Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7156780FA1
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351286AbjHRPyQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378345AbjHRPxs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 11:53:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CA270C
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 08:53:46 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEkuvA013564;
        Fri, 18 Aug 2023 15:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=OZZCwPwv64deI6XNzG9YK1iyXdTkb2XFjrF+QqORBiU=;
 b=BU599LOSMsmEBAn70UmYr6zPWl3o1qHEL/tb/+SgZE1cfJQkJ51ohGLCpsVoCKK6Juc/
 xK4wY23hRyfjVypHoAatvwUGStZJE6b+x2KP190nqrPekREEAtlFXxMfPeCAZDaDIoN2
 Ojbpk47hifqUdrYrjnejZV2Is9NszSjN1VM+o3r+/EM8bzBXjYFR2YgcRUlwVyR1G3D1
 GJbEWU4d2d2BkCEdSixK/oqKqrRYj4ase0KXh7bC4rNSQm5y4win2mHAd79TLU2kufeT
 Bi88QN2r55DaK38/IUnQQdu7VwTsk+Cl/xMRvGcDpGYfnKClx1Ice/Egs3izEF1gEUf+ Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30t4b9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 15:53:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEIct4006625;
        Fri, 18 Aug 2023 15:53:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2hasqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 15:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT/4cXiBHs5X/A1/dF1VY+iONrQU5pcfX7uMRTnZiYuafRC5v37pC5w2EToBeIs8RQSUqm2o0aEfYNpdB3RPEgiBvoRGNwQ73HgG5VslaQGnpjImjdbsxPjPGrVlcJydG5/n11W6VeP+axoiu+oql/XMGaCgSVXLEQO4T4ZAcGiBAyGWp6coN4+sF/0ueCceKmng3UNUGLNi1GjNyMbEhjQvQLV0I4FP4wvKRev+vJCj9+WrvWmWjvx6wFejm6HYg7y0Gir/BNyoT9/+k9OtB5OV2nx3YWs0tDDLeiQkuwWroG1IJX5Vs+hjqVgVjdgb16PyrAqHEWRbtMdQffX3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZZCwPwv64deI6XNzG9YK1iyXdTkb2XFjrF+QqORBiU=;
 b=DcsZYOHT84vK9PbgrABGTjoMAVixVf4TLfEN0LTHtDuq3L3g32FMLi1FAdJdMGzSBFh0mKiwx4ApG2V1FEXVpkyQXRlYHnCWd4n7huqr/O5khR0s1NIM/eX3VD+SW9Gzmk7dR46ByEygwC7Sg3/kqSUFD1RRzWf+0/zAqUvHYMAuEU/7hycj21CgdAVu4SUl8Ruz5R2L6VCgh2ow+byZegEb1cXWA2z2/1FsfAYRxi3N7felpwCTB7OKiPfZumUfyjQvETU9Gg9ZibdyjTpG8FYJUc9i5SOCWNLVOHiUsY7Sl7Kuxq/WcuMB+uxJIxjYib9t35wkK2M2BbGT+Rw5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZZCwPwv64deI6XNzG9YK1iyXdTkb2XFjrF+QqORBiU=;
 b=xNMUi13e6+1EzvQcuLrb2OsJrQqJkeFu9VbUH0VcVs4o+3xRl4cFiTUfcO+CljZzTRnBr0QX8PG8iAyxz82itfXvwrgd6IUIqRDteNzZwgEXYWwDtfXlppI/GwLh1kBGhtqyyys0b4/zNtaF0JUaJYkdJTa/UB+dbqyDmWr58sk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5759.namprd10.prod.outlook.com (2603:10b6:806:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 15:53:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 15:53:34 +0000
Date:   Fri, 18 Aug 2023 11:53:31 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/7] SUNRPC: change service idle list to be an llist
Message-ID: <ZN+T+y+lwQ2XrXLM@tissot.1015granger.net>
References: <20230818014512.26880-1-neilb@suse.de>
 <20230818014512.26880-2-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818014512.26880-2-neilb@suse.de>
