Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17047F060
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Dec 2021 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353298AbhLXRZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Dec 2021 12:25:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10848 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhLXRZx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Dec 2021 12:25:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BOEww3O002489;
        Fri, 24 Dec 2021 17:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6pPXoPHz6CyMzo6TIMux5Sd6slT6bM4baJCHSd/xmec=;
 b=JdJ+MAazKntwAlHN2/8cBck3K3SB4vJg7J8e/Mt1aHbW0pwaMAUqR6kQhQ/IfibU2jSS
 wU5KY7rWSrLKpJ4YHkBn8C7flfdCDZiGfzpDBDArC/vxeOryDgVCzrjun2hdDUObvBiL
 xGRN4fkwD235jaWPxwuqozXKSx20YauS/f8jG0rUlUqrZ+xbBROrk0XQeYHudAy6SkGc
 u+eC0mV8BmFb3lzBnMB2UKHb3We7LAdaujQ0vJ7BB3AsiUKFcEGt2x2oY8H9yPbesBa7
 NygF3IkQqXWRdlpfZe16M7vg6/H4WOmEe9wb4/Sjo5hnVx8yL9wVy3VkpvSQlCKp1lxf 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d4f6w3nw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 17:25:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BOHL28o042252;
        Fri, 24 Dec 2021 17:25:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 3d17f80tph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 17:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiI+DkrTWeR7tpfEiplT9zah/ul3SOt00aZ/uaMID/U/DdBCkZTIQshJBpt1KoAWOPGxQXWNKk0nJaY8lByUhF/I2ce2asnp1MtM+EUU1xaMo02JIZI7Zz8Fc21FY3fVdu2tqKH1/3GoSjyXnkU8TLXTaIXA8mh2vnJ81QUBcnw3gpvWVWkhRVDjQU2bOVmKU0KZY2h1tYulVWspI4RQTOCx2XH7Klx/YqvLshOpIA/pQgQIXqfAXZ7RdmgkyFHS0nA3gzZhdFMYFW0mZpvrKZTWFFpPhTTRLPrGheqH0n/FLWniWFNKuGhxUAy7QfAkw+U+zcSWaFvufUZEXY3U9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pPXoPHz6CyMzo6TIMux5Sd6slT6bM4baJCHSd/xmec=;
 b=fKtWkRoN9i+L8JSftNfuLBRodOHtlWOswyHJtWH3wBmTW84eqLhUNsJI47E6+mu73Nkwq+j0znUaj5tgMbw8AY+nQBhk4NJlwNfznTPp3rwRubncs/xGp0ya3gqV4Lcvirjr1VTSwtkFhsO9Pi7iUD0c9aVJ2Pg6PIj25CDi0PqGSy+pLr0rekixwV/9ZNAfQ7Uep7eckUSSst4Nd10xOOkaIxiruEol+hLezpysab5W4ZzSUFGhflhkF/RPVGsTycXkWi/PqdoETbDJtCEvcQEhlo6VdCEPYvqW6ZPGEWfpZMvXo6wdFXOEhDUl4K7EpdRgvnvdwECyzvgi6NLgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pPXoPHz6CyMzo6TIMux5Sd6slT6bM4baJCHSd/xmec=;
 b=yapoDtr92dhj+GJPao4WXn7TFflsaf3R3mVTL7KnSejFjfBlPO2ubs+WC5bu3qTVfOjZBTnan7p4bS5Y7J5tNT9uJPtbFrf/k8AMP7izb0znUZmP2DN+X52hC7ICFMwv+3oP+7MVYMtUbId5pjIL6tHGyWhP+MH5UErr+w9yBXI=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4988.namprd10.prod.outlook.com (2603:10b6:610:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 17:25:49 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 17:25:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stefan Roesch <shr@fb.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] add offset parameter to iterate_dir function
Thread-Topic: [PATCH v7 1/3] add offset parameter to iterate_dir function
Thread-Index: AQHX+OtLQT+7Nk4IB0WFiJn+eviOuw==
Date:   Fri, 24 Dec 2021 17:25:49 +0000
Message-ID: <06BA4A1A-2C07-446B-93F6-095D61A41A22@oracle.com>
References: <20211222210708.983429-1-shr@fb.com>
 <20211222210708.983429-2-shr@fb.com>
