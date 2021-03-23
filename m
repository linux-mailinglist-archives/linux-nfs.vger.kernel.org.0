Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30079345781
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 06:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWFst (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 01:48:49 -0400
Received: from mail-eopbgr1300091.outbound.protection.outlook.com ([40.107.130.91]:23605
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229493AbhCWFsp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 01:48:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYmYvrG56O4+k8x0fJWg1+Xgw8cTijnjJCwpiffYRy6NZKdxAepfmeXes78KZyV4E6ojQ0XN79u0Gk7Qvwl/q8yH+JPB0S0nCLK/l7NCJuUa1otDp6V3mE/eHg5KhCHG1DRp7QBZMA5AMF04NjMl/ExtJBoxO5RR/XZ07tFGxs0MxlBd+yW3/Cmij7zk2GyaegdObcv6rkt7//H8hwr/9yGNLseNQj72QvlCTgbMs68eV3C4IVZu6+59Uie2xrxLxLoiWLuf97e4SbgC4rQ09Amf4BA1Pju7ACXOX1zLFsqqSEAO3mxFPr8VAFcvMJHWZQtCjcjSmZCvdQKXfcuCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az0F+9NgWI5etWNnZzlE5W37eRI8bJWC0b0tB+5io14=;
 b=e9dn5zDe+CBVE7TF5zFbPz3T1yc7Ix23ma0dCZAUdCQC4WGGfykr07E0suXc5nuG35oRU+TergiYLcvGRnDJYcdp/HYernFxSpWDvbXiOeFKgatWu1R4N+Jj9e9I8HZCFr3MhhmIjFa9ruZ6v/6rKI6ZODfdxetKoV37EG2H/pGaEfV29qQwBq41tXXXpC/vJKDAiWt1CTzkWH93wP5T5TuKhrRdGjqTzA9OtadTITu6YDIRammcZsgbXtGwd0hJ2ZJB/qDFgIUB27QSEfymXh1608pgZY82J5n1AX9XKKuBkhzRhJyuqIWeDvVcApTqIW5b1humkLbkNtdnk5P49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az0F+9NgWI5etWNnZzlE5W37eRI8bJWC0b0tB+5io14=;
 b=ZSp52Hl4O/Nw7a8G0Y88DrzeoR00uOblI7f40sLLfA3xKaz2Xaakc006Pljnnx+RdQAhWkzYGdPLIFulqcT9Fg3WkXHBEtZEeeJlH2C/ZeyYigGY7iHHw1+zMas74Qw5KyzWXmZiMrR67TLud0RJ+gfv8DHotc1saNgRzz6COwg=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.6; Tue, 23 Mar 2021 05:48:42 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 05:48:42 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: [PATCH 2/5] nfs: Add mount option for forcing RPC requests to one
 file over one connection
Thread-Topic: [PATCH 2/5] nfs: Add mount option for forcing RPC requests to
 one file over one connection
Thread-Index: AdcfqBhZ8OmTEm29SYee8i/OAvQvnQ==
Date:   Tue, 23 Mar 2021 05:48:42 +0000
Message-ID: <SG2P153MB0361FD1C5138A0C1FCD7DB719E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c75faff6-2539-4f57-c7b1-08d8edbf5118
x-ms-traffictypediagnostic: SG2P15301MB0064:
x-microsoft-antispam-prvs: <SG2P15301MB00640D43220D1CC2B58041719E649@SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Vr858O8bKyc0P5v8bsLA1zMU45APVRcRhT4FvY/EKVmLSF/LmoEnYbyY6r7v7/vsm/9iZIoQvFvem48K8aoDjJ8BMEJZhW++KrJrDL1HS4jwN8LmfPb1pmBC8azknr4RsHmKEvm883+W3tn2Z0GdbkxQCbrZuwaQCm5SrNH/Qj4CbXWGlCK3F/7m7V5mG5I72JOu2DG1VnvdRq7TnSjGpOvWnPp8c5gfoDMWAgPltksOu4/pY9zlJyTybVbffYOYzY5+Xo1ITtt3mzf6Jy3k/ACsDVjqsg2AELO+FNQ4GChmxJ/E8O42bH2Q7KFfVYPryqWtev2OEf81LziehLZrsEKXHiSvYjZYNsNlBAh/uFVL5l1sRJFVijbx9KJVOOaho9MgEWWbirvSIXPBDHyZY/wUYRkGe10w8PWYQVTf6ZY0dT8+xb1Vg6LlslU8l7QZx9pY25SLvk2HjWVWbotm/vzmt5Q2RYLGVKA3jOwjLcDR3R9vzxa+zZbcYJylM2QYva+qmLvl20aDrYrb+U3G1LdIGIy3/b3r9mMkopMtWbBFZKul112AJQ2xyHo8lY7wo6ktPoCzbyoVj1oW91I8nGWd7OmE02XfXC8kvE5bxmjfoVGeboPl6I/wXTvuAEzL/AqViqJKxJW2DHJjIcJ0VLADAfZRIeLHxBfDw343Qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(5660300002)(316002)(52536014)(7696005)(54906003)(76116006)(33656002)(86362001)(8990500004)(10290500003)(186003)(66476007)(38100700001)(30864003)(64756008)(66446008)(26005)(6506007)(6916009)(66556008)(66946007)(55236004)(71200400001)(82960400001)(2906002)(8676002)(8936002)(9686003)(55016002)(82950400001)(83380400001)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7sdnCIw8SpyuJHLO9duT/xQIikyTACdcAXe4sYyecdOcPLLwYZxVwOiZT+Kt?=
 =?us-ascii?Q?jAwmC1MkeMj3APG3r/iTcX7StDhSM3ClEMyZZdlqruCELaBsGqbRiTwNOovB?=
 =?us-ascii?Q?ZfzrKkoF3ezYJ3VWne9kPYJLR2y0HujZwHvvpjHN5LCnHo3rqR65hZMlkC+K?=
 =?us-ascii?Q?6G5G1rbAVd01xv6Mgy38MsPef2SVHcCULgKBipR4SmYv7CxMmjBYbMzvHuLg?=
 =?us-ascii?Q?BwtSJltMuqTETeSzwiy/MeXbftJKgGuHIa6PZcQ4NsrvGeTaq02YgA/KXOza?=
 =?us-ascii?Q?TJDbLk8LLfELpUd/XEUJrL9eecdpKpUW6m0XvcSwW9i26/nWvBfN0PDFFRuA?=
 =?us-ascii?Q?MUBxBvJ4MHU42CaKOyr7zlbGYV31SusaOUV1+caZ5udAQRmiXKjAe/hDGwMN?=
 =?us-ascii?Q?K5sbgNi7WjWivG1w5ekE8NchRgnuzrR8p5CHj99EgAX85pfkP9JNzXKGFSem?=
 =?us-ascii?Q?gyH+6avp/zKzgDx3pMx2pPPUQSDHOzWJh/rFwoTjz/UJEgpOZvnNS6OguS8Y?=
 =?us-ascii?Q?hKIo6vAk21XbbH6zG6zIXUCPev9ToZv7hBfil4bRxT6jP7ElorYFPIQU7R/2?=
 =?us-ascii?Q?mW8FtAk05n+a0Sft533QxSb8JRdcKjSiI9VTBy5v2W532MIKN3BNBAaOEW/r?=
 =?us-ascii?Q?M4uNezvhQm0GaxA9bz4VjJzMhMj5WiIg+IvsM3woFAFHJB56ccsB1pyGUvi6?=
 =?us-ascii?Q?yaPoqPgqoJPC6y+eLGDKALFAX66Tb3xeRyQWvSZxCs/dHmpospARocRBl3rM?=
 =?us-ascii?Q?6yIyC9N/pSQWah5UB9Irol+HVKL7637inObT2f1NYoUZcy9tL6izN9nB4eBF?=
 =?us-ascii?Q?fdy7KIQEYJI+nNIMREX+QLxDEEK9Sa4SQ9gPFQBeHs7mGnvbHROhv1ni22q2?=
 =?us-ascii?Q?d++O8IGlWFHEdBsD/EIBuMNCfzozS3I3k8jc73jE1p17kOF30SKYmMeixrme?=
 =?us-ascii?Q?FExWZIH2CmPhtO0A7odvk9Jj0gRlluT7kt+c70irKYHFy4bpyIuDZaLujwDn?=
 =?us-ascii?Q?FHqO0WFyC27Sfxn4MNUaf6eWKC2NO8Nbe9yg6f1384qaM10Y1CGjNXHAycwg?=
 =?us-ascii?Q?o2uMXUEDzi85e0muY67056TZvogLI1Rs94zU1rLMB/iegSRr+UDUTD77i/fL?=
 =?us-ascii?Q?AyQWqDL7LwTMz86l1NqSsICbxUyuuGTzXzFN8zv/nyrIXtyAbccBQB5P+dLS?=
 =?us-ascii?Q?ueiNYPavKx0mEpyRuNoWV/wPYrJhgGOzTiYz8L+KIxs3H/f+pDLaIWaidfT8?=
 =?us-ascii?Q?dLRz8I45K+m0HD82fJshsLieJpdM31zZFNDj2m0VT89udXwCGn+kkcp5iOf7?=
 =?us-ascii?Q?T19r8eqqhJgU3XfsmH5oKpTt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c75faff6-2539-4f57-c7b1-08d8edbf5118
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:48:42.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd24qkTcjKOo+k7SSDM6/dovUfiIh1QYUfjXUysfdBm7CT1XtsufFFGgReXsNjPmdLTT8iv/4ULkN3OzjRT/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0064
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

Adds a new mount option ncpolicy=3Droundrobin|hash which allows user to
select the nconnect policy for the given mount. Defaults to roundrobin.
We store the user selected policy inside the rpc_clnt structure and
pass it down to the RPC client where the transport selection can be
accordingly done.
Also adds a new function pointer p_fhhash to struct rpc_procinfo.
This can be supplied to find the target file's hash for the given RPC
which will then be used to affine RPCs for a file to one xprt.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
 fs/nfs/client.c             |  3 +++
 fs/nfs/fs_context.c         | 26 ++++++++++++++++++++++++++
 fs/nfs/internal.h           |  2 ++
 fs/nfs/nfs3client.c         |  4 +++-
 fs/nfs/nfs4client.c         | 14 +++++++++++---
 fs/nfs/super.c              |  7 ++++++-
 include/linux/nfs_fs_sb.h   |  1 +
 include/linux/sunrpc/clnt.h | 15 +++++++++++++++
 net/sunrpc/clnt.c           | 34 ++++++++++++++++++++++++++++------
 9 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index ff5c4d0d6d13..5c2809d8368a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_cl=
ient_initdata *cl_init)
=20
 	clp->cl_proto =3D cl_init->proto;
 	clp->cl_nconnect =3D cl_init->nconnect;
+	clp->cl_ncpolicy =3D cl_init->ncpolicy;
 	clp->cl_net =3D get_net(cl_init->net);
=20
 	clp->cl_principal =3D "*";
@@ -506,6 +507,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.net		=3D clp->cl_net,
 		.protocol	=3D clp->cl_proto,
 		.nconnect	=3D clp->cl_nconnect,
+		.ncpolicy	=3D clp->cl_ncpolicy,
 		.address	=3D (struct sockaddr *)&clp->cl_addr,
 		.addrsize	=3D clp->cl_addrlen,
 		.timeout	=3D cl_init->timeparms,
@@ -678,6 +680,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.timeparms =3D &timeparms,
 		.cred =3D server->cred,
 		.nconnect =3D ctx->nfs_server.nconnect,
+		.ncpolicy =3D ctx->nfs_server.ncpolicy,
 		.init_flags =3D (1UL << NFS_CS_REUSEPORT),
 	};
 	struct nfs_client *clp;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 971a9251c1d9..7bb8f1c8356f 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -60,6 +60,7 @@ enum nfs_param {
 	Opt_mountvers,
 	Opt_namelen,
 	Opt_nconnect,
+	Opt_ncpolicy,
 	Opt_port,
 	Opt_posix,
 	Opt_proto,
@@ -127,6 +128,18 @@ static const struct constant_table nfs_param_enums_wri=
te[] =3D {
 	{}
 };
=20
+enum {
+	Opt_ncpolicy_roundrobin,
+	Opt_ncpolicy_hash,
+};
+
+static const struct constant_table nfs_param_enums_ncpolicy[] =3D {
+	{ "hash",		Opt_ncpolicy_hash },
+	{ "roundrobin",		Opt_ncpolicy_roundrobin },
+	{ "rr",			Opt_ncpolicy_roundrobin },
+	{}
+};
+
 static const struct fs_parameter_spec nfs_fs_parameters[] =3D {
 	fsparam_flag_no("ac",		Opt_ac),
 	fsparam_u32   ("acdirmax",	Opt_acdirmax),
@@ -158,6 +171,7 @@ static const struct fs_parameter_spec nfs_fs_parameters=
[] =3D {
 	fsparam_u32   ("mountvers",	Opt_mountvers),
 	fsparam_u32   ("namlen",	Opt_namelen),
 	fsparam_u32   ("nconnect",	Opt_nconnect),
+	fsparam_enum  ("ncpolicy",	Opt_ncpolicy, nfs_param_enums_ncpolicy),
 	fsparam_string("nfsvers",	Opt_vers),
 	fsparam_u32   ("port",		Opt_port),
 	fsparam_flag_no("posix",	Opt_posix),
@@ -749,6 +763,18 @@ static int nfs_fs_context_parse_param(struct fs_contex=
t *fc,
 			goto out_of_bounds;
 		ctx->nfs_server.nconnect =3D result.uint_32;
 		break;
+	case Opt_ncpolicy:
+		switch (result.uint_32) {
+		case Opt_ncpolicy_roundrobin:
+			ctx->nfs_server.ncpolicy =3D ncpolicy_roundrobin;
+			break;
+		case Opt_ncpolicy_hash:
+			ctx->nfs_server.ncpolicy =3D ncpolicy_hash;
+			break;
+		default:
+			goto out_invalid_value;
+		}
+		break;
 	case Opt_lookupcache:
 		switch (result.uint_32) {
 		case Opt_lookupcache_all:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 7b644d6c09e4..e6ca664d7e91 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -67,6 +67,7 @@ struct nfs_client_initdata {
 	int proto;
 	u32 minorversion;
 	unsigned int nconnect;
+	enum ncpolicy ncpolicy;
 	struct net *net;
 	const struct rpc_timeout *timeparms;
 	const struct cred *cred;
@@ -120,6 +121,7 @@ struct nfs_fs_context {
 		int			port;
 		unsigned short		protocol;
 		unsigned short		nconnect;
+		enum ncpolicy		ncpolicy;
 		unsigned short		export_path_len;
 	} nfs_server;
=20
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 5601e47360c2..f8a648f7492a 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -102,8 +102,10 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_serve=
r *mds_srv,
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname =3D buf;
=20
-	if (mds_clp->cl_nconnect > 1 && ds_proto =3D=3D XPRT_TRANSPORT_TCP)
+	if (mds_clp->cl_nconnect > 1 && ds_proto =3D=3D XPRT_TRANSPORT_TCP) {
 		cl_init.nconnect =3D mds_clp->cl_nconnect;
+		cl_init.ncpolicy =3D mds_clp->cl_ncpolicy;
+	}
=20
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 889a9f4c0310..c967c214129a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -863,6 +863,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		const char *ip_addr,
 		int proto, const struct rpc_timeout *timeparms,
 		u32 minorversion, unsigned int nconnect,
+		enum ncpolicy ncpolicy,
 		struct net *net)
 {
 	struct nfs_client_initdata cl_init =3D {
@@ -881,8 +882,10 @@ static int nfs4_set_client(struct nfs_server *server,
=20
 	if (minorversion =3D=3D 0)
 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
-	if (proto =3D=3D XPRT_TRANSPORT_TCP)
+	if (proto =3D=3D XPRT_TRANSPORT_TCP) {
 		cl_init.nconnect =3D nconnect;
+		cl_init.ncpolicy =3D ncpolicy;
+	}
=20
 	if (server->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
@@ -950,8 +953,10 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_serve=
r *mds_srv,
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname =3D buf;
=20
-	if (mds_clp->cl_nconnect > 1 && ds_proto =3D=3D XPRT_TRANSPORT_TCP)
+	if (mds_clp->cl_nconnect > 1 && ds_proto =3D=3D XPRT_TRANSPORT_TCP) {
 		cl_init.nconnect =3D mds_clp->cl_nconnect;
+		cl_init.ncpolicy =3D mds_clp->cl_ncpolicy;
+	}
=20
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
@@ -1120,6 +1125,7 @@ static int nfs4_init_server(struct nfs_server *server=
, struct fs_context *fc)
 				&timeparms,
 				ctx->minorversion,
 				ctx->nfs_server.nconnect,
+				ctx->nfs_server.ncpolicy,
 				fc->net_ns);
 	if (error < 0)
 		return error;
@@ -1209,6 +1215,7 @@ struct nfs_server *nfs4_create_referral_server(struct=
 fs_context *fc)
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
+				parent_client->cl_ncpolicy,
 				parent_client->cl_net);
 	if (!error)
 		goto init_server;
@@ -1224,6 +1231,7 @@ struct nfs_server *nfs4_create_referral_server(struct=
 fs_context *fc)
 				parent_server->client->cl_timeout,
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
+				parent_client->cl_ncpolicy,
 				parent_client->cl_net);
 	if (error < 0)
 		goto error;
@@ -1321,7 +1329,7 @@ int nfs4_update_server(struct nfs_server *server, con=
st char *hostname,
 	error =3D nfs4_set_client(server, hostname, sap, salen, buf,
 				clp->cl_proto, clnt->cl_timeout,
 				clp->cl_minorversion,
-				clp->cl_nconnect, net);
+				clp->cl_nconnect, clp->cl_ncpolicy, net);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error !=3D 0) {
 		nfs_server_insert_lists(server);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 94885c6f8f54..8719be70051b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -481,8 +481,13 @@ static void nfs_show_mount_options(struct seq_file *m,=
 struct nfs_server *nfss,
 	seq_printf(m, ",proto=3D%s",
 		   rpc_peeraddr2str(nfss->client, RPC_DISPLAY_NETID));
 	rcu_read_unlock();
-	if (clp->cl_nconnect > 0)
+	if (clp->cl_nconnect > 0) {
 		seq_printf(m, ",nconnect=3D%u", clp->cl_nconnect);
+		if (clp->cl_ncpolicy =3D=3D ncpolicy_roundrobin)
+			seq_puts(m, ",ncpolicy=3Droundrobin");
+		else if (clp->cl_ncpolicy =3D=3D ncpolicy_hash)
+			seq_puts(m, ",ncpolicy=3Dhash");
+	}
 	if (version =3D=3D 4) {
 		if (nfss->port !=3D NFS_PORT)
 			seq_printf(m, ",port=3D%u", nfss->port);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 6f76b32a0238..737f4d231e23 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -62,6 +62,7 @@ struct nfs_client {
=20
 	u32			cl_minorversion;/* NFSv4 minorversion */
 	unsigned int		cl_nconnect;	/* Number of connections */
+	enum ncpolicy		cl_ncpolicy;	/* nconnect policy */
 	const char *		cl_principal;  /* used for machine cred */
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 02e7a5863d28..aa1c1706f4d5 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -28,6 +28,15 @@
 #include <net/ipv6.h>
 #include <linux/sunrpc/xprtmultipath.h>
=20
+/*
+ * Policies for controlling distribution of RPC requests over multiple
+ * nconnect connections.
+ */
+enum ncpolicy {
+	ncpolicy_roundrobin,	// Select roundrobin.
+	ncpolicy_hash,		// Select based on target filehandle hash.
+};
+
 struct rpc_inode;
=20
 /*
@@ -40,6 +49,7 @@ struct rpc_clnt {
 	struct list_head	cl_tasks;	/* List of tasks */
 	spinlock_t		cl_lock;	/* spinlock */
 	struct rpc_xprt __rcu *	cl_xprt;	/* transport */
+	enum ncpolicy		cl_ncpolicy;	/* nconnect policy */
 	const struct rpc_procinfo *cl_procinfo;	/* procedure info */
 	u32			cl_prog,	/* RPC program number */
 				cl_vers,	/* RPC version number */
@@ -101,6 +111,8 @@ struct rpc_version {
 	unsigned int		*counts;	/* call counts */
 };
=20
+typedef u32 (*getfhhash_t)(const void *obj);
+
 /*
  * Procedure information
  */
@@ -108,6 +120,7 @@ struct rpc_procinfo {
 	u32			p_proc;		/* RPC procedure number */
 	kxdreproc_t		p_encode;	/* XDR encode function */
 	kxdrdproc_t		p_decode;	/* XDR decode function */
+	getfhhash_t		p_fhhash;	/* Returns target fh hash */
 	unsigned int		p_arglen;	/* argument hdr length (u32) */
 	unsigned int		p_replen;	/* reply hdr length (u32) */
 	unsigned int		p_timer;	/* Which RTT timer to use */
@@ -129,6 +142,7 @@ struct rpc_create_args {
 	u32			version;
 	rpc_authflavor_t	authflavor;
 	u32			nconnect;
+	enum ncpolicy		ncpolicy;
 	unsigned long		flags;
 	char			*client_name;
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
@@ -247,4 +261,5 @@ static inline void rpc_task_close_connection(struct rpc=
_task *task)
 	if (task->tk_xprt)
 		xprt_force_disconnect(task->tk_xprt);
 }
+
 #endif /* _LINUX_SUNRPC_CLNT_H */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 1b2a02460601..ed470a75e91d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -410,6 +410,7 @@ static struct rpc_clnt * rpc_new_client(const struct rp=
c_create_args *args,
 	}
=20
 	rpc_clnt_set_transport(clnt, xprt, timeout);
+	clnt->cl_ncpolicy =3D args->ncpolicy;
 	xprt_iter_init(&clnt->cl_xpi, xps);
 	xprt_switch_put(xps);
=20
@@ -640,6 +641,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_c=
reate_args *args,
 	new->cl_discrtry =3D clnt->cl_discrtry;
 	new->cl_chatty =3D clnt->cl_chatty;
 	new->cl_principal =3D clnt->cl_principal;
+	new->cl_ncpolicy =3D clnt->cl_ncpolicy;
 	return new;
=20
 out_err:
@@ -1053,9 +1055,10 @@ rpc_task_get_first_xprt(struct rpc_clnt *clnt)
 }
=20
 static struct rpc_xprt *
-rpc_task_get_next_xprt(struct rpc_clnt *clnt)
+rpc_task_get_next_xprt(struct rpc_clnt *clnt, u32 hash)
 {
-	return rpc_task_get_xprt(clnt, xprt_iter_get_next(&clnt->cl_xpi, 0));
+	return rpc_task_get_xprt(clnt,
+			xprt_iter_get_next(&clnt->cl_xpi, hash));
 }
=20
 static
@@ -1065,8 +1068,16 @@ void rpc_task_set_transport(struct rpc_task *task, s=
truct rpc_clnt *clnt)
 		return;
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt =3D rpc_task_get_first_xprt(clnt);
-	else
-		task->tk_xprt =3D rpc_task_get_next_xprt(clnt);
+	else {
+		u32 xprt_hint =3D 0;
+
+		if (clnt->cl_ncpolicy =3D=3D ncpolicy_hash &&
+		    task->tk_msg.rpc_proc->p_fhhash) {
+			xprt_hint =3D task->tk_msg.rpc_proc->p_fhhash(
+						task->tk_msg.rpc_argp);
+		}
+		task->tk_xprt =3D rpc_task_get_next_xprt(clnt, xprt_hint);
+	}
 }
=20
 static
@@ -1130,8 +1141,8 @@ struct rpc_task *rpc_run_task(const struct rpc_task_s=
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
@@ -1636,6 +1647,7 @@ call_start(struct rpc_task *task)
 	/* Increment call count (version might not be valid for ping) */
 	if (clnt->cl_program->version[clnt->cl_vers])
 		clnt->cl_program->version[clnt->cl_vers]->counts[idx]++;
+
 	clnt->cl_stats->rpccnt++;
 	task->tk_action =3D call_reserve;
 	rpc_task_set_transport(task, clnt);
@@ -2888,7 +2900,17 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 				connect_timeout,
 				reconnect_timeout);
=20
-	rpc_xprt_switch_set_roundrobin(xps);
+	switch (clnt->cl_ncpolicy) {
+	case ncpolicy_roundrobin:
+	default:
+		WARN_ON(clnt->cl_ncpolicy !=3D ncpolicy_roundrobin);
+		rpc_xprt_switch_set_roundrobin(xps);
+		break;
+	case ncpolicy_hash:
+		rpc_xprt_switch_set_hash(xps);
+		break;
+	}
+
 	if (setup) {
 		ret =3D setup(clnt, xps, xprt, data);
 		if (ret !=3D 0)
