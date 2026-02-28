Return-Path: <linux-nfs+bounces-19443-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCR9EZBMo2nW/AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19443-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:14:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A79AC1C8113
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F65231B1974
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E04301BD;
	Sat, 28 Feb 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK6CtK9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59744301BC
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300817; cv=none; b=dg4rlapj5iGBVeYybkqewK1hJMY9vnKz6WBDMT9wF10mu5wF16NZWB0y3MNi8ZGudV6PO241INiYY7OCNGBNjO9UetuwQkYX4MObAyltrF1n9SRiaOEUD3uWEu4N+p//5AsNT/iQmCookqAKMlvDxw/Kp2sFghmzqXcQnL4UukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300817; c=relaxed/simple;
	bh=Zq3U2WpQL01tg4siPgjvCwrDjfak6yQQYAVG5jwhW0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFtgc9mkpvqA6u5bpLPpeUn7wD9oAa5im+nqL3+eL31lHu0VvXciQy7mdaGtUS4DX9fz9LwXrH2i9QXAqtu2qb8gpIfgB0MpTGeF8WjFSlE8YYR52K4mQdgK0YU0WP1eFg/FCL3bRONL2lgy0dpibFseHOoJB6PFM/KzrvRpiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK6CtK9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB05C116D0;
	Sat, 28 Feb 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300816;
	bh=Zq3U2WpQL01tg4siPgjvCwrDjfak6yQQYAVG5jwhW0g=;
	h=From:To:Cc:Subject:Date:From;
	b=eK6CtK9uU+dE6/WLCaEep88N/Njbsk6qgOAZn/OGpvhXVzgR/IDqD8Z+ZIIgZEFi+
	 GPQy6CJBBitC/n2fPpG4cAlo8lg8TAkoXupguI1zBoTUI/ngTqFRH7tgMighiAwm8P
	 e1AVNAFoeSutkGXQrKk4Sd8GxFNHv8XXQurb7twOz76tQF18/4fVbOAH52taap6E/J
	 2Btte6RDUsJT6Id6OyFq1s/cHlIf+iCVAbKL2gsZ9uwgmKfJdlfqsK14hCIprtotgz
	 5rGo4/cn7xNCwFzxFEw60hMZ2qaBtP/T2gJodE9lJZcOJMkFrS8Ipr6RhLb3hB6byC
	 jKOBCCnLKRB6A==
From: Chuck Lever <cel@kernel.org>
To: Steve Dickson <SteveD@redhat.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] mountstats: Fix per-operation percentages with nconnect
Date: Sat, 28 Feb 2026 12:46:54 -0500
Message-ID: <20260228174654.129309-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19443-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79AC1C8113
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Per-operation percentages reported by "mountstats --rpc" are
inaccurate when an NFS mount uses nconnect.

With nconnect=N, the kernel emits N separate "xprt:" lines in
/proc/self/mountstats, one per transport.  Each transport tracks
its own rpcsends counter reflecting only RPCs routed through that
connection.

The parser overwrites rpcsends on each "xprt:" line, keeping only
the last transport's value.  Per-operation counts (READ, WRITE,
etc.) are maintained in a single array per RPC client and reflect
all RPCs across all transports.

With nconnect=3 and balanced round-robin, rpcsends holds roughly
one third of total RPCs while per-op counts hold the full total.
display_rpc_op_stats() computes (op_count * 100) / rpcsends,
yielding percentages roughly three times too large.

Accumulate rpcsends, rpcreceives, badxids, backlogutil,
sendutil, and pendutil across multiple "xprt:" lines. These are
cumulative counters where the sum across transports gives the
correct aggregate.  Per-connection properties (port, bind_count,
connect_count, connect_time, idle_time, maxslots, inflightsends)
retain the value from the last transport seen.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/mountstats/mountstats.py | 61 +++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index d488f9e1c258..a6adab344d0e 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -140,6 +140,38 @@ XprtRdmaCounters = [
     'reply_waits_for_send',
 ]
 
+# Counters that should be summed across transports when nconnect > 1.
+# Each is stored in a per-transport structure in the kernel
+# (xprt->stat or rpcrdma_xprt.rx_stats) and represents a cumulative
+# event count or utilization value.  Per-connection properties (port,
+# bind_count, connect_count, connect_time, idle_time, maxslots,
+# inflightsends) retain the value from the last transport seen.
+XprtAccumulatedCounters = {
+    'rpcsends',
+    'rpcreceives',
+    'badxids',
+    'backlogutil',
+    'sendutil',
+    'pendutil',
+    'read_segments',
+    'write_segments',
+    'reply_segments',
+    'total_rdma_req',
+    'total_rdma_rep',
+    'pullup',
+    'fixup',
+    'hardway',
+    'failed_marshal',
+    'bad_reply',
+    'nomsg_calls',
+    'recovered_mrs',
+    'orphaned_mrs',
+    'allocated_mrs',
+    'local_invalidates',
+    'empty_sendctx_q',
+    'reply_waits_for_send',
+}
+
 Nfsv3ops = [
     'NULL',
     'GETATTR',
@@ -291,23 +323,22 @@ class DeviceData:
         elif words[0] == 'xprt:':
             self.__rpc_data['protocol'] = words[1]
             if words[1] == 'udp':
-                i = 2
-                for key in XprtUdpCounters:
-                    if i < len(words):
-                        self.__rpc_data[key] = int(words[i])
-                    i += 1
+                counters = XprtUdpCounters
             elif words[1] == 'tcp':
-                i = 2
-                for key in XprtTcpCounters:
-                    if i < len(words):
-                        self.__rpc_data[key] = int(words[i])
-                    i += 1
+                counters = XprtTcpCounters
             elif words[1] == 'rdma':
-                i = 2
-                for key in XprtRdmaCounters:
-                    if i < len(words):
-                        self.__rpc_data[key] = int(words[i])
-                    i += 1
+                counters = XprtRdmaCounters
+            else:
+                counters = []
+            i = 2
+            for key in counters:
+                if i < len(words):
+                    val = int(words[i])
+                    if key in XprtAccumulatedCounters and key in self.__rpc_data:
+                        self.__rpc_data[key] += val
+                    else:
+                        self.__rpc_data[key] = val
+                i += 1
         elif words[0] == 'per-op':
             self.__rpc_data['per-op'] = words
         else:
-- 
2.53.0


