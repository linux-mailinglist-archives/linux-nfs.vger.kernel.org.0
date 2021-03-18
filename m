Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6CB33FCEF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 02:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhCRB4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Mar 2021 21:56:35 -0400
Received: from mail-eopbgr1320133.outbound.protection.outlook.com ([40.107.132.133]:19648
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230132AbhCRB40 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Mar 2021 21:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIdtIDs819vzexs9Ws42f73JbpJtgLhQiXaItirvL6ztJjG19Bndm1hwF8GL/w8ejqZC1/RRdeRIBKsjweMIZ4Z1EYf4f8FnyCnjVW5KXe9AD3eBHg+a3AA/tqgMFizXZBBTz3Wb0ZxGAf9B46QPy82fKn3gkSVSML+YrHjFyALi0uUjZycgukaI1Knjo/VWQ6Lvg7ZiEVFVNF9ivsPxGxWSIG5+TlWQjqUJnAKwqPYbUn6qBXM29Ix86/jFOmx6t2ofQp2VbUn5U18CXhMc5U+DLD0Br2KDrnl+6aMsWU7Vf37+cdhM44fMu5+D56RMgokvYk6xT7NBKPFMlfUW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+62YxsqNK9EzFtd2wEHFoqDvuYg5LetlLHtFd6v030=;
 b=f77duA0AQCR88TwTB+zx75K1MS+jo1jwNdC63jdOYKjyEzoCHV9lhlMWMrV1N/4T8JKVjoTeX8mYoNsHhsdn8cn0brGaMnrooJ4SJevBEGtatcbFoDHNqeog+iMWMJ6NkYoFbhC+o9lYR6dQOMoDCBQ5pp89ySGhulEFTc59ewa13Hd6WB8MTwNYWwTfglqrst4xHQ9Cc+nPAVtOHzqTYBa7VuqqDlVZj9EJgWd/66F7drALxhITAhYFEGqrqSKHQzd+0buIIyE7zb5DAbpZoI4pNYamwCu2zsPdJ2Cifd9SY8XXYa8XB2i193NcTFz3l1UOjMXZaGOmsiIhZV/Vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+62YxsqNK9EzFtd2wEHFoqDvuYg5LetlLHtFd6v030=;
 b=AR1cwvuOlLfkDzyKr4IOIpZByOKvjmX2ysAa0PJT+m45NyJak7ieU13rtoZ3H+/QiF4ZvAYeVmVrsRmsQJPdSwO/wF2jJVY17WQjETAJy/aXKPA0gwc54E72r1AX1GrwiIXkSIaUjKumrR2ebH4Xf+9SRXbwXM3aA4sO+LCe9vY=
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM (10.170.175.146) by
 KL1P15301MB0417.APCP153.PROD.OUTLOOK.COM (20.182.81.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.2; Thu, 18 Mar 2021 01:56:23 +0000
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42]) by KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42%2]) with mapi id 15.20.3977.005; Thu, 18 Mar 2021
 01:56:23 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [RFC] nconnect xprt stickiness for a file
