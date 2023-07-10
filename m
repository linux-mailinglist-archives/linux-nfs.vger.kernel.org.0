Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8874DB4E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGJQl6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGJQl5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DBCD2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B614761121
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B398AC433C8;
        Mon, 10 Jul 2023 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007315;
        bh=tKbYfM/RtTQW9L0jYsThapHdDdM0t7T55AMRTtzncBM=;
        h=Subject:From:To:Cc:Date:From;
        b=BNDaQ9dSqFFTyJKQP+8fWjNBbvlRO4Tx6pYg1Eo5qSPpFwYEpzmjwzQ6ldXbQ7DdE
         tHWgAwKjJA7p6er/WC9uqj19bcvnUvrhYxnHjlcwy594v5gWLsThfKjzT9/GPSM4q3
         9rSG3wgF0RLw2mDWtcVbsSz8tS7N59yhOGJHWmyvRsMnsZmRQMA/qoHg4T0TJrSnJm
         I9x4mf6XDHcW/n2VRJplHXB1BKMi2x3+XI+0WcDkoFXdDcjLtZNiN0vP4VLDOHAOvJ
         wE+0AI/Huga2cnuDSdTAn/PT+twIa+B/1Gp2FZa5uvn7k0mxHrOXaW0pebiJ/5E0uO
         qkUzFqBDsF9eQ==
Subject: [PATCH v3 0/9] SUNRPC service thread scheduler optimizations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 10 Jul 2023 12:41:53 -0400
Message-ID: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Walking a linked list to find an idle thread is not CPU cache-
friendly, and in fact I've noted palpable per-request latency
impacts as the number of nfsd threads on the server increases.

After discussing some possible improvements with Jeff at LSF/MM,
I've been experimenting with the following series. I've measured an
order of magnitude latency improvement in the thread lookup time,
and have managed to keep the whole thing lockless.

This version of the series addresses Neil's earlier comments and 
is robust under load. The first 7 patches in this series seem
uncontroversial, so I'll push them to the 
"topic-sunrpc-thread-scheduling" branch of: 

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

The last two are still under discussion. They are posted as part
of this series for comparison to other proposals, but are not yet 
included in the topic branch. But they are tested and working.


Changes since v2: 
* Dropped the patch that converts sp_lock to a simple spinlock
* Replaced explicit memory barriers in svc_get_next_xprt()
* Select thread victims from the other end of the bitmap
* Added a metric for wake-ups that find nothing on the transport queue

Changes since RFC:
* Add a counter for ingress RPC messages
* Add a few documenting comments
* Move the more controversial patches to the end of the series
* Clarify the refactoring of svc_wake_up() 
* Increase the value of RPCSVC_MAXPOOLTHREADS to 4096 (and tested with that many threads)
* Optimize the loop in svc_pool_wake_idle_thread()
* Optimize marking a thread "idle" in svc_get_next_xprt()

---

Chuck Lever (9):
      SUNRPC: Deduplicate thread wake-up code
      SUNRPC: Report when no service thread is available.
      SUNRPC: Split the svc_xprt_dequeue tracepoint
      SUNRPC: Count ingress RPC messages per svc_pool
      SUNRPC: Count pool threads that were awoken but found no work to do
      SUNRPC: Clean up svc_set_num_threads
      SUNRPC: Replace dprintk() call site in __svc_create()
      SUNRPC: Replace sp_threads_all with an xarray
      SUNRPC: Convert RQ_BUSY into a per-pool bitmap


 fs/nfsd/nfssvc.c              |   3 +-
 include/linux/sunrpc/svc.h    |  19 ++--
 include/trace/events/sunrpc.h | 159 ++++++++++++++++++++++++++----
 net/sunrpc/svc.c              | 177 ++++++++++++++++++++++------------
 net/sunrpc/svc_xprt.c         |  99 ++++++++++---------
 5 files changed, 323 insertions(+), 134 deletions(-)

--
Chuck Lever

