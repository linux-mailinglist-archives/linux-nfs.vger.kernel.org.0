Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F528B92
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfEWUdq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 16:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387544AbfEWUdq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 16:33:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40DC47FDFD
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 20:33:46 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E0EE5B686
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 20:33:45 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] mountstats: add per-op error counts for mountstats command
Date:   Thu, 23 May 2019 16:33:44 -0400
Message-Id: <20190523203344.12487-1-dwysocha@redhat.com>
In-Reply-To: <20190523201351.12232-4-dwysocha@redhat.com>
References: <20190523201351.12232-4-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 23 May 2019 20:33:46 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Display the count of ops completing with error status (status < 0)
on kernels that support it.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 tools/mountstats/mountstats.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index c7fb8bb1..2f525f4b 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -475,7 +475,9 @@ class DeviceData:
                 retrans = stats[2] - count
                 if retrans != 0:
                     print('\t%d retrans (%d%%)' % (retrans, ((retrans * 100) / count)), end=' ')
-                    print('\t%d major timeouts' % stats[3])
+                    print('\t%d major timeouts' % stats[3], end='')
+                if len(stats) >= 10 and stats[9] != 0:
+                    print('\t%d errors (%d%%)' % (stats[9], ((stats[9] * 100) / count)))
                 else:
                     print('')
                 print('\tavg bytes sent per op: %d\tavg bytes received per op: %d' % \
-- 
2.20.1

