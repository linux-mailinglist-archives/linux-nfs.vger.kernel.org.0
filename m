Return-Path: <linux-nfs+bounces-20816-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMjdLz252mkO5wgAu9opvQ
	(envelope-from <linux-nfs+bounces-20816-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Apr 2026 23:12:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEE3E1B7A
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Apr 2026 23:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD52F3008441
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Apr 2026 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A162FFDE3;
	Sat, 11 Apr 2026 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJD7F+rK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F9248880;
	Sat, 11 Apr 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775941943; cv=none; b=PnXogrb3KXlJiE97WTvg0Op0qyzpj/6YATp79+5jFkO1kPGLemiEEHMZ1yJMLyJpVLyB4NuRzDjooQUzIWQ8e0bR9bg2xxkYPAJzckQexJM6KkRx/p0sAM3yoSAQW3nHf/YpbRJ4m9T5lkNuEBJgsEJF0ah4n1yqDQAnlgC/bPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775941943; c=relaxed/simple;
	bh=zZbzxmN5GftsX0EeN88EW7G2QUstoxwy9RW4SXIzW5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dkMO6R9glCw1yO3hEQ2rPLGDtwjQO/8fNKz6VrkmSeRV3XlPLT1V5g6FHhYmMXe8GK1HkkRM2Icp32aHBwLmejg2qZgiBHbea1M0rCizp1GdDlNngyiIkNl0xl8nazVaHVhwxHpkoTs1HghLnVskmIzlQCL435l1rF/FUMj/wRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJD7F+rK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C7BC116C6;
	Sat, 11 Apr 2026 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775941942;
	bh=zZbzxmN5GftsX0EeN88EW7G2QUstoxwy9RW4SXIzW5M=;
	h=From:Date:Subject:To:Cc:From;
	b=BJD7F+rK9bwK/BTX2mnxpL9rrKTfw5DqKU53lNs4VdBJUrjEeDmYBgSPnUnpVHOF5
	 dwoDwZFQ0JtEAsflx/78Kai4OKkCyvEZX8LN7qY/W6fMv7JZAM5kmy8cY1YyMS/DCa
	 YdcnxCRNcejoXaafOUWpGzVt94X+ooIBisY40/YEzB6AHfkSQAHsUmDD89yb7CswkK
	 w8vY2vTAglpsQSeGCXrjE220kYUvfh6pXef3j6qZw33lgWv/z/K/sOg9mSrh6EnIHD
	 hwAbpnyJwzLIgjxApZEqiX6ZmKrUdoMkTCzJIsKJRyX0tya6W0Ykm0Zotolq5+UcuK
	 nCQuo35iQarrg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 11 Apr 2026 17:12:16 -0400
Subject: [PATCH] sunrpc: start cache request seqno at 1 to fix netlink
 GET_REQS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-exportd-nl-v1-1-ca582b6d9434@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ND3dSKgvyikhTdvBxdo+QUo1TLFBNTw6RkJaCGgqLUtMwKsGHRsbW
 1AGEj7wxcAAAA
X-Change-ID: 20260411-exportd-nl-2cd2e9d451bc
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zZbzxmN5GftsX0EeN88EW7G2QUstoxwy9RW4SXIzW5M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp2rk1s96udHJB/bmF9NmptWvK0ddRiijbTEVIY
 Gj4qPF1rKeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadq5NQAKCRAADmhBGVaC
 FYU8EACeqybISgRP7VIY2hb/VzrG6liQvVSru+UytOq+ZvO3L5pvK9mQuqWWaztKDvFQ90RmZKN
 zbcj+zaJf8+TKBmT2EadXIW8y6uoYYdsZWlIBPWLIO8bW0DQ3TdJAzcVuNjEF2Hr48VdpnSol/s
 zGe11E9quVgS2D+rtfvoGXtH0Q08x6EQUPKTSEjhCx+7pXAxMD6ev6zHnpk5GztuGsszAV8FtO3
 lJaRDwYDQM7BDUosxplTFIgbLKbTFnbRGKZFCgZGbaJ7aXqfH/sDov33vQl42uG28IxZrHs9xlk
 2H5dvUTL7Fgs41zzmfqPE0olbMObc5wlR9yryJpCOUf9u7D3H/GitgLu/qugw0lgeTp/iYxq0nh
 +DlVbKljVyPhtnP/i4WU9Yf2y7t0cnjQS/MhFvJ+SClwY8Yg51lJa9VBIApze68aV/keqXeCSGt
 shHfYT2n5hdA0grXKTSMF/Z1cPfGeZDYKprhJsjM+sYFIL/+5vJPgejO/lnbbyWG/hRp1e9Ebcu
 cm3Hw0daoa523L5VMG+gCCJfEi+FF6/5DohqjWaE/CzXmoJDkWrOhAFehdfUoC7+3Xe5euuUFDy
 b6xwO5+5LFARMt0Ou5+k1Uv+SYcDXaE9pDqJJ6igB0C8oycG6nOFB53shYOLnZsed8W3MvVbXxb
 HOPIpQLgPjqD97Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20816-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5FEE3E1B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sunrpc_cache_requests_snapshot() filters requests with
crq->seqno <= min_seqno. The min_seqno for the first netlink
dump call is cb->args[0] which is 0. Since next_seqno was
initialized to 0, the very first cache request got seqno=0
and was silently skipped by the snapshot (0 <= 0 is true).

This caused netlink-based GET_REQS to return 0 pending requests
even when a request was queued, preventing mountd from resolving
cache entries (particularly expkey/nfsd.fh). The unresolved
CACHE_PENDING state blocked all further notifications for the
entry, leading to permanent NFS4ERR_DELAY hangs.

Start next_seqno at 1 so all requests have seqno >= 1 and pass
the snapshot filter when min_seqno is 0.

Fixes: facc4e3c8042 ("sunrpc: split cache_detail queue into request and reader lists")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I started hitting a persistent hang in mountd upcalls just after reboot,
and this turns out to be the cause. It's probably best to fold this into
the patch in the Fixes: line.
---
 net/sunrpc/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index d477b19dbfa1..305c6e67f052 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -405,7 +405,7 @@ void sunrpc_init_cache_detail(struct cache_detail *cd)
 	INIT_LIST_HEAD(&cd->readers);
 	spin_lock_init(&cd->queue_lock);
 	init_waitqueue_head(&cd->queue_wait);
-	cd->next_seqno = 0;
+	cd->next_seqno = 1;
 	spin_lock(&cache_list_lock);
 	cd->nextcheck = 0;
 	cd->entries = 0;

---
base-commit: 68f3218e45ab644ed37d5020a4a25e523fc0e30e
change-id: 20260411-exportd-nl-2cd2e9d451bc

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


