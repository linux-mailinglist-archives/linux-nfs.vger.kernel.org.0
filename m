Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2946587157
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiHATXF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 15:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHATXE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 15:23:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB73892
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 12:23:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271Hs4LM010181;
        Mon, 1 Aug 2022 19:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JLAf1wqghz7q7a+MCkdr7DNNG1WYex59d1J3uh562YI=;
 b=dq2ClK+ce4p+cuivAbJ9Ku0j/hHd3WrcHCihkGrd4LcnuCJgsuWhUpLREsJxO5lohYFS
 aTf2UG/hmpZnKauLV1AAxZUxAtezDkqfnWZDP9znkMLWvOe4687iAUe7NQ5q35ftJILS
 1rEPv2bq6R+qUtNK/c4WMOG8wPYC37Hg24HSOzZwHW7vgqNqLQvS/iFeKzcGZkF7nlE2
 gk8Mxw2shx4PzgPkE4+BvbZQlms0m/KQJUF/ZrnP5Gry+snUPKmE/7MzR57PGG5Bprve
 AZ9Mna8c7SCc+xR7AdshjHEOnv9JNsYwVLshClVR6TFX9WRxp7l//l+29YoHA1KHdz6i GQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2mr3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 19:22:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271Hr5Zg001056;
        Mon, 1 Aug 2022 19:22:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57qgjnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 19:22:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSU130IiZ3Bc4qLhHS5jh2GhWuIhRxKsQltFxAw/VCFtC4BCMcTW5jAb3x6jGnTBqSpJeZyuPYRt0PFS3GgxggNOVCWnCmY4FiPMxlddsPdi0En9/7Y679mYU903wSEPHEewC/XJehzNJ0UxVC3GT+IcbyGz+LLbyusmGpXStvFErQ6HsuyovGFWtKa0V/l3BRPOC3OB/1+Biygkq1mWnrLqw8c4kKJBKOMyIlCo5dgdpMArfzZvD7rJlCMig6XpxPzQlmA1V+PSY9kgaZCgINhz8YUfMKsoh/B7CeOeORaL4TgTTnbCrohKKlZb0qnr44hPJZeKOYePNxv1+mI+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLAf1wqghz7q7a+MCkdr7DNNG1WYex59d1J3uh562YI=;
 b=FHv40DZ8YBWc4nNXSoeqIkV1c/jxkNl5H8L4aE9L80U1LL2eLE/nsEcXO2ed6Ay7Q7PRIooKhP0F4UxTiNjRwTMNiUZp5QRDuGCyA6jXusCGBUa2bWoQCF2CjB8Ci9pb/BLXlPD+wsJ1T3ik43/uGlvwtqEWSVVGMVn2LOFyj8jhlOkY/gCB8vJjgXdDjPMd1+jNfGaCvjifgAcyfEaZ9j25lfNmDFgWIf5+F6HgdbPY/ILWOHihiSk0K3GvnkiSmw4iKV+83c+PiQ/kGKTWRzyNjqCLgdwgTQRTh692RDOAvs+Pnt9kHKyadCAC5026vOxNxQkPInWMcHPslBN+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLAf1wqghz7q7a+MCkdr7DNNG1WYex59d1J3uh562YI=;
 b=V8BvLcjQHN/ccopkC1HYdjvYgLnNskcjiIGQOYiiOLN9+3bdY3CBOW++zY4o2HeeJrMI1IzDHZSvcJkXXjEGjdtQeYmRC4ZFs1Mw0zl76OaEptx2ILQk6bSHu7WY9rZrebdonIXPG1dOvbR5tm8A4BZwsUIdh3yUR5odSGk0DAI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 19:22:55 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:22:55 +0000
