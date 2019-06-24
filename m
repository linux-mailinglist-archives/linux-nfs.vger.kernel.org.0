Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B894451CF8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2019 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfFXVQu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jun 2019 17:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfFXVQu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 24 Jun 2019 17:16:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E444E4E938;
        Mon, 24 Jun 2019 21:16:44 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94A486012C;
        Mon, 24 Jun 2019 21:16:43 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, SteveD@RedHat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] mountstats: Add per-op error counts to iostat command when RPC iostats version >= 1.1
Date:   Mon, 24 Jun 2019 17:16:39 -0400
Message-Id: <20190624211639.22511-2-dwysocha@redhat.com>
In-Reply-To: <20190624211639.22511-1-dwysocha@redhat.com>
References: <20190624211639.22511-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 24 Jun 2019 21:16:49 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With RPC iostats 1.1 there is a new metric which counts the RPCs
completing with errors (tk_status < 0).  Add these to the output at
the end of the line.  This increases the length of an output line
to 136 columns from 120, but keeps consistent format and spacing:

read:              ops/s            kB/s           kB/op         retrans    avg RTT (ms)    avg exe (ms)  avg queue (ms)          errors
                   0.000           0.106         512.316        0 (0.0%)          17.500          17.500           0.000        0 (0.0%)
write:             ops/s            kB/s           kB/op         retrans    avg RTT (ms)    avg exe (ms)  avg queue (ms)          errors
                   0.001           0.476         512.398        0 (0.0%)           1.667           5.778           3.889       1 (11.1%)

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 tools/mountstats/mountstats.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 2f525f4b..c5e8f506 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -607,6 +607,8 @@ class DeviceData:
         queued_for = float(rpc_stats[5])
         rtt = float(rpc_stats[6])
         exe = float(rpc_stats[7])
+        if len(rpc_stats) >= 9:
+            errs = int(rpc_stats[8])
 
         # prevent floating point exceptions
         if ops != 0:
@@ -615,12 +617,15 @@ class DeviceData:
             rtt_per_op = rtt / ops
             exe_per_op = exe / ops
             queued_for_per_op = queued_for / ops
+            if len(rpc_stats) >= 9:
+                errs_percent = (errs * 100) / ops
         else:
             kb_per_op = 0.0
             retrans_percent = 0.0
             rtt_per_op = 0.0
             exe_per_op = 0.0
             queued_for_per_op = 0.0
+            errs_percent = 0.0
 
         op += ':'
         print(format(op.lower(), '<16s'), end='')
@@ -630,7 +635,10 @@ class DeviceData:
         print(format('retrans', '>16s'), end='')
         print(format('avg RTT (ms)', '>16s'), end='')
         print(format('avg exe (ms)', '>16s'), end='')
-        print(format('avg queue (ms)', '>16s'))
+        print(format('avg queue (ms)', '>16s'), end='')
+        if len(rpc_stats) >= 9:
+            print(format('errors', '>16s'), end='')
+        print()
 
         print(format((ops / sample_time), '>24.3f'), end='')
         print(format((kilobytes / sample_time), '>16.3f'), end='')
@@ -639,7 +647,11 @@ class DeviceData:
         print(format(retransmits, '>16'), end='')
         print(format(rtt_per_op, '>16.3f'), end='')
         print(format(exe_per_op, '>16.3f'), end='')
-        print(format(queued_for_per_op, '>16.3f'))
+        print(format(queued_for_per_op, '>16.3f'), end='')
+        if len(rpc_stats) >= 9:
+            errors = '{0:>10.0f} ({1:>3.1f}%)'.format(errs, errs_percent).strip()
+            print(format(errors, '>16'), end='')
+        print()
 
     def display_iostats(self, sample_time):
         """Display NFS and RPC stats in an iostat-like way
-- 
2.20.1

