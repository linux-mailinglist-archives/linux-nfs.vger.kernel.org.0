Return-Path: <linux-nfs+bounces-21802-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM5OFCRQEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21802-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:46:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9FB5B4600
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 548113103244
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D63B1013;
	Fri, 22 May 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lftIQpqQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EE396B9A;
	Fri, 22 May 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452987; cv=none; b=NjyxdpyXGYV+lBIq3tsrFIFwEV+gYwhncgJtsUCS8DwAi71A9K54FdT3kqu0rcKqg7mSeoSYeQ/IR0z6vIGwM8vqXkMgNSx8FICqiRHAPDhloONLmX3fnS9hDvcaH1cVdZbCF7AU1HYKWUrSU3sNiCSPQriTjQ1PJUOTDnXzNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452987; c=relaxed/simple;
	bh=n094Y6iJ3spWbyVj9NXLGKhtNg67cBauAd1DvKPlUTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxMu6lQt6koQ+8Ut9KeVq2mYlKTh+1TLgrpskq6TalcEMOl4Qi0FcHdfmMG+d06t+SI+Wm11igRsOAoBI/4FFv+/XmroxJENiPhUT5ryCVs7LIQSC0rJcBl7TtuXTsqydi/qCCBgRRPgoYtgEGDVzZd0VohalLootlrSINBdKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lftIQpqQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CAA1F000E9;
	Fri, 22 May 2026 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452985;
	bh=bWyWQkGX486MPJv66TllLqijhqa59fSqHuKYh3opB4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lftIQpqQtVuYUtUe2lX7etHBqXQ3dNhGxA2ymRYJOYZMWiYpS/8uszccJVVW+RkVW
	 5sGnqzNdQF3nUF/rZBIS0GMfCWvzm5fq0ViGclhXZrvYENllYjqURzNvcYdqZPRgfI
	 TsiYV+qJa+1ROnBKm+m0uAR158HAeZiq3MuZUeZm9ol3kDh70ddR/u7fNwvIeeORBX
	 0ASQNdDRpYsFdzjAyAq+uByOCVTLduwcsb1H/w2SVwTTy28/upjQciBFN1FAjIEzEX
	 aq9uK15Rwo8b6MDvMz9BrV1x57qYcMSXFq5JWmxexMF9cEfpaUy5jsC6fYen+X2Amz
	 X+TzUWh5KZe3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:10 -0400
Subject: [PATCH v4 21/21] nfsd: add support to CB_NOTIFY for dir attribute
 changes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-21-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6108; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n094Y6iJ3spWbyVj9NXLGKhtNg67cBauAd1DvKPlUTY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwTaTKb0Q8gBI05oUpUIRLP3Up50YMyqYWJq
 aoetENq7KyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEwAKCRAADmhBGVaC
 FRerD/4sXAbqO20EYs5tLpzmsVsSlqkOL6oM7+qPEDdOXLP8HM1yMuBfjo2Lej6nnaCkxGrkgmY
 a79V7WxOJ9M6ONzIXhDffgQd7qi7QX9PJSYeTPYOfUv7IhSKxY/3m7lpjCFIt235gk7E8SwT/v5
 PGSkRQiPnxfiCOu3tXloGqkryzR/jLqZLGTKIo5tBUoXeZUOZu8/41tb20HTNeO/n97z1aHVFtx
 4jSZ9mLyVX9rjgKMIGG/asPbLtqL81VNRgCCBwwSxr1XvOBfL1fGe4pA/pyLEIWJVSq4GYj6tCP
 f5sX4d6doQwPB/AEpi30VUg5p1S4GKHhoZn4VvWpnhMqHjIRD09HyUXuOJzjOJib9TARNh0zkTZ
 nbGBL1o+rtmBbiqjHm0aaSbKyTTgRa9I6jmgXMajPgvrKSgWhmv7mhScjTrrT4+/i8nj3B4S39Q
 IShyN7V3DxtlsP+SSM/6HXRL3vPNo/8BIISXzEaN+nnnKbCTk/CLbAr9d78bIg8z3EgBGJxHgqH
 8rOX6OawNHJZlupkGVixSWrJ9694cmtU4ssCpBt6g71G/C6C7BAeYczcFKLMZc6wSe0ri6mnHhB
 4QH8vhH/HIfDok+SkqBpt+xnG4zxEdHxbWSjjwEOO5BOwSCFeoMGHCZaapPTwc/EexD6QoxqF6z
 nO+wAEh6NldwVsw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21802-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF9FB5B4600
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
index 4a078b51506b..34728aa3161e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3487,10 +3487,15 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
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
 
@@ -3504,7 +3509,7 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	}
 
 	/* we can't keep up! */
-	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
+	if (count > limit) {
 		spin_unlock(&ncn->ncn_lock);
 		goto out_recall;
 	}
@@ -3551,6 +3556,22 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
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
index 4fe697bf34e7..2143fb6d5e3f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4227,11 +4227,11 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
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
@@ -4243,6 +4243,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	parent = (dentry == path.dentry);
+	path.dentry = dentry;
+
 	/* FIXME: d_find_alias for inode ? */
 	if (!path.dentry || !d_inode(path.dentry))
 		goto noattrs;
@@ -4258,15 +4261,20 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
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
@@ -4383,6 +4391,41 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
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


