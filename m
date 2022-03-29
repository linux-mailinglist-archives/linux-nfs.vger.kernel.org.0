Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CC4EB709
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiC2XxG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbiC2XxA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:53:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E11CAF14;
        Tue, 29 Mar 2022 16:51:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64FEC1F37B;
        Tue, 29 Mar 2022 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=decwXtYK4xzf9z+YJq9kZIT8RF7eJZEH+v+/UIEpIs0=;
        b=gIlals8TlB5yctjTv9aD0cnYjD5k+Z3UK4jKAFB9nKXC2iWqPABcPBOBg/Kq12vS0dHNym
        ZvqMi5c0BDJqW6tnJz0/0h3/c++bM+JN9onMMUO98A0/fYuNG77UqOAuJm+79FANKppCrL
        KSYerLOwkBAWGWWT+u2XCxNfUCxukeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=decwXtYK4xzf9z+YJq9kZIT8RF7eJZEH+v+/UIEpIs0=;
        b=oZLW8JZWx9ZEKj2ved76aCXNp4XaZHcDloX0gXO0FFuNXj9vIjOpVdlfSPB/uUG6xIVVcZ
        +VSqHzJJz1AbC2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BFCF13A7E;
        Tue, 29 Mar 2022 23:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hZv0CXCbQ2IcLwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:51:12 +0000
Subject: [PATCH 00/10] MM changes to improve swap-over-NFS support
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859751830.29473.5309689752169286816.stgit@noble.brown>
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

Assorted improvements for swap-via-filesystem.

This is a resend of these patches, rebased on current HEAD.
The only substantial changes is that swap_dirty_folio has replaced
swap_set_page_dirty.

Currently swap-via-fs (SWP_FS_OPS) doesn't work for any filesystem.  It
has previously worked for NFS but that broke a few releases back.
This series changes to use a new ->swap_rw rather than ->readpage and
->direct_IO.  It also makes other improvements.

There is a companion series already in linux-next which fixes various
issues with NFS.  Once both series land, a final patch is needed which
changes NFS over to use ->swap_rw.

Thanks,
NeilBrown


---

NeilBrown (10):
      MM: create new mm/swap.h header file.
      MM: drop swap_dirty_folio
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
 mm/page_io.c                          | 247 +++++++++++++++++++-------
 mm/swap.h                             |  30 +++-
 mm/swap_state.c                       |  22 ++-
 mm/swapfile.c                         |  13 +-
 mm/vmscan.c                           |  38 ++--
 18 files changed, 347 insertions(+), 128 deletions(-)

--
Signature

