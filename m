Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E98218C81
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgGHQGT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 12:06:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728148AbgGHQGS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 12:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594224377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f+4NQ7RPt3aYZYFERpD0WoJqo/EAsKGe/BvuDtTDY0Q=;
        b=UmDZsyGUWVqcOLnJNyjfmVhXbDlUztkfP/6/wd84WEiqyPWFBSiWpIi00EiUmtm17IF1dP
        gsSgIIRc2xmksadqjS2ozlFJYtLZ6PPVZj5AddjhaK+y6ALkax1spH10HphbbSsBLRi7T/
        g5ZLUPISTnOApG+j3gyjGHu9JYaiPVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-66VABFpAMu2eFmyGlK9wXw-1; Wed, 08 Jul 2020 12:06:12 -0400
X-MC-Unique: 66VABFpAMu2eFmyGlK9wXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17EA788C79B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 16:06:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.74.10.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 544FE60C80;
        Wed,  8 Jul 2020 16:06:08 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     SteveD@redhat.com, kdsouza@redhat.com
Subject: [PATCH] nfsiostat/mountstats: handle KeyError in compare_iostats()
Date:   Wed,  8 Jul 2020 21:36:06 +0530
Message-Id: <20200708160606.21279-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This will prevent a backtrace like this from occurring if nfsiostat is run
with <interval> <count>, eg: nfsiostat 1 3
This issue can occur if old_stats.__rpc_data['ops'] keys are not up to
date with result.__rpc_data['ops'].
I belive this issue can also affect mountstats due to similar code,
hence fix it too.

nfsiostat:217:compare_iostats:KeyError: 'NULL'

Traceback (most recent call last):
  File "/usr/sbin/nfsiostat", line 649, in <module>
    iostat_command(prog)
  File "/usr/sbin/nfsiostat", line 617, in iostat_command
    print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
  File "/usr/sbin/nfsiostat", line 468, in print_iostat_summary
    diff_stats[device] = stats[device].compare_iostats(old_stats)
  File "/usr/sbin/nfsiostat", line 217, in compare_iostats
    difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
KeyError: 'NULL'

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 tools/mountstats/mountstats.py | 5 ++++-
 tools/nfs-iostat/nfs-iostat.py | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 014f38a3..1054f698 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -560,7 +560,10 @@ class DeviceData:
         # the reference to them.  so we build new lists here
         # for the result object.
         for op in result.__rpc_data['ops']:
-            result.__rpc_data[op] = list(map(difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
+            try:
+                result.__rpc_data[op] = list(map(difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
+            except KeyError:
+                continue
 
         # update the remaining keys
         if protocol == 'udp':
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index b7e98a2a..5556f692 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -213,8 +213,11 @@ class DeviceData:
         # the reference to them.  so we build new lists here
         # for the result object.
         for op in result.__rpc_data['ops']:
-            result.__rpc_data[op] = list(map(
-                difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
+            try:
+                result.__rpc_data[op] = list(map(
+                    difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
+            except KeyError:
+                continue
 
         # update the remaining keys we care about
         result.__rpc_data['rpcsends'] -= old_stats.__rpc_data['rpcsends']
-- 
2.21.1