X-ClientProxiedBy: CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c5e7c6-2e25-436d-4839-08dba003472b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPD16nnIXbKIgXxEipGzdWcCKm0wHG+K1f6EdLrPuf/4gztplERrRfoXSFtsrWttPRqh/fE6swEedLT4aOv22i/lLVXPEok/Z8mbmAWON/4FJL22vggJ/dnvgZPgSeZ7Dsjmv8Z6nRLD+tRhtANoAvaGwNoheyTnp0RuKzDuzFiB0B/dfqXIfO6n+N4b3H7oQ8/biUtJzK5MjLLijx2paDs8PpujO7JrR9bVVMU71ha7z2LoC+BWRX1gUZpJblW9z3E/xVdJ528L6FoU8aJ+Ugnewtsh3bxWufvty0RZPLvzssS6CIN92PoM0xYbZT7oDef1HSYFCCXBU9lNqTHowELo6bjSE/XPIuD14vLcRAWy0QbnzzikTvAOv7AX+TfAr5qGOOoKniWWXYsZiFe3s6D1SvBoyO7LR1sWMljAeHRi212RpCq6YEspZT0CA9MXhlxUi3TxQXk2Cty2x/KqHq58/qaCR0eiHzBRRh9Vyogu0x5fJDRh4j93/g82pKzVLUUMo+0FGozvgFxJQiY7qZiqfmB1q1z6Klcil8EMnmEmMWlBwzoPvLRQ6ANKJteQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(83380400001)(30864003)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(6666004)(6506007)(44832011)(6512007)(6486002)(9686003)(478600001)(66476007)(316002)(6916009)(38100700002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RiXIRCCfaBub5lF6HTykw/q3ciBWaVsGs1UiVqROk7u4XUUnXJHHzn9eluVX?=
 =?us-ascii?Q?ZJQ7i8ttlkSM4MEQDnenCLYKaUg9pDCxyDjg/aU0cKY8dTAFZAYfUfles9lZ?=
 =?us-ascii?Q?GN6h/QQwSlGT76aavGybNCw02Dr6AW1NnHYFQ5vOhExm0moY9ZsBEpV0oIzn?=
 =?us-ascii?Q?9fZx3aVdRtmu/PYoO1533M09SFnooYZE0AEFke6VuqHO25YTkC+Q4NNVDAyN?=
 =?us-ascii?Q?0PUS2ttsv5JTpFa+M1oydHoLddrQrDUvxsjuvfyBtozzoVqgK0nuuq5ybGxD?=
 =?us-ascii?Q?JqOSw3uu0eX7+VNHoAi+q+tYZfAel4kM1OsaRYALEPFXUn8oEXMqeyU5lzQ6?=
 =?us-ascii?Q?RjcOF/Sj68L7S4rOEbs4in4BLkdACXMkQRAlyWEZEsCKSt/a0IyEpqLAOQfM?=
 =?us-ascii?Q?Br8FHEhJdJCpIfESPD2fdxsayfYaFFlcbsiGjHeok1p0gwYc+fmpdBR4wt0T?=
 =?us-ascii?Q?293Spei1YCLLuUW+T6lILV8lIaxTCHXf54kfpKIYC9AcHF7oS6kzLNadECxo?=
 =?us-ascii?Q?1Mv6BgW4NGXXjlmjUCUu7g4s+w0yYx+N3Vt8M/Ry2nGoEalVCTV/DUgYNHBE?=
 =?us-ascii?Q?eM58ZTJQYryJ7dMEyU6SWzips90V8jI7hc9o2ro8p+DW9IXOTCz1h0b+rmbG?=
 =?us-ascii?Q?IvNajY2uzfbAdlNTIoBby6mJeMuOtzPlvnifJbrLYkCvzKwbMpmJo9Ncgpxm?=
 =?us-ascii?Q?eieX7WNp8ql97zwhH6bIJtO5tSVz/GiOIneLeYPzP2DQkQEA59abB+VIDu0q?=
 =?us-ascii?Q?SLLSRFP3EF6hskOOBobKGBdpD8/LluLMKvKHBeyN/IKHr0EXWKtrjb9CP2I3?=
 =?us-ascii?Q?k6KYdoeeJ+7cGdfzUvgFNH/Qo43GFu4amtUTkrwqHxf6DA6ErlghzHc3K2xl?=
 =?us-ascii?Q?9LTsJLXdQi5uGCx8cp9dx3KAtHT1woDtuHKL4ZGn9TWqbQmxUDnhDVQhw7Gg?=
 =?us-ascii?Q?UzUAUylVdn9zjgiYU7os+UkO4ZCKlZ3Ao9DabTTyWyiEwxxcwIJwYiGtXQFh?=
 =?us-ascii?Q?PKFWIo3zzBmXHImKuUg8SKm4Ctm5/4EHrPxv5ZKy7DKULIp8TvSO1mdJh/Nk?=
 =?us-ascii?Q?6FcqPDndwaqcwrqTlUWvA8GNzch6AvSLKfkMSQXSO66+jfEgJJNc8kjbaWVh?=
 =?us-ascii?Q?AUhcTXMFC3vv4zSGfN0pcxIoXLHtQBSD6thH/9ld46Meg/Pd02xKWqIJb3Xo?=
 =?us-ascii?Q?GSeRWSmP0OucY8qrrc0mv2W0DEw42FrHbxiup3UcMml1keISCXA9BIqHbOMT?=
 =?us-ascii?Q?XO9pqOMVCSCR0KTuVG1GAZvmddlKZp9Wpz/cVEEcD21ZHW86a1pHooMVUzG6?=
 =?us-ascii?Q?RTOf6NtRKjw6q9RqK5R5JoTjC/Wos+0kSirtHcKWHGb39TU028aITfkSfF8w?=
 =?us-ascii?Q?EWHZHY58J/hfV64HhOSir6o1eueWolpZntR/JbhSkBI25Pxe+TOVwlsYm7I/?=
 =?us-ascii?Q?d1B4xScRWnM65mWcTN4sQ3Z8y9qeD9ZA6hG1vhtifAi/jH3mwYrVUyl8nuQw?=
 =?us-ascii?Q?XeI9JOV/Ci//DRYEIGMLm+E1M0beVhc0JEts13hoMKnkmeQQR2khGO8lwKaz?=
 =?us-ascii?Q?8Vhhi/ivuZ4k4v3Z0OZc+L7py0eTdgYjYjIPQ2sZKqN0hZcrkOXdT3Z4qD+x?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lE2FMEh8Zt9s4oSM4KfB4/1cCsbA9qxK6n93G75bQ5mP4p6Ja/UvnFlQA58JmB5DDQvzbGXNIBDl+2WHIHC2UWHFe6CMWnPKcykYJQHge49ZgD/E9tQon2lMfUupwDmzw/KsdJ6wUIs+T17lQChGJ+TL/lqt11JaPFP71hLtmPPxCYDou04JEa1soKBMGayK1kxvQPd+XwmpH8JqT2PIeu7L6hzPBdUB6IweGqxQYQZwNy+6BkKHwDEbRFjaaGx49sSl9RiI6aKcTsPGYSjLWK05vXiiHgdTu3U4buXL7+9F7HDz+rUqzwPucbs8VTnQIsCYybPqkSkDDtakDh2+I1O/+41Xq/XHE5adbsArqUbHdHPjh2AvfhXqZ5tiQMeWwtKMjbpssMvGY7ljlExHQp27J/ogVwpLaIjNmlwsp2686f0TJFaBMaLboRmIIJFTZWcC8e9JkK4m5uesN0/yZAcZ2Q1wPs+peOAcKZ5BEaziLeZrIixCP1kWWuGr6a8MjvMgu3W9Vo2bljP7O7GY3R332+Fs9qbNyR3EHjNGHwza28YrvcsfL1eDj5L1G0sWpYWFB/omFJNWyC5xZwgwpF4CgUsP2Dn+LFfeuaGva5Atab+T0lRSAwBYDPpqZ4uwLfGZUr2yKifqsBT3/G/trdjHwhD0zbwhApOU9ow6b2ZPWQhkCrN5+KpMweNCzCZgLn9q6HRhIVKzEJSfsH6eliXKwldiZUqT5LwOQR8wjbIRBjrE53WXgk2zOSP1Dt01HrcN09ANIltL47UIfdWmSsOiAPQ+ljQax6YKDOPZhtDIqZw/zYn4DF0rrsdH/2rj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c5e7c6-2e25-436d-4839-08dba003472b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 15:53:34.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyiysQ+n7iCaJiyr11tBvJM63FR397axWQSfalSoJXYKi+tJfHtre9XnpiyvwydvCndL9Kmh+N68svyel/eM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180145
X-Proofpoint-GUID: yH4fIJzG3fxO83Dz8aurJgDpgSBg9OXW
X-Proofpoint-ORIG-GUID: yH4fIJzG3fxO83Dz8aurJgDpgSBg9OXW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 18, 2023 at 11:45:06AM +1000, NeilBrown wrote:
> With an llist we don't need to take a lock to add a thread to the list,
> though we still need a lock to remove it.  That will go in the next
> patch.
> 
> Unlike double-linked lists, a thread cannot reliably remove itself from
> the list.  Only the first thread can be removed, and that can change
> asynchronously.  So some care is needed.
> 
> We already check if there is pending work to do, so we are unlikely to
> add ourselves to the idle list and then want to remove ourselves again.
> 
> If we DO find something needs to be done after adding ourselves to the
> list, we simply wake up the first thread on the list.  If that was us,
> we successfully removed ourselves and can continue.  If it was some
> other thread, they will do the work that needs to be done.  We can
> safely sleep until woken.
> 
> We also remove the test on freezing() from rqst_should_sleep().  Instead
> we set TASK_FREEZABLE before scheduling.  This makes is safe to
> schedule() when a freeze is pending.  As we now loop waiting to be
> removed from the idle queue, this is a cleaner way to handle freezing.
> 
> task_state_index() incorrectly identifies a task with
>    TASK_IDLE | TASK_FREEZABLE
> as 'D'.  So fix __task_state_index to ignore extra flags on TASK_IDLE
> just as it ignores extra flags on other states.

Let's split the task_state_index() change into a separate patch
that can be sent to the scheduler maintainers for their Review/Ack.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sched.h      |  4 +--
>  include/linux/sunrpc/svc.h | 14 ++++++-----
>  net/sunrpc/svc.c           | 13 +++++-----
>  net/sunrpc/svc_xprt.c      | 51 +++++++++++++++++++-------------------
>  4 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 609bde814cb0..a5f3badcb629 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1666,7 +1666,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>  
>  	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
>  
> -	if (tsk_state == TASK_IDLE)
> +	if ((tsk_state & TASK_IDLE) == TASK_IDLE)
>  		state = TASK_REPORT_IDLE;
>  
>  	/*
> @@ -1674,7 +1674,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>  	 * to userspace, we can make this appear as if the task has gone through
>  	 * a regular rt_mutex_lock() call.
>  	 */
> -	if (tsk_state == TASK_RTLOCK_WAIT)
> +	if (tsk_state & TASK_RTLOCK_WAIT)
>  		state = TASK_UNINTERRUPTIBLE;
>  
>  	return fls(state);
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 22b3018ebf62..5216f95411e3 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -37,7 +37,7 @@ struct svc_pool {
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
>  	struct list_head	sp_all_threads;	/* all server threads */
> -	struct list_head	sp_idle_threads; /* idle server threads */
> +	struct llist_head	sp_idle_threads; /* idle server threads */
>  
>  	/* statistics on pool operation */
>  	struct percpu_counter	sp_messages_arrived;
> @@ -186,7 +186,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   */
>  struct svc_rqst {
>  	struct list_head	rq_all;		/* all threads list */
> -	struct list_head	rq_idle;	/* On the idle list */
> +	struct llist_node	rq_idle;	/* On the idle list */
>  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
>  	struct svc_xprt *	rq_xprt;	/* transport ptr */
>  
> @@ -270,22 +270,24 @@ enum {
>   * svc_thread_set_busy - mark a thread as busy
>   * @rqstp: the thread which is now busy
>   *
> - * If rq_idle is "empty", the thread must be busy.
> + * By convention a thread is busy if rq_idle.next points to rq_idle.
> + * This ensures it is not on the idle list.
>   */
>  static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
>  {
> -	INIT_LIST_HEAD(&rqstp->rq_idle);
> +	rqstp->rq_idle.next = &rqstp->rq_idle;
>  }

I don't understand the comment "This ensures it is not on the idle
list." svc_thread_set_busy() is called in two places: The first
when an svc_rqst is created, and once directly after an
llist_del_first() has been done. @rqstp is already not on the
idle list in either case.

What really needs an explanation here is that there's no
existing utility to check whether an llist_node is on a list or
not.


>  /**
>   * svc_thread_busy - check if a thread as busy
>   * @rqstp: the thread which might be busy
>   *
> - * If rq_idle is "empty", the thread must be busy.
> + * By convention a thread is busy if rq_idle.next points to rq_idle.
> + * This ensures it is not on the idle list.

This function doesn't modify the thread, so it can't ensure it
is not on the idle list.


>   */
>  static inline bool svc_thread_busy(struct svc_rqst *rqstp)

const struct svc_rqst *rqstp

>  {
> -	return list_empty(&rqstp->rq_idle);
> +	return rqstp->rq_idle.next == &rqstp->rq_idle;
>  }
>  
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 051f08c48418..addbf28ea50a 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -510,7 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
>  		pool->sp_id = i;
>  		INIT_LIST_HEAD(&pool->sp_sockets);
>  		INIT_LIST_HEAD(&pool->sp_all_threads);
> -		INIT_LIST_HEAD(&pool->sp_idle_threads);
> +		init_llist_head(&pool->sp_idle_threads);
>  		spin_lock_init(&pool->sp_lock);
>  
>  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> @@ -701,15 +701,16 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>  void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  {
>  	struct svc_rqst	*rqstp;
> +	struct llist_node *ln;
>  
>  	rcu_read_lock();
>  	spin_lock_bh(&pool->sp_lock);
> -	rqstp = list_first_entry_or_null(&pool->sp_idle_threads,
> -					 struct svc_rqst, rq_idle);
> -	if (rqstp)
> -		list_del_init(&rqstp->rq_idle);
> +	ln = llist_del_first(&pool->sp_idle_threads);
>  	spin_unlock_bh(&pool->sp_lock);
> -	if (rqstp) {
> +	if (ln) {
> +		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
> +		svc_thread_set_busy(rqstp);
> +
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>  		wake_up_process(rqstp->rq_task);
>  		rcu_read_unlock();
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index fa0d854a5596..81327001e074 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -715,10 +715,6 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	if (svc_thread_should_stop(rqstp))
>  		return false;
>  
> -	/* are we freezing? */
> -	if (freezing(current))
> -		return false;
> -
>  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>  	if (svc_is_backchannel(rqstp)) {
>  		if (!list_empty(&rqstp->rq_server->sv_cb_list))
> @@ -734,30 +730,32 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
>  	struct svc_pool *pool = rqstp->rq_pool;
>  
>  	if (rqst_should_sleep(rqstp)) {
> -		set_current_state(TASK_IDLE);
> -		spin_lock_bh(&pool->sp_lock);
> -		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> -		spin_unlock_bh(&pool->sp_lock);
> +		set_current_state(TASK_IDLE | TASK_FREEZABLE);

I'm trying to learn about the semantics of IDLE|FREEZABLE, but there
isn't another instance of this flag combination in the kernel.


> +		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> +
> +		if (unlikely(!rqst_should_sleep(rqstp)))
> +			/* maybe there were no idle threads when some work
> +			 * became ready and so nothing was woken.  We've just
> +			 * become idle so someone can to the work - maybe us.
> +			 * But we cannot reliably remove ourselves from the
> +			 * idle list - we can only remove the first task which
> +			 * might be us, and might not.
> +			 * So remove and wake it, then schedule().  If it was
> +			 * us, we won't sleep.  If it is some other thread, they
> +			 * will do the work.
> +			 */

Large block comments suggest that this code doesn't document itself
very well.

At least, some of the textual redundancy can be removed, though this
comment and the next are removed or replaced in later patches. I'll
leave it up to you to find an approach that is a bit cleaner.


> +			svc_pool_wake_idle_thread(pool);
>  
> -		/* Need to check should_sleep() again after
> -		 * setting task state in case a wakeup happened
> -		 * between testing and setting.
> +		/* We mustn't continue while on the idle list, and we
> +		 * cannot remove outselves reliably.  The only "work"
> +		 * we can do while on the idle list is to freeze.
> +		 * So loop until someone removes us
>  		 */

Here and above, the use of "we" obscures the explanation. What is
"we" in this context? I think it might be "this thread" or @rqstp,
but I can't be certain. For instance:

		/* Since a thread cannot remove itself from an llist,
		 * schedule until someone else removes @rqstp from
		 * the idle list.
		 */


> -		if (rqst_should_sleep(rqstp)) {
> +		while (!svc_thread_busy(rqstp)) {

I need to convince myself that this while() can't possibly result in
an infinite loop.


>  			schedule();
> -		} else {
> -			__set_current_state(TASK_RUNNING);
> -			cond_resched();
> -		}
> -
> -		/* We *must* be removed from the list before we can continue.
> -		 * If we were woken, this is already done
> -		 */
> -		if (!svc_thread_busy(rqstp)) {
> -			spin_lock_bh(&pool->sp_lock);
> -			list_del_init(&rqstp->rq_idle);
> -			spin_unlock_bh(&pool->sp_lock);
> +			set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		}
> +		__set_current_state(TASK_RUNNING);
> 
>  	} else {
>  		cond_resched();
>  	}

There's a try_to_freeze() call just after this hunk. Is there a
reason to invoke cond_resched(); before freezing?


> @@ -870,9 +868,10 @@ void svc_recv(struct svc_rqst *rqstp)
>  		struct svc_xprt *xprt = rqstp->rq_xprt;
>  
>  		/* Normally we will wait up to 5 seconds for any required
> -		 * cache information to be provided.
> +		 * cache information to be provided.  When there are no
> +		 * idle threads, we reduce the wait time.
>  		 */
> -		if (!list_empty(&pool->sp_idle_threads))
> +		if (pool->sp_idle_threads.first)
>  			rqstp->rq_chandle.thread_wait = 5 * HZ;
>  		else
>  			rqstp->rq_chandle.thread_wait = 1 * HZ;
> -- 
> 2.40.1
> 

-- 
Chuck Lever
