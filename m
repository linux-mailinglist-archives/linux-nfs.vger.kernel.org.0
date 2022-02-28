Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF694C62BC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 07:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiB1GGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 01:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiB1GGG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 01:06:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0235A08B
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 22:05:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RN94Bm021511;
        Mon, 28 Feb 2022 06:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x3Gq08YYILQRHLnBbXrU+EYp5iysGPwrzWf7DbWPqtU=;
 b=mN4mgrsqOD5K8sFLsfcspW33H2/Qog8dMv6ytRKKn4TqEi5wN9omPcpfar8ppXQvz7Wa
 Z9vU/DkE/yAsm+8f3fjSrctzXlEcrC8a9jWwpI8ME6RyUPXc2/TlqyzsF22raSlxvddw
 pbu00Q3q5v7MwcUqStE702AdovIZnZJKyha96PvFxyyswTOb6qT5x2rqXl1OZ1TsFv5H
 bIPpfdXanRvoWcvUvZL2evYVyi3xONNGCvfuOih364jz2ssfsxhERnz0XkX7jIDrS4Mm
 NGCXB3B8UGBD2jGG3t7Sbo3Zy/ZgKEIC9lsPoVC7lksPWZDeyKUX5eJyk6Zxnto0PFpP XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1u6ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 06:05:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S60jle160990;
        Mon, 28 Feb 2022 06:05:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3efc12ju3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 06:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoadd3xpg2mCBzbMB8gVZ5B5ym0p6EbrmPfAVE+QoLyTrOGqdWJ+EswbTLbyKmUGYSYExgN2S9iFxJr00gon1blTVKmy9HIBRT/wXJbw2Jb6rT76I15cA9Ga3X72AEj+VE2pB7A67Z+kA+jlYWs04vr3M3YMYDeA4p7iSKBx8bMjDXc6qHo8lbQGQwrC0Yp1bmLdcD5ptT12zgP1yY/6K7tMoTcAQ2tHNmFQqfFa43k+MnMTrIf8zwC65W2ZbKTXK0en0YEDmu9WRX1Q1/PcmLYRs/M+h+DYbH+5ZCUDSthEtVxoLyBH2+m9Rbbsyfg70EpvBi46JaGns7DsFoQURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3Gq08YYILQRHLnBbXrU+EYp5iysGPwrzWf7DbWPqtU=;
 b=dYj6J85G8YjiM3DDXXT8x93Klkj+An4w2au1gWKi3IAlTL7UitPXwy/Ojx1n3C3MYceMo2KVHkeHeI31txUKsUiIkhgfwyXaiG0lfo64pTkuI7rbpFucWOlY+c/4fGIhFTUie8qczNz6MI1IO8RQ25c9Z2YKo5Js7w9JUjRC2kxicRvU7L+YJg1Ca13rom9a5AFcxcJ9OVZNlDnCQPq9ZnWydw5YaQUpQ6Vdq77qPciUoLmvYXXOfIRXLXmZKFUYnPB85A1sVlOe38FfeYSPMN3sExqg0ZIq80HRw01bfQs7HJrtAn5Ihpvo568pTU4T6FnJCCMJoE5D8DbhIY7AJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Gq08YYILQRHLnBbXrU+EYp5iysGPwrzWf7DbWPqtU=;
 b=Kf0uMZtrgxW9J5qCFeZrwqqiuoBOVZBrd4ofStVuC7G1JF/jOt+k82RI/wJQR3VdcYwANrrznPIUk0LVXnuiEq2Sp+PK0Ta8qn+Stseimglptoj77eB1Un26iqttxKf8sW0VXuGYg92hksKxLB1r1sezgjXFYhj62HZa9oWoEHo=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by DM5PR10MB1611.namprd10.prod.outlook.com (2603:10b6:4:b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Mon, 28 Feb 2022 06:05:23 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 06:05:23 +0000
Message-ID: <ee0866bd-d949-f4f0-2693-b06fc877930d@oracle.com>
Date:   Sun, 27 Feb 2022 22:05:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v14 02/10] NFSD: Add lm_lock_expired call out
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-3-git-send-email-dai.ngo@oracle.com>
 <648261D6-098A-4326-9D03-516E69A85746@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <648261D6-098A-4326-9D03-516E69A85746@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79da0b2f-ec94-4512-ccf5-08d9fa804ec4
