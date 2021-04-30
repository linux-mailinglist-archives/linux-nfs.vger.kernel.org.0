Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5A36FE62
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhD3QUD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 12:20:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35408 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhD3QUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Apr 2021 12:20:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UG72RX175216;
        Fri, 30 Apr 2021 16:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QjyVFuvm6DPMWdRbVJ6mIEcXv05PmUfnLgeJQYM0Iyk=;
 b=TiT+b/1BehQs1B+vtIFbLwgCNEJ+G85Ljpa4DlUkd0NAkhM9QN9x5QYMl6dPIUqO5UuP
 ebkLmAg/DFLCDjnuS4PLnzVeuAaxwaM18fZf/VkUBlpcFrCBSKAYfXR65LpbQbCjwIbZ
 wbvJtjhyXvh4vQOFTpXEILItSkKYS9nLTpTOdMjx7CIQS/sGFNS3twaaktbB+wCXczkG
 YpxtipfoMJ5EgomM7QCl9r9WK/8PLgXN6IQct4D3nSzvJvT6VnlniJJsgqQTqNm8od4l
 GFL+SSqdYH1Qz34uXglU2pO1y7GQf3SUp/VjVQslOyUfvnPcgo4Aapa1WVvrcjntW/bT 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 385aft87uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 16:19:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UG70RW087285;
        Fri, 30 Apr 2021 16:19:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3874d54nft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 16:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlA/AwEqoub/pKBCloS+s+Ah1e9SfiHmrOTwwOOi4on6Q7sKI7Uspd2efiw6msnMZjuA3qyg8KNqwr8TJOyegGiD3N9Y6C5zc+fCVYUKTSPgXA022T6BkJ/4bF0TitSHw27Occm5lyoewWY2ge2HSB9w9nroMparGJEuPH/5spHkKIanHHT237YV+NmxlMXBf0e6QnZ6cBWYHmHKLYMMFySOXU8dKrNZxqC92YarPCIKZqTOnWxZSL5u2cGlKEiajqZMt5b7e+YGqU90puEQzB+YjA5gT3GknjoGI3kgqWOH1Lx8QajyUL2Xz3V/HoKbdqEUlK2dQpXcrMzmHouejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjyVFuvm6DPMWdRbVJ6mIEcXv05PmUfnLgeJQYM0Iyk=;
 b=CfuyPrpJkxMi56YKoAQGhLqbP58v/oVdjH6Y9iSlQHb8V0URGKKENBHjAA3DXuugxDK54numjcduJIOAMGKm0HllBzByCWqvzz2JSaER8S2xF0xXkquG4gajBqhEsuasU0XkCyXWCiFh8t8xsDcJjNkmtDTHMDgNBsGeSS9KIyWSLz4Apj7QOBNas+nP1j1452BolXBO53n3FovCw6BPa8harT3hQGxdZ7YJ5WuBW3MQ7TjC1kMm56su+tZmSMR64nPt+2vNRz/1CHDlc4Dpk5ODuICQO4UtKLcIJDPWCtORsFBDp+zd644GV5D+UUjGijJdpfr65Tia8Xa0X5y+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjyVFuvm6DPMWdRbVJ6mIEcXv05PmUfnLgeJQYM0Iyk=;
 b=xoNMXkVOZI3leXpc2JmeMwCGZxmRI97HxiBv970go4GDmdnkxZkLYgSOVkDQiiDvuqYMIl2tnUvLqijvzf/nid3wFPy6BH7qn2+x7ViHxuD+tenPZLOA3Ulk6JsR5JBnWOH8E/XzHI3paHML8IDILf0M6LmRSHKwj4os7Jkl3vw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Fri, 30 Apr
 2021 16:19:06 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 16:19:06 +0000
Subject: Re: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210430050900.106851-1-dai.ngo@oracle.com>
 <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
