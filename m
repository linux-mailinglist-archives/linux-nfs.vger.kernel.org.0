Return-Path: <linux-nfs+bounces-21987-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COFzFhr2FWqzfwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21987-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:35:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2E5DC099
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 455F03004C98
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AB3AA4E4;
	Tue, 26 May 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJcpLhVU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9A3A7F67;
	Tue, 26 May 2026 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824117; cv=none; b=sfSAAZnXNthSxjrUYFou7gY8F4TMJ+7xYPOqwe5qgKxbUHHX5Ia0/GcBEtaU52VNRBhiWObzXIvOfbX+bJmmvykhV7ov/mbbpnu8/PNW63C0W9Mo1OuyKgL5Pvui96ra7vcIcO7uYe2cEAdrP9ZLMF6uywDRqN5PKs+LLuIUUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824117; c=relaxed/simple;
	bh=oJCAD767lEvcJtdX4QL2EZdPgEKpMJ0fVRHYf871C2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P4LPzLk7Q8MWuNAONxL1oajBdqUuKakz9czskAjJY94vuYv9ZYN64t8Q8en6Ok/IAxn4nd7aZ/Ux5gPSv9GbtDMXDjwqJcZukashU1N90gKf6CFxyPbZS6gGyr2Q3CZFoKqSCWFr0NUomJIK09cud1uQoAwIEOTc+9MuDpi0mKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJcpLhVU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933811F00A3A;
	Tue, 26 May 2026 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824116;
	bh=Zj8aAjGKG5w7thnd+pEEQUtdzXDGrVfJLbeOlsjh3/s=;
	h=From:Date:Subject:To:Cc;
	b=AJcpLhVUG3tEoEe7Rz5JWbJTEScuaZARHtqgFkKCHEzyDJNTrMiIbuROtBbVcigz+
	 ZNVLIFy1NSzZ1BXYB5sZeS+abcaGqfneq1kMza5aTdyirhRwSPG5vHmQUykgCHsX0V
	 jOOcL2PfOiFXf4yrBBPDdqrGNWrbLqTGRMU9iBQqEz/ZMAp10uNI/4J+XJSFVzH2gM
	 jR7F5tU9Ue+6li/vR0mIkqlERrAHXiawJmzfiDJvb5roTIez6dkbuxHnVkQqGktFZI
	 yxqmcrC4ImID+TlbYwKn3wFwr03lAKBy9S3tktEdKCQgdyBTo8YXBade5b2QHIqi7/
	 uPvvsCYdj8Z8g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 26 May 2026 15:35:06 -0400
Subject: [PATCH] SUNRPC: always drain cache_cleaner before destroying a
 cache_detail
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-cache_cleaner_vs_destroy_no_sync-v1-1-a707a6fcfd32@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3N0QrCMAxA0V8ZebawVlaYvyISSpq5gKSSyHCM/
 bvFx/Ny7wHOJuxwGw4w3sSlaUe8DEBr0ScHqd2QxpTHKeVAhVZGenFRNtwcK/vH2o7a0HelEK9
 pnpccK08EPfM2XuT7X9wf5/kDxE364HIAAAA=
X-Change-ID: 20260526-cache_cleaner_vs_destroy_no_sync-13299f61de5c
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oJCAD767lEvcJtdX4QL2EZdPgEKpMJ0fVRHYf871C2Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFfXux3TIcvKtYcsE40LUOikpvlH7qO/7bjGOT
 gyw5ZE/ImuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahX17gAKCRAADmhBGVaC
 FX1sEACbct2archT4ThbbbEPn7yhOacquQ/3iEbH7FMCCFJbDsdaKliVfnMknGKc3qOJDbUZvDT
 QyvjOA1awzYcyIawwDA4BHjAka9lvGrPHgBwR96pqrTgx0zDd0LHNymHu+mcl41WonLUcuEWIdA
 vQgteHtgGL6t5aI2F5gGEbvYSkxfbrYkdyBsMb1kleW/fhtuYJMU/DT+sFRB9tGHOv4wyz3H2lN
 rtAhosDMYyXUejjCiM+nztWnE78ozjZqIuphDAw54bsbhwNdrxOxCBthrIW/A3xo2uRVkeL2Gg9
 mYx3KzQ9ODq2gTzvRLChhGd+fbRlh/Nj+yhlpngRWYKvlGuTGC7qqSXtZIAFbcKsZTBVA0ZbeG5
 SoyqWQ7xJKsaY4Qilsuo0+J6p5J0VUFwrlbxnlSjVwQjJGa+0EJQwuNQIDghWWBFDFzcZb2iF2I
 vJQy/UScRPh0nBO+AEobkjJxDvJsGWb8cx/gpBZ2DWv8c6I+Kh5ZByYbwwbmch4/yTBHf7j/4GR
 aMfauPrCzJ7Zj2LuLunBF7o9V/3SMpmVdj2qC0AdYiJ38kSIe/t2ySKcV4Ap0PsNXEwZ9qjyY6G
 iLYIlV8RPhguKXLySNkqPvRSfAP++LGgIt7w3Lmcmb0PvnFF1v2zgb+MXyG6GMCT1bf3irUP7AZ
 OBLgYrwf7gOUW0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21987-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58C2E5DC099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sunrpc_destroy_cache_detail() only cancels the global cache_cleaner
delayed_work when cache_list is empty.  During per-netns teardown
cache_list is never empty because init_net's caches remain registered,
so the cancel never fires.  After unlink, the caller proceeds to
cache_destroy_net() which kfrees the cache_detail while cache_clean()
may still hold a dangling pointer to it.  The result is a
use-after-free: cache_dequeue() takes cd->queue_lock on freed memory,
and cache_put() dereferences cd->cache_put as a function pointer from
freed slab.

Drop the list_empty guard so that cancel_delayed_work_sync() always
runs, ensuring any in-flight cache_clean() completes before the
cache_detail is freed.  Re-arm the cleaner afterwards if other caches
are still registered.

Fixes: 820f9442e711 ("SUNRPC: split cache creation and PipeFS registration")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/cache.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 391037f15292..1bc04109d213 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -430,10 +430,9 @@ void sunrpc_destroy_cache_detail(struct cache_detail *cd)
 	list_del_init(&cd->others);
 	spin_unlock(&cd->hash_lock);
 	spin_unlock(&cache_list_lock);
-	if (list_empty(&cache_list)) {
-		/* module must be being unloaded so its safe to kill the worker */
-		cancel_delayed_work_sync(&cache_cleaner);
-	}
+	cancel_delayed_work_sync(&cache_cleaner);
+	if (!list_empty(&cache_list))
+		queue_delayed_work(system_power_efficient_wq, &cache_cleaner, 0);
 }
 EXPORT_SYMBOL_GPL(sunrpc_destroy_cache_detail);
 

---
base-commit: 97bac3c7a039675d7ae71fbdf3a7c39e840339b6
change-id: 20260526-cache_cleaner_vs_destroy_no_sync-13299f61de5c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


