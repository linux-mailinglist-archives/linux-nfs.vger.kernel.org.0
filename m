Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86511DED24
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2020 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgEVQWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 May 2020 12:22:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59554 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729903AbgEVQWD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 May 2020 12:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590164521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GwslxaamzAwEeYdz9IQIhJMBJAs4Rf1VRuapQrfMX7I=;
        b=F1l4ma8om/5/+6iZGjLOwMKHhUUsXCrrWujTyasffYF5jT9vjUtUXf06zKsjHYkT1d1wiM
        rWzU1/1Vk1+Idwqmj/PkGxApK4HJYw20nW8OtU7Uil8mmsJL6Ket+nqQ2Rf5+CQ3p+mAxv
        KyWWT4a3l1EK7knb+g30b+MxeP+cyVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-V7Umiz8UOb2rUmNIDSCi3Q-1; Fri, 22 May 2020 12:21:59 -0400
X-MC-Unique: V7Umiz8UOb2rUmNIDSCi3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB77C461
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2020 16:21:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-38.sin2.redhat.com [10.67.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 473E11059123;
        Fri, 22 May 2020 16:21:56 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     SteveD@redhat.com, kdsouza@redhat.com
Subject: [PATCH] nfsdclnts: Handle exceptions gracefully for "info" and "states" file.
Date:   Fri, 22 May 2020 21:51:52 +0530
Message-Id: <20200522162152.27217-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch makes sure that "info" and "states" file are sane.
If "info" file is not sane this patch would populate the fields as "N/A".
This helps us to go ahead and process next "states" file.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 tools/nfsdclnts/nfsdclnts.py | 75 +++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
index 2d0ad0ad..7370fede 100755
--- a/tools/nfsdclnts/nfsdclnts.py
+++ b/tools/nfsdclnts/nfsdclnts.py
@@ -46,19 +46,18 @@ def init_worker():
 # this function converts the info file to a dictionary format, sorta. 
 def file_to_dict(path):
     client_info = {}
-    with open(path) as f:
-        for line in f:
-            try:
-                (key, val) = line.split(':')
-                client_info[key] = val
-    # FIXME: There has to be a better way of converting the info file to a dictionary.
-            except ValueError:
+    try:
+        with open(path) as f:
+            for line in f:
                 try:
-                    (key, val) = line.split()
-                    client_info[key] = val
-                except:
-                    pass
-    return client_info
+                    (key, val) = line.split(':', 1)
+                    client_info[key] = val.strip()
+                    # FIXME: There has to be a better way of converting the info file to a dictionary.
+                except ValueError as reason:
+                    print('%s' % reason)
+        return client_info
+    except OSError as reason:
+        print('%s' % reason)
 
 # this function gets the paths from /proc/fs/nfsd/clients/
 # returns a list of paths for each client which has nfs-share mounted.
@@ -70,10 +69,10 @@ def getpaths():
         exit('%s' % reason)
     if len(dirs) !=0:
 	    for i in dirs:
-		    path.append('/proc/fs/nfsd/clients/' + i + '/states')
+                path.append('/proc/fs/nfsd/clients/' + i + '/states')
 	    return (path)
     else:
-	    exit('Nothing to process')
+        exit('Nothing to process')
 
 # A single function to rule them all, in this function we gather all the data
 # from already populated data_list and client_info.
@@ -83,12 +82,11 @@ def printer(data_list, argument):
     for i in data_list:
         for key in i:
             inode = i[key]['superblock'].split(':')[-1]
-            # get the ip address from client_info as 'address:' note the extra
-            # ':' as a suffix to address. If there is a better way to convert
-            # the file to dictionary, please change the following value too.
-            client_ip = client_info['address:']
             # The ip address is quoted, so we dequote it.
-            client_ip = client_ip[1:-1]
+            try:
+                client_ip = client_info['address'][1:-1]
+            except:
+                client_ip = "N/A"
             try:
                 # if the nfs-server reboots while the nfs-client holds the files open,
                 # the nfs-server would print the filename as '/'. For such instaces we
@@ -110,15 +108,25 @@ def printer(data_list, argument):
                 deny = i[key]['deny']
             except:
                 deny = ''
-            hostname = client_info['name'].split()[-1].split('"')[0]
-            hostname =  hostname.split('.')[0]
+            try:
+                hostname = client_info['name'].split()[-1].split('"')[0]
+                hostname =  hostname.split('.')[0]
+                # if the hostname is too long, it messes up with the output being in columns,
+                # therefore we truncate the hostname followed by two '..' as suffix.
+                if len(hostname) > 20:
+                    hostname = hostname[0:20] + '..'
+            except:
+                hostname = "N/A"
+            try:
+                clientid = client_info['clientid']
+            except:
+                clientid = "N/A"
+            try:
+                minorversion = "4." + client_info['minor version']
+            except:
+                minorversion = "N/A"
+
             otype = i[key]['type']
-            # if the hostname is too long, it messes up with the output being in columns,
-            # therefore we truncate the hostname followed by two '..' as suffix.
-            if len(hostname) > 20:
-                hostname = hostname[0:20] + '..'
-            clientid = client_info['clientid'].strip()
-            minorversion = client_info['minor version'].rstrip().rsplit()[0]
             # since some fields do not have deny column, we drop those if -t is either
             # layout or lock.
             drop = ['layout', 'lock']
@@ -138,17 +146,20 @@ def printer(data_list, argument):
                    print('%-22s' %client_ip, end='| ')
                 if (argument.clientinfo == True) :
                     print('%-20s' %clientid, end='| ')
-                    print('4.%-3s' %minorversion, end='| ')
+                    print('%-5s' %minorversion, end='| ')
                 print(fname)
 
 def opener(path):
     try:
         with open(path, 'r') as nfsdata:
-            data = yaml.load(nfsdata, Loader = yaml.BaseLoader)
-            if data is not None:
-                clientinfo = path.rsplit('/', 1)[0] + '/info'
-                data.append(clientinfo)
+            try:
+                data = yaml.load(nfsdata, Loader = yaml.BaseLoader)
+                if data is not None:
+                    clientinfo = path.rsplit('/', 1)[0] + '/info'
+                    data.append(clientinfo)
                 return data
+            except:
+                print("Exception occurred, Please make sure %s is a YAML file" %path)
 
     except OSError as reason:
         print('%s' % reason)
-- 
2.21.1