Thread-Topic: [RFC] nconnect xprt stickiness for a file
Thread-Index: AdcbmG3Wy+rLrgPySr2+3WoogOFJyg==
Date:   Thu, 18 Mar 2021 01:56:23 +0000
Message-ID: <KU1P153MB01977184017092050048033F9E699@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-18T01:56:21Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aebff2e6-3be2-4bf8-aa79-6b8e560ea24b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f43ee328-f495-4624-f772-08d8e9b1087c
x-ms-traffictypediagnostic: KL1P15301MB0417:
x-microsoft-antispam-prvs: <KL1P15301MB0417E56AC3A070F70E25A4079E699@KL1P15301MB0417.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQaXbv5nxNN4ygYG+XAd+qXoduBZFYmcB5cT+w1i1dbR6/Rt9+GhlqD2IcfDfTn3XNjk40srvGIOPypaw/GRZgEb63pTKSyyr5Sav7gLUKTqkhfAzGQxvw4S4yymdbJQi/n2d1uJ7oAtbtqSqhpd4Iti4giDnQJhh6iNhAF5LVEKgXYMH2N11j1nwvRhZoOX/Ao1zHBvntdexJa7mhf8m89YYAg6ksK9Gf8TXyQswOla99UTgXbI2sruKUiDiP1a8vXIGK1o1enFY+PjXsf4+XCatbW+6RFgRedaqPLpnaPkgZgpFNlRG5/G6b3m/9yajx5cmH4T/8KOGIvVHxyjpMJ0Sd9+tlzdVrFXk/JKYwJMk2RdAhTmqGWvxXNyvaOO6DkpMldtO29g4H7rcfCXHDYBd4/KcABKmzt+tywZd15N/S6S94uy+HUkNft24C0LLAsJJ6MVwtaYPO0qfP64a2vhGO2w5XTQv9feqkJqm5Ri+b5+dOf88ToRZvFfrMqunBJQas+cWAM4KGbOOzao4pMtOQtoiwu3qelEzxSPJMFFMz2MaetI+mwmYDoHhvSepJJhKPOdYDYtiuMG1K4RIu5mpmmhB2wWdCKxeG3UpJ/zsp136zqgBVd42gMdO/ra
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0197.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(6916009)(66946007)(9686003)(55016002)(82960400001)(316002)(7696005)(8676002)(4326008)(30864003)(8936002)(33656002)(2906002)(26005)(76116006)(66446008)(6506007)(478600001)(86362001)(71200400001)(64756008)(55236004)(66476007)(82950400001)(66556008)(10290500003)(8990500004)(186003)(52536014)(5660300002)(83380400001)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mHNSMX208zeGXZ0LF83YWvNIxeJ/DFl8z/efkkS+Qkpbf1hp9tF+wFYWHil9?=
 =?us-ascii?Q?ZOeo8E8aYD0v0jyOwYOCXs8DmvywF4nxheFlXirD2xIOzLpZLrnbVIKgsbwy?=
 =?us-ascii?Q?bMfM0DgXLzuOymp7+JikXwCbSaqtEz0xzEovTItzrqHfjnSExDCzHaV31h0q?=
 =?us-ascii?Q?09/t+0ABduU0YL7FEZREiIar9MCQU1Z3oPGexHnbcHHS2xGBZQqqTeoO89l4?=
 =?us-ascii?Q?WpPkrxT0LFL7swVOSkakrzJK/EBr6KYC9LK1eKIAiOWjx+yA6K9mdFvrdMdY?=
 =?us-ascii?Q?XvdK04xIRSFaYXV7/eWUCXpDthE2j8+rIssmU+1WsHF0arHiB5Zqrn9FTu2I?=
 =?us-ascii?Q?IXzYapdp8EgLNS3SZEbd8mikJgV9i7QhNud6MyYdnB3ODvqxEuiVOedqZ3KZ?=
 =?us-ascii?Q?hScyuKqqOKH9z9qfiZ7PFIIDyV4r704VhJxo0SFLZM33gTO0ySPlIDT55jya?=
 =?us-ascii?Q?R5GTtvGtM6DemsoMiJNqWx8l2iB2jMikIKx64dZc1XoMaHx5MQ23LYGsQBdf?=
 =?us-ascii?Q?Bz1tfpmn9OXaNnTfArNtrzVK0OuDzYWf9Oz6T9eDNVOOaRY2xDIi7zuE44Ro?=
 =?us-ascii?Q?baLDBoTWcsmTW3Q0WNjo8dtd8LPd9uZzItsxdHKJU+VXKjAD6QbVSdMagKj7?=
 =?us-ascii?Q?M5EsMWD6Bkkfaqr+AIAj1/qcpBfcISTSaGKQf/TjZm93tAo86hPh/cSxdorP?=
 =?us-ascii?Q?RIfTVzmLrgqlJfyPMby7mre6H+1N2DD8OgDxhoHFS1yjs64O7+AYaNO8W8sl?=
 =?us-ascii?Q?FeiPJth+TtVB+71kfZlz+984D3tEFoaUqa7Qpp2wEGln36C6CIl3bJVjj7Yg?=
 =?us-ascii?Q?sIgmwRsKKDW0e6yeLCGA/K/e/O02RwQjEWpPQOmuOwtgh582KzdvUJ361j0N?=
 =?us-ascii?Q?810kavGccOdOHltDiYkwkQI6lbISZ0RHyewDIQKxuseiR6JLe4yjrYQTFndJ?=
 =?us-ascii?Q?qW0/PL8nW75OA820jBxv5IHSaOlZh0svPDsaRQ4vllQQEnUhu9u84i7S8Nf0?=
 =?us-ascii?Q?veVltAH6UADwPv1kXrCrSCqz8MLpjLpNeZBMIFnhupOFC1psHbLRnD4o33Rj?=
 =?us-ascii?Q?2lHKTabEN3y/jCOIO+pxPy0zLzGaNmePXisCbbAMt35T6HuA9Puqr1Tvg1zs?=
 =?us-ascii?Q?Ewq/4AnxhGDUeWe0cbMejBiuDju/42b0GQX/Y4YWEZBm7TSn0RNZfsWaVcR4?=
 =?us-ascii?Q?cCU9tN6WQ2udDnhj9fch6syUcrwPOR9kV7BGJTH6xPn0DzkpL2vrF5EXcu/z?=
 =?us-ascii?Q?epjfjfH0rzEC8LG4/zVsH/vKmQm1Ds19vLMUp5iTx4/tXKhiIxmCPd46nt99?=
 =?us-ascii?Q?5OvQtC7n1INrlK8xKP+IrweG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f43ee328-f495-4624-f772-08d8e9b1087c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 01:56:23.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDDVuyix3i5dznx87wsUjHa2kkJMGcjcBPIiVivDHAp+hmcn3AjTs1eUq1XKDyprbSJjseccYQKN5dnPwhXeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0417
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We have a clustered NFS server behind a L4 load-balancer with the following
Characteristics (relevant to this discussion):

