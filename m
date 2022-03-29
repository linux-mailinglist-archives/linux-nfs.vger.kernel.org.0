Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36E34EB712
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiC2XxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiC2XxL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:53:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B3214043;
        Tue, 29 Mar 2022 16:51:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FAF8210E4;
        Tue, 29 Mar 2022 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HnOSi35e7huDS3NoAvQMcSW+GRRJDr6mjIJuI3yhq6M=;
        b=fDs8Hp1TppCMD+ZF8OC62VmBEk2geE7a2GqsNOIWt9agTqYBcAZ6C8+JMXk+9P9IB98h/U
        mkjHuIrswYegFdfk4RU0N2ouvCSCYIlbpTSTZWwHPEOaOSiuXX3R8BBGSmucMusvAfwHlK
        HEKnxubAhOTexgHFWgLBV1D7V8LCYws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HnOSi35e7huDS3NoAvQMcSW+GRRJDr6mjIJuI3yhq6M=;
        b=kjM8SjqIU011vunEmTySEzBTseN+224GBIV3vdL63xb2Mocnj0NfE45cl+sxn0yRrkW76+
        vyRpl2do8mKsBPDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55A8713A7E;
        Tue, 29 Mar 2022 23:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id stJ5BXybQ2IkLwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:51:24 +0000
Subject: [PATCH 02/10] MM: drop swap_dirty_folio
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778123.29473.6900942583784889976.stgit@noble.brown>
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

folios that are written to swap are owned by the MM subsystem - not any
filesystem.

When such a folio is passed to a filesystem to be written out to a
swap-file, the filesystem handles the data, but the folio itself does not
belong to the filesystem.  So calling the filesystem's ->dirty_folio()
address_space operation makes no sense.  This is for folios in the given
address space, and a folio to be written to swap does not exist in the
given address space.

So drop swap_dirty_folio() which calls the address-space's
->dirty_folio(), and always use noop_dirty_folio(), which is
appropriate for folios being swapped out.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/swap.h |    1 -
 mm/page_io.c         |   17 -----------------
 mm/swap_state.c      |    2 +-
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 11390dde5a6c..6bc9e21262de 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -420,7 +420,6 @@ extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-bool swap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
 int generic_swapfile_activate(struct swap_info_struct *, struct file *,
diff --git a/mm/page_io.c b/mm/page_io.c
index d01ab9d5410a..5ffdbda31a16 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -439,20 +439,3 @@ int swap_readpage(struct page *page, bool synchronous)
 	delayacct_swapin_end();
 	return ret;
 }
-
-bool swap_dirty_folio(struct address_space *mapping, struct folio *folio)
-{
-	struct swap_info_struct *sis = swp_swap_info(folio_swap_entry(folio));
-
-	if (data_race(sis->flags & SWP_FS_OPS)) {
-		const struct address_space_operations *aops;
-
-		mapping = sis->swap_file->f_mapping;
-		aops = mapping->a_ops;
-
-		VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
-		return aops->dirty_folio(mapping, folio);
-	} else {
-		return noop_dirty_folio(mapping, folio);
-	}
-}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 5437dd317cf3..f3ab01801629 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -31,7 +31,7 @@
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
-	.dirty_folio	= swap_dirty_folio,
+	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif


