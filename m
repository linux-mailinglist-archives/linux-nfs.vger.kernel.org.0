Return-Path: <linux-nfs+bounces-2374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9D87EDEB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 17:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E51C21DFF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B654FAF;
	Mon, 18 Mar 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3w50cXa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105B54FA6;
	Mon, 18 Mar 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780510; cv=none; b=ZBuhdQEAm9CGM25GcALa/Nwq8I2OHwC3CSjIGpWBEE/OF/j4WWcmzR9+tAmaSudkNHO0niEjeT8Ro+azXNy5UjB3SZmIM18ybq+gZCs4ODkzF32QcYv8ntzuNLImnz3LlnMaYVmdDapb6xnSbpnLkuLJtib17yvzILdoMjvMsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780510; c=relaxed/simple;
	bh=yGU/0gf5M1EqusA+t0d+zz931jpa6jjz9G8iT77WZek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ldudGrr6sH5RPJ4dloEmB5aXCWRfkDLHg0Qmu9Dn+3CWbB9MGVnPcD3cNqzpBPDpp7ibQNnj+WZS0OC2dHNrbQhE956MxNaYE38tqRtvZ6pJMkbE1aPTHmOEoIoG0nU4CS1yanjxcbFmjE7gTbi/3nZT3FYNci6Wcf3/h6X60w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3w50cXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508F6C433F1;
	Mon, 18 Mar 2024 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710780510;
	bh=yGU/0gf5M1EqusA+t0d+zz931jpa6jjz9G8iT77WZek=;
	h=From:Date:Subject:To:Cc:From;
	b=k3w50cXatDgcL9NK9Q2HcqD+oVewJZN4RL2cdEYiEMzrdMgYGy8CP3YWssngfvbGY
	 xHc4c+0Uqo99vPfNivqd2SQmNunOAjNDnvae/HJ551B/3yz00G7eAmNiJVv5LBLSLS
	 n7HzrL/k5pWz92lHoCi9KkdWFA+R3JTzExNbWCWU+qYBOG0tfYTHY4EAqVwcGWum9X
	 TWjt/0V+853uU6VWlrOdN4lnLinUr1dpcJEPqT60P0yYsf3s55Q+3G06GcGmuHQFXY
	 Sl3g+LTS6ulUt+SXei60M7p/XHQ8NjlNfUNL+jcCMKyMyXUJO25r4n/wFxKTeurUFH
	 R9nEGUqGVp/6Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 18 Mar 2024 12:48:04 -0400
Subject: [PATCH] nfsd: trivial GET_DIR_DELEGATION support
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-nfs-gdd-trivial-v1-1-158924b9e00d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAENw+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3by0Yt30lBTdkqLMsszEHF1DyySz5EQzU2MLE0MloK6CotS0zAq
 widGxtbUAhG3LP2EAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8435; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yGU/0gf5M1EqusA+t0d+zz931jpa6jjz9G8iT77WZek=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl+HBVp06wW7PPjy/egf7OEtVwU59KWmIoT3Kxc
 dfOWEZSgGeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfhwVQAKCRAADmhBGVaC
 FSnMD/9MvlvA6epxY6FccjlMbfRfWb8T867VI1M93qHHvvQhp+buXVzFHcOqsbbI48uki/fcTns
 gKBmEC/qVw5MN+UZjrgPf7dhOH2WY0A6IU42drZIWkXoBbpx6rVMMx0np8xs6YCG0Bo8bJwzxfG
 G7fuFj7GGrItGbUrrdcyqBnwsbNjUbTUW0pKGRuEjb8V/Tj4lTlSJEuKZh4zVJCrVfjb7fh0K5o
 QqDsassoBrHrFDb+pc+Lgp7ZsKaYqcOV5lWmvV0duZSnwwOGFxV1bChPLFF4MzMb3hqpECAC53n
 hxf6juIxs5nMJUZmmxyJ0rI/AurhQhfMK9+M38A/58NZR9tQZYCkQQiGhm9Ew5jlQ9cM8AAtkBL
 BgJU4jRsSxrHrk7a1o3C4A1Z7FlPv0zn3mh3SZ9EdLO+0N9jm8q9Za5QydFHvdPBpDHLcC7+k9w
 oEh0W25hIbLFA8oUaVYWY6lJzUz79DPYlzO6xKPtYX7dCgG/njyii0KX8rEOOCPhCyExWvzv6Ow
 PZGR3NMya86LOOipMlRup45HIpOWqDxVP6DyQDaZXrDQvS+srSeUSb5ld1cTebWHO/4PiTyJBEv
 i/wgB7zzdixDSexBNsvfzGVxbUsQ9i/EPm4xyAV0Z097wPHmrowyRR9sCRFczZl7/yzq/PEB1Hg
 W+gU6nNhm0Ge/aQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This adds basic infrastructure for handing GET_DIR_DELEGATION calls from
