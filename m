Return-Path: <linux-nfs+bounces-22664-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IbIZIPnjMmoL6wUAu9opvQ
	(envelope-from <linux-nfs+bounces-22664-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:14:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F069BE67
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aJ0wAvJX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22664-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22664-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67A5307A04A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE0379C34;
	Wed, 17 Jun 2026 18:12:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F6378818;
	Wed, 17 Jun 2026 18:12:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719977; cv=none; b=i0YacOiI/qrslIXYsOkDKPtvWBlwZXFc7uySKYKJkBqQYQqkrHTRb6wTm+qontRy8U757Ho7wUGQk9e+O8cOA3CGGGCr+kVgW8lxwJRaCrWuuE0zcgH2X13nFGVxtmrejvdGGp5l78sdPorlmP3IMRZGZQPL5qd/K05MFlzAsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719977; c=relaxed/simple;
	bh=arp1FB6FgXOEvI1hiYgKEw7OWhj6rlSAFqz4AoMzZ9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgn0VVtFlfDtReTsNLOjlymCTwNyeVetBeEmdyu/c0x4owGUygnmnMk5ahCaxYFpri5pbOjyWlzXV+wXvXtHTPcF6rF0FYPtdn1WM2RryeGlR7WNhIx4TTZDZAI5AswEYqWrcfLq0dESv5XOE9OuyVnWcbhGOx7QPxjksmcHtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ0wAvJX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F731F000E9;
	Wed, 17 Jun 2026 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781719976;
	bh=nKskAijqLhdZso8jT7lZnHIqj7eXX7Vmt4zu4FlkoLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aJ0wAvJXbCtFv4TG77qJDl6YWuA+aagJ5oNLU9lMyowp9UmwlU8Sg+HS+oXEX3oXT
	 j4AzkCMmNrq7IQ2iv9n08PZYqK72BpHPrZEEmsVJ9pmDydxh91YMrqZownIwJcOC00
	 4b1hV4ZLPAhf0hWI2r3lx8L80hgWedVP5sJMi/AYMHAYl10vX5OrclsFDvJ+8bDpYd
	 9jgdv81qQNwBRntC+Y/AnxT/ia28yidYqgRqV0NqDEqRGfUyRCkKJ4u5lWSSqxX95I
	 93MzJvDTlr2OXY/S1SVvTVUCPcYVqn5zeyKPuwR9YobSFOCoaYA0e/TR/nlyEy18dB
	 SwTnWAv3VvADw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 17 Jun 2026 14:12:31 -0400
Subject: [PATCH 3/3] nfsd: recall deleg if a requested dir attr change
 can't be encoded
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-dir-deleg-fixes-v1-3-32b85b366c29@kernel.org>
References: <20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org>
In-Reply-To: <20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=arp1FB6FgXOEvI1hiYgKEw7OWhj6rlSAFqz4AoMzZ9A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMuOkFA443KsUr4IdTWmxTmtMZsoOkb81rLvFW
 Rqauk3qpeOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajLjpAAKCRAADmhBGVaC
 Faa6EACJJ3vbN/FSJSiaKnpgto4yLUX7zJVhzP/m12gyp5Xze2XjqerMsNf17tRbg96gw1kN9py
 PMou6qTKn+HT2mVczgxYGW/DUtj37u8uYqvd5Wg1a+nU4xCDIaEO5AJiJv3fVji9KYd96vVcI9w
 hrhjLkGgJsUODZaaBPKK6HzROjgpM9aLgEvm8Lv/K3aYxNY+UcUEF59RM3/R9dQK4vdY4VptVt2
 8WOnr/MCqm1jsCKRxuNH7uG2gi3/W9Sg6PbgCM3MWfYJpkQFf9GfTLNkoSAp2okTDuHM2kn7URX
 KG1XFejUL91CHUg6810ukBlkl6ZPWbl2h2SHzHP7fwPj5z/NTlLxTmWafsEAm/lnK1U7ivEZnVg
 JeXJheXqWtpTVJw3xqpsMAjzDhEj8/BN1skugope6Kq5qVusfjHMFGWJXQnirUNHSXwE8SmjxVU
 u5qHkxHAp1TeU7kcqtAV8r+gyv0i9MEmMAkh46Zk532yRorfZ8TGhmj4pSJ+TSRBPhR42gD5gBY
 nws9pZR8IBFpQu5W9ProQ/ZEP/GOBQsUj6v5TU++fkvnpAbOrd98bViofhXZXfq8MhhuTUd+w9t
 V4qF5afUmPUud6mG/Nv053aPUxu75SbqPwWxKDSAflHFmUqvswxvSqCLsJr6Hb1GiVG4kAnaD6z
 sfKIZi9rtEdg3eg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22664-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B4F069BE67

When the client requested NOTIFY4_CHANGE_DIR_ATTRS,
nfsd4_cb_notify_prepare() tried to append the dir attribute change to the
CB_NOTIFY, but silently dropped it if the attrmask space reservation
failed or nfsd4_encode_dir_attr_change() returned NULL (out of buffer
space, encode error, or no attributes to send). It then returned true
and transmitted a CB_NOTIFY lacking the requested notification, leaving
the client's cached directory attributes stale with no indication.

RFC 8881 s10.4 requires the server to recall the delegation when it
cannot deliver a requested notification. Treat a failure to encode the
dir attribute change like the per-event encode failures already handled
in the loop above: set error and fall through to out_recall.

Fixes: fd0d6dde2a57 ("nfsd: add support to CB_NOTIFY for dir attribute changes")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b830aed7ae39..82125937dde2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3598,23 +3598,30 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 put_event:
 		nfsd_notify_event_put(nne);
 	}
-	if (!error) {
-		if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)) {
-			u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+	if (!error && (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS))) {
+		u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+		u8 *p = NULL;
 
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
+		if (!p) {
+			/*
+			 * The client asked to be told about dir attr changes
+			 * but we couldn't encode one. RFC 8881 s10.4 requires
+			 * recalling the delegation rather than dropping a
+			 * requested notification, so fall through to recall.
+			 */
+			error = true;
+		} else {
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

-- 
2.54.0


