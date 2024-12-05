Return-Path: <linux-nfs+bounces-8362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397269E63D2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E909E282E83
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A036C;
	Fri,  6 Dec 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lenovonetapp.partner.onmschina.cn header.i=@lenovonetapp.partner.onmschina.cn header.b="GZiGYQq7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2062.outbound.protection.partner.outlook.cn [139.219.17.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D113C8FF
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450345; cv=fail; b=VvmQ0g3Q+NFPXCp/1+OK91CxDD6QJOwcBx3JAzWLn2FBRKFLXOg0jhzvjZIHCacmIS0f7oLINNRxjykErYKyuYVKnYNXgL1ifaRIuYjaQC0yFs8mA3klnulldIXkbsiWY8dmfa+PospaxOQl5zlflCZPnfOpfAiCRBqVIH2mk88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450345; c=relaxed/simple;
	bh=dAAS2lRFcJB4CBrW98lTGCJ662yCcIQbK4RuCw8ew2M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OdQ8s/t4J+1If1pBeQZ8EUUyGgfga+0+heNEAVWRiUioDyq5a2jucuNGvEx1YoUDpAqvaBH6r3Ar4Em0j61FTMAK9oRgQB13/tQDznshnxcmF+yq3QdT5MwGGpaNqupjmesY1Nryy2FBsspqGL9uZjDaNq+cpjZT+vwZUghWOIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lenovonetapp.com; spf=pass smtp.mailfrom=lenovonetapp.com; dkim=pass (1024-bit key) header.d=lenovonetapp.partner.onmschina.cn header.i=@lenovonetapp.partner.onmschina.cn header.b=GZiGYQq7; arc=fail smtp.client-ip=139.219.17.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lenovonetapp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovonetapp.com
Received: from ZQ0PR01MB1093.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::10) by NT0PR01MB1104.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Thu, 5 Dec
 2024 18:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz7G1Q5XVoI6Jrk0bBEFPspCMwIeWWMQuBBgx0Uq/Bv6eVTK3qbCqo0tEh6KL7ob42FBvQr5+D2doEVfEf4YUtu4BWGdIf3FElNY8567TaV2Yk3FNrtPh+ulBKy5m+o8XZBYdpfxWaflnjViiJGpt/R0w2xcWlDlguP9D439z08a2mYFQM4wfLH4pl5ZzW44Mtixwe9LTjTRQDCPELe6hPSLLW2T0g0CbcM1RHA7BZQt+hOsBKnee1HdIg9lXHOuTPcrN8n4OX6f94IHkhE3sxtg2yTUkofpRiQGsQBp54NAbEVaZQOM/cLreAAW6t4GJiL91VlT00KBurPeCDbttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B5Ge+AltnG6pobPUs0p47CDGQ0U7nt85BEA9lziXM0=;
 b=ds3FXx/F9SK76yut7uKPWpFybv6ma1XUUKhQofpTFP5I+tcWm4ElWVVYGy20fPmqM2EnUPNxaF7BaR5fIi/fJp2Kj3jx+Z3kEjfY3ogm1u0Ej76YwEN9xWoBKRb3GFJSChWwwUm49h6ML/LNltIUjGRZzsJfihhCWPu3Pq0loAYBuCezr87v33WNoeKJ5dAFEzOHNufU9s1B7AZX1C3LJgSD1YZutf9LkJ1C7yujJZ9Cd2jvpI04yNKvWYyMsVO8AghSinx3qHhRVUVg7fT6KV+tT3OiQVhQvXc3xO6OXpI/mnrFDCh3ANTbC72AN2Wn2Y+4bNHDRin4qSvOUtpBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovonetapp.com; dmarc=pass action=none
 header.from=lenovonetapp.com; dkim=pass header.d=lenovonetapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lenovonetapp.partner.onmschina.cn;
 s=selector1-lenovonetapp-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B5Ge+AltnG6pobPUs0p47CDGQ0U7nt85BEA9lziXM0=;
 b=GZiGYQq7JiJVHdTCWkhBJ7+QxGqLPmThr7e2ceHJ5VciOtfH57NvbVaSODTo2ZCvg99nLzUvdFSMiETH1g93+0xfV1Oha4OQmJfuyMDnvP+ut75M39OzPBB+NYDVaYCaQy/EGYKJAQt4c7UrlDbzCd5t3+9VKeWPCB0e9mwHBt8=
