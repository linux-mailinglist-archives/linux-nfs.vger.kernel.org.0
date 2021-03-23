Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A834577F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 06:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWFrn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 01:47:43 -0400
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:18976
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhCWFrN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 01:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWIXltSf3YY6j4PDSXvzaFHDinagLppKvAP8hfgLjjKhOSlK6bt72+1dyJv7fh73AlGuAszMtNSlQepkT06N9TsMTC4N7nJxEs5v+rqXQoc83uQAWWyp1F/ngiaU6p0aHLPzFzj98JozvAAj2YH6ZbhBSw6lxtKbmjrjmV/PkZMYSK7E2L2SsLSi7bGdsCB5ul06QI0U7x6tGo/ezg95+d7thHy1DBOxrTpTsfKpHuD1BX2OzKuNZOnmEMUKiBRXfrBh9P1wQjOJzyvGPoVHQPyyVCStChksxtnYDB2MmXXKSJjw9MGTESaS2MJB9utXbHh8i9LjYqimg28I9EIYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ni3LKiJjZr3RHBnoH96R+0V9LlBJjfKyPKiVzr7CIQ=;
 b=a+DP/ss/oKwAErX/Od3Sy3d+3ZuweP2qNCFdowqn3u9rCEOgo6k7G2IgCL9mXlBSsI1LsJ2lsgoUIt4nEbtjbO1hf3ixxZFfbYUc1vyIuSxR+rxZeubDrIuQ2qZ0obCwBV8AcEAtH87us8xU3HA0u0Ewa40FP5Vkg4exsU7UpnZ4G8LiJkwbO5LEoJ3dgg3bVSpCI6OW8ylLqzzQGQ7Ur3qCdYjg8wQBynvB2aPKQ9q2gCcMFzvOphARCeye2uJupkCwfxRF3reNfKU85cTnVSgNo5CcGPdGuzuoauTxXa3Kbh8Z5/RosWAXbtNAvkcP4VCkjH6uCddlAHsgPyQyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ni3LKiJjZr3RHBnoH96R+0V9LlBJjfKyPKiVzr7CIQ=;
 b=SKm/VdXOOHGCzv6qgJsiQH9BjswlgEYlGH1jBerXZaAcGw4yp6HqNM9QnFpTKhvKv3thl3x5/K4yvGcY6i5afbmDB6Gn5nNlXjZx7NPRR7FBJ0tdFzdebQhehtdBEidO9kkPBcmBhsmPrNSlozGppHbOPBJjHaj5z+B0BLbP778=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.6; Tue, 23 Mar 2021 05:47:10 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 05:47:10 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: [PATCH 1/5] nfs: Add mount option for forcing RPC requests for one
 file over one connection