1. RPC requests for the same file issued to different cluster nodes are not=
 efficient.
    One file one cluster node is efficient. This is particularly true for W=
RITEs.
2. Multiple nconnect xprts land on different cluster nodes due to the sourc=
e=20
    port being different for all.

Due to this, the default nconnect roundrobin policy does not work very well=
 as
it results in RPCs targeted to the same file to be serviced by different cl=
uster nodes.

To solve this, we tweaked the nfs multipath code to always choose the same =
xprt=20
for the same file. We do that by adding a new integer field to rpc_message,
rpc_xprt_hint, which is set by NFS layer and used by RPC layer to pick a xp=
rt.
NFS layer sets it to the hash of the target file's filehandle, thus ensurin=
g same file
requests always use the same xprt. This works well.

I am interested in knowing your thoughts on this, has anyone else also come=
 across
similar issue, is there any other way of solving this, etc.

Following  patch is just to demonstrate the idea. It works but covers only =
what I
needed for the experiment. Based on the feedback, I can follow it up with a=
 formal=20
patch if needed.

Thanks,
Tomar

---
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 5c4e23abc..8f1cf03dc 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -108,6 +108,7 @@ nfs3_proc_getattr(struct nfs_server *server, struct nfs=
_fh *fhandle,
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_GETATTR],
 		.rpc_argp	=3D fhandle,
 		.rpc_resp	=3D fattr,
+		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
 	};
 	int	status;
 	unsigned short task_flags =3D 0;
@@ -136,6 +137,7 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fat=
tr *fattr,
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_SETATTR],
 		.rpc_argp	=3D &arg,
 		.rpc_resp	=3D fattr,
+		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
 	};
 	int	status;
=20
@@ -171,6 +173,7 @@ __nfs3_proc_lookup(struct inode *dir, const char *name,=
 size_t len,
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_LOOKUP],
 		.rpc_argp	=3D &arg,
 		.rpc_resp	=3D &res,
+		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
 	};
 	int			status;
=20
@@ -235,6 +238,7 @@ static int nfs3_proc_access(struct inode *inode, struct=
 nfs_access_entry *entry)
 		.rpc_argp	=3D &arg,
 		.rpc_resp	=3D &res,
 		.rpc_cred	=3D entry->cred,
+		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
 	};
 	int status =3D -ENOMEM;
=20
@@ -266,6 +270,7 @@ static int nfs3_proc_readlink(struct inode *inode, stru=
ct page *page,
 	struct rpc_message msg =3D {
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_READLINK],
 		.rpc_argp	=3D &args,
+		.rpc_xprt_hint	=3D nfs_fh_hash(args.fh),
 	};
 	int status =3D -ENOMEM;
=20
@@ -355,6 +360,7 @@ nfs3_proc_create(struct inode *dir, struct dentry *dent=
ry, struct iattr *sattr,
 	data->arg.create.name =3D dentry->d_name.name;
 	data->arg.create.len =3D dentry->d_name.len;
 	data->arg.create.sattr =3D sattr;
+	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.create.fh);
=20
 	data->arg.create.createmode =3D NFS3_CREATE_UNCHECKED;
 	if (flags & O_EXCL) {
@@ -442,6 +448,7 @@ nfs3_proc_remove(struct inode *dir, struct dentry *dent=
ry)
 		.rpc_proc =3D &nfs3_procedures[NFS3PROC_REMOVE],
 		.rpc_argp =3D &arg,
 		.rpc_resp =3D &res,
+		.rpc_xprt_hint =3D nfs_fh_hash(arg.fh),
 	};
 	int status =3D -ENOMEM;
