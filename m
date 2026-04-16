Return-Path: <linux-nfs+bounces-20901-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKDEMskh4WnMpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20901-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:52:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A98D41355F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F12731D54AC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F313EF661;
	Thu, 16 Apr 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDTwdR9r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B13EF654;
	Thu, 16 Apr 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360960; cv=none; b=AuOVvwXFEs7MnNBAQeky5kA8TpIzWDZ5vkhMXsNqPoxAsFLc9WtqfTMkC3nfYb3oUfKKAdk4M/cMEo7msoTQD8DMDuac3lI6GJZ79olOiJpZRh4nUarP9t+skxz2c3faCylKti23c1jlOQjbs0j5mgASPcASBvqeBjB9NE7qt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360960; c=relaxed/simple;
	bh=ljfjy/b8w/hQplBxEbpZFyap3tO+DH6nJOLLAPUxDOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG8EMg4Eon9OnB1XVIaiIZPP+QQ6cvuu1GjnZYsb361Y7RNsVQeAgVrnC6gQeER8kywzVNtHOIBjYok6ko3hWl307ckRq8wRF3iMPCkYe966n2SWhPfLj0QGHPbQ7+PuoCslpoyT5DfGyEnu4hp0akian+5zKNSz+I3ky+mdAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDTwdR9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FF1C2BCB0;
	Thu, 16 Apr 2026 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360960;
	bh=ljfjy/b8w/hQplBxEbpZFyap3tO+DH6nJOLLAPUxDOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LDTwdR9rcYpC+PWYmtTySZmkJeRG5rBy1KRbtNgA6wqrZncoy0QoIy59/YIHJFUlL
	 2S7eoYl9/9inXlHzl8+zzXXZ3F4xvcd6H0H0J2iCqr/sNtmB8Ci2pN8YbRyLe2sBCI
	 7Lu7F7w1USJtrqNRyghKhbzq4+k/Hh5UaydGVpkFKCZqfk/lXEnXwlywdIrZDsIjQa
	 vf530ESYqvA00pwYGuVbZLhy4USxXUJPGgMmL86l+relJEXJZ6oz91klryk17QMznJ
	 cKEdSfdx5IrdDq9EL3tDv/6NGA/QjNNx1wLs3OF5Jpnou4Ji2aRGJLW/qAj14z+RdX
	 AT0/v/Mf9Xt1w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:29 -0700
Subject: [PATCH v2 28/28] nfsd: add support to CB_NOTIFY for dir attribute
 changes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-28-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6108; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ljfjy/b8w/hQplBxEbpZFyap3tO+DH6nJOLLAPUxDOQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3o2LhexlgAJoX8NHPQ6gcu2NLN9f1xovT1r
 rInPTWLFfeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd6AAKCRAADmhBGVaC
 FYe/D/9PtdrLY15JLTr0DUze9xwoP99KYUiS2/zWUe0U684BJLG8RpLaymBBMCHbq3udqHAXiz7
 1YFMmfWqM2mb1VkEHSzdlSdPIzcu0W+L0PhZKtDqUuB2J61zwocSlYpbdgRCWA2RaF+4EWDlo2R
 d+xBOyZ3mTL1FeMxuZSqF33E4XatpwcVGlT5jxFA9qHmvTaS8ohxTim860A7RHV+VsKX10NDWIh
 FlKg24QwR16vcD5yACCAXY7CrH0toYCSEy9o7xDNKe+OqZ5U8RgwUuwvZtweXZE2/11sOxE0NCL
 jFZWSUATUAsefIRW4odMDNHJb0jP2oTeJ6UdKIpquRC2LVrWLZd4b4ETCFVoRdAaDQaVL9T+WlN
 hTTPSL/NvKIjaXMQM/LYpAGZ9P/QgXg4EVAQZ8iSr1D4kZnkKrjswh3vdRYGXclaevuoUphIX1e
 ziN4vy51Patf4ZB8M9fua6T8ZOZshsI//uPWW2R9s75HKc+kd/6TmPc+i9wsWchIAkbuay0keqJ
 3hwC9u1lQ8VbSpxw0H0h9HproOAYSpb3N7OodTjGd9y8tszRMTDYIkACNKFksKpFSbj8a5fb3Zy
 wOs806UAiPX/7gD5dphPXdjHfSv+Q9dGLqntF2mRhMwGE5WeUDeYYZBfn/Adm3vzq3bqewCYZPP
 b7JQkZOjy/rFs4A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20901-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A98D41355F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If the client requested dir attribute change notifications, send those
alongside any set of add/remove/rename events. Note that the server will
still recall the delegation on a SETATTR, so these are only sent for
changes to child dirents.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++--
 fs/nfsd/nfs4xdr.c   | 61 +++++++++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/xdr4.h      |  2 ++
 3 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 32340a0669df..5eca7899c48d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3478,10 +3478,15 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	struct nfsd_notify_event *events[NOTIFY4_EVENT_QUEUE_SIZE];
 	struct xdr_buf xdr = { .buflen = PAGE_SIZE * NOTIFY4_PAGE_ARRAY_SIZE,
 			       .pages  = ncn->ncn_pages };