Received: from ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::10) by ZQ0PR01MB1093.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 5 Dec
 2024 09:13:19 +0000
Received: from ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn
 ([fe80::dce3:c224:207c:7bae]) by
 ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn ([fe80::dce3:c224:207c:7bae%4])
 with mapi id 15.20.8207.010; Thu, 5 Dec 2024 09:13:19 +0000
From: "Liu, Changxin<changxin.liu@lenovonetapp.com>"
	<changxin.liu@lenovonetapp.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust
	<trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Subject: [PATCH] nfs: prevent out-of-bounds memory access in nfs4_xdr_dec_open
 and nfs4_xdr_dec_open_noattr
Thread-Topic: [PATCH] nfs: prevent out-of-bounds memory access in
 nfs4_xdr_dec_open and nfs4_xdr_dec_open_noattr
Thread-Index: AdtG8mhTxiE/djBQTsWqdZjdkxlDpAAAcsGg
Date: Thu, 5 Dec 2024 09:13:18 +0000
Message-ID:
 <ZQ0PR01MB1031BEFCC312865552969274F830A@ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn>
References:
 <ZQ0PR01MB1031E3B5494478C1F7630AD8F830A@ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <ZQ0PR01MB1031E3B5494478C1F7630AD8F830A@ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenovonetapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ0PR01MB1031:EE_|ZQ0PR01MB1093:EE_|NT0PR01MB1104:EE_
