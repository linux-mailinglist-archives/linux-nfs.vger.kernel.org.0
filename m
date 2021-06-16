Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C53AA420
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhFPTTm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 15:19:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhFPTTl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 15:19:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GJ1hJM030550;
        Wed, 16 Jun 2021 19:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/sw7sZ1r399TVUEQfblRJ4H3M2g4bB8g4uv7s1ar8xI=;
 b=kZwsOH98XynalRaP6k9yflfRNn/XshtTm8e/uO7a20/Gg/cmoPkOBIDzgSrxwC+5C/ge
 A2ZdfQCpU5iz7NfCzus/0WvZdDBjNZd84rTiQ/8oCGGkHNpfkR9jMYyXzu9dWVNQ8Csd
 DeDzRUskul6AcBOSYfGsc2bCXYghLl5yZkPqthFrvdgEZR/T8J47mXPnuz5YxiTuQer2
 WMJaZWiht4O79Kys0X5Xp953KgO+frKBw8u12xnVrKBm1b+MLqpRP/8fsz9RDC61n9Hz
 oxH2Hu8n7VODXfs3qe7VWSHuqHekWRMQ3aD1AkHvHPzwlviJm3WKXP3ER41g/SKTUp9A SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnqrmr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:17:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GJ1LSD084134;
        Wed, 16 Jun 2021 19:17:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 396waurs4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcTvTSkFY5f/Tl/N3hfNKncpNyVq5UPPMocFfmDgqrXSiE1CvQcHNzlDWCOyZ5lMhx3yvlXCEAaZXONnNMFhXUNfElfe9K4N4MTgOWrULiEQnrWSHTdhmRJ/ogonGYXrqHgt/AsTpQ1dHiC33a+wTnqi2l3IxARFcC9H48LKNX9B4N6mOScw8tBPPxsdh+0wkBd4GHycVBx/rWWcVe7/QMZsOpwb444sCRkNDaQJwNr0FHIXFiC45+bfpPxEst2GJC/IN8oh4xbAb9thJK5f+MtH3IY8scWxv5C/CGbLS5/5MWCXR3TPbnmVa2hH01IH+tFuGGHKAipqisZclux88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sw7sZ1r399TVUEQfblRJ4H3M2g4bB8g4uv7s1ar8xI=;
 b=CCtpb0qpW7NxjJKlX9hgrDyP9WfMxJHT4TGoJ8cejDw8y1hpOEHeo+dCth8RuTH2WueStnUg6bwk1OFJDSFOjZuwHCg46SjO6G/AU6Tb3JbdiBS7GZUh9ioEUcoI6FKe29pY3bavn0atjeN5aU9CYYOFIESoqzMvtqNSVfvYTYLNzsNBDNBoEQ5S756DGQ4KNoGhH3O2sQ6Hh4uk7R9qW3/xTdWrKLU38g3kfCCUbtsaWYG7nqkiIWoe2/TjlyYcrKS2uxDzkSjnCG5u0yo9t/Adpzj5+1kvTXu5nLSFIePwuvclMcjN17kNSz+S/E0aV9qShYPbNd0EkPGDqCksaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sw7sZ1r399TVUEQfblRJ4H3M2g4bB8g4uv7s1ar8xI=;
 b=c6yCc8Vsd8o7FZeecWpcBt+srneCuErwipg3PQpvP/Bgd0v3XWmmeETx7ZZy9CCVPBwR63aZ6S8VPRVlrhUkc2hz8OWVvE9dozlX1BpV+eB0SnlxgMwtvJggAck9Koy9X0PvrDNEeKphcobsxJbsEdQNLGgQ70cNjIBwSMv7TOE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4051.namprd10.prod.outlook.com (2603:10b6:a03:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Wed, 16 Jun
 2021 19:17:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 19:17:30 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210616160239.GC4943@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <63c6d3e0-87d5-f617-cd82-b91df0d2c4fe@oracle.com>
Date:   Wed, 16 Jun 2021 12:17:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210616160239.GC4943@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-134-236.vpn.oracle.com (72.219.112.78) by SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 16 Jun 2021 19:17:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9229910-c4cc-4483-da19-08d930fb6291
X-MS-TrafficTypeDiagnostic: BY5PR10MB4051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4051DC287E6D3B4CCF79BC65870F9@BY5PR10MB4051.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRONav8JtOHB4xfzJHUplxt0fO0oC+gHsKGwRKXWquLfTd6w9FxUrygAiC+0dONoK2u27svAK1WWXiZ5H4JsH6ShAVBijA3xsGXkgWVOFSyL1WzUQQvDKO5wgxMOLrwP35YwX37MWGjLhvtOzg+LQoVUOl7mWQxQxZRwgPTKh2hXUKi8UHfaOrbPdYo+M7g4DGfMIXcVehyWeBMRXjEuP3r9hvLSr/KHVgEDUlcMlVWtRN61Z8Ps9ct/cVZPv8DjvEHMlA792CEh8lklwaPhP7+hMAcPjUHbQD9EnNr04JsBAmF7qREQKmVI/y5bf6vW1Ues0CCwAGBayWTlUPqcNGTNvrl/eHjnyQH0+UcFmp7Jn7uVNrMo5/Y+J+oIu/byeQcWqA5SpuR4OdGM0Mp6Oq1IH/D1kMaiNXb8w9pr4VJLX3FrbtvGqgwaurtB6gLjENQp9/ZH3gR7wQlERnYkV2u6C1dyjYVOqPB6Gc0oIq77+AgBRxF65gP+/oHyOne2qUs53qJ3+n0SBuA9rkgV5+zgGov2vS6JJc/5xP2MPlNWb4tcaiRH1lHkP4BhN5Ygx0mxyjg32XlkzXC4IW4smivpwZCPnf4swTgM8ctZBsl3v691Shi9f5A3LtwrMKxeZn3Z5jTEOOMVl7n/6zApCKXrIPEYTqHG02ORXYH8hQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(6916009)(316002)(4326008)(66946007)(7696005)(66476007)(5660300002)(186003)(26005)(16526019)(478600001)(38100700002)(6486002)(53546011)(8676002)(30864003)(9686003)(83380400001)(956004)(66556008)(2906002)(2616005)(31696002)(8936002)(86362001)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUcyYXhjbnBxcVVKanA5ZFNIbk1teGhlVDlXUzE1UG9xQmZRbmpwTjU4eEg5?=
 =?utf-8?B?OVl1MlQ0c1ZROGFsR3FaVkVKMmtJL2Zia0JrNHVjdEFEK1I5amN5bDhvSzZq?=
 =?utf-8?B?RGhRbzBKbklGbHY3SEdpc3VPbGdPUjFqeXVVcThMTENnWXo3T0t0TnVLaUNF?=
 =?utf-8?B?ZWJLVUV2Zit2ajJ1WUhkb0Z6SXMxZm41ZmdWZ0VwS0s0WWNmL2ZHMGlwOWJR?=
 =?utf-8?B?LzVBbzFaQXZZd0M5RDBxYTkxRlRCb2hNZXhoT2Jzc29iT1MzRk44aTdhc29O?=
 =?utf-8?B?YlViWkQwTGFrcStpR1lvZEtsdjJUYzFWYWlldXQzZVpjU1ppZy80Ym9zTHlF?=
 =?utf-8?B?SHNWLzlVeFNNNXFmbUtEN09Ba3JydWx5ek8xQ1B1V0V2ejFNMDFCeURWbjdw?=
 =?utf-8?B?Qlh5a2g1VkJ5QnkwYWNOKzFsckoybWZRSEZ0YXZkcnNlZ0V0M01DZDZMdWRJ?=
 =?utf-8?B?K1BMWUZYaXcycXJGUmN5cmhNcStpOThJY0JISjdOYk1wNjJJSmp5UmEzdEZv?=
 =?utf-8?B?Q1B2YURoRnUxSnVPbWRCKzk1RFgwVlNZZGYvcXJyRytFRWxUcnp1QWkyV2k4?=
 =?utf-8?B?Y2xzWHAvOE4yNXkxRU40RW9McitXaVd4VU8rVFZFUUZSREwzNTBtYzZYQklS?=
 =?utf-8?B?bDlBb3FmRTI1aGQwQmZ4RGc5RFFVMG1LUFlNU1NBcnNTY3R1OFZDd09WZnRy?=
 =?utf-8?B?MVdTaGMzSnBKSVZ1Qk43ZzhaTE9pdEw4dnU2STZScWQ2Q0V6a2VFaEthR01Q?=
 =?utf-8?B?UTlJSjRYTVlIODAwbHJxQmFOUFBib0Z1QjZBRWtmci84dWtmSG5TREVLVGhh?=
 =?utf-8?B?Wk9ROHRFMVNOd1JRZXZpNDcrL2p6S1piZ01ISUlQZVp2SVkrTlZQQ0NWRzc3?=
 =?utf-8?B?NVoyY0h6eXVUbExNREthNU1qS2FQamgxUy9LT1puMXYzYU02S0t6T3RWWlhR?=
 =?utf-8?B?cmVtVFRqc2hOczNBYi9xK3BYc3ZKS1hSbXZXMGFuUW8vMGtSOGNpT09NQW0y?=
 =?utf-8?B?YUxualhaVFhuaVBFdS83bWdZNzFoZ1VYOERtdTFzcUdIQjF1Mkpqbys3eW9z?=
 =?utf-8?B?R0NOd0hUME1uc3BXZVJNSTJINWNOYnhlK0tBMTQ3Ni9JNnJjSk9WckxZSmlQ?=
 =?utf-8?B?Qm5pakxyVU4wKzhCWVYrTTJmWm1aVzQ3Qk50RGFaYmRRQWRLbXpKZ1U2Y1NG?=
 =?utf-8?B?dVZTSHdqUmlkbXAzbmcwNlpHYzhnN1lkeGJCY0RlMWVmMTZYbzVrelN1dW96?=
 =?utf-8?B?OHRSeXlzZkZlZGZ4a3JNRmZtZnJqdVpMdEdkQ1I0anJvbU1VNmZIbE8xQjc1?=
 =?utf-8?B?U2IyblEwWUVsay80VVUwdU52eW5ScXFFN1hNRHR1UkhyaHNJblRYUVRSbm9N?=
 =?utf-8?B?by94YUJlbkxCSHZlaEFxMlhtTGhMVklkQnFjb0Z1Vi9DcS9TcVQ4VUVRSVB6?=
 =?utf-8?B?VUNydU9EaVV3Q2tQVytNc3JsbjM3ZFFFVXBHbjlkcWErY2xWZGxnMTJEeHZO?=
 =?utf-8?B?eWRhMkgvSnRaM2xiRTgyVzRHN2ttZ2JqVFFUNks2STUvWDZMbFU3czJGTElt?=
 =?utf-8?B?TGZPUW52cU9obGlpb0ljQllKdFhuQUpMeXFQc0JkVWpLdmM4aDVLMG9UekNm?=
 =?utf-8?B?S2xmMFBBbWpPU1ptSHpGWVJpV3o2dkp6VkZrL2dxZXUvbnpPWkV3c1RBZG55?=
 =?utf-8?B?TkZRWnNoTGNudnhSU1NERnh3eHVPWlY1bmRDSWlEUmJoc3FiL3lEbEwrdkY3?=
 =?utf-8?Q?GT0+ghKkBtEAKPAl6lIAL3VsMYBXtYyOv+5RG+2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9229910-c4cc-4483-da19-08d930fb6291
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:17:29.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZpzI67u44Z4smANISY2CLr6qQMIfuD9XovZU/1SETN9geOMKuCgB4QweEgzuBSHZ7805vM9X/fdLyzpHiB8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160108
X-Proofpoint-GUID: cwGVgbCdjL6_oxgxsqp9jdMZxWyd-Chf
X-Proofpoint-ORIG-GUID: cwGVgbCdjL6_oxgxsqp9jdMZxWyd-Chf
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/16/21 9:02 AM, J. Bruce Fields wrote:
> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>> client fails to renew the lease, for any reason, the Linux server expunges
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>> reconnect and attempt to use the (now) expired state.
>>
>> The default lease period for the Linux server is 90 seconds.  The typical
>> client cuts that in half and will issue a lease renewing operation every
>> 45 seconds. The 90 second lease period is very short considering the
>> potential for moderately long term network partitions.  A network partition
>> refers to any loss of network connectivity between the NFS client and the
>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>> driver bugs, network misconfigurations & administrative errors, routers &
>> switches crashing and/or having software updates applied, even down to
>> cables being physically pulled.  In most cases, these network failures are
>> transient, although the duration is unknown.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server reboots.
>>
>> The initial implementation of the Courteous Server will do the following:
>>
>> . when the laundromat thread detects an expired client and if that client
>> still has established states on the Linux server then marks the client as a
>> COURTESY_CLIENT and skips destroying the client and all its states,
>> otherwise destroy the client as usual.
>>
>> . detects conflict of OPEN request with a COURTESY_CLIENT, destroys the
>> expired client and all its states, skips the delegation recall then allows
>> the conflicting request to succeed.
>>
>> . detects conflict of LOCK/LOCKT request with a COURTESY_CLIENT, destroys
>> the expired client and all its states then allows the conflicting request
>> to succeed.
>>
>> To be done:
>>
>> . fix a problem with 4.1 where the Linux server keeps returning
>> SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after the expired
>> client re-connects, causing the client to keep sending BCTS requests to server.
> Hm, any progress working out what's causing that?

I will fix this in v2 patch.

>
>> . handle OPEN conflict with share reservations.
> Sounds doable.

Yes. But I don't know a way to force the Linux client to specify the
deny mode on OPEN. I may have to test this with SMB client: expired
NFS client should not prevent SMB client from open the file with
deny mode.

>
>> . instead of destroy the client anf all its state on conflict, only destroy
>> the state that is conflicted with the current request.
> The other todos I think have to be done before we merge, but this one I
> think can wait.
>
>> . destroy the COURTESY_CLIENT either after a fixed period of time to release
>> resources or as reacting to memory pressure.
> I think we need something here, but it can be pretty simple.

ok.

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c        | 94 +++++++++++++++++++++++++++++++++++++++++++---
>>   fs/nfsd/state.h            |  1 +
>>   include/linux/sunrpc/svc.h |  1 +
>>   3 files changed, 91 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b517a8794400..969995872752 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -171,6 +171,7 @@ renew_client_locked(struct nfs4_client *clp)
>>   
>>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>   	clp->cl_time = ktime_get_boottime_seconds();
>> +	clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>   }
>>   
>>   static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -4610,6 +4611,38 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>   	nfsd4_run_cb(&dp->dl_recall);
>>   }
>>   
>> +/*
>> + * Set rq_conflict_client if the conflict client have expired
>> + * and return true, otherwise return false.
>> + */
>> +static bool
>> +nfsd_set_conflict_client(struct nfs4_delegation *dp)
>> +{
>> +	struct svc_rqst *rqst;
>> +	struct nfs4_client *clp;
>> +	struct nfsd_net *nn;
>> +	bool ret;
>> +
>> +	if (!i_am_nfsd())
>> +		return false;
>> +	rqst = kthread_data(current);
>> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> +		return false;
> This says we do nothing if the lock request is not coming from nfsd and
> v4.  That doesn't sound right.
>
> For example, if the conflicting lock is coming from a local process (not
> from an NFS client at all), we still need to revoke the courtesy state
> so that process can make progress.

The reason it checks for NFS request is because it uses rq_conflict_client
to pass the expired client back to the upper layer which then does the
expire_client. If this is not from a NFS request then kthread_data() might
not be the svc_rqst. In that case the code will try to recall the delegation
from the expired client and the recall will eventually timed out.

I will rework this code.

Thanks,
-Dai

>> +	rqst->rq_conflict_client = NULL;
>> +	clp = dp->dl_recall.cb_clp;
>> +	nn = net_generic(clp->net, nfsd_net_id);
>> +	spin_lock(&nn->client_lock);
>> +
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) &&
>> +				!mark_client_expired_locked(clp)) {
>> +		rqst->rq_conflict_client = clp;
>> +		ret = true;
>> +	} else
>> +		ret = false;
>> +	spin_unlock(&nn->client_lock);
>> +	return ret;
>> +}
>> +
>>   /* Called from break_lease() with i_lock held. */
>>   static bool
>>   nfsd_break_deleg_cb(struct file_lock *fl)
>> @@ -4618,6 +4651,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>>   
>> +	if (nfsd_set_conflict_client(dp))
>> +		return false;
>>   	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
>>   
>>   	/*
>> @@ -5237,6 +5272,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>>   	 */
>>   }
>>   
>> +static bool
>> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
>> +{
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	if (!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ||
>> +			mark_client_expired_locked(clp)) {
>> +		spin_unlock(&nn->client_lock);
>> +		return false;
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +	expire_client(clp);
>> +	return true;
>> +}
>> +
>>   __be32
>>   nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>>   {
>> @@ -5286,7 +5337,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> +		rqstp->rq_conflict_client = NULL;
>>   		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
>> +			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
>> +				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		}
>> +
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> @@ -5472,6 +5529,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	};
>>   	struct nfs4_cpntf_state *cps;
>>   	copy_stateid_t *cps_t;
>> +	struct nfs4_stid *stid;
>> +	int id = 0;
>>   	int i;
>>   
>>   	if (clients_still_reclaiming(nn)) {
>> @@ -5495,6 +5554,15 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		if (!state_expired(&lt, clp->cl_time))
>>   			break;
>> +
>> +		spin_lock(&clp->cl_lock);
>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>> +		spin_unlock(&clp->cl_lock);
>> +		if (stid) {
>> +			/* client still has states */
>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			continue;
>> +		}
>>   		if (mark_client_expired_locked(clp)) {
>>   			trace_nfsd_clid_expired(&clp->cl_clientid);
>>   			continue;
>> @@ -6440,7 +6508,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>   	.lm_put_owner = nfsd4_fl_put_owner,
>>   };
>>   
>> -static inline void
>> +static inline int
>>   nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>>   {
>>   	struct nfs4_lockowner *lo;
>> @@ -6453,6 +6521,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>>   			/* We just don't care that much */
>>   			goto nevermind;
>>   		deny->ld_clientid = lo->lo_owner.so_client->cl_clientid;
>> +		if (nfs4_destroy_courtesy_client(lo->lo_owner.so_client))
>> +			return -EAGAIN;
>>   	} else {
>>   nevermind:
>>   		deny->ld_owner.len = 0;
>> @@ -6467,6 +6537,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>>   	deny->ld_type = NFS4_READ_LT;
>>   	if (fl->fl_type != F_RDLCK)
>>   		deny->ld_type = NFS4_WRITE_LT;
>> +	return 0;
>>   }
>>   
>>   static struct nfs4_lockowner *
>> @@ -6734,6 +6805,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	unsigned int fl_flags = FL_POSIX;
>>   	struct net *net = SVC_NET(rqstp);
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	bool retried = false;
>>   
>>   	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
>>   		(long long) lock->lk_offset,
>> @@ -6860,7 +6932,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>>   		spin_unlock(&nn->blocked_locks_lock);
>>   	}
>> -
>> +again:
>>   	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
>>   	switch (err) {
>>   	case 0: /* success! */
>> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	case -EAGAIN:		/* conflock holds conflicting lock */
>>   		status = nfserr_denied;
>>   		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
>> -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
>> +
>> +		/* try again if conflict with courtesy client  */
>> +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
>> +			retried = true;
>> +			goto again;
>> +		}
>>   		break;
>>   	case -EDEADLK:
>>   		status = nfserr_deadlock;
>> @@ -6962,6 +7039,8 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_lockowner *lo = NULL;
>>   	__be32 status;
>>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	bool retried = false;
>> +	int ret;
>>   
>>   	if (locks_in_grace(SVC_NET(rqstp)))
>>   		return nfserr_grace;
>> @@ -7010,14 +7089,19 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	file_lock->fl_end = last_byte_offset(lockt->lt_offset, lockt->lt_length);
>>   
>>   	nfs4_transform_lock_offset(file_lock);
>> -
>> +again:
>>   	status = nfsd_test_lock(rqstp, &cstate->current_fh, file_lock);
>>   	if (status)
>>   		goto out;
>>   
>>   	if (file_lock->fl_type != F_UNLCK) {
>>   		status = nfserr_denied;
>> -		nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
>> +		ret = nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
>> +		if (ret == -EAGAIN && !retried) {
>> +			retried = true;
>> +			fh_clear_wcc(&cstate->current_fh);
>> +			goto again;
>> +		}
>>   	}
>>   out:
>>   	if (lo)
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..bdc3605e3722 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,7 @@ struct nfs4_client {
>>   #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>   #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>   					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>>   	unsigned long		cl_flags;
>>   	const struct cred	*cl_cb_cred;
>>   	struct rpc_clnt		*cl_cb_client;
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index e91d51ea028b..2f0382f9d0ff 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -304,6 +304,7 @@ struct svc_rqst {
>>   						 * net namespace
>>   						 */
>>   	void **			rq_lease_breaker; /* The v4 client breaking a lease */
>> +	void			*rq_conflict_client;
>>   };
>>   
>>   #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>> -- 
>> 2.9.5