Thread-Topic: [PATCH 1/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp+U1aW330QBCRYC69f9ZVFWEig==
Date:   Tue, 23 Mar 2021 05:47:10 +0000
Message-ID: <SG2P153MB0361BEE013A388343774F2EE9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
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
x-ms-office365-filtering-correlation-id: b12506ab-7a8f-4ea5-6233-08d8edbf19fc
x-ms-traffictypediagnostic: SG2P15301MB0064:
x-microsoft-antispam-prvs: <SG2P15301MB0064AD5D5E3F5C7D5E39D83D9E649@SG2P15301MB0064.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5gUlV1+08mt8SLr7fzxIPSzyhkGyBMKQypOZSZMuPXYq6txwmvwMi97V4T9Kr28xHm/lQyw3EdvXwZdSG/L6Yv6YE/Epk/TGiLGycH3/yq+Si9xE/u+G2GQCTcrjuvhbOYjcHMcgbYwotgrO3rPu6/aq+ys2gFGPLvju9P+/alix5frqcH41z1kOB3+rjtbT1AO51N7SJ3neZlyvX2mtF6fNfZ/j00V0tBOaZupYDFGah4EtoAH0UWwbBi+NjObfL7pyfGe/z15PuC6Qk3H3hoLTbgw9mMmNrX/KVPkspFsHTRvoP6xiYiF550Y3W5XQA4Xxe3776J+C95NjCEFHsWYauqmrAQyAqRLdCQ1Pd6+BhDgmYgcdFMS7uMlvPVpwmh5bGxffjj7mVgxYJr5cYE4oL62F+/aa/+Z4ymwCUsmFYXyFaMin1mBC+ItLMzGsox5EoqdqRFW8GXu+hnQ9zYp2wnUaCLjgyCypr69wZ7KWrmCNGnyy+tm/MpmmlykcYOrOpECQHygynx4IyrNJqSn1ocw6SE1hEC9NE64fyEJ0VEx48MHZRCj/69XI0d6zxfFDa1OC2V5gbSyodGtolHPJLpya+QRNiJJf1onk5U2OUJmoKb3cW6kFcBKvT7969GdcDiRUa+Hsa5kYiQ7Z7VYmFgmKCawDDxoPxPNjD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(5660300002)(316002)(52536014)(7696005)(54906003)(76116006)(33656002)(86362001)(8990500004)(10290500003)(186003)(66476007)(38100700001)(64756008)(66446008)(26005)(6506007)(6916009)(66556008)(66946007)(55236004)(71200400001)(82960400001)(2906002)(8676002)(8936002)(9686003)(55016002)(82950400001)(83380400001)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2i1jnqZvtQRbMngoC617v/m2z2h9j8GZnNtT+VKdHuEuu7KmkxIjt1Ov6he2?=
 =?us-ascii?Q?eJLZS8pYRfLFXHZZmMq86WvaYqlURrLgkANrZKp67aU6jTcFVvo0YpHsNpB8?=
 =?us-ascii?Q?8W+67RBxgKrELxo3dd4mnySLq5G5/UypukU7Xym4VB1uTjNTOa5cU+iNoa7U?=
 =?us-ascii?Q?IlFo5yugWurV8kdd3rEaThaE6+nmr90Rwy3ALhONwITjbqqiE/8CImpwCgJz?=
 =?us-ascii?Q?QqBEY+5cfU+MiuFcG41u+fPRSKvEnUnm39ItlQ1rk/9SpEs7LcTbkmShqCiu?=
 =?us-ascii?Q?vaiaQgZQ1Hr+BJFBpxHaCR3MdqDsKobvdnJf3mZIHeK55B1fD9dXvyC0XGXk?=
 =?us-ascii?Q?CB99W/CE0KbFBdSBPBj9YDomZIHcVm+ep4AklT0Lg0Bj+ztN5CKq/YcfhYOR?=
 =?us-ascii?Q?+c4fkwmSIRDsahtE7N/SChKKl2LdDEd+Qfyr105N0niWA8FGQ1/YEBAUdHZv?=
 =?us-ascii?Q?ZO+yeXTuRgISedG+Eqz0yGfxMJMxbxYswD0zRHePIrqnKzkcwWqqxUmXa5po?=
 =?us-ascii?Q?eHhE+UxvWtiye7AUgkj8nqvbaes9NDTc9T+1c0YsPynbe+gnYx8ZJoGXFxfu?=
 =?us-ascii?Q?l/gsqfShU5W7FbcvzNBMhXwS2k1IlMek+MxnQc5UX8u3AZQhT01GJQGB7o33?=
 =?us-ascii?Q?ZyIfVcZyP5pgI+AMYmhL/WemsTNDz+KgoZKS2LtrcrLbUYdOHpDjcXeSr8HW?=
 =?us-ascii?Q?0P5SfKk+bKJmsNhbTxUa0L7vIO+JS4Q7QI42DHFoFqdO7wvBez7+2UoMutUd?=
 =?us-ascii?Q?wLpOBTfNiiSsGwgl2PCUpCGqFomQyJzLtfr0N4AaZ1Ap9YljqGWIsQWmKZvP?=
 =?us-ascii?Q?xZYUrcLB3ExPrTEWE9o/wZGb8ypx6sxlHYUAPS/Nzvj80DFHuB/+e8CIXoxI?=
 =?us-ascii?Q?b1LHRebXA8l+3k/lCqrh19+YMGy92u0487JP22BKza4qxVUxACL/BAuqsZlC?=
 =?us-ascii?Q?OIlsmSO1LKqDqrRKDcJrs2dJHyDoR1i5L/wUTPYHmOQpr5ZQJy5E0v7XkQsK?=
 =?us-ascii?Q?+a2KkNTzJSJDyW8NFEJruiZ08b9ozSNSYN1Cryf8KEbHjupJgoHZ0Y0w+IYT?=
 =?us-ascii?Q?Wnd+y//ujbZ+qKhuBW1zcUl7ryVdGHFH3JMd6AoLvl+tu4G68kldVYRz3m8b?=
 =?us-ascii?Q?3TTjcy5Wm43kXPwHhphHHSm2thQhYLUuopBHApGBUly4Y70LD0NQCiYEFlpS?=
 =?us-ascii?Q?OencgErzOJmx7AiUQFUBdzzWxac1AMSMCjzL6KUa1fB66v++V4T0OX4/gusV?=
 =?us-ascii?Q?WzYoet5rK4uF3ufjB+nLgrnWV2rQzg1qN7Hq49Nfz8l+SCq8dCyxDjUjezsX?=
 =?us-ascii?Q?L8q2AaZjXqIru9DcdwiDcyz6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b12506ab-7a8f-4ea5-6233-08d8edbf19fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:47:10.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpas75MtqADrZ2Bl+VA0JSKuQGSztYKuYOS3I8CsgfGH3u/NAE7xO64IfAis5rUHWA7UJsJlVr7DXrmkfC3l8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0064
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

Adds a new rpc_xprt_iter_ops which returns a xprt suitable for carrying
an RPC based on an additional u32 hash parameter to identify the RPC
target file.
Other xprt policies, like roundrobin, which do not make use of the hash
ignore it.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
 net/sunrpc/clnt.c                    |  4 +-
 net/sunrpc/xprtmultipath.c           | 91 ++++++++++++++++++++++++++++++++=
++--
 3 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xp=
rtmultipath.h
index c6cce3fbf29d..62caecfaa4f8 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -37,7 +37,11 @@ struct rpc_xprt_iter {
 struct rpc_xprt_iter_ops {
 	void (*xpi_rewind)(struct rpc_xprt_iter *);
 	struct rpc_xprt *(*xpi_xprt)(struct rpc_xprt_iter *);
-	struct rpc_xprt *(*xpi_next)(struct rpc_xprt_iter *);
+	/*
+	 * 2nd parameter is a hash value identifying the RPC target file.
+	 * A xprt policy may use it to affine RPCs for a file to a xprt.
+	 */
+	struct rpc_xprt *(*xpi_next)(struct rpc_xprt_iter *, u32);
 };
=20
 extern struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
@@ -47,6 +51,7 @@ extern struct rpc_xprt_switch *xprt_switch_get(struct rpc=
_xprt_switch *xps);
 extern void xprt_switch_put(struct rpc_xprt_switch *xps);
=20
 extern void rpc_xprt_switch_set_roundrobin(struct rpc_xprt_switch *xps);
+extern void rpc_xprt_switch_set_hash(struct rpc_xprt_switch *xps);
=20
 extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 		struct rpc_xprt *xprt);
@@ -67,7 +72,7 @@ extern struct rpc_xprt_switch *xprt_iter_xchg_switch(
=20
 extern struct rpc_xprt *xprt_iter_xprt(struct rpc_xprt_iter *xpi);
 extern struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_iter *xpi);
-extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi);
+extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi, u32 =
hash);
=20
 extern bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 		const struct sockaddr *sap);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 612f0a641f4c..1b2a02460601 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -809,7 +809,7 @@ int rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *cln=
