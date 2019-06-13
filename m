Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECB43B04
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfFMPZV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 11:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731563AbfFMMDQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 Jun 2019 08:03:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E23081DEB;
        Thu, 13 Jun 2019 12:03:16 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 486111001B17;
        Thu, 13 Jun 2019 12:03:16 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, SteveD@RedHat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] mountstats: Add per-op error counts to iostat command when RPC iostats version >= 1.1
Date:   Thu, 13 Jun 2019 08:03:13 -0400
Message-Id: <20190613120314.1864-2-dwysocha@redhat.com>
In-Reply-To: <20190613120314.1864-1-dwysocha@redhat.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
 <20190613120314.1864-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 12:03:16 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This replicates the functionality in the nfsiostat command.
---
 tools/mountstats/mountstats.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 2f525f4b..5f13bf8e 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -607,6 +607,8 @@ class DeviceData:
         queued_for = float(rpc_stats[5])
         rtt = float(rpc_stats[6])
         exe = float(rpc_stats[7])
+        if self.__rpc_data['statsvers'] >= 1.1:
+            errs = int(rpc_stats[8])
 
         # prevent floating point exceptions
         if ops != 0:
@@ -615,6 +617,8 @@ class DeviceData:
             rtt_per_op = rtt / ops
             exe_per_op = exe / ops
             queued_for_per_op = queued_for / ops
+            if self.__rpc_data['statsvers'] >= 1.1:
+                errs_percent = (errs * 100) / ops
         else:
             kb_per_op = 0.0
             retrans_percent = 0.0
@@ -630,7 +634,10 @@ class DeviceData:
         print(format('retrans', '>16s'), end='')
         print(format('avg RTT (ms)', '>16s'), end='')
         print(format('avg exe (ms)', '>16s'), end='')
-        print(format('avg queue (ms)', '>16s'))
+        print(format('avg queue (ms)', '>16s'), end='')
+        if self.__rpc_data['statsvers'] >= 1.1:
+            print(format('errors', '>16s'), end='')
+        print()
 
         print(format((ops / sample_time), '>24.3f'), end='')
         print(format((kilobytes / sample_time), '>16.3f'), end='')
@@ -639,7 +646,11 @@ class DeviceData:
         print(format(retransmits, '>16'), end='')
         print(format(rtt_per_op, '>16.3f'), end='')
         print(format(exe_per_op, '>16.3f'), end='')
-        print(format(queued_for_per_op, '>16.3f'))
+        print(format(queued_for_per_op, '>16.3f'), end='')
+        if self.__rpc_data['statsvers'] >= 1.1:
+            errors = '{0:>10.0f} ({1:>3.1f}%)'.format(errs, errs_percent).strip()
+            print(format(errors, '>16'), end='')
+        print()
 
     def display_iostats(self, sample_time):
         """Display NFS and RPC stats in an iostat-like way
-- 
2.20.1

