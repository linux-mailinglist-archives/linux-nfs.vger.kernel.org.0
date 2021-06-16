Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D563AA450
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 21:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhFPT3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 15:29:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47952 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232357AbhFPT3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 15:29:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GJKin0027845;
        Wed, 16 Jun 2021 19:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/0Q2LfqhDUcBgeoi6/npB1WCLCTn1bEmcuhE7BsGWog=;
 b=qxwZDKrp9WEgqzjZId4534u4JXMJl6NC82tKk93yhMowxL4VXir5A9wH/2OHqSnllOKv
 3omZBwGVozEN3KllH9OxVv+wg8MUC9FVDMTkKDPoeLaJ1mCVnxiHvt02NoAG0cD2Ds0A
 1+ftvQKZe0LHTkLHZ4ZgbctsQTxHRs60fT0wdfgt7jtD6Bo6ggzdUsLRFc/O1kMjQBaI
 UmMpJvFsQsosDmyds7xFDWOo8N9mNlEv2kufgTZcorz/LVglt7om+jRBveYY6ZgdxrqT
 rCAjZU2EH5KYNJdIKfCP70rmUK+kA5CI0Eqsea3FGTNfTsf+47CIZIkOdNRE1WYy2adK 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptgaxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:27:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GJLM1u025166;
        Wed, 16 Jun 2021 19:27:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 396watwut6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZeVtnKbM+nG0havoakpCaLbud88OvbNAd5dTfJa0IuZmQ4AKr2ncgfh5s6yHZRCpNHMjBL2LJgAxBV1gR30lcdkeOyopx3ztwjZWJc2twEWR951ad/DIuGje3Ci0Qkz6BiJcNP8LfpGbyVETfPI7z6JG0mG7PPLaZhwo8XmVto0HIrARK4XUUWndar9fU855nDz+jEoevNsSZwMhMkxK5cAIYAK/ac0EXdoatyloZjTabbg3RgYYp33cwp3y8gLvQxTmjyUkH47PbNJa6TUzsDFMgjL83tqXqRcJog9gkZE96nQOFgvZw0QmhVZ+7gxnKdeBRbDa/gc8DZsYwD+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Q2LfqhDUcBgeoi6/npB1WCLCTn1bEmcuhE7BsGWog=;
 b=Uc28+lp6BtPSLyXqWnIDHuLlQjSH8NiE4KZbazEjVq5maeLzA3a0r9/OQocBSu0oQ5OvdtT9cnc/8WAfaMMHvtrc/terLS4J8rjoUmiJo8FG3r1MkZAuqcAiea9W79o68+zByJHcs3XZvCRM26xFiHjGVGn0PQrPaKajoyJpxkO8OldUrbHqvaXPX3kRkDPlqwbHbrinVR71nq0o3jz3FrKSwIWOjx5EciOLyy3SpztjZ9HRn1/rHCX3Rw0eJG7U1AQLkK5wFoxv5y+CGLRYKJ0y+cYlnsF/HidG8z6psfo3olDRQZxyyN+lZ8k+V86QZxDP1d97hZW2eSwbCov0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Q2LfqhDUcBgeoi6/npB1WCLCTn1bEmcuhE7BsGWog=;
 b=TUJM8y0nRFEZM8Sh0Ee4lKe7/jLY3ThcrscJ8TE13dvVq6q4JmfX08MrUUbGSFwMZA/DCXHpWsJOeW5AQlMdOBPhxaB4HYgYQz3lo9UPkUGbsc57d7QIyqfxrPmVWAKqpjOuPCvWhP5luyM07Qf+3eALcO9VdmKGw90addEEIWk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4052.namprd10.prod.outlook.com (2603:10b6:a03:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 19:27:42 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 19:27:42 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     Calum Mackay <calum.mackay@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210616160239.GC4943@fieldses.org>
 <63c6d3e0-87d5-f617-cd82-b91df0d2c4fe@oracle.com>
 <93b4ea72-786f-dc7f-d000-e40426ffff02@oracle.com>
From:   dai.ngo@oracle.com
Message-ID: <5db5327e-67ce-557d-e734-4cd81d1ad8e8@oracle.com>
Date:   Wed, 16 Jun 2021 12:27:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <93b4ea72-786f-dc7f-d000-e40426ffff02@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-134-236.vpn.oracle.com (72.219.112.78) by SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 16 Jun 2021 19:27:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc7f1909-e505-44ab-a4cb-08d930fccfc2
X-MS-TrafficTypeDiagnostic: BY5PR10MB4052:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4052E641E62B847B3F95D3C1870F9@BY5PR10MB4052.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uv83STZ1To4l3olIX33H2fPXbLtXbP39eaUD4u/ugdgHAAtKcszYUDbWedsMyzrGmnFy4R+oDu7GNjWaz8ParSHN+XpvLttPQmGCvlAgi75R2S/EeuY40NALrl7xcVzKBuoChyFyansq/ik/1moAk+17xJO+39k8TmJLMjvw0YJmchlUTLM1Bf6oouJyljvN/u83DnQPbw/QrA2v0KZAJuBvxRyZvef/0alQdMwpgYjHri/tXJZ8P6D6u8qkGPSy9p/pwi/wt+Ij5FYeLg6lO3ECSXm3KVqPvHs63m+/v/eikpROERzPw4doXeTqNNewl6NWAnTPnsarJIVbIsxEUGWMvwcZ4ZS1XrcHXfjJka4SH0sGa7+29PydlCct7EOwahj66LgPs4CzHtGn5lgD3Rt5HULcILD2C1Qx6D5G/fEgRLwoFxNpWyhKFfrxJRJqSyLDmCYlv/829mYZXX6/P1e/bef8e2+4lfYTp7DF8cfCP2JYGxyCnviWUzW7OWcjccjm+cKgqodpc7xUGiG9B6QF0wbbFTmBICozl/7stI5JwY72EFBNN/CzN3cwThjlBdaxq8dXxSejiG0mIaZoPLTQv8ms6f4Iz3+de6yfZojv+9lAtZvuVne79BSXSRcof2sN4Go4uHlz9QZLrzmCljQ5LE959kkwnY3fBsH2krw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(956004)(36756003)(38100700002)(66556008)(316002)(66476007)(110136005)(7696005)(5660300002)(30864003)(83380400001)(31696002)(84040400003)(2616005)(2906002)(66946007)(4326008)(8936002)(31686004)(6486002)(86362001)(26005)(8676002)(53546011)(16526019)(186003)(478600001)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEl3bzQ5SnBqcTJwTjFZL1NVWmNGck12U2g0bXlTSHdjdjFpdng2amRYUFpI?=
 =?utf-8?B?bjd5OXE1am9NZStvc2FiTnV1OXU4emxkR1I2UFNSVXpMTEo4UE52bEtXcU5C?=
 =?utf-8?B?Lys1VktvdlArdzFVdGhjalpGbk5MY1VTb25lTnZISEVjV0g0Z0xURkNVakJT?=
 =?utf-8?B?V1VaQ2M4TUZWWXVhNzd4d1Q4bzVWNnNEMDg3WmRqU2lMWU9SUnZ5QnFGVnhI?=
 =?utf-8?B?TXAyZFlXVzE1WGw1WXprYU1icmpMZ2tPblBWRkZvUEZCWTIxWlRCWGM3NDF4?=
 =?utf-8?B?dnJlOFRTZitJNEwzTHgrd0E0YittNHgxTGk5dldTL1RBekxKSFNDOUlVT2pv?=
 =?utf-8?B?UithMVF5TzlpQnVvOUc2TklSNUoxN1l3NjlpSUs4RUcyeC9jU21zTDJ4MTUw?=
 =?utf-8?B?bnQyanVCdWNPd0szQjYyZ0wwM3oyME45a055cUNZTCtwdUZQcVlMUGJsQVpj?=
 =?utf-8?B?Z0VGeHY1WWZ3WnVsdHZuWG1ZOVpWdVJoTElhWDRjQWlNSWcyZlJEMWhtazc4?=
 =?utf-8?B?cDAzR0VVekUxdWhjWHplRkVkOWhDbURtN1ExRC9LRGRiQkFIdloyMWwzWm5W?=
 =?utf-8?B?UFVQVzVYeExNc0pzWS9lQndrWVdEQTV0WVJmRlV4ZXBubTU2dzhrYTJ0SUI4?=
 =?utf-8?B?eHE2NlFNN1IydzlRRmdvOHpEQmc4R3B3T2lYOGdSanErSFJlczNhNlR6N0tE?=
 =?utf-8?B?MU1SdCttSmhNN0dOQXVhSnBnTzFsZ3hFUTNwQ0hJektTcGR4SnI5ZDdMWko5?=
 =?utf-8?B?R2tDK3VISlp4VVg0UDd6RlJIUDFnUUltb05iWGxVbE5SSjNZYUt3dXlFTTI5?=
 =?utf-8?B?MUU2ME5GaE56bjNmNEF3VHl4V1Rrek9VZGNaM2pSWHV4TDJNanhVMUFKM0NX?=
 =?utf-8?B?Z2N4K2lMQUVIa0ZJOUdVUS9peVpxQnFKZUtCV054eG1hVE4yN09rNmlmRWky?=
 =?utf-8?B?V1dJUjBqUkxyandodDgvbVgyZmE3YS82eUF4RWtYRnRDRnc5cWVNcW9QaTNK?=
 =?utf-8?B?U0FEWW9WdXFHNDF2bjVLRWNqR1ZLTHEyeC9rM2IxRWlZNDNhYUZrVHVQcjNU?=
 =?utf-8?B?K0Z0dkx0OWY4QjlEQ0FJbWp4VjRlWE1sNVhnZzJRWTV6dCsyQ2ZrSHhsUDdm?=
 =?utf-8?B?ZG5waFBOT0hWd1J3ZmNOb0MxdFBMVDJkZEoyK3djUGZtK1NJZVFJWHAvU3hH?=
 =?utf-8?B?TFNNZzZTMzhqdE04VE1BMk5lRHFONWg1WjR1SUpTc203U2J3dmlGUFdjTkVH?=
 =?utf-8?B?M3I4Tjk2S3U5V09FeGZaYmJoVTRheG9qTnB5aFRBVE5va25BV3dQZzhXcTVm?=
 =?utf-8?B?elIxNlcra2JYS05UL0tFZStVckpGWnJpOWk2NDBOdUNyNVhGWHJuSVNTOFJP?=
 =?utf-8?B?Z09hKzEvR3QvVDJRamlPMWk4LzhsVi9NUXUxOGpjd2Z0dzdJcTZkRWJhOTMz?=
 =?utf-8?B?dnRBZHhNUTVQSXJIdk5xSzExa2JSSTFvYVlqN2RiUHEwTk1XK0dCOTViRHVY?=
 =?utf-8?B?bFVIVnRlZDc4TFdFemdpeEtBa1lGYWptNjQ3QzJJdy9DTUI3ZTR1OEplZUt5?=
 =?utf-8?B?b1dPQVhxZmxJNDM3Z0tBVW5HNlV5UnVHM3hFck00dEpsZ1lnN3p1ZFNXR0ZR?=
 =?utf-8?B?NG9hRjFEdDBvT0xPdjVrbFltMktqa0Z4Zk5JUGtUaE05L1MyUnRDeGM2T2tY?=
 =?utf-8?B?Yk81QWlzMGhvQW9uQzFrUmFPY2JENVFJcDVpVkpRUWpLQ1lDZUs3MSs4MnVU?=
 =?utf-8?Q?/pFRWT66rHVvLZ1T/LfrVOv/DquwnkpWQ2oqPQt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7f1909-e505-44ab-a4cb-08d930fccfc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:27:42.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6Rtlted6CKj3D09Mxf5aqFI/V3IAX8rmTcSwZm/4zpGuDpV19sPOpBjXLQBTcPa7e4EQX5rBgTU9+matvszzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4052
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160109
X-Proofpoint-GUID: _Uxm9plv0vku3OpQQw4HlowQMEVEDPAQ
X-Proofpoint-ORIG-GUID: _Uxm9plv0vku3OpQQw4HlowQMEVEDPAQ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/16/21 12:19 PM, Calum Mackay wrote:
> On 16/06/2021 8:17 pm, dai.ngo@oracle.com wrote:
>>
>> On 6/16/21 9:02 AM, J. Bruce Fields wrote:
>>> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>>>> Currently an NFSv4 client must maintain its lease by using the at 
>>>> least
>>>> one of the state tokens or if nothing else, by issuing a RENEW 
>>>> (4.0), or
>>>> a singleton SEQUENCE (4.1) at least once during each lease period. 
>>>> If the
>>>> client fails to renew the lease, for any reason, the Linux server 
>>>> expunges
>>>> the state tokens immediately upon detection of the "failure to 
>>>> renew the
>>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client 
>>>> should
>>>> reconnect and attempt to use the (now) expired state.
>>>>
>>>> The default lease period for the Linux server is 90 seconds.  The 
>>>> typical
>>>> client cuts that in half and will issue a lease renewing operation 
>>>> every
>>>> 45 seconds. The 90 second lease period is very short considering the
>>>> potential for moderately long term network partitions.  A network 
>>>> partition
>>>> refers to any loss of network connectivity between the NFS client 
>>>> and the
>>>> NFS server, regardless of its root cause.  This includes NIC 
>>>> failures, NIC
>>>> driver bugs, network misconfigurations & administrative errors, 
>>>> routers &
>>>> switches crashing and/or having software updates applied, even down to
>>>> cables being physically pulled.  In most cases, these network 
>>>> failures are
>>>> transient, although the duration is unknown.
>>>>
>>>> A server which does not immediately expunge the state on lease 
>>>> expiration
>>>> is known as a Courteous Server.  A Courteous Server continues to 
>>>> recognize
>>>> previously generated state tokens as valid until conflict arises 
>>>> between
>>>> the expired state and the requests from another client, or the 
>>>> server reboots.
>>>>
>>>> The initial implementation of the Courteous Server will do the 
>>>> following:
>>>>
>>>> . when the laundromat thread detects an expired client and if that 
>>>> client
>>>> still has established states on the Linux server then marks the 
>>>> client as a
>>>> COURTESY_CLIENT and skips destroying the client and all its states,
>>>> otherwise destroy the client as usual.
>>>>
>>>> . detects conflict of OPEN request with a COURTESY_CLIENT, destroys 
>>>> the
>>>> expired client and all its states, skips the delegation recall then 
>>>> allows
>>>> the conflicting request to succeed.
>>>>
>>>> . detects conflict of LOCK/LOCKT request with a COURTESY_CLIENT, 
>>>> destroys
>>>> the expired client and all its states then allows the conflicting 
>>>> request
>>>> to succeed.
>>>>
>>>> To be done:
>>>>
>>>> . fix a problem with 4.1 where the Linux server keeps returning
>>>> SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after 
>>>> the expired
>>>> client re-connects, causing the client to keep sending BCTS 
>>>> requests to server.
>>> Hm, any progress working out what's causing that?
>>
>> I will fix this in v2 patch.
>>
>>>
>>>> . handle OPEN conflict with share reservations.
>>> Sounds doable.
>>
>> Yes. But I don't know a way to force the Linux client to specify the
>> deny mode on OPEN.
>
> We could do this with pynfs, perhaps, for testing?

Ah you're right. I think we can, might need your help with this.

Thanks,
-Dai

>
> cheers,
> c.
>
>
>
>  I may have to test this with SMB client: expired
>> NFS client should not prevent SMB client from open the file with
>> deny mode.
>>
>>>
>>>> . instead of destroy the client anf all its state on conflict, only 
>>>> destroy
>>>> the state that is conflicted with the current request.
>>> The other todos I think have to be done before we merge, but this one I
>>> think can wait.
>>>
>>>> . destroy the COURTESY_CLIENT either after a fixed period of time 
>>>> to release
>>>> resources or as reacting to memory pressure.
>>> I think we need something here, but it can be pretty simple.
>>
>> ok.
>>
>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c        | 94 
>>>> +++++++++++++++++++++++++++++++++++++++++++---
>>>>   fs/nfsd/state.h            |  1 +
>>>>   include/linux/sunrpc/svc.h |  1 +
>>>>   3 files changed, 91 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index b517a8794400..969995872752 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -171,6 +171,7 @@ renew_client_locked(struct nfs4_client *clp)
>>>>       list_move_tail(&clp->cl_lru, &nn->client_lru);
>>>>       clp->cl_time = ktime_get_boottime_seconds();
>>>> +    clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>>>   }
>>>>   static void put_client_renew_locked(struct nfs4_client *clp)
>>>> @@ -4610,6 +4611,38 @@ static void nfsd_break_one_deleg(struct 
>>>> nfs4_delegation *dp)
>>>>       nfsd4_run_cb(&dp->dl_recall);
>>>>   }
>>>> +/*
>>>> + * Set rq_conflict_client if the conflict client have expired
>>>> + * and return true, otherwise return false.
>>>> + */
>>>> +static bool
>>>> +nfsd_set_conflict_client(struct nfs4_delegation *dp)
>>>> +{
>>>> +    struct svc_rqst *rqst;
>>>> +    struct nfs4_client *clp;
>>>> +    struct nfsd_net *nn;
>>>> +    bool ret;
>>>> +
>>>> +    if (!i_am_nfsd())
>>>> +        return false;
>>>> +    rqst = kthread_data(current);
>>>> +    if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>>>> +        return false;
>>> This says we do nothing if the lock request is not coming from nfsd and
>>> v4.  That doesn't sound right.
>>>
>>> For example, if the conflicting lock is coming from a local process 
>>> (not
>>> from an NFS client at all), we still need to revoke the courtesy state
>>> so that process can make progress.
>>
>> The reason it checks for NFS request is because it uses 
>> rq_conflict_client
>> to pass the expired client back to the upper layer which then does the
>> expire_client. If this is not from a NFS request then kthread_data() 
>> might
>> not be the svc_rqst. In that case the code will try to recall the 
>> delegation
>> from the expired client and the recall will eventually timed out.
>>
>> I will rework this code.
>>
>> Thanks,
>> -Dai
>>
>>>> +    rqst->rq_conflict_client = NULL;
>>>> +    clp = dp->dl_recall.cb_clp;
>>>> +    nn = net_generic(clp->net, nfsd_net_id);
>>>> +    spin_lock(&nn->client_lock);
>>>> +
>>>> +    if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) &&
>>>> +                !mark_client_expired_locked(clp)) {
>>>> +        rqst->rq_conflict_client = clp;
>>>> +        ret = true;
>>>> +    } else
>>>> +        ret = false;
>>>> +    spin_unlock(&nn->client_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   /* Called from break_lease() with i_lock held. */
>>>>   static bool
>>>>   nfsd_break_deleg_cb(struct file_lock *fl)
>>>> @@ -4618,6 +4651,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>>>       struct nfs4_delegation *dp = (struct nfs4_delegation 
>>>> *)fl->fl_owner;
>>>>       struct nfs4_file *fp = dp->dl_stid.sc_file;
>>>> +    if (nfsd_set_conflict_client(dp))
>>>> +        return false;
>>>> trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
>>>>       /*
>>>> @@ -5237,6 +5272,22 @@ static void 
>>>> nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>>>>        */
>>>>   }
>>>> +static bool
>>>> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
>>>> +{
>>>> +    struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>>> +
>>>> +    spin_lock(&nn->client_lock);
>>>> +    if (!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ||
>>>> +            mark_client_expired_locked(clp)) {
>>>> +        spin_unlock(&nn->client_lock);
>>>> +        return false;
>>>> +    }
>>>> +    spin_unlock(&nn->client_lock);
>>>> +    expire_client(clp);
>>>> +    return true;
>>>> +}
>>>> +
>>>>   __be32
>>>>   nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh 
>>>> *current_fh, struct nfsd4_open *open)
>>>>   {
>>>> @@ -5286,7 +5337,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, 
>>>> struct svc_fh *current_fh, struct nf
>>>>               goto out;
>>>>           }
>>>>       } else {
>>>> +        rqstp->rq_conflict_client = NULL;
>>>>           status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, 
>>>> open);
>>>> +        if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
>>>> +            if 
>>>> (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
>>>> +                status = nfs4_get_vfs_file(rqstp, fp, current_fh, 
>>>> stp, open);
>>>> +        }
>>>> +
>>>>           if (status) {
>>>>               stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>>>               release_open_stateid(stp);
>>>> @@ -5472,6 +5529,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>       };
>>>>       struct nfs4_cpntf_state *cps;
>>>>       copy_stateid_t *cps_t;
>>>> +    struct nfs4_stid *stid;
>>>> +    int id = 0;
>>>>       int i;
>>>>       if (clients_still_reclaiming(nn)) {
>>>> @@ -5495,6 +5554,15 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>           clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>>           if (!state_expired(&lt, clp->cl_time))
>>>>               break;
>>>> +
>>>> +        spin_lock(&clp->cl_lock);
>>>> +        stid = idr_get_next(&clp->cl_stateids, &id);
>>>> +        spin_unlock(&clp->cl_lock);
>>>> +        if (stid) {
>>>> +            /* client still has states */
>>>> +            set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>>> +            continue;
>>>> +        }
>>>>           if (mark_client_expired_locked(clp)) {
>>>> trace_nfsd_clid_expired(&clp->cl_clientid);
>>>>               continue;
>>>> @@ -6440,7 +6508,7 @@ static const struct lock_manager_operations 
>>>> nfsd_posix_mng_ops  = {
>>>>       .lm_put_owner = nfsd4_fl_put_owner,
>>>>   };
>>>> -static inline void
>>>> +static inline int
>>>>   nfs4_set_lock_denied(struct file_lock *fl, struct 
>>>> nfsd4_lock_denied *deny)
>>>>   {
>>>>       struct nfs4_lockowner *lo;
>>>> @@ -6453,6 +6521,8 @@ nfs4_set_lock_denied(struct file_lock *fl, 
>>>> struct nfsd4_lock_denied *deny)
>>>>               /* We just don't care that much */
>>>>               goto nevermind;
>>>>           deny->ld_clientid = lo->lo_owner.so_client->cl_clientid;
>>>> +        if (nfs4_destroy_courtesy_client(lo->lo_owner.so_client))
>>>> +            return -EAGAIN;
>>>>       } else {
>>>>   nevermind:
>>>>           deny->ld_owner.len = 0;
>>>> @@ -6467,6 +6537,7 @@ nfs4_set_lock_denied(struct file_lock *fl, 
>>>> struct nfsd4_lock_denied *deny)
>>>>       deny->ld_type = NFS4_READ_LT;
>>>>       if (fl->fl_type != F_RDLCK)
>>>>           deny->ld_type = NFS4_WRITE_LT;
>>>> +    return 0;
>>>>   }
>>>>   static struct nfs4_lockowner *
>>>> @@ -6734,6 +6805,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct 
>>>> nfsd4_compound_state *cstate,
>>>>       unsigned int fl_flags = FL_POSIX;
>>>>       struct net *net = SVC_NET(rqstp);
>>>>       struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>> +    bool retried = false;
>>>>       dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
>>>>           (long long) lock->lk_offset,
>>>> @@ -6860,7 +6932,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct 
>>>> nfsd4_compound_state *cstate,
>>>>           list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>>>>           spin_unlock(&nn->blocked_locks_lock);
>>>>       }
>>>> -
>>>> +again:
>>>>       err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
>>>>       switch (err) {
>>>>       case 0: /* success! */
>>>> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct 
>>>> nfsd4_compound_state *cstate,
>>>>       case -EAGAIN:        /* conflock holds conflicting lock */
>>>>           status = nfserr_denied;
>>>>           dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
>>>> -        nfs4_set_lock_denied(conflock, &lock->lk_denied);
>>>> +
>>>> +        /* try again if conflict with courtesy client  */
>>>> +        if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == 
>>>> -EAGAIN && !retried) {
>>>> +            retried = true;
>>>> +            goto again;
>>>> +        }
>>>>           break;
>>>>       case -EDEADLK:
>>>>           status = nfserr_deadlock;
>>>> @@ -6962,6 +7039,8 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct 
>>>> nfsd4_compound_state *cstate,
>>>>       struct nfs4_lockowner *lo = NULL;
>>>>       __be32 status;
>>>>       struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>> +    bool retried = false;
>>>> +    int ret;
>>>>       if (locks_in_grace(SVC_NET(rqstp)))
>>>>           return nfserr_grace;
>>>> @@ -7010,14 +7089,19 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct 
>>>> nfsd4_compound_state *cstate,
>>>>       file_lock->fl_end = last_byte_offset(lockt->lt_offset, 
>>>> lockt->lt_length);
>>>>       nfs4_transform_lock_offset(file_lock);
>>>> -
>>>> +again:
>>>>       status = nfsd_test_lock(rqstp, &cstate->current_fh, file_lock);
>>>>       if (status)
>>>>           goto out;
>>>>       if (file_lock->fl_type != F_UNLCK) {
>>>>           status = nfserr_denied;
>>>> -        nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
>>>> +        ret = nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
>>>> +        if (ret == -EAGAIN && !retried) {
>>>> +            retried = true;
>>>> +            fh_clear_wcc(&cstate->current_fh);
>>>> +            goto again;
>>>> +        }
>>>>       }
>>>>   out:
>>>>       if (lo)
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index e73bdbb1634a..bdc3605e3722 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -345,6 +345,7 @@ struct nfs4_client {
>>>>   #define NFSD4_CLIENT_UPCALL_LOCK    (5)    /* upcall 
>>>> serialization */
>>>>   #define NFSD4_CLIENT_CB_FLAG_MASK    (1 << NFSD4_CLIENT_CB_UPDATE 
>>>> | \
>>>>                        1 << NFSD4_CLIENT_CB_KILL)
>>>> +#define NFSD4_CLIENT_COURTESY        (6)    /* be nice to expired 
>>>> client */
>>>>       unsigned long        cl_flags;
>>>>       const struct cred    *cl_cb_cred;
>>>>       struct rpc_clnt        *cl_cb_client;
>>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>>> index e91d51ea028b..2f0382f9d0ff 100644
>>>> --- a/include/linux/sunrpc/svc.h
>>>> +++ b/include/linux/sunrpc/svc.h
>>>> @@ -304,6 +304,7 @@ struct svc_rqst {
>>>>                            * net namespace
>>>>                            */
>>>>       void **            rq_lease_breaker; /* The v4 client 
>>>> breaking a lease */
>>>> +    void            *rq_conflict_client;
>>>>   };
>>>>   #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : 
>>>> rqst->rq_bc_net)
>>>> -- 
>>>> 2.9.5
>
