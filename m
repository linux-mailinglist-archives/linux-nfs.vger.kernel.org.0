Return-Path: <linux-nfs+bounces-22662-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vfbGF7vjMmrg6gUAu9opvQ
	(envelope-from <linux-nfs+bounces-22662-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:13:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD92969BE49
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:13:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Hd/usu26";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22662-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22662-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E864B304C13E
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3D378D9C;
	Wed, 17 Jun 2026 18:12:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D43783D8;
	Wed, 17 Jun 2026 18:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719976; cv=none; b=UtVGpr0MogcF46diiGI3YA0ObxeNtkv4HIe86IdfTPm2j+VqL/uUYpL9Y43EMZw0jY0h2iIPN3B6NzMB8B4r3hky2soB40E250X9I2XaF8OfR7ztbCN26P2DBvPLl+KGNkvcR81uuqqJr+/joZYSKRDOG24D5DeGkQinCs2XoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719976; c=relaxed/simple;
	bh=V9yrjaYjI7Gk2FtiMlH7cPKsrGRickK9hrG6NCOwuEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLg76FKbIddSewv9k6Qv6K+l/7Nwq5e5NpEL3bL7A9eikCcHtzZaiXZ2qHkhGvRm9xLyIFHGbNSOrwpIPGHM6wmhHqaFryCfe3LmqIED1759OxDGw5JlXRtCyw6PVvXLZlxU0x4DIpjNl2zD/g8ID0uffwuaaKTR0EbmO+Jdx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd/usu26; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973721F00A3A;
	Wed, 17 Jun 2026 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781719974;
	bh=svTOJ+U11358QwrtlmpTicT22umHi1xqPpyQ0qYHQFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Hd/usu266pkN+dG6yX3vHfZrb7iw7j7mgA37kWX1f6LSHX4UWlF/XsVpWpHGpTF5M
	 sSM8lQtr9QiWqGHUxVgLvjEeBogzf2OM3UTCLYjXDYR7oBmK17XzYdgShyUaBGAvxW
	 pXNd5IqQi1cJ8Mh8BKp0UVmi3/GfI6UAsaPkwEu1oSP31WWRYRx0Xl9SL6JsZLxI9T
	 I8HBVh1EZn2/FwXeKNt4PuHyLN6IpJ7lxchkX2CfhsndQNnq7ozu+JpIFl2wOnmgqk
	 2dApL24YuSlEpDnP+9pKYkQ+R5pxPnzyLQdmFEkD/Ttv+vJPwYJfMlDt/dmlcCBOzs
	 F15MhdTwjyawA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 17 Jun 2026 14:12:29 -0400
Subject: [PATCH 1/3] nfsd: fix CB_NOTIFY workqueue loop when queue
 overflows
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-dir-deleg-fixes-v1-1-32b85b366c29@kernel.org>
References: <20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org>
In-Reply-To: <20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V9yrjaYjI7Gk2FtiMlH7cPKsrGRickK9hrG6NCOwuEs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMuOj3qZGPFpK8zuKrVMlh106RRgHrECkDYcR4
 Hg/pduwKRiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajLjowAKCRAADmhBGVaC
 FSkLD/43AWSz3KDATLDcKOqQqW9Lw0DQkiRS77D/AaJuVmQZnIGdXI69BQWKK+0+PCBB6PoAjth
 D0HNmXmAhzkgMnwRcKkYLVxoxOulWQiuHKxlpmqrZ9TO4KwcB41fVtDcR8qCM3mk97ULvvIFaCb
 672KvElZYwKnkIIAjIpsHf4SJGVyD/udFWxINuk22Jgdo5pqHLiEIRHwlVwkLrIzwuAwUW/ZqnK
 ZuNSAzngUmhrelmv2EQNWBLZXl+EODTK5bvioXgRsZ6Fv2URR4By0XD58VpYYgAvRG1TJJVR2vN
 NoM4pjkxUjjIwbWY02DlCEx2ZEzg8Mj3qIT6QInu6iGTpozuD22jGaHy8U4pitPqZBpeNUDazne
 EA1pWrBP+2QhCf4xaaEkCAumaZRrvlklDZlFkZcjI/FSMy3XC9eeY1PFL99kHSEtb/Y5odNRLvB
 dY0dP2RmrDCE2sQV1m8XFHdsyGFmXid8nSDdMLVGft94UxNGvbQ4jDwbY8alh4fmFdcjAp8gazI
 I2cKm3Bcd8rpWDkTJemURpSL4bm6kjY0kDDmVQB7J52xxrP1snDTL/5UFzHPAj80am0JtOg9LoG
 /wmgmStjV6V3tC/9yLAjdcXtKmlUoYpQaK11zunp7KCjrF8+xaB4yUAwAXIyTERCpiGP/tNu+a0
 BbmQLhp1vTwoIEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22662-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD92969BE49

When NOTIFY4_CHANGE_DIR_ATTRS is requested, nfsd4_cb_notify_prepare()
lowers its limit to NOTIFY4_EVENT_QUEUE_SIZE - 1 to reserve a slot for
the dir attribute update. The producer in nfsd_handle_dir_event() caps
ncn_evt_cnt at NOTIFY4_EVENT_QUEUE_SIZE, so the queue can fill to one
more than that limit.

In that case prepare() took the "we can't keep up!" branch and jumped to
out_recall without draining the queue, leaving ncn_evt_cnt nonzero.
Returning false from prepare causes nfsd41_destroy_cb() to run the
release op, and nfsd4_cb_notify_release() requeues the callback whenever
ncn_evt_cnt > 0. The requeued callback hits the same overflow check and
recalls again, spinning a workqueue thread forever. Because each cycle
holds an stid reference across the requeue, sc_count never reaches zero,
so the delegation is never freed even after the client returns it -
exhausting CPU and leaking the delegation.

Drain the queued events (dropping their references) and reset
ncn_evt_cnt before recalling, so the release op won't requeue. This also
fixes an event reference leak that previously existed on the recall path.

Also guard the release-side requeue against a revoked delegation: there
is no point notifying a client that no longer holds the delegation, and
skipping the requeue avoids pinning the stid and spinning the workqueue.

Fixes: fd0d6dde2a57 ("nfsd: add support to CB_NOTIFY for dir attribute changes")
Reported-by: Sashiko AI <https://sashiko.dev>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2f7210accdf1..b830aed7ae39 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3546,16 +3546,21 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 		return false;
 	}
 
