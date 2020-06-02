Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2C1EB884
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2020 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgFBJ32 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jun 2020 05:29:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbgFBJ32 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Jun 2020 05:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591090167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ghOmR0rtwYZQtRKS5M+qGGuZT87LH+UqMCpWfquFVss=;
        b=CO9dbCcjxitW9QfhAj9YnxDFFHm0/usOPzisCJOFlBFSR4ct6AHs11A3Yoxb5dAlgSUnEZ
        9nkKoYbwiQ9V79CS1uG1VMLqE6PhL2z4zHYO5CTKGNcE+oB6etO81l0x3UyhHOeediNchk
        f7lMp3BtipJiZWS28RfZmju8yiuPcuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-pz5rxK7kM4aa62sVZxRxsQ-1; Tue, 02 Jun 2020 05:29:25 -0400
X-MC-Unique: pz5rxK7kM4aa62sVZxRxsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A19C3801504
        for <linux-nfs@vger.kernel.org>; Tue,  2 Jun 2020 09:29:24 +0000 (UTC)
Received: from fedora.rsable.com (unknown [10.74.9.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 433155C1C5;
        Tue,  2 Jun 2020 09:29:23 +0000 (UTC)
Date:   Tue, 2 Jun 2020 14:59:19 +0530
From:   Rohan Sable <rsable@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     rsable@redhat.com, steved@redhat.com
Subject: [PATCH] mountstats: Adding Day:Hour:Min:Sec format along with age to
 "mountstats --raw" for ease of understanding.
Message-ID: <20200602092919.GA42177@fedora.rsable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The output will look something like this :

From :
age:    2215

To   :
age:    2267; 0 Day(s) 0 Hour(s) 37 Min(s) 47 Sec(s)

Signed-off-by: Rohan Sable <rsable@redhat.com>
---
 tools/mountstats/mountstats.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 6ac83ccb..d9b5af1b 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -228,6 +228,15 @@ Nfsv4ops = [
     'CLONE'
 ]
 
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
@@ -349,7 +358,8 @@ class DeviceData:
             (self.__nfs_data['export'], self.__nfs_data['mountpoint'], \
             self.__nfs_data['fstype'], self.__nfs_data['statvers']))
         print('\topts:\t%s' % ','.join(self.__nfs_data['mountoptions']))
-        print('\tage:\t%d' % self.__nfs_data['age'])
+        print('\tage:\t%d' % self.__nfs_data['age'], end="; ")
+        sec_conv(self.__nfs_data['age'])
         print('\tcaps:\t%s' % ','.join(self.__nfs_data['servercapabilities']))
         print('\tsec:\tflavor=%d,pseudoflavor=%d' % (self.__nfs_data['flavor'], \
             self.__nfs_data['pseudoflavor']))
-- 
2.25.4

