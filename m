Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5971E13C2
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2020 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbgEYSDS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 May 2020 14:03:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388621AbgEYSDR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 May 2020 14:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590429795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ECNmsRhD8JqR8DT/b8XMdC9ByMNz46FqeCXDiUGAUTE=;
        b=Sjbv3HJxDp+N/fM4haoXwPHQ8Bvd0rq75IgoQ81ES0aLj+d7gRteK4YE/5QGw2heciqUsN
        /UpwrkaegpRVkYMQMXW/PEfa1h9Zg3SaHDgNHPf/qEWt2xwVTKWUlK9VmnOTJ8g2EodpLv
        VF+Z//PzJsfbhkzS60Z8Ge7OhdgSZKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-_J4H3cKIMIm0hwS2zZYvmQ-1; Mon, 25 May 2020 14:03:13 -0400
X-MC-Unique: _J4H3cKIMIm0hwS2zZYvmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5BFE19057AC
        for <linux-nfs@vger.kernel.org>; Mon, 25 May 2020 18:03:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-68.sin2.redhat.com [10.67.116.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 729685D9E5;
        Mon, 25 May 2020 18:03:06 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     SteveD@redhat.com, kdsouza@redhat.com, agaikwad@redhat.com
Subject: [PATCH] nfsdclnts: Add --verbose and --file option.
Date:   Mon, 25 May 2020 23:33:01 +0530
Message-Id: <20200525180301.32192-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add new option --file to process specific states file,
provided the info file resides in the same directory as
states file. If the info file is not valid or present the
fields would be marked as "N/A".

--verbose option will be helpful for debugging purpose.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
---
 tools/nfsdclnts/nfsdclnts.man | 26 +++++++++++++++++++++++++-
 tools/nfsdclnts/nfsdclnts.py  | 32 +++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/tools/nfsdclnts/nfsdclnts.man b/tools/nfsdclnts/nfsdclnts.man
index 3701de9a..c7efbd70 100644
--- a/tools/nfsdclnts/nfsdclnts.man
+++ b/tools/nfsdclnts/nfsdclnts.man
@@ -63,6 +63,18 @@ Print hostname of nfs\-client instead of ip-address.
 Hide the header information.
 .RE
 .sp
+\fB\-v, \-\-verbose\fP
+.RS 4
+Verbose operation, show debug messages.
+.RE
+.sp
+\fB\-f, \-\-file\fP
+.RS 4
+Instead of processing all client directories under /proc/fs/nfsd/clients, one can provide a specific
+states file to process. One should make sure that info file resides in the same directory as states file.
+If the info file is not valid or present the fields would be marked as "N/A".
+.RE
+.sp
 \fB\-h, \-\-help\fP
 .RS 4
 Print help explaining the command line options.
@@ -118,7 +130,19 @@ Inode number | Type   | Access | Deny | ip address            | Client ID
 .fi
 .if n .RE
 .sp
-\fBnfsdclnts.py \-\-quiet \-\-hostname\fP
+\fBnfsdclnts \-\-file /proc/fs/nfsd/clients/3/states -t open\fP
+.RS 4
+Process specific states file.
+.RE
+.sp
+.if n .RS 4
+.nf
+Inode number | Type   | Access | Deny | ip address            | Client ID           | vers | Filename
+33823232     | open   | r\-     | \-\-   | [::1]:757             | 0xc79a009f5eb65e84  | 4.2  | testfile
+.fi
+.if n .RE
+.sp
+\fBnfsdclnts \-\-quiet \-\-hostname\fP
 .RS 4
 Hide the header information.
 .RE
diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
index 7370fede..e5f636a2 100755
--- a/tools/nfsdclnts/nfsdclnts.py
+++ b/tools/nfsdclnts/nfsdclnts.py
@@ -54,10 +54,16 @@ def file_to_dict(path):
                     client_info[key] = val.strip()
                     # FIXME: There has to be a better way of converting the info file to a dictionary.
                 except ValueError as reason:
-                    print('%s' % reason)
+                    if verbose:
+                        print('Exception occured, %s' % reason)
+
+        if len(client_info) == 0 and verbose:
+            print("Provided %s file is not valid" %path)
         return client_info
+
     except OSError as reason:
-        print('%s' % reason)
+        if verbose:
+            print('%s' % reason)
 
 # this function gets the paths from /proc/fs/nfsd/clients/
 # returns a list of paths for each client which has nfs-share mounted.
@@ -159,10 +165,12 @@ def opener(path):
                     data.append(clientinfo)
                 return data
             except:
-                print("Exception occurred, Please make sure %s is a YAML file" %path)
+                if verbose:
+                    print("Exception occurred, Please make sure %s is a YAML file" %path)
 
     except OSError as reason:
-        print('%s' % reason)
+        if verbose:
+            print('%s' % reason)
 
 def print_cols(argument):
     title_inode = 'Inode number'
@@ -204,11 +212,25 @@ def nfsd4_show():
         help = 'output clients information, --hostname is implied.')
     parser.add_argument('--hostname', action = 'store_true',
         help = 'print hostname of client instead of its ip address. Longer hostnames are truncated.')
+    parser.add_argument('-v', '--verbose', action = 'store_true',
+        help = 'Verbose operation, show debug messages.')
+    parser.add_argument('-f', '--file', nargs='+', type = str, metavar='',
+        help = 'pass client states file, provided that info file resides in the same directory.')
     parser.add_argument('-q', '--quiet', action = 'store_true',
         help = 'don\'t print the header information')
 
     args = parser.parse_args()
-    paths = getpaths()
+
+    global verbose
+    verbose = False
+    if args.verbose:
+        verbose = True
+
+    if args.file:
+        paths = args.file
+    else:
+        paths = getpaths()
+
     p = mp.Pool(mp.cpu_count(), init_worker)
     try:
         result = p.map(opener, paths)
-- 
2.21.1