In-Reply-To: <20211222210708.983429-2-shr@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5feb8e11-da06-4cbe-5791-08d9c7026d97
x-ms-traffictypediagnostic: CH0PR10MB4988:EE_
x-microsoft-antispam-prvs: <CH0PR10MB4988FBCA0644ADDE84AFA528937F9@CH0PR10MB4988.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuw24hNaB9Ba3aXeMhZlKuV0A3pFXltr/rfPIfJVQVRtnZQQ8dtpsMzoDro5wDJcdu+E/llIiVr3qgDjnwpueXXrrceimY/kdE+/pDBJqzpnlz2ZcyiEMtB0qJaTt0cvG2i76i0Eo7NxyLLz1upIJUikLQOi3xlM7IkwXOyFBId4pNS6Sn4mwAI13H+Jg6LiKMn2gaxu3NvQwu4RgfYC+DHz4wTJNWrBR0wbDOwBHf6+5cJ3zUTY8+REdxriWEKTq0HNc21agQIrbw5V0eP/8KKIuvM33EKhu/rskHU0lVzDLMS8jxHBH+5EJhBzLxWtyl3hMIO4xjA7fVIXaV4Yvn54lCUIuKhPf3RgPe9TGIE5yhxiO7Ap7CuU12P+UbOYlQWDRYXS+igCmYETaYtW/NzlF81be4MygzO1MPumIXu8KYdk3H9nvbOZjENidXBrGyvUEJ16d1XZ9nCXVU+/shtXjjw6YrA2++15a4KUwRwZbEQSMA03U5LkafrT8Q+v5MUOMEV/jXt0pmSEx/4J2v1IWV2rtRTzNLXBp7GzRYwNSozLSDFc6nz5uheOg8UCUy4XMkUggfK08Ilnov2E7SNfe/iFPMaPSDkn9BxFOTakvJ/dGMhPhf/LvgiZqXyVdolYdYqRSjUAmA0xPXpJdStl4SqyU1Dxq0+WEgElpIvnXEyTOf8PV66H72FYIgBZfJO5vi09yutuN3IXuAXmM9IPw/l2vbswe5LJ8bdyibsO2CTS2DN5vDpcr9rw/yTe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33656002)(83380400001)(6486002)(316002)(53546011)(122000001)(6506007)(8936002)(8676002)(2616005)(26005)(66446008)(186003)(6512007)(76116006)(4326008)(38070700005)(5660300002)(66946007)(86362001)(64756008)(36756003)(6916009)(38100700002)(71200400001)(66476007)(66556008)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PTyIY8w7Sl9ZOiMTojODMhNlpVeHn8WpLGrpiHr98VnnrPf1l14SRwGpBbmb?=
 =?us-ascii?Q?Ze4oFiiidoCuDB0rwCUeLYjM56pr8BtogYvnDNniuyqMR7UR98uRnQnYed32?=
 =?us-ascii?Q?UFNzx0q97CiSiQtGyPRu5bm22s9w1CUBnr90fS9O2mCwemZZIe6TQJJuQohE?=
 =?us-ascii?Q?FLdrpqMgalCO6RhOB4Lo6ms93WFZ5rg0aIq2/EmhWT4qqpHoioZwoh7SSa7R?=
 =?us-ascii?Q?a25uQrMidpeHANwh6jeg8wj30ONRe6MDZTC6W/W+rEX2r++nOlyeOQooAGAY?=
 =?us-ascii?Q?07SE48rvdJ6jWyeD1UOV9Wh2Ezyzhf2dicL7JwyFG0G67zeXaRm3oev6rcP+?=
 =?us-ascii?Q?8o0YdhiAzBnHnTU09j8BEy3PB+FAllBNHS6wX9djhNdMWGZSB5Gv4i0G7B3j?=
 =?us-ascii?Q?+EXkMwsCRfDNKScX4Np1r4fehdTTdCicEK0xgA7HrNdHwFSKVyFNYceU6FqM?=
 =?us-ascii?Q?tBLxpAUcC+xTCJSEzrnNfum8J1/gcKJIUrpG7TyeZ+uvfJU50NOBUXYaOl3o?=
 =?us-ascii?Q?whAWJClne4lk5gizAJjXDYEJa7MDYaseWnSal4nVTvRyvtjMnrWZlTLX855M?=
 =?us-ascii?Q?ARBN1v0DQk9bonSbQSB0wjMwZwqpPDMk636OI2BOw2quaG8fYppIsEfB126a?=
 =?us-ascii?Q?P9OJDbhj+mg5jHQsVyXM6hsyxSsIDVG/8HnJrIcslhApOQzm9/RwU5U9RV+a?=
 =?us-ascii?Q?ttVaBupCYB6rCLPtPUL4GoTYNowaAGVb6slyRztEIqMOJ1lgffB81RUsLImr?=
 =?us-ascii?Q?iSAFjUcYgUPFRImKAWwJfm3E5MF4pUgwNsVAhs8PikP2w+JSegIaLoE/6WG9?=
 =?us-ascii?Q?MQVhonAXNvrBWRpWacOJTVjJJ1F/29Io2vG10A9s50pWCBiVrEi6CSMzLnm2?=
 =?us-ascii?Q?bwcMyBPYC3KrbibwzgkNDpRzJNndynjv8PjOMgzU5RHmtRSKLrBX1zSUdagZ?=
 =?us-ascii?Q?DcIkUbKq2o+Q52Z4t0heAlpg+x1cXAZLhn2qek2baIoeOC74ZR/ybgn7iDv/?=
 =?us-ascii?Q?neshmhimH7/kxFR5rz3dEBkAuTW7j20RCqR0zmV8llKn+CXU+BuKKq7FsnDC?=
 =?us-ascii?Q?8O1HbWcyb/pE1J1+TjPXhYzsDbREltAYeVwTSbQc8VOL8Ozf9u9CvtlTCNEL?=
 =?us-ascii?Q?tBzDCqVCrlLpH/ERoqokv13jyKFjnD75XGyByLl/ggumyq3TdzVVCDGkYE8d?=
 =?us-ascii?Q?M6SHWN02Qvea/rn2F84hhPBXhouJSAIXYhRVtPD31hfOBO/fLk9DcIfl/oCB?=
 =?us-ascii?Q?knDYstF55ubTURmzC2LrivomPLJOpvG51/HT9oc5wOFp2GabOP2/vhqlN8K3?=
 =?us-ascii?Q?ZMK8T021qdlixcHgm8k32HkQMgvsnMoa5MUDOpL2hhndUMPYDG06FEqb8dgA?=
 =?us-ascii?Q?4wHLC1/GaXrkmUEyHO1Ee8Z87fchYNqk9h0RGVvNwdNV83BhXcxPgkue1PIA?=
 =?us-ascii?Q?iNjFPUPR9lGNIRnlu64fIPJHN2KLAMaGTqOihd+BKajkmovDbfvn51HCxlId?=
 =?us-ascii?Q?WX9pCSFEkGuiIdm/qvCt1QKKdIxohWS4dbU5yjLd5DAxf8Nzr0XRb3U/6p3/?=
 =?us-ascii?Q?Hcd1MO6c/BmCqEn4OxQnnjhtMiVHiWl+t+mXZ3DvyVz8Ys1/xdKdQY7E9QHu?=
 =?us-ascii?Q?DOo28/krcR/+oWrA+lD6WRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E095B96F37164E4B96A752E7847168CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feb8e11-da06-4cbe-5791-08d9c7026d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 17:25:49.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /a2S7KCNqhLWFMfRVe1uOE94Cq89fpHCh4gjSseM0oT2cKLDoo5vDofrzlbwHzia1nUjxmo/jinNr3D0EiHYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4988
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10208 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112240084
X-Proofpoint-GUID: BZrdAcWHsZE7uHXSILuJ-Z01zY_rM6--
X-Proofpoint-ORIG-GUID: BZrdAcWHsZE7uHXSILuJ-Z01zY_rM6--
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Dec 22, 2021, at 4:07 PM, Stefan Roesch <shr@fb.com> wrote:
>=20
> This change adds the offset parameter to the iterate_dir
> function. The offset paramater allows the caller to specify
> the offset position.
>=20
> This change is required to support getdents in io_uring.
>=20
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
> arch/alpha/kernel/osf_sys.c |  2 +-
> fs/ecryptfs/file.c          |  2 +-
> fs/exportfs/expfs.c         |  2 +-
> fs/ksmbd/smb2pdu.c          |  3 ++-
> fs/ksmbd/vfs.c              |  4 ++--
> fs/nfsd/nfs4recover.c       |  2 +-
> fs/nfsd/vfs.c               |  2 +-
> fs/overlayfs/readdir.c      |  6 +++---
> fs/readdir.c                | 28 ++++++++++++++++++----------
> include/linux/fs.h          |  2 +-
> 10 files changed, 31 insertions(+), 22 deletions(-)

