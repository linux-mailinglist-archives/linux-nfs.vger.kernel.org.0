Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD4426F8B
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhJHR3o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Oct 2021 13:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhJHR3o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Oct 2021 13:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633714068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kloBSv2DsGFPJBpEDWVi4y8T4BYAAufU4TmNKwDkboI=;
        b=T7/3ZptTmtGOhUF31rwJZVG8rcxqwhmFrh/Wtqyyib1aiiwN7dTJLHyPVAgRyDcN/FvJq3
        5GfxU29JTxGtf1ZT72vaoCY9448BKxKpHBDV5GOtrie5Gm4XBBGqs5u3gINIzgS8sPFJgn
        6bYOL+ry1zSFKax81nGZWyD0EcDAruA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-t00buLk9N22_1SFnghg04Q-1; Fri, 08 Oct 2021 13:27:46 -0400
X-MC-Unique: t00buLk9N22_1SFnghg04Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD42C10A8E08;
        Fri,  8 Oct 2021 17:27:45 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50CFE1007606;
        Fri,  8 Oct 2021 17:27:45 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsiostat: Handle both readahead counts for statsver >= 1.2
Date:   Fri,  8 Oct 2021 13:27:42 -0400
Message-Id: <1633714062-21081-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Later kernel versions convert NFS readpages to readahead so update
the counts accordingly.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 1df74ba822b5..1ddd884faf58 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -43,7 +43,7 @@ NfsEventCounters = [
     'vfspermission',
     'vfsupdatepage',
     'vfsreadpage',
-    'vfsreadpages',
+    'vfsreadpages', # or vfsreadahead in statvers=1.2 or above
     'vfswritepage',
     'vfswritepages',
     'vfsreaddir',
@@ -86,7 +86,7 @@ class DeviceData:
             self.__nfs_data['export'] = words[1]
             self.__nfs_data['mountpoint'] = words[4]
             self.__nfs_data['fstype'] = words[7]
-            if words[7] == 'nfs':
+            if words[7] == 'nfs' or words[7] == 'nfs4':
                 self.__nfs_data['statvers'] = words[8]
         elif 'nfs' in words or 'nfs4' in words:
             self.__nfs_data['export'] = words[0]
@@ -294,8 +294,11 @@ class DeviceData:
         print()
         print('%d nfs_readpage() calls read %d pages' % \
             (vfsreadpage, vfsreadpage))
-        print('%d nfs_readpages() calls read %d pages' % \
-            (vfsreadpages, pages_read - vfsreadpage))
+        multipageread = "readpages"
+        if float(self.__nfs_data['statvers'].split('=',1)[1]) >= 1.2:
+            multipageread = "readahead"
+        print('%d nfs_%s() calls read %d pages' % \
+            (vfsreadpages, multipageread, pages_read - vfsreadpage))
         if vfsreadpages != 0:
             print('(%.1f pages per call)' % \
                 (float(pages_read - vfsreadpage) / vfsreadpages))
-- 
1.8.3.1

