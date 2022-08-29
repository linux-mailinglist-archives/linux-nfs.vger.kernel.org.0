Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683A5A5437
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2SxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2SxD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 14:53:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20CD5AC49
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 11:53:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TIfnKV006694;
        Mon, 29 Aug 2022 18:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TZIr0TI/tp4uSu9QNzY9xcWcGadDFQx+LiH6sY2QLLY=;
 b=t7uBW8XeCCpwZ5kGHMV1Ls7sL0Xvl+/lQ3CWG1l7GSQloATjkeOB3AJb3TrKGSPz48Fr
 XJeTGP45IKwnW6csh9I6u6RHe4MHScy1js8PSj+A0F+rzVjFT6yp2NxgVfSUPJqtYlPX
 9+KlRBLGbQd1GN+e7yXq3fL2VzTHzgp7IwRxQIyYGTManrBPGuRhTlKENpJjbpFa+i+T
 kPGUPc21JbgG6oOmBYLxm14Kz/vzWS6n5yNiBm9mt0NGEUnwkck9veqhQbTOELPLpdKh
 D8x8wZywomEKEBML2xaRflUzggPxXeceo9jvaNUwrOOjg0AQADqH/r3AAegN6WowsfHT EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsc8vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:52:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27THYPZv038267;
        Mon, 29 Aug 2022 18:52:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q92g49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4twJFS4flov0DOs9ppTnv3LO6ZuxB/c8UZ/Kyy4cyEu544RMxGyHC3gq1/qDn4Vauh0Q/Lh3BfQoz2LYym3wHggy6LdAYy+crh3VdlcRJp0SC72aIWUpk48LiHiwMz7Z0Pn4kmfmrU9VG8EsU6H7NEjBNCih2UAhesnntT6blmtLLMInjwXfmgG67C9CwevE1qy1NhOCNgY4BmKIepIN1bP6Q6wT5om1GXxAd4SsMvPjn+3fAFxwTRwAAyBBqRYuntNECoyyBi9xW9L8sRrDt6Z103+g16f7haHFY5JL55GxKIWcMVzCdEGr3WPrJc6Jt37nh7Q7/1fIcqGRHf1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZIr0TI/tp4uSu9QNzY9xcWcGadDFQx+LiH6sY2QLLY=;
 b=DlFRktEbDELbA/EshFA6UQAX52lIuM+zHJ0zK2IhheDcQ6R95JhZmn1/olNHFN42UfxkPONpuTEKV2fSEeiRfSUUmdO/PWx0uxvu8Pcp7CSQolPGt1G3/5aum5Q/cey+HnamHhnr92mh+3/XPgAG3s64sP+YcBqa/8IwqK5tdcXD6JrN1hevXq7ui8qhnlJ/UPHh+XQ7VkFu2G0xwQ5nPyYnpgGNXUaK5pvpVlzWdwJnkmF5WipRqQK0FW6PgrEdpwQfMQ0u0QAQZTBo6eHP93FKXyqhpgnLPmZ+9Eq00Jc9ZXIhQpoI2SCrk5yB7wSmOpq2laR2jwY+oRJ478VuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZIr0TI/tp4uSu9QNzY9xcWcGadDFQx+LiH6sY2QLLY=;
 b=YeFxjGc/ojR8bSUu8iyeThM02QQGZC1SHbvC9IXy8rJgsUBUl5wcVm1kedE1nYct3yp4HvE181Kck1D0016c/jMGgXRyIq/DrK4XjIbM6KXAMfTyBrQtHkkQo7lqxup5lXzkHkflyco+qQXO1AlVDqaM7KH9/95EtxoclOUtOQ8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN7PR10MB2450.namprd10.prod.outlook.com (2603:10b6:406:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 18:52:51 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:52:50 +0000
Message-ID: <80aef835-89cc-f5f6-0ca9-234815cc3ae8@oracle.com>
Date:   Mon, 29 Aug 2022 11:52:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1661734063-22023-1-git-send-email-dai.ngo@oracle.com>
 <1661734063-22023-3-git-send-email-dai.ngo@oracle.com>
 <b12994817cda7d9509767182edb1b1f21697648a.camel@kernel.org>
 <94838eff-af62-8ed4-05cf-10a9cec6a473@oracle.com>
 <b038317d230490bf79466ee74fb837e37e5ca25c.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <b038317d230490bf79466ee74fb837e37e5ca25c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a10250a-73ee-4e60-25ca-08da89efabdc
X-MS-TrafficTypeDiagnostic: BN7PR10MB2450:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xSt6ybxEt+1u8ZoErTASJmyDhNhKWKb0hIbt1qGI5U5aLeSoR/e2StyKRGKTo/NhIKDAN1VThUTNLQFSiKgUmJ1K597Ou4g7YZXwzEwt48EfiMq1e0f2D6AitjDKMf5cldH2dtwK+Y8tn5QWWwM5b/7sVB0Gx//wsEWFabdbGZo9aw6m6Dhk8nHGyzPGpIDJELaBe1HFbpDPEdon7/79mFRN55pcOrS+cNkpjp7X75RRWDvtc4FElNOXX4z7mgz97gYrELpZm3/UUUQ5UOSBsqxyflfkw9mwW866D7gsP8c1XaNJeETrCVbeAXsNd/VlSYfvFRaa84I2appnJShXp0Zm3cqAmTHdiw7GP6N+NUxqqlaMvvipdFzI6LVFYpCg4TgyJMWyGgBMaLVCCEimQJ/8RD5HCXVUGU427uQ0aH4c60z3bcfLGJdjnrV894reTPbWigv51ee68O9d7qURVP+tjh91gekLrCXQNc61L2uFryZEn0o+g4iXFiqK3haq4Rl+MdCH2qC6r6wLmqVc6iN5A4bD9yeLr2NgNQTTyIQ0XKRPpL8xemyPevUSQE44qkB+6iuW5QX7ZdJxu3R97HFlc56Bde/i9lE/3UkFTyNo0MFwDvG+M5Ka2OW05+mQg4/CoT4ojYyjjfDynpMkadLB2tcgmpWDLXhCGgL1/Q5CDfiDwCHsyfz8NObGVJxyrIFRT/978oq5qAMlsJs3ayzk1L3ZSxQWEjIRpogjEX0r2zsn8zQ6aV0owThYnElVnUkm5+7wg+AzX8Irx55rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(31696002)(83380400001)(36756003)(186003)(2616005)(86362001)(5660300002)(38100700002)(6512007)(4326008)(8676002)(66556008)(66476007)(66946007)(31686004)(2906002)(6486002)(41300700001)(478600001)(6666004)(6506007)(9686003)(53546011)(8936002)(26005)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0xCeHJtSDJMRThiS3lGNEVBemlwMFo2OHJ1WHNDaG9leGszWHJxVkhicmRU?=
 =?utf-8?B?V0l6VkpQeFFZUWljUHduQjgvT1FPR0NTbmp6ZGVuaWt1NEFOZFpiUldVRHdW?=
 =?utf-8?B?YzNRS1ZLLzNSYkNMM2ErT25XSThNeWhTQVlZNWxpNzRiSEQ1WWpYNWFvSlZs?=
 =?utf-8?B?VEVObzlZZyt0RTZNblphdUhuemRGdFBqUjFVVmprUmIranY2bmV0V2dtS3NO?=
 =?utf-8?B?R2cyMXVoZVRzU0JiZXFYVWVJSVdYZ3RiaGV1Z21yc00wTThRYkJZMG5WV3B4?=
 =?utf-8?B?ZHFyaGI5bXRrQ0JXRERpbFNVZmdrWGxEVnoza0NaRll2UnJsWHIySmlSc1FJ?=
 =?utf-8?B?bkVISXFrMFFya01xaHAwSEtpUk10MU1lTnpqSmFqcXd5V2dKRFNQZ1BJVlUv?=
 =?utf-8?B?b2Jja0E2V2c2K2dPWU9Zc29ZTTNXQXhSZjBzZ25rNmtZWWpBQ0Z3UmROUzFT?=
 =?utf-8?B?N0xJTFVFS0NsNWdLdm5NZ0RQZ0Y5QVJnRDgxYzdSdUFGTmljM0VBYmRzK1V5?=
 =?utf-8?B?MXUzcDJZdWlrQ0dmMldZQWpIQ0RYdnBESGFqWnN3N3UvOFdmSVZteVBFeHN2?=
 =?utf-8?B?MkN0dEw3Y1pqQnVwQjZYNThpNUxiem9YMFgybThCa0RlcTNYUjRTUnE5MG9U?=
 =?utf-8?B?SjhhSjRydzhZblNrNXdWQU1yelNZOEdKWWVmTTJoYnRTelZqNUZ6cFhEckFH?=
 =?utf-8?B?UkIza1RYd0t6ditJQnNjbERPdHV1Q0t6WWZaWEZZc1FNc2tsQ2F2TkFsUHZD?=
 =?utf-8?B?Q3RjNno1aE8wUXBpM042VzNUakJMbmhBUlhEOVBXNnRuZUsvcUlYL0ZDZFBn?=
 =?utf-8?B?amtoczVmenNJbmRsNzBIRG9nSkNDeXNTZEFURytiazNGRTlBVmtyenZVUWdH?=
 =?utf-8?B?NDZ1dG02YVF0UDM1eHZXYlV4QzJ5a3RKak5IYjhveWI0elhVSlo0QjZSbUZp?=
 =?utf-8?B?Q0E2bHM2OUpsNTk1NGV1anpFYWtQeEhrNmxBUVJXYzNUOFJDV3pmaHo1Umwr?=
 =?utf-8?B?MVVHSXJwYkprbG5DaXozUmk3Q3FaRU9qVmVTOElkVGtSOGtrRElQaVFiL1g2?=
 =?utf-8?B?QTk1bnN4QU44a3h2bVU0L0F6ZVVLSjNDRS81bkhyT2Z2R3htWUFNN2V0azhL?=
 =?utf-8?B?TUdCN0NUdTJSMlNyN0t0NmRETU8vYllCems1a0lEN1dxUkJSUkg2UWJXOWY1?=
 =?utf-8?B?RzdZOXM2TlQ1RWNvd0R2OHh3aW9XbjhpbjVEeTgwM09LMTZuQ0d4VG5NcEJI?=
 =?utf-8?B?ckhnUXBocTE1R280bVl4K3JTRGQxSlkrQW9qc1ZzWC9TcVR2aHVPMHljNDlZ?=
 =?utf-8?B?Qmdja3Zlc0pOcTN4SmxTTm8zOUZDb1EzcE9nS1Y1aHk3RHM5ZEUxS0NuVTBa?=
 =?utf-8?B?bGhETkZGNnFsT2I4djN4QVJmQUNiNlpsN0p6RkVHakxoSVUyTXhuS0tJaVA5?=
 =?utf-8?B?OCthelM5T2Q3ZWxhTXhvcnovRkhNM2lZRFl0ZDRIcjRBRG95TGRoMis0N002?=
 =?utf-8?B?V0xrSUpDUFhmVDlQUnpsTUswM1lmTUI4VkUrR1Y5K3VrRTd1V041dnBWYVV1?=
 =?utf-8?B?dFV5UUZQVC9xVHFRc1V1RjcrTEtDdy9zbkVLZndEZ1BhZ3pIcUxGTTVXZFk0?=
 =?utf-8?B?VVZRZVU4ZHZ4anVlbUhKYTBXQ0dFUE1McG1NZzhCeU8rcER4L3F4ZEV1THFq?=
 =?utf-8?B?SmJ6TWN1eWw3Y1NjaW1aSXh0Qmtna3dsZ210TkdXZUwzRitURm9sME9waDhh?=
 =?utf-8?B?ZVBrZEM5ditGcTkzQkkraVlpcUFkaXExd1RpY3FSUUVaRWpadlBORFJ5a2F0?=
 =?utf-8?B?bXNWVENLUXpBK1FZRkx2MGpMYUtEL0NWbEMzRWdXbTBqUUNmdzNaK1BUMjdT?=
 =?utf-8?B?R3FIclJ5c0diT3NCckY3QUdVQzZzbTIvaEFEanU0UHZQblRST0dUcXZEalpQ?=
 =?utf-8?B?VURDTXpBSFM0K0Zoc242cjRYOVJoUlJUd0orY3MzaVhaNU8wOXNWK2hXZ1BI?=
 =?utf-8?B?enNnRW92SlR2S2t3dGpjRWdpYi8xb3JENURoSEtydHJkd0JRM21rR2p3YmtX?=
 =?utf-8?B?bGduN2RtZDgydmNDY2FnSi9EOUFLYmtacG1BYzhYWlk0cm5lSHFuSWg1aUVs?=
 =?utf-8?Q?JDGOA1VY7U6ZYDsbnDqNaGuoo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a10250a-73ee-4e60-25ca-08da89efabdc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:52:50.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdPavdkopwcodHNFQUhFhJ9xRrQFwQpmzlXqzhq4AEisdupVAHZHttS9/GNNmzxxac8+IPpJPbqI5AJ6lW6Kdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290087
X-Proofpoint-GUID: SmOHZ1a7ieqhp04z7_CLmGuFNcb4x0oA
X-Proofpoint-ORIG-GUID: SmOHZ1a7ieqhp04z7_CLmGuFNcb4x0oA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/29/22 11:40 AM, Jeff Layton wrote:
> On Mon, 2022-08-29 at 11:25 -0700, dai.ngo@oracle.com wrote:
>> On 8/29/22 10:15 AM, Jeff Layton wrote:
>>> On Sun, 2022-08-28 at 17:47 -0700, Dai Ngo wrote:
>>>> Add the courtesy client shrinker to react to low memory condition
>>>> triggered by the memory shrinker.
>>>>
>>>> On the shrinker's count callback, we increment a callback counter
>>>> and return the number of outstanding courtesy clients. When the
>>>> laundromat runs, it checks if this counter is not zero and starts
>>>> reaping old courtesy clients. The maximum number of clients to be
>>>> reaped is limited to NFSD_CIENT_MAX_TRIM_PER_RUN (128). This limit
>>>> is to prevent the laundromat from spending too much time reaping
>>>> the clients and not processing other tasks in a timely manner.
>>>>
>>>> The laundromat is rescheduled to run sooner if it detects low
>>>> low memory condition and there are more clients to reap.
>>>>
>>>> On the shrinker's scan callback, we return the number of clients
>>>> That were reaped since the last scan callback. We can not reap
>>>> the clients on the scan callback context since destroying the
>>>> client might require call into the underlying filesystem or other
>>>> subsystems which might allocate memory which can cause deadlock.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/netns.h     |  3 +++
>>>>    fs/nfsd/nfs4state.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>>>>    fs/nfsd/nfsctl.c    |  6 ++++--
>>>>    fs/nfsd/nfsd.h      |  9 +++++++--
>>>>    4 files changed, 61 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>> index 2695dff1378a..2a604951623f 100644
>>>> --- a/fs/nfsd/netns.h
>>>> +++ b/fs/nfsd/netns.h
>>>> @@ -194,6 +194,9 @@ struct nfsd_net {
>>>>    	int			nfs4_max_clients;
>>>>    
>>>>    	atomic_t		nfsd_courtesy_client_count;
>>>> +	atomic_t		nfsd_client_shrinker_cb_count;
>>>> +	atomic_t		nfsd_client_shrinker_reapcount;
>>>> +	struct shrinker		nfsd_client_shrinker;
>>>>    };
>>>>    
>>>>    /* Simple check to find out if a given net was properly initialized */
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 3d8d7ebb5b91..9d5a20f0c3c4 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -4341,7 +4341,39 @@ nfsd4_init_slabs(void)
>>>>    	return -ENOMEM;
>>>>    }
>>>>    
>>>> -void nfsd4_init_leases_net(struct nfsd_net *nn)
>>>> +static unsigned long
>>>> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
>>>> +{
>>>> +	struct nfsd_net *nn = container_of(shrink,
>>>> +			struct nfsd_net, nfsd_client_shrinker);
>>>> +
>>>> +	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
>>>> +	return (unsigned long)atomic_read(&nn->nfsd_courtesy_client_count);
>>>> +}
>>>> +
>>>> +static unsigned long
>>>> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
>>>> +{
>>>> +	struct nfsd_net *nn = container_of(shrink,
>>>> +			struct nfsd_net, nfsd_client_shrinker);
>>>> +	unsigned long cnt;
>>>> +
>>>> +	cnt = atomic_read(&nn->nfsd_client_shrinker_reapcount);
>>>> +	atomic_set(&nn->nfsd_client_shrinker_reapcount, 0);
>>> Is it legit to return that we freed these objects when it hasn't
>>> actually been done yet? Maybe this should always return 0? I'm not sure
>>> what the rules are with shrinkers.
>> nfsd_client_shrinker_reapcount is the actual number of clients that
>> the laudromat was able to destroy in its last run.
>>
>>> Either way, it seems like "scan" should cue the laundromat to run ASAP.
>>> When this is called, it may be quite some time before the laundromat
>>> runs again. Currently, it's always just scheduled it out to when we know
>>> there may be work to be done, but this is a different situation.
>> Normally the "scan" callback is used to free unused resources and return
>> the number of objects freed. For the NFSv4 clients, we can not free the
>> clients on the "scan" context due to potential deadlock and also the
>> laundromat might block while destroying the clients. Because of this we
>> use the "count" callback to notify the laundromat of the low memory
>> condition.
>>
>> In the "count" callback we do not call mod_delayed_work to kick start
>> the laundromat since we do not want to rely on the inner working
>> mod_delayed_work to guarantee no deadlock. I also think we should do
>> the minimal while on the memory shrinker's callback context.
>>
> Are you aware of a specific problem with shrinkers and queueing work?
>
> As I understand it, shrinkers are run in the context of an allocation.
> An allocation crosses a threshold of some sort and and we start trying
> to free stuff using shrinkers. queueing delayed work will never allocate
> anything, so I would think it'd be safe to do in the count callback.

ok, I'll try to add mod_delayed_work on the "count" callback. I remember
vaguely that I ran into some trouble before but that might have been caused
by something else.

-Dai

>
>> Once the laundromat runs it monitors the low memory condition and
>> reschedules itself to run immediately (NFSD_LAUNDROMAT_MINTIMEOUT) if
>> needed.
>>
>> Thanks,
>> -Dai
>>
>>>> +	return cnt;
>>>> +}
>>>> +
>>>> +static int
>>>> +nfsd_register_client_shrinker(struct nfsd_net *nn)
>>>> +{
>>>> +	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
>>>> +	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
>>>> +	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>>>> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>>>> +}
>>>> +
>>>> +int
>>>> +nfsd4_init_leases_net(struct nfsd_net *nn)
>>>>    {
>>>>    	struct sysinfo si;
>>>>    	u64 max_clients;
>>>> @@ -4362,6 +4394,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
>>>>    	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>>>>    
>>>>    	atomic_set(&nn->nfsd_courtesy_client_count, 0);
>>>> +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>>>> +	return nfsd_register_client_shrinker(nn);
>>>>    }
>>>>    
>>>>    static void init_nfs4_replay(struct nfs4_replay *rp)
>>>> @@ -5870,12 +5904,17 @@ static void
>>>>    nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>>>    				struct laundry_time *lt)
>>>>    {
>>>> -	unsigned int oldstate, maxreap, reapcnt = 0;
>>>> +	unsigned int oldstate, maxreap = 0, reapcnt = 0;
>>>> +	int cb_cnt;
>>>>    	struct list_head *pos, *next;
>>>>    	struct nfs4_client *clp;
>>>>    
>>>> -	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
>>>> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
>>>> +	cb_cnt = atomic_read(&nn->nfsd_client_shrinker_cb_count);
>>>> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients ||
>>>> +							cb_cnt) {
>>>> +		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
>>>> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>>>> +	}
>>>>    	INIT_LIST_HEAD(reaplist);
>>>>    	spin_lock(&nn->client_lock);
>>>>    	list_for_each_safe(pos, next, &nn->client_lru) {
>>>> @@ -5902,6 +5941,8 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>>>    		}
>>>>    	}
>>>>    	spin_unlock(&nn->client_lock);
>>>> +	if (cb_cnt)
>>>> +		atomic_add(reapcnt, &nn->nfsd_client_shrinker_reapcount);
>>>>    }
>>>>    
>>>>    static time64_t
>>>> @@ -5942,6 +5983,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>>>    		list_del_init(&clp->cl_lru);
>>>>    		expire_client(clp);
>>>>    	}
>>>> +	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0)
>>>> +		lt.new_timeo = NFSD_LAUNDROMAT_MINTIMEOUT;
>>>>    	spin_lock(&state_lock);
>>>>    	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>>>    		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index 917fa1892fd2..597a26ad4183 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *net)
>>>>    		goto out_idmap_error;
>>>>    	nn->nfsd_versions = NULL;
>>>>    	nn->nfsd4_minorversions = NULL;
>>>> +	retval = nfsd4_init_leases_net(nn);
>>>> +	if (retval)
>>>> +		goto out_drc_error;
>>>>    	retval = nfsd_reply_cache_init(nn);
>>>>    	if (retval)
>>>>    		goto out_drc_error;
>>>> -	nfsd4_init_leases_net(nn);
>>>> -
>>>>    	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>>>>    	seqlock_init(&nn->writeverf_lock);
>>>>    
>>>> @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
>>>>    	nfsd_idmap_shutdown(net);
>>>>    	nfsd_export_shutdown(net);
>>>>    	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
>>>> +	nfsd4_leases_net_shutdown(nn);
>>>>    }
>>>>    
>>>>    static struct pernet_operations nfsd_net_ops = {
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index 57a468ed85c3..7e05ab7a3532 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -498,7 +498,11 @@ extern void unregister_cld_notifier(void);
>>>>    extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>>>>    #endif
>>>>    
>>>> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>>>> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
>>>> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn)
>>>> +{
>>>> +	unregister_shrinker(&nn->nfsd_client_shrinker);
>>>> +};
>>>>    
>>>>    #else /* CONFIG_NFSD_V4 */
>>>>    static inline int nfsd4_is_junction(struct dentry *dentry)
>>>> @@ -506,7 +510,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
>>>> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
>>>> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) { };
>>>>    
>>>>    #define register_cld_notifier() 0
>>>>    #define unregister_cld_notifier() do { } while(0)