-	/* we can't keep up! */
-	if (count > limit) {
-		spin_unlock(&ncn->ncn_lock);
-		goto out_recall;
-	}
-
 	memcpy(events, ncn->ncn_evt, sizeof(*events) * count);
 	ncn->ncn_evt_cnt = 0;
 	spin_unlock(&ncn->ncn_lock);
 
+	/*
+	 * We can't keep up! Drop the queued events and recall. The queue must
+	 * be drained here: out_recall leaves ncn_evt_cnt at 0, so the release
+	 * op won't see leftover events and requeue this callback forever.
+	 */
+	if (count > limit) {
+		for (i = 0; i < count; ++i)
+			nfsd_notify_event_put(events[i]);
+		goto out_recall;
+	}
+
 	rcu_read_lock();
 	nf = nfsd_file_get(rcu_dereference(dp->dl_stid.sc_file->fi_deleg_file));
 	rcu_read_unlock();
@@ -3663,8 +3668,13 @@ nfsd4_cb_notify_release(struct nfsd4_callback *cb)
 	struct nfs4_delegation *dp =
 			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
 
-	/* Drain events that arrived while this callback was in flight */
-	if (READ_ONCE(ncn->ncn_evt_cnt) > 0)
+	/*
+	 * Drain events that arrived while this callback was in flight, but
+	 * don't requeue against a revoked delegation: there's no point in
+	 * notifying a client that no longer holds it, and doing so can pin the
+	 * stid and spin the workqueue.
+	 */
+	if (!dp->dl_stid.sc_status && READ_ONCE(ncn->ncn_evt_cnt) > 0)
 		nfsd4_run_cb_notify(ncn);
 	nfs4_put_stid(&dp->dl_stid);
 }

-- 
2.54.0


