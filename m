Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC31E304A45
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jan 2021 21:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbhAZFG6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jan 2021 00:06:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36602 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbhAYOgE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jan 2021 09:36:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PESdJ2018978;
        Mon, 25 Jan 2021 14:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uw42eO9RU9tk3roJEunlgyycbJvigLnvuSER8siWQCg=;
 b=ji6rJTkhe07k+AKKtML6UKfq4DWIefy9N+ERxZqbq91CPP3OQ0xN3fwUflJGesRDppg4
 7YAmwerL/Fz5Yxftnn95vvOZjIQ2ZGz52bd7gx1FaEpUjBAoTaTc1ul/JgxXqqi7bO4+
 sNa0U42NbfyzhkNGpevSLzfZgt2kxPW9eJRwYnM5db3Uih3q6ve3jE+KMiJyS4FFCgBL
 uonL7ACWDUlTwkgcal5l5wDsS49bR2OSO1op7FATE0qY/fpS4z9nR3Iwcae/tptV7+OU
 9KIiIWo1glzpGdgHKd9pqm7WW2XjHrb+6L8fAvLLH2Kao5f1CjKxNCkZshpa2+va9FWj gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 368brkdfa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 14:35:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PEU388061516;
        Mon, 25 Jan 2021 14:33:01 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by userp3030.oracle.com with ESMTP id 368wqv1pgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 14:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnlZykszMbPb5bUA9QNyJ5AgBXsOthcHK19U6UI0DJzi0WvCJOj530bojYx0Icp5UKDNwQdHPTvEP05uUwgYf5aAU/GT9cseVOxyvE1jAXQQXG7als+yeA7rS4QPKbh01jhygMIw2tFbXMmEXUUxd2evG8M6IrUgeHNEEz2YkpCCEEt8/EU+qgrlQBAIm0R/gSRy3pEgNdvopc8UBu8lrmbICHNJ70czq0z7NYL1SQYuEX2hmlKPCGosLcullG9p5VJ5dYLdtNep/XjZOFqC4AA2wvsAJ3KQNzYrTGOOdSXK7UUuzhaR5WxBlkCDSqMr8w73K4aLLhCisRYTU7Z0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw42eO9RU9tk3roJEunlgyycbJvigLnvuSER8siWQCg=;
 b=PsRVaVMNn81aTmJPk/5Mq1E2IrTKfK8av513pTbIhXa2aviuMbONAmQ8z3da5t7CGHcl7sMWkOrtW9W0ujS2MnqkJqjS9JVFdXtusXir1dmvm5fP9KS1jyPrQ6KhFyw6UY2oJTRjze2sYEDwxsobVRH4EgRJiwMYphiXQ2h4eOrUEBvfa7Jp+PqM+RkvRAIYuQLQ1a+CLUDvKHWJt8nb+MMx+GkvOu4s5cPxRJ/UlaXJyX4c1yKdvOmHkjOtgW5YXU7GUtL0jr8OTnHkS/pcoyAxXUKSqO3Ehf5yAPP7oSjmNBtyZqciRX+kKPHVtpsvxW+R1+3wJPx9sEbA6izRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw42eO9RU9tk3roJEunlgyycbJvigLnvuSER8siWQCg=;
 b=PpFNc/efQ16QMz9AL2T/z7EDjSnpqR9ZPZfGHlyl+gkt1eXZx6caN9nhIj+FD39BPTYF18yTSLFdiSxgO+OI/CzstCe/XsClNWoQhnesc4qdVJ8fZ3A2thYK2NSQTtWkE99CKfw8tKKug+4+WOjzlIZhW3fJENm4X+GG6q5Ej7Q=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 14:32:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 14:32:58 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4_2: SSC helper should use its own config.
