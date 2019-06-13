Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37CF43AFE
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbfFMPZN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 11:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731567AbfFMMDR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 Jun 2019 08:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FAE43079B9D;
        Thu, 13 Jun 2019 12:03:17 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B03BC1001B19;
        Thu, 13 Jun 2019 12:03:16 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, SteveD@RedHat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] mountstats: Check for RPC iostats version >= 1.1 with error counts
Date:   Thu, 13 Jun 2019 08:03:14 -0400
Message-Id: <20190613120314.1864-3-dwysocha@redhat.com>
In-Reply-To: <20190613120314.1864-1-dwysocha@redhat.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
 <20190613120314.1864-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Jun 2019 12:03:17 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add explicit check for statsvers instead of array based check.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 tools/mountstats/mountstats.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 5f13bf8e..2ebbf945 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -476,7 +476,7 @@ class DeviceData:
                 if retrans != 0:
                     print('\t%d retrans (%d%%)' % (retrans, ((retrans * 100) / count)), end=' ')
                     print('\t%d major timeouts' % stats[3], end='')
-                if len(stats) >= 10 and stats[9] != 0:
+                if self.__rpc_data['statsvers'] >= 1.1 and stats[9] != 0:
                     print('\t%d errors (%d%%)' % (stats[9], ((stats[9] * 100) / count)))
                 else:
                     print('')
-- 
2.20.1

