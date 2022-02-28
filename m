Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2A4C7B70
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiB1VMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 16:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiB1VMf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 16:12:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65F7496A1
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 13:11:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SIJ4Z5018798;
        Mon, 28 Feb 2022 21:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OFGXLtNiKRt3ngHGF5H0Ue5C/v3G52wh1UQKSchVD/U=;
 b=LKjUeudPwCaMqAeQ/UYutbsHR5oBdBpdcPzQHJy9Ac9kNlXwTDXtx7z8tkZI+ms1twgg
 Rt0XmqtcClFN9PmRCL4gXdTpaXPARuB5b1ICreWBtXUAAA6Q45IcEGDMxhV4zZEkpEI4
 7E2gtqHQpncx/E2o/zozaHGkwlWemwNjrGZwgOCTknPIjO29Ngxo5yI0TsvhSm74T+vD
 +RiBCf4cYhGQPLWel8fCbzPM30IuolX9Tgc1V4YChewMCXfC5W3lQvGYYtYQbqWGWKfh
 ik0MmF3jzNFlM1j7EFJcrdUjHvFdqtvcB9perr8AKhEbiBQ3FDFpcntotSZPwrrUpghP 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttdhhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 21:11:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SLBQ7W118805;
        Mon, 28 Feb 2022 21:11:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3efdnkhna8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 21:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iADAuHG9v2kg9wNq+AlEZOeJMNdgasv8uBDGfFXX5c0Nlt+gqNDH6XPnPe9u+cXMT/A1Sc0MPGS6r3hYf4dIJbcky04f+GQSqHj0bXRXFnCTBh+4f5UHb+2MwZGQODcS6sEffFc37J3hjXxoxvu+khQ1WF7XhUj5Nyu2Pt0fre+zwEQF/4VbMFBx5yJBnSszFwPwfiu2+CgfuRrIJdsJLlTVs/TDrggBAQJlZI5vkIYsU+36b0vEnzKs5Kkg6ksz8yKoYNKkmo8nEunVYQBRgg3oRQdwsLlNVodOGKXIWhkADnGWEOgX71fNIMfStuJmZ+yU8Sc9tVXA7wNBJDtRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFGXLtNiKRt3ngHGF5H0Ue5C/v3G52wh1UQKSchVD/U=;
 b=Tk7GZlTq1qCPGMgDGRc29RnG6lOILaH5ojvtG3kIlxstFoR/TmLSCUxtcp3/fu3B4gTbdndx6rzqk7jxRnWKZrtOsofAAaXajlBFYiDzHj6u18ukPk2mNq42j1EUufBJD+JQmWMbyJeK9hWBrJM7unzNB731eW1UJS6sYDLVsvVwpV7GqwzJ7eRS2G7M+ypi+c5Ir/vKcneFMcRpmTUHY5PQh3G603o8d8MFqgfI2tiK7O7TU6WdBzK9HCwVDGKxW0MxAGGkQ1o40iBO1ep1UnwPsMeeBOYa06vspDT2agEYHZQZX9Ssb6SDOzgCzl0dviTsyhbYN2dusEJX2D0BDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFGXLtNiKRt3ngHGF5H0Ue5C/v3G52wh1UQKSchVD/U=;
 b=AAQV4LqeGPgyuWQ5c+Y4BrtDoGeIKmt40xY/ho9s1O3EQv/d4/KAKGp+Ru7pa3vejvAYPe07dJ1/w7uACqeLTYgXEsJzdj9+x9yn/locymf2Dc+cCHtl5u/qB2nKdipvDuKNBpvmIswpln8OfNZZqocpIHmdHo+sO3atITlGtZ4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 21:11:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f97f:5d3e:5955:f773]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f97f:5d3e:5955:f773%7]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 21:11:48 +0000
Message-ID: <5ab13c61-81de-60a9-6ea8-e30edaa04ef9@oracle.com>
Date:   Mon, 28 Feb 2022 13:11:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v14 05/10] NFSD: Update find_clp_in_name_tree() to
 handle courtesy clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-6-git-send-email-dai.ngo@oracle.com>
 <448E3513-197B-4988-AF27-B691B6696F5E@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <448E3513-197B-4988-AF27-B691B6696F5E@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 593deb6b-a5eb-4792-a77d-08d9fafeeebe
