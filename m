Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18433ED01
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Mar 2021 10:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCQJ3a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Mar 2021 05:29:30 -0400
Received: from mail-eopbgr1310092.outbound.protection.outlook.com ([40.107.131.92]:23146
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhCQJ3Q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Mar 2021 05:29:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6JXLun4BcyxZVAZfhER0iimEF3OLly7HS+f/7AkgJwBVaafWVDPUtqXqZxefUgPZtr4ZZI4HyojUGoYQ0s545NVeRKgrLQwBMC7eqEIyFa1esH5yubVhxx3FAA12n9tH9aF2OLlo40RhZjYSt8h/aRUK7J8zCn7RELFh8Sr0pAE5xszv17zNb2j5CKHVV0OTP0tJqKh+Q4WqF5EwAJn185TP+t9XYmkm+pyYVlj1AZdCRlv3Kl4JQDrn0Gea8I253Sjea/qbOe31Y3CQ73GiAXQU58a9uEDTKzvOsYFes698uJiIdIlLDlukdCzbeiJKNlmj2YrR2xasqQhIdytrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP2zktnl8ImPa3fF+9JAUa3oWTJhdl14zZcu7bsw23c=;
 b=FX/TJIISAQufrJ3ND8T5ozPWXonpWm8Uk56l/4ULrAw269OiDkwSwYi8JKFcgYb6ODrBmHF+7zt7sQSLFgaxxRscwe96C4xNUS3AR6SraaUxqcti332eC5PWF4QkCirs0bZSRuR/aGj2af5OivRrLTuvONnMA+vlgf/2KRr5ZJEVAUo95R2yudUVPK6ntbpclCieVyr+YC2F7wGMuGpRoZYfKdWIfgMVbzQDM/DVxKnQZm8c+gWvKCpARcvWyB3gCSQvLUz0RCQGesXtSYNDipPR+Y7fRnEvwFsJk8crr1zZJtFmYzF//fPxKSciHSv/vNahrE7LkBkQ/dIS8DS1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP2zktnl8ImPa3fF+9JAUa3oWTJhdl14zZcu7bsw23c=;
 b=QhWWz/lOLWZs2/5wZumsgopK9ZavMZimjrbVRcosqD0fxqc6Ua9j/+Kiqp+iSIOKli1+y//kQudsHVqQGDzcJQbZBT6RPiT8Ww2Fp3/+I1tg0JTM0z2Ob9+JCa+RkGQmb01we1WPeq16F0XkAHxW5eJ/lLbHG87jSsm3qRJngGg=
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM (2603:1096:802:20::18)
 by KL1P15301MB0344.APCP153.PROD.OUTLOOK.COM (2603:1096:820:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.4; Wed, 17 Mar
 2021 09:29:12 +0000
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42]) by KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42%2]) with mapi id 15.20.3977.005; Wed, 17 Mar 2021
 09:29:12 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] NFS: Fix handling of cookie verifier in
 uncached_readdir()
Thread-Topic: [EXTERNAL] [PATCH] NFS: Fix handling of cookie verifier in
 uncached_readdir()
