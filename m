Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F404EB715
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiC2Xxm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiC2Xx2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:53:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770D21A8BC;
        Tue, 29 Mar 2022 16:51:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE73E210E4;
        Tue, 29 Mar 2022 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUqsktX1Dv6qEK49ZdefTv/pOyZaEMsB1qtsMGhOrI4=;
        b=LvNolslLWWnhLdL/xjqxOHqkEMnr1D2s2zo0ZkV7o4M61dzgurAVy4d+4feES/DzhFlvBA
        Rwmaqp1DJD194Fis6kF6LpmUVovPGYtCPJsjN+6ncbXteQIE6K5e0huLuNB0kbxZSF3cRq
        B4q7NuCJVrWUsoRRDFHbzkkFQXKbIK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUqsktX1Dv6qEK49ZdefTv/pOyZaEMsB1qtsMGhOrI4=;
        b=QOa9e9vj7wV7WsyjC3Pj4tX/B/UhY320L+3XytQmEOmOmBS9JgR9QB46s/Bkan94wyYnjP
        JXPSJwFAzw/4QvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F53A13A7E;
        Tue, 29 Mar 2022 23:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E/MiD4KbQ2IvLwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:51:30 +0000
Subject: [PATCH 03/10] MM: move responsibility for setting SWP_FS_OPS to
 ->swap_activate
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778123.29473.17908205846599043598.stgit@noble.brown>
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
index 60f43bff7ccb..050f463580f3 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4927,7 +4927,8 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 	 * from reading or writing the file
 	 */
 
-	return 0;
+	sis->flags |= SWP_FS_OPS;
+	return add_swap_extent(sis, 0, sis->max, 0);
 }
 
 static void cifs_swap_deactivate(struct file *file)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 2df2a5392737..66136dca0ad5 100644
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
index 6bc9e21262de..e18b7edccc1d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -570,6 +570,12 @@ static inline swp_entry_t get_swap_page(struct page *page)
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
index 2650927a009b..8710c9c29862 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2244,13 +2244,9 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 
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
 


