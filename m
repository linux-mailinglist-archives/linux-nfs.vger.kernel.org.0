Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46B4307822
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 15:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhA1Oc6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 09:32:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48616 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhA1Ocs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 09:32:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SEOj8m049729;
        Thu, 28 Jan 2021 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8zhCQffk/+Irl8JvfXYR7ZjaYvAjY9tzS5Lmc+TSKy4=;
 b=f0qxgAu6I+5gY976Y0OQphblyZLj7gSwZ6VUxURHWLvbCW3jiat0SqVoIoP0ZtFOpx3n
 qyZoDwDYfIF3QfwdYYttg/jIJvuYbllEo6A1fSEkyxB4c9HQlfKH1FD9TdnPq6BVbix/
 UrnwJfTtOgsOSFBCe3eEeTc50H9mEoiogpEejFfdV1Y0G/dcJqCq16BpCrIyOPr4tWlj
 sTnrjjkkJTklMUTcXBHNEn5hjOSk4W+7fYk+QEa01GFe6QghFy+G/dy1OMTvXGdXII/C
 /RWvKBxY86Dc9O7HFAHLeTT8FlMimk+BW2xD/3haEyHjhqIcP1WGBOr2AbFJ5pHW/YWG Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 368brkvayq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 14:32:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SEPpZe084625;
        Thu, 28 Jan 2021 14:31:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3020.oracle.com with ESMTP id 368wju4x4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 14:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRlxFD88I/ScVfBzyjBpeYZ1wLgI5H0MsY8DrogMQuJ2YamUHxvA+xbtQO3CgYd4QVnVyOgSmc/RF3xmGXCXNaNZoWnihv6TSBwZ/fPzkH/q0yqLllJuxVRKODc18QBZqBqXtPcJ9cgIXb01Mtdnj3SPYxWOerF3fOja99fJFVB309pKPgoRQRmR7XNGaFxkzAoEbw9a/s9PFdYwDJ81sen+xFPCLI3b616uMyQ+ldSpkKtWGzwXpOdThB7IYBX0v7Uxcog/LfuYISHH4wYNgqtDFCCOil5tScONgghZqaJnU3NGhOyL3dd/Q4qeGK3m7m+3JAUQftKUA/GSnKPV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zhCQffk/+Irl8JvfXYR7ZjaYvAjY9tzS5Lmc+TSKy4=;
 b=RI0Q4tTydcIa0qxyc1rONpSD5QMvcgPcmsn0Qn/Mjg8QobeuZdHj/jcYnCMSw1Wb+Z5VaZGsqBI4rAJdA1UKjgnvKB8r6O9WnPE6AFxwI6L0xYm/a7u3s7xQrkWKjQNz9gwq/ys/Jt7j1m1QK8aalxZSf00MGe2BZC9fhmx82BFmbwfGfiVprQcnhiVX9LiYKp0dAjm0uPidTrAhxue/iX4fZ7J3qrCxpR5vcobHoFqsvyhVe0ESU6hqGTHMYePqKR39lLpvK5Y7TwXo0ujW6UOOe7dzd8yarVh90ai55Ix27AsZiPYoHm44dxnuInbFIsbm++3cz0pAenC5DDPHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zhCQffk/+Irl8JvfXYR7ZjaYvAjY9tzS5Lmc+TSKy4=;
 b=OeTc/f+JbXF+0FBK/MlhILOxfUAYs2WYnewjJFzsirpDTwj19EPK9qgKGl2ABmfONBjCKjkGfI3zgDKsR+ON2/4R6CT4C4nSFTpdQCNqNMsGiN6h6SZXb8jAGnI4uxqCCs/+6/UTgn4p/aJFPw0cSHWuhsB6D9KzxCEiUzoJ9Ts=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 14:31:57 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 14:31:57 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSv4_2: SSC helper should use its own config.
