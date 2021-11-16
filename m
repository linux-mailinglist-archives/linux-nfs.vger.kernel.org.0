Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA94527F0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357082AbhKPCun (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:50:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357060AbhKPCsl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:48:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60D091FD48;
        Tue, 16 Nov 2021 02:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAFJQqD66lEKxyMF66YMnhf/bOSH3X44K2KcJkng4Uk=;
        b=gbCVQ6bDbY22Q4NrW50evrXT7Ds3nDI8NTZ9Io9sBz8NoaC8jFFX4LTn9aA2PckSz94ueJ
        SvWZN4rSfdqNgtdqvCb3r6IMZTWyB8yR622TKV5wwN3g9rx4EO5seoFCc3Xi4NO3yH5dFZ
        v5umM8wYEzG+99gUwLsGHV5PyxHV710=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030744;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAFJQqD66lEKxyMF66YMnhf/bOSH3X44K2KcJkng4Uk=;
        b=mqZ30JPHIzdhcGRAwSZF5MRmu7hx8qlwHnCXFyzSJrWYCq8+8g8lNDIo44ZDQDQku5U0lR
        tfeimJ8vg5wpEbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A16A13B70;
        Tue, 16 Nov 2021 02:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jzimLlUbk2HNCAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:45:41 +0000
Subject: [PATCH 02/13] NFS: do not take i_rwsem for swap IO
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064452.25805.5738767545414940042.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Taking the i_rwsem for swap IO triggers lockdep warnings regarding
possible deadlocks with "fs_reclaim".  These deadlocks could, I believe,
eventuate if a buffered read on the swapfile was attempted.

We don't need coherence with the page cache for a swap file, and
buffered writes are forbidden anyway.  There is no other need for
i_rwsem during direct IO.

So don't take the rwsem or set the NFS_INO_ODIRECT flag during IO to the
swap file.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/io.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index b5551ed8f648..83b4dfbb826d 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -118,11 +118,18 @@ static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
  * NFS_INO_ODIRECT.
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
+ *
+ * When inode IS_SWAPFILE we ignore the flag and don't take the rwsem
+ * as it triggers lockdep warnings and possible deadlocks.
+ * bufferred writes are forbidden anyway, and buffered reads will not
+ * be coherent.
  */
 void
 nfs_start_io_direct(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	if (IS_SWAPFILE(inode))
+		return;
 	/* Be an optimist! */
 	down_read(&inode->i_rwsem);
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) != 0)
@@ -144,5 +151,7 @@ nfs_start_io_direct(struct inode *inode)
 void
 nfs_end_io_direct(struct inode *inode)
 {
+	if (IS_SWAPFILE(inode))
+		return;
 	up_read(&inode->i_rwsem);
 }


