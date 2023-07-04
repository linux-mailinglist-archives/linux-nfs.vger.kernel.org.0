Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4D746652
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 02:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGDAHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 20:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAHc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 20:07:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19E189
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 17:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7D66101C
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 00:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6604FC433C7;
        Tue,  4 Jul 2023 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429250;
        bh=H0s4RMJDK7bFW5DZ5Jz/CXciI1EolYWHac5OC1luPgw=;
        h=Subject:From:To:Cc:Date:From;
        b=X3DRHpkpV7kgxkL11s352DY50VtCA1zkr7OZ+yrwN+ahvqGcVjTgXH38Zpp/gj509
         DVAGev5lkul4EpIleMCV2hyVRh3KtcS55sYupUFXyNWy0L2cg2qknUJ6GuJ84YbxzX
         JyL9sAH/yFvx9G2MulIaXC3kjPg+1WG78pbPzNlygvO6iV87qITs1sPNsWlcShoRYH
         3qQF5Jwd6jn4MkbcbN1koST/AE6bDNsT5NwDTCCbmB6/uHRsb25jxukrVbKQO8gzY2
         SMA2xXrtGHtjjwLMEt2w970EbWhEIro7ISvw8yoO3fwr4PrPXMH1iGc6/DwBAZuoBW
         9BuCpzLDQ/zEA==
Subject: [PATCH v2 0/9] SUNRPC service thread scheduler optimizations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 03 Jul 2023 20:07:29 -0400
Message-ID: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

After some offline discussion with Neil, I tried out using just
the xarray plus its spinlock to mark threads idle or busy. This
worked as well as the bitmap for lower thread counts, but got
predictably bad as the thread count when past several hundred. For
the moment I'm sticking with the wait-free bitmap lookup.

Also, the maximum thread count is now 4096. I'm still willing to try
an RCU-based bitmap resizing mechanism if we believe this is still
to small of a maximum.


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
      SUNRPC: Clean up svc_set_num_threads
      SUNRPC: Replace dprintk() call site in __svc_create()
      SUNRPC: Don't disable BH's when taking sp_lock
      SUNRPC: Replace sp_threads_all with an xarray
      SUNRPC: Convert RQ_BUSY into a per-pool bitmap


 fs/nfsd/nfssvc.c              |   3 +-
 include/linux/sunrpc/svc.h    |  18 ++--
 include/trace/events/sunrpc.h | 159 +++++++++++++++++++++++++++----
 net/sunrpc/svc.c              | 174 ++++++++++++++++++++++------------
 net/sunrpc/svc_xprt.c         | 114 +++++++++++-----------
 5 files changed, 328 insertions(+), 140 deletions(-)

--
Chuck Lever

