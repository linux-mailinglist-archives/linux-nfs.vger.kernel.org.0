Return-Path: <linux-nfs+bounces-21344-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPJkOVsV9WkEIQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21344-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 23:04:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EA94AFA72
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 23:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B3A3015732
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D531423145;
	Fri,  1 May 2026 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="E+YIy6ao"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365E36B046
	for <linux-nfs@vger.kernel.org>; Fri,  1 May 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669408; cv=none; b=GQz/MEb+So2rZ6jmVg8Pfmjq2iHogk0DBYINiE5lHzjgd+gkJEjR15i5ZnaMrosd6LlgM17fe1ZXFyMUeP3v7z/w6Qi3LGzGHbNLHdAjgF/G1uCSpnpKSGGLV91+Z22mmC+z2AAM1NszP6nQOYC2B5zKndaPeKViMCXE6sHHC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669408; c=relaxed/simple;
	bh=KZc/Zsl78fson1OjjF58aPvLDihNwtlt6jpLvYExU44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Scsio3tdGWexiSXOon/g9Jd6S9ORq9m1c2e2XWukmHYZgrZLu2/a52Ng9+iZ5tU9zgDp9GEUPONaIZ2elSTiE46YZ1ucf0zcb3xkHKmZC2iunuKzKsGjTkJMCkMZHQHYlFEnt4P9mbM7QV90hNMhWM6suWqVuf8vhf44h11qDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=E+YIy6ao; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	by smtp-o-3.desy.de (Postfix) with ESMTP id EBB9511F92E
	for <linux-nfs@vger.kernel.org>; Fri,  1 May 2026 22:56:14 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 4E7B113F648
	for <linux-nfs@vger.kernel.org>; Fri,  1 May 2026 22:56:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 4E7B113F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1777668967; bh=jJ5IHXzys4V7exX5ZiYZno9IH3XdJ+rc84fkzm+0b1o=;
	h=From:To:Cc:Subject:Date:From;
	b=E+YIy6aoyZyk1IEGFz2mdIVJIqnEQFPkpMHQXlHHevc2pokipqod9Mn9usBxuWam7
	 I2IU7nmlh/Oc0DZWXKdjHTYvG4nYXMU+qDJNchv/CdiSgWPCyfWEd7xt6aVif7vKkz
	 N2+faYMTV/vIdnW5TaiZw+k1H7VhV0+Lo3Jc9cRQ=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 43A08120043;
	Fri,  1 May 2026 22:56:07 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 3A8BC40044;
	Fri,  1 May 2026 22:56:07 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 4A5C4160058;
	Fri,  1 May 2026 22:56:06 +0200 (CEST)
Received: from nairi.fritz.box (VPN0289.desy.de [131.169.254.34])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 1402380046;
	Fri,  1 May 2026 22:56:06 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfs-utils: add option to display throughput in MB/s
Date: Fri,  1 May 2026 22:56:04 +0200
Message-ID: <20260501205604.653238-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48EA94AFA72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21344-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[desy.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,desy.de:email,desy.de:dkim,desy.de:mid];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]

Nowadays,the network bandwidth in kB/s is quite a large number to read.
Thus, let nfsiostat display it in MB/s if requested.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 tools/nfs-iostat/nfs-iostat.py | 53 ++++++++++++++++++++++------------
 tools/nfs-iostat/nfsiostat.man | 11 ++++---
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 69d24a11..af04aac5 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -327,7 +327,7 @@ class DeviceData:
             print()
             print('%d congestion waits' % congestionwaits)
 
-    def __print_rpc_op_stats(self, op, sample_time):
+    def __print_rpc_op_stats(self, op, sample_time, use_mb=False):
         """Print generic stats for one RPC op
         """
         if op not in self.__rpc_data:
@@ -343,9 +343,19 @@ class DeviceData:
         if len(rpc_stats) >= 9:
             errs = float(rpc_stats[8])
 
+        # scale to MB if requested
+        if use_mb:
+            throughput = kilobytes / 1024.0
+            throughput_label = 'MB/s'
+            per_op_label = 'MB/op'
+        else:
+            throughput = kilobytes
+            throughput_label = 'kB/s'
+            per_op_label = 'kB/op'
+
         # prevent floating point exceptions
         if ops != 0:
-            kb_per_op = kilobytes / ops
+            unit_per_op = throughput / ops
             retrans_percent = (retrans * 100) / ops
             rtt_per_op = rtt / ops
             exe_per_op = exe / ops
@@ -353,7 +363,7 @@ class DeviceData:
             if len(rpc_stats) >= 9:
                 errs_percent = (errs * 100) / ops
         else:
-            kb_per_op = 0.0
+            unit_per_op = 0.0
             retrans_percent = 0.0
             rtt_per_op = 0.0
             exe_per_op = 0.0
@@ -364,8 +374,8 @@ class DeviceData:
         op += ':'
         print(format(op.lower(), '<16s'), end='')
         print(format('ops/s', '>8s'), end='')
-        print(format('kB/s', '>16s'), end='')
-        print(format('kB/op', '>16s'), end='')
+        print(format(throughput_label, '>16s'), end='')
+        print(format(per_op_label, '>16s'), end='')
         print(format('retrans', '>16s'), end='')
         print(format('avg RTT (ms)', '>16s'), end='')
         print(format('avg exe (ms)', '>16s'), end='')
@@ -375,8 +385,8 @@ class DeviceData:
         print()
 
         print(format((ops / sample_time), '>24.3f'), end='')
-        print(format((kilobytes / sample_time), '>16.3f'), end='')
-        print(format(kb_per_op, '>16.3f'), end='')
+        print(format((throughput / sample_time), '>16.3f'), end='')
+        print(format(unit_per_op, '>16.3f'), end='')
         retransmits = '{0:>10.0f} ({1:>3.1f}%)'.format(retrans, retrans_percent).strip()
         print(format(retransmits, '>16'), end='')
         print(format(rtt_per_op, '>16.3f'), end='')
@@ -395,9 +405,11 @@ class DeviceData:
             sample_time = 1;
         return (sends / sample_time)
 
-    def display_iostats(self, sample_time, which):
+    def display_iostats(self, sample_time, options):
         """Display NFS and RPC stats in an iostat-like way
         """
+        which = options.which
+        use_mb = options.megabytes
         sends = float(self.__rpc_data['rpcsends'])
         if sample_time == 0:
             sample_time = float(self.__nfs_data['age'])
@@ -423,21 +435,21 @@ class DeviceData:
         print()
 
         if which == 0:
-            self.__print_rpc_op_stats('READ', sample_time)
-            self.__print_rpc_op_stats('WRITE', sample_time)
+            self.__print_rpc_op_stats('READ', sample_time, use_mb)
+            self.__print_rpc_op_stats('WRITE', sample_time, use_mb)
         elif which == 1:
-            self.__print_rpc_op_stats('GETATTR', sample_time)
-            self.__print_rpc_op_stats('ACCESS', sample_time)
+            self.__print_rpc_op_stats('GETATTR', sample_time, use_mb)
+            self.__print_rpc_op_stats('ACCESS', sample_time, use_mb)
             self.__print_attr_cache_stats(sample_time)
         elif which == 2:
-            self.__print_rpc_op_stats('LOOKUP', sample_time)
-            self.__print_rpc_op_stats('READDIR', sample_time)
+            self.__print_rpc_op_stats('LOOKUP', sample_time, use_mb)
+            self.__print_rpc_op_stats('READDIR', sample_time, use_mb)
             if 'READDIRPLUS' in self.__rpc_data:
-                self.__print_rpc_op_stats('READDIRPLUS', sample_time)
+                self.__print_rpc_op_stats('READDIRPLUS', sample_time, use_mb)
             self.__print_dir_cache_stats(sample_time)
         elif which == 3:
-            self.__print_rpc_op_stats('READ', sample_time)
-            self.__print_rpc_op_stats('WRITE', sample_time)
+            self.__print_rpc_op_stats('READ', sample_time, use_mb)
+            self.__print_rpc_op_stats('WRITE', sample_time, use_mb)
             self.__print_page_stats(sample_time)
 
         sys.stdout.flush()
@@ -500,7 +512,7 @@ def print_iostat_summary(old, new, devices, time, options):
 
     count = 1
     for device in devices:
-        display_stats[device].display_iostats(time, options.which)
+        display_stats[device].display_iostats(time, options)
 
         count += 1
         if (count > options.list):
@@ -585,6 +597,11 @@ client are listed.
                             type="int",
                             dest="list",
                             help="only print stats for first LIST mount points")
+    displaygroup.add_option('-m', '--megabytes',
+                            action="store_true",
+                            dest="megabytes",
+                            default=False,
+                            help="display throughput in megabytes per second (MB/s) instead of kilobytes per second (kB/s)")
     parser.add_option_group(displaygroup)
 
     (options, args) = parser.parse_args(sys.argv)
diff --git a/tools/nfs-iostat/nfsiostat.man b/tools/nfs-iostat/nfsiostat.man
index 104c7ab4..4f24318d 100644
--- a/tools/nfs-iostat/nfsiostat.man
+++ b/tools/nfs-iostat/nfsiostat.man
@@ -56,16 +56,16 @@ This is the length of the backlog queue.
 .RE
 .RE
 .RS 8
-- \fBkB/s\fR
+- \fBkB/s (MB/s)\fR
 .RS
-This is the number of kB written/read per second.
+This is the number of kB (or MB) written/read per second.
 .RE
 .RE
 .RE
 .RS 8
-- \fBkB/op\fR
+- \fBkB/op (MB/op)\fR
 .RS
-This is the number of kB written/read per each operation.
+This is the number of kB (or MB) written/read per each operation.
 .RE
 .RE
 .RE
@@ -122,6 +122,9 @@ shows help message and exit
 .B \-l LIST or " \-\-list=LIST 
 only print stats for first LIST mount points
 .TP
+.B \-m or " \-\-megabytes
+display throughput in megabytes per second
+.TP
 .B \-p " or " \-\-page
 displays statistics related to the page cache
 .TP
-- 
2.54.0