X-MS-TrafficTypeDiagnostic: DM5PR10MB1611:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1611AAFCF75610BC5325F15B87019@DM5PR10MB1611.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEVRJb45o+4zuk478CmUKM+xDVz1m/n1JWIEh+AmSvB14J7lF774a1hOIL5f+jG7afWPch7N1RWTIM8OQvlc61NJuWSrg0n4NLDwzhmq806t16ALc2gTeeIWxRllaUuv56ywF9yYShB4po4XpXMnga2d5Ydt7UaJmteabCuWdr/fS6IAcQbFId9dTAlmRxVeL1G8s8pi5BgtPwPS+s8D0J+VrXn3jnk5o70gvz6ET2/Rhiw36i2izWC68pgPiqFKYz3KfITpLvnVybdqoUcagk9it/cIPXOdeHNnB7YOH/PIN7SthrnFs8gi07v1mJga8P6O7+s1CssvPwX8sR4A8JuIZm1aNxfaYjnps4Dvt/g6pGkwpjfTL/uCmT237xQhKn5AtalvSuzynf9RaqFewbTBnzhR1/XN49iMByNTZgPB8rmJr/tPUHHDf+ucOxlK2T+n9p91ps1ft2VwfnC+gUUcVWn+HnuCEBmelLzn58lmA3R7i2egH0/K30H9lIN1igjQvXi1lA1BtOJcuMR4P5RT84OWdZi6lhNprUWHIlFWcCA1K5ImNuvF6TnUJuSo5c1oYqh9X3ObnrxEf/N0lXoTScqUCzMDkqCZ28DOUAn2tQP1gV7lpvHgtulWua7B1FPCfvI6RlFkt7Wu9XW6QrffIQRQMl0cb+49C18i+HcTzYEtUxgovzpsNNpQZ2UdoFGp99THKK+w8V0FbBe66g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6862004)(66556008)(6512007)(66476007)(66946007)(8676002)(4326008)(53546011)(9686003)(316002)(86362001)(83380400001)(26005)(186003)(54906003)(6486002)(37006003)(508600001)(2906002)(6506007)(5660300002)(2616005)(38100700002)(36756003)(31686004)(8936002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVUzUlh2aHJ1ZFhtVWs4OVhWaDAvR2tjdEwyYlU1SGZLcm13YmV3MFBCMGZt?=
 =?utf-8?B?QmxxYmVRSCs5ZUxTamVLcnEwSWt2bWtXc3JnN2hrMDVjdjJOOThEZk9PSXJC?=
 =?utf-8?B?MkdDZTYvU1JmYndaZ3NHK2hWSmQ0dnZkdXZ2REYxZnlJZUxyMWF1QnM1M2gw?=
 =?utf-8?B?ZGkyOE5pc2FCUEFlVGt1MkozR0poQjF6OW1xMzV4cEQ1Rkg4MWNlaWhQZmFH?=
 =?utf-8?B?Nlo4R3ZWamVDQXVBWmVRakZrMDFPZVhWNjlmMGxWNU1qR3JMOTMwWGYzdG5S?=
 =?utf-8?B?SDJicHI2RC9JVUlhMXFUMWw0L21ETFpIQ3hlb0F6V0dSdHh3aVZMdDRYUlB5?=
 =?utf-8?B?TExvbG9NWmRLNGNOdGhSSUVhNEVyWW5OV0JId2xzT0k4ZG1WSzdJQ25oUGFs?=
 =?utf-8?B?NzQ4b29YWThOaW1xS0pKMjExbzZySnhNdGdoOS9BcFZPVUc2K1YxU3pwT2F5?=
 =?utf-8?B?QmhMQ0YzTXhDdEFyYnUvWCttLzVOa1Y4MXpVbU1FeFdPMFhaVzU3MlQwYWZy?=
 =?utf-8?B?WjRGYjdXbm95RmdZUlJHOTlvN01WUzNRRStqWDlrdHlPS2ZuY2pLRm5CenhG?=
 =?utf-8?B?QXZsOFNyZFIyVDZ2REdxN1haZ3AxcjVUbXJ6eUtKMXMxU2YrMHl6TjlwcGRk?=
 =?utf-8?B?RHdpd0k1UmN2NEgwZzdGRHB3TkVpN3A5S1pCbEZEd0dUMHpzYXp5NEJHOGNn?=
 =?utf-8?B?alVyVVMyVzNUcTZqODJ3andlcE1QUmFYSGFUdmF3K29TWlozeU5VN2VwY2hF?=
 =?utf-8?B?TFVSb1BjVlNuNk1jeUovMjVJT0lhSUtGUmt4dVM1ZlMzaG9nREZBRVVMbVRi?=
 =?utf-8?B?ZVR4eUdld1ZMYXRJVE1mUHFacUdab3hMSHhLTEZhSlIyckNsTDkrRDlFL3Fm?=
 =?utf-8?B?TCtXQ29PK0JDbDhXSzY0OWI5QkpOSkl5VE5sUTJPVkJTVlpwZlB0Zll6V1Vq?=
 =?utf-8?B?d2dSa2xQU3ZNNUR3OHpOM01GUXA1Tks3djk1cXVJTFg4bWtnbmZlYW9EYUdk?=
 =?utf-8?B?MkFoMk5xc1FJTEN0RFZkYmNxSTU0TGdSTEhRZWRaNWRhY3FpY29NM0dGYkRC?=
 =?utf-8?B?Qk1BQ0tDbW50bWt6WjFpeVIxOHk1OUlWL2w3MWh3ZVh1dnAza25HY3MrQUpZ?=
 =?utf-8?B?cnF3VWRoWHY4TGE4YWZ2UkRKTkp0ekRFQXltQWZUREZtYVNkOW5UVnVIcTgr?=
 =?utf-8?B?UXhlVXo4NktlNWtTd3dIWXg0ZjhoMTNPQ0l5ZWcyYW9LL1U4dEhBS1lwT04r?=
 =?utf-8?B?MXVuSmVuWkE1T1ZIc0R0Y254S1V0UXhxN3phUEhPOXYycUVIQlBKRDB6Ylhv?=
 =?utf-8?B?czVyVGVRL2NwT3BKMWQ0alRIdXdndjZobnBiTjRBUnhHRHhUU0V2MXZ5cE9P?=
 =?utf-8?B?S0dtUWY3NDFHUzVvWnR1Nk5HQ2JKMW5hNitmWjMxZlVRU0U4WEZ6MUl1YjhL?=
 =?utf-8?B?MWxyTmJCNWx1ems3b3R0MGg5UUtFUlE5U0IvYVBoYzlpeXVsTURON3Q5NmZK?=
 =?utf-8?B?c1RpckNUeEV3a2NuVzZNRTBxeit2ZEEvTTNjMWNxN0k5V3RtNXFLZC9WTkcw?=
 =?utf-8?B?TzVhblpBcm5HL1p6Z1NZMUZNdFZiN2lRQ2ZkYXhiRk82WkVyRG4vK2R4M1hT?=
 =?utf-8?B?MVhjMjUvTVJJV1J2VVVQUlFwME9kV1ZxaDNXa1dpTm9ZTkQxa0dnTFAwV3RG?=
 =?utf-8?B?RDlhN3BVcGlxbjhHS3ZCUGhTSmk3bDVKYUMyNlZlZElPNUpqSGVTNStRQWNj?=
 =?utf-8?B?emJqTXdiM1pCUDB5bE82NzQ0Z1pwUlhIRDAxZXZQK2lSbzliZG5RNU9QMTlu?=
 =?utf-8?B?UHlrZ0QzRlY3emUzamJvUjNvNFdGWWZHNHdVK3c2b01SQUtSb01LaEk3L1oz?=
 =?utf-8?B?c0lGWTAxN3FVTE1FY0FCVGVpcjBqc3R2VmMwbTRSaUtCaTJZNEw3MnRVVHBU?=
 =?utf-8?B?SGY0NFNLcmM3N0hjSGxvODg3dXdXZmpUTVFrZGduVXFTK01ncSthRkpqT2RC?=
 =?utf-8?B?NVJrK0puYVUxemMyQ242NnBnbDZ4THVIT01maG95dERPc3FFRFB5OWUrZjBx?=
 =?utf-8?B?OWt2aWxVOW50RVVyQ3o3VVkwcEhSNEpiRG42MXA3bUlkWlQ3S1l2OStncG5X?=
 =?utf-8?B?T0Mvdkk2VVdWYXY2aVYra3BQUy83NGtHZDNNeG4rVnVsK25vZklTWlI5NnUz?=
 =?utf-8?Q?/XnaZBvMo2iMSZQIwwj/gDE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79da0b2f-ec94-4512-ccf5-08d9fa804ec4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:05:23.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLsBZv7LB9ZWc5+fXZYTIHMwEF/bZQ+9lWWH643BKMdTSB2E0OPTeqQv3nzZ3Ty+xpWTbkF1/zdhJpKCQSftFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1611
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280036
X-Proofpoint-GUID: UBwb16hdC4SlZrtJfuMWXI8C_2hmCHHO
X-Proofpoint-ORIG-GUID: UBwb16hdC4SlZrtJfuMWXI8C_2hmCHHO
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/25/22 8:29 AM, Chuck Lever III wrote:
>
>> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
>> If lock request has conflict with courtesy client then expire the
>> courtesy client and return no conflict to caller.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>> 1 file changed, 37 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 6a10f089ef4c..6bca727978ea 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
>> 	}
>> }
>>
>> +/**
>> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %false: real conflict, lock conflict can not be resolved.
>> + *   %true: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_lm_lock_expired(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc = false;
>> +
>> +	if (!fl)
>> +		return false;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>> +		rc = true;
>> +	else {
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> +			rc =  true;
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>> static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>> 	.lm_notify = nfsd4_lm_notify,
>> 	.lm_get_owner = nfsd4_fl_get_owner,
>> 	.lm_put_owner = nfsd4_fl_put_owner,
> I started to pull this series, but quickly realized it isn't
> based on the current contents of the NFSD for-next topic
> branch, which changes the names of nfsd4_fl_{put,get}_owner
> as we discussed during v13 review.
>
> The upshot is that I would have to apply each of these patches
> by hand, which is tedious and error prone for more than one
> or two patches.
>
> Please pull the latest from my for-next branch, rebase this
> series, and then post again. Thanks!'

will do in v15.

-Dai

>
>
>> +	.lm_lock_expired = nfsd4_lm_lock_expired,
>> };
>>
>> static inline void
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
