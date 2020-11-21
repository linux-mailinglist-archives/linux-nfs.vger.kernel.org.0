Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC832BBDC8
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKUHUI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 02:20:08 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:39400 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgKUHUI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 02:20:08 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Nov 2020 02:20:07 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id D5495540163;
        Sat, 21 Nov 2020 15:11:14 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] nfs: Only include nfs42.h when NFS_V4_2 enable
Date:   Sat, 21 Nov 2020 15:11:09 +0800
Message-Id: <1605942669-585-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSktLTx4ZGhkaHklKVkpNS05CT0lNTE5KTUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hOT1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Ljo4Tz8ZNwI6AVYtMDQM
        HBcwCxFVSlVKTUtOQk9JTUxOTE1OVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKSUNCNwY+
X-HM-Tid: 0a75e9a48668b038kuuud5495540163
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove duplicate header unnecessary.
Only include nfs42.h when NFS_V4_2 enable.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b..a1321a5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -67,7 +67,6 @@
 #include "nfs4idmap.h"
 #include "nfs4session.h"
 #include "fscache.h"
-#include "nfs42.h"
 
 #include "nfs4trace.h"
 
-- 
2.7.4