X-MS-TrafficTypeDiagnostic: BN0PR10MB4981:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB498162D673D020B9E795F02887019@BN0PR10MB4981.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tr9Gbfh0+YGVSWaIgQ/doniIa4RH7GeH9eptPDBD8eqHX/G20HubxHCH53bBf0Th/ljPTk4mI8LlIXSxhZN8dZ32fDHw8K2Ago5OLp8VKmE+82bomrhktn9r0uK8P3YQVlF28y0VLramUbjaKaucuodGZU65n88v74hlee4gKeEe8xTG6vSRxplpB+DrMA1LuspRGkVxWF9yXF4719BMMNlPdfdc+8/YgOugQJiB61o2Q8PVdHcJg7UTSu6yCMclqPl/YAzdUn/hTEQ/pKDfXaFLikYpxEuJ2b4jtH/xRM5/CBsn6DWQxkKoE/30D2Xfzbut0lU6vhq8qLhpyZfJ21O7GmXam97o3nWtGtqEyv7t38ZZsUj/gqt+fHxsk1uL8NdJAtrqNrkQ0ve89Rnnd8apr8I4opqkgkYVccIaF/JjYmIc7OZEI3IPCkOh595iYVj2YWCJANq/0NNKeFfAINkXOgfMHHTIjda9vcaCjsJGAjeEkeTxjkc5tMFInkjPjJ3Uz0iYQu5e+k6yrvsB+dQ5d/BRlplC1VowT0aNk/PjxVTu1eTh4tNqIzOqZaKXWTddIkiK3DVlwiwU4m4uOx16cCDC0E74FNgmK+qkixg6O5M5wEoaUqI5iHxdcbrjA0JDjDayhqfm2Fke2c9l08Wd6EUr/blQFveCfVbyZUAKfGiiUUNcv2+zgrrFV5MnDderlrJ0AmN3T5kpTZqpKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(36756003)(2906002)(9686003)(6512007)(26005)(6486002)(2616005)(186003)(15650500001)(83380400001)(38100700002)(31686004)(6506007)(53546011)(316002)(37006003)(54906003)(6666004)(86362001)(4326008)(6862004)(8676002)(66556008)(66946007)(66476007)(508600001)(31696002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZwU3NKR09FOUNaZ040Y3lXdllKMndqbnB4eU1vYUdsa3RFS1dVOGpFZTds?=
 =?utf-8?B?bzQwekhybmkxWm16T0FxY29TZWpVQ0ZSOUI5NXlOaTNZc3c2eEpvUVkydkRj?=
 =?utf-8?B?dmtEQmFzM01FVXZxTitJVGkwb2k3a1ZZREdKazYzU3ZzZzVlVHI3MFRBa1pG?=
 =?utf-8?B?T0NMbWcrUElYL3RZMUUzWGRobnJ2VzNHQWh3VFB4akp0bEtyNEFzL0J4T0R4?=
 =?utf-8?B?M2QvRVkwQ0tLY3JJLytxWk1Wd1hHK2FyZzRsYUQ3NUVUVnNSRXBjSS9xMkVX?=
 =?utf-8?B?Vmp0QkpGYXFZZ0dPaTlTSzZSRW9KMnBKNVpiZmdKVkIvc3hFKy9YUmFCNzB4?=
 =?utf-8?B?Wk1kc29lMFJadFRTNHV2aWxSRHpCT1ROdUU3c0FUWHpNNEsraXdPMGhDSnpl?=
 =?utf-8?B?UTZvSHlrR3BXVnRjQnFNQWlHQm1jejV1YVQ5azN4WEVrK1VWOFMwSnZkcE9p?=
 =?utf-8?B?UHhzdnlmMytQa1dKTFhTdmh1dGxqYlkxZjErQ0hlZWV0YTBwZDVwcFVwcWtq?=
 =?utf-8?B?Q2lJK0FQSGs3S0pLZkxucHBEMHJXUmRhcWE0dU1JSEhySzhjdlFYUlNRZ3hV?=
 =?utf-8?B?RnZRVnhNLy9DaWJVelJlOVQ3RG9qUkdQWSsxcU9WRis4eFl1clNaQVZ4UDE4?=
 =?utf-8?B?bXNMelNQMnRpVW9McnBOcTU4cUtVM2hwVlFMRkNFSHQyaEtQUDJNQkZodG9U?=
 =?utf-8?B?OE5EbDBpNkFjNkdwcTdLWjlJdWNDYVVOalBHKy8yWjZidlBhQWNNM3IvNEdQ?=
 =?utf-8?B?Q3M2L1lSM0V5VWZpUG1vbU5ObmtmMndDb2tlTnVpN3NjM0c0RTk3ZE5lem9z?=
 =?utf-8?B?Z2QvemJxYVY1THpsRUpmRmloaDhDU0hKOENEb2Zkb21OWjBpSG50aWF1by83?=
 =?utf-8?B?b1lDU2ZncEZpTkdOdHdUejN4NEdUUXRPYk40N01SdmN5NkxhZHNpQTlGNjR5?=
 =?utf-8?B?N3RVR0lvKzRxTHhQTk9wN1hFUGg2KzRWZHYxUGRLVGJpS3VGVmRDc09XdUxa?=
 =?utf-8?B?eVk1S1MzVDltK21aYUFrY3V0c0VPczljc2U2SzJhaWNYZTE3djcxMG5DSjJz?=
 =?utf-8?B?N2I5VUV4RFFLUU9ENUM2ZFZ6bWt5ZlVKaWtKYW8rV2J6L1NLT0dGRTRKVkw1?=
 =?utf-8?B?M0xTMHNSZGcrY2pBWVBoLzd0ZW9RRTRXVFQvOHJXejZXOHQ4bmpiZDVrcUg5?=
 =?utf-8?B?U0FGV0F4ZjJLd2c3SkN4ZkRVdEpkb1REWm52Y1ZmdkwvUkQyNXBSc1dWcm5y?=
 =?utf-8?B?Vk5TWFZWQXVEdng4SUwrR0hjTy9hQUhPRVFUVzhSei8vaWUyS3VLajNxajdO?=
 =?utf-8?B?V0ZqUU1pMllGd041RjNUSUFuVlRDaVZXRkxBVDJLUC85MkttZGFIV0QzdUp1?=
 =?utf-8?B?WENLS3BMQWFZOHp2NDhVMjVaWUlab0tKdGU3UVJ3N3lYd01acjFFQllBUWpX?=
 =?utf-8?B?a0tHdk53MUkxWmpuRlVmcWJscUhFcSszalcvRGJIR1lCM2FJcm54bjI1ZHpX?=
 =?utf-8?B?dkMzSzhvR0NXMzVWZU0xL1dBc0grZmxqZ1ZSaG9lY2VidUJNczVDczdFSU1V?=
 =?utf-8?B?UnFGYlQ3Umo1QkcvMjFNSmNDT21GQVFXYWx0T25TOS9yQlQxRWpZenpDd3RP?=
 =?utf-8?B?K1p1dnp3SjZNMTBJaFZKVVBqL1NMbUkxcjFaa1M5cFAyalFPRU93K0xPUVlD?=
 =?utf-8?B?L09sTmd6T28zeHZQbGNxTU1mWWRXS0dNa3R0MmJYYXdVUjgrQ3QyQjNXWU9V?=
 =?utf-8?B?Z2xkdjZQQ1JxSGdrVk5HTzJ2RlpGTFBjaW9SeHdjVFVrcVNiVkZqUXhvVGZT?=
 =?utf-8?B?ZGVyMjNGU1FzUVcvcDkyUk85TUxhUVl3RVlEWUJ6bDNCREJYTWN3M3NHcE1F?=
 =?utf-8?B?a090ek0reUl2U292a1J6QU5aZTlRMm1hR1Rra1c0THhYbDR1VzFjVnhQdUpm?=
 =?utf-8?B?VHhEWGVaUVBRYXJkNVVUa0RqajFjQ3VlUVZuMlFMVHdMZXJQU1U3RHNzZ1Bj?=
 =?utf-8?B?NUxiaUtsTVliYStmdE4waG1OZHp2QkszMkhhZFY1bWpneW1vWEUraGdNb2Ni?=
 =?utf-8?B?ajczVGJjSE1JYkFBNXNzd2dsRVdKOGVYNVN4cVZOMks0SHJ2dnFiSUNIZHhU?=
 =?utf-8?B?OFd5Q2twWjdONVViU1B6NGxjSkFWU3lNYVE4MDJQK1FDK21iWFhCS2N0citu?=
 =?utf-8?Q?YKftrvlSVbWoXIA2YkYKQmw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593deb6b-a5eb-4792-a77d-08d9fafeeebe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 21:11:48.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhdWM/Nc0WWxpn5zn/NpiBUtiEHAZSbD2LB7q4Og2aFiNe24dwGyqQeO+e5YTaCnZsMoRceJZwXi+1xANPYjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280106
X-Proofpoint-GUID: Yix613pl-NVmQ45CwlEgIR_DmwnQ92dc
X-Proofpoint-ORIG-GUID: Yix613pl-NVmQ45CwlEgIR_DmwnQ92dc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/28/22 6:56 AM, Chuck Lever III wrote:
> Good morning, Dai!
>
>
>> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Update find_clp_in_name_tree:
>> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
>> . if courtesy client was found then clear CLIENT_COURTESY and
>>    set CLIENT_RECONNECTED so callers can take appropriate action.
>>
>> Update find_confirmed_client_by_name to discard the courtesy
>> client; set CLIENT_EXPIRED.
>>
>> Update nfsd4_setclientid to expire the confirmed courtesy client
>> to prevent multiple confirmed clients with the same name on the
>> the conf_id_hashtbl list.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1ffe7bafe90b..4990553180f8 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2834,8 +2834,21 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> 			node = node->rb_left;
>> 		else if (cmp < 0)
>> 			node = node->rb_right;
>> -		else
>> +		else {
>> +			clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
>> +			/* sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return NULL;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +				set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
>> +			}
> This should be written
>
> 	if (test_and_clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
> 		set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);

Fix in v15.

>
>
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			return clp;
>> +		}
> And since this is the same logic that is used in 6/10 and 7/10,
> please refactor this into a separate function and call it from
> the find_yada_ functions as we discussed previously. Thanks!

Fix in v15.

-Dai

>
>
>> 	}
>> 	return NULL;
>> }
>> @@ -2888,6 +2901,14 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>> 	return NULL;
>> }
>>
>> +static void
>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>> +{
>> +	spin_lock(&clp->cl_cs_lock);
>> +	set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +}
>> +
>> static struct nfs4_client *
>> find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
>> {
>> @@ -2914,8 +2935,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>> static struct nfs4_client *
>> find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>> {
>> +	struct nfs4_client *clp;
>> +
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
>> +		nfsd4_discard_courtesy_clnt(clp);
>> +		clp = NULL;
>> +	}
>> +	return clp;
>> }
>>
>> static struct nfs4_client *
>> @@ -4032,12 +4060,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	struct nfs4_client	*unconf = NULL;
>> 	__be32 			status;
>> 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_client	*cclient = NULL;
>>
>> 	new = create_client(clname, rqstp, &clverifier);
>> 	if (new == NULL)
>> 		return nfserr_jukebox;
>> 	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&clname, nn);
>> +	/* find confirmed client by name */
>> +	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
>> +	if (conf && test_bit(NFSD4_CLIENT_RECONNECTED, &conf->cl_flags)) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>> +
>> 	if (conf && client_has_state(conf)) {
>> 		status = nfserr_clid_inuse;
>> 		if (clp_used_exchangeid(conf))
>> @@ -4068,7 +4103,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	new = NULL;
>> 	status = nfs_ok;
>> out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>> 	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>> 	if (new)
>> 		free_client(new);
>> 	if (unconf) {
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
