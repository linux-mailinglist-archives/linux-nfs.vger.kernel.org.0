Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD44CEEBA
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiCFXvF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiCFXvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:51:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5C11A1D;
        Sun,  6 Mar 2022 15:50:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DBD11F38E;
        Sun,  6 Mar 2022 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B5TF9OjBYnAvE9aH5SLQp8lDT5DoHM72C74T7yiurcA=;
        b=UrTWS9yX+p9XW7I8btQShNBxnfOKbcGpJeq+bgYsDqam1Gerz+p/wzaDqtyRayoNwlGQMK
        YMb0qXlrV/Gu5ljlt7G0oxOtNuEbvkl7Pbfy2ZedzovSmpQ49DiZGfQ5BtMPaNfrEHCb1t
        dZ8FuvnxUvI7CzkPWPJPL27mK02DFZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B5TF9OjBYnAvE9aH5SLQp8lDT5DoHM72C74T7yiurcA=;
        b=FtqjrEGiYRJ+tJHuysqbTXlAReKwNZ+5CZmn40Se1LP0vA/eUY+MLbTHOHnK4U7LOp7gTj
        q8G35DFLTOwL23Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E3E1134CD;
        Sun,  6 Mar 2022 23:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id te+YErBIJWIIWgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:50:08 +0000
Subject: [PATCH 00/10] MM changes to improve swap-over-NFS support
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:49:38 +1100
Message-ID: <164661047081.13454.11679636335222534920.stgit@noble.brown>
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

Hi Andrew,
 these are the non-NFS-specific parts of the swap-over-NFS series that
 I've posted a few times.  I've address all comments, most recently
 style improvements in mm/swap.h.
 Would it be possible for these to land in the next merge window?

Thanks,
NeilBrown


---

NeilBrown (10):
      MM: create new mm/swap.h header file.
      MM: drop swap_set_page_dirty
      MM: move responsibility for setting SWP_FS_OPS to ->swap_activate
      MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
      MM: introduce ->swap_rw and use it for reads from SWP_FS_OPS swap-space
      MM: perform async writes to SWP_FS_OPS swap-space using ->swap_rw
      DOC: update documentation for swap_activate and swap_rw
      MM: submit multipage reads for SWP_FS_OPS swap-space
      MM: submit multipage write for SWP_FS_OPS swap-space
      VFS: Add FMODE_CAN_ODIRECT file flag


 Documentation/filesystems/locking.rst |  18 +-
 Documentation/filesystems/vfs.rst     |  17 +-
 drivers/block/loop.c                  |   4 +-
 fs/cifs/file.c                        |   7 +-
 fs/fcntl.c                            |   9 +-
 fs/nfs/file.c                         |  20 ++-
 fs/open.c                             |   9 +-
 fs/overlayfs/file.c                   |  13 +-
 include/linux/fs.h                    |   4 +
 include/linux/swap.h                  |   7 +-
 include/linux/writeback.h             |   7 +
 mm/madvise.c                          |   8 +-
 mm/memory.c                           |   2 +-
 mm/page_io.c                          | 244 ++++++++++++++++++++------
 mm/swap.h                             |  30 +++-
 mm/swap_state.c                       |  22 ++-
 mm/swapfile.c                         |  13 +-
 mm/vmscan.c                           |  38 ++--
 18 files changed, 347 insertions(+), 125 deletions(-)

--
Signature

