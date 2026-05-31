Return-Path: <linux-nfs+bounces-22134-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKU2MvYlHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22134-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:13:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DD616007
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E401B307BA20
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F73D386C0F;
	Sun, 31 May 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQpWbY7d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E73372060;
	Sun, 31 May 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229244; cv=none; b=S0dqcZVAjUlIJfq0kDf05hWKJ00NpQsr+vkbw+oPn0th9PnHjPBsDQ9h0Gqqli9TZ94T+jcd8zV7Mr8Wd+H+KCWKBWME1mKtHJUfaCdlNmyP/ZgYxu2U/W7pTBAfrBWh1pemFb3Wiu3Tst0aUoWLFLFO36sQf1quqjWh9gemVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229244; c=relaxed/simple;
	bh=Hm0zCW9aG+ykmGtE6Szcl+eqPu2Q842Gl9Am0VOU948=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDxIxSJMFYXwfAMAoMfD/cqwj1lkJL2fgXJ7fLwY9Rh06783CC+OF0jwDUdgKKBV1aH0b+ONrF7iIJtgQbCzCVmsELkA6GWfK6VMIt74+rQZwzK30EmrIJ7+NPgnPsw4HvzbLhlQpHxBR11N+myOoTL5qBCDiCEWYaqZD5FZ3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQpWbY7d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68611F00899;
	Sun, 31 May 2026 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229236;
	bh=uDaxjB3lMGip+HPjVkemne90SSI/5/0SDYtKUx199As=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KQpWbY7dGJ3IHc/OXLo+hjNlFpTIqGWjwM0pUgWOmZDfONGzYs1JdOQZzNboWCIWe
	 jVYyr/W445BSLy5y0bC82wkeA3pXPmpAvyHh16UOmnbqrXGvohrbaseoILnv2k/Xr3
	 xaDS8YAwV4EoufyniPWBrKy8v5NdLQ/trSds/ICBJmMVS00Eix6xcJcUiFhCtQBvOh
	 G74yy6cpQ6RTduX7/YoilvEerdrz4RwEv8WXYh1rxWbLj/K2zQHazf8LvCUWjCH5rL
	 GReo6i9dNLj+H8DfCtLfVV7s+6qdw8frua/RWGvzNcE2rUhTVYx3k7TddXWG2HvATw
	 U97E9wwxfQKpA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:07:03 -0400
Subject: [PATCH 6/6] nfsd: fix layout fence worker double-reference race
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v1-6-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
In-Reply-To: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, David Howells <dhowells@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3802; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Hm0zCW9aG+ykmGtE6Szcl+eqPu2Q842Gl9Am0VOU948=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHCRrW3UJ8TzwL9ad6g2rLYlGjVenfRkq6nRKz
 h4ornlUQ2iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahwkawAKCRAADmhBGVaC
 FdAKEACD99RjZjSwstwe02l92r843e1PlO/llI+9pH3KbmitIS24TVBxThmdUCW8YE4KCkAMmUL
 gvjEDoyk2/444nkAK0OEmpZVD3BQOjW9PgF319CO5H2Nj1mVKl/NJY7bmo7+FTG/xWaPfMSEkHC
 Lu7z2bdBAP9b5cbp+ZcnbHh2G/rKL6xJZaIxy5oDPoq58XMrR+oJxyzyk0OI4MdABRHCU5nzYZj
 vrBoT8Vwd9U0+Px0FALLOsJhdzIYfj90f2ZOdQMhv6JzHhue78qM4lhccU9yMLkeyVqB0dHcqxa
 EtvKAQ7VvGj9uOgp/yHmZ8bEddN1sakpygOjevefwPeok0Z4eMFn+ye+MjAs2lB6lI8jtXTGlMM
 EsxsEO+CTPjYELxTLqmLqm47iJHP+5eLydC/aYbNeBzv6jP+pNBfvZOUQgBy9Qce3cX/s76CJ0w
 2WXFGYF3eSChUzFexvQVxGR/piDhMv2CihwrlgE+Bnw2dQFMs6U+etqrrGaG7GMAYquMP1Kt4Fu
 22Y1pOFWl9Jd6uuRD1NqKCc2Wgyl5fM82ntVT6eH9jkS6TJX1mRESq6NznWb0O942GUTS+vBaKq
 9+i6sKzDrrpBLxTMXUitZP2Az3ghyVEDYErVtCDoxbQrlCz2BKJmwU9vzi5szMuzi38lkWKkDyO
 6hXtmpFIDLgJLkQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22134-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 352DD616007
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The workqueue core clears WORK_STRUCT_PENDING before the callback
is invoked, so delayed_work_pending() in lm_breaker_timedout() can
return false while the fence worker is already running. This lets
the breaker take a duplicate sc_count reference and schedule a new
worker that coalesces with the in-progress one. The extra reference
is never put, leaking the layout stateid.

