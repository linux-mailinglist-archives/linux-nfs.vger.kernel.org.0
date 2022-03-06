Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7083D4CEE9E
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiCFXnQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiCFXnP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:43:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C239836
        for <linux-nfs@vger.kernel.org>; Sun,  6 Mar 2022 15:42:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF09210FC;
        Sun,  6 Mar 2022 23:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gKDwuIBNRlBJYpWscBRtFmxO0I8PDI8ZkbE33HCfeRU=;
        b=1iXTdFpdm4LoCp9GYGonBzRoZ2wLnoodJW/OB8k0OmcpHqdd3TmqsyqmOxypzrPKa7vO8v
        SabTJMNIcapj7pKA1AVM4rAV+GN3EpiiutqRYD+ZAyviUaVRAI1sSns0JBaMhGgaIwQcXh
        yZeIFLJv/W4SiWAEI3X6slYB8EAIWLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gKDwuIBNRlBJYpWscBRtFmxO0I8PDI8ZkbE33HCfeRU=;
        b=yx0hq+MXYfrmW07V5aC1byMr8nRXvrm4Ui0nIHPGH4o7P9NJF3RHC9PA8RibxnizVsPZSC
        NL+yWV9sRe2I9rBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26DB6134CD;
        Sun,  6 Mar 2022 23:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rPcKNNtGJWL5VwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:42:19 +0000
Subject: [PATCH 00/11] Various NFS/sunrpc improvements for swap-over-NFS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:41:44 +1100
Message-ID: <164660993703.31054.17075972410545449555.stgit@noble.brown>
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

swap-over-NFS currently doesn't work.  Even after these patches it still
won't work.  Some core MM changes are needed.
However these patches make a number of improvements to NFS and SUNRPC so
that swap-over-NFS can work once those mm changes land.

There is one change since the last posting of these patches.
The last patch was added to fix a potential hang when enabling swap.

Trond/Anna - is their any chance these can go in on the next merge
window?

Thanks,
NeilBrown


---

NeilBrown (11):
      NFS: remove IS_SWAPFILE hack
      SUNRPC/call_alloc: async tasks mustn't block waiting for memory
      SUNRPC/auth: async tasks mustn't block waiting for memory
      SUNRPC/xprt: async tasks mustn't block waiting for memory
      SUNRPC: remove scheduling boost for "SWAPPER" tasks.
      NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
      SUNRPC: improve 'swap' handling: scheduling and PF_MEMALLOC
      NFSv4: keep state manager thread active if swap is enabled
      NFS: swap IO handling is slightly different for O_DIRECT IO
      NFS: swap-out must always use STABLE writes.
      SUNRPC: change locking for xs_swap_enable/disable


 fs/nfs/direct.c                 | 48 ++++++++++++++++++++++-----------
 fs/nfs/file.c                   | 19 +++++++++----
 fs/nfs/nfs4_fs.h                |  1 +
 fs/nfs/nfs4proc.c               | 20 ++++++++++++++
 fs/nfs/nfs4state.c              | 39 ++++++++++++++++++++++-----
 fs/nfs/read.c                   |  4 ---
 fs/nfs/write.c                  |  2 ++
 include/linux/nfs_fs.h          | 13 +++------
 include/linux/nfs_xdr.h         |  2 ++
 include/linux/sunrpc/auth.h     |  1 +
 include/linux/sunrpc/sched.h    |  1 -
 include/trace/events/sunrpc.h   |  1 -
 net/sunrpc/auth.c               |  8 ++++--
 net/sunrpc/auth_gss/auth_gss.c  |  6 ++++-
 net/sunrpc/auth_unix.c          | 10 +++++--
 net/sunrpc/clnt.c               |  7 +++--
 net/sunrpc/sched.c              | 29 +++++++++++++-------
 net/sunrpc/xprt.c               | 19 +++++--------
 net/sunrpc/xprtrdma/transport.c | 10 ++++---
 net/sunrpc/xprtsock.c           | 34 ++++++++++++-----------
 20 files changed, 185 insertions(+), 89 deletions(-)

--
Signature

