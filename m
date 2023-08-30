Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C972A78D824
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjH3S3d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbjH3PWL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 11:22:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82AE8
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 08:22:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9jC8i009325;
        Wed, 30 Aug 2023 15:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Hbvhzm76Vt8ah+2ImvPpU2iq6Bw0aaKukBYBkGyrIuI=;
 b=eiwKYl6VpGizSrUcXCYv5ucazBBB+cIIACIEuHNNhN5FBClLEvvIZQSFov5lg+SsqE58
 LuLS13ShKhYm6pdlCyn3OLyF6kw3oBux9peTNXpPwQCe3ynFZH7WzvQ/2eXG42EHWmpd
 XuF/iN0Qdgg+y5W00X3ogNDvIgLuYap8T2/lEBLO3F/cXcxh668YTyB6LeJuhwpKqehZ
 asCpm0oZR4l3OPoTez863f5XDJ6CKhtYQlxzZ6y7sUsn0Q1ieRtanjhlyScml+sMGKF3
 1EzE6cE4gN2KHTOqI9Qsq9kbRdZWX0dVAchxzmyK6g1uJd0dPJ8ymdIj3vCesEat88ub bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk7nh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 15:22:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UFHwDt009179;
        Wed, 30 Aug 2023 15:22:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepy21xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 15:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EylRZ+k5KOItlVCyXsh+1bcr7jxayjR+Ja3WvFJrAoFszDuD5wRHngXkH7bVEn7uCWwcxBJyJEvZ2OTue/ro7KlOLpvq71xByZc7rWbNGEaXxYKUQkZmZ25q/KDuRZRsUo3GtC/L8mT9n5YanFcj09Uksjxa0fImiD23uubWCAe6811FqL4fvRuk1Qwuw94t4a7d9+26n6BfQaRn3HiBA1bBhUzxoXo4OiwNSQsiU6K62lU+AORWMbho3FefLk8JC+dhzxOt1Fnvccz8tWuNZgeTLyXpw4GroiMgYa5TxyiweV1T+Vp0sCrlIt/fmTgv+s2R0dvoZzlN0vQtTFhP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbvhzm76Vt8ah+2ImvPpU2iq6Bw0aaKukBYBkGyrIuI=;
 b=ZWasz51OUgpZjcLJTW3s584Zpum4F3S14TJawgQ9IspO1qvevBsaIhHJeQHyxo956xZlvdQD7t0Ulj+lfmfN0YVJNKD2s/C/oxFiRiWrvQY7dfA+nlVBJLwpCpY3T9l0dSVhGThyvdSphELf/pXtWhzPDOYSPXcf2clp4P9KckNAooAFTSwI1p7AESmj/YC+GFEa3ZGEDWjWxHGoMzrKwv13BqsJ/3tJGoM+1DiRHgDuo3laoYGx+WlEalNOFCZMtG7YiaM7pDmgdf77e8DxmWWrjX3/hobnxr2gRFoemESZ1MJbQwJppSfu0plL+ayM270rzTlmcsEkFbksAJUjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbvhzm76Vt8ah+2ImvPpU2iq6Bw0aaKukBYBkGyrIuI=;
 b=lDZ7pIb/fdnGBqeJs9V+XyAOHBqXXIrX84/j/GN78dO7XVpajUk2bxToJApLq2WESk1usMIFtXs8z9MpitYOE7uHxrN7AVHY56flTI82DSmxOhPKrURvljRz4jlFGTsLBcjgy8K15GKMD5jJXwW1ChW4RvlU5+bBrju9/dlQo1Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6392.namprd10.prod.outlook.com (2603:10b6:806:258::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 15:21:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:21:58 +0000
Date:   Wed, 30 Aug 2023 11:21:55 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/10] lib: add light-weight queuing mechanism.
Message-ID: <ZO9ek4UI8sNETSdr@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>
 <20230830025755.21292-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830025755.21292-6-neilb@suse.de>
