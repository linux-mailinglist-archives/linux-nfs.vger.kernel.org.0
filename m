Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6168D427A1C
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Oct 2021 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhJIM3Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Oct 2021 08:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232926AbhJIM3Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Oct 2021 08:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633782448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=YrqipSYiuTCNeWzdDWJ6voqxA3tZPk/A8qaCiJQ9C1M=;
        b=Ue6YWyAf9YLbJRd6X30IiWQM8P5L8dGDXXoLZnDysOkiI/hrPdQ7q8qu+31kPe8MvL+NjI
        v71f0x3/dHLUEmF7kmCT3cb6j6K+0EJHEfvTL49ypROz0wVSvK/ZhaDqwDvr1HamXeP4WE
        +gTKfAXw/VK+aOkBt8hbBuyEXIXy1rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-9ef-sI5XNoWYgl3YTCOV7Q-1; Sat, 09 Oct 2021 08:27:27 -0400
X-MC-Unique: 9ef-sI5XNoWYgl3YTCOV7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3F21006AA6;
        Sat,  9 Oct 2021 12:27:26 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D727360C05;
        Sat,  9 Oct 2021 12:27:25 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] nfsiostat: Handle both readahead counts for statsver >= 1.2
Date:   Sat,  9 Oct 2021 08:27:21 -0400
Message-Id: <1633782441-17839-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633782441-17839-1-git-send-email-dwysocha@redhat.com>
References: <1633782441-17839-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Later kernel versions convert NFS readpages to readahead so update
the counts accordingly.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 1df74ba822b5..85294fb9448c 100755
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
@@ -86,14 +86,14 @@ class DeviceData:
             self.__nfs_data['export'] = words[1]
             self.__nfs_data['mountpoint'] = words[4]
             self.__nfs_data['fstype'] = words[7]
-            if words[7] == 'nfs':
-                self.__nfs_data['statvers'] = words[8]
+            if words[7] == 'nfs' or words[7] == 'nfs4':
+                self.__nfs_data['statvers'] = float(words[8].split('=',1)[1])
         elif 'nfs' in words or 'nfs4' in words:
             self.__nfs_data['export'] = words[0]
             self.__nfs_data['mountpoint'] = words[3]
             self.__nfs_data['fstype'] = words[6]
             if words[6] == 'nfs':
-                self.__nfs_data['statvers'] = words[7]
+                self.__nfs_data['statvers'] = float(words[7].split('=',1)[1])
         elif words[0] == 'age:':
             self.__nfs_data['age'] = int(words[1])
         elif words[0] == 'opts:':
@@ -294,8 +294,11 @@ class DeviceData:
         print()
         print('%d nfs_readpage() calls read %d pages' % \
             (vfsreadpage, vfsreadpage))
-        print('%d nfs_readpages() calls read %d pages' % \
-            (vfsreadpages, pages_read - vfsreadpage))
+        multipageread = "readpages"
+        if self.__nfs_data['statvers'] >= 1.2:
+            multipageread = "readahead"
+        print('%d nfs_%s() calls read %d pages' % \
+            (vfsreadpages, multipageread, pages_read - vfsreadpage))
         if vfsreadpages != 0:
             print('(%.1f pages per call)' % \
                 (float(pages_read - vfsreadpage) / vfsreadpages))
-- 
1.8.3.1

