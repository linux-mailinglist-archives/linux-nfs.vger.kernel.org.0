Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0973233EE6C
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Mar 2021 11:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCQKjk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Mar 2021 06:39:40 -0400
Received: from mail-eopbgr1320092.outbound.protection.outlook.com ([40.107.132.92]:23675
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230050AbhCQKjh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Mar 2021 06:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1j7zaC9MUmMvomX+UCuQEOustcQANzXGQykKEAIBfBHFjCF142C3bJLCorOHDK6yMzjrwMvvWHqd+/SiHPMMlg/BFdP2SS7zJMdjemqCdrvQEcF0OPSOutLSBGUlBUXrXAvZNXQVhDV0g97U/4jDqHBolZJIVyOu2k17QUAtV+vGVwsf6cN3kQ27Tf/zeHTc7MgRC3jS7d3uE90jPb3KUjBiCYoTmg3lndsJ7w6V5FwGFGL3EwXLFsq5m6iV+om6v3EJIaWRD5/ELtPcOFiBfWcRWpLolRMz9J0nnXXee6bOFHmVQGE3OwoJQaoSZpMzpuTbxZ/nTbAnCHEjwxkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afk00X/7kGXkRfMAb4kvQP1KQsXyH+YmVVqd18YgBEI=;
 b=ccAaGk6EML7F+D/qXGF1pfeAbssBwnC02+x1vjsdoB+QU8QG/WhLRYFaPpCy6r1LALg+qvn6Usmu5a5p0SJDB/GRR9W88cSOBtkem7PhfUhMYzb928lZvQriE8X7esoe3+FBYrf9UkM5G5jnx3U3Pb3q1a9+iWhkCw9fbvvHyMNs5R7C6RrQUbU7kq+ODFtHExaWGlM7CTSGGsk2bB9XPSoXWPZXqBpCtN83hwfdCowWGAoSbFDxPquvq545UqTUOTEKnZAtGMmFdmJoXAUklf4irS9a+BcQr9IazKA0Zy+TbivM0TqExTFhUrCgxDPJbBdUGlC4o1PBUI/FVnJ5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afk00X/7kGXkRfMAb4kvQP1KQsXyH+YmVVqd18YgBEI=;
 b=At4FYKh9NhCvCcSmkJRuxy88p5Bg+cCnkqA4TTWCCpydNgVKtye35wU9KBPi7YkXmitx3iQPUWWAV7/h8fmAlyX7bw8qXS78bRov86MUh1c3J+RX50lSFcTWzwEQZ3bhFT6WLLtxL4Ojncfpnj6nmhy+teNTK95SXLXpLFqZyy8=
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM (2603:1096:802:20::18)
 by KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM (2603:1096:802:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.5; Wed, 17 Mar
 2021 10:39:33 +0000
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42]) by KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42%2]) with mapi id 15.20.3977.005; Wed, 17 Mar 2021
 10:39:33 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] NFS: Fix handling of cookie verifier in
 uncached_readdir()
Thread-Topic: [EXTERNAL] [PATCH] NFS: Fix handling of cookie verifier in
 uncached_readdir()
