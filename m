Return-Path: <linux-nfs+bounces-22731-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CBAKNy3YNmr9FQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22731-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2026 20:13:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE36A972F
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2026 20:13:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UCdI0yY/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22731-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22731-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2E613004F07
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2026 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E0330330;
	Sat, 20 Jun 2026 18:12:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF75175A80;
	Sat, 20 Jun 2026 18:12:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979179; cv=none; b=bbCDjWBB9lVKCqvuWUZzNPLoPlqmV5CeyZ1JesiioF+AsYRAWYA01qb0qRa2oxg5ScUzNUXEgZ8VoZeGDeLvdUzbIu42erd3KjjxO9X3nvxCAgPp5418xTRYLYQfX4Lb98bD6xbO+qFfR+HcRmcXZwGS0Dus9ffdX8PE+aVT6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979179; c=relaxed/simple;
	bh=AkPCgh/fHn9RWC8DBqZy5D9Mpbi2qfE48CSlpiFJuKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pNuBlFKkTd7F3GIvxV2HaOu0p+PyFa/QwTHhYmDXycoKr9Y3FRoPSE/lynfK23IogDv07DNMumBd9h+/KY6/gjZHMBixMNH+kALTe2fADQ6iL4aLAqKfBTy7zzlXx+U8wZPCVmmn4i0a4/BngPteI+MNAldRUKJZLJCv2Ee9h60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCdI0yY/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146451F000E9;
	Sat, 20 Jun 2026 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781979177;
	bh=c8GmJuUOlPtcdTI/eN/NIq1baA/SbZ8+ASJpqEsqbRc=;
	h=From:Date:Subject:To:Cc;
	b=UCdI0yY/rHzxxnIVcZ/edkeQYDNaSGC5aNCHxPTZsCqhCZA3M8sLymWGF5ZIDWVWe
	 gzQZc1C358HaWseRMTCfSqyJNDOt1hZzZfih29C0GP0bHvxAdkef1vC1XE9M/yaz+G
	 gpNAZ9Sf8jdQHAeI+t6pXeuZonztBapBuAj9nWkxiioOTejrOL9/jpuDyP1zfW+BN0
	 AOOTDPPuL250oNhPQNGkpGuE6wc60xbiMbPO2hcroTtXqni8TQm1Cx3Hx1Q6EVSszh
	 7OaubUTg4/Y6DAOt4nRe4T0HVxLhrK/0cL2j0Ibqmnid9XIA81Ivcpb8Uisrox2IMh
	 R0SFJLfMQE2ow==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 20 Jun 2026 14:12:44 -0400
Subject: [PATCH v3] nfsd: recall deleg if a requested dir attr change can't
 be encoded
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-dir-deleg-fixes-v3-1-4ff9a315c793@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4X07Jp2gQKe/A/jAdoFGgk1W9NoC
 P9u4aQxHt9M5s0iArGjIE7ZIpiiC87PCfJDJszYzgOBs4kFStRSqwqsY7A00QC9e1IAMq2pC9m
 UXV2ItLoz7UUaXa6JRxcenl/7QVRb+t8VFUjIsavLLtfaYHO+Ec80HT0PYpNF/BQ0vwIEBa1F7
 AlNZSv7JVjX9Q2lnZOd8AAAAA==
X-Change-ID: 20260617-dir-deleg-fixes-ecac84095b84
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8586; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AkPCgh/fHn9RWC8DBqZy5D9Mpbi2qfE48CSlpiFJuKQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNtgkCbDvx2WYKamsVHMRTxzjlzqRX8e9tAxqX
 3AXhb0T/oyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajbYJAAKCRAADmhBGVaC
 FZp6D/9qwQzFZsRRltGpnRk1KXytALpoFmN2Uby7yjQBYXKXE62MgaKpk7uOaLPzV4OCi7LcF+N
 Xe2ecrF/mjtvLBti/zIdHXpZBtOlS0cU5UNbD3wmLZkq6DtZYJcBUmvW6UcdZkNe26Kuaf2EXC3
 1fxEkDAGmWQ672/R7v8zUqD6zf6I8fDD7xP79hWSi3UXN/hb8H26vQI9mxnGCX4MqWt71KfYEm6
 NSfpyL94TdsVzErVsQDoiAIr+lgu+sv+xZyj0xobahbl4ZHkUp/Jso8CON7oPhk//u2vSouIcKR
 /3Pgjolf4saNlGKbmma1T0Os0C2NgXPoPyZ1DcZxwsh5pLcdKLAzqPoGbOJN4Ry8RBFovRsA5zc
 5xnMtkoMyS3PCxg9njC8+NPnGhZfAuYfRp/JlBsefp74DDND2DooUpj8Q4yRCEBkvUqpVx8wLMH
 rWK0g3bLQv4xdocr6Q0DSjzjcGebVVU9L1nKf/z7sBp9qfuhovKqXaVI2bKg/wa6bewREwi7ppY
 cHAMv3QZNJ6cizqPjiHFdyLFRc5tiSGb3LKgWL/uv5TAckemBYZ6PV7g0L4vPfB7uMHSzl5uTky
 mrERXVC9uo/irJiK8g/wF4nnvpBJMUyGScBT1mSo6He2LmbcmNfhf+Xu+8/UdixZTx/7jDRPhEo
 imv/Z3WMFk33XEg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22731-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EFE36A972F