=20
@@ -524,6 +531,7 @@ nfs3_proc_link(struct inode *inode, struct inode *dir, =
const struct qstr *name)
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_LINK],
 		.rpc_argp	=3D &arg,
 		.rpc_resp	=3D &res,
+		.rpc_xprt_hint	=3D nfs_fh_hash(arg.tofh),
 	};
 	int status =3D -ENOMEM;
=20
@@ -566,6 +574,7 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *den=
try, struct page *page,
 	data->arg.symlink.pages =3D &page;
 	data->arg.symlink.pathlen =3D len;
 	data->arg.symlink.sattr =3D sattr;
+	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.symlink.fromfh);
=20
 	d_alias =3D nfs3_do_create(dir, dentry, data);
 	status =3D PTR_ERR_OR_ZERO(d_alias);
@@ -602,6 +611,7 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentr=
y, struct iattr *sattr)
 	data->arg.mkdir.name =3D dentry->d_name.name;
 	data->arg.mkdir.len =3D dentry->d_name.len;
 	data->arg.mkdir.sattr =3D sattr;
+	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.mkdir.fh);
=20
 	d_alias =3D nfs3_do_create(dir, dentry, data);
 	status =3D PTR_ERR_OR_ZERO(d_alias);
@@ -636,6 +646,7 @@ nfs3_proc_rmdir(struct inode *dir, const struct qstr *n=
ame)
 	struct rpc_message msg =3D {
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_RMDIR],
 		.rpc_argp	=3D &arg,
+		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
 	};
 	int status =3D -ENOMEM;
=20
@@ -682,6 +693,7 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr=
_arg,
 		.rpc_argp	=3D &arg,
 		.rpc_resp	=3D &res,
 		.rpc_cred	=3D nr_arg->cred,
+		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
 	};
 	int status =3D -ENOMEM;
=20
@@ -735,6 +747,7 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentr=
y, struct iattr *sattr,
 	data->arg.mknod.len =3D dentry->d_name.len;
 	data->arg.mknod.sattr =3D sattr;
 	data->arg.mknod.rdev =3D rdev;
+	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.mknod.fh);
=20
 	switch (sattr->ia_mode & S_IFMT) {
 	case S_IFBLK:
@@ -782,6 +795,7 @@ nfs3_proc_statfs(struct nfs_server *server, struct nfs_=
fh *fhandle,
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_FSSTAT],
 		.rpc_argp	=3D fhandle,
 		.rpc_resp	=3D stat,
+		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
 	};
 	int	status;
=20
@@ -800,6 +814,7 @@ do_proc_fsinfo(struct rpc_clnt *client, struct nfs_fh *=
fhandle,
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_FSINFO],
 		.rpc_argp	=3D fhandle,
 		.rpc_resp	=3D info,
+		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
 	};
 	int	status;
=20
@@ -834,6 +849,7 @@ nfs3_proc_pathconf(struct nfs_server *server, struct nf=
s_fh *fhandle,
 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_PATHCONF],
 		.rpc_argp	=3D fhandle,
 		.rpc_resp	=3D info,
+		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
 	};
 	int	status;
=20
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 78c9c4bde..60578e9fd 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -762,6 +762,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs=
_pgio_header *hdr,
 		.rpc_argp =3D &hdr->args,
 		.rpc_resp =3D &hdr->res,
 		.rpc_cred =3D cred,