Thread-Index: AQHXGmlShDXHBmMWxkiQPuK+CMYpjaqH5mWQ
Date:   Wed, 17 Mar 2021 09:29:12 +0000
Message-ID: <KU1P153MB019739728B8BC81A2D5FABC69E6A9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
References: <20210316133603.1228154-1-trondmy@kernel.org>
In-Reply-To: <20210316133603.1228154-1-trondmy@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-17T09:29:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ae89404c-2281-496b-a335-3140d41f493f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eba42655-64c3-4e62-1226-08d8e9272017
x-ms-traffictypediagnostic: KL1P15301MB0344:
x-microsoft-antispam-prvs: <KL1P15301MB03448A284D5D57F6E86679E79E6A9@KL1P15301MB0344.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3LyuUHSy4qjHbNenJDfIZT0S7hukyyRPDnXN7fjwMwjm8M5e920BKMo/y0eNA7XXwU2YVqZrHdOJtqXeS4V6FURAqhcA1Az576A+WwZqu9sBJIEux20d77eYhHLNpy4ZLZ29TcE4EfzVIgS3QANTpEfjmOTOcPymYp855gAiOVYqlNIR66n8G9CbcbN0+M3QbwkV9XRVi4N7bN+iNHSHNY9jRZalFUNmlXEkOG4HspyvmhPef8eFzqw6r9QldwnY86PhUthlrlWtmAHjCPv2UII1KekIFByOK0SfeNIKbtoRXcp2lPDaoTIkThtdxqkgN9FELzNU3bemRNTdLx/fY/IrUDNa0iLjWHY+rAWRvPoMjeKZiQqOAPr2j2K8h5YHVeSUuZhxC/Zc8MUjrZwUC3gYxCZwyWYaLFfnUY3HqMW/bb/+LypEgrbIq1IZEuxGx3b+4eg+hKdQO94N6l/juIFn8WlT6fNmkOOqsI1EClxZfpWz3g/dngOFhr9m1RX5xxcewJdMU7UHNsg9+RJOPrlSAjifoSWIyQpFgPpzKFDJ5G8IjfEubGFoifNWIine
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0197.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(33656002)(10290500003)(6506007)(4326008)(8676002)(478600001)(53546011)(55016002)(83380400001)(5660300002)(316002)(186003)(8936002)(86362001)(71200400001)(66946007)(66446008)(55236004)(66476007)(76116006)(8990500004)(66556008)(64756008)(26005)(6916009)(82950400001)(9686003)(7696005)(82960400001)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/z0OTKz+W0Y6DvJDhuIkRn397YTafEJWb/kK10/4yhplS329HFAAut/gVLc6?=
 =?us-ascii?Q?qd3p4W3JJdGBJgRESaERazOpTGOhsf0TpGOKNlF8tWG6d70tuhOOEXPkZ+GU?=
 =?us-ascii?Q?ZYpqz6NyNlJ5HlZQYw+DSI8l+/fM7XS3Mb4OjplYbMbrdgA0ydZYZsE+gH71?=
 =?us-ascii?Q?F/vaYxN6smQ+9FI/ltdGsU++t4hHVi++mHyjFVWENYMIRS1zShaVnGiFFktm?=
 =?us-ascii?Q?VzQ462uAIeQx+8irWi4XOVCcRcKeTkyzFu6hLdCvKGqK0jW0A8gXEFjDsmrZ?=
 =?us-ascii?Q?xhdxT03kUsGOxsStR9awXUQDsnLlhjQxQNfF99fmn5vymX9sTuDlvyuLaqVz?=
 =?us-ascii?Q?brJbdPK3WvFnYzsbHPNOPvFB8v14g/o3AmV2AbukFGBa6Lmn2SIbh8bfsL7d?=
 =?us-ascii?Q?5qqlT7P9g4DpCwFPgQ7uTlZSiRlsVVC64YfkLF8bZNUZz+55kwqz2xK4s32j?=
 =?us-ascii?Q?Er/OVUT7/NALUkiJlHcQ6pHBWAjskoGa5BLj/m6JJD3b34/AL8Y95TnClAtT?=
 =?us-ascii?Q?ZqexzpyCKzWVpRiKRbSq8VotazAl6cCK+L5jnZlQcDgebDMQ6UnAoabEwlUV?=
 =?us-ascii?Q?m1ATacFJR66I635jIGS9LdoY1UzsTJcucQCT3yDe8cbAsxTDgegJbKdOgOum?=
 =?us-ascii?Q?lBTnfGfFIVeuzpQACS1ECGDDfFz6axrynPWBgkhbYafNGSY89Fn6tGK3jqUK?=
 =?us-ascii?Q?Tk0rsMKqShN+cNc40xNFhzoy5g9LQojICWFHsLddVE9jbHEZGAQ6fk5eRc03?=
 =?us-ascii?Q?7eHV7uQgh4N5GGE4dXZLGCiqnUI9ZtL3IXi3eVqe9kmOtXM7052UVeXdF44v?=
 =?us-ascii?Q?X7XRrVIEbQHDMSm+PD9+QxlAePSn5G/gefLtxt5Yfbcgk0yvOX2D5xyMgqtM?=
 =?us-ascii?Q?JAzbKSSzoDUjLZOD3w8lbA/EDJYo/GmKYg8ZB0KPZQVLTABV//FwqFli2LFk?=
 =?us-ascii?Q?GFvSNhvj6iAF9k17kDYvdjHjUjjvldB0RaKkhPzKbrqDnh9xebTDdf3bJWWb?=
 =?us-ascii?Q?OyvjNyaRCWJiNQE9+TJBe9nm8RxOgtfa/KX2+w4GcAK7bqN2oPQ7/mX1t5LS?=
 =?us-ascii?Q?31C6QsqLdFlbHcCUcRAZl5iR7Pi+snL8cho0gWBypi6h5wqkosbGhH4lXDAa?=
 =?us-ascii?Q?pMfRUy89ajQg+H+rD0W4T+kLWu51fKn2n5Ct15ytT4sGM9ns3FNlCpbPeYeI?=
 =?us-ascii?Q?T2zf4/FhpzZC7r9KKC/JOE/0/kOOjCe1sRKTkIzi0GwpFzi6rB6nejCIND36?=
 =?us-ascii?Q?Q7QOhZn99v+5bW3wlCjTe9KGijMG3OMWr9VHAXQ186CwyjVUnPAQqTRVGRT/?=
 =?us-ascii?Q?t+ZqiK2SjEZm3LMoDW6q7Zxz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eba42655-64c3-4e62-1226-08d8e9272017
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 09:29:12.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8erEFGC4s1Vp3GvD0ZT2IJBTDZ9NoK4TSHueM0+Pxj+oNuvVVA7MLpt2wf0Sv9wTAeWfO31VHBB+wTuoZX0vmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0344
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,
     I think it'll be better to remove cookieverifier from nfs_inode, as tr=