When the client requested NOTIFY4_CHANGE_DIR_ATTRS,
nfsd4_cb_notify_prepare() tried to append the dir attribute change to
the CB_NOTIFY, but silently dropped it if the attrmask space
reservation failed or nfsd4_encode_dir_attr_change() failed to marshal
the change into the buffer. It then returned true and transmitted a
CB_NOTIFY lacking the requested notification, leaving the client's
cached directory attributes stale with no indication.

RFC 8881 s10.9.4 requires the server to recall the delegation when the
directory changes in a way that is not covered by the notification.
Treat a failure to encode the dir attribute change like the per-event
encode failures already handled in the loop above: set error and fall
through to out_recall.

The granted notification mask and the requested dir attribute mask come
from independent fields of the GET_DIR_DELEGATION request, so a client
can be granted NOTIFY4_CHANGE_DIR_ATTRS while requesting no specific dir
attributes. nfsd4_encode_dir_attr_change() now distinguishes a genuine
encode failure (which forces the recall) from that benign case (which
simply omits the event).

For that distinction to hold, nfsd4_setup_notify_entry4() must not mask
genuine failures as an empty attribute set. It previously routed three
different conditions through its noattrs label and returned true with a
zero-length attribute set:

  - a NULL or negative dentry (no attributes to report),
  - a vfs_getattr() failure, and
  - an nfsd4_encode_attr_vals() failure (XDR buffer exhaustion).

Only the first is benign; the latter two are genuine failures that were
indistinguishable from the "no attributes requested" case, so a
requested change could still be silently dropped (the per-event entries
encoded by nfsd4_encode_notify_event() were affected the same way).
Return false on a vfs_getattr() or nfsd4_encode_attr_vals() failure so
the error propagates to the caller and the delegation is recalled, and
reserve the noattrs path for the NULL or negative dentry case.

While we're in there, also remove an unneeded check for
NOTIFY4_CHANGE_DIR_ATTRS from nfsd4_encode_dir_attr_change().

Fixes: 757a16cd93d5 ("nfsd: add support to CB_NOTIFY for dir attribute changes")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This version should address Chuck's comments about the NULL pointer
handling.
---
Changes in v3:
- Recall delegations on vfs_getattr() failure instead of sending empty attr set
- Link to v2: https://lore.kernel.org/r/20260619-dir-deleg-fixes-v2-1-ad22fe2c7d7d@kernel.org

Changes in v2:
- Allow nfsd4_encode_dir_attr_change() to return ERR_PTR when there are errors
- Drop unneeded NOTIFY4_CHANGE_DIR_ATTRS check
- Link to v1: https://lore.kernel.org/r/20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org
---
 fs/nfsd/nfs4state.c | 43 ++++++++++++++++++++++++--------------
 fs/nfsd/nfs4xdr.c   | 60 ++++++++++++++++++++++++++++++-----------------------
 2 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b830aed7ae39..4ae5d65c056a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3598,23 +3598,36 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 put_event:
 		nfsd_notify_event_put(nne);
 	}
