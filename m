Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C278D825
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjH3S3e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbjH3QDW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 12:03:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A34193
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 09:03:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iv36008558;
        Wed, 30 Aug 2023 16:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=C2ZVifTXUUYoFvRNrCtHWMKHS0Zb/9c4EvGS/0aoJnQ=;
 b=zmwGyeOatd3YXKjvqvZhLpiKSvqFZUmfQZkmjRTBA207c28QtJGcVIhsyZwVLZweetDI
 mO+yDu3KRL8HMftXAqo85xjMuANPklDZg9wjrb3fvAYtlUTumECPRiW6sn54xJNUHDkN
 h0GJoNQexASzOqwNd9UtQqvw3DYrL0v8PFZXU+vHDX4OU65nsLE5evpB2LPCrPk8g4Iy
 U36jYgmfjsoGoBEYmk3N+RzctE5ztCr+ZATsmBubgoJ9GDsKqD8NksWUJ8am66xAcwQl
 NrHDYUX6NHnVuWfdgWcrGADUb39jz8ctTJ0UB5Kt5j8PJWpldecnqMRu0v3qkmwPZhe0 cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk7s6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 16:03:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UFC6Rj014337;
        Wed, 30 Aug 2023 16:03:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hpqds4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 16:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmKO7cKK36G9zh1ZqrZA4h4EXJ6xMLPQK2ECni/0G9f0kdSNhfymSkqGYM4+2qX6JjocelUdyHqElgB9/DsXya5jrBKby3NTqTB+R4VtYp69WacuXzNF0tV2HLTd2X94XFB0ZuzPxKf28qeeZj8OGU6/OHQXJxCtpJmAMHM3RoC1TOa6QjvfaIkSFKP//1cCCSU9njnJEI93C9D3e3uQNTAZE5as1kcZPhYfWimq5099aWN8Hqb/XmAry2Z0J4MISkw9Qp8nd1G4R7omQXP/s73DCjgqpL+MrFjsKW7F4Ueeg89vgGR0UCz4KFaqRIm2JXjcK7OMRogpZlFXcZUTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2ZVifTXUUYoFvRNrCtHWMKHS0Zb/9c4EvGS/0aoJnQ=;
 b=EJ1TP+c5KBxBYN0PLOyQ1+7U1knq6o7gb/PEQt8uDK4s1KjGEk2MRnHCvCrhhbrt5brurN3nTkAanY1PMeIBsSauhVJ6pHjunhgk8Gq4R4DncrCKPjekzg2KJveS+ayW5TNQn1ElFfZ8WgxRbz8VOK5p7qYrCtB8+ck1PGBVGg1jYcxAJ3ul1o7/KDxGvJnGLSuVJZIj5fd8BIwv8MFFpjAKf3nTQuE4CjYN6NRIoWiWHt3YiD9jmNQZPd5rrYRAkssrnn6pfmzZlbGYk6nC5XYQGVC/SfpJ1VGQtuTFkwIxFn1OxEgXHXF7ywvUTzrkn4+P4Z9FQEG2wXFrQPaW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2ZVifTXUUYoFvRNrCtHWMKHS0Zb/9c4EvGS/0aoJnQ=;
 b=LepRY1+1M88S9R8NvV9YM2Ha3tTkfNLE1LnDrKTlDZZjIN1H0ADv86f7RTlxAc72aqn489kS9DnjuU06A+Nssm98zT47GLWDARFQOsSi97Cr7Oq6+MZ5OrKS8puAeZgQn3/nBhDCDvHWHrm+w2571zBgYlMrYcNOaBrdHx/LSiU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 16:03:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 16:03:06 +0000
Date:   Wed, 30 Aug 2023 12:03:04 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/10] lib: add light-weight queuing mechanism.
Message-ID: <ZO9oOPno/Z8Is5Jc@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>
 <20230830025755.21292-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830025755.21292-6-neilb@suse.de>