uly speaking
it doesn't belong there. A cookie verifier (along with the cookie) is part =
of a readdir
context, and context is per open dir instance and not per file. Ideally we =
should have
the following sequence

1. Application opens directory, nfs_open_dir_context->verf is set to 0.
    nfs_open_dir_context->verf is used to populate nfs_readdir_descriptor->=
verf, which is our cursor.
2. The first readdir call using the above newly opened handle carries the 0=
 cookie verifier (with cookie=3D=3D0).
3. A cookie verifier received as  a response of #2 is saved in nfs_readdir_=
descriptor->verf, which
    is later saved in nfs_open_dir_context->verf. Thus subsequent readdir c=
alls carry the cookie
    verifier (and cookie) returned by the server.

What do you think about this patch?
It includes the patch that I sent y'day so only this should be enough.

PS: Currently find_and_lock_cache_page() seems to be accessing nfs_inode->c=
ookieverifier
       w/o locking the inode.

Signed-off-by: Nagendra S Tomar <natomar@xxxxxxxxxxxxx>
---
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index fc4f490f2d78..a52917800e37 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -76,6 +76,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_co=
ntext(struct inode *dir
 	if (ctx !=3D NULL) {
 		ctx->duped =3D 0;
 		ctx->attr_gencount =3D nfsi->attr_gencount;
+		memset(ctx->verf, 0, sizeof(ctx->verf));
 		ctx->dir_cookie =3D 0;
 		ctx->dup_cookie =3D 0;
 		spin_lock(&dir->i_lock);
@@ -820,7 +821,6 @@ static struct page **nfs_readdir_alloc_pages(size_t npa=
ges)
 }
=20
 static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
-				    __be32 *verf_arg, __be32 *verf_res,
 				    struct page **arrays, size_t narrays)
 {
 	struct page **pages;
@@ -829,6 +829,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_=
descriptor *desc,
 	size_t array_size;
 	struct inode *inode =3D file_inode(desc->file);
 	size_t dtsize =3D NFS_SERVER(inode)->dtsize;
+	__be32 verf[NFS_DIR_VERIFIER_SIZE];
 	int status =3D -ENOMEM;
=20
 	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -854,9 +855,9 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_=
descriptor *desc,
=20
 	do {
 		unsigned int pglen;
-		status =3D nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
+		status =3D nfs_readdir_xdr_filler(desc, desc->verf, entry->cookie,
 						pages, dtsize,
-						verf_res);
+						verf);
 		if (status < 0)
 			break;
=20
@@ -866,6 +867,8 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_=
descriptor *desc,
 			break;
 		}
