Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF14CEEC2
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiCFXvd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiCFXvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:51:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566C4614A;
        Sun,  6 Mar 2022 15:50:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF78C210EA;
        Sun,  6 Mar 2022 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIwc70WfyZePk+M4TY2KFFjSotnhhDywYz77GPeU54I=;
        b=yW2mlcWWshB+Zpw8lpFaHuA/Po1I8F2jWDiyqn7SoLSvTRka3d/5LKHQAA958Hn/X7jqzQ
        nPn1sBMTzfBI0RCVJ2S28aRK82AYrW3xg5pTJaCRg3P3dwNe2iXM2f5X2sX6HZDgy3bRjQ
        xjaohQhwB2DDhNQCyxlXYQ2jBPbw+8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIwc70WfyZePk+M4TY2KFFjSotnhhDywYz77GPeU54I=;
        b=Ctxa6xp0IpfZB8kCQyX3+nRmsObXTjF6Y2MZzMXc9UTNyI9IFR7N3dAaYiwjKrXeL+5eaG
        FmcJk4vtYoJsrBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB19A134CD;
        Sun,  6 Mar 2022 23:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Arb/KMxIJWI3WgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:50:36 +0000
Subject: [PATCH 03/10] MM: move responsibility for setting SWP_FS_OPS to
 ->swap_activate
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:49:38 +1100
Message-ID: <164661057804.13454.2171827219509234605.stgit@noble.brown>
In-Reply-To: <164661047081.13454.11679636335222534920.stgit@noble.brown>
References: <164661047081.13454.11679636335222534920.stgit@noble.brown>
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

If a filesystem wishes to handle all swap IO itself (via ->direct_IO and
->readpage), rather than just providing devices addresses for
submit_bio(), SWP_FS_OPS must be set.
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/cifs/file.c       |    3 ++-
 fs/nfs/file.c        |   13 +++++++++++--
 include/linux/swap.h |    6 ++++++
 mm/swapfile.c        |   10 +++-------
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e7af802dcfa6..fe49f1cab018 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4917,7 +4917,8 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
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
 


