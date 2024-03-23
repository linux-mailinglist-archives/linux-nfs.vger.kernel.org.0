Return-Path: <linux-nfs+bounces-2449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF718878D1
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Mar 2024 14:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24E5282455
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Mar 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FC282FB;
	Sat, 23 Mar 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxnyygNc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB419CA6F;
	Sat, 23 Mar 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200371; cv=none; b=TuHw1nVn5873IvaM05zFlwhKHL1JobpMR43EQi9w1JUzcSvFGrE8gBEOXQdpS1zRkDqUicE8YBTgJy140+NH5kliPMRKUqRb4Vr9aPpwQzhzdWImBahNXOAhk9FNQ29fN5XT9f3u0s7+woSu4L/Sbm7pZpPZSLsJYL7JOl/6rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200371; c=relaxed/simple;
	bh=ofTSoDtrxZISRXGkFAOEOhhLeS+oijtwq6/TO6rcW6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q31o3G3uQ0TSB76I48b8Fl+RRm5K24rE9YF8rKSkU8nwrJ6rE/+A6yPoh/LbIoecVefhKQpHgjPOSvKLFEHqju2HNaPcjA0ix00e5H3nKCabSo6vAZNwm2t/0r/tIZghu9adFb5eRRDAxrGKSNmUwbyRCYizFs/HedGFyIx/9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxnyygNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D907BC433F1;
	Sat, 23 Mar 2024 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711200370;
	bh=ofTSoDtrxZISRXGkFAOEOhhLeS+oijtwq6/TO6rcW6c=;
	h=From:Date:Subject:To:Cc:From;
	b=uxnyygNc72qqDv1lmuZDp68s529vKM1HgFsyL0SDfxLrFjMvHcLV2ymexxmDkK0eA
	 qvTmGlF6ly4PR+1hWbnE0s3OrjUBUNZqR76FColi3ih6EWAbreoPEsNekptRS46pFZ
	 ToQekbOCPg+PXs5EaKA0q5dtdEHLiQV6aclLrWo13IFUleZ2Tx7Nzzl3DeGcgqFwma
	 yFdkEfCuLC+Uc9AUNw9rfGeulgvlWSVcVMHlgiyzzooJOvhsgHg8cGi6Td4n+I1hBR
	 nRS1bpsQeiph1ARSe6nUJXzVNgprCXJXXR8fx/gzRLZO/jQoVmPVEuDtuEdXganDfY
	 CgmVQ1z4Vs0Cg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 23 Mar 2024 09:25:54 -0400
Subject: [PATCH v2] nfsd: trivial GET_DIR_DELEGATION support
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-nfs-gdd-trivial-v2-1-8549a4008daa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGHY/mUC/3WNwQqDMBBEf0X23C1JjKI99T+KBzWrLpVYNhJaJ
 P/e1HuZ0xuYNwcEEqYAt+IAociBN5/BXAoYl97PhOwyg1HGqlI36KeAs3O4C0fuV9TtUI99XZW
 N1ZBXL6GJ36fx0WVeOOybfM6DqH/tf1fUmFM1rbFDS0q5+5PE03rdZIYupfQFLxWlSK8AAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8964; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ofTSoDtrxZISRXGkFAOEOhhLeS+oijtwq6/TO6rcW6c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl/thu78xCRl8OJ6jg1lGJD97j/zt7WlaZfyAJ/
 KEg9vyudRuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZf7YbgAKCRAADmhBGVaC
 FR/sD/462Lje2tQU0PRUoHgiKLApUDzbThFe51FUeL8Nzc7viIcnpDntmqUqy9KZKoHpuHR/NkN
 ukOUnqE6/EahH7ohYggTbqzrcoyOyT/S+NP/8kEMq7il9V3czq5W/vOUVFa0+ncqMfJbXUMlWBK
 UHhUoSBQ0g0D2IXXhmTK5fx/qRtRaf0BWVkQWWx3/m1uGDNef+fxDGOCDDGZzXtYBqnzTtNkBRe
 MjWVb8c0h8iQwlE+2oZbpYysqj43KC0PFvNN7CX3zeA2Llv1GfJt1wkqF9gYJ71ejjnka6+h7NE
 rcjrKV9+fIVTnkGwfF4bkcJttlPLFRNMwQ7O78Tm83lyPySxjL9i8wz6BA3HxgVdFXZQYB8iYQM
 Gbl8ElPLrAiZPFyM+mS8E7IrDRoK5Ilu/asKW0nl44TWXdNrj3AGqD0h1SjU/UirSDE8af+3Lhm
 fdpjuCQ5QTUttbE3rW9/aqOWwiXksJ2mVK5ULBfsn/BDn2JLd8giok1geAlsrliD97+5pctk6pC
 1UDByUmQBeZe9m+qYF6kk4asTvmOsNUoJzVKt1nZzN3zQhcFrhUkP8TYoKPDgobkK20lm0+kAyA
 t1altabuYDGA5wDOb2b7MXa3kp/bzLitlmrBGrbNZa3u5nFIGusVQ8tk1Y9R+4HAFgxynZqXIaa
 gIi3aIphHlsfAtA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This adds basic infrastructure for handing GET_DIR_DELEGATION calls from
clients, including the decoders and encoders. For now, it always just
returns NFS4_OK + GDD4_UNAVAIL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Please consider this for v6.10. Eventually clients may start sending
this operation, and it's better if we can return GDD4_UNAVAIL instead of
having to abort the whole compound.
---
Changes in v2:
- move nfsd4_encode_dir_delegation outside of CONFIG_NFS4_PNFS block
- add comment to clarify the deviation from RFC8881
---
 fs/nfsd/nfs4proc.c   | 41 +++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h       | 19 +++++++++++
 include/linux/nfs4.h |  6 ++++
 4 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2927b1263f08..a581f58938e2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2154,6 +2154,29 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
+static __be32
+nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
+			 struct nfsd4_compound_state *cstate,
+			 union nfsd4_op_u *u)
+{
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+
+	/*
+	 * RFC 8881, section 18.39.3 says:
+	 *
+	 * "The server may refuse to grant the delegation. In that case, the
+	 *  server will return NFS4ERR_DIRDELEG_UNAVAIL."
+	 *
+	 * This is sub-optimal, since it means that the server would need to
+	 * abort compound processing just because the delegation wasn't
+	 * available. RFC8881bis should change this to allow the server to
+	 * optionally return NFS4_OK with a non-fatal status of GDD4_UNAVAIL
+	 * in this situation.
+	 */
+	gdd->gddrnf_status = GDD4_UNAVAIL;
+	return nfs_ok;
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static const struct nfsd4_layout_ops *
 nfsd4_layout_verify(struct svc_export *exp, unsigned int layout_type)
@@ -3082,6 +3105,18 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
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
@@ -3470,6 +3505,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index fac938f563ad..4848ebf3e14e 100644
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
@@ -4964,6 +4998,59 @@ nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfs_ok;
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
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_encode_device_addr4(struct xdr_stream *xdr,
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
base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
change-id: 20240318-nfs-gdd-trivial-19b6ca653841

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