+		.rpc_xprt_hint =3D nfs_fh_hash(hdr->args.fh),
 	};
 	struct rpc_task_setup task_setup_data =3D {
 		.rpc_client =3D clnt,
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index b27ebdcce..b1713d6fb 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -355,6 +355,12 @@ nfs_async_rename(struct inode *old_dir, struct inode *=
new_dir,
 	msg.rpc_resp =3D &data->res;
 	msg.rpc_cred =3D data->cred;
=20
+	if (data->args.new_dir)
+		msg.rpc_xprt_hint =3D nfs_fh_hash(data->args.new_dir);
+	else
+		msg.rpc_xprt_hint =3D nfs_fh_hash(data->args.old_dir);
+
+
 	/* set up nfs_renamedata */
 	data->old_dir =3D old_dir;
 	ihold(old_dir);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec..284b364a6 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1687,6 +1687,7 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct=
 nfs_commit_data *data,
 		.rpc_argp =3D &data->args,
 		.rpc_resp =3D &data->res,
 		.rpc_cred =3D data->cred,
+		.rpc_xprt_hint =3D nfs_fh_hash(data->args.fh),
 	};
 	struct rpc_task_setup task_setup_data =3D {
 		.task =3D &data->task,
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 0dc7ad38a..5d5b2d20b 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -10,6 +10,7 @@
=20
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
+#include <linux/jhash.h>
 #include <uapi/linux/nfs.h>
=20
 /*
@@ -36,6 +37,10 @@ static inline void nfs_copy_fh(struct nfs_fh *target, co=
nst struct nfs_fh *sourc
 	memcpy(target->data, source->data, source->size);
 }
=20
+static inline u32 nfs_fh_hash(const struct nfs_fh *fh)
+{
+	return (fh ? jhash(fh->data, fh->size, 0) : 0);
+}
=20
 /*
  * This is really a general kernel constant, but since nothing like
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index df696efdd..8f365280c 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -27,6 +27,7 @@ struct rpc_message {
 	void *			rpc_argp;	/* Arguments */
 	void *			rpc_resp;	/* Result */
 	const struct cred *	rpc_cred;	/* Credentials */
+	u32			rpc_xprt_hint;
 };
=20
 struct rpc_call_ops;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 612f0a641..fcf8e7962 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1058,6 +1058,53 @@ rpc_task_get_next_xprt(struct rpc_clnt *clnt)
 	return rpc_task_get_xprt(clnt, xprt_iter_get_next(&clnt->cl_xpi));
 }
=20
+static
+bool xprt_is_active(const struct rpc_xprt *xprt)
+{
+	return kref_read(&xprt->kref) !=3D 0;
+}
+
+static struct rpc_xprt *
+rpc_task_get_hashed_xprt(struct rpc_clnt *clnt, const struct rpc_task *tas=
k)
+{
+	const struct rpc_xprt_switch *xps =3D NULL;
+	struct rpc_xprt *xprt =3D NULL;
+	const struct rpc_message *rpc_message =3D &task->tk_msg;
+	const u32 hash =3D rpc_message->rpc_xprt_hint;
+
+	if (!hash)
+		return rpc_task_get_next_xprt(clnt);
+
+	rcu_read_lock();
+	xps =3D rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+
+	if (xps && hash) {
+		const struct list_head *head =3D &xps->xps_xprt_list;
+		struct rpc_xprt *pos;
+		const u32 nactive =3D READ_ONCE(xps->xps_nactive);
+		const u32 xprt_idx =3D (hash % nactive);
+		u32 idx =3D 0;
+
+		list_for_each_entry_rcu(pos, head, xprt_switch) {
+			if (xprt_idx > idx++)
+				continue;
+			if (xprt_is_active(pos)) {
+				xprt =3D xprt_get(pos);
+				break;
+			}
+		}
+	}
+
+	/*
+	 * Use first transport, if not found any.
+	 */
+	if (!xprt)
+		xprt =3D xprt_get(rcu_dereference(clnt->cl_xprt));
+	rcu_read_unlock();
+
+	return rpc_task_get_xprt(clnt, xprt);
+}
+
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
@@ -1066,7 +1113,7 @@ void rpc_task_set_transport(struct rpc_task *task, st=
ruct rpc_clnt *clnt)
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt =3D rpc_task_get_first_xprt(clnt);
 	else
-		task->tk_xprt =3D rpc_task_get_next_xprt(clnt);
+		task->tk_xprt =3D rpc_task_get_hashed_xprt(clnt, task);
 }
=20
 static
@@ -1100,6 +1147,7 @@ rpc_task_set_rpc_message(struct rpc_task *task, const=
 struct rpc_message *msg)
 		task->tk_msg.rpc_argp =3D msg->rpc_argp;
 		task->tk_msg.rpc_resp =3D msg->rpc_resp;
 		task->tk_msg.rpc_cred =3D msg->rpc_cred;
+		task->tk_msg.rpc_xprt_hint =3D msg->rpc_xprt_hint;
 		if (!(task->tk_flags & RPC_TASK_CRED_NOREF))
 			get_cred(task->tk_msg.rpc_cred);
 	}
@@ -1130,8 +1178,8 @@ struct rpc_task *rpc_run_task(const struct rpc_task_s=
etup *task_setup_data)
 	if (!RPC_IS_ASYNC(task))
 		task->tk_flags |=3D RPC_TASK_CRED_NOREF;
=20
-	rpc_task_set_client(task, task_setup_data->rpc_client);
 	rpc_task_set_rpc_message(task, task_setup_data->rpc_message);
+	rpc_task_set_client(task, task_setup_data->rpc_client);
=20
 	if (task->tk_action =3D=3D NULL)
 		rpc_call_start(task);