clients, including the decoders and encoders. For now, the server side
always just returns that the  delegation is GDDR_UNAVAIL (and that we
won't call back).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Please consider this for v6.10. Eventually clients may start sending
this operation, and it's better if we can return GDD4_UNAVAIL instead of
having to abort the whole compound.
---
 fs/nfsd/nfs4proc.c   | 30 +++++++++++++++++
 fs/nfsd/nfs4xdr.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h       | 19 +++++++++++
 include/linux/nfs4.h |  6 ++++
 4 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2927b1263f08..46b3d99c2786 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2154,6 +2154,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
+static __be32
+nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
+			 struct nfsd4_compound_state *cstate,
+			 union nfsd4_op_u *u)
+{
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+
+	/* FIXME: implement directory delegations */
+	gdd->gddrnf_status = GDD4_UNAVAIL;
+	return nfs_ok;
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static const struct nfsd4_layout_ops *
 nfsd4_layout_verify(struct svc_export *exp, unsigned int layout_type)
@@ -3082,6 +3094,18 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
 		* sizeof(__be32);
 }
 
+static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
+					  const struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size +
+		1 /* gddr_status */ +
+		op_encode_verifier_maxsz +
+		op_encode_stateid_maxsz +
+		2 /* gddr_notification */ +
+		2 /* gddr_child_attributes */ +
+		2 /* gddr_dir_attributes */);
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
 				     const struct nfsd4_op *op)