X-ClientProxiedBy: CH2PR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:610:5b::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: e923b44b-545e-4adc-60a5-08dba96cd9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mstNtP4jra9kZK7d+80VTH2Q+UQ+YVVLYATAhwIY/vTUcx8pRPnACNq47en7orj0Gyd2kkvjl9Z1QItdAFU936+sqfdNd+sVeh5d5MdxwqyY4fzdMGLyTzX4IdIF3s9i4Du6a2uXV2jRvd7xV1L+sxBFWq5MJ7//fxrYCgq2ha5X5hBJ0AnVBrwwt59B1v3qpfPf3jOMAfMCrCwMoZrgxVb3rJjQDGM0JcZbVeWYbBKoUPs1F2fveacYPW7L3W8B5yH9zP/ziVotgjpKspO60aTuv3XQUlqyuKmOXYhuiR35b8b72vDD3Ghu5msGNomwv1sLT5CSotkumQ1v8Lu7CTNAagqBmsrTui2YVA/ZjvMUG2dtles5/GLyXJiif8Ma69tAEWGZpON8o4Zvb6sma7SrrjbQ8VBmaW25keSHHZbzgxNeFMgiSsbJfRGqZdYj4ZobzH86xo33gSD79FN61Qp1B5DhsjWAVkpPgu1sAUnerhT5TQj8ecAr2yghrO1rTKVNT4NMz8F44RwFuO7xfwt06rdpaU8pS6yrCK6blNdaY03tMZdwn7h/uJneZg1kNqTcDcWK1GM3VFNt2QRtKl/0Lr5alYJf1WXCtXNa8ooKMf8kWVgpV4vxwGzms/LC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(9686003)(26005)(316002)(38100700002)(6916009)(66899024)(41300700001)(4326008)(2906002)(30864003)(86362001)(5660300002)(44832011)(8676002)(83380400001)(8936002)(6666004)(6506007)(66476007)(6486002)(66556008)(66946007)(478600001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JT5ee/45fzE6gde5SVNQ4E1lwaz0TU2b8nX2jBmHk56b6xjFGL3msFB10U4R?=
 =?us-ascii?Q?AqSDDBGPL8hlzN/pw3ebOBR2pi+eApyTDmMC35Gk2/jGmq+GlLNVS9dJUxLb?=
 =?us-ascii?Q?EfTe0R2ESFk/k0p267JKP3UlrqSLMl0HQlhrt+Qih9E9PnR6FD3jbuT4FqFr?=
 =?us-ascii?Q?Tx690hLUPt1jxtv9c0mCH0mxza8zh9/mCvTSnfH/VflCmUusds3DU2weqJdc?=
 =?us-ascii?Q?m/qW6zqdNGYnDKc3mj/gGvcZ80JpbT/UoUH9qWWKhvuXmMX+r0xERYDGGFfQ?=
 =?us-ascii?Q?pBg84Kra8g7FVvy72pxELWbXBltrnD9BPAZUo7VD9Qos7BNo749u2KFF3LR0?=
 =?us-ascii?Q?x660Tecf2ny7dGOHlnzCJpYGTcwWxJgixAUUzYdCLyrb2EOw53yr1k1+m103?=
 =?us-ascii?Q?tuSy9kpGq1XHcv5WW3UZhez3YdV2GzZIeLQN2ONClLbURAhuuHnSkCCuiQpr?=
 =?us-ascii?Q?3mSz0exTE/JAymkz/GADAiCtEu4NJhKbPSILjxNJT2W+w62P8ilaKwFJo0kn?=
 =?us-ascii?Q?4Qz+pHmyK5jHBQPhNu6GhxERuekGyJjkYHjvVDutkIxzvBNraYxMeAgVZinw?=
 =?us-ascii?Q?ziRYRWxs69J7VxLiFSTpzyKGaHqgInoEnOFydDpHGQiJaXh/h9JBpfJ/bIO8?=
 =?us-ascii?Q?xHVWmrlhxcj+8jisg/txl/cNEy0xj/ClRyfKkdgOvQqYi/kvbQdWsR08kd4T?=
 =?us-ascii?Q?SXVGmdJaKLLS4qww6Bog09rRN6v1Y1rgvEgruQ1xjMyzaCKu3nxV00v2pblo?=
 =?us-ascii?Q?kmA9TecFPyOYmC8yTqi4NhwelEMc+ze+pIbwbvgyXcUHsQpRLJLJGnf45edI?=
 =?us-ascii?Q?gNEc48oSmujDaIhNmpn4EKWcEgs/TPJIPm029N85HPXyFvcRmlXQtytPctoh?=
 =?us-ascii?Q?vaW3HhE4ocFF9ZG/w1Ko3jroVGoUWsP9A2RzGxLIaGvzt0c8dvFarmlCGK29?=
 =?us-ascii?Q?yisXEwa2t3CO/xuG/WU3wqSaEcwlGLUogso05TaOac/KVG/xOfLE3TAS04jg?=
 =?us-ascii?Q?79y59OdMq4bSnZFON27eMdXsIhaQO4dKu5DkKkZD7SScPlzi+Wu0Hdv7OTCL?=
 =?us-ascii?Q?5ZSCwQttaGct8mZhDcwrnH5I9tkJUGCtQ79eu5AE96eyQYi1GSZTk91YjNUx?=
 =?us-ascii?Q?PBiJcp6lZ51j0W8L3aaeBUwsoj8JtoVwI9Irp+HZvXE0h74MXu9rk8c8jQ+c?=
 =?us-ascii?Q?y8u3nzJe3nHIoLgAipSrcYdpX+WSsQdL86A3B1I0WOzAP1YSrc+iusLT34xK?=
 =?us-ascii?Q?3P1tK5D8Z499Yn/0HaEAQA0cibNMOv40Y8mjcAXgzK3cmHPk6goNfLer2Qvc?=
 =?us-ascii?Q?rzttR8j7GQ5WucTAvrEWudAGlYwkxHSGdBmTuXcpdr2PH96QP2PAoNSEMdnM?=
 =?us-ascii?Q?3jgFezwEKPGvU7V7Vtfm/P0xe8jpjVCrlKKXsxYenvKDNr61jv2wJ73AmgY6?=
 =?us-ascii?Q?cOR0l76T+gjTDAt0Nat3xt1mF0cCQvEeVr4Zepul+z8V2qRv1PcArI/BsEvR?=
 =?us-ascii?Q?4752Uliwihk0LhZJuvaSmOFroOro9idcq5cQDz2OE2NvJ7xZCEQlg866kqKF?=
 =?us-ascii?Q?t1k/zqn7N96c4dswjDksHNTrUDC/xAXLqxONPRX5QjFokg24x5FUZOXL6Tpo?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6OWKWMu/Vi+gpev8w8uvfOIRFr5PlvU2l+rtUDLdyFDhLrk4TXZN8oX+N7qnfhILFs4fKf0tAjIfkbQsgQOGWVpA/mt+dbOPrHsOHilYgoGqewFxzrLVHLdN4qxclj7L+TGsPCGI7hYJwav7UsZ5j7L3pAIy7oraJPU8k+RrO0HR20WJ3hX5gRakzbR8L1dew/HtsCaIBin9cEtPAzd7P6nWZ2t8j1XBvkMHezhFHU5ylirQHz6B7ETu4555KbP7tVla/ypCfBzD1OEmYkAUEmIDxJTgCqk6Jz/dMK0GmekvUMnMgtZxVSV8+ntXUJz9UecJ5dAc5XMsap0mdVRItnHznz7j47ur+lF26R9lH12Y2P/QeA1RAKY8SWDF/OXJp494+Ji6RG92r3g+9LqrXwGGL1u2y7oFmWeSGWrTr1XaGmtKWLlGun94Ld14v0rM3NDSuje3Unmh2FlTAruKXsI5J51p7zca/sbUP2mSybcZfbTpOpTefCpH6POXmYV4vTOQ58YI9abdtPliWGp+YMPIRqDHYbp7l7fTKK0vF6lNzKcFht45b12jqKp3OOi99+PP2NGeUTLXUJaTpm3GZNJH55g6yHCy6HIncHorxae7k23hutQGK79k+7RHv6/7stRTSDBx250OCa6p+j0NM36PB2aEWZ+w8VkJVocjuyphLhKxRgXQXevzoOi5j8SYnKCobdyAGPHnGSkevKp/pAzaGswpwMOtHEf34krBxkc2mN6jgmE85EQEDgCG2RYaLA2u1Un5E8KCn+UbY7mqiMtTGhrbR8afXlU0VhTPGk3VT7IjuXb+w9847KlyPZ5W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e923b44b-545e-4adc-60a5-08dba96cd9c0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:21:58.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m65Ax1gs7/xSrtSFe3eAhOElZoXqh4X+wboBw5xfGnkFZeIUmawWrkCiWP3Y2XMbeOhxmymPmut7vyc90jrU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_12,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300142
