Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113CD257F40
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHaRGt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 13:06:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726791AbgHaRGs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 13:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598893606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=teAZumf1O1ucXI5DEYqItbPuWQNSCGlaPv5fCn8z+rk=;
        b=XVsBst36/B82dnKJoUOPa09dJyVUTi2ZC1Ob9zpUZKbl0ML+otZlUGVPrHQzziY/E9fq69
        DrEsz6fLcb63Ntj0wlDhVewpQeBuJG1i75H2pUwxLIn7H6NUF5Cj+VfFM+PJUEZWcZmpUA
        3YJcnSu1mVWNaq3imQYFYPkv57gTbEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-Viyy7sIOPY2UEMN0d-BQAg-1; Mon, 31 Aug 2020 13:06:44 -0400
X-MC-Unique: Viyy7sIOPY2UEMN0d-BQAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718C21007460
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 17:06:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.74.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D47D478B20;
        Mon, 31 Aug 2020 17:06:41 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, kdsouza@redhat.com
Subject: [PATCH] nfsiostat/mountstats: Drop autofs entries before calling compare_iostats()
Date:   Mon, 31 Aug 2020 22:36:39 +0530
Message-Id: <20200831170639.3962-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsiostat/mountstats can fail with below KeyError when old stat and new stat
data go out of sync.

$ mountstats iostat 1 3

Traceback (most recent call last):
  File "/usr/sbin/mountstats", line 1092, in <module>
    res = main()
  File "/usr/sbin/mountstats", line 1081, in main
    return args.func(args)
  File "/usr/sbin/mountstats", line 965, in iostat_command
    print_iostat_summary(old_mountstats, mountstats, devices, sample_time)
  File "/usr/sbin/mountstats", line 920, in print_iostat_summary
    diff_stats = stats.compare_iostats(old_stats)
  File "/usr/sbin/mountstats", line 528, in compare_iostats
    if old_stats.__nfs_data['age'] > self.__nfs_data['age']:
KeyError: 'age'

Steps to Reproduce:

1> Add autofs mounts in /etc/fstab controlled via systemd.

nfs-server:/test1 /mnt1 nfs noauto,x-systemd.idle-timeout=2,x-systemd.automount 0 0
nfs-server:/test2 /mnt2 nfs noauto,x-systemd.idle-timeout=2,x-systemd.automount 0 0
nfs-server:/test3 /mnt3 nfs noauto,x-systemd.idle-timeout=2,x-systemd.automount 0 0

2> Trigger the mounts via below command:

$ while :; do date; ls -lR /mnt* 2>&1 >/dev/null; sleep 3; done

3> On other terminal run nfsiostat or mountstats command:

$ mountstats iostat 1 3
$ nfsiostat 1 3

Frequent mount and umount can cause autofs entries to be processed in compare_iostats.
We need to filter the devices list and drop autofs entries to fix the issue.
This way we pass only nfs mounts and not autofs entries.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 tools/mountstats/mountstats.py | 9 +++++----
 tools/nfs-iostat/nfs-iostat.py | 5 ++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 00adc96b..25e92a19 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -953,10 +953,11 @@ def print_iostat_summary(old, new, devices, time):
         if not old or device not in old:
             stats.display_iostats(time)
         else:
-            old_stats = DeviceData()
-            old_stats.parse_stats(old[device])
-            diff_stats = stats.compare_iostats(old_stats)
-            diff_stats.display_iostats(time)
+            if ("fstype autofs" not in str(old[device])) and ("fstype autofs" not in str(new[device])):
+                old_stats = DeviceData()
+                old_stats.parse_stats(old[device])
+                diff_stats = stats.compare_iostats(old_stats)
+                diff_stats.display_iostats(time)
 
 def iostat_command(args):
     """iostat-like command for NFS mount points
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 4f5e8a66..1df74ba8 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -470,10 +470,13 @@ def parse_stats_file(filename):
 def print_iostat_summary(old, new, devices, time, options):
     stats = {}
     diff_stats = {}
+    devicelist = []
     if old:
         # Trim device list to only include intersection of old and new data,
         # this addresses umounts due to autofs mountpoints
-        devicelist = [x for x in old if x in devices]
+        for device in devices:
+            if "fstype autofs" not in str(old[device]):
+                devicelist.append(device)
     else:
         devicelist = devices
 
-- 
2.21.3

