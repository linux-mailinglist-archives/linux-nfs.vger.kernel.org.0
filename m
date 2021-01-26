Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF4304E60
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390695AbhA0A2z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jan 2021 19:28:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53880 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405261AbhAZUHO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jan 2021 15:07:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJxGUL077240;
        Tue, 26 Jan 2021 20:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LGPLfOeE+BvmOq7pAwaor/uvTFHgQCL69F4ufqrVeuw=;
 b=e/BcH/vWfSc5TIog+BNGo61HT5pzJMgq2G619aB+iYPpfn5kEcBsLhIIDlXXMV/y5/Fv
 kq5p3NgKAGS58OzL6acDKNROcnOB49/E15nCB7UmugmWIp6omo6JxGMXBL2h+OGRq2b3
 1j7uVql37t1qrkjrYOuCADFpmOEFkNBgESHg4LOmeDtiE1oMsYVUTf176q+obq6a0O+z
 r51OLV6Kz9LYLjKxE2X67w80CzkTD2WNlBoRzEDuxGeVti7KcCk4sEPyLOA6qDtdaa2n
 hov1gJz4Veri/wRMf5Awj6HKaTItTkr9Yn/RWsE22OgA4w33e0treUUuIg4GeRoHHe3i Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3689aam26f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 20:06:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJxbvu164953;
        Tue, 26 Jan 2021 20:06:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 368wjrm6fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 20:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgPM8JhHiXMCbl4nbPf/t6YUcFMe5iWnOU02V0GpPi2tw5LEvBvuIFQYfJoNqekb8jXY+ARW53mFNbbgQ1srQZsVqJE40hNXsfZ60HGavZ+MRoNtg+3tdYhNns14rz26riO8QuctNuffsbUf8oQa2RuBD7wRZZO+eaxHTCGOla7OXA8RIvWfGDMwd4TnxypdfbtuG5XzHmijH2w/UbEJ13qvbJurMyR3d1eCn6pXRG7dF3QXyO2/3mbzgF+mImQYPej4y8k5zjaL86Iixq8uyjk9czs/TXWZA8dyxatO4lxX7oLgR/uqrVKa0/3lcPmoqFZGo/FoWc7LMXReyNiKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGPLfOeE+BvmOq7pAwaor/uvTFHgQCL69F4ufqrVeuw=;
 b=YhmZLQ0Wf519BnC+PNspUXHGUi6TsmbvAwXa5yDI9L8Kw4DcbmyVfNWoM9HOh6/2kivNTgs7M8kBkTu0SslDmmveKQkrk9ZAclob3kvCeATM7DvM5QNOriRKvZB0Pnljcjq60597us5HwMmdhJXyZUjXIwkgcsZbCkz5GrJaN0YurMMxI/i7qJ9RU/JgrJ6uE4ZZGMff6KwVsUjhbKQLrfAjlYLJeCEPKHbP3ennly26krJJfklEsksrcQTb5t5aTDZh8D0LWv2jbVpwFMLT0v8+LFgKaETJzR82Rikf7UoGVg52ARbSOsMIDirlVUcwN/z7Jw6hWT/wbW0BhsFWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGPLfOeE+BvmOq7pAwaor/uvTFHgQCL69F4ufqrVeuw=;
 b=JqMD6ikyRhN/MXKERECJq8syjrdit/JbhudLYL39tpGskvhDSTIA/EpKMtKjwS1YLAJwqqEiqOued2kPgWD0LnKr5zjgZFsudWjFgVKpXWjnCBRqv0UnkVwH9MqGWi7CZB4UpR58DyOxhysRxuLhY7yw8ZPaLk2uA/GgAWt3o50=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3606.namprd10.prod.outlook.com (2603:10b6:a03:11b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 20:06:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 20:06:21 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4_2: SSC helper should use its own config.
Thread-Topic: [PATCH] NFSv4_2: SSC helper should use its own config.
Thread-Index: AQHW8SqGjbmtpKL2c06zEcYrSgDRXKo6WxcA
Date:   Tue, 26 Jan 2021 20:06:21 +0000
Message-ID: <DFEC5D4E-E28C-40E6-94CA-D05372DD8236@oracle.com>
References: <20210123015013.34609-1-dai.ngo@oracle.com>
In-Reply-To: <20210123015013.34609-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ce551d0-2bd4-4d0a-8177-08d8c235d9d2
x-ms-traffictypediagnostic: BYAPR10MB3606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB360639C46403A092A3E1FFE693BC9@BYAPR10MB3606.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DItC2Waj2rcGDfSErNC3zLrvdPQ23Z21/IOZyV/AY926ZjHSnQoqEB/CVJU5krC2LpeGz9JAzsfHFDad2SSYGcfA4Iac3nd65KWWDXVI9RoW83K7IkbF8MS88SRqXK6PkLVzTK6tgdntcWcj5XSJMA6b507MpFJhBx/6LweZVEVYSjY0tk7J7+dXu0qMXlMbqM4KP0pIl8ZpHxKYdJVsqUyFeIwKGQlzIvaLZGP7C4lQCNtg1W/V56Oc1a1EPYbEUFdfgATqnBrT7VPImfHTtJshSU9VARBt8QMkWHQcgqtvhTuycevEnrXhCTkghofp4Z2wPekBmO1shf8CMJUVnAXhx/uqncR2PoEcVxHYWWFPQbG8Bf9bv9UWhwaKl0GNNShpT4vm28+Lu/qln5ih4MM+M5wPwgajdz/3s7FRnq5kr1p/RSeOKJ82oQz49HUYhtda1+LdGAQjs6VWnSgIkN4feS6FUsbRZDeq0XL2T9aLMNP/+iO1FHrz+MLtzyZv+voEa2wPluttq2xB+G+tKu0oe217GHlAWRDZp5WQ8r4xQmoeMDHp8ySk5DoIjQPRoChdQ8pS1cdKBQ8usxBBMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(8676002)(5660300002)(316002)(76116006)(6512007)(6636002)(8936002)(33656002)(4326008)(2616005)(44832011)(54906003)(26005)(37006003)(71200400001)(186003)(66946007)(66556008)(6506007)(64756008)(86362001)(36756003)(2906002)(6486002)(66476007)(83380400001)(6862004)(478600001)(53546011)(66446008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OOFVNMbPInqsXPtvRGt66qMS9mV/2MDOiSYw9rLyc0TtmZbSgfWzIIuIsLOS?=
 =?us-ascii?Q?PSkYPwqJDGQ1oVjtkEwjLkmQDmmsj/9toX8oZJ3w7PPZTKhpqzCszb+k0aib?=
 =?us-ascii?Q?ppToqoS5DA4SXeIJsEvgowKOQhf2cCMKeyH47L0QBjYYaCcIod7YUUlBGJsz?=
 =?us-ascii?Q?n2wlTSmtz04d/jiq3UhXlGXQ4xXgEqsOkE3GEoFfXRCs4R14yHN50a4VVMW0?=
 =?us-ascii?Q?oYyeG6YY5PH96YkjV4ffxOVXVqwJ22uu74Z69J2WCKtw7XxWp89ohTeelU8J?=
 =?us-ascii?Q?H6HBHH/AJd04nhUzwisuCDyaOnVvTGRe2MVPbRPV1rZW5O6TlIGQdaKSPlu2?=
 =?us-ascii?Q?vzIAn2ANIruIKTYUhKQPZ4gOzLWriKQZIMhnY7CWc3rPlj7UrVHSiZpNONpp?=
 =?us-ascii?Q?YxLBEioua82dcXjey0vigvHpNYZHH5ZZ6z6EZSG5SERz6N1abbWbV3yYVwvw?=
 =?us-ascii?Q?TgeEfyRjeMBVYImR6ooGqGNYnp4xBgp5xag1hDQtfVfA7Y3DKNt57A5wxOwK?=
 =?us-ascii?Q?Mffvc1AOmfnuLo2Fvv5q9hxmT6t9E9x+nNGNxKJ4r/sEjVrFtwiyyKWFIxoF?=
 =?us-ascii?Q?LtFF5W1rxcyp9DQ016Ko5AYen06Kh+CyT9yXqLqqhOLcnLPizyMjvQQ69f0r?=
 =?us-ascii?Q?D3hrF7FqafNW1i/vM311i30p2DtG7ousScNF8Xk0OlGA5Cm6+ef8VIiN+J/y?=
 =?us-ascii?Q?sxY0GQFnUe2DRk6GQEM86Vls6yyKUctcneFdPkphaFl00iPrdKFoBFMGyh2h?=
 =?us-ascii?Q?BkRrCVW8oGXXO0hK1ZAgJaXnE9EKOgDxJmGvULhn6eqlrAvniDAVANH2CnX4?=
 =?us-ascii?Q?BIeiUWK6fEOwPlwNWbumeaY4L9WdRu+C6lqK8flhq3tTBVp5jgzEpbCGvHbF?=
 =?us-ascii?Q?nnfMTKyVP1N9lwQ+75/QpELXdI+FLlNwDg1x2Ythy/vnk2moS90DUeFolA3s?=
 =?us-ascii?Q?tF0mGNa2QlsdWVfZGDuJMTZPC/h0PQUC3B3oItfkro9M6S9hrDlbfZWQ29U4?=
 =?us-ascii?Q?LPhrhCdwbROFiNw6Aa86t2kNJWZWv7Xgje1l1JRaNneTnA5ObbjRqjmaXRpU?=
 =?us-ascii?Q?P0Csv5yf/dFYLQNmNMe79OX7eJxuOA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28BF2565FD01D548B0A519B581840CA5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce551d0-2bd4-4d0a-8177-08d8c235d9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 20:06:21.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d99nks/MVFRtQOLqbegSG4cRmx528vGRf+XLd5uLggeMouEpBrPEtmVVEEdqNaTUagCwmNhyeLGpfDYMUi5Ekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3606
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai-

> On Jan 22, 2021, at 8:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
> as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
> depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
> enabled. Also removed the file name from a comment in nfs_ssc.c.
>=20
> Fixes: 0cfcd405e758 (NFSv4.2: Fix NFS4ERR_STALE error when doing inter se=
rver copy)
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Thanks for your patch. It has been committed to the for-next
branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

in preparation for the v5.12 merge window.


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



