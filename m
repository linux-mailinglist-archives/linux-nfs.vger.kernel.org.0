Return-Path: <linux-nfs+bounces-22493-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MU0fD2j2Kmpp0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22493-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:54:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7167432D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J9OHsFEj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22493-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22493-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A37B305D23E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083124DD6EF;
	Thu, 11 Jun 2026 17:51:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4D4DC54E;
	Thu, 11 Jun 2026 17:51:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200271; cv=none; b=gP8Z2AOm3ck6CMcsWgNaf8C6Mwf2R7bwdXWA3Y4Aa3+7lLnHQ03wOiwzRS/XHdbkd+5/19pMQpV693L7aGdgQf9imeg60ocf/KIXu8IsmaOBSR1OYSda3SaqAjeMUehUqRVX6Dj5KS4Wawvb3idvZ0I8E0wUALeF1BxQawA28oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200271; c=relaxed/simple;
	bh=emL5fNfICAJlgEqAE5bmz/85UIAGj+PBG4gXo7Pb4Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ad3KobUAQ+HI7MsfhxldeuNQY/Hsd9+1/bWO9i/sDGXwNL9MtIQR98hzmgojqoWlsU2L4smX/4Pwt1qMLQ27jLPqsrgOf6sTORYhUQ8hmzhRX6BR8+K+EHHUKH8Sqlt4SO5rqzfICqdq6U3Fw9cNDM0LfXfWKSJqVTdJaLlEyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9OHsFEj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C41F00898;
	Thu, 11 Jun 2026 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200270;
	bh=JMxPicfLnHJXDlOPHPdm8WveFf4HMrxmBXlH9ncp8MU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J9OHsFEjDn/gCJFj01MeIEhSxS5B5gFSXq3Zty7jjs1TlwxPyAf/loXTT0LcCTBOj
	 xlp7845Bbe3YQHGoS7Y2Fu5B9fyiq2qlzHlBk1LUE16rf/nEOr14gOnzG8Yv22A2nl
	 IaPinJRCnmJfuDWtxWKjfY6eA3Hab9gTx5QTaUPwDfH78ZpqxsezCjPCXntDN/mW1a
	 hGDOMNskrQjgwCNSsFWHh6bR6jkRfjSfBoAwAt9PtNuRXKt0CQnu43oqY0XG9UQ8Cr
	 53OgzhAJSy2Mq5hTKQASQwLa6L/H6+WMGSzh8eUNY9hzwZU6lShT2VMpEr2uZxcsWR
	 ffDjogM1FJElw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:26 -0400
Subject: [PATCH v6 20/20] nfsd: add support to CB_NOTIFY for dir attribute
 changes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-20-4c45080e5f3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7638; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=emL5fNfICAJlgEqAE5bmz/85UIAGj+PBG4gXo7Pb4Sk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVlr2Wdi1g87CWBPN5/thsL4z7Y563JLfIez
 mUORE9D3MCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1ZQAKCRAADmhBGVaC
 FTcJEACD8OUU9Hs6Dc2tDOeOiSofHrJKi68BhrxohMHDZkJDNJUMye8/fZtqH2g2G/LFzCXxwfS
 oyF071K7pprczky59mdkV5+IxadPLsMKu99pI+vZIRx8IokgjWnztQ14DCZmL0L1RQEqJOCy8cC
 VdgdPXXNDn4zlm1Ju7x35j13oaiCUuqi+TZ3Bk1UOwnccCd6P2gzLpQQGf6x7yfN9763GPgnCH8
 IT9mxh3sP4VXz5gLEv4puYFcr5kzZ8RPehpQXuK8ZLMAgX6TXf5cbMWnZGRztjLXaqyiO+B7nxO
 eckHtFa91C34Chm24fO0NfbfZJEQHOh1/tyQEwaa/3YrY3neAqORphbn2IfTJN8plziQXu6NhN4
 twLZh/fqWMLJA5ToN6QojcWpjLmxYExB7A4+bprzZEa+Z9dMx4rQSZdWSadJMxR5ZUsRplnHl/f
 jETNgOGhDxsvM434Z0w0cnN3b1adIESCsNVTqKU0JrCCwC8M7w76CRnOFE/H1k6P4DfegS9yium
 r5xs8CPjmIV+ndsrTSy2ivLSGHxgaOY7O5sLt/lXnC45Ob6NDpuVgIluLP88FubkFZ3Pzc5bhzo
 kx3U8pa2YSgvOFP8VpbwcKwGE8DZKiG7daSgLExscrN/a6YPMTv8XEqdEGHjeBEKM+R2N0ofsUU
 0SqTQb0C4tdczmA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22493-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDE7167432D

If the client requested dir attribute change notifications, send those
alongside any set of add/remove/rename events. Note that the server will
still recall the delegation on a SETATTR, so these are only sent for
changes to child dirents.

The child filehandle returned in these notifications is composed by
setup_notify_fhandle() without going through fh_compose(), so it does
not get a MAC appended. On exports configured with NFSEXP_SIGN_FH the
client would then get back an unsigned filehandle that fh_verify()
rejects as stale. Pass the delegation's export down to
setup_notify_fhandle() and append the MAC with fh_append_mac() when the
export requires signed filehandles; if signing fails, drop the
filehandle attribute rather than handing out an unusable one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++--
 fs/nfsd/nfs4xdr.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/xdr4.h      |  2 ++
 3 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 12627afb604f..e394278fb92e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3503,10 +3503,15 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
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
 
@@ -3520,7 +3525,7 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	}
 
 	/* we can't keep up! */
-	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
+	if (count > limit) {
 		spin_unlock(&ncn->ncn_lock);
 		goto out_recall;
 	}
@@ -3567,6 +3572,22 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
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
index 1e3c360c06cd..7dd8476028d6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4199,7 +4199,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 static bool
 setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
-		     struct nfsd_file *nf, struct nfsd4_fattr_args *args)
+		     struct nfsd_file *nf, struct svc_export *exp,
+		     struct nfsd4_fattr_args *args)
 {
 	int fileid_type, fsid_len, maxsize, flags = 0;
 	struct knfsd_fh *fhp = &args->fhandle;
@@ -4227,6 +4228,17 @@ setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
 
 	fhp->fh_fileid_type = fileid_type;
 	fhp->fh_size += maxsize * 4;
+
+	/*
+	 * fh_compose() appends a MAC to filehandles on signed exports; this
+	 * hand-rolled filehandle must do the same or the client will get back
+	 * an unsigned filehandle that fh_verify() later rejects as stale.
+	 * If we can't sign it, don't hand it out at all.
+	 */
+	if (exp && (exp->ex_flags & NFSEXP_SIGN_FH))
+		if (!fh_append_mac(fhp, NFS4_FHSIZE, exp->cd->net))
+			return false;
+
 	return true;
 }
 
@@ -4240,11 +4252,11 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
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
@@ -4256,6 +4268,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	parent = (dentry == path.dentry);
+	path.dentry = dentry;
+
 	/* FIXME: d_find_alias for inode ? */
 	if (!path.dentry || !d_inode(path.dentry))
 		goto noattrs;
@@ -4271,15 +4286,21 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
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
+		if (!setup_notify_fhandle(dentry, fi, nf,
+					  dp->dl_stid.sc_export, &args))
+			attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (!(args.stat.result_mask & STATX_BTIME))
-		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+		if (!(args.stat.result_mask & STATX_BTIME))
+			attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	}
+	attrmask[2] = 0;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
@@ -4392,6 +4413,38 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
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


