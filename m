Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA738BDF1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhEUFsE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 01:48:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhEUFsD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 01:48:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6F6BAC8F;
        Fri, 21 May 2021 05:46:39 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Tom Haynes <loghyr@hammerspace.com>,
        "Yong Sun (Sero)" <yosun@suse.com>
Subject: [PATCH pynfs 2/2] 4.1 server: Compare with int variable instead of string
Date:   Fri, 21 May 2021 07:46:33 +0200
Message-Id: <20210521054633.3170-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521054633.3170-1-pvorel@suse.cz>
References: <20210521054633.3170-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Similarly to previous commit prefer using int variables
(e.g. NFS4_OK) than string literals (e.g. "NFS4_OK"),
which don't detect typos.

This requires to change status parameter of show_op()
from string to int.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 nfs4.1/nfs4server.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
index 6f7d10c..9422481 100755
--- a/nfs4.1/nfs4server.py
+++ b/nfs4.1/nfs4server.py
@@ -515,8 +515,8 @@ class SummaryOutput:
 
         summary_line = "  %s" % ', '.join(opnames)
 
-        if status != "NFS4_OK" and status != "NFS3_OK":
-            summary_line += " -> %s" % (status,)
+        if status != NFS4_OK and status != NFS3_OK:
+            summary_line += " -> %s" % nfsstat4[status]
 
         print_summary_line = True
         if summary_line != self._last or role != self._last_role:
@@ -850,7 +850,7 @@ class NFS4Server(rpc.Server):
         log_41.info("Replying.  Status %s (%d)" % (nfsstat4[status], status))
         client_addr = '%s:%s' % cred.connection._s.getpeername()[:2]
         self.summary.show_op('handle v4.1 %s' % client_addr,
-                             opnames, nfsstat4[status])
+                             opnames, status)
         return env
 
     def delete_session(self, session, sessionid):
-- 
2.31.1

