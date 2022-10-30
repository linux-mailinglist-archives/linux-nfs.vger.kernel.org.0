Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF3D612BA1
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ3QdL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3QdK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 12:33:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FCA479;
        Sun, 30 Oct 2022 09:33:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29UGDE3T030344;
        Sun, 30 Oct 2022 16:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=O6LBpfU9Bj9s8V/GEqYOM7t1adOIfRqWaYzE20MVg0s=;
 b=Yt7jjH8/J2d5G9IbdNqasjRGosBZbpnwRikapIlpEpeSEKynf7Ih88Lu2o0X2UOjKCRN
 p48gg3qaUmMjWyiHdsbYfkotr2qn6RA1qOEnl/BS+I3iafi4gsA/2BqAzyahJOWrDrOr
 t7p0gqDDjGZxVKVDca5h3VTeRM3c6xNn+gZ9LTXt1Jv5S/uG+tphDOkqQzbw7b4dFjIO
 V/tLs7120/qNZ+PPc6o9e7QSxODXHG/FiqLgat4JObcvJJPQWGQXOrJIv/873lqg4ZI6
 aLb1s361syK7Pe9eg77v4kGurknKSB1SAq4Dc8U42tZXx9oKHEYoiwA5q+SaKuLH4yyx tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd1ug7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 16:32:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29UCbYl5024412;
        Sun, 30 Oct 2022 16:32:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm2h1gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 16:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+Rxm3MObXmG/TvPtguLUBBU8Zleg3XiCBTZv8ipURFLLPc650XBhwvlkpZNbjY+6/FDr13tQnlTlfFoIADz0G4oF3UZdDmomX1NISrh0XLC0dGnAR8MgmbfIpSTXc1IcHsBqSnQM4lD5AL8MlWrUr6wPBqsRthrbRULxm1MmSNR171n5QAd/PwKpIlmTCsCONUpi4T2fYXyvuEkgKrStcEELgGn4NtyulHq5Mx2X7Prph+QmcQw59+0d0nWHp4aiF3+iIdUvtRX30M7khKDcmrPhDqOaG7v1GyypGCYo0ltskw9j0lrpsro1sYGqSaqscqx178wMa12g9aVay/2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6LBpfU9Bj9s8V/GEqYOM7t1adOIfRqWaYzE20MVg0s=;
 b=YQ3ceESE73fZXahHy7fC1JpDkD89xRXVtDqemVzPJmUy+xi0OvkP8zfQDxCA/xlHz2guAqFl6aNrblXXVrqle/CShfz6SNKrXEBZmI4Q9QP8q20LNswovcJS9WhHjB1k13oLEG3Ga0t4A460mdb8JciFpu+DiqzIeUEukhF89Ctst6j6cbxMltxzOiTO6fxrcfnpBuOGyQc3wABEWlJ3TJ0fFr9kM21w6yl0iatEYgozkY5bWNIW/4L/bqOMX0tJqK6+6JYGo33mO4TibZBo8cbdiPhQFkgCtuKqjr92x7gI1L5bLv055fYlOWbUUaLAzHXFDR05DbKVeNBxU4eTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6LBpfU9Bj9s8V/GEqYOM7t1adOIfRqWaYzE20MVg0s=;
 b=QLwjxy4sNRWooi5qQHDQP60Ux7n5gRuS4kRK8tfMkDuuOTcaU8J1BGzfAPV/ZPP+eNkx+m+gYUUev6ipB7hkqCNTbd8niXA1HZu8pftVpbVl2Gix2uRQZ49f7Spu/MIV2A79DIAVTauEn7jfBjkruCS9srRowKjNFWq9fGomLGc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4238.namprd10.prod.outlook.com (2603:10b6:208:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Sun, 30 Oct
 2022 16:32:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8bd:d43:8279:fa67]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8bd:d43:8279:fa67%6]) with mapi id 15.20.5769.019; Sun, 30 Oct 2022
 16:32:54 +0000
Message-ID: <07c572c3-bf4b-fcca-9a15-a8b4b627af46@oracle.com>
Date:   Sun, 30 Oct 2022 09:32:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] NFSD: Fix the share reservation conflict to courteous
 server logic in nfs4_upgrade_open()
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <7ed2d8f1ee8c441a13b450c5e5c50f13fae3a2b9.1667114760.git.christophe.jaillet@wanadoo.fr>
 <FB543B1D-A3BF-4403-9BFD-CE3AA40A89B5@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <FB543B1D-A3BF-4403-9BFD-CE3AA40A89B5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN2PR10MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fad9dc-1d12-423b-2329-08daba94655b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHvtBj7xwpWasbiEcAN9lb67hXMF6xSL7lKhCzzC4F/XS+gAVP1e5aLoZOPZ2Ot3SWRhAjisn+ia31xnRMMkwD1PVGkVObJipntQigyfdPX+11iGAQr3ifoYrZQnXhF02iwC4kCHeWmXdp32fGr8vm3oApaCvGJb6YTMrgL3ImjvxKAlBUuVtZFNToFV84kolpKALmyYyrXnu8ZHhhA6Qz1pWydWVqOHhaXAR9EVR6YcmU7Nqjm3O4KlqNRmnx+I7/dGSXLvGTLBAYSADlBi1/+wHMA0K7s0npvQfnTHNVQB8oxtjdfDy0WffHMXbWApg6mqqKU67DhIgFRObnEB430GK6HcvA3LXuPpz0vTv/0/D5+3ttzcgXzFFuAHCHy8/yw+tUwaEbsO60IRg/iRi/ynyA373N79nEVAjAkiIRIGCOvI+zZsXW98k/Nt1eku33JpJxU6Tq5HYFmIOljCuaNFejAcjllW3TtgGt8xxM3EnAiAgcpCeCyTv2la1BcjmbwnUdSmdbiPMR2K3fgThXKXEOZMPAiVdewUaVAwewQmtwKo+wYtEyAvbe3s76BrUFwzw+qXEnB1ebGuCfwSMCJ6B36IRjr3zBhMBZ0nP0Y7sxEHFgpbPRdQglfY3W+GXNfhMUTFCf5jw1s+jVZQEMbwlxgu+pY2a4QC/iPc5A2jFtyYDsBszt/ZbYMaJARTy9wCx04Ie/cvSBWZAr6nm+XVU2pQozBIopDf0VqTfSNO9UjMJ/3v2xaTbhLWXbgfy06/KrdWrjbKKVCmTxUSIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199015)(36756003)(31696002)(86362001)(38100700002)(2906002)(6486002)(6666004)(478600001)(4326008)(8676002)(316002)(6506007)(66556008)(66946007)(8936002)(5660300002)(110136005)(66476007)(54906003)(41300700001)(6512007)(2616005)(186003)(53546011)(9686003)(26005)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QURkWGJMWDdacGx4aGdsVzVWaTFMc2NDR2I0U2JKWlA5SFlEZmxJSEZ5cEQ1?=
 =?utf-8?B?bFlERHVWTTJxNXRkcHh3dS9WaVJJc09PVFJJczhLRGJYRkdQaEhhRml5Q09m?=
 =?utf-8?B?NW94KzloVWNzbUpMVmUzMGMwRWxYY0dTcVVkNmtITVIzcXIyaXY5RytNMUtC?=
 =?utf-8?B?M3hBSElwWDBUQ21pMkxRY1BzTWdWSGJ5L215ajZzV0JFRncvL0RWK2V3dmgx?=
 =?utf-8?B?TlVEUUxDUFdwRUZvY2pwZ1ZDUWRKVk5Wd3RzMklTY0pINVBVTDlQMCtNYXEy?=
 =?utf-8?B?Kzk5Y2RtS2NndUZnNkprL3VPNitBNjFFV1g5K0M0SC8yOXkwS29TY1VpeE9z?=
 =?utf-8?B?WlZ6blBkWFNab2swakFuTUxuaWlsays1REE3YWIvSkZLMG9FWnRFamlrbzJu?=
 =?utf-8?B?NmtZdGlZN1R4STRWRXFpbU1mdmRuZGhiRldGdEhNUzV1UW1GNldoczBSUGVm?=
 =?utf-8?B?RngwWHR3ek1PS2xzREV1SEVhcjFkREZHb2UyU09xNnY0NFljem93TExmSGVI?=
 =?utf-8?B?R0FqQXBOQjdLMTBBSTJsZ04rU2E3bjJyd1hrOGN4NzhlNEpCY2ZuakljcWl4?=
 =?utf-8?B?cVcxNzJjNUg2Yk9wdzRPMCtRYjU2d2xBUkpNSUVKOUdtajNSRWlLbUFHaktw?=
 =?utf-8?B?NnEvb3diYStBeFB1YStWOUZnNDVCS3AwT0JIMU5XbmpNSWk0bjhaaVlaOWxw?=
 =?utf-8?B?WHR4alM3RlVVNFRYMUQvdHNuMmNzMnlYZ0wyMGNEWm1vN3ViZnBTN0Y4Nzdz?=
 =?utf-8?B?UGEzZzBBaDNGSEdrbVYxYzF3Y3o5NHRndWhxMy93dGRwenRoQmpxOW1od0Rz?=
 =?utf-8?B?UVZTbEYyYkZTc294Rnd1blJHQzZ2dFpTc2w0a28yeklGV3lEQTQ4MFlRYVJy?=
 =?utf-8?B?MlVmSGlibGJmdC9aYkJZdzlrMytCdGt3UllCVFFOVThwYW5qTHFERXlPUDZG?=
 =?utf-8?B?NWc4VGpKY3I1akNaTHZlNWpxM0JoQVd5SWVtaE15VEVYTm5BUmsxcmRXOURV?=
 =?utf-8?B?QXBid1VXeDBxSS9ReVN2cU5aM1RyOU1zTTNzU1dMSzdGU1RBeWdRZi9VY1Vr?=
 =?utf-8?B?dE11OTZJSUJLUnRkczBIblNjelp5VWhmNDZnTTgvdzhlZzJIK0ZzQkgzcjJP?=
 =?utf-8?B?b3dtRTNtK0hINnRzeGFJYVR1S0VFdjBnd291R1FiS3RvWGtTN2RCTENjRmpC?=
 =?utf-8?B?RWF5WC85SlpuOS84SlBHMExMQlR3cit6azQvU251SElyYkprZGwxQU1oQ2lO?=
 =?utf-8?B?bFZERG1iSVBZc1BkZzd6YmlGa1RxaWlKMmJnT0ZIbmYzMjJNZytIemNMREF2?=
 =?utf-8?B?SGliK2JhVS8ySUxxMlJqU0hubXlxVm5Xd2RtMktBUElLU2t0QWU1UHIrTTNV?=
 =?utf-8?B?ejBnczFaMzNEa2pUQmhwdTRRUUdrU2N5NWFMd3lRRldXTWZLM1VsK3Q2SmxB?=
 =?utf-8?B?UkhiZURXV01FUTV3Q2Zxb2t2MTUzSFJUZ3ZRaTM1dFFpNVVsU1hFK1F2L1hv?=
 =?utf-8?B?ZmFlaEZUd0ZSYjZiVVFKNTNUUnpwdjVnYkxZUXJHVUxJOWxrMjBoUEhmSmJF?=
 =?utf-8?B?OFhKa1ZuV01zRkZ6WldFKzFvZEp5N2pKM2JCL3EybktrMXBBTFhMZnkvR3do?=
 =?utf-8?B?cENHZ0prcWUzZlhpYkJ0TG0ycnU3U1gwbTA3SHQzdU1QUndjMXpJb014Y3pq?=
 =?utf-8?B?ZngyOWhGdjdDZHpYR1FjclpXYk1DK0U2WmlYaXhpUm02c0UyaDUyTk1DZ2cy?=
 =?utf-8?B?UlJjNTRoUjUxS1BlenlRT0N3NCttTFJsVGtINTBGZHhPVitVWXJDTGxCUHBt?=
 =?utf-8?B?WE84QWtRcUhrNXdheHlVa0JLVlJTWHRFcG1PR3NSeittT1RlZGU3U3hUUnVQ?=
 =?utf-8?B?RHEwejJsSlFzM1NnZ1M5c2U0RkRNUTN3RG9BQkNSWmttdzZuK2hwc2JqZER4?=
 =?utf-8?B?VzhUZC9nNW1kWVIxL0c2VEc4UU45NCt1cEluazV5bWpBeElUa3VPZkxSU1FL?=
 =?utf-8?B?ZnZXSkRRZUxBaGdlMVgzbmxGb01LTXdRTm9BMERhb2J6c0FuL0YzcW1wbkcw?=
 =?utf-8?B?WkRXOG5QejFwZUhwV1Zqb1dRV2xaMjY1K1JqT3doVXZ2WGRnWEFlSGVZUW1I?=
 =?utf-8?Q?k6woPXqIbgldXJ2GMfzY3BgmU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fad9dc-1d12-423b-2329-08daba94655b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 16:32:54.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiYnIhez419ksgUu6gLm68+0KZ5tKepRUSGqiY4+NfeUO6RuTguXrOIcB3MNUPFWO+SlrkbNxUV5oMGTzZ7Udw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210300109
X-Proofpoint-ORIG-GUID: 96cNPz6YmxrEwJy90EK5Kyg7p-V-D557
X-Proofpoint-GUID: 96cNPz6YmxrEwJy90EK5Kyg7p-V-D557
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/30/22 8:26 AM, Chuck Lever III wrote:
>
>> On Oct 30, 2022, at 3:26 AM, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>>
>> 'status != nfserr_share_denied' is known to be true because we test
>> 'status == nfs_ok' the line just above.
>>
>> So nfs4_resolve_deny_conflicts_locked() can never be called.
>>
>> Fix the logic and avoid the dead code.
>>
>> Fixes: 3d6942715180 ("NFSD: add support for share reservation conflict to courteous server")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is speculative.
>> It is compile tested only.
>>
>> REVIEW WITH CARE.
>> ---
>> fs/nfsd/nfs4state.c | 14 ++++++--------
>> 1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1ded89235111..de0565e9485c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5260,15 +5260,13 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	spin_lock(&fp->fi_lock);
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
> I agree there's dead code here. I believe the bug is the first check is
> supposed to be "if (status != nfs_ok)". I will let Dai have a look at
> this to confirm.

Yes, it's actually a bug when nfs4_file_check_deny returns
nfserr_share_denied we won't try to resolve the conflict at all.

Thanks for catching this!
-Dai

>
> But, in the fix, let's replace this logic with "switch (status) { }".
>
>
>> 	if (status == nfs_ok) {
>> -		if (status != nfserr_share_denied) {
>> -			set_deny(open->op_share_deny, stp);
>> -			fp->fi_share_deny |=
>> +		set_deny(open->op_share_deny, stp);
>> +		fp->fi_share_deny |=
>> 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> -		} else {
>> -			if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> -					stp, open->op_share_deny, false))
>> -				status = nfserr_jukebox;
>> -		}
>> +	} else if (status == nfserr_share_denied) {
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, false, stp,
>> +				open->op_share_deny, false))
>> +			status = nfserr_jukebox;
>> 	}
>> 	spin_unlock(&fp->fi_lock);
>>
>> -- 
>> 2.34.1
>>
> --
> Chuck Lever
>
>
>