X-Proofpoint-GUID: DmOviTB0b645-fGFGT_vxiyXw_f7BVet
X-Proofpoint-ORIG-GUID: DmOviTB0b645-fGFGT_vxiyXw_f7BVet
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 12:54:48PM +1000, NeilBrown wrote:
> lwq is a FIFO single-linked queue that only requires a spinlock
> for dequeueing, which happens in process context.  Enqueueing is atomic
> with no spinlock and can happen in any context.
> 
> Include a unit test for basic functionality - runs at boot time.  Does
> not use kunit framework.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/lwq.h | 120 +++++++++++++++++++++++++++++++++++
>  lib/Kconfig         |   5 ++
>  lib/Makefile        |   2 +-
>  lib/lwq.c           | 149 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 275 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/lwq.h
>  create mode 100644 lib/lwq.c

I've applied and/or squashed the previous four and pushed.

I don't have any specific complaints on this one, but checkpatch
throws about 20 warnings. Some of those you might want to deal with
or just ignore. Up to you, but I'll hold off on applying it until I
hear from you.

Also, I'm trying to collect a set of potential reviewers for it:

[cel@bazille even-releases]$ scripts/get_maintainer.pl lib/
Andrew Morton <akpm@linux-foundation.org> (commit_signer:206/523=39%)
"Liam R. Howlett" <Liam.Howlett@oracle.com> (commit_signer:89/523=17%,authored:61/523=12%)
Kees Cook <keescook@chromium.org> (commit_signer:48/523=9%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:48/523=9%)
David Gow <davidgow@google.com> (commit_signer:43/523=8%)
linux-kernel@vger.kernel.org (open list)
[cel@bazille even-releases]$