Thanks for posting. The nfsd changes seem sensible to me.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index 8bbeebb73cf0..cf68c459bca6 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -162,7 +162,7 @@ SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
> 	if (!arg.file)
> 		return -EBADF;
>=20
> -	error =3D iterate_dir(arg.file, &buf.ctx);
> +	error =3D iterate_dir(arg.file, &buf.ctx, &arg.file->f_pos);
> 	if (error >=3D 0)
> 		error =3D buf.error;
> 	if (count !=3D buf.count)
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index 18d5b91cb573..b68f1945e615 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -109,7 +109,7 @@ static int ecryptfs_readdir(struct file *file, struct=
 dir_context *ctx)
> 		.sb =3D inode->i_sb,
> 	};
> 	lower_file =3D ecryptfs_file_to_lower(file);
> -	rc =3D iterate_dir(lower_file, &buf.ctx);
> +	rc =3D iterate_dir(lower_file, &buf.ctx, &lower_file->f_pos);
> 	ctx->pos =3D buf.ctx.pos;
> 	if (rc < 0)
> 		goto out;
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 0106eba46d5a..654e2d4b1d4f 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -323,7 +323,7 @@ static int get_name(const struct path *path, char *na=
me, struct dentry *child)
> 	while (1) {
> 		int old_seq =3D buffer.sequence;
>=20
> -		error =3D iterate_dir(file, &buffer.ctx);
> +		error =3D iterate_dir(file, &buffer.ctx, &file->f_pos);
> 		if (buffer.found) {
> 			error =3D 0;
> 			break;
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 49c9da37315c..fd4cb995d06d 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -3925,7 +3925,8 @@ int smb2_query_dir(struct ksmbd_work *work)
> 	dir_fp->readdir_data.private		=3D &query_dir_private;
> 	set_ctx_actor(&dir_fp->readdir_data.ctx, __query_dir);
>=20
> -	rc =3D iterate_dir(dir_fp->filp, &dir_fp->readdir_data.ctx);
> +	rc =3D iterate_dir(dir_fp->filp, &dir_fp->readdir_data.ctx,
> +			&dir_fp->filp->f_pos);
> 	if (rc =3D=3D 0)
> 		restart_ctx(&dir_fp->readdir_data.ctx);
> 	if (rc =3D=3D -ENOSPC)
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 19d36393974c..5b8e23d3c846 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1136,7 +1136,7 @@ int ksmbd_vfs_empty_dir(struct ksmbd_file *fp)
> 	set_ctx_actor(&readdir_data.ctx, __dir_empty);
> 	readdir_data.dirent_count =3D 0;
>=20
> -	err =3D iterate_dir(fp->filp, &readdir_data.ctx);
> +	err =3D iterate_dir(fp->filp, &readdir_data.ctx, &fp->filp->f_pos);
> 	if (readdir_data.dirent_count > 2)
> 		err =3D -ENOTEMPTY;
> 	else
> @@ -1186,7 +1186,7 @@ static int ksmbd_vfs_lookup_in_dir(struct path *dir=
, char *name, size_t namelen)
> 	if (IS_ERR(dfilp))
> 		return PTR_ERR(dfilp);
>=20
> -	ret =3D iterate_dir(dfilp, &readdir_data.ctx);
> +	ret =3D iterate_dir(dfilp, &readdir_data.ctx, &dfilp->f_pos);
> 	if (readdir_data.dirent_count > 0)
> 		ret =3D 0;
> 	fput(dfilp);
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 6fedc49726bf..79a2799891e4 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -307,7 +307,7 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *n=
n)
> 		return status;
> 	}
>=20
> -	status =3D iterate_dir(nn->rec_file, &ctx.ctx);
> +	status =3D iterate_dir(nn->rec_file, &ctx.ctx, &nn->rec_file->f_pos);
> 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
>=20
> 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c99857689e2c..085864c25318 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1980,7 +1980,7 @@ static __be32 nfsd_buffered_readdir(struct file *fi=
le, struct svc_fh *fhp,
> 		buf.used =3D 0;
> 		buf.full =3D 0;
>=20
> -		host_err =3D iterate_dir(file, &buf.ctx);
> +		host_err =3D iterate_dir(file, &buf.ctx, &file->f_pos);
> 		if (buf.full)
> 			host_err =3D 0;
>=20
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 150fdf3bc68d..52167ff9e513 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -306,7 +306,7 @@ static inline int ovl_dir_read(struct path *realpath,
> 	do {
> 		rdd->count =3D 0;
> 		rdd->err =3D 0;
> -		err =3D iterate_dir(realfile, &rdd->ctx);
> +		err =3D iterate_dir(realfile, &rdd->ctx, &realfile->f_pos);
> 		if (err >=3D 0)
> 			err =3D rdd->err;
> 	} while (!err && rdd->count);
> @@ -722,7 +722,7 @@ static int ovl_iterate_real(struct file *file, struct=
 dir_context *ctx)
> 			return PTR_ERR(rdt.cache);
> 	}
>=20
> -	err =3D iterate_dir(od->realfile, &rdt.ctx);
> +	err =3D iterate_dir(od->realfile, &rdt.ctx, &od->realfile->f_pos);
> 	ctx->pos =3D rdt.ctx.pos;
>=20
> 	return err;
> @@ -753,7 +753,7 @@ static int ovl_iterate(struct file *file, struct dir_=
context *ctx)
> 		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
> 			err =3D ovl_iterate_real(file, ctx);
> 		} else {
> -			err =3D iterate_dir(od->realfile, ctx);
> +			err =3D iterate_dir(od->realfile, ctx, &od->realfile->f_pos);
> 		}
> 		goto out;
> 	}
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 09e8ed7d4161..c1e6612e0f47 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -36,8 +36,13 @@
> 	unsafe_copy_to_user(dst, src, len, label);		\
> } while (0)
>=20
> -
> -int iterate_dir(struct file *file, struct dir_context *ctx)
> +/**
> + * iterate_dir - iterate over directory
> + * @file    : pointer to file struct of directory
> + * @ctx     : pointer to directory ctx structure
> + * @pos     : file offset
> + */
> +int iterate_dir(struct file *file, struct dir_context *ctx, loff_t *pos)
> {
> 	struct inode *inode =3D file_inode(file);
> 	bool shared =3D false;
> @@ -60,12 +65,15 @@ int iterate_dir(struct file *file, struct dir_context=
 *ctx)
>=20
> 	res =3D -ENOENT;
> 	if (!IS_DEADDIR(inode)) {
> -		ctx->pos =3D file->f_pos;
> +		ctx->pos =3D *pos;
> +
> 		if (shared)
> 			res =3D file->f_op->iterate_shared(file, ctx);
> 		else
> 			res =3D file->f_op->iterate(file, ctx);
> -		file->f_pos =3D ctx->pos;
> +
> +		*pos =3D ctx->pos;
> +
> 		fsnotify_access(file);
> 		file_accessed(file);
> 	}
> @@ -190,7 +198,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
> 	if (!f.file)
> 		return -EBADF;
>=20
> -	error =3D iterate_dir(f.file, &buf.ctx);
> +	error =3D iterate_dir(f.file, &buf.ctx, &f.file->f_pos);
> 	if (buf.result)
> 		error =3D buf.result;
>=20
> @@ -283,7 +291,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
> 	if (!f.file)
> 		return -EBADF;
>=20
> -	error =3D iterate_dir(f.file, &buf.ctx);
> +	error =3D iterate_dir(f.file, &buf.ctx, &f.file->f_pos);
> 	if (error >=3D 0)
> 		error =3D buf.error;
> 	if (buf.prev_reclen) {
> @@ -366,7 +374,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
> 	if (!f.file)
> 		return -EBADF;
>=20
> -	error =3D iterate_dir(f.file, &buf.ctx);
> +	error =3D iterate_dir(f.file, &buf.ctx, &f.file->f_pos);
> 	if (error >=3D 0)
> 		error =3D buf.error;
> 	if (buf.prev_reclen) {
> @@ -379,7 +387,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
> 		else
> 			error =3D count - buf.count;
> 	}
> -	fdput_pos(f);
> +
> 	return error;
> }
>=20
> @@ -448,7 +456,7 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
> 	if (!f.file)
> 		return -EBADF;
>=20
> -	error =3D iterate_dir(f.file, &buf.ctx);
> +	error =3D iterate_dir(f.file, &buf.ctx, &f.file->f_pos);
> 	if (buf.result)
> 		error =3D buf.result;
>=20
> @@ -534,7 +542,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
> 	if (!f.file)
> 		return -EBADF;
>=20
> -	error =3D iterate_dir(f.file, &buf.ctx);
> +	error =3D iterate_dir(f.file, &buf.ctx, &f.file->f_pos);
> 	if (error >=3D 0)
> 		error =3D buf.error;
> 	if (buf.prev_reclen) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6b8dc1a78df6..e1becbe86b07 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3340,7 +3340,7 @@ const char *simple_get_link(struct dentry *, struct=
 inode *,
> 			    struct delayed_call *);
> extern const struct inode_operations simple_symlink_inode_operations;
>=20
> -extern int iterate_dir(struct file *, struct dir_context *);
> +extern int iterate_dir(struct file *, struct dir_context *, loff_t *pos)=
;
>=20
> int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
> 		int flags);
> --=20
> 2.30.2
>=20

--
Chuck Lever



