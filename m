Return-Path: <linux-nfs+bounces-22622-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CFL4M/M9MWr3ewUAu9opvQ
	(envelope-from <linux-nfs+bounces-22622-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:13:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757168F2E9
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:13:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZM+5eVzs;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22622-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22622-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B14C03039F62
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B04779A9;
	Tue, 16 Jun 2026 11:59:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C5477993;
	Tue, 16 Jun 2026 11:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611186; cv=none; b=eKWz1neupUd0PWCY4dBYfuedoqzBfeofbuT6SLRy1UedLwheYVunypQL2XLcGJzfNvPwjdtZ3p+QXbvFIWhIvkrAsJ/sCrSNgcKngwih/SH0UMQbu39bybiVhHFE9KOjJgjHitlJXph98T6B955sH7QbXvCytnTKXV61dhLbYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611186; c=relaxed/simple;
	bh=gH+uDT87A/C27AIhVHK5wxfGC6rtEaL1A5rAzBUcmGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYfckgDgMJGhFygrn1n+KL8GrvXBnzk/Cz/dIFUn4yqsGn3VvC4OJAVP/lLiZOIPcrFizexQERLEjq3GfmounR/8dy4o+mdo2XeeS1OnI+zQKken3djIzNfSLKSXoTWoyeRxWY2CI01zQDrtNvieULE7P3MfmIyfw9k9YxndtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM+5eVzs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEF81F00A3A;
	Tue, 16 Jun 2026 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611184;
	bh=k7ihv2PVJm8Txb0R8FICWVxvyXBx92a26UjRp6NT9ys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZM+5eVzshb5WcRhOR24zzzrAcr5tikU3022aR3TMQw9XoPKKV0YA5O0VlradS4Mmg
	 7GbWr4CJI5HIgyFw4LQAlxw9peK95NWfGcZts32qbp729HUmO8zPZKtozx1/dmE4az
	 eoPLjd+7q53JH5BLY8b0DoUxauvkhXoYZckoU1iSrIoaXKNUCsf1AHXxxlagcuvkks
	 qhGRoeE3K6lir7jAFyJwXQrdSU7IFylb818nJmcG64OIEt9D2H2hncy201v8suM2WQ
	 qAe/VxwLH/fq1eS5ZhLL1K3p+foc7Q+cABxw79A6rf3f8PPXrfGv1cRR11DonzobNQ
	 p01GKTaovyIaQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:59:03 -0400
Subject: [PATCH v7 20/20] nfsd: add support to CB_NOTIFY for dir attribute
 changes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-20-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8995; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gH+uDT87A/C27AIhVHK5wxfGC6rtEaL1A5rAzBUcmGg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqIztEIw47JLebOaM8hiiC/JcAX+8QPnFGZL
 IdgGSJNFu+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6iAAKCRAADmhBGVaC
 FZ+xEACu8b2kujCSSH6wD9EXPew9lYjcKOXGrUFUmhewWzS5HvHNySC7u9nWAMWs4qF8Oy1mCfg
 2DgP3jEmNGtBGBs+0p1qVAEkp7rpnl3g9Ivs30bDyV488VZxB7HY5ca2+f1O6YEVpXDlpWhb871
 8GOlaq02ZOw4l9E3WO9NOWzlSTts62mgllob/z06lWeo7U3nQc3k1qwgFN6Jx7GnJvWENy0/Vq9
 iobTKYPwzADWWkW4q+/bNslDMRcreD1+DQYFgGgSamyl89u01H9ZTnTVElIxCJqMINgYmIrUTWa
 ytVS8hZxVxpM6lo3UMWAaa/QrtWZV/qUVrAAa3al7f327yngrlQQXKXcdmwGOBrCj4+eqd1XaKR
 ttLsA6zWjTX2bvOwH90IBiAOvatjnXh5Dta1D2mepfi106qoAOsZ/10VJKG53mzA8LELBMnpVCW
 DNK3C9Nfexngu/DN+oNmfI3hiozGipFPPxAxUYnV2S1VagfiatrAtNDfQ5q773/jS6lsIhRVOFh
 ddqNAiHrCymP4Nv44qDnw45dASggSRx9uvOuPxW6zy8vKqt3hxTLPaI08+DlR7+4k1JM220AHPZ
 iyIbW6bNuLKx3Ff3U1N/2eXctJjcgT2zLzHY9rS+awk6gXzxeNgDdAWWWPAxYvxL8uvFrmTYvhR
 pvVyesbuTmSbx0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22622-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4757168F2E9

If the client requested dir attribute change notifications, send those
alongside any set of add/remove/rename events. Note that the server will
still recall the delegation on a SETATTR, so these are only sent for
changes to child dirents.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x |  1 +
 fs/nfsd/nfs4proc.c                |  7 +++--
 fs/nfsd/nfs4state.c               | 25 +++++++++++++++--
 fs/nfsd/nfs4xdr.c                 | 58 +++++++++++++++++++++++++++++++++------
 fs/nfsd/nfs4xdr_gen.c             |  4 +--
 fs/nfsd/nfs4xdr_gen.h             |  3 ++
 fs/nfsd/xdr4.h                    |  2 ++
 7 files changed, 84 insertions(+), 16 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index a32df1e882e5..e66f396ae659 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -464,6 +464,7 @@ pragma public notify_add4;
 struct notify_attr4 {
         notify_entry4   na_changed_entry;
 };
+pragma public notify_attr4;
 
 struct notify_rename4 {
         notify_remove4  nrn_old_entry;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 48fc7b0df4dc..c413ed0810b9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2552,9 +2552,10 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
-#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
-				 BIT(NOTIFY4_ADD_ENTRY) |	\
-				 BIT(NOTIFY4_RENAME_ENTRY) |	\
+#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_CHANGE_DIR_ATTRS) |	\
+				 BIT(NOTIFY4_REMOVE_ENTRY) |		\
+				 BIT(NOTIFY4_ADD_ENTRY) |		\
+				 BIT(NOTIFY4_RENAME_ENTRY) |		\
 				 BIT(NOTIFY4_GFLAG_EXTEND))
 
 static __be32
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a948dc8a46cc..2f7210accdf1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3522,10 +3522,15 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
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
 
 	/* Clear any failure recorded by a previous transmit. */
 	ncn->ncn_encode_err = false;
@@ -3542,7 +3547,7 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	}
 
 	/* we can't keep up! */