t,
 	if (ret)
 		return ret;
 	for (;;) {
-		struct rpc_xprt *xprt =3D xprt_iter_get_next(&xpi);
+		struct rpc_xprt *xprt =3D xprt_iter_get_next(&xpi, 0);
=20
 		if (!xprt)
 			break;
@@ -1055,7 +1055,7 @@ rpc_task_get_first_xprt(struct rpc_clnt *clnt)
 static struct rpc_xprt *
 rpc_task_get_next_xprt(struct rpc_clnt *clnt)
 {
-	return rpc_task_get_xprt(clnt, xprt_iter_get_next(&clnt->cl_xpi));
+	return rpc_task_get_xprt(clnt, xprt_iter_get_next(&clnt->cl_xpi, 0));
 }
=20
 static
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 78c075a68c04..7901afa432f0 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -24,6 +24,7 @@ typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struc=
t rpc_xprt_switch *xps,
=20
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_singular;
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_roundrobin;
+static const struct rpc_xprt_iter_ops rpc_xprt_iter_hash;
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_listall;
=20
 static void xprt_switch_add_xprt_locked(struct rpc_xprt_switch *xps,
@@ -176,6 +177,12 @@ void rpc_xprt_switch_set_roundrobin(struct rpc_xprt_sw=
itch *xps)
 		WRITE_ONCE(xps->xps_iter_ops, &rpc_xprt_iter_roundrobin);
 }
=20
+void rpc_xprt_switch_set_hash(struct rpc_xprt_switch *xps)
+{
+	if (READ_ONCE(xps->xps_iter_ops) !=3D &rpc_xprt_iter_hash)
+		WRITE_ONCE(xps->xps_iter_ops, &rpc_xprt_iter_hash);
+}
+
 static
 const struct rpc_xprt_iter_ops *xprt_iter_ops(const struct rpc_xprt_iter *=
xpi)
 {
@@ -223,6 +230,13 @@ struct rpc_xprt *xprt_iter_first_entry(struct rpc_xprt=
_iter *xpi)
 	return xprt_switch_find_first_entry(&xps->xps_xprt_list);
 }
=20
+static
+struct rpc_xprt *xprt_iter_next_entry_singular(struct rpc_xprt_iter *xpi,
+		u32 hash)
+{
+	return xprt_iter_first_entry(xpi);
+}
+
 static
 struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
 		const struct rpc_xprt *cur)