Thread-Topic: [PATCH] NFSv4_2: SSC helper should use its own config.
Thread-Index: AQHW8SqGjbmtpKL2c06zEcYrSgDRXKo4a54A
Date:   Mon, 25 Jan 2021 14:32:58 +0000
Message-ID: <3F738386-929D-403A-9876-1063C52BAE4D@oracle.com>
References: <20210123015013.34609-1-dai.ngo@oracle.com>
In-Reply-To: <20210123015013.34609-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7640891-bbe6-4e07-25a4-08d8c13e1cc4
x-ms-traffictypediagnostic: BY5PR10MB4131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB41319C6CC4594C0F18D0C20B93BD9@BY5PR10MB4131.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qQMYy72V13+z5ssP1HyO2JaC00ywfqHKr5OxjhRdSL7J73nEqOFcV9i18jUd6qNt3/CovFLrbX6Y3JS/Sx2awfgXLvLdCpMXoeFiIaGwB4bqu2vdeziJB40lfusKlimj1A3WhIW7gzaYrsPtIuuCbJLWLtxZnZi0FJUG3Qh5s1WVpnhAQnvRk4r0hNXpLb5wgsmUP9GGoxwOtOgDT3AbcIU73+EMuCwYaZgFasXetvseHparOH+kACXZ9tEKhvxeY2JIekr5sZi0fxbS5gE7VbnEv4c9LOwLu7L08EOFAbqpeM1fipSwQDP+IZp0h0ZmtRmLuREI4005ZBOTiZagJzqLTaIARR7f8oAvgqJoA1sXefQktzwfLLRnhCS6QiM2gzrdJlc6IdUb7quD6GGXtFnxuvTBl2+mbe0DshDkHKyXKRc5AnfWNcLjldKS7xmrtsXFQX9k/yarbIPNFQ50PV6jKxvgtKthsipjdHmkaUqE9NQGehohN/TSWtT6yqrTK54VNVdQ+IGAUvHMUzny9PUsYSMNX3rZrgASx4P93h7YaYCmw5zEKgyTCdRvOyYcmxHACmwoEUF7qOlW9KYZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(6512007)(36756003)(83380400001)(4326008)(26005)(53546011)(110136005)(8676002)(6506007)(6486002)(86362001)(44832011)(66446008)(478600001)(2616005)(2906002)(76116006)(91956017)(66476007)(66946007)(186003)(66556008)(33656002)(64756008)(5660300002)(316002)(8936002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dq1Qjd1dExZBhRyCTV4fOu5jr8V+7TxCpMpl+Mgl9DQTncO9eLSEZ5vgYUrn?=
 =?us-ascii?Q?4qEBEI6FdxSdoG5JcXJpu/jhHrZt96+YjBXyfA6wh6R9uQHvzSl5jxuteFhM?=
 =?us-ascii?Q?03nqAzfNHxK2qp6ET7a6Zzm1tdTe6Qpn0ZZPl09en75LcawNszLSZfTNKMcD?=
 =?us-ascii?Q?nt/9KS4S9O1AUrmEXaBgpmthcDyVKyKXScWRjRF2n5PkULvJVLwbcKqenLx5?=
 =?us-ascii?Q?4tfCV3afe8efIMg+QrzFBtEelJyaG4SQJa9kwuiywPYr8C9w7booPczsIrTL?=
 =?us-ascii?Q?mCVKx1DjEdq2eO1wG8kvwYb1dYl/p4VHxw2LZV33NE1e1Re+l9AbG068KcBt?=
 =?us-ascii?Q?bQpqWxh5dzWdCYVAXQaiRII8GWupSlBNU4VZZsHirVHJ8f8pdqn36AueNC9+?=
 =?us-ascii?Q?njdxr1zqKV+7vl7dL/s4Xb2Lh1+7opoRjxgUQ3uF7zAjGAARd3NtHd9uKU4g?=
 =?us-ascii?Q?ZMpdR7GRQxxoUMdExG3sAisoeggkWmsFLoTvO0EGRT1p6OiV7QeCcYLO9Hg6?=
 =?us-ascii?Q?YWnr29C2y+dviY+89f6Nz9KxggXSZF+FvY0CIuKvBTvt0XUCi+DfRDjSAB5l?=
 =?us-ascii?Q?hPX19ttje7nRJbeEPj7D/8ujvMB7HlGsOowMNboSC2sbBM1OFdSoD9Avh6T4?=
 =?us-ascii?Q?/006NZgRSPcFejPpIrbeBAyOsQNV59SGXAQkYRMihbmuTYwMTrCTHZOwlH6L?=
 =?us-ascii?Q?Nzq1ZhiL6Lo76rDsAWFVo1AXn3hcpwrxECQB9bSi5YTjfmugxwDtQo5z+TMn?=
 =?us-ascii?Q?jup3ZQNmXwtfDdnGuSUkXNZ52qOs0kppOJLOlT4op0puVCX7h/UGNPlc3rTT?=
 =?us-ascii?Q?13bYWNqGpuqSz5jTq6dq15SWY6MkAnHoQB+AsFFilgjFHH6I4xFDbRb2VO1U?=
 =?us-ascii?Q?yIxH6V/By3rEuPeiX6EXmQZ7nvvTBCcr+DjYQHBMQse3FY/Xvu1ADvi92FVr?=
 =?us-ascii?Q?0+SHCIrG/jsyekG+VqYy8s89gvbKQDmbveAGwBOe2LArZdwwMlPvz8wUc+TO?=
 =?us-ascii?Q?T1Rj?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54A76859D010A947918BFF553BD01704@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7640891-bbe6-4e07-25a4-08d8c13e1cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 14:32:58.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pelm66kG8KsbKmjO461EeG5ujte1KQyEu63lG1CrsfAlGPbQ50/20LHUxDcsBn74/IYD62AEUGY4FSPukVDAzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9874 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9874 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250084
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 22, 2021, at 8:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
> as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
> depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
> enabled. Also removed the file name from a comment in nfs_ssc.c.
>=20
> Fixes: 0cfcd405e758 (NFSv4.2: Fix NFS4ERR_STALE error when doing inter se=
rver copy)

This patch feels more like a clean up / refactor then a fix,
so I'm not certain we want to request an automatic backport
to stable for it. Dai, would you mind if we dropped the
Fixes: tag, or is there something I missed?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/Kconfig              |  3 +++
> fs/nfs/nfs4file.c       |  4 ++++
> fs/nfs/super.c          | 12 ++++++++++++
> fs/nfs_common/Makefile  |  2 +-
> fs/nfs_common/nfs_ssc.c |  2 --
> fs/nfsd/Kconfig         |  1 +
> 6 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index aa4c12282301..d33a31239cbc 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -333,6 +333,9 @@ config NFS_COMMON
> 	depends on NFSD || NFS_FS || LOCKD
> 	default y
>=20
> +config NFS_V4_2_SSC_HELPER
> +	tristate
> +
> source "net/sunrpc/Kconfig"
> source "fs/ceph/Kconfig"
> source "fs/cifs/Kconfig"
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 57b3821d975a..441a2fa073c8 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -420,7 +420,9 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt=
_ops_tbl =3D {
>  */
> void nfs42_ssc_register_ops(void)
> {
> +#ifdef CONFIG_NFSD_V4
> 	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
> +#endif
> }
>=20
> /**
> @@ -431,7 +433,9 @@ void nfs42_ssc_register_ops(void)
>  */
> void nfs42_ssc_unregister_ops(void)
> {
> +#ifdef CONFIG_NFSD_V4
> 	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
> +#endif
> }
> #endif /* CONFIG_NFS_V4_2 */
>=20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 4034102010f0..c7a924580eec 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -86,9 +86,11 @@ const struct super_operations nfs_sops =3D {
> };
> EXPORT_SYMBOL_GPL(nfs_sops);
>=20
> +#ifdef CONFIG_NFS_V4_2
> static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl =3D {
> 	.sco_sb_deactive =3D nfs_sb_deactive,
> };
> +#endif
>=20
> #if IS_ENABLED(CONFIG_NFS_V4)
> static int __init register_nfs4_fs(void)
> @@ -111,15 +113,21 @@ static void unregister_nfs4_fs(void)
> }
> #endif
>=20
> +#ifdef CONFIG_NFS_V4_2
> static void nfs_ssc_register_ops(void)
> {
> +#ifdef CONFIG_NFSD_V4
> 	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
> +#endif
> }
>=20
> static void nfs_ssc_unregister_ops(void)
> {
> +#ifdef CONFIG_NFSD_V4
> 	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
> +#endif
> }
> +#endif /* CONFIG_NFS_V4_2 */
>=20
> static struct shrinker acl_shrinker =3D {
> 	.count_objects	=3D nfs_access_cache_count,
> @@ -148,7 +156,9 @@ int __init register_nfs_fs(void)
> 	ret =3D register_shrinker(&acl_shrinker);
> 	if (ret < 0)
> 		goto error_3;
> +#ifdef CONFIG_NFS_V4_2
> 	nfs_ssc_register_ops();
> +#endif
> 	return 0;
> error_3:
> 	nfs_unregister_sysctl();
> @@ -168,7 +178,9 @@ void __exit unregister_nfs_fs(void)
> 	unregister_shrinker(&acl_shrinker);
> 	nfs_unregister_sysctl();
> 	unregister_nfs4_fs();
> +#ifdef CONFIG_NFS_V4_2
> 	nfs_ssc_unregister_ops();
> +#endif
> 	unregister_filesystem(&nfs_fs_type);
> }
>=20
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index fa82f5aaa6d9..119c75ab9fd0 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) +=3D nfs_acl.o
> nfs_acl-objs :=3D nfsacl.o
>=20
> obj-$(CONFIG_GRACE_PERIOD) +=3D grace.o
> -obj-$(CONFIG_GRACE_PERIOD) +=3D nfs_ssc.o
> +obj-$(CONFIG_NFS_V4_2_SSC_HELPER) +=3D nfs_ssc.o
> diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
> index f43bbb373913..7c1509e968c8 100644
> --- a/fs/nfs_common/nfs_ssc.c
> +++ b/fs/nfs_common/nfs_ssc.c
> @@ -1,7 +1,5 @@
> // SPDX-License-Identifier: GPL-2.0-only
> /*
> - * fs/nfs_common/nfs_ssc_comm.c
> - *
>  * Helper for knfsd's SSC to access ops in NFS client modules
>  *
>  * Author: Dai Ngo <dai.ngo@oracle.com>
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index dbbc583d6273..821e5913faee 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -76,6 +76,7 @@ config NFSD_V4
> 	select CRYPTO_MD5
> 	select CRYPTO_SHA256
> 	select GRACE_PERIOD
> +	select NFS_V4_2_SSC_HELPER if NFS_V4_2
> 	help
> 	  This option enables support in your system's NFS server for
> 	  version 4 of the NFS protocol (RFC 3530).
> --=20
> 2.9.5
>=20

--
Chuck Lever



