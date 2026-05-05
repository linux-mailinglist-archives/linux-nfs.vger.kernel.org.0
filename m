Return-Path: <linux-nfs+bounces-21399-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCzcNrVn+mnwOgMAu9opvQ
	(envelope-from <linux-nfs+bounces-21399-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 23:57:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405A4D421E
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 23:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E6EE30A4073
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64C3CB2D7;
	Tue,  5 May 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JoQhg2bk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC04A2E34
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018141; cv=none; b=DPXP2C45St18GkLBVgxfDotzJZwX9TWFJBvZSw8C75Sto3qD1Hlcy8nUsoX1/6/P36Wa1SP8gEI8JwHZk1ft38wlnhu9IPDGWhNaGRt8wMbLNNQdDZPWLzmCSbTv915TZYZAJ2EQzde5JWt1RqrdvH9ke/QbIpUidP6AiAXIUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018141; c=relaxed/simple;
	bh=4QakSgL7gQXb91FNXqYmEEiI968o1GQh1WXxly2rQzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0fhnGw2D09GSyalwpYB7oOmy6+pbQwAFLFKZA49fh9BUbxbkuhzGmPwmq5IvoL2qUVKI5nz+in1HztG+jX3nveHkmrJ6xOMXlq47MYlgpZpMyBL20Y4PlAgGJ7lxJSCFX/8Hae/wZ+g11PK0NStrUYUqZa0COet7VcZSooF8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JoQhg2bk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso19154146d6.3
        for <linux-nfs@vger.kernel.org>; Tue, 05 May 2026 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1778018139; x=1778622939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVUrUfg4vOq9afVrksBWKgXI4pn+24wHz+8mubB5Za4=;
        b=JoQhg2bkMLR6cbLFV5bR/3ft81mYAZz7NGdaoMEcq7e/S8hZ89lBRxiFYhRd2h+sPz
         DZC1PpUalaiztlyaCEDVmYTKrB8gY4RzB6/tMr8e74TWe5MU8umUW2nNC7lY6jxioyxt
         M+vpZU0Vrkvy+2ULZz2p25QSmKIxBMhShscO16pl2K/QDz4oEbLnaXJalbc94FokJ00X
         3+PHTCkQ6AgAbTVdSHe8BxIv5FgiJYcs0hFNV9uSFrEBJY/HZfKUergtM7vDEFU+/aKc
         q/iI3KQxsvZuIfkKHcRptSJ2FUoWfF/Lm/MRfqzkyLQJvo0lMMHGyMBg+J2WchQJWXFY
         iPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018139; x=1778622939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVUrUfg4vOq9afVrksBWKgXI4pn+24wHz+8mubB5Za4=;
        b=gME9Klg0hG7M/YvRwGKhKlQ2wNIiLhAhFPqs/6O1ET7/u8FdX+gZJ2tWsvlvucpgN3
         YXS6EM7tYCHf9J2qjfl47dz7iCWZW7ktnK22STosnHesNTlyH9VuKsaITibQbUXFqE1V
         pxxej+8EwkyY90xh1oMcy4wegF84+hV2tNSJ/DzYqbvD3lLGSO28n0pxyvNcvKz7Mdx5
         a7MJzUiTUvrWLvZGdUUwPK4s7c5ElmIWi5NJCEsBBQMtVgpBKuxIw7qzZLzGrW4zs979
         ohhFZ5WE49SKHWv1rTlKPYBk9W0n4iMsBo3c2xDtyrl5y7vgMgkvts0lLDhJa+cG/Qav
         ISfw==
X-Gm-Message-State: AOJu0Yy6hNv1v/VgjX0wfJ/ewbbdE1ajpR+If+AF2bOOMD1JMSeXGk7m
	aLJAGTsZCfWn+gSQITFz3tpsnr+Z4kaBp5uyJUwHh0D0ZWbByNytV6wUIBrVwQ/zJ1U=
X-Gm-Gg: AeBDievnAHyObZXXnhAzGQ3IV/0Nxq3tRJORGaHfc5FKy/JkFXi8NMTd4YC0CGB/00K
	XsvOoBVGJFp0/OJIvo2BZCOf8EZid1b9ocVPUs/39s9xVPWw0mxVpiGrU9qbQ7PkfWSiLW/C8z0
	Rscl56X4kfOyNXgTl5uawqBx9xyL3my2a92lip4N95DpPF+rjp0QUPDFioTueSkAMsHa5BVfi3t
	YxUp8Q/Cz+kVyIuR2/9exmi21jLqRfh58j8oK+R4PiI393PVmTn25o+r4901GvhSlT+tMK9JGm3
	TP91DbVvMWJwQ2u1jkBscwrOTBkuuOEkKGQ76CUMl7QjEZFm5tpa+MnMkv491eK7gtTRz3gmM1m
	RHeVzY/V7G14lwIm1/HMBVVkyrIomAcS31+Nt735LSRKsoUis3IhP/V80y4PILTKJGTzbNkL7h/
	6GmmzQpRPNcSIyGGkrIZrNS8mj6psjhWt2FuWTa39sWz7/1teZEZMXsdanAHg5g8luzV0J3/HFA
	Rj9sLLvwY2UvcRy03/146AUiUI=
X-Received: by 2002:ad4:5c4c:0:b0:8ac:aeed:b1e7 with SMTP id 6a1803df08f44-8bc4536b3damr9317856d6.30.1778018138485;
        Tue, 05 May 2026 14:55:38 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d6442d0sm157444626d6.46.2026.05.05.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:55:38 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	ben.coddington@hammerspace.com,
	jonathan.flynn@hammerspace.com
Subject: [RFC PATCH 2/2] for diagnostic use only: add svcrdma_wq lag diagnostic
Date: Tue,  5 May 2026 17:55:35 -0400
Message-ID: <20260505215535.68412-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260505215535.68412-1-snitzer@kernel.org>
References: <20260505215535.68412-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4405A4D421E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21399-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:dkim,hammerspace.com:email,claude.md:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]

