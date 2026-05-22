Return-Path: <linux-nfs+bounces-21788-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMTrFsNPEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21788-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:44:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F95B459B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FBD930830BA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8A39A4DC;
	Fri, 22 May 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pskq59gK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20B38E8A5;
	Fri, 22 May 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452962; cv=none; b=SVqZBaR1tJeVks/xXs8k9MDS3a/GXjlJz3hlhkBzZJFVFO8wdn3KrJrFNdFG91/By7g2mOAn9q7xFPO603iaKXsAHVGo1GwM79eP24zsih2ArYr+JW+SVrz9baW8iO9FL4o0z9mhCkSle2jsRTFHoGoTYKCft7ETI5NDWPHZ394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452962; c=relaxed/simple;
	bh=b1rU6ZAGMx709xUdqTWwkbd1Zwx96RNeV+LNlMCfsIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pnx0/W9jr20QG1eZZZ876bHzEfngNrSZ+WhRdOoZtYSgLh0W2bLPOZ0sou90+Q4Ey/NmUb95DWSlltnA8JDvpvihNGL9rGPZi1jEh5INDLNwswr2u3YeQ75bPhsROgcviyfj7jOTzoPa/dF0TD9vI9VUGDj2NG3qCR8UK3s476o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pskq59gK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F201F0155A;
	Fri, 22 May 2026 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452961;
	bh=4LN8CBPtlSu0h1hjRMQR5ihtJ8gQEm1OuiggHng7lj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pskq59gKO7QScu2KFodiQoaP9Rot9rM81ScZ5rr9JrixEV5YesVNh2MPot14225kO
	 5Rb9KxVPiLTRecdIOoiIBMIrxC9HWpI++3vKKxCkmvFkXmP1r4lvck1l66X2DaQ+qu
	 ytPqs4CWl8iiMSNLXEikyvqATmMazl8fxA3/dk0lezy2nfyt++/CiDoANs3GSwxjYJ
	 N/+ULcnOdeN7g2eRz7EgI9V2qgqLCggjbMXPUpReJm0AqMflCWhryMRE6kLdEXmHMB
	 gf5OZ3Xyq8ZFG3rARoZ8hjr3tokEBsk9bV0XboIoyJxtXUmNlYbKaMJ3hy3V8lK8af
	 3bmUV1tORDUTg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:28:56 -0400
Subject: [PATCH v4 07/21] nfsd: add callback encoding and decoding linkages
 for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-7-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=b1rU6ZAGMx709xUdqTWwkbd1Zwx96RNeV+LNlMCfsIs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwOkhcogk+Qxy6TDIl9z7Y1TWQNG3Fve7SJF
 ri1zcxfIQeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDgAKCRAADmhBGVaC
 Ff8QD/kBNWykl8tScnfoshyW8rKhjTQHRMreOWaC8mTnOIV1Taze3sWrV57egDhhpWAeKpa7PE6
 /oTEUbjjL7F1cHWA+2vgAIGZ4JyMIwD/PcneLpZpOa7O1KdlDMMg3TIEjuKmnh8LaUSaOTNVZqC
 v9LvvIe2guK4JIjonnbGskqZPex9djk9CrI00/7+2HW55nmb/+S+OCALrZvfctGSPPjOU4p1X9Y
 lOHUlMJGP1MS2vS/3Gjxk0mBfcoZ+qVLFu0u5X5exvwClbmh04T1brslYxNqYQlBmZ/WD6neD5y
 YoTzFpb+mhaW6TwViTuo+ukuJBDB8PmVEnzvIKUOZGMDJ3C5T2pXABg8Y1bV+WxgkCjiHdOFB3E
 dRpxA+DQHu+QSVsxSTsrq9+g4qsELxg79nLWcNNW1gYrAe4JPHzsXWJkP2AtjsgBJe/pNmI/VFU
 N7f48GgaLoixB4T9o6nONQ5WHFlIF+dfwINnu7004xuWvPsEr0R7qVwlLH2KXtfYdIsJu6B6upR
 V6EDIC8KeCqCguOfd/jqsU6ICLKy1lR4GUAMPfsH9wkf7Zug623TiAB0Mxmz5a4NobUaBGLKeVy
 +MWjxf/QQ3WnwVtO/3PwIvL2mI2JcbbD+BWCwks0yG4d7gnmJG/NZHAsYcy7dqTiFJfxW7WT1Pq
 eJDzaDd+ytkyURA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21788-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F8F95B459B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add routines for encoding and decoding CB_NOTIFY messages. These call
into the code generated by xdrgen to do the actual encoding and
decoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |  8 ++++++++
 fs/nfsd/xdr4cb.h       | 12 ++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 25bbf5b8814d..ea3e7deb06fa 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -865,6 +865,51 @@ static void encode_stateowner(struct xdr_stream *xdr, struct nfs4_stateowner *so
 	xdr_encode_opaque(p, so->so_owner.data, so->so_owner.len);
 }
 
+static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   const void *data)
+{
+	const struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = 0,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+	struct CB_NOTIFY4args args = { };
+
+	WARN_ON_ONCE(hdr.minorversion == 0);
+
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+
+	/*
+	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
+	 * buffer, and zero it.
+	 */
+	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
+
+	hdr.nops++;
+	encode_cb_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_cb_notify(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+
+	status = decode_cb_compound4res(xdr, &hdr);
+	if (unlikely(status))
+		return status;
+
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
+	return decode_cb_op_status(xdr, OP_CB_NOTIFY, &cb->cb_status);
+}
+
 static void nfs4_xdr_enc_cb_notify_lock(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
 					const void *data)
@@ -1026,6 +1071,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #ifdef CONFIG_NFSD_PNFS
 	PROC(CB_LAYOUT,	COMPOUND,	cb_layout,	cb_layout),
 #endif
+	PROC(CB_NOTIFY,		COMPOUND,	cb_notify,	cb_notify),
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e1c40f8b5d01..790282781243 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -190,6 +190,13 @@ struct nfs4_cb_fattr {
 	u64 ncf_cur_fsize;
 };
 
+/*
+ * FIXME: the current backchannel encoder can't handle a send buffer longer
+ *        than a single page (see bc_alloc/bc_free).
+ */
+#define NOTIFY4_EVENT_QUEUE_SIZE	3
+#define NOTIFY4_PAGE_ARRAY_SIZE		1
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -774,6 +781,7 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
 	NFSPROC4_CLNT_CB_RECALL_ANY,
 	NFSPROC4_CLNT_CB_GETATTR,
+	NFSPROC4_CLNT_CB_NOTIFY,
 };
 
 /* Returns true iff a is later than b: */
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index f4e29c0c701c..b06d0170d7c4 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -33,6 +33,18 @@
 					cb_sequence_dec_sz +            \
 					op_dec_sz)
 
+#define NFS4_enc_cb_notify_sz		(cb_compound_enc_hdr_sz +       \
+					cb_sequence_enc_sz +            \
+					1 + enc_stateid_sz +            \
+					enc_nfs4_fh_sz +		\
+					1 +				\
+					NOTIFY4_EVENT_QUEUE_SIZE *	\
+					(2 + (NFS4_OPAQUE_LIMIT >> 2)))
+
+#define NFS4_dec_cb_notify_sz		(cb_compound_dec_hdr_sz  +      \
+					cb_sequence_dec_sz +            \
+					op_dec_sz)
+
 #define NFS4_enc_cb_notify_lock_sz	(cb_compound_enc_hdr_sz +        \
 					cb_sequence_enc_sz +             \
 					2 + 1 +				 \

-- 
2.54.0


