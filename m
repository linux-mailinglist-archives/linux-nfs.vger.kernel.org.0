Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE104EB73A
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiC2Xzz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiC2Xym (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:54:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFC24E247;
        Tue, 29 Mar 2022 16:52:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F6AF218F9;
        Tue, 29 Mar 2022 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE32eedhCbqKNV/qzY0QU0j1sD/lbIXfPgDh2Z7fRTs=;
        b=npmS5Rtdt/vjDg9rTITOYuf0u/0wOAROyuYict0Yx8Rlg5aAG7crOrIyOIn5n7L9jpR+l3
        xRm3PhCNFMQsJ0ujiDy2L6oYKm1FM94lty/8pH2WSGM5CMs0tIlhDERpH4jI7U4LC8JfcK
        joM92dZM0iUmJ2/asLXy8NyVeEpzxLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE32eedhCbqKNV/qzY0QU0j1sD/lbIXfPgDh2Z7fRTs=;
        b=3wC0HgxOOEeD/3T3+oCgunZQv+J+1MqE6Bd8mMwtFdIWZsqNC9klDTo+16h0XLvnTbFdk4
        MQLIjNp7nPKQUXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4922A13A7E;
        Tue, 29 Mar 2022 23:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nFx+ArGbQ2JILwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:52:17 +0000
Subject: [PATCH 07/10] DOC: update documentation for swap_activate and swap_rw
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778126.29473.6778751233552859461.stgit@noble.brown>
In-Reply-To: <164859751830.29473.5309689752169286816.stgit@noble.brown>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This documentation for ->swap_activate() has been out-of-date for a long
time.  This patch updates it to match recent changes, and adds
documentation for the associated ->swap_rw()

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/filesystems/locking.rst |   18 ++++++++++++------
 Documentation/filesystems/vfs.rst     |   17 ++++++++++++-----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2998cec9af4b..009d855c9be5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -260,8 +260,9 @@ prototypes::
 	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
 	int (*error_remove_page)(struct address_space *, struct page *);
-	int (*swap_activate)(struct file *);
+	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 	int (*swap_deactivate)(struct file *);
+	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 
 locking rules:
 	All except dirty_folio and freepage may block
@@ -290,6 +291,7 @@ is_partially_uptodate:	yes
 error_remove_page:	yes
 swap_activate:		no
 swap_deactivate:	no
+swap_rw:		yes, unlocks
 ======================	======================== =========	===============
 
 ->write_begin(), ->write_end() and ->readpage() may be called from
@@ -392,15 +394,19 @@ cleaned, or an error value if not. Note that in order to prevent the folio
 getting mapped back in and redirtied, it needs to be kept locked
 across the entire operation.
 
-->swap_activate will be called with a non-zero argument on
-files backing (non block device backed) swapfiles. A return value
-of zero indicates success, in which case this file can be used for
-backing swapspace. The swapspace operations will be proxied to the
-address space operations.
+->swap_activate() will be called to prepare the given file for swap.  It
+should perform any validation and preparation necessary to ensure that
+writes can be performed with minimal memory allocation.  It should call
+add_swap_extent(), or the helper iomap_swapfile_activate(), and return
+the number of extents added.  If IO should be submitted through
+->swap_rw(), it should set SWP_FS_OPS, otherwise IO will be submitted
+directly to the block device ``sis->bdev``.
 
 ->swap_deactivate() will be called in the sys_swapoff()
 path after ->swap_activate() returned success.
 
+->swap_rw will be called for swap IO if SWP_FS_OPS was set by ->swap_activate().
+
 file_lock_operations
 ====================
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4f14edf93941..9d3480e089f6 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -751,8 +751,9 @@ cache in your filesystem.  The following members are defined:
 					       size_t count);
 		void (*is_dirty_writeback) (struct page *, bool *, bool *);
 		int (*error_remove_page) (struct mapping *mapping, struct page *page);
-		int (*swap_activate)(struct file *);
+		int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 		int (*swap_deactivate)(struct file *);
+		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 	};
 
 ``writepage``
@@ -963,15 +964,21 @@ cache in your filesystem.  The following members are defined:
 	unless you have them locked or reference counts increased.
 
 ``swap_activate``
-	Called when swapon is used on a file to allocate space if
-	necessary and pin the block lookup information in memory.  A
-	return value of zero indicates success, in which case this file
-	can be used to back swapspace.
+
+	Called to prepare the given file for swap.  It should perform
+	any validation and preparation necessary to ensure that writes
+	can be performed with minimal memory allocation.  It should call
+	add_swap_extent(), or the helper iomap_swapfile_activate(), and
+	return the number of extents added.  If IO should be submitted
+	through ->swap_rw(), it should set SWP_FS_OPS, otherwise IO will
+	be submitted directly to the block device ``sis->bdev``.
 
 ``swap_deactivate``
 	Called during swapoff on files where swap_activate was
 	successful.
 
+``swap_rw``
+	Called to read or write swap pages when SWP_FS_OPS is set.
 
 The File Object
 ===============