@@ -352,12 +366,55 @@ struct rpc_xprt *xprt_switch_find_next_entry_roundrob=
in(struct rpc_xprt_switch *
 }
=20
 static
-struct rpc_xprt *xprt_iter_next_entry_roundrobin(struct rpc_xprt_iter *xpi=
)
+struct rpc_xprt *xprt_iter_next_entry_roundrobin(struct rpc_xprt_iter *xpi=
,
+		u32 hash)
 {
 	return xprt_iter_next_entry_multiple(xpi,
 			xprt_switch_find_next_entry_roundrobin);
 }
=20
+struct rpc_xprt *__xprt_switch_find_next_entry_hash(struct rpc_xprt_switch=
 *xps,
+		u32 hash)
+{
+	struct list_head *head =3D &xps->xps_xprt_list;
+	struct rpc_xprt *pos;
+	const u32 nactive =3D READ_ONCE(xps->xps_nactive);
+	const u32 xprt_idx =3D (hash % nactive);
+	u32 idx =3D 0;
+
+	list_for_each_entry_rcu(pos, head, xprt_switch) {
+		if (xprt_idx > idx++)
+			continue;
+		if (xprt_is_active(pos))
+			return pos;
+	}
+	return NULL;
+}
+
+static
+struct rpc_xprt *xprt_switch_find_next_entry_hash(struct rpc_xprt_switch *=
xps,
+		u32 hash)
+{
+	struct list_head *head =3D &xps->xps_xprt_list;
+	struct rpc_xprt *xprt;
+
+	xprt =3D __xprt_switch_find_next_entry_hash(xps, hash);
+	if (xprt =3D=3D NULL)
+		xprt =3D xprt_switch_find_first_entry(head);
+	return xprt;
+}
+
+static
+struct rpc_xprt *xprt_iter_next_entry_hash(struct rpc_xprt_iter *xpi,
+		u32 hash)
+{
+	struct rpc_xprt_switch *xps =3D rcu_dereference(xpi->xpi_xpswitch);
+
+	if (xps =3D=3D NULL)
+		return NULL;
+	return xprt_switch_find_next_entry_hash(xps, hash);
+}
+
 static
 struct rpc_xprt *xprt_switch_find_next_entry_all(struct rpc_xprt_switch *x=
ps,
 		const struct rpc_xprt *cur)
