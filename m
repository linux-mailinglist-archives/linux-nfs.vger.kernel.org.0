Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F461EE9CE
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgFDRwk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 13:52:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34696 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730055AbgFDRwk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 13:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591293159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=S9iZfWJrB+9moUoHggnaqXbY0sHJ1DcOOa+Vq49+qao=;
        b=BNlsQiK0TNKkzOGtjVxRELMrW7RjT41Oz1vedej+TEzrGixrUJRs63SouJWNGJBL78pN2S
        3ugk3y/BF6FHKbDRdJwiCzW4Ft5hK3yvNnYCGxMRglYlFFjjoacy1D6K4HkqCvEEyUVnkP
        IWBWpXDvxBucGuWfe3gdv569/Fqkg+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-yGpgS6rlPF-TQn0_MNkIRA-1; Thu, 04 Jun 2020 13:52:37 -0400
X-MC-Unique: yGpgS6rlPF-TQn0_MNkIRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9101D1B18BCE
        for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2020 17:52:34 +0000 (UTC)
Received: from fedora.rsable.com (unknown [10.74.9.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A942A5D9D3;
        Thu,  4 Jun 2020 17:52:25 +0000 (UTC)
Date:   Thu, 4 Jun 2020 23:22:21 +0530
From:   Rohan Sable <rsable@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     rsable@redhat.com, steved@redhat.com, smayhew@redhat.com
Subject: [PATCH v2] mountstats: Adding 'Day:Hour:Min:Sec' format along with
 'age' to "mountstats --nfs" for ease of understanding.
Message-ID: <20200604175221.GA157967@fedora.rsable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch adds printing of 'Age' in 'Sec' and 'Day:Hours:Min:Sec' like below to --nfs in mountstats :
NFS mount age: 9479; 0 Day(s) 2 Hour(s) 37 Min(s) 59 Sec(s)

Signed-off-by: Rohan Sable <rsable@redhat.com>
---
 tools/mountstats/mountstats.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index d565385d..c4f4f9e6 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -233,6 +233,16 @@ Nfsv4ops = [
     'COPY_NOTIFY'
 ]
 
+# Function to convert sec from age to Day:Hours:Min:Sec.
+def sec_conv(rem):
+    day = int(rem / (24 * 3600))
+    rem %= (24 * 3600)
+    hrs = int(rem / 3600)
+    rem %= 3600
+    min = int(rem / 60)
+    sec = rem % 60
+    print(day, "Day(s)", hrs, "Hour(s)", min, "Min(s)", sec, "Sec(s)")
+
 class DeviceData:
     """DeviceData objects provide methods for parsing and displaying
     data for a single mount grabbed from /proc/self/mountstats
@@ -391,6 +401,8 @@ class DeviceData:
         """Pretty-print the NFS options
         """
         print('  NFS mount options: %s' % ','.join(self.__nfs_data['mountoptions']))
+        print('  NFS mount age: %d' % self.__nfs_data['age'], end="; ")
+        sec_conv(self.__nfs_data['age'])
         print('  NFS server capabilities: %s' % ','.join(self.__nfs_data['servercapabilities']))
         if 'nfsv4flags' in self.__nfs_data:
             print('  NFSv4 capability flags: %s' % ','.join(self.__nfs_data['nfsv4flags']))
-- 
2.25.4