From: Mike Snitzer <snitzer@hammerspace.com>

Per-5s rates of svc_rdma_wc_send (proxy for queue_work into
svcrdma_wq, since each Send completion queues one put),
svc_rdma_send_ctxt_put_async (actual workqueue dispatch),
svc_rdma_send_ctxt_get (demand on the cache), and the
svcrdma_send_ctxt_capped tracepoint.

Used to diagnose whether svcrdma_wq dispatch is keeping up with
inflow under sustained load -- a sustained gap between wc_send and
release rates means ctxts are pinned as queued sc_work items, which
the on-llist depth counter cannot see.

Uses only reliably-traceable hooks: wc_send and _put_async are
function-pointer call sites that cannot be inlined; _get is forced
out-of-line by external callers in recvfrom and backchannel TUs (see
CLAUDE.md "Probe-inlining gotcha").

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 .../filesystems/nfs/svcrdma-wq-lag.bt         | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 Documentation/filesystems/nfs/svcrdma-wq-lag.bt

diff --git a/Documentation/filesystems/nfs/svcrdma-wq-lag.bt b/Documentation/filesystems/nfs/svcrdma-wq-lag.bt
new file mode 100755
index 0000000000000..16e374bcb7aa8
--- /dev/null
+++ b/Documentation/filesystems/nfs/svcrdma-wq-lag.bt
@@ -0,0 +1,146 @@
+#!/usr/bin/env bpftrace
+/*
+ * svcrdma-wq-lag.bt
+ *
+ * Test the "svcrdma_wq is the bottleneck" theory.
+ *
+ * Background
+ * ----------
+ * An earlier commit from Ben Coddington ("svcrdma: cap per-xprt
+ * sc_send_ctxts free list at sc_max_requests") added an atomic depth
+ * counter on the sc_send_ctxts llist and a cap check inside
+ * svc_rdma_send_ctxt_release(). The svcrdma_send_ctxt_capped
+ * tracepoint was supposed to fire whenever the cache was about to
+ * exceed sc_max_requests.
+ *
+ * Customer test on hot workload: tracepoint fires zero times during
+ * the test, then floods the moment the test is Ctrl-C'd. Memory
+ * keeps growing during the test as before.
+ *
+ * Hypothesis
+ * ----------
+ * svcrdma_wq is alloc_workqueue("svcrdma", WQ_UNBOUND, 0). WQ_UNBOUND
+ * has bounded concurrency but UNBOUNDED queue depth. Under load,
+ * svc_rdma_wc_send (Send completion ISR) calls svc_rdma_send_ctxt_put,
+ * which does INIT_WORK + queue_work and returns in microseconds. The
+ * worker, svc_rdma_send_ctxt_put_async -> svc_rdma_send_ctxt_release,
+ * has to do ib_dma_unmap_page per SGE plus release_pages plus
+ * svc_rdma_reply_chunk_release -- a much slower operation.
+ *
+ * If queue rate >> worker rate, work items pile up. Each pinned
+ * sc_work is embedded in its ctxt, so ctxts can't be released. The
+ * llist stays empty (depth ~ 0), and the cap at _release never
+ * fires. _get keeps seeing an empty llist and calling _alloc for new
+ * ctxts. Memory grows.
+ *
+ * After Ctrl-C: completions stop, workqueue drains, all queued
+ * releases run rapid-fire. NOW the llist depth shoots past
+ * sc_max_requests and the cap fires for each subsequent release --
+ * the post-test flood.
+ *
+ * What this script measures
+ * -------------------------
+ * Per 5-second window, three rates:
+ *
+ *   @wc_send_rate    svc_rdma_wc_send invocations
+ *                    -- proxy for svcrdma_wq.queue_work() rate
+ *                    (each completion queues one put)
+ *
+ *   @release_rate    svc_rdma_send_ctxt_put_async invocations
+ *                    -- actual workqueue dispatch rate
+ *
+ *   @get_rate        svc_rdma_send_ctxt_get invocations
+ *                    -- demand pressure on the cache
+ *
+ *   @capped_rate     svcrdma_send_ctxt_capped tracepoint count
+ *                    -- where Ben's cap actually fires
+ *
+ * Reading the result
+ * ------------------
+ *   If @wc_send_rate >> @release_rate during the test, the workqueue
+ *   is backed up -- queue items are accumulating, which means ctxts
+ *   are pinned in workqueue items. Hypothesis confirmed.
+ *
+ *   If those two rates are comparable, the workqueue is keeping up
+ *   and the bottleneck is somewhere else.
+ *
+ *   @capped_rate ~ 0 during the test, then @release_rate >>
+ *   @wc_send_rate after Ctrl-C (workqueue draining), then
+ *   @capped_rate spikes -- exactly the user's observed pattern.
+ *
+ *   @get_rate gives the workload's natural cadence; if @get_rate >>
+ *   @release_rate sustained, allocations are accumulating regardless
+ *   of where in the pipeline they're stuck.
+ *
+ * Probes used
+ * -----------
+ *   kprobe:svc_rdma_wc_send                  function pointer call;
+ *                                            reliably traceable
+ *   kprobe:svc_rdma_send_ctxt_put_async      workqueue function
+ *                                            pointer; reliably
+ *                                            traceable
+ *   kprobe:svc_rdma_send_ctxt_get            external callers force
+ *                                            it out-of-line;
+ *                                            reliably traceable
+ *   tracepoint:rpcrdma:svcrdma_send_ctxt_capped
+ *                                            from Ben's patch
+ *
+ * If the tracepoint fails to attach (rpcrdma module's tracepoint
+ * table not visible to bpftrace at attach time), comment out that
+ * probe -- the rest of the script still answers the main question.
+ *
+ * Usage
+ * -----
+ *   sudo bpftrace svcrdma-wq-lag.bt
+ *   (Ctrl-C to exit; END block prints a final snapshot.)
+ *
+ * Run for 60-120s under the load that previously OOM'd. Watch the
+ * 5-second windows; the gap between @wc_send_rate and @release_rate
+ * is the smoking gun.
+ */
+
+config = {
+	max_map_keys = 4096;
+}
+
+BEGIN {
+	printf("svcrdma_wq lag diagnostic. Per-5s rates.\n");
+	printf("Watch for @wc_send_rate >> @release_rate during the test\n");
+	printf("(workqueue backed up -> ctxts pinned in queue items ->\n");
+	printf(" Ben's cap can't see them).\n");
+	printf("Ctrl-C to exit.\n\n");
+}
+
+kprobe:svc_rdma_wc_send {
+	@wc_send_window += 1;
+}
+
+kprobe:svc_rdma_send_ctxt_put_async {
+	@release_window += 1;
+}
+
+kprobe:svc_rdma_send_ctxt_get {
+	@get_window += 1;
+}
+
+tracepoint:rpcrdma:svcrdma_send_ctxt_capped {
+	@capped_window += 1;
+}
+
+interval:s:5 {
+	time("\n%H:%M:%S  ");
+	printf("wc_send=%-8lld release=%-8lld get=%-8lld capped=%-8lld",
+	       @wc_send_window, @release_window,
+	       @get_window, @capped_window);
+	if (@release_window > 0) {
+		printf("  queue/release ratio=%lld",
+		       @wc_send_window / @release_window);
+	}
+	printf("\n");
+	clear(@wc_send_window);
+	clear(@release_window);
+	clear(@get_window);
+	clear(@capped_window);
+}
+
+END { }
-- 
2.44.0