x-ms-office365-filtering-correlation-id: 1c364c21-0cef-4974-0136-08dd150d0f31
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|2093699003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 HjR1A8YVwNxnGmZuz5g3uwiW2wOJOGkCPLrTNpfe/iLFGwK4wPF6EGumREsuZl4cImS66QGdlfuGgHqgX2X3w28hSKw/zOAPkj2M7/Mlz1pKftIj+5SmGoD/G8DE0lw9O/sRO2TegsC3W1XiCPcHwxSZiUTgnmo/Udw7QXW/fafInFn+1/XDQIsuBU7o2Zqu2ZjQvRP+3435dQzE73Up0/JP9nPqRMZuzPNP4EVV80ll4iU5aDF8Bqjsd80gec6lJxsAGFORMts31f5kijw8y8D3Q/8WyjTdDXf50ubsaGnbfbN2R8pAMAroDbsYVd3enEKyROXfHMf9jgNP30woAB9/VqKXNUPFO+Spk/SKgPNxMH56aUDzG+mBXdIgNgA0LNoDDVI37nAdT7u8UTp8okKkBobwDaqfz5W8YYaZ6x26b2CQ4hbOdC6BOoGk6scm6HMw2nc9dD9QlJHgnqlcEn053/kMfKzeI/99zcYNr3FobzXpkSGKqPEOJKRD36geOng3kG2EbGhYagzFr3lwD8bT0xUo5xp31bKJfBQw+S+dAHCbMsnwzq4hXAhRJHWYI2CcugcogFmvonoqjhHcdGcvL0VO7V/OCVnIOS4L+bu9KLVKHXYWvNDGx4wRJaxdKETLsfiNfO5PPEFp/ZreIg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(2093699003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ps09RE4oCb3n20cUUFq8qRD8TBMSHKtmTL0XeiHomgXdpB2Ozk0Yw2VZzeTU?=
 =?us-ascii?Q?hHrdCBQaAjBQ0Gj/tRO83fgLOSHkADJAdML7ruaSdLdHUVi+Q/CEjL2zvaLs?=
 =?us-ascii?Q?e84yomEY7gKrtHGO0+quXrqEpOwGWc1GECiq3qrms47orOAh6OqpeTyhaRJm?=
 =?us-ascii?Q?gm4v2Vy1Xgns/PM4xriE9L12NBYAAN0ExXhWexkVOWR+8aAdIvL+wpimHWe0?=
 =?us-ascii?Q?oL9ioqn2xfNg8jvVWZtGuiOaTJTmQ3PSIae2j+yrq+0xSjWYRr6/GSuGJToX?=
 =?us-ascii?Q?2LQ/nzlKmqVdUrL3iwTPgMXDDXLGzibMwpyIj1cAcQEY5CCmrl0tkW8vMeMB?=
 =?us-ascii?Q?cuQGhfn2qq6eprpIhsQlS4Zw0MSRsU7ZjV73u+NN6H/ypaXxcggTPrrzbOK/?=
 =?us-ascii?Q?cgtalg8be00Y753MWGrd0QulS5/4DcloeWe98vaK6LtGdhNyaPvLhcdjSmXC?=
 =?us-ascii?Q?N4KO6KklusBVXAIY1eLV49V+uSsuRi7hUkvONg2TSTeU41htkmEaXWHgMDHS?=
 =?us-ascii?Q?4NS9D+rrnJ9u36pbLX+46aQmOHkcKwzUVIfAjTRMEL+axWaeH1ZqA7QZ4My4?=
 =?us-ascii?Q?+YPN7ItiiGRH+9TlroWbgQ4RSc/SF9OAZo39UbIAuNZbZnyrq4YV6XfuGimq?=
 =?us-ascii?Q?9kQpppr5OlvYf/wm1UaxkXsuQoOF75o8idYyt5yvDfvysCUPU8KBUf1Nq4P1?=
 =?us-ascii?Q?8stBVQY8+uOSkIHjLm4ZLNGgGsNO0y3547R56j7Sdbc5VcBrWl61VL+vC68l?=
 =?us-ascii?Q?wxRlrQcFJyneLsG196nmBsV06FnRx72KJD0b4cDpHJa5UTkMiu8aJSQKj942?=
 =?us-ascii?Q?Pufvjw3f/H1/SEgiEaNWlqcsAfv1+Qt5OHbrPQpTnEziFG29p8lli+2C044f?=
 =?us-ascii?Q?xXE4iRbH4oQcMtVAQcqwHN7efGVHN8wa0DSjH4CxnW5Z6I3F/s3dE87W18gn?=
 =?us-ascii?Q?NP6I9b4CKq2/xbTIXk8y6RIUeklgkxEv/R2DAtPQND554ITf3xutRlrbn2O7?=
 =?us-ascii?Q?gxMbZZuF4L0S+EH4XyHTxWjIniL5rmgjjQzrse2KskEFBEvIKXtdngNwPVtZ?=
 =?us-ascii?Q?U/Xf4kdledyyWKf3lCLcrQHV+k9205EHhz7eHCwIV24iQ/ITg2O4nVgofDyk?=
 =?us-ascii?Q?ndwMinpFWm24CSIz9p+yhHARo/1caQrMzojGbrxp/sBVzcNbxgWay1BuuY6m?=
 =?us-ascii?Q?M5OwZAVdT73BiACIlg9fj3AF7iwEAHXh5XkZvpE4I47aydQuVHdn06G2VZst?=
 =?us-ascii?Q?R2ERYWeMpCTgU+211/NDTRZtnBMmBm7i4s21isWVoDWfTBSa8PQBc7QFnu1w?=
 =?us-ascii?Q?XmFwFDBdh9+8QhlJaxYRucP4wSMyf0njVO7TgebhnBFbp47zz3rZ2Bpy9FrA?=
 =?us-ascii?Q?O/ZzCWDVc9b6S7/bDro+v/TgD9K4+2xuKQcaiNAenDzkaT7BIqIYk3ZBmR0o?=
 =?us-ascii?Q?e+W1mgbf56eIJIG0fwvHeFQJxYpD60vDmyvbJSeAKqgys1o4wRutg1lP3Y+L?=
 =?us-ascii?Q?l9BdZy16FR8gJvtWejozoWQS5dvV9FClmaNCSCoa1NdgGPUVQIyXoBI5yP2w?=
 =?us-ascii?Q?s8M222Ozb+CF7v0zcsZLXy+cGvHF0yFEaiXKxjkwvjpvr0q55GZ9KVdAwZ5f?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c364c21-0cef-4974-0136-08dd150d0f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 09:13:18.9769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 927e186b-5306-4888-8faf-367d5292e481
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYazIxxwftkagpvqiITkBVb20Ptz2EjIAvVUr3XjU+9Xg+EuolW+I4tGjawcOPdlGkY1QZkNCVX4V4hYE0QC7m+TyQy35+T7lqVDpzphUEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1093
X-OriginatorOrg: lenovonetapp.com

The `nfs4_xdr_dec_open()` function does not properly check the return=20
status of the `ACCESS` operation. This oversight can result in=20
out-of-bounds memory access when decoding NFSv4 compound requests.

For instance, in an NFSv4 compound request `{5, PUTFH, OPEN, GETFH,=20
ACCESS, GETATTR}`, if the `ACCESS` operation (step 4) returns an error,=20
the function proceeds to decode the subsequent `GETATTR` operation=20
(step 5) without validating the RPC buffer's state. This can cause an=20
RPC buffer overflow, which leading to a system panic. This issue=20
can be reliably reproduced by running multiple `fsstress` tests in the=20
same directory exported by the Ganesha NFS server.

This patch introduces proper error handling for the `ACCESS` operation=20
in `nfs4_xdr_dec_open()` and `nfs4_xdr_dec_open_noattr()`. When an=20
error is detected, the decoding process is terminated gracefully to=20
prevent further buffer corruption and ensure system stability.

 #7 [ffffa42b17337bc0] page_fault at ffffffff906010fe
    [exception RIP: xdr_set_page_base+61]
    RIP: ffffffffc12166dd  RSP: ffffa42b17337c78  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffffa42b17337db8  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffffa42b17337db8
    RBP: 0000000000000000   R8: ffff904948b0a650   R9: 0000000000000000
    R10: 8080808080808080  R11: ffff904ac3c68be4  R12: 0000000000000009
    R13: ffffa42b17337db8  R14: ffff904aa6aee000  R15: ffffffffc11f7f50
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffa42b17337c78] xdr_set_next_buffer at ffffffffc1217b0b [sunrpc]
 #9 [ffffa42b17337c90] xdr_inline_decode at ffffffffc1218259 [sunrpc]
 #10 [ffffa42b17337cb8] __decode_op_hdr at ffffffffc128d2c2 [nfsv4]
 #11 [ffffa42b17337cf0] decode_getfattr_generic.constprop.124 at ffffffffc1=