@@ -3470,6 +3494,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
+	[OP_GET_DIR_DELEGATION] = {
+		.op_func = nfsd4_get_dir_delegation,
+		.op_flags = OP_MODIFIES_SOMETHING,
+		.op_name = "OP_GET_DIR_DELEGATION",
+		.op_rsize_bop = nfsd4_get_dir_delegation_rsize,
+	},
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO] = {
 		.op_func = nfsd4_getdeviceinfo,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fac938f563ad..369b85e42440 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1732,6 +1732,40 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
+static __be32
+nfsd4_decode_get_dir_delegation(struct nfsd4_compoundargs *argp,
+		union nfsd4_op_u *u)
+{
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	__be32 status;
+
+	memset(gdd, 0, sizeof(*gdd));
+
+	if (xdr_stream_decode_bool(argp->xdr, &gdd->gdda_signal_deleg_avail) < 0)
+		return nfserr_bad_xdr;
+
+	status = nfsd4_decode_bitmap4(argp, gdd->gdda_notification_types,
+				      ARRAY_SIZE(gdd->gdda_notification_types));
+	if (status)
+		return status;
+
+	status = nfsd4_decode_nfstime4(argp, &gdd->gdda_child_attr_delay);
+	if (status)
+		return status;
+
+	status = nfsd4_decode_nfstime4(argp, &gdd->gdda_dir_attr_delay);
+	if (status)
+		return status;
+
+	status = nfsd4_decode_bitmap4(argp, gdd->gdda_child_attributes,
+					ARRAY_SIZE(gdd->gdda_child_attributes));
+	if (status)
+		return status;
+
+	return nfsd4_decode_bitmap4(argp, gdd->gdda_dir_attributes,
+					ARRAY_SIZE(gdd->gdda_dir_attributes));
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
@@ -2370,7 +2404,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
 	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
 	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
-	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_get_dir_delegation,
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
 	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
@@ -5002,6 +5036,59 @@ nfsd4_encode_device_addr4(struct xdr_stream *xdr,
 	return nfserr_toosmall;
 }
 
+static __be32
+nfsd4_encode_get_dir_delegation(struct nfsd4_compoundres *resp, __be32 nfserr,
+				union nfsd4_op_u *u)
+{
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	struct xdr_stream *xdr = resp->xdr;
+	__be32 status = nfserr_resource;
+
+	switch(gdd->gddrnf_status) {
+	case GDD4_OK:
+		if (xdr_stream_encode_u32(xdr, GDD4_OK) != XDR_UNIT)
+			break;
+
+		status = nfsd4_encode_verifier4(xdr, &gdd->gddr_cookieverf);
+		if (status)
+			break;
+
+		status = nfsd4_encode_stateid4(xdr, &gdd->gddr_stateid);
+		if (status)
+			break;
+
+		status = nfsd4_encode_bitmap4(xdr, gdd->gddr_notification[0], 0, 0);
+		if (status)
+			break;
+
+		status = nfsd4_encode_bitmap4(xdr, gdd->gddr_child_attributes[0],
+						   gdd->gddr_child_attributes[1],
+						   gdd->gddr_child_attributes[2]);
+		if (status)
+			break;
+
+		status = nfsd4_encode_bitmap4(xdr, gdd->gddr_dir_attributes[0],
+						   gdd->gddr_dir_attributes[1],
+						   gdd->gddr_dir_attributes[2]);
+		break;
+	default:
+		/*
+		 * If we don't recognize the gddrnf_status value, just treat it
+		 * like unavail + no notification, but print a warning too.
+		 */
+		pr_warn("nfsd: bad gddrnf_status (%u)\n", gdd->gddrnf_status);
+		gdd->gddrnf_will_signal_deleg_avail = 0;
+		fallthrough;
+	case GDD4_UNAVAIL:
+		if (xdr_stream_encode_u32(xdr, GDD4_UNAVAIL) != XDR_UNIT)
+			break;
+
+		status = nfsd4_encode_bool(xdr, gdd->gddrnf_will_signal_deleg_avail);
+		break;
+	}
+	return status;
+}
+
 static __be32
 nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 		union nfsd4_op_u *u)
@@ -5580,7 +5667,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
 	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
 	[OP_FREE_STATEID]	= nfsd4_encode_noop,
-	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_get_dir_delegation,
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
 	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 415516c1b27e..446e72b0385e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -518,6 +518,24 @@ struct nfsd4_free_stateid {
 	stateid_t	fr_stateid;         /* request */
 };
 
+struct nfsd4_get_dir_delegation {
+	/* request */
+	u32			gdda_signal_deleg_avail;
+	u32			gdda_notification_types[1];
+	struct timespec64	gdda_child_attr_delay;
+	struct timespec64	gdda_dir_attr_delay;
+	u32			gdda_child_attributes[3];
+	u32			gdda_dir_attributes[3];
+	/* response */
+	u32			gddrnf_status;
+	nfs4_verifier		gddr_cookieverf;
+	stateid_t		gddr_stateid;
+	u32			gddr_notification[1];
+	u32			gddr_child_attributes[3];
+	u32			gddr_dir_attributes[3];
+	bool			gddrnf_will_signal_deleg_avail;
+};
+
 /* also used for NVERIFY */
 struct nfsd4_verify {
 	u32		ve_bmval[3];        /* request */
@@ -797,6 +815,7 @@ struct nfsd4_op {
 		struct nfsd4_reclaim_complete	reclaim_complete;
 		struct nfsd4_test_stateid	test_stateid;
 		struct nfsd4_free_stateid	free_stateid;
+		struct nfsd4_get_dir_delegation	get_dir_delegation;
 		struct nfsd4_getdeviceinfo	getdeviceinfo;
 		struct nfsd4_layoutget		layoutget;
 		struct nfsd4_layoutcommit	layoutcommit;
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index ef8d2d618d5b..0d896ce296ce 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -701,6 +701,12 @@ enum state_protect_how4 {
 	SP4_SSV		= 2
 };
 
+/* GET_DIR_DELEGATION non-fatal status codes */
+enum gddrnf4_status {
+	GDD4_OK		= 0,
+	GDD4_UNAVAIL	= 1
+};
+
 enum pnfs_layouttype {
 	LAYOUT_NFSV4_1_FILES  = 1,
 	LAYOUT_OSD2_OBJECTS = 2,

---
base-commit: c442a42363b2ce5c3eb2b0ff1e052ee956f0a29f
change-id: 20240318-nfs-gdd-trivial-19b6ca653841

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