From:   dai.ngo@oracle.com
Message-ID: <3eb40de3-7e7f-8164-0abf-f5355c8e70ca@oracle.com>
Date:   Fri, 30 Apr 2021 09:19:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-138-225.vpn.oracle.com (72.219.112.78) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 16:19:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52c2d24-8c83-4e01-a7ff-08d90bf3ad28
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4447:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44478C47B010474336F00117875E9@SJ0PR10MB4447.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAMEtkxjbDMl0QCcsZ+RPimfou6JWGnU5S1tw8FXr+BwwNpIYysn+rl4OxH1vQFoxpDxkB+ZlKzwKAULm9VKjRLwRjVvvsGLtGQ93G9U4GHyVw1vAYX2aStmsClHJAbdD4E3Tglr62tel33usBh2TO3gal6VUGUNRfJQexayZWK1YO3BojccAfvZC7rIX7RZmltiYxPUnvOBxkL6Qw1y8ZXkQJSmfc8nn/nCqhYsWL6bfBEU2njLhyJHcluj6rTfcHghx1e1D9+vQqnPFTaQkB/G5xC43hARvVmcyQHIlXMi9Z8Cnn5slXXxy437ehoMTIX/EUYn5tXHNU2J4+lLWnf8yjvUNVRT5oBqKYdVg719A/AE6+ZCvZlnEGX/C1MvheweXmYZmxo8vnzXJdEz85SY4VVBBSMrEsSjXuRoTvq1KzKzlSMhvUbY8l4f59iVDPtMaXxc5qaq7bZtkEeSritWEsq387ei0f6PZ0j0svKFUvpkrlNShHYDuYe1/lZ0jbQgLVbg7hUVRzOU6W+/C+fxIyqNCOyVha7OKXApe5dVo8KuJoiwU7gx1yXxcZxdjsfoj8vgp/1tHiHjhrapDhzom91x806ZWc3ecbNr7x/Nx+XdUHjpxoVGCdOLDV9WJJpVcds9gIPDbJfadLDLiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(39860400002)(346002)(16526019)(4326008)(36756003)(8676002)(53546011)(6486002)(31686004)(316002)(186003)(6916009)(2906002)(956004)(5660300002)(9686003)(86362001)(7696005)(66476007)(66946007)(26005)(83380400001)(478600001)(31696002)(8936002)(66556008)(2616005)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SHVEN1krWnJvZk1QWXZoRHNMTHZObWtFeVRqdUlINkRkNC9CU1gwWTc2eDNL?=
 =?utf-8?B?dVBvMGYvYTBGQkY3b2FEQndXdkFjRzNjZGpqZ3NNZjI4NjZkdHM2aWViV2tN?=
 =?utf-8?B?akF3dDJoYWpPbUVZbDhnVCt4STNxTzNsbTMzU0g5OWlrb1NxcHhMV040bnMv?=
 =?utf-8?B?UThRY3BRSmdqZDROL0RKcmxJUVUwYXBlNko4QWlEbEJITlM0NDRWUm9nelJl?=
 =?utf-8?B?OUhlQmJOQzJleTNka1E0bXZlRmJXZnl3ckI2dHdOZ3Q4MSthUFUzdEMzbGxQ?=
 =?utf-8?B?Zys3UXhEU29QQlNQNHB3cDJkMFpEOVZkSlJLWS9XOTI2eDkvaXA0LzhDUHY1?=
 =?utf-8?B?bHIyNDhPMytJYnh3aXFydWZjQjREczJIWG5MazNvUSttcXh5RjBONWNjSEdm?=
 =?utf-8?B?cnN3VHdYMTI3bC81MHVLMG5yLzlVUUFCbWpDYWFvYSs2RDRsUFpQMGpLTnBV?=
 =?utf-8?B?aGRsSDlrUUpTcmN1cDBlMDExNmpLQjVSUjkxUkRwbGZkODNubWI2YUoyVm9O?=
 =?utf-8?B?cWdxbVVKV0szNzdFdWVvUzEzblpod2hkbStSb29MUzRUTkFsb0JwLzZscCtm?=
 =?utf-8?B?Z05razhFLzMyR2hwWjhCR1NodWJKVzFzTGNyc3VES20xUmZHV1Y4MmNPOSsr?=
 =?utf-8?B?bDBTbitWNGNmMEduYkZlRk8rcmhCVGRTRmRCRUZWZVA3UVIrMkxJMlRURExp?=
 =?utf-8?B?aXJVSEtrSUZqMHQxaEJEQm1LMWxURytZb3NjRmtwb2w1VzRQdHZQSzBGRUQ2?=
 =?utf-8?B?Vm1qU3ptTmVlMEEvQ1N4cnU2Z3BMY3hUSmhxZWpYQmU5SGRSKy9rak45d1o3?=
 =?utf-8?B?dmpNY096cWFOQW5kNnkzQXBWOTNJZWU1OVhaU3Y3YUd4SEJKazc4U2c4OWtU?=
 =?utf-8?B?QzRQS2h5OUNxMUFCNXFWRllBMTVFMXVUV0hzK3gxWkxGdDdIYVMwZDR2U2Uw?=
 =?utf-8?B?WnhOam0vMm1HbkxUc0tDcDlkVUR6eWUvdGpXZ3N4Zjd4M3NDYmRoWE9sVEFB?=
 =?utf-8?B?WUJjem91Y2svbENOSU1UbVMrR05vV2htSEFOalhnZi9BaXF6cHZTdUxKNlFV?=
 =?utf-8?B?MSt6SS9TT21PUkxQeFo5UEhTZE1oK0prRmtoTmExUTVpVFkxaUVtK2xLMThv?=
 =?utf-8?B?UzRVT1l2MW5FMHJuWXBMTm1VN3h6YlhBSXZNRkUzSkFGMkJ5SHBPNnZ1U25W?=
 =?utf-8?B?VnoyZlpGY21OakxEYVFta1VBdkhPbDNtdnBoa3ljckhKK3NROEZkOHMzQnpO?=
 =?utf-8?B?M25KMkV5cmpCY3VIZ1BKTkRkYXlQSU1Wb3hiS3JIOXJNMjlnd1ZpOEd1RFAw?=
 =?utf-8?B?MFBzRzEwZlFrRFdaSEhrd1BZcDdOYkxhYUxQL1R2Tkd5bUtFaFFxTStaU1d4?=
 =?utf-8?B?Z285RjJOUDhNWUljb1grakVSNmRKbjJXbXZaUWJaM04wblNSVGVUK0ZTWCtW?=
 =?utf-8?B?MWxidDFMZEE3RGM0TzhpVFFjWjkrNk9FKzM2TmNma2d2eGxmdVgzVHVZei9n?=
 =?utf-8?B?SFVkcjJjSVZkSGVkWXFVN3Rja1BrSk1jT1FUUVprSGhGMjg4UDRKdlFTdmVW?=
 =?utf-8?B?KzMxSkxybWcxYjBBbGVPelBnbzBxOHFVV0hnbWRQOHFNQVdlYjZHMDlwMEtl?=
 =?utf-8?B?eHJuS3k1RGxHbmpCdkV1YzVYV1dBMVhrMDN2Q0JYMmpTUzJodnZ5azVveU1h?=
 =?utf-8?B?TzJLZGJVajZxbUNDNmJWTE9obStXdnZyeGhxMTdQMDRMY0F1aVpmbG1BSEVY?=
 =?utf-8?Q?+EgtbM50l3kyu27JXJSh2fZNR0u8EhadDxQhUYV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52c2d24-8c83-4e01-a7ff-08d90bf3ad28
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 16:19:06.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9Y5d6gJJxbwHh0vI3pxH4wv4MA/kIYQ+psiNTGrcJ4yyZYDohrAq4lc8mJ+uBKAkd5Aero472iCU38VtVC17Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300108
X-Proofpoint-GUID: MuyCEI6DZcQwfPYTyq7dfrCiectk3ztP
X-Proofpoint-ORIG-GUID: MuyCEI6DZcQwfPYTyq7dfrCiectk3ztP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300108
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/30/21 5:42 AM, Trond Myklebust wrote:
> On Fri, 2021-04-30 at 01:09 -0400, Dai Ngo wrote:
>> Currently can_open_cached accesses the openstate's flags without the
>> so_lock and also does not update the flags of the cached state. This
>> results in the openstate's flags be out of sync which can cause the
>> file to be closed prematurely.
>>
>> This patch adds the missing so_lock around the call to
>> can_open_cached
>> and also updates the openstate's flags if the cached openstate is
>> used.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfs/nfs4proc.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index c65c4b41e2c1..2464e77c51f9 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -2410,9 +2410,15 @@ static void nfs4_open_prepare(struct rpc_task
>> *task, void *calldata)
>>          if (data->state != NULL) {
>>                  struct nfs_delegation *delegation;
>>   
>> +               spin_lock(&data->state->owner->so_lock);
>>                  if (can_open_cached(data->state, data->o_arg.fmode,
>> -                                       data->o_arg.open_flags,
>> claim))
>> +                               data->o_arg.open_flags, claim)) {
>> +                       update_open_stateflags(data->state, data-
>>> o_arg.fmode);
>> +                       spin_unlock(&data->state->owner->so_lock);
>>                          goto out_no_action;
>> +               }
>> +               spin_unlock(&data->state->owner->so_lock);
>> +
>>                  rcu_read_lock();
>>                  delegation = nfs4_get_valid_delegation(data->state-
>>> inode);
>>                  if (can_open_delegated(delegation, data->o_arg.fmode,
>> claim))
> This is going to introduce stateid leaks. The actual update of the open
> state flags happens in nfs4_try_open_cached(), which is called from
> nfs4_opendata_to_nfs4_state().

Right, the actual update is done by _nfs4_opendata_to_nfs4_state called
from _nfs4_do_open/_nfs4_open_and_get_state. I missed the check of
data->cancelled in nfs4_open_release and just keying in on rpc_done not
set path which skips the call to nfs4_opendata_to_nfs4_state.

Thanks Trond!

-Dai

>
> While we could put spinlocks around the call to can_open_cached() here,
> there is little point in doing so, since this is just a read-only
> advisory check. The real check is performed, as I said, in
> nfs4_try_open_cached().
>