Message-ID: <e8bd29c6-7d68-716f-1ed0-9f58436371c5@oracle.com>
Date:   Mon, 1 Aug 2022 12:22:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
 <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
 <c969d149-36be-a161-2b2a-469dbf7b9bcf@oracle.com>
 <eec78149840c74bd7b8f2ac18c9f27efb5bcd54d.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <eec78149840c74bd7b8f2ac18c9f27efb5bcd54d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe5d8e4f-125e-4f73-adb7-08da73f33c55
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZWFNysJGXF/MGIcQ55Chlh6MzOGkwZSzkFffMkkMjzHeElvdsOT69fB80lpyAs9d19vIigurnQyeg9j+cDQGQCfb5ACOPoQfOMh4M1fjzAbbyGgRgHfLO172CCf8RjCSA+Eqvl8s4XqS+znnawfulkyjHFRfcPyTFpCVTr5fUlrkA4y/NY8nE1hvGAEBqsyAGf40PTRro8+s58KKSsyLeQA+lQblu+Y/3B2g6LYhSlv9LPAoFDxvX/QePNP3a+LL17T7/bzGB7X2oxCDoq2TGHdCWFmWpIIAOCFDHYf7o5KkTVaUhJFxOxV0R7pRh7R6++MHb1+Ev2vH95+sqM5+7kORC1PetSo3R5NVJUiJSJn0NXNGEJE0SFWFkshzYRGRxD0zylwWeIYi0NzRfySb4wjOObiiftxNhl1AqyMLn5+XmeFzpMalxVr/Q6idFr37O3l+lCnMpDHzWQCRsMqzt7jwxQfnmRIrGftv9Z70sX6ApHNsC13s8/sVtDSqj00s+wMuO5EP8FRZO0oig+cN9oZFrAtGT/xpft34678Kbym2zmZyIdk9sRKMb1brmTCSy40QCOsQOD4hpv2JS98unbScHFTLSguM1IsYGWa5T+t774KMp4r/054ga6TTBAE0jGhM2b+RuUe0wP0GA4ODjPM3h3yWF8VdMQ2GC4g5Sh7hfQR18E+s7FrpdzNYKCi5afmEJe6JTdCLdaWGnn568qG4dBF8idxuAMhBYzF3+0PRM0ybbQ578YYscgzlp/B16f5tfgd1rY/tg0/vI3tXEZO6kTEJp+T1FYJxHT+NSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(316002)(41300700001)(53546011)(6506007)(9686003)(6512007)(26005)(36756003)(86362001)(31686004)(31696002)(83380400001)(66556008)(66476007)(66946007)(4326008)(2906002)(8676002)(38100700002)(2616005)(186003)(478600001)(6486002)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmlicFNhL1h0M0JzUU1LTnY4NlBkb1ZvMVJTbUwwWk45dkpPVGIrYnJqZWN6?=
 =?utf-8?B?cXUrZlVYMCtqQzlUUElGS0Y2SldTTzkwUEpYc3k1NkFUbVVmUFFUSzRYSnlP?=
 =?utf-8?B?UXBTdFcyRnp4dGQ0ZkNmeE4yTHZjUWl5RERYdjlGYnBlYnFpNldtZXFpUzdD?=
 =?utf-8?B?R0J6ZVFxQ1d5TWk5dVFzUFlTT2NrZHcwa2IvVkhWbzNzSkVUYUxQeW8wcWNO?=
 =?utf-8?B?bkJGSFMzQmZ1MUlkTlYrTG9WbjlRaW85K0tKNkZuSFlONG5KN0lXb0RVUmIz?=
 =?utf-8?B?Z3FRa2hOMnMrREpMUnFRLzdnT25TQUtYT01wV1FpRThMUmFMckpkVHdBYjRx?=
 =?utf-8?B?bEI1MWFiMVR5bzZRcW1jSTNta2s4QVRZTE1ORFNGQ29vMk1hQUlEYUZWbDV4?=
 =?utf-8?B?QXBWdUFHaENocXc1WncyS1VZaEx3L1lyWlVUQ1pVWHQxTzNoMGNvYzc4REpn?=
 =?utf-8?B?UUdnTTB0R2hhSDdsdlQydHUyeUZ5MDg0NUxKM0kwWkFKUkk3ZTNwTzhNSTRG?=
 =?utf-8?B?VUtkeXBsazFieGxEcXh6Q2NEajFabGxJRG5jNTJ4dHV1Mnp3SEJTQVdWc1ZE?=
 =?utf-8?B?WjRmaGhNUENkS1dQbldiWStJdlY3anNwWTUrY011a3R1SGs4QkVjdXdwZHYw?=
 =?utf-8?B?REpDZmM2ZXJOd1BlNFVITzFHTGdqMHlzQVF3c2lyMENpcGNjZzJEK0FWd3Zw?=
 =?utf-8?B?ajNTNGpBMTR0OWgrT3VnZk4zUkQyQkIva1hzUEhTNW0xQ2lMMlhFcnk4cTlJ?=
 =?utf-8?B?Wk02T05OY2ttQ2NvLzhqTVFYczNyc1VMYnh3Z2lIVDN0ZEcxNUVUYTR5aEdZ?=
 =?utf-8?B?TmpCNXhRRmJwQUlSeVhWUW02dWl4TTJMTmp0cGFwN2NtVVliZUdiSkk4RE1H?=
 =?utf-8?B?WXRyTGMwQ2FvdW9qKy8xODJ6QkUzcmdWMmZCeEIwbi90dkxYZmNndXh4RE5z?=
 =?utf-8?B?c2tNOHk2OURraXE1MlNINXltNU9QTm5LT09IMlRBOUxkNFRGbDZJUE5EUjZB?=
 =?utf-8?B?dk5zNmpLNnRxRTlSVGhxNUpZZzBYYjNBcW5KVDhhVVhzbVhKaXBsT1pBWWtV?=
 =?utf-8?B?bFRsbGFORUZIcGpjcWpJbm51dzhLY0ZSOXVuZXlIVW5wc2EwVzYyMlN3ZEhK?=
 =?utf-8?B?c0ZrVFRGRDFST1BXR2pEaUNUdFE5ZkQra3YrUzArRjdQY2YvWitlNTJIWHl3?=
 =?utf-8?B?cTlBYU9iT00vTm1vVUw5T3REVmwrUlJmUE8rNFFLeitqU1B3UUZocThZclZW?=
 =?utf-8?B?NVlIMEtVM1dUWUIzZFMrTzgzMFVDaENkcE5WNmVwU3BNSC92V1A5SUN2UUli?=
 =?utf-8?B?YlZ0SjVYeUJGSDRMK1Q4eEJFQmFWR2JiUkNRY3lYUjNrMHJMZm1FNXhkMFMw?=
 =?utf-8?B?TExtWURlRUU1MHgzUUlpTlA0aGQyOU5rYkNjcFRydWxuczBlaGNvdDYrZnRI?=
 =?utf-8?B?YURzSlhEUEN0eG10WjlzMUZvSHc2VmFqRDIza3o5djQ2VkhKY3RDeEVUQ3VI?=
 =?utf-8?B?Y3lyY0taM3BjK21iVzRTLzVBMjFpTWtEcTRXSjhCc2lNQ3BKREliOHBlYkIw?=
 =?utf-8?B?Rm9lYkRIS1gvUndnMjZ6UVlrQXNHcVgycXpPaHprL1UxUk9qc2NNRFZtb1Jn?=
 =?utf-8?B?ei9wenprOFpYd2JZTU00VjRpYmJUM1ZRemIwWkJkN2I5a2R2U2UvQmYwOFAw?=
 =?utf-8?B?Y0NyU3lYRlpRbmtEb2g5VHFqQVFRZ0duQWNhcVB3ckorMy9IOWFiUVpmZTZT?=
 =?utf-8?B?YXRNM25UNUlTWGhFN0hienBieU8yNGpCSkNQTmdwUG9zZ2UwTCt1WnVIQ1dy?=
 =?utf-8?B?SHFLdkwyVlhBKzhHdWpWbVFVZUpRQm1OMmF3QkkyRXFlU1A1enJvQXJOVnNi?=
 =?utf-8?B?RW5aQ3pQU0hOVXAyNVZwcnl4NWs4L0FQOVBCeDZkaHJTbnJScVIweGpTemhk?=
 =?utf-8?B?NDBxUFN4eFFDSUNoNWtXVHR3dDl4UmtVZHZqQjIrNlJZa3d6ZmFpZ2JmYVlS?=
 =?utf-8?B?NzcrczFxQTJlcHcxVGoyY2dNeG1mUTIxclZ2cHZicDhGUnBEemNhTlhCREpX?=
 =?utf-8?B?V0RqMlRpNlYvNDdtakJYUVh0VzhZT1JIcUIwNzZPY050OGdubEdYL3Q5cC9s?=
 =?utf-8?Q?GC0FUP48XMEDDdIj8JaAWk9Wd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5d8e4f-125e-4f73-adb7-08da73f33c55
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:22:55.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QVyGNGkZuBRvuhw8IftIgl+qQ9HOm+Zud5C6qDnQTBMH4L5J3sV+aZ3uDKB4k5MiPs5OyuItiV/xiA44sNf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010096
X-Proofpoint-ORIG-GUID: d39gSmC0VJPstFt-9bmR3am5Jk_vyRXe
X-Proofpoint-GUID: d39gSmC0VJPstFt-9bmR3am5Jk_vyRXe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/1/22 12:10 PM, Jeff Layton wrote:
> On Mon, 2022-08-01 at 11:52 -0700, dai.ngo@oracle.com wrote:
>> On 8/1/22 4:47 AM, Jeff Layton wrote:
>>> On Sun, 2022-07-31 at 13:19 -0700, Dai Ngo wrote:
>>>> Use-after-free occurred when the laundromat tried to free expired
>>>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>>>> copy completed. The sc_cp_list that the expired copy state was
>>>> inserted on was already freed.
>>>>
>>>> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
>>>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
>>>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>>>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>>>
>>>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>>>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>>>> frees all lock states on its st_locks list without cleaning up the copy
>>>> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
>>>> server returns BAD_STATEID since the lock state was freed. This causes
>>>> the use-after-free error to occur when the laundromat tries to free
>>>> the expired cpntf_state.
>>>>
>>>> This patch adds a call to nfs4_free_cpntf_statelist in
>>>> nfsd4_close_open_stateid to clean up the copy state before calling
>>>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 9409a0dc1b76..749f51dff5c7 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>>>    	struct nfs4_client *clp = s->st_stid.sc_client;
>>>>    	bool unhashed;
>>>>    	LIST_HEAD(reaplist);
>>>> +	struct nfs4_ol_stateid *stp;
>>>>    
>>>>    	spin_lock(&clp->cl_lock);
>>>>    	unhashed = unhash_open_stateid(s, &reaplist);
>>>> @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>>>    		if (unhashed)
>>>>    			put_ol_stateid_locked(s, &reaplist);
>>>>    		spin_unlock(&clp->cl_lock);
>>>> +		list_for_each_entry(stp, &reaplist, st_locks)
>>>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>>>    		free_ol_stateid_reaplist(&reaplist);
>>>>    	} else {
>>>>    		spin_unlock(&clp->cl_lock);
>>> Nice catch.
>>>
>>> There are a number of places that call free_ol_stateid_reaplist. Is it
>>> really only in nfsd4_close_open_stateid that we need to do this? I
>>> wonder if it would be better to do this inside free_ol_stateid_reaplist
>>> instead so that all of those callers clean up the copy states as well?
>> Yes, we can do this in free_ol_stateid_reaplist too, I tested it.
>>
>> The linux client uses either delegation state or lock state to send with
>> the COPY_NOTIFY to the source server. If the server grants the delegation
>> in the OPEN then the client uses the delegation state, otherwise it sends
>> the LOCK to the source and uses the lock state for the COPY_NOTIFY. This
>> problem happens only when the lock state is used *and* the client sends
>> the CLOSE and FREE_STATEID out of order.
>>
>> free_ol_stateid_reaplist is called from release_open_stateid, release_openowner,
>> nfsd4_close_open_stateid and nfsd4_release_lockowner. Among these functions,
>> only nfsd4_close_open_stateid deals with lock state that may have cpntf_state
>> associated with it and only for the minorversion > 1 case.
>>
>> nfsd4_release_lockowner will free the lock states but if the client has
>> not send LOCKU yet then put_ol_stateid_locked would fail to add the lock
>> state on the reaplist.
>>
>> I'm ok to move it to free_ol_stateid_reaplist if you still think we should
>> and don't mind a little overhead on the unneeded cases.
>>
> If you think this is the only way this can happen, then the patch you
> have is fine. In that case though, it might be good to have something
> like this in free_ol_stateid_reaplist():
>
>      WARN_ON(!list_empty(&stp->sc_cp_list));
>
> ...to try and catch cases where these objects slip through the cracks
> after future changes.

Good suggestion, I'll add it to v2.

Thanks,
-Dai