-	if (!error) {
-		if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)) {
-			u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+	if (!error && (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS))) {
+		u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+		u8 *p;
 
-			if (maskp) {
-				u8 *p = nfsd4_encode_dir_attr_change(&stream, dp, nf);
-
-				if (p) {
-					*maskp = BIT(NOTIFY4_CHANGE_DIR_ATTRS);
-					ncn->ncn_nf[count].notify_mask.count = 1;
-					ncn->ncn_nf[count].notify_mask.element = maskp;
-					ncn->ncn_nf[count].notify_vals.data = p;
-					ncn->ncn_nf[count].notify_vals.len = (u8 *)stream.p - p;
-					++count;
-				}
-			}
+		if (maskp)
+			p = nfsd4_encode_dir_attr_change(&stream, dp, nf);
+		else
+			p = ERR_PTR(-ENOBUFS);
+
+		if (IS_ERR(p)) {
+			/*
+			 * The client asked to be told about dir attr changes
+			 * but the change could not be encoded. RFC 8881
+			 * s10.9.4 requires the server to recall the delegation
+			 * rather than drop a requested notification, so fall
+			 * through to recall. A NULL return instead means there
+			 * were no attributes to report, so omit the event in
+			 * that case.
+			 */
+			error = true;
+		} else if (p) {
+			*maskp = BIT(NOTIFY4_CHANGE_DIR_ATTRS);
+			ncn->ncn_nf[count].notify_mask.count = 1;
+			ncn->ncn_nf[count].notify_mask.element = maskp;
+			ncn->ncn_nf[count].notify_vals.data = p;
+			ncn->ncn_nf[count].notify_vals.len = (u8 *)stream.p - p;
+			++count;
 		}
+	}
+	if (!error) {
 		ncn->ncn_nf_cnt = count;
 		nfsd_file_put(nf);
 		return true;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5282e00805af..b37290b723f5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4291,9 +4291,21 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	parent = (dentry == path.dentry);
 	path.dentry = dentry;
 
-	/* FIXME: d_find_alias for inode ? */
-	if (!path.dentry || !d_inode(path.dentry))
-		goto noattrs;
+	/*
+	 * A NULL or negative dentry has no attributes to report. This is
+	 * expected, e.g. for the old entry of a rename or for an entry that
+	 * has already been removed, so encode an empty attribute set rather
+	 * than failing.
+	 */
+	if (!path.dentry || !d_inode(path.dentry)) {
+		attrmask[0] = 0;
+		attrmask[1] = 0;
+		attrmask[2] = 0;
+		ne->ne_attrs.attr_vals.data = NULL;
+		ne->ne_attrs.attr_vals.len = 0;
+		ne->ne_attrs.attrmask.count = 1;
+		return true;
+	}
 
 	/*
 	 * It is possible that the client was granted a delegation when a file
@@ -4302,7 +4314,7 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	 */
 	ret = vfs_getattr(&path, &args.stat, CB_NOTIFY_STATX_REQUEST_MASK, AT_STATX_SYNC_AS_STAT);
 	if (ret)
-		goto noattrs;
+		return false;
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
@@ -4326,18 +4338,10 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	status = nfsd4_encode_attr_vals(xdr, attrmask, &args);
 	if (status != nfs_ok)
-		goto noattrs;
+		return false;
 
 	ne->ne_attrs.attr_vals.len = (u8 *)xdr->p - ne->ne_attrs.attr_vals.data;
 	return true;
-noattrs:
-	attrmask[0] = 0;
-	attrmask[1] = 0;
-	attrmask[2] = 0;
-	ne->ne_attrs.attr_vals.data = NULL;
-	ne->ne_attrs.attr_vals.len = 0;
-	ne->ne_attrs.attrmask.count = 1;
-	return true;
 }
 
 /**
@@ -4439,28 +4443,32 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
  * @nf: nfsd_file opened on the directory
  *
  * Encode a dir attr change event.
+ *
+ * Return: a pointer to the start of the encoded event on success; NULL
+ * if there were no requested attributes to report, in which case the
+ * caller should omit the event; or an ERR_PTR if the event was requested
+ * but could not be marshalled into @xdr, in which case the caller should
+ * recall the delegation.
  */
 u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation *dp,
 				 struct nfsd_file *nf)
 {
 	struct dentry *dentry = nf->nf_file->f_path.dentry;
 	struct notify_attr4 na = { };
-	bool ret;
-	u8 *p = NULL;
-
-	if (!(dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)))
-		return NULL;
+	u8 *p;
 
 	/* RFC 8881 s10.4.3: ne_file must be a zero-length string for dir attrs */
-	ret = nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
-					dentry, dp, nf, "", 0);
+	if (!nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
+				       dentry, dp, nf, "", 0))
+		return ERR_PTR(-ENOBUFS);
 
-	/* Don't bother with the event if we're not encoding attrs */
-	if (ret && na.na_changed_entry.ne_attrs.attr_vals.len) {
-		p = (u8 *)xdr->p;
-		if (!xdrgen_encode_notify_attr4(xdr, &na))
-			p = NULL;
-	}
+	/* No requested attributes to report; omit the event */
+	if (!na.na_changed_entry.ne_attrs.attr_vals.len)
+		return NULL;
+
+	p = (u8 *)xdr->p;
+	if (!xdrgen_encode_notify_attr4(xdr, &na))
+		return ERR_PTR(-ENOBUFS);
 	return p;
 }
 

---
base-commit: 6f90c7618528b5ca5887f8c6057f26dcc7a27a99
change-id: 20260617-dir-deleg-fixes-ecac84095b84

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


