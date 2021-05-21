Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1186E38BDF0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhEUFsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 01:48:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:44220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhEUFsD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 01:48:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6F27AC87;
        Fri, 21 May 2021 05:46:39 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Tom Haynes <loghyr@hammerspace.com>,
        "Yong Sun (Sero)" <yosun@suse.com>
Subject: [PATCH pynfs 1/2] st_flex: Fix comparison operator, compare int
Date:   Fri, 21 May 2021 07:46:32 +0200
Message-Id: <20210521054633.3170-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It fixes Python 3 warning:
    nfs4.1/server41tests/st_flex.py:618: SyntaxWarning: "is not" with a literal. Did you mean "!="?
      if nfsstat4[res.status] is not 'NFS4_OK':

0bfa03c correctly changed NFS4_OK to string, as nfsstat4 dictionary
values are strings, but comparator was not changed.

But instead of just changing operator to '!=' also use res.status
directly thus we can compare with NFS4_OK (int variable) instead of
"NFS4_OK" (string literal => typos not detected).

Fixes: 0bfa03c ("st_flex: Fixup check for error in layoutget_return()")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 nfs4.1/server41tests/st_flex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 169db69..766b213 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -615,7 +615,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
                         0, NFS4_MAXFILELEN, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res, allowed_errors)
-    if nfsstat4[res.status] is not 'NFS4_OK':
+    if res.status != NFS4_OK:
         return [res] # We can't return the layout without a stateid!
     layout_stateid = res.resarray[-1].logr_stateid
 
-- 
2.31.1