+	int limit = NOTIFY4_EVENT_QUEUE_SIZE;
 	struct xdr_stream stream;
 	struct nfsd_file *nf;
-	int count, i;
 	bool error = false;
+	int count, i;
+
+	/* Save a slot for dir attr update if requested */
+	if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS))
+		--limit;
 
 	xdr_init_encode_pages(&stream, &xdr);
 
@@ -3495,7 +3500,7 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	}
 
 	/* we can't keep up! */
-	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
+	if (count > limit) {
 		spin_unlock(&ncn->ncn_lock);
 		goto out_recall;
 	}
@@ -3542,6 +3547,22 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 		nfsd_notify_event_put(nne);
 	}
 	if (!error) {
+		if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)) {
+			u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+
+			if (maskp) {
+				u8 *p = nfsd4_encode_dir_attr_change(&stream, dp, nf);
+
+				if (p) {
+					*maskp = BIT(NOTIFY4_CHANGE_DIR_ATTRS);
+					ncn->ncn_nf[count].notify_mask.count = 1;
+					ncn->ncn_nf[count].notify_mask.element = maskp;
+					ncn->ncn_nf[count].notify_vals.data = p;
+					ncn->ncn_nf[count].notify_vals.len = (u8 *)stream.p - p;
+					++count;
+				}
+			}
+		}
 		ncn->ncn_nf_cnt = count;
 		nfsd_file_put(nf);
 		return true;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bd1142590d2b..73f2fdf929ed 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4152,11 +4152,11 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
 	struct nfs4_file *fi = dp->dl_stid.sc_file;
-	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
-			      .dentry = dentry };
+	struct path path = nf->nf_file->f_path;
 	struct nfsd4_fattr_args args = { };
 	uint32_t *attrmask;
 	__be32 status;
+	bool parent;
 	int ret;
 
 	/* Reserve space for attrmask */
@@ -4168,6 +4168,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	parent = (dentry == path.dentry);
+	path.dentry = dentry;
+
 	/* FIXME: d_find_alias for inode ? */
 	if (!path.dentry || !d_inode(path.dentry))
 		goto noattrs;
@@ -4183,15 +4186,20 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = dp->dl_child_attrs[0];
-	attrmask[1] = dp->dl_child_attrs[1];
-	attrmask[2] = 0;
+	if (parent) {
+		attrmask[0] = dp->dl_dir_attrs[0];
+		attrmask[1] = dp->dl_dir_attrs[1];
+	} else {
+		attrmask[0] = dp->dl_child_attrs[0];
+		attrmask[1] = dp->dl_child_attrs[1];
 
-	if (!setup_notify_fhandle(dentry, fi, nf, &args))
-		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
+		if (!setup_notify_fhandle(dentry, fi, nf, &args))
+			attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (!(args.stat.result_mask & STATX_BTIME))
-		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+		if (!(args.stat.result_mask & STATX_BTIME))
+			attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	}
+	attrmask[2] = 0;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
@@ -4308,6 +4316,41 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
 	return NULL;
 }
 
+/**
+ * nfsd4_encode_dir_attr_change
+ * @xdr: stream to which to encode the fattr4
+ * @dp: delegation where the event occurred
+ * @nf: nfsd_file opened on the directory
+ *
+ * Encode a dir attr change event.
+ */
+u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation *dp,
+				 struct nfsd_file *nf)
+{
+	struct dentry *dentry = nf->nf_file->f_path.dentry;
+	struct notify_attr4 na = { };
+	struct name_snapshot n;
+	bool ret;
+	u8 *p = NULL;
+
+	if (!(dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)))
+		return NULL;
+
+	take_dentry_name_snapshot(&n, dentry);
+	ret = nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
+					dentry, dp, nf, (char *)n.name.name,
+					n.name.len);
+
+	/* Don't bother with the event if we're not encoding attrs */
+	if (ret && na.na_changed_entry.ne_attrs.attr_vals.len) {
+		p = (u8 *)xdr->p;
+		if (!xdrgen_encode_notify_attr4(xdr, &na))
+			p = NULL;
+	}
+	release_dentry_name_snapshot(&n);
+	return p;
+}
+
 static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
 				struct xdr_buf *buf, __be32 *p, int bytes)
 {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d276840aca50..cf7f0df68d63 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -958,6 +958,8 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *nne,
 			      struct nfs4_delegation *dd, struct nfsd_file *nf,
 			      u32 *notify_mask);
+u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation *dp,
+				 struct nfsd_file *nf);
 extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,

-- 
2.53.0