-	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
+	if (count > limit) {
 		spin_unlock(&ncn->ncn_lock);
 		goto out_recall;
 	}
@@ -3589,6 +3594,22 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
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
index 0649bb4cf2e7..a18d0b766b50 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4253,11 +4253,11 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
-	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
-			      .dentry = dentry };
+	struct path path = nf->nf_file->f_path;
 	struct nfsd4_fattr_args args = { };
 	uint32_t *attrmask;
 	__be32 status;
+	bool parent;
 	int ret;
 
 	/* Reserve space for attrmask */
@@ -4269,6 +4269,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	parent = (dentry == path.dentry);
+	path.dentry = dentry;
+
 	/* FIXME: d_find_alias for inode ? */
 	if (!path.dentry || !d_inode(path.dentry))
 		goto noattrs;
@@ -4284,15 +4287,20 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
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
 
-	if (!setup_notify_fhandle(dentry, dp, nf, &args))
-		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
+		if (!setup_notify_fhandle(dentry, dp, nf, &args))
+			attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (!(args.stat.result_mask & STATX_BTIME))
-		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+		if (!(args.stat.result_mask & STATX_BTIME))
+			attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	}
+	attrmask[2] = 0;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
@@ -4405,6 +4413,38 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
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
+	bool ret;
+	u8 *p = NULL;
+
+	if (!(dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)))
+		return NULL;
+
+	/* RFC 8881 s10.4.3: ne_file must be a zero-length string for dir attrs */
+	ret = nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
+					dentry, dp, nf, "", 0);
+
+	/* Don't bother with the event if we're not encoding attrs */
+	if (ret && na.na_changed_entry.ne_attrs.attr_vals.len) {
+		p = (u8 *)xdr->p;
+		if (!xdrgen_encode_notify_attr4(xdr, &na))
+			p = NULL;
+	}
+	return p;
+}
+
 static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
 				struct xdr_buf *buf, __be32 *p, int bytes)
 {
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index d1240ade120d..a6725c773768 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -669,7 +669,7 @@ xdrgen_decode_notify_add4(struct xdr_stream *xdr, struct notify_add4 *ptr)
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_decode_notify_attr4(struct xdr_stream *xdr, struct notify_attr4 *ptr)
 {
 	if (!xdrgen_decode_notify_entry4(xdr, &ptr->na_changed_entry))
@@ -1091,7 +1091,7 @@ xdrgen_encode_notify_add4(struct xdr_stream *xdr, const struct notify_add4 *valu
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_encode_notify_attr4(struct xdr_stream *xdr, const struct notify_attr4 *value)
 {
 	if (!xdrgen_encode_notify_entry4(xdr, &value->na_changed_entry))
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index c62299bac735..f6a458a07406 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -38,6 +38,9 @@ bool xdrgen_encode_notify_remove4(struct xdr_stream *xdr, const struct notify_re
 bool xdrgen_decode_notify_add4(struct xdr_stream *xdr, struct notify_add4 *ptr);
 bool xdrgen_encode_notify_add4(struct xdr_stream *xdr, const struct notify_add4 *value);
 
+bool xdrgen_decode_notify_attr4(struct xdr_stream *xdr, struct notify_attr4 *ptr);
+bool xdrgen_encode_notify_attr4(struct xdr_stream *xdr, const struct notify_attr4 *value);
+
 bool xdrgen_decode_notify_rename4(struct xdr_stream *xdr, struct notify_rename4 *ptr);
 bool xdrgen_encode_notify_rename4(struct xdr_stream *xdr, const struct notify_rename4 *value);
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 62ac790428be..805c7122eb93 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -973,6 +973,8 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *nne,
 			      struct nfs4_delegation *dd, struct nfsd_file *nf,
 			      u32 *notify_mask);
+u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation *dp,
+				 struct nfsd_file *nf);
 extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,

-- 
2.54.0


