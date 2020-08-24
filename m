Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC6250060
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXPFw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 11:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgHXPFu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 11:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598281542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yhj50m+yp5TG5axwoQvzJyWGAe0F2L0Acoom68/W02k=;
        b=bCEyP7JR2+zatoM6x1SzU5tzJqBpVqjH55LynMoZ7O4xW5hhr3t02PKfwoq9ZpQWqiwzUJ
        fe2ICZ6L3F7o9uqZboRXmlszJPcQM9N5BZg7jJO12iSu6KuIYraQJocug2AUvXSeQ0I39V
        mpjHp7ktW7afR+y7+vy8QTmFZ6R5LMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-xnuSWAn2Oy6gixe8uJnLUw-1; Mon, 24 Aug 2020 11:05:39 -0400
X-MC-Unique: xnuSWAn2Oy6gixe8uJnLUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106711007463
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 15:05:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.74.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7BF6FDB6;
        Mon, 24 Aug 2020 15:05:37 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     kdsouza@redhat.com, SteveD@redhat.com
Subject: [PATCH] nfs-iostat: divide by zero with fresh mount
Date:   Mon, 24 Aug 2020 20:35:35 +0530
Message-Id: <20200824150535.15224-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When an export is freshly mounted, /proc/self/mountstats displays age = 0.
This causes nfs-iostat to divide by zero throwing an error.
When we have age = 0, other stats are greater than 0, so we'll set age = 1 and
print the relevant stats.

This will prevent a backtrace like this from occurring if nfsiostat is run.

nfsiostat -s 1
Traceback (most recent call last):
  File "/usr/sbin/nfsiostat", line 662, in <module>
    iostat_command(prog)
  File "/usr/sbin/nfsiostat", line 644, in iostat_command
    print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
  File "/usr/sbin/nfsiostat", line 490, in print_iostat_summary
    devicelist.sort(key=lambda x: stats[x].ops(time), reverse=True)
  File "/usr/sbin/nfsiostat", line 490, in <lambda>
    devicelist.sort(key=lambda x: stats[x].ops(time), reverse=True)
  File "/usr/sbin/nfsiostat", line 383, in ops
    return (sends / sample_time)
ZeroDivisionError: float division by zero

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 5556f692..0c6c6dda 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -383,6 +383,8 @@ class DeviceData:
         sends = float(self.__rpc_data['rpcsends'])
         if sample_time == 0:
             sample_time = float(self.__nfs_data['age'])
+        if sample_time == 0:
+            sample_time = 1;
         return (sends / sample_time)
 
     def display_iostats(self, sample_time, which):
-- 
2.21.3

