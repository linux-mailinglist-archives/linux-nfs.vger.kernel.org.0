Return-Path: <linux-nfs+bounces-22729-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IgxwJpW1NWoI3gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22729-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 23:33:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7B6A7CE7
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 23:33:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=djW8SBWq;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22729-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22729-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D3213008D1B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A03624D3;
	Fri, 19 Jun 2026 21:33:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A83612FB;
	Fri, 19 Jun 2026 21:33:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781904784; cv=none; b=ditKwsh0K3T+7/2+U4CZcCNoq4EueE3dzKK2ANBiTJjB54a7HQgAJr1Zn+vrNcW0uC2SqJODGd0mm9iVJ3iFojDM2Mle+e/0QHZQbR27PYu568zq/Lbh34Q4dpQBbr0EhhVfhT6UpsYMgd3+cU5Bb0ncysP7f8Yr5nViJcXhbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781904784; c=relaxed/simple;
	bh=TZex6GcVXA/S3FWkQQmBagBvW1jsaOuEm/RCBnLTZ5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MjDFprs6O1EPT7Rd/J/1X3b/VKihq2R9lan9ikbhQfKk74Z101LjwU1S9y8jS0QVOG5Yy3nHeE6gogVO4aCseP7W3K9fkyHhmlzuAcZzi5xdTrMZ5ypc9VhFLZyJaSpEINxET39osVyKemHm+nN/yVPZD9LTcH3bnS3d7z3N4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djW8SBWq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA2D1F000E9;
	Fri, 19 Jun 2026 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781904782;
	bh=ZDDroLOVqdJigyLzWpni7DdeGOE9EKWrshO5jraCI7A=;
	h=From:Date:Subject:To:Cc;
	b=djW8SBWqdnkMYrd+Mgde7BtJovhCId2jYcu150unNCnllqngLYkHs18ZFCdHf+EE4
	 PPcbsWyeb+ONKXoZX8W4d0Y5YjkrDPr30vHd0WHNVzZivq8wlhuNPVBFGAHPY9O6fe
	 xJOaCtZLcPXuEhUdv6BIqF4pKZPkkDjDYbfG7GaIGHWchpbtLbpqCl6yLXqY8BJzb/
	 yFhywGVNz20iBeGD0t3SBiQHSnFBhco9AX/LxhZnPmRPn9EYUcd+SdDIBwhKa2qhAU
	 09ndaXEzVDvQhPG0K53rMp1B3614RUPR3J8UtnlurXcAn9FnvC+kGR0yF2T9r6YR6v
	 p4JtsQjWAqgrA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 17:32:44 -0400
Subject: [PATCH v2] nfsd: recall deleg if a requested dir attr change can't
 be encoded
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-fixes-v2-1-ad22fe2c7d7d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TVtgVo8+R+GA5QVNhJKtqbRE
 P7dyt3jm8mb2SCSMEW4FhsIJY4clgzmVICfumUk5CEzGGWssvqCAwsONNOID35TRPKdd5Vq6t5
 VkK1V6CiydG8zTxxfQT7HQdK/9P9W0qiwNL2r+9Jab5rbk2Sh+RxkhHbf9y9Kc2F1rwAAAA==
X-Change-ID: 20260617-dir-deleg-fixes-ecac84095b84
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5791; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TZex6GcVXA/S3FWkQQmBagBvW1jsaOuEm/RCBnLTZ5w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNbWG2ZTwR9TiF9xeqeghcD42PeF55qzRbwRV8
 rrEFgeoOumJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajW1hgAKCRAADmhBGVaC
 FTLSD/9jPyLTF8GJ0Qcbi6BvfcK/sW5qAJNFvf3kCx4B/6cqV6AYp+OJpfP81x6ZTlPhxZs9UAd
 mGaRXvp2Bi9nOjAjq2ltP7A850q3C12Enkf8yTxSyslhVVAaLewcTx0lpg5qiyF8iHQ9zU7kr99
 on5BGY/eEoMDsmblogMhPIarcSbrfqwZDj25RXqUFgKd1xahX6ND5m4UfzfoXysxvuqR5vFAgyi
 o+r20q02mVjCN0sRhFqMazocmTBVO7SQ0k5g1OyZchNg3hWMq2e7qNSi3jfLjauVW1/e4Caz+8Q
 FJIFJRyyI//p5Zz9k1gY7zGyy2M5019ObUqqRfF58n0Q0yP5dTVZ1rHoz8BND930OK+3yRMGp1S
 IKn4ndUwUGKL4zxmgrIB85I01vV4ex5X4ZnUk43KJZp/s2xguxIBDyl/OWIk0rnnq6taeU4lCS4
 4Ga0rozMqtn2tK+J8r7sOM5AGTam1lOsby3aungvZ+AOKdmri4lQ4pMtKjB4WH4sUKAiH8hFR24
 OrmRoCpYvrw0azDHCJ5t5eyl1slDsclPinRv/O291rK4rfWdNx9VEgcm2pMyFO7ad4zy2QbLns+
 sVCckhAPuY6QznwIQ9YgFH8wREcoKaR03wTe8c8vZ4RnRwfcbUY+2C4zBFMaNCifc/LAA35f6FJ
 bLIAzG3NoQhmr+Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22729-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78B7B6A7CE7

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

While we're in there, also remove an unneeded check for
NOTIFY4_CHANGE_DIR_ATTRS from nfsd4_encode_dir_attr_change().

Fixes: 757a16cd93d5 ("nfsd: add support to CB_NOTIFY for dir attribute changes")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This version should address Chuck's comments about the NULL pointer
handling.
---
Changes in v2:
- Allow nfsd4_encode_dir_attr_change() to return ERR_PTR when there are errors
- Drop unneeded NOTIFY4_CHANGE_DIR_ATTRS check
- Link to v1: https://lore.kernel.org/r/20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org
---
 fs/nfsd/nfs4state.c | 43 ++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   | 30 +++++++++++++++++-------------
 2 files changed, 45 insertions(+), 28 deletions(-)

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
index 5282e00805af..f46115a38af7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4439,28 +4439,32 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
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


