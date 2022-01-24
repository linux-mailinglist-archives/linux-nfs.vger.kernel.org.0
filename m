Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC44977D7
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiAXDvw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:51:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46904 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiAXDvw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:51:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 027C61F3B1;
        Mon, 24 Jan 2022 03:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZSVg3aKIz40nUMCvjUBG4ZEl086iHutx/VbHAUIx6g=;
        b=FaCT8C1KKiZslEDKX0B0nnEP4OIwXLlUiEhOwkGJDBaYzBxeeguuvTaQXFCpbtLdCapya/
        Gc2MurPmUUKTe6q3WUuO/LoCDpoJZI8zBqY8GPgDElQyuk8Xh7M9lKOfy0hbsq2C1plfkz
        mQZPM+sgH+Qd2DcjWAilknmFULUgQ4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZSVg3aKIz40nUMCvjUBG4ZEl086iHutx/VbHAUIx6g=;
        b=2dDfgB4kbXXac24BmsiGHxhQ/+8avwdmlQkpUQ6uxYnfQjmrENFosVnlPPSEAVdkcy7eyq
        VZAxN3wOy5t6E1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2AC713305;
        Mon, 24 Jan 2022 03:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0DHNF1Ii7mEpRQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:51:46 +0000
Subject: [PATCH 08/23] DOC: update documentation for swap_activate and swap_rw
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611278.26253.2945860698197438729.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This documentation for ->swap_activate() has been out-of-date for a long
time.  This patch updates it to match recent changes, and adds
documentation for the associated ->swap_rw()

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/filesystems/locking.rst |   18 ++++++++++++------
 Documentation/filesystems/vfs.rst     |   17 ++++++++++++-----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 3f9b1497ebb8..fbb10378d5ee 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -260,8 +260,9 @@ prototypes::
 	int (*launder_page)(struct page *);
 	int (*is_partially_uptodate)(struct page *, unsigned long, unsigned long);
 	int (*error_remove_page)(struct address_space *, struct page *);
-	int (*swap_activate)(struct file *);
+	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 	int (*swap_deactivate)(struct file *);
+	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 
 locking rules:
 	All except set_page_dirty and freepage may block
@@ -290,6 +291,7 @@ is_partially_uptodate:	yes
 error_remove_page:	yes
 swap_activate:		no
 swap_deactivate:	no
+swap_rw:		yes, unlocks
 ======================	======================== =========	===============
 
 ->write_begin(), ->write_end() and ->readpage() may be called from
@@ -392,15 +394,19 @@ cleaned, or an error value if not. Note that in order to prevent the page
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
index bf5c48066fac..779d23fc7954 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -751,8 +751,9 @@ cache in your filesystem.  The following members are defined:
 					      unsigned long);
 		void (*is_dirty_writeback) (struct page *, bool *, bool *);
 		int (*error_remove_page) (struct mapping *mapping, struct page *page);
-		int (*swap_activate)(struct file *);
+		int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 		int (*swap_deactivate)(struct file *);
+		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 	};
 
 ``writepage``
@@ -959,15 +960,21 @@ cache in your filesystem.  The following members are defined:
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