2980a2 [nfsv4]
 #12 [ffffa42b17337d58] nfs4_xdr_dec_open at ffffffffc1298374 [nfsv4]
 #13 [ffffa42b17337db0] call_decode at ffffffffc11f8144 [sunrpc]
 #14 [ffffa42b17337e28] __rpc_execute at ffffffffc1206ad5 [sunrpc]
 #15 [ffffa42b17337e80] rpc_async_schedule at ffffffffc1206e39 [sunrpc]
 #16 [ffffa42b17337e98] process_one_work at ffffffff8fcfe397
 #17 [ffffa42b17337ed8] worker_thread at ffffffff8fcfea60
 #18 [ffffa42b17337f10] kthread at ffffffff8fd04406
 #19 [ffffa42b17337f50] ret_from_fork at ffffffff9060023f

Signed-off-by: changxin.liu <changxin.liu@lenovonetapp.com>
---
 fs/nfs/nfs4xdr.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e8ac3f615f93..819e3fd7487b 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6637,11 +6637,16 @@ static int nfs4_xdr_dec_open(struct rpc_rqst *rqstp=
, struct xdr_stream *xdr,
 	status =3D decode_getfh(xdr, &res->fh);
 	if (status)
 		goto out;
-	if (res->access_request)
-		decode_access(xdr, &res->access_supported, &res->access_result);
-	decode_getfattr(xdr, res->f_attr, res->server);
+	if (res->access_request) {
+		status =3D decode_access(xdr, &res->access_supported, &res->access_resul=
t);
+		if (status)
+			goto out;
+	}
+	status =3D decode_getfattr(xdr, res->f_attr, res->server);
+	if (status)
+		goto out;
 	if (res->lg_res)
-		decode_layoutget(xdr, rqstp, res->lg_res);
+		status =3D decode_layoutget(xdr, rqstp, res->lg_res);
 out:
 	return status;
 }
@@ -6691,11 +6696,16 @@ static int nfs4_xdr_dec_open_noattr(struct rpc_rqst=
 *rqstp,
 	status =3D decode_open(xdr, res);
 	if (status)
 		goto out;
-	if (res->access_request)
-		decode_access(xdr, &res->access_supported, &res->access_result);
-	decode_getfattr(xdr, res->f_attr, res->server);
+	if (res->access_request) {
+		status =3D decode_access(xdr, &res->access_supported, &res->access_resul=
t);
+		if (status)
+			goto out;
+	}
+	status =3D decode_getfattr(xdr, res->f_attr, res->server);
+	if (status)
+		goto out;
 	if (res->lg_res)
-		decode_layoutget(xdr, rqstp, res->lg_res);
+		status =3D decode_layoutget(xdr, rqstp, res->lg_res);
 out:
 	return status;
 }
--=20
2.27.0


