Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBE1EFBCD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFEOs5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 10:48:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728056AbgFEOs5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jun 2020 10:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591368536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JimWbZdPxgL41S6TgRBogCenu3BX6JX1o1lvoUnJrlQ=;
        b=Gd9Z5OfMwdpLITpmQ6EmBSlccdAZuvNdsZoFXttNdKXrFzc396AUzEsln3o/Sf7YgMz/SC
        GSt/138SjU6wh1fd6NpyJhGNlqclhz24IevgHxOX5/x+6iR1nGL+9d1hj10X13vkrFtugA
        J9k4Ap9U9BYmm0DO4Hfry2dPHlkEM+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Mr3TmXMPPwKNW2DPwhw30Q-1; Fri, 05 Jun 2020 10:48:54 -0400
X-MC-Unique: Mr3TmXMPPwKNW2DPwhw30Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7161BEC1B9;
        Fri,  5 Jun 2020 14:48:53 +0000 (UTC)
Received: from fedora.rsable.com (unknown [10.74.9.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ADC81001B07;
        Fri,  5 Jun 2020 14:48:38 +0000 (UTC)
Date:   Fri, 5 Jun 2020 20:18:35 +0530
From:   Rohan Sable <rsable@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     rsable@redhat.com, steved@redhat.com, smayhew@redhat.com,
        chuck.lever@oracle.com
Subject: [PATCH v3] mountstats: Adding 'Day, Hour:Min:Sec' to "mountstats
 --nfs" for ease of understanding.
Message-ID: <20200605144835.GA98618@fedora.rsable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch adds printing of 'Days, Hours:Mins:Sec' like below to --nfs in mountstats :
NFS mount age : 12 days, 23:59:59

Signed-off-by: Rohan Sable <rsable@redhat.com>
---
 tools/mountstats/mountstats.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index d565385d..014f38a3 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -4,6 +4,7 @@
 """
 
 from __future__ import print_function
+import datetime as datetime
 
 __copyright__ = """
 Copyright (C) 2005, Chuck Lever <cel@netapp.com>
@@ -391,6 +392,7 @@ class DeviceData:
         """Pretty-print the NFS options
         """
         print('  NFS mount options: %s' % ','.join(self.__nfs_data['mountoptions']))
+        print('  NFS mount age: %s' % datetime.timedelta(seconds = self.__nfs_data['age']))
         print('  NFS server capabilities: %s' % ','.join(self.__nfs_data['servercapabilities']))
         if 'nfsv4flags' in self.__nfs_data:
             print('  NFSv4 capability flags: %s' % ','.join(self.__nfs_data['nfsv4flags']))
-- 
2.25.4