Is that a reasonable set to add as Cc's?


> diff --git a/include/linux/lwq.h b/include/linux/lwq.h
> new file mode 100644
> index 000000000000..52b9c81b493a
> --- /dev/null
> +++ b/include/linux/lwq.h
> @@ -0,0 +1,120 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef LWQ_H
> +#define LWQ_H
> +/*
> + * light-weight single-linked queue built from llist
> + *
> + * Entries can be enqueued from any context with no locking.
> + * Entries can be dequeued from process context with integrated locking.
> + */
> +#include <linux/container_of.h>
> +#include <linux/spinlock.h>
> +#include <linux/llist.h>
> +
> +struct lwq_node {
> +	struct llist_node node;
> +};
> +
> +struct lwq {
> +	spinlock_t		lock;
> +	struct llist_node	*ready;		/* entries to be dequeued */
> +	struct llist_head	new;		/* entries being enqueued */
> +};
> +
> +/**
> + * lwq_init - initialise a lwq
> + * @q:	the lwq object
> + */
> +static inline void lwq_init(struct lwq *q)
> +{
> +	spin_lock_init(&q->lock);
> +	q->ready = NULL;
> +	init_llist_head(&q->new);
> +}
> +
> +/**
> + * lwq_empty - test if lwq contains any entry
> + * @q:	the lwq object
> + *
> + * This empty test contains an acquire barrier so that if a wakeup
> + * is sent when lwq_dequeue returns true, it is safe to go to sleep after
> + * a test on lwq_empty().
> + */
> +static inline bool lwq_empty(struct lwq *q)
> +{
> +	/* acquire ensures ordering wrt lwq_enqueue() */
> +	return smp_load_acquire(&q->ready) == NULL && llist_empty(&q->new);
> +}
> +
> +struct llist_node *__lwq_dequeue(struct lwq *q);
> +/**
> + * lwq_dequeue - dequeue first (oldest) entry from lwq
> + * @q:		the queue to dequeue from
> + * @type:	the type of object to return
> + * @member:	them member in returned object which is an lwq_node.
> + *
> + * Remove a single object from the lwq and return it.  This will take
> + * a spinlock and so must always be called in the same context, typcially
> + * process contet.
> + */
> +#define lwq_dequeue(q, type, member)					\
> +	({ struct llist_node *_n = __lwq_dequeue(q);			\
> +	  _n ? container_of(_n, type, member.node) : NULL; })
> +
> +struct llist_node *lwq_dequeue_all(struct lwq *q);
> +
> +/**
> + * lwq_for_each_safe - iterate over detached queue allowing deletion
> + * @_n:		iterator variable
> + * @_t1:	temporary struct llist_node **
> + * @_t2:	temporary struct llist_node *
> + * @_l:		address of llist_node pointer from lwq_dequeue_all()
> + * @_member:	member in _n where lwq_node is found.
> + *
> + * Iterate over members in a dequeued list.  If the iterator variable
> + * is set to NULL, the iterator removes that entry from the queue.
> + */
> +#define lwq_for_each_safe(_n, _t1, _t2, _l, _member)			\
> +	for (_t1 = (_l);						\
> +	     *(_t1) ? (_n = container_of(*(_t1), typeof(*(_n)), _member.node),\
> +		       _t2 = ((*_t1)->next),				\
> +		       true)						\
> +	     : false;							\
> +	     (_n) ? (_t1 = &(_n)->_member.node.next, 0)			\
> +	     : ((*(_t1) = (_t2)),  0))
> +
> +/**
> + * lwq_enqueue - add a new item to the end of the queue
> + * @n	- the lwq_node embedded in the item to be added
> + * @q	- the lwq to append to.
> + *
> + * No locking is needed to append to the queue so this can
> + * be called from any context.
> + * Return %true is the list may have previously been empty.
> + */
> +static inline bool lwq_enqueue(struct lwq_node *n, struct lwq *q)
> +{
> +	/* acquire enqures ordering wrt lwq_dequeue */
> +	return llist_add(&n->node, &q->new) &&
> +		smp_load_acquire(&q->ready) == NULL;
> +}
> +
> +/**
> + * lwq_enqueue_batch - add a list of new items to the end of the queue
> + * @n	- the lwq_node embedded in the first item to be added
> + * @q	- the lwq to append to.
> + *
> + * No locking is needed to append to the queue so this can
> + * be called from any context.
> + * Return %true is the list may have previously been empty.
> + */
> +static inline bool lwq_enqueue_batch(struct llist_node *n, struct lwq *q)
> +{
> +	struct llist_node *e = n;
> +
> +	/* acquire enqures ordering wrt lwq_dequeue */
> +	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
> +		smp_load_acquire(&q->ready) == NULL;
> +}
> +#endif /* LWQ_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5c2da561c516..6620bdba4f94 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -763,3 +763,8 @@ config ASN1_ENCODER
>  
>  config POLYNOMIAL
>         tristate
> +
> +config LWQ_TEST
> +	bool "RPC: enable boot-time test for lwq queuing"
> +	help
> +          Enable boot-time test of lwq functionality.
> diff --git a/lib/Makefile b/lib/Makefile
> index 1ffae65bb7ee..4b67c2d6af62 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -45,7 +45,7 @@ obj-y	+= lockref.o
>  obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
>  	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
>  	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
> -	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
> +	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
>  	 percpu-refcount.o rhashtable.o base64.o \
>  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
>  	 generic-radix-tree.o
> diff --git a/lib/lwq.c b/lib/lwq.c
> new file mode 100644
> index 000000000000..d6be6dda3867
> --- /dev/null
> +++ b/lib/lwq.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Light weight single-linked queue.
> + *
> + * Entries are enqueued to the head of an llist, with no blocking.
> + * This can happen in any context.
> + *
> + * Entries are dequeued using a spinlock to protect against
> + * multiple access.  The llist is staged in reverse order, and refreshed
> + * from the llist when it exhausts.
> + */
> +#include <linux/rcupdate.h>
> +#include <linux/lwq.h>
> +
> +struct llist_node *__lwq_dequeue(struct lwq *q)
> +{
> +	struct llist_node *this;
> +
> +	if (lwq_empty(q))
> +		return NULL;
> +	spin_lock(&q->lock);
> +	this = q->ready;
> +	if (!this && !llist_empty(&q->new)) {
> +		/* ensure queue doesn't appear transiently lwq_empty */
> +		smp_store_release(&q->ready, (void *)1);
> +		this = llist_reverse_order(llist_del_all(&q->new));
> +		if (!this)
> +			q->ready = NULL;
> +	}
> +	if (this)
> +		q->ready = llist_next(this);
> +	spin_unlock(&q->lock);
> +	return this;
> +}
> +
> +/**
> + * lwq_dequeue_all - dequeue all currently enqueued objects
> + * @q:	the queue to dequeue from
> + *
> + * Remove and return a linked list of llist_nodes of all the objects that were
> + * in the queue. The first on the list will be the object that was least
> + * recently enqueued.
> + */
> +struct llist_node *lwq_dequeue_all(struct lwq *q)
> +{
> +	struct llist_node *r, *t, **ep;
> +
> +	if (lwq_empty(q))
> +		return NULL;
> +
> +	spin_lock(&q->lock);
> +	r = q->ready;
> +	q->ready = NULL;
> +	t = llist_del_all(&q->new);
> +	spin_unlock(&q->lock);
> +	ep = &r;
> +	while (*ep)
> +		ep = &(*ep)->next;
> +	*ep = llist_reverse_order(t);
> +	return r;
> +}
> +
> +#if IS_ENABLED(CONFIG_LWQ_TEST)
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/wait_bit.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +struct tnode {
> +	struct lwq_node n;
> +	int i;
> +	int c;
> +};
> +
> +static int lwq_exercise(void *qv)
> +{
> +	struct lwq *q = qv;
> +	int cnt;
> +	struct tnode *t;
> +
> +	for (cnt = 0; cnt < 10000; cnt++) {
> +		wait_var_event(q, (t = lwq_dequeue(q, struct tnode, n)) != NULL);
> +		t->c++;
> +		if (lwq_enqueue(&t->n, q))
> +			wake_up_var(q);
> +	}
> +	while (!kthread_should_stop())
> +		schedule_timeout_idle(1);
> +	return 0;
> +}
> +
> +static int lwq_test(void)
> +{
> +	int i;
> +	struct lwq q;
> +	struct llist_node *l, **t1, *t2;
> +	struct tnode *t;
> +	struct task_struct *threads[8];
> +
> +	printk(KERN_INFO "testing lwq....\n");
> +	lwq_init(&q);
> +	printk(KERN_INFO " lwq: run some threads\n");
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		threads[i] = kthread_run(lwq_exercise, &q, "lwq-test-%d", i);
> +	for (i = 0; i < 100; i++) {
> +		t = kmalloc(sizeof(*t), GFP_KERNEL);
> +		t->i = i;
> +		t->c = 0;
> +		if (lwq_enqueue(&t->n, &q))
> +			wake_up_var(&q);
> +	};
> +	/* wait for threads to exit */
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		if (!IS_ERR_OR_NULL(threads[i]))
> +			kthread_stop(threads[i]);
> +	printk(KERN_INFO " lwq: dequeue first 50:");
> +	for (i = 0; i < 50 ; i++) {
> +		if (i && (i % 10) == 0) {
> +			printk(KERN_CONT "\n");
> +			printk(KERN_INFO " lwq: ... ");
> +		}
> +		t = lwq_dequeue(&q, struct tnode, n);
> +		printk(KERN_CONT " %d(%d)", t->i, t->c);
> +		kfree(t);
> +	}
> +	printk(KERN_CONT "\n");
> +	l = lwq_dequeue_all(&q);
> +	printk(KERN_INFO " lwq: delete the multiples of 3 (test lwq_for_each_safe())\n");
> +	lwq_for_each_safe(t, t1, t2, &l, n) {
> +		if ((t->i % 3) == 0) {
> +			t->i = -1;
> +			kfree(t);
> +			t = NULL;
> +		}
> +	}
> +	if (l)
> +		lwq_enqueue_batch(l, &q);
> +	printk(KERN_INFO " lwq: dequeue remaining:");
> +	while ((t = lwq_dequeue(&q, struct tnode, n)) != NULL) {
> +		printk(KERN_CONT " %d", t->i);
> +		kfree(t);
> +	}
> +	printk(KERN_CONT "\n");
> +	return 0;
> +}
> +
> +module_init(lwq_test);
> +#endif /* CONFIG_LWQ_TEST*/
> -- 
> 2.41.0
> 

-- 
Chuck Lever
