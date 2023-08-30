Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5584E78D23F
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjH3C6R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbjH3C6Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD76185
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3665E1F461;
        Wed, 30 Aug 2023 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5bDOZtpIpmY/7QSfs2X3/j2pGW9USJJ16oPzYA7KmYs=;
        b=2OfTfAHH8aJ4UPheqQDbJqqC60NdVecCdvVGjRVxVEycr0d7jAhcd9K3X5uOTxHhXkFEWK
        7gmeKn3t/9SZ9qXXB9dRR2hxYxbQdWAuskAA9+nfWmTxZQUiOlBdV5fUhOuGThvDBXk7vj
        N/I0UE9W0BOOarsLSdoIw2H7Iiq0Vzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5bDOZtpIpmY/7QSfs2X3/j2pGW9USJJ16oPzYA7KmYs=;
        b=T9lNi1tmwVJoqr5jVnZRwYhAeiCT5vuAPhM+4k7a+8wUF9uBwAMehny/GIOV6Nd/P9nkUf
        XMaPm8F0mwdWT9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E833113301;
        Wed, 30 Aug 2023 02:58:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LQAEJkOw7mTPYwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:11 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/10] SUNRPC thread management changes
Date:   Wed, 30 Aug 2023 12:54:43 +1000
Message-ID: <20230830025755.21292-1-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here is an updated set of patches against topic-sunrpc-thread-scheduling.

There are two patches to be squashed into the current top of that topic,
though an llist patch needs to be moved earlier for the second to work.

All the llist changes are no in separate patches.  lwq is now added to lib/

NeilBrown


 [PATCH 01/10] SQUASH: revise comments in SUNRPC: change service idle
 [PATCH 02/10] llist: add interface to check if a node is on a list.
 [PATCH 03/10] SQUASH use new llist interfaces in SUNRPC: change
 [PATCH 04/10] llist: add llist_del_first_this()
 [PATCH 05/10] lib: add light-weight queuing mechanism.
 [PATCH 06/10] SUNRPC: only have one thread waking up at a time
 [PATCH 07/10] SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
 [PATCH 08/10] SUNRPC: change sp_nrthreads to atomic_t
 [PATCH 09/10] SUNRPC: discard sp_lock
 [PATCH 10/10] SUNRPC: change the back-channel queue to lwq