Thread-Index: AQHXGmlShDXHBmMWxkiQPuK+CMYpjaqH5mWQgAATm9A=
Date:   Wed, 17 Mar 2021 10:39:32 +0000
Message-ID: <KU1P153MB019740C5B86FFA134C7458DE9E6A9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
References: <20210316133603.1228154-1-trondmy@kernel.org>
 <KU1P153MB019739728B8BC81A2D5FABC69E6A9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB019739728B8BC81A2D5FABC69E6A9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
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
x-ms-office365-filtering-correlation-id: 4cb2b3d5-8b7c-4785-1b5f-08d8e930f3f4
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB0039DCE7119D06CE48CFC2B49E6A9@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ess/1tlnfbtxeHsTdOICcD42H1PPHYwcqwgx5OV8Ud+Uwu3HHMltFpV3txqrkxsFkGYoKbI/yW41tPrItimVA0m+ex1viBRy8aejGC8h8g5L2kRVVUEwY9VEu/yvTfAIREv4RYyE68S1lFbwot0aRUY+gJTmUoBF4hDYu4dyuVS23JhgAMbqJj+iK5ucLQJqw9prtr4eEQT0CrgwDCjpqLYNyBbi1m1mvdRAVw7B0fLVg8+q8GPmZNsMtFxih0q++SdjhflPDhZDDrSA0Z/cAYTmGd0h/6BkBLSCyyqfDI7pokc11iBbj3rPZlt7Z8b4pEZK2eCPxw6o0T/nULVkerQiDn7zbw3YVN9sVrYkGl8U77LUArOagBixVvSVGYLoD3xO7WJWYbkseNkW4as8vbhRYR49tT7I7mOKqvy9+sC2l9X35jsxdlrhGqk/TT2cRi9yPQ8lCQtQxPkc7sk0RTOC5YpaOlRqDXmvEZwuwu6bCNxDo8jRUDtiBwi6iQZ4OeRYoUkwQgxkOU0QkVfrieNKw5K6SqwDkFdU5otugin/HmlQPu9/9+DnDYJFh49A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0197.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(52536014)(66946007)(186003)(66446008)(26005)(478600001)(71200400001)(66476007)(64756008)(66556008)(82960400001)(55016002)(10290500003)(76116006)(316002)(83380400001)(8676002)(2940100002)(8936002)(2906002)(82950400001)(86362001)(6916009)(55236004)(33656002)(6506007)(5660300002)(53546011)(8990500004)(4326008)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ddxkhNfx51Eyhs2kA8j8YBF8UAJi4WvXERuyLhLD4xlAn5LzEZpcux44QN6Q?=
 =?us-ascii?Q?EibASp07Uv8dvuYPts20cjxywn4nofHl8VCWw1AdjR9T4km/OGUUd4U7Z+g9?=
 =?us-ascii?Q?eymhGgUoPIswkDVFifBUklBVBeSNcy+ugYvncdz2tZ5HTktaRqhwLc4yNJn3?=
 =?us-ascii?Q?JIhXswzI06rGuZyJikP8QAVTOLjKkHKNNbgGOOVlo16GQHghawLcb5sshjZO?=
 =?us-ascii?Q?N1O6+qwVhOka2pr1hA/h/MSgx6EIrqFqJs1UnoSXq7sLwv9TJ/HDmBCHt1Xs?=
 =?us-ascii?Q?fgfitjDineDxHspT0bvKMZ0PBZ3G8ATwkSt4grQ4GiyEVH67vJc7LAMBeV6c?=
 =?us-ascii?Q?vf5FL2NPflFSCgeCc495RGK1MyQB+/EM5h7vuFFn0i0k2kGhrtXkYRzsfAFx?=
 =?us-ascii?Q?vszcTAACpDij0U5V1wY0QKEsd2lUqvBw+mcZm7B+tut4VqmaZTc0NqWP/hkS?=
 =?us-ascii?Q?iPX4bTZ6JK5q3r5DlRdCaJFuoZ3/kl+d0FkbTgElWhH2zl2f8ddlNlF03euS?=
 =?us-ascii?Q?T5q94Qal+/BxKHBFCiQX46yRlRZEKlkezbkk2zoHS4zyDB+rX5xuT8V+anP/?=
 =?us-ascii?Q?OCGYvue2o/GiI6FmUJc3/Xr+wIWCn+vnNHYnAU+iEwdm+RELNy0R7lns90kP?=
 =?us-ascii?Q?bSnq4QnEHj+Axz84FDgzttQp6lWxCuMH0VAvil3d+9GOi/SAykz/axfF5rUU?=
 =?us-ascii?Q?YtTmB0xnelf3DjFr+rnWs3vilCY8Y/YO2/ymrIxqIhK/NVJE+BvLp+O46qpc?=
 =?us-ascii?Q?0W2Ous1TouhPlcXQ7RDWOQK9FcP9pyWinDsb/lYS11ipKQoeLY0BhtzmD1rF?=
 =?us-ascii?Q?DQU2j6oeZBRxnT6EnKfu6JqOf+RdeIeadQ15Atk+RtU10gSj8pWr1FtqL9QX?=
 =?us-ascii?Q?8+ZbpIG/YwlBAAhNgaA5jAvWe0AwLr+pyGXy/IqMC6fGswzWDqlLMv+1BYdn?=
 =?us-ascii?Q?CPu5iweyMvheg56a4yyQFbdN7kN1gmkuC39xUbqbL14s4v7QooZ6fi8qRa5d?=
 =?us-ascii?Q?eMDsGDPN/btwoXRkpPHSa/nT44Ga5geCLp2gIX+effPPjBmloiyK8xhxdt5s?=
 =?us-ascii?Q?G+MItozVKL1Cfgjtebi6OhppbQzSYUTIyq2R6MzuXIbvKYn1sQ1mSNaNj15l?=
 =?us-ascii?Q?toDl5BXhklPy0rlEiMHSXmrqYZTpzF+8Z6LimYiEwr+RMr7qasXkwwV4XlA5?=
 =?us-ascii?Q?u+ga9DGg0qNJzvSnk3OoMgDOYN9emOI2G2Bh77+za+BAZ3pJ1l9gyX9rWXjp?=
 =?us-ascii?Q?d1ITO6yJ8Ebdh78hrPLppE/9oGM0oiQmt1fbpRcdb626CRt6IL2D71CtXso4?=
 =?us-ascii?Q?H9Ejj0dSv36qzs1CosDu5voS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb2b3d5-8b7c-4785-1b5f-08d8e930f3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 10:39:33.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6jaCnNUIkEIqFnKGyTTq/kzMKpj77TshOonRJZx2yWZbPmdwZZi6nT1sggbutcXolNZ+ONCgK/jgC59f6s9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0039
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ignore this, we do need the inode cookieverifier for the cached cookies in =
the absence
of any open dir handle. I was clearly overthinking!

I've a question on your patch:
If the server changes the cookieverifier for a directory, shouldn't we zap =
the
cached directory pages since the cached cookies do not correspond to this n=
ew cookie
verifier for this directory? Or, do we depend on the server to return BADCO=
OKIE when we
present a bad cookieverifier+cookie combo, and then we invalidate. I guess =
that's fine too.

Also my earlier comment about find_and_lock_cache_page() accessing nfsi->co=
okieverf
w/o locking the inode. This one is not introduced by your current patch.

Thanks,
Tomar=20

-----Original Message-----
From: Nagendra Tomar=20
Sent: 17 March 2021 14:59
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: RE: [EXTERNAL] [PATCH] NFS: Fix handling of cookie verifier in unc=
ached_readdir()

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

