Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED64977CF
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiAXDu6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:50:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiAXDuw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:50:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0922198E;
        Mon, 24 Jan 2022 03:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3+8Urza+M6Hp0rhzCu2VxlEP+N2PAYC/q2bkhSRhhQ=;
        b=MRpjffj/7VeHdxIDvWWjvl/3r4/m4nUYdxDb5oZ0MqJtNXzmzCabuDPrwJjGKWSRCKT1hv
        0eIzNEVsbLqTPxQ8NUD6GLT8O4PJddETBuHpkFe2wmXYa5XWBgH+MaJ4KqUPjU3ewxZtwB
        KVWPF5jcDiBVq7BwPzWnL2CjuWgH0EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3+8Urza+M6Hp0rhzCu2VxlEP+N2PAYC/q2bkhSRhhQ=;
        b=H600lppcNVits1+ijjv1xGR2cG4x3GPjkeRayoUjM2oyaz9E6uw3QaROGd3vyIteNPOVKO
        H+ylIEPXzcLPB6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DC1A1331A;
        Mon, 24 Jan 2022 03:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PwBpLhci7mHGRAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:50:47 +0000
Subject: [PATCH 04/23] MM: move responsibility for setting SWP_FS_OPS to
 ->swap_activate
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
Message-ID: <164299611275.26253.11641346650863170349.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a filesystem wishes to handle all swap IO itself (via ->direct_IO),
rather than just providing devices addresses for submit_bio(),
SWP_FS_OPS must be set.
Currently the protocol for setting this it to have ->swap_activate
return zero.  In that case SWP_FS_OPS is set, and add_swap_extent()
is called for the entire file.

This is a little clumsy as different return values for ->swap_activate
have quite different meanings, and it makes it hard to search for which
filesystems require SWP_FS_OPS to be set.

So remove the special meaning of a zero return, and require the
filesystem to set SWP_FS_OPS if it so desires, and to always call
add_swap_extent() as required.

Currently only NFS and CIFS return zero for add_swap_extent().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/cifs/file.c       |    3 ++-
 fs/nfs/file.c        |   13 +++++++++++--
 include/linux/swap.h |    6 ++++++
 mm/swapfile.c        |   10 +++-------
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 59334be9ed3b..c795d4a9ec4a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4974,7 +4974,8 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 	 * from reading or writing the file
 	 */
 
-	return 0;
+	sis->flags |= SWP_FS_OPS;
+	return add_swap_extent(sis, 0, sis->max, 0);
 }
 
 static void cifs_swap_deactivate(struct file *file)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 76d76acbc594..d5aa55c7edb0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -488,6 +488,7 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 {
 	unsigned long blocks;
 	long long isize;
+	int ret;
 	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
 	struct inode *inode = file->f_mapping->host;
 
@@ -500,9 +501,17 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		return -EINVAL;
 	}
 
+	ret = rpc_clnt_swap_activate(clnt);
+	if (ret)
+		return ret;
+	ret = add_swap_extent(sis, 0, sis->max, 0);
+	if (ret < 0) {
+		rpc_clnt_swap_deactivate(clnt);
+		return ret;
+	}
 	*span = sis->pages;
-
-	return rpc_clnt_swap_activate(clnt);
+	sis->flags |= SWP_FS_OPS;
+	return ret;
 }
 
 static void nfs_swap_deactivate(struct file *file)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index a43929f7033e..b57cff3c5ac2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -573,6 +573,12 @@ static inline swp_entry_t get_swap_page(struct page *page)
 	return entry;
 }
 
+static inline int add_swap_extent(struct swap_info_struct *sis,
+				  unsigned long start_page,
+				  unsigned long nr_pages, sector_t start_block)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_SWAP */
 
 #ifdef CONFIG_THP_SWAP
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 71c7a31dd291..ed6028aea8bf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2347,13 +2347,9 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 
 	if (mapping->a_ops->swap_activate) {
 		ret = mapping->a_ops->swap_activate(sis, swap_file, span);
-		if (ret >= 0)
-			sis->flags |= SWP_ACTIVATED;
-		if (!ret) {
-			sis->flags |= SWP_FS_OPS;
-			ret = add_swap_extent(sis, 0, sis->max, 0);
-			*span = sis->pages;
-		}
+		if (ret < 0)
+			return ret;
+		sis->flags |= SWP_ACTIVATED;
 		return ret;
 	}
 