Thread-Topic: [PATCH v2] NFSv4_2: SSC helper should use its own config.
Thread-Index: AQHW9UDLvddb2ajGdU+XwVdIMDGfbao9GiYA
Date:   Thu, 28 Jan 2021 14:31:56 +0000
Message-ID: <AA89E90C-36BF-4302-B782-765B2CF389CB@oracle.com>
References: <20210128064226.85025-1-dai.ngo@oracle.com>
In-Reply-To: <20210128064226.85025-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8f55dd-53ac-4dd5-be77-08d8c3997740
x-ms-traffictypediagnostic: BY5PR10MB4210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB4210059F8948475FCE23ED7593BA9@BY5PR10MB4210.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWvxnZHgsyFsXX6/aNVq03GdQdIi6PwUIKHWtLjNgQ/EVDNAf/2w4m9/m4fl0JZJGtgWLNHvrxn3HAH8HK+bXMEbmbA+PbLGYNJZO/ZV80BGycIAdkxe6hxY9yB3E1/R4JHWYGhHDZusIWjU3GkQ4y1F/0rMGaQelDoZoAtbmCLIkofyxAKdZGLi4h3m82iv9xsR3o01rD12EML9E3bcWRBjuaWG6Ta3EotAGdZAUmHmhpOFN5mWdBVazPqTh/bI5wODBmJVKhjpCdulPqP3YP2q9IIiQFInErDgLPxeBLrcnAqbYVP87ELtOc28t8ma8ebCK3ReWp6Tkl/pSpO/A6rjCyws30gx3hgFjtYejEk6JVfMp8c0MEEMnj38O8EhsnbTKLjhlKCXAvhgnhEaaGi14OAvDkJte67lAFVjEQNG6btmzWnjqhmQN0Y7eCJrQkUpmAy9xsHJgqB9RvBDdzYnsMOKRHNRwFVYSYS9QVnl/TIHJGLBswEpAecSHD7+VHelYFgC2MosaaFSEVXNta95IwZJqEMyWMEYZnYrIfxeYYq43shifkwYuSVEYc1eXsJy7kQmYdT7RecgOOGqsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(76116006)(66946007)(71200400001)(54906003)(91956017)(8936002)(44832011)(2616005)(86362001)(53546011)(66476007)(186003)(5660300002)(316002)(2906002)(8676002)(6506007)(36756003)(66446008)(4326008)(83380400001)(37006003)(26005)(66556008)(64756008)(6512007)(478600001)(33656002)(6862004)(6636002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YQi+rJgSfJ0irX4CX6xlILoUlqdTlQTBKhXnbqwV1IaMSYHxHSas/oVcNHEe?=
 =?us-ascii?Q?DnudAyfFie79UqmElg8gFeewOV4YXz0Nap4w8gY5IVdd2nMjHGmfoRWQj/X1?=
 =?us-ascii?Q?k3/gBQcPxyb2sgp3YgtLb19Zlm3unPL47U24thh3f1mqMUqgew/TOECoJyGe?=
 =?us-ascii?Q?wjTuURZqe6+ljHvw4xVewNyXqSRzvvDr1mZHtudaaXEAU2diZxld7AiVRNmQ?=
 =?us-ascii?Q?qwW2GUuXbNoJJqUfePZWskofTJPnFTgOrL++ySZTODvotNBpW3i4oT2OsNYY?=
 =?us-ascii?Q?kNDN2HTu7C/Vq1WJW9F7JDjvfPVsIGb/YfjmUVx6sVkCx+HNtOIAPnriu1mt?=
 =?us-ascii?Q?ITuAI7ZAgefjEWT/1keRIdH92qfAgb7uUk3DrUjNYM6X0cRgIWcqSeKfTBD8?=
 =?us-ascii?Q?sagTbC2sIAAMJralXzzrtoZPJUoZ2h4M+BfeFujbOLkv11hSHz9igy0hPUC+?=
 =?us-ascii?Q?2J9vS9OnVUnHepAm/nG7fgup9TBkoDKZpF2BONxWEg5QKWlzrPsAy2jWoUxx?=
 =?us-ascii?Q?b3oTNg+6sHRkqJaaXUTyPeA4kvOcE4+Aewq1RWhgBupiHQW2mJd94m5lj+yz?=
 =?us-ascii?Q?yol9VeseHOw//20ct4P9z6A6SR1/l5BVb7xvARWO23hTIQZGEuzkYkFI2iCO?=
 =?us-ascii?Q?dEFk4Pqr5q2ZI/xB2vwj2qKiI3hrXkUIwVuS8eUSYaAoefH8RQqSyFrXRjhU?=
 =?us-ascii?Q?H6LcuCFwm5zkv7pWGHCyuJhLXPkMnJqNQv8t0iMmaPvzJ6iMYjf4Mt/P7p18?=
 =?us-ascii?Q?bitIUqmXGlkhLsag7aYmGH+pVZ61nUUjFoJTbiiwZ4OW25B41+chKFpfbWAm?=
 =?us-ascii?Q?TGA7P8RwZANU5ak3R1VVNtp7yFlQyhx6vx9d9EmMTA1P1CKEQddmsED3ULWt?=
 =?us-ascii?Q?A7sqNlPQWWya/UU3xVNErA1kU62q+SKxmv5VyTC1VK1ryLsNV1dcGBAFdTpw?=
 =?us-ascii?Q?YvyK4Udta9Pe+F7INoesY/esXOCMyP4qTy97KbzpdI2MrMKGz0h/lVdj7vx7?=
 =?us-ascii?Q?Sb1xC47wWepETAj0e3AC6ReLcXpD6FJ9Ve45ut6TAHXuZ8lfI3dEyVWgVRQ6?=
 =?us-ascii?Q?f9wkYg7P6/A35DqbFlq283kyQrnweg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EA00B2D6872274F994A515EBED0E69B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8f55dd-53ac-4dd5-be77-08d8c3997740
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 14:31:56.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZziQxh1PQ5rsxZWSQRkvx88LbqtrK0n5Xe+WnUZagnWv/XQE9TrD+0o6SZVNAVxFzKSETkBjczXG7zxh0Ddpzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280073
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280073
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dai-

> On Jan 28, 2021, at 1:42 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
> as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
> depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
> enabled. Also removed the file name from a comment in nfs_ssc.c.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

v2 of your patch has replaced the original version in the for-next
branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/Kconfig              |  4 ++++
> fs/nfs/nfs4file.c       |  4 ++++
> fs/nfs/super.c          | 12 ++++++++++++
> fs/nfs_common/Makefile  |  2 +-
> fs/nfs_common/nfs_ssc.c |  2 --
> fs/nfsd/Kconfig         |  1 +
> 6 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index aa4c12282301..a55bda4233bb 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -333,6 +333,10 @@ config NFS_COMMON
> 	depends on NFSD || NFS_FS || LOCKD
> 	default y
>=20
> +config NFS_V4_2_SSC_HELPER
> +	tristate
> +	default y if NFS_V4=3Dy || NFS_FS=3Dy
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



