Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73D27890D
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 15:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgIYNH7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgIYNH7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 09:07:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D5C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 06:07:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CE690C56; Fri, 25 Sep 2020 09:07:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CE690C56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601039278;
        bh=fOeRm4EL2TuNfi2z68lm6oxqa0/ztau0G/0o1CNKvOc=;
        h=Date:To:Subject:From:From;
        b=yfYVVqE2+E8uGLwhCzXc8o5L9KpgTEfMaSL3K7pSe2kZ6QsJiOUk/F9u2RyWevBYa
         VR/zfgAG0zUcsFXuCpxCmiGHpxaLbXljkBU7CSzjf8GeSKctOwmG9wk6qk+9RbQyBm
         6g+BCLrzsaZRxa/19GxXwCPY33e/BhnghdsGxQYQ=
Date:   Fri, 25 Sep 2020 09:07:58 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Cache R, RW, and W opens separately
Message-ID: <20200925130758.GB1096@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The nfsd open code has always kept separate read-only, read-write, and
write-only opens as necessary to ensure that when a client closes or
downgrades, we don't retain more access than necessary.

Also, I didn't realize the cache behaved this way when I wrote
94415b06eb8a "nfsd4: a client's own opens needn't prevent delegations".
There I assumed fi_fds[O_WRONLY] and fi_fds[O_RDWR] would always be
distinct.  The violation of that assumption is triggering a
WARN_ON_ONCE() and could also cause the server to give out a delegation
when it shouldn't.

Fixes: 94415b06eb8a ("nfsd4: a client's own opens needn't prevent delegations")
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c8b9d2667ee6..3c6c2f7d1688 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -889,7 +889,7 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
 
 	hlist_for_each_entry_rcu(nf, &nfsd_file_hashtbl[hashval].nfb_head,
 				 nf_node, lockdep_is_held(&nfsd_file_hashtbl[hashval].nfb_lock)) {
-		if ((need & nf->nf_may) != need)
+		if (nf->nf_may != need)
 			continue;
 		if (nf->nf_inode != inode)
 			continue;
-- 
2.26.2