@@ -366,7 +423,7 @@ struct rpc_xprt *xprt_switch_find_next_entry_all(struct=
 rpc_xprt_switch *xps,
 }
=20
 static
-struct rpc_xprt *xprt_iter_next_entry_all(struct rpc_xprt_iter *xpi)
+struct rpc_xprt *xprt_iter_next_entry_all(struct rpc_xprt_iter *xpi, u32 h=
ash)
 {
 	return xprt_iter_next_entry_multiple(xpi,
 			xprt_switch_find_next_entry_all);
@@ -482,6 +539,22 @@ struct rpc_xprt *xprt_iter_get_helper(struct rpc_xprt_=
iter *xpi,
 	return ret;
 }
=20
+static
+struct rpc_xprt *xprt_iter_get_helper_1(struct rpc_xprt_iter *xpi,
+		struct rpc_xprt *(*fn)(struct rpc_xprt_iter *, u32),
+		u32 arg)
+{
+	struct rpc_xprt *ret;
+
+	do {
+		ret =3D fn(xpi, arg);
+		if (ret =3D=3D NULL)
+			break;
+		ret =3D xprt_get(ret);
+	} while (ret =3D=3D NULL);
+	return ret;
+}
+
 /**
  * xprt_iter_get_xprt - Returns the rpc_xprt pointed to by the cursor
  * @xpi: pointer to rpc_xprt_iter
@@ -506,12 +579,12 @@ struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_i=
ter *xpi)
  * Returns a reference to the struct rpc_xprt that immediately follows the
  * entry pointed to by the cursor.
  */
-struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi)
+struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi, u32 hash)
 {
 	struct rpc_xprt *xprt;
=20
 	rcu_read_lock();
-	xprt =3D xprt_iter_get_helper(xpi, xprt_iter_ops(xpi)->xpi_next);
+	xprt =3D xprt_iter_get_helper_1(xpi, xprt_iter_ops(xpi)->xpi_next, hash);
 	rcu_read_unlock();
 	return xprt;
 }
@@ -521,7 +594,7 @@ static
 const struct rpc_xprt_iter_ops rpc_xprt_iter_singular =3D {
 	.xpi_rewind =3D xprt_iter_no_rewind,
 	.xpi_xprt =3D xprt_iter_first_entry,
-	.xpi_next =3D xprt_iter_first_entry,
+	.xpi_next =3D xprt_iter_next_entry_singular,
 };
=20
 /* Policy for round-robin iteration of entries in the rpc_xprt_switch */
@@ -532,6 +605,14 @@ const struct rpc_xprt_iter_ops rpc_xprt_iter_roundrobi=
n =3D {
 	.xpi_next =3D xprt_iter_next_entry_roundrobin,
 };
=20
+/* Policy for returning a hashed entry from the rpc_xprt_switch */
+static
+const struct rpc_xprt_iter_ops rpc_xprt_iter_hash =3D {
+	.xpi_rewind =3D xprt_iter_default_rewind,
+	.xpi_xprt =3D xprt_iter_current_entry,
+	.xpi_next =3D xprt_iter_next_entry_hash,
+};
+
 /* Policy for once-through iteration of entries in the rpc_xprt_switch */
 static
 const struct rpc_xprt_iter_ops rpc_xprt_iter_listall =3D {
