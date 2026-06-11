Return-Path: <linux-nfs+bounces-22480-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aCf6K8X1Kmo20AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22480-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:52:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060867429D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CfMInuf6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22480-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22480-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88C2A3046703
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52249553A;
	Thu, 11 Jun 2026 17:50:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07044BC03A;
	Thu, 11 Jun 2026 17:50:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200247; cv=none; b=aY/qmg3WPuDh8MoKttG623OQr/NmzAUD1MYjqwtCq7PiAaBjC4lceYNMPgq3AM657Odutc4cNPsDEzzqA/Z8XepW+bEwFjMOGSi2lDjGK+OseZlDXitd7WV9R1SYR7XRbmtZ3tTl6QZA6DT1v1WDanhRO/mir0jht0UDLe1fn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200247; c=relaxed/simple;
	bh=/v4AGcwQ+jnip7ZQR/LFyLLB2ScGGRIhZ59DQDHD4ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnDfT+uXT3JjDLxLbltupLl7IomW7zYNwOl63PwFrDoE026iRrWWrASO3v4I6LqBLfA/pW/8Kff0Vzrtj9PhZ7dHVKpJ0mJEg59nRCHB5OrnDWXWsI7EHw58FKlwFhcAZlYOiOaqgu59QOo2SrsEIK5DxKRdsujEq3L/xZ64s4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfMInuf6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7491F00899;
	Thu, 11 Jun 2026 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200245;
	bh=lXV96LtnO9o/mjSP+w7I8N2g9RxbMO5a1AjpS6Fy6rM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CfMInuf6GALvKyof2wLkTqvLrMEw0MCWdmX4Qva/i2/xcUM7huaEXqo/0Ev/jD3j/
	 gbMBetlXxk04GZufE4TaFlV/slyD0KqKuJhdDUINZmQ6a8H6B2wOMdUsAYHYoF7mI1
	 Fpteb2gKg3za/VBfH0o0+3yLxpZWvraWjKiWaVCkjgwU/3PzPzkwullSUNMqvXFG/v
	 xOmoKyAhI4InR1m3Vu/mts06zqf6mVxwS4baWTjv5bl8z4PVM8RxF3PF6ybJ59LfTM
	 Lbx4lQyxGC20OKF6R4H9FimG06MNEqNU/86MSPgQt3HBmujnCGKfIlR1gA5X8RFx7M
	 nkF6Ln6/2D89g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:13 -0400
Subject: [PATCH v6 07/20] nfsd: add callback encoding and decoding linkages
 for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-7-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4063; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/v4AGcwQ+jnip7ZQR/LFyLLB2ScGGRIhZ59DQDHD4ok=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVf5E600Pbka7zLUe4XVEcHBrlrLjke+Oy+a
 7uzDtX1T9qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1XwAKCRAADmhBGVaC
 FVlXD/49+9hmWEvkURRaV61VyLU0RgQ5Aw3ZrAVuX2dsy1WgmFkhXdgQo6TaGZSPMnzNw0uAJZB
 O/5RKbso3N7UaJha2OZ43xYRXd/p+MlA4nnc+fZuZOxgf9p3Azcf3ylBLMN1wcNFU51UQTesCyc
 CZsgWxNHgUFN8XBFfKVvhkSr8Mpagta0ZHP/8VkBxIPNQtyaSasafLm3gK3T6Kd2GjyWWqnlTGt
 F82JmWidz8+rUT+4699n/a8FM9r8tpM41n3/jlYX4rmgGw8AYw5WOEdr+1OFRlz1y8oskj+gSf4
 1BChBuxNuIL6MlEpzQhZPrZhcH27fLnOpNYLidZbyxqRwz1j/RseTZQIdnON+vHCVtkp0k8w06y
 VmTEnYRKfKOybQB+i2cZ17Ypp/NiulMiga0jyp1pTp5xk+GYTMmXYNK71y+5V+JQ4RkTm9gBlIH
 X98U8+/LaZsEkQzTd/hPHrXzRL612SA9Rl3JJfkiA6Gly7rsSq8Yc+EZ3HRBIWIkUKfweL5Czce
 m2bnpdoFrXsh/Nz7XZL3IBOVEUqnnfkZAZvnCNH4n3upIG36WnjhcGB3fOeNHaFlVuVCVuM3WbR
 0h+rFStdmkId46fgRlnmdWgJhwFA+J9sdzwv82/tvohc8W2D3WkFzuSpL7XQV/fF6R7MYcYRdYq
 /IPdVwWAfHhWFjw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22480-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5060867429D

Add routines for encoding and decoding CB_NOTIFY messages. These call
into the code generated by xdrgen to do the actual encoding and
decoding.

For now, the encoder is a stub. Later patches will flesh out the payload
encoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |  8 ++++++++
 fs/nfsd/xdr4cb.h       | 12 ++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index a3c46905fd47..ca4dd2f969eb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -887,6 +887,51 @@ static void encode_stateowner(struct xdr_stream *xdr, struct nfs4_stateowner *so
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
+	xdrgen_encode_CB_NOTIFY4args(xdr, &args);
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
@@ -1048,6 +1093,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #ifdef CONFIG_NFSD_PNFS
 	PROC(CB_LAYOUT,	COMPOUND,	cb_layout,	cb_layout),
 #endif
+	PROC(CB_NOTIFY,		COMPOUND,	cb_notify,	cb_notify),
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4c6765a4cf22..9f321e9ed76d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -190,6 +190,13 @@ struct nfs4_cb_fattr {
 	u64 ncf_cur_fsize;
 };
 
+/*
+ * FIXME: the current backchannel encoder can't handle a send buffer longer
+ *        than a single page (see bc_malloc/bc_free).
+ */
+#define NOTIFY4_EVENT_QUEUE_SIZE	3
+#define NOTIFY4_PAGE_ARRAY_SIZE		1
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -776,6 +783,7 @@ enum nfsd4_cb_op {
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


