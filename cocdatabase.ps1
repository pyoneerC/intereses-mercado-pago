$apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImY4M2Y0NTRlLTgxZmEtNDY2MC05NWNiLWVlMDk3ZjFkMmFkMiIsImlhdCI6MTcwNDUwMjM4Miwic3ViIjoiZGV2ZWxvcGVyLzJjODFlNDBjLWNkOTAtZmViOS0wNGJjLTc3YTA5YzZjYTI5YiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjE5MC4xNS4yMjAuMjM5Il0sInR5cGUiOiJjbGllbnQifV19.osezpWipMH-PXqaY-m2MA6dVU9TFUpuZ-Jz9wsCNQTqxGyS4gixHeMS5tmhWuCioR0Y_LXb5ms9vB1GZiDrEVQ'

function getGoldPassCurrentSeason {
    param (
        [Parameter(Mandatory=$true)]
        [string] $apiKey
    )

    $headers = @{
        'Authorization' = "Bearer $apiKey"
    }

    $request = "https://api.clashofclans.com/v1/goldpass/seasons/current"
    $response = Invoke-RestMethod -Uri $request -Headers $headers

    return $response
}

function GetClanInfo {
    param (
        [Parameter(Mandatory=$true)] # example: '#GUJR9C88'
        [string] $clanTag
    )

    class ClanInfo {
        static [string] $apiKey = $script:apiKey
        static [hashtable] $headers = @{
            'Authorization' = "Bearer $($([ClanInfo]::apiKey))"
        }

        static [string] $clanTag

        static [pscustomobject] GetResponse() {
            $clanTagEncoded = $([ClanInfo]::clanTag) -replace "#", "%23"
            $request = "https://api.clashofclans.com/v1/clans/$($clanTagEncoded)"
            $response = Invoke-RestMethod -Uri $request -Headers $([ClanInfo]::headers)
            return $response
        }

        static [string] GetClanTag() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Tag: $($response.tag)"
            return $response.tag
        }

        static [string] GetClanName() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Name: $($response.name)"
            return $response.name
        }

        static [string] GetClanType() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Type: $($response.type)"
            return $response.type
        }

        static [string] GetClanDescription() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Description: $($response.description)"
            return $response.description
        }

        static [bool] IsFamilyFriendly() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Is Family Friendly? $($response.IsFamilyFriendly)"
            return $response.IsFamilyFriendly
        }

        static [string] GetClanLevel() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Level: $($response.clanLevel)"
            return $response.clanLevel
        }

        static [string] GetClanPoints() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Points: $($response.clanPoints)"
            return $response.clanPoints
        }

        static [string] GetClanBuilderBasePoints() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Builder Base Points: $($response.clanBuilderBasePoints)"
            return $response.clanBuilderBasePoints
        }

        static [string] GetClanCapitalPoints() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Capital Points: $($response.clanCapitalPoints)"
            return $response.clanCapitalPoints
        }

        static [string] GetClanLocationID() {
            $response = [ClanInfo]::GetResponse()
            Write-Host "Clan Location: $($response.location.id)"
            return $response.location
        }
    }
}

# i want to get the clan capital points from #2JQLPCY9J
[ClanInfo]::clanTag = '#2JQLPCY9J'
[ClanInfo]::GetClanCapitalPoints()