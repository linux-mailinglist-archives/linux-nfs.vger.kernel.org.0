Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE85B3E98
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIISMf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 14:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIISMe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 14:12:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05862D5730
        for <linux-nfs@vger.kernel.org>; Fri,  9 Sep 2022 11:12:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289I42jo000308;
        Fri, 9 Sep 2022 18:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SR82Po03UoZCScXm35VjhQlFcXulc4BnF8917HA7duo=;
 b=VmSyC40YUyOPtXnRG8MOFW/P1pI337aRiGYt9itu+EtUv2usIQ/RllcBakIBz1iSbd5z
 SRfESObVKl6zx9D1OC/6hz331cFxz5CijDIaWuGpW5yIH0VOdk6WyRREoGY6AzJ4TYFq
 PM3LuRBDjMVlCGSPBDPBBYZ3u1MZ5kD1nnshIkvlgPfGAqs926rDlCWNpfqKHRMBC8KA
 A4TOEL+SkxuEpl2hjTktEoEz+p2jfyXoGcqVdX4vwxjn5HhHNiMZ/vXBxmvXCuLwo2HH
 NvE5twcRwE91Sm2XvztzXK4YsNKGMprsqK1DdK29/6/97JzWu5t1XYcPY4oF+nibEL5/ SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxht01a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 18:12:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289GBnsb008720;
        Fri, 9 Sep 2022 18:12:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc8j9xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 18:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwAe1cb9CQyNthtlZ5/OAiqcCwM4F0G9LE2Xx1c2mtiFibSNF+aoP5wDxaEGvpvcfquqiyDJQhyRIaQAvu2FzGJDJ3nk5JDpw2uXLtvOVeRhxF7v1WHkFdFyNgLHRv0UaFW8KKQ9p6s/JnpwCh/OvQTSCzq6u/SPZdyhxK6BPqicxxwtU0F6LIbY8somgD50jx36ibV2FcMV+6wklTH6H/aC7kiTd50zCSv/DO3PZGIHbXb523cSFw3CW0Wd9oCnKT7iMcjDKaWSycJiLo1AjzXmySFGtyYRb8x8wAolsiRbceCzWox/fta7E7LkPXMFQ9gicjU4L6FewwEyVt9lJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR82Po03UoZCScXm35VjhQlFcXulc4BnF8917HA7duo=;
 b=almxum+u0DJD+CDfpBCFw/fK68/oMr8aIVfmoY5if/2beAlufnt3i1cwJkljmklcwf5wpdYNWF0gvhUwxjfQn2FJ7sfAahaIuQNZd20SNJSr6aGDKIrTlFECKKk4esE9rBWeLgsL/maYbM7ryCRQcjtVsUEb4MrH6PovPHRucOX4i8dJycSzpE780xi+3+SeII+wd6OETbfqqqBdL0DhXC+UIF09Q0EI+2sec2ANqXdjc/LwICSmj/lWMUlsWShtKubpPO9M5WnmLjCMBN1dDTvkVroqiGkc0oQhHmrO+eTaa/zM6gC2jRHMTSbdoaDHhssQwOeJIq5H9/yjY+YDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR82Po03UoZCScXm35VjhQlFcXulc4BnF8917HA7duo=;
 b=DAC0FJoLXbnYoIq/H1N6Cbzb+A1UtmDZlnckooumXHvzwbtMRYVUWSvEP6TDRXauukZRU56+SO5z9R9gNfiWgDeu3ZEpBUYEoJHrB+jdJMLNk2UXRUmdR1DBsE72brichTAWphR6tggkWYYIxfvWI+4+U0SaTdVNr30Mv4w9hc4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5292.namprd10.prod.outlook.com (2603:10b6:610:ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 18:12:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%6]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 18:12:26 +0000
Message-ID: <1557e8bb-1739-29a4-a04c-c62732cfc7c4@oracle.com>
Date:   Fri, 9 Sep 2022 11:12:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
 <E146112C-33EE-4143-92F7-7515638301D7@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <E146112C-33EE-4143-92F7-7515638301D7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:806:125::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 27815bfb-73c8-43bc-64cd-08da928ed958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpvB50E38HAB+XkjbKg2aULT6csiROd6xo8BadJVVRRUzE9YhkXsPU6efY+3X45QuLfV+Q8WGmMmB8iHMYBn9Pmcdd56Yo8VjuUZU7XW1sj98oLbgkC0kRaDCaltgCMoJlFjToVWo+MwrJePYSxuDcnrZSAYEskwPxv7mmczVRj2drGiXkWQmipkXoVaPa3KNM+4iSI1qnAbbua4sj9yWoQIClEmO38WKWHtYvK/nl/iXqUmCCR29Zg6132CkuEeOfw6ve3Xypip1whsPlhAuThju/jlKVy0Xz0ZOpeYe8/N2YLQoeFqyoXCDiPh3EPsKHtaxguMPbDYQ4NcQKSts1djCbzJiwjGWGHGD44Da36jl+xQjzCA+pM0brPZYrX+RW9Soq3o9Wv+D4nmUCbP/AZnEx/JiekswWY3MWY1WniELHDHkVOywgULSqxtMILo4olxZczCafGtOuOSXRvoI9V2ZqMRrKgAdT+8v6KJHVuqYEIBap8O6KevjaSxABBfnQpJo1Yat7GqLFxZoDIyC6IGiwAVJqWHKMYA9D5MkBuF+fCPKWFq4c4Is1cQTaF9fUzLkiBDqtbF4QN1JJY/vpkV9od7Mzue8xoc7Rkzkc3pEAs1mnuGkCeUr5c0m4TVfqygq1sciI+uQysfug4ZmaH2V/Vz5jJ2HOeKBMrIBhopztogGFO29ShmUd5JDnZtwrhGn4OHv7F+9k6gKi8haDQIZUZ6y+uotyevhFmMPgy50kk6mGgYqdOndEcCEzcN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(136003)(346002)(36756003)(86362001)(38100700002)(31696002)(26005)(8676002)(66556008)(66476007)(2906002)(6506007)(31686004)(6666004)(41300700001)(6862004)(8936002)(5660300002)(4326008)(478600001)(54906003)(37006003)(316002)(53546011)(2616005)(6486002)(66946007)(83380400001)(6512007)(186003)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEYyTFZZc0FHV1dTQ2FFY3A0U2lCR1ZibGlYVEhUYzlJQW1hcFQyQ1VTMEM3?=
 =?utf-8?B?aUxIYlM0S0VZd0lpV0h3RElLSUw0dERvQk9ucWlPRkE0SGZGRk41czgxK3BJ?=
 =?utf-8?B?YjJqa0hLSFRyQmw3Uk1jZG5naXBlRWZUVWVMVlJsS3hFSHBYTVJDbEQ1dXpQ?=
 =?utf-8?B?UjA5TXpSYmtHQlZDaHdmUTlGWUdMU20rSUhUakRhVmYrNHdicXpCamFXSm5T?=
 =?utf-8?B?cDV4bFVsc2JHNFpNd1Y1NGYxV1NnMlVtUEVmL1hxTWkwU0pZTkRKTnVhcTVm?=
 =?utf-8?B?dXBjd0htVTVRTFRNUERKN0ZLaHl5TzhBNEhLSHJqMHVxVUsxaVlhNXNFSzRC?=
 =?utf-8?B?dDFzWGNOQU54Vmp2QzAxWjlqTThCSG4rdWdJRUZ0TzVTQ0NTYzRubEpQaU1r?=
 =?utf-8?B?a3dUNVdTOVQreDgxbUVkeHRTVVMxY0k3ZWlGekVQcm14R3pEZy95ZysxaXpm?=
 =?utf-8?B?RmlXSzNITW5FZkFqK1FZbEFZSDVoclZ4TzlyVDFGOEMxUlNSYTlTeThhUFJQ?=
 =?utf-8?B?KzZkRkdOaVRiNTloSk9ST2FKRDVJUWEzK2dNOGdqaVR2bFNIL1R6M3RudURE?=
 =?utf-8?B?YlMwZFVYaVAyUS92U29xNjVXMHEzSzY1ZFFUQ1VSclpOYk4vb0ZBblBvUUh1?=
 =?utf-8?B?eDVockR5S0NnR3hrUzhMclRMeC9zeVMyWDJ1VmtOcUgvUm5mT0l2SDRvNzlu?=
 =?utf-8?B?RktZakNnZzJjcFdPRElvVURVcXdJenozWU5LZ0wvZHhEUTFQV0oyMEYxSkZj?=
 =?utf-8?B?Mkl5UU9RNTBKYkVRUGxOaHVoNzlqRzlpUlVDeU1UODJQa3pRdVdLb0RGUVl4?=
 =?utf-8?B?a25WSURoM244K2haMitaNlBKVlJSa1ovS2E3cTdoQklHSytTRlVVMmM4Vy91?=
 =?utf-8?B?dE1Jb09sVVBtaWtOZ21OWldHQVQ5WGVFZ3M3U09ORHp1OFNRa0xqWW4rZjJG?=
 =?utf-8?B?akY5Y0pkYjR3T0FFakNqeXRWNUwvZjVLandONjhZTDNqQ0FFREVPV3RGUFEv?=
 =?utf-8?B?WlB1V1htUjN0YXJkYlB1b3FWNVRSTU4waUZLcTZ5SzFrSHBWclpQbWxDdFM5?=
 =?utf-8?B?aGVZMTJXclhibTV0cXRSQjczbUkyOGhLVG14MGJGd2VmRWxSdk9aV3lEeGxC?=
 =?utf-8?B?VVpPRnl4WjcrdUsrQWM0R2FvT3I2MkdjM3VkQkhRSzlqbzJjY0JmRjN5aFV2?=
 =?utf-8?B?clRvZER1LzdFZ3ZhbElLQ2h5SGROZFJYc0FlQlBxamNBcHRuQm9JcmR1QzMz?=
 =?utf-8?B?VG5kelJBdExzNHI5bVAybjlNQmw4MGZGMjNOc0VEUTVwMis0ajJPZ253OHNi?=
 =?utf-8?B?TnUrdzJDaGREZ3Bhd3ZxVFJlYmlySVRYb2NrWlBGSUl6K01YeG9IR3RvRW9L?=
 =?utf-8?B?WnFXcjhDTHpoY1RIZzNNWktad1hyaXBHYWtNYTExMU56YXRNRlZwZGJtNTNZ?=
 =?utf-8?B?OU42dDhETG5NdTJZeS9iL01SVGo0ZFJ5Z0x3VFJ1UnZwSFJwWTg0ZzlKcElI?=
 =?utf-8?B?SE5HTDVHY0F5NVArQ3hWVlQvUnR5b0xhK1pJVVFtUGV0S1hMUFEwQldUb1B6?=
 =?utf-8?B?ang0SGwyREdTMHpqY292S1lIZC9lVmF0UWdta3kvM29RR200YXNhWkdCdmxR?=
 =?utf-8?B?aHdJd2xRTmJmMzNYaDBtL0UwUkg4VVFmRnJiV2VXTkV1aGxFQk5nNDR4Skdo?=
 =?utf-8?B?Yk53UjVjYVBaVlVMZ2liZzBMM29xUjRsVUFBWjdQaTM2K29taU1XZmtmVmdS?=
 =?utf-8?B?cTNuZHBKNCtoMjRLZ3NtamtHUWdGaGFKNlZhTkZMQUhzYSt1ODBla2t2RjQ2?=
 =?utf-8?B?RWdSQWVXcDlXVzNEemJHWnBHaUxaZnFqVTd2TmQyelFNM2dwOE5PVzlyOWdQ?=
 =?utf-8?B?dng0UkVRWkNlSXNVOFQ1dVVUWHg1OGRTdEM2K0dnMVkxazM0a0I1ZU5UVkow?=
 =?utf-8?B?YU5aVjJaZm9MTFdMTGU1UXIva0lvVTY3TExrMExudHYwWC9JWCtUZUxhL3ZW?=
 =?utf-8?B?Q0lxeVhzRG5oMStOUTBSZHZFbDhyeTBhNkxQWFNpejQyWk5ydTVlZnBhYWtQ?=
 =?utf-8?B?djdONVFLeThxYS9hOGJtS3VxVm9hZGt2bTNHL0pubERSWkhZcDI5T1ZUTmhR?=
 =?utf-8?Q?U9eTN7xsUTXcN0kxBUV9DFkt/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27815bfb-73c8-43bc-64cd-08da928ed958
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:12:25.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNUmW+S7mSN3oOd58R3g5x3CTQX4rhqjfWGtwhWRU46hXNdTuqsezYNyVR3zO1bcfbSv53mgdYfC+1lbSnZGGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090064
X-Proofpoint-GUID: u-uS5yG77Gyx6o8GaMBLE2-c_6huQa81
X-Proofpoint-ORIG-GUID: u-uS5yG77Gyx6o8GaMBLE2-c_6huQa81
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

Is there anything else you want me to do with this patch?

Thanks,
-Dai

On 8/2/22 7:35 AM, Chuck Lever III wrote:
>
>> On Aug 1, 2022, at 9:52 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Use-after-free occurred when the laundromat tried to free expired
>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>> copy completed. The sc_cp_list that the expired copy state was
>> inserted on was already freed.
>>
>> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>
>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>> frees all lock states on its st_locks list without cleaning up the copy
>> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
>> server returns BAD_STATEID since the lock state was freed. This causes
>> the use-after-free error to occur when the laundromat tries to free
>> the expired cpntf_state.
>>
>> This patch adds a call to nfs4_free_cpntf_statelist in
>> nfsd4_close_open_stateid to clean up the copy state before calling
>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Applied to my private tree for testing.
> I added "Cc: <stable@vger.kernel.org> # 5.6+".
>
>
>> ---
>> fs/nfsd/nfs4state.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 9409a0dc1b76..b99c545f93e4 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1049,6 +1049,9 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
>>
>> static void nfs4_free_deleg(struct nfs4_stid *stid)
>> {
>> +	struct nfs4_ol_stateid *stp = openlockstateid(stid);
>> +
>> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
>> 	kmem_cache_free(deleg_slab, stid);
>> 	atomic_long_dec(&num_delegations);
>> }
>> @@ -1463,6 +1466,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid)
>> 	release_all_access(stp);
>> 	if (stp->st_stateowner)
>> 		nfs4_put_stateowner(stp->st_stateowner);
>> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
>> 	kmem_cache_free(stateid_slab, stid);
>> }
>>
>> @@ -6608,6 +6612,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>> 	struct nfs4_client *clp = s->st_stid.sc_client;
>> 	bool unhashed;
>> 	LIST_HEAD(reaplist);
>> +	struct nfs4_ol_stateid *stp;
>>
>> 	spin_lock(&clp->cl_lock);
>> 	unhashed = unhash_open_stateid(s, &reaplist);
>> @@ -6616,6 +6621,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>> 		if (unhashed)
>> 			put_ol_stateid_locked(s, &reaplist);
>> 		spin_unlock(&clp->cl_lock);
>> +		list_for_each_entry(stp, &reaplist, st_locks)
>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>> 		free_ol_stateid_reaplist(&reaplist);
>> 	} else {
>> 		spin_unlock(&clp->cl_lock);
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
