Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88100757460
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGRGjI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGRGjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10813E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA862193C;
        Tue, 18 Jul 2023 06:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8aKr8hgNV53KfPAWTBs1EGAfa9oI5wKwQm+OjfP5qdE=;
        b=m2ApP84JDWn9cnz1eg/XdtA8WPHmxouOTwJOOK/MhIRDxzV33ltTdx7WkxxutFfekFN3IH
        kZRTNxVQKDxMYKcb13GUA9kLBoYsNn2drMrKxn9pC7wKn38hjHJX2r2ltM1/TD6GAwTSmz
        ZXapi68dfiWoy9lUuUXcviXReewEIwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8aKr8hgNV53KfPAWTBs1EGAfa9oI5wKwQm+OjfP5qdE=;
        b=lucg8kQlA2utsWot94Zo6f40SX8MoumFwXKMevfKPWm+1SIiIcXMShGjtlCM4b0R/6XkOw
        h51y6Nj+NLtspIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 178F113494;
        Tue, 18 Jul 2023 06:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id swViLoIztmQRDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:38:58 +0000
Subject: [PATCH 00/14] Refactor SUNRPC svc thread code, and use llist
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966227838.11075.2974227708495338626.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This code .... grew a bit since my previous pencil-sketch code.

The goal is really the final patch: using a llist without spinlocks to
handle dispatch of idle threads.  To get there I found it necessary - or
at least helpful - to do a lot of refactoring.

This code passes some basic tests, but I haven't push it hard yet.

Even if other aren't convinced that llists are the best solution, I
think a lot of the refactoring is this valuable.

Comments welcome,
Thanks,
NeilBrown

---

NeilBr own (14):
      lockd: remove SIGKILL handling.
      nfsd: don't allow nfsd threads to be signalled.
      SUNRPC: call svc_process() from svc_recv().
      SUNRPC: change svc_recv() to return void.
      SUNRPC: remove timeout arg from svc_recv()
      SUNRPC: change various server-side #defines to enum
      SUNRPC: refactor svc_recv()
      SUNRPC: integrate back-channel processing with svc_recv() and svc_process()
      SUNRPC: change how svc threads are asked to exit.
      SUNRPC: change svc_pool_wake_idle_thread() to return nothing.
      SUNRPC: add list of idle threads
      SUNRPC: discard SP_CONGESTED
      SUNRPC: change service idle list to be an llist
      SUNRPC: only have one thread waking up at a time


 fs/lockd/svc.c                    |  49 ++-----
 fs/lockd/svclock.c                |   9 +-
 fs/nfs/callback.c                 |  59 +-------
 fs/nfsd/nfs4proc.c                |  10 +-
 fs/nfsd/nfssvc.c                  |  22 +--
 include/linux/llist.h             |   2 +
 include/linux/lockd/lockd.h       |   4 +-
 include/linux/sunrpc/cache.h      |  11 +-
 include/linux/sunrpc/svc.h        |  87 +++++++++---
 include/linux/sunrpc/svc_xprt.h   |  39 +++---
 include/linux/sunrpc/svcauth.h    |  29 ++--
 include/linux/sunrpc/svcsock.h    |   2 +-
 include/linux/sunrpc/xprtsock.h   |  25 ++--
 include/trace/events/sunrpc.h     |   5 +-
 lib/llist.c                       |  27 ++++
 net/sunrpc/backchannel_rqst.c     |   8 +-
 net/sunrpc/svc.c                  |  71 ++++------
 net/sunrpc/svc_xprt.c             | 226 ++++++++++++++++--------------
 net/sunrpc/xprtrdma/backchannel.c |   2 +-
 19 files changed, 347 insertions(+), 340 deletions(-)

--
Signature