=20
+		memcpy(desc->verf, verf, sizeof(desc->verf));
+
 		status =3D nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
 	} while (!status && nfs_readdir_page_needs_filling(page));
@@ -909,15 +912,13 @@ static int find_and_lock_cache_page(struct nfs_readdi=
r_descriptor *desc)
 {
 	struct inode *inode =3D file_inode(desc->file);
 	struct nfs_inode *nfsi =3D NFS_I(inode);
-	__be32 verf[NFS_DIR_VERIFIER_SIZE];
 	int res;
=20
 	desc->page =3D nfs_readdir_page_get_cached(desc);
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
-		res =3D nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
-					       &desc->page, 1);
+		res =3D nfs_readdir_xdr_to_array(desc, &desc->page, 1);
 		if (res < 0) {
 			nfs_readdir_page_unlock_and_put_cached(desc);
 			if (res =3D=3D -EBADCOOKIE || res =3D=3D -ENOTSYNC) {
@@ -927,7 +928,6 @@ static int find_and_lock_cache_page(struct nfs_readdir_=
descriptor *desc)
 			}
 			return res;
 		}
-		memcpy(nfsi->cookieverf, verf, sizeof(nfsi->cookieverf));
 	}
 	res =3D nfs_readdir_search_array(desc);
 	if (res =3D=3D 0) {
@@ -977,7 +977,6 @@ static int readdir_search_pagecache(struct nfs_readdir_=
descriptor *desc)
 static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 {
 	struct file	*file =3D desc->file;
-	struct nfs_inode *nfsi =3D NFS_I(file_inode(file));
 	struct nfs_cache_array *array;
 	unsigned int i =3D 0;
=20
@@ -991,7 +990,6 @@ static void nfs_do_filldir(struct nfs_readdir_descripto=
r *desc)
 			desc->eof =3D true;
 			break;
 		}
-		memcpy(desc->verf, nfsi->cookieverf, sizeof(desc->verf));
 		if (i < (array->size-1))
 			desc->dir_cookie =3D array->array[i+1].cookie;
 		else
@@ -1027,7 +1025,6 @@ static int uncached_readdir(struct nfs_readdir_descri=
ptor *desc)
 {
 	struct page	**arrays;
 	size_t		i, sz =3D 512;
-	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	int		status =3D -ENOMEM;
=20
 	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %llu\n",
@@ -1044,7 +1041,7 @@ static int uncached_readdir(struct nfs_readdir_descri=
ptor *desc)
 	desc->last_cookie =3D desc->dir_cookie;
 	desc->duped =3D 0;
=20
-	status =3D nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
+	status =3D nfs_readdir_xdr_to_array(desc, arrays, sz);
=20
 	for (i =3D 0; !desc->eof && i < sz && arrays[i]; i++) {
 		desc->page =3D arrays[i];
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a7fb076a5f44..ab3e666ed097 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -522,7 +522,6 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, st=
ruct nfs_fattr *fattr, st
 		inode->i_uid =3D make_kuid(&init_user_ns, -2);
 		inode->i_gid =3D make_kgid(&init_user_ns, -2);
 		inode->i_blocks =3D 0;
-		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->write_io =3D 0;
 		nfsi->read_io =3D 0;
=20
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index eadaabd18dc7..752de9e43e36 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -158,12 +158,6 @@ struct nfs_inode {
 	struct list_head	access_cache_entry_lru;
 	struct list_head	access_cache_inode_lru;
=20
-	/*
-	 * This is the cookie verifier used for NFSv3 readdir
-	 * operations
-	 */
-	__be32			cookieverf[NFS_DIR_VERIFIER_SIZE];
-
 	atomic_long_t		nrequests;
 	struct nfs_mds_commit_info commit_info;


-----Original Message-----
From: trondmy@kernel.org <trondmy@kernel.org>=20
Sent: 16 March 2021 19:06
To: Nagendra Tomar <Nagendra.Tomar@microsoft.com>
Cc: linux-nfs@vger.kernel.org
Subject: [EXTERNAL] [PATCH] NFS: Fix handling of cookie verifier in uncache=
d_readdir()

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're doing uncached readdir(), then the readdir cookie could be
different from the one cached in the nfs_inode. We should therefore
ensure that we save that one in the struct nfs_open_dir_context.

Fixes: 35df59d3ef69 ("NFS: Reduce number of RPC calls when doing uncached r=
eaddir")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 08a1e2e31d0b..2cf2a7d92faf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -976,10 +976,10 @@ static int readdir_search_pagecache(struct nfs_readdi=
r_descriptor *desc)
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
-static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
+static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
+			   const __be32 *verf)
 {
 	struct file	*file =3D desc->file;
-	struct nfs_inode *nfsi =3D NFS_I(file_inode(file));
 	struct nfs_cache_array *array;
 	unsigned int i =3D 0;
=20
@@ -993,7 +993,7 @@ static void nfs_do_filldir(struct nfs_readdir_descripto=
r *desc)
 			desc->eof =3D true;
 			break;
 		}
-		memcpy(desc->verf, nfsi->cookieverf, sizeof(desc->verf));
+		memcpy(desc->verf, verf, sizeof(desc->verf));
 		if (i < (array->size-1))
 			desc->dir_cookie =3D array->array[i+1].cookie;
 		else
@@ -1050,7 +1050,7 @@ static int uncached_readdir(struct nfs_readdir_descri=
ptor *desc)
=20
 	for (i =3D 0; !desc->eof && i < sz && arrays[i]; i++) {
 		desc->page =3D arrays[i];
-		nfs_do_filldir(desc);
+		nfs_do_filldir(desc, verf);
 	}
 	desc->page =3D NULL;
=20
@@ -1071,6 +1071,7 @@ static int nfs_readdir(struct file *file, struct dir_=
context *ctx)
 {
 	struct dentry	*dentry =3D file_dentry(file);
 	struct inode	*inode =3D d_inode(dentry);
+	struct nfs_inode *nfsi =3D NFS_I(inode);
 	struct nfs_open_dir_context *dir_ctx =3D file->private_data;
 	struct nfs_readdir_descriptor *desc;
 	int res;
@@ -1124,7 +1125,7 @@ static int nfs_readdir(struct file *file, struct dir_=
context *ctx)
 			break;
 		}
 		if (res =3D=3D -ETOOSMALL && desc->plus) {
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(inode)->flags);
+			clear_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
 			nfs_zap_caches(inode);
 			desc->page_index =3D 0;
 			desc->plus =3D false;
@@ -1134,7 +1135,7 @@ static int nfs_readdir(struct file *file, struct dir_=
context *ctx)
 		if (res < 0)
 			break;
=20
-		nfs_do_filldir(desc);
+		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
 	} while (!desc->eof);
=20
--=20
2.30.2