X-ClientProxiedBy: CH2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:610:53::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e85d56-11d3-44ce-fe25-08dba9729944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqsrfgHs7s3Dlmf00bhkAngoe/ChtG47bbHPbBlHuHcmQtZkxyYKHaxVSHYVNvWufNlJwYYpJSsL4umn+yYxUMuurgcPi+rwptnqceXLehglPVxzei+ohOqKOleX9at5TO6XMFkZ8Ocr96MTKhQOSFHQYmonnbbVBQsQEowA+EPjhu7F13Z/IDyq4Vw2ReLJXmZxvlLYkjYSMt48/Nw1vOVsIdzRhe3En+n4N2FvHFzSx8ROs0IBwHLF6T6qtUaVIUN6hd0pXP4pQTX27+ZVaweBM2XOTl8U0/wTCAgMXfX8NT8H32fSoDkxo84av1wav52UwNKfRiVcosrAW0ivbuZ7qRvTjPirFUi0kvO2JtR3Jbgc0ksU1BDRWPIIUyqo3kBdcNTBdZG8+omqIT+HaVfA0PqGn3/HGFeg5gD55uT/JeNywuVbLYr3eAYQd12hkpgSFI/+K/l8dmSpWJhRUc2riOtqfc4FujwpPHeM7Ke0ET+mJRrT5lRJxyfJT4YJd9E9BuJIM7FtWYB9HSVs2FpTNLMqo7JNZI2zeTCmvQRItv7JDrDTE1+l9S6N9/mPsPdnRW67HHmjOv1DRSRbJ9P+0hCWUJ821c++s1FrCAWogP0w6SuQ4qzRyankZu+h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(9686003)(6512007)(38100700002)(316002)(41300700001)(6916009)(4326008)(2906002)(86362001)(30864003)(8676002)(44832011)(5660300002)(83380400001)(26005)(8936002)(66476007)(66946007)(66556008)(6506007)(6486002)(478600001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zCY0sC7+DG4UAa5JYAFRzFkouGZCPDlo5bn81GJkwQIIgf5akiRgvOOflhwH?=
 =?us-ascii?Q?/gq3J3P1R9TO94dDLJuGaBcVAtA3lX5HpzViRLKRvZApFeqN2ntzY4VEgg0D?=
 =?us-ascii?Q?EBssPrJjV2zMbBws5xnjfipuWZMordF3T2xYWJXbrt/I9HRznCOT4juw8ZDK?=
 =?us-ascii?Q?EtmCnaaycfngIUm0L/63TelzuhAEpFsZBJOCC0vZhtFk3GoBeUokhuHfAvDI?=
 =?us-ascii?Q?rUW8mXtFDB/5Uo8Bm6/c7/I3dnL9bKQSTnovpJdheCV7xqEwHeUrGiDWHKFw?=
 =?us-ascii?Q?WFIFHW9opok/8Fhe9vhaH7OH3K4J6XrIy1Rfn9KjwduvwiLVpnE0j9DBDG5O?=
 =?us-ascii?Q?CDuveWNoDTeADndN0lp9/Gz9nZOvsmmOMD5pzE55CK3zophUQb/1HSz/Yo+D?=
 =?us-ascii?Q?CtgkBHsuuuGoqQbMyXrO8ezGRPw25WZgREO1XiEuIkdMN8gx+A1Rk+BJ8gSJ?=
 =?us-ascii?Q?COmqeWgF7sWJ8Dz/HiKyYz4/g+fUSG8TkxLkHT14jEMikQZmCsfrkv3DfW1V?=
 =?us-ascii?Q?CFW5f1o2ENYZN/5wwGELuZNkNhia9BL9oBhcdeimnWWoH24oDAKh+TqoOnCg?=
 =?us-ascii?Q?BWdikJOg7Bir6C335wuS04ZVSXKVK1wluX11BGTAJ+5SZxckDDTrOAVuBKvQ?=
 =?us-ascii?Q?Lls90J2LV9qPuKHxrDgfCuu/zAIXlDvocdv5PURGyx9DiRfqZ6qciGkEs6Sx?=
 =?us-ascii?Q?wJYGVHs2GV7lQwfmF54YKmgw26Fj1RoluF/gOUSSWr+FnvtgOtEWXsz331/T?=
 =?us-ascii?Q?fDgQ+z3E2/rfk0+5JOWVs5o1rQEYgeSuv68jb6xAHwIDhJyaqWvB4zkG8XEb?=
 =?us-ascii?Q?MosYZYHMn+S+tT/zr5AHRamYycg1ckKn4e6fKyAVOTLFYrB8UwNYCQ5Js6i1?=
 =?us-ascii?Q?61Uvp+aqebeM2ZTWRLhmNmkt6aMHlKtpANnJi/LFjbVPTtk3DDKe0Viv4SWZ?=
 =?us-ascii?Q?TTybuefIl8pabKuhgJxZr6g1C8fKGk9kz9Y58rhx3xbZliWzE5Ir5lpTovgu?=
 =?us-ascii?Q?k6hEszDK178eEIvcbyKjxOwv8tCothzhWe4LRQ753Nlm6F92aEazpn3NblaA?=
 =?us-ascii?Q?SnRuyE9y8pYRWGC45uM92b5tbwIz7Ujtx1vwnmjzS82DPOW9+k8VEYJnkFfr?=
 =?us-ascii?Q?66pBgb+MBWattbhcrOutilsUaLO1Lc9O/AHWFUv2WQHISE+/U39ckYD292b3?=
 =?us-ascii?Q?nmmnDW0nAgEEFNxhiFmIaWblRZ7LZTFYwF+KFTGLLEtcFlWN17GeYnJloSD4?=
 =?us-ascii?Q?wGYonnY3glXGcK5SZw88SZlnWhnhpqIM1ttVaJKrOX8s+VNEw7ja6deQBc5X?=
 =?us-ascii?Q?tR/D6kFnVVVi6/CDRO19COhrOomTshui0tAHaEbpV9a+Hsm42wJzr6tt9cKH?=
 =?us-ascii?Q?y45quBR5n15iGOomYH5FHFpG7KrEB2//82+IX/uyb1KMwzvWVNbJFNWl/OmX?=
 =?us-ascii?Q?NgZOU2nZI1xz53F/FiTHYHHUTViKVfuDczd6oWBB+TLs7GLypaOfsQoULH+2?=
 =?us-ascii?Q?ZprPxmUDBmlGFa3E7hmHHGDrvussDL9z3WNoIghpoK67/gj1r+0XHX5Gig3x?=
 =?us-ascii?Q?qvbtWnSZGXySegSNeBtMrTGvRNbfNYIAGCGMKiL1SgvUD9XKS5+4eWIWizXY?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xa10ooZTSuUYXBy09+X35wtSdTPzoZ9cyJn6fTm9xm+h9tQJhpGt0du71RwYsnWml3mKUivaBarVSMcXb2kx879YK1pE87vIXc2aAzKGSOTR3i6dzBbpu0gfnaAObvAbQBddMIx008c0sbWq36ku2+1fxyXlP4AYNjr92Hi3XQwsyxSJccKwYLR8yh6w73GACNhVcivk3OSRWgLTmc+f+wAwdzj0+/YUuMgNQr4Gg0n0POVPAXYEEk4SmT1hSorV6b1R7T26M20S4l/pmD1xe6f7iCAhF6tTguRfX+OQ5dgzgDDvtLiNBVT9x/NYTDCOmRx3PKFOVgzarQc/9AjusdNyxS8hAvode4aD2b4jEjQbJju4q+huPchITJayCwVLMhGUZQoFfdgxzZoPqMXUZuz1Dy/z+kO3eHfgdgZTEYJNbWo4dT59ieDCbkSqoLLiH7gQxH69Z9M6m4PbTnixBOq0/KwI8lzvfklf46ujIZ/Dw4mgHTE7cozrCvzXTGGE2upSpAaOdAfq6jlHgaGUfD+Kzf0dQt4EyjR2kz1umuHs69LhPAkDHzXvRlZ67/1325Aafk5kxnZdVJM/Q/p+faaF5uQ6dqFDrUtYAn/dC5isHdgVoMoVK7SZ2u7tyHHhTT3SgHASL9E/zVOAODBN6jgJ45LDF7UHSAhl+E8hzFOG7t4DffIJwPwCi9P/wSQXqddSHdqRNpS6wCbwMakdRsiD40XNhGi3f5T6icutOZowkFxMaq4tOqxUNqiLm2wndHbb+gwfCk2wXDepoK6SElQtWZMviGCpXM1kyIJR3LC8yaAV55KjG1VvdKlYQKjd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e85d56-11d3-44ce-fe25-08dba9729944
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:03:06.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JChOYl6b3FJOF2QzzckGXuN53c+8Z9llpL+oy9xTJ3X41MfdCBleReAfnK3fDBcg+fpJKstF3ZDwDfWKMWjqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_12,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=873 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300149
X-Proofpoint-GUID: 4Tb3XEXGUeCRBFb9b_lCAi-jkAN1YvX2
X-Proofpoint-ORIG-GUID: 4Tb3XEXGUeCRBFb9b_lCAi-jkAN1YvX2
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
> 
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

ERROR: modpost: "lwq_dequeue_all" [net/sunrpc/sunrpc.ko] undefined!
ERROR: modpost: "__lwq_dequeue" [net/sunrpc/sunrpc.ko] undefined!
make[3]: *** [/home/cel/src/linux/even-releases/scripts/Makefile.modpost:144: Module.symvers] Error 1
make[2]: *** [/home/cel/src/linux/even-releases/Makefile:1984: modpost] Error 2
make[1]: *** [/home/cel/src/linux/even-releases/Makefile:234: __sub-make] Error 2
make: *** [Makefile:234: __sub-make] Error 2

You might need an EXPORT_SYMBOL_GPL or two now.


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