Replace the racy delayed_work_pending() check with an
ls_fence_inflight boolean set atomically with
refcount_inc_not_zero() under ls_lock, and cleared under ls_lock
before nfs4_put_stid() on every exit path.  Remove the self-rearm
mod_delayed_work() at the top of the worker.

Fixes: f52792f484ba ("NFSD: Enforce timeout on layout recall and integrate lease manager fencing")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 27 +++++++++++++++------------
 fs/nfsd/state.h       |  1 +
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 6c4e4fdd6c05..475246c0e20c 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -260,6 +260,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	}
 
 	ls->ls_fenced = false;
+	ls->ls_fence_inflight = false;
 	ls->ls_fence_delay = 0;
 	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
 
@@ -798,15 +799,6 @@ nfsd4_layout_fence_worker(struct work_struct *work)
 	struct nfs4_client *clp;
 	struct nfsd_net *nn;
 
-	/*
-	 * The workqueue clears WORK_STRUCT_PENDING before invoking
-	 * this callback. Re-arm immediately so that
-	 * delayed_work_pending() returns true while the fence
-	 * operation is in progress, preventing
-	 * lm_breaker_timedout() from taking a duplicate reference.
-	 */
-	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
-
 	spin_lock(&ls->ls_lock);
 	if (list_empty(&ls->ls_layouts)) {
 		spin_unlock(&ls->ls_lock);
@@ -816,6 +808,9 @@ nfsd4_layout_fence_worker(struct work_struct *work)
 		nfsd4_close_layout(ls);
 
 		ls->ls_fenced = true;
+		spin_lock(&ls->ls_lock);
+		ls->ls_fence_inflight = false;
+		spin_unlock(&ls->ls_lock);
 		nfs4_put_stid(&ls->ls_stid);
 		return;
 	}
@@ -901,18 +896,26 @@ nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
 	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
 			ls->ls_fenced)
 		return true;
-	if (delayed_work_pending(&ls->ls_fence_work))
-		return false;
 	/*
 	 * Make sure layout has not been returned yet before
-	 * taking a reference count on the layout stateid.
+	 * taking a reference count on the layout stateid. The
+	 * ls_fence_inflight flag is set together with the sc_count
+	 * increment under ls_lock so that a fence worker invocation
+	 * already in progress (which has cleared WORK_STRUCT_PENDING
+	 * but not yet reached dispose:) cannot be coalesced with a
+	 * fresh schedule that takes an extra unmatched reference.
 	 */
 	spin_lock(&ls->ls_lock);
+	if (ls->ls_fence_inflight) {
+		spin_unlock(&ls->ls_lock);
+		return false;
+	}
 	if (list_empty(&ls->ls_layouts) ||
 			!refcount_inc_not_zero(&ls->ls_stid.sc_count)) {
 		spin_unlock(&ls->ls_lock);
 		return true;
 	}
+	ls->ls_fence_inflight = true;
 	spin_unlock(&ls->ls_lock);
 
 	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c26b2384d694..05b6f12040d8 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -812,6 +812,7 @@ struct nfs4_layout_stateid {
 	struct delayed_work		ls_fence_work;
 	unsigned int			ls_fence_delay;
 	bool				ls_fenced;
+	bool				ls_fence_inflight;
 };
 
 static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)

-- 
2.54.0


