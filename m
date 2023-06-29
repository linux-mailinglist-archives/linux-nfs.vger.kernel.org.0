Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C69742BFB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjF2Sm3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjF2Sm2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 14:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE02681
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0EE615C8
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9154C433C0;
        Thu, 29 Jun 2023 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064145;
        bh=Smtwvse0G5PjHDobA8Ui2u0KyQlinxB5/J60SY9cYm0=;
        h=Subject:From:To:Cc:Date:From;
        b=rApkjczu8EDkuVeIqHfRaHF8C/0ITjaBOY2aWCqMbQn7uHAhVN2lNbv7MQ+v2mDtT
         ZViKvGV5U2kIdX4d1YM0DAMYsGT/6NoU//ghA5UciVv1Yt3/2SfnpIm0JTUxWUpA8E
         M9PU2ayHpEiafsmp0yeHn1tEXolv1z3njepAX/Y+V1ub2iZwDw1KA/YZKZ6eBZLvQ7
         /PCC0y2DZmax0qFJqYtiVFcl/5DCnZWztQCI03bfsdOBAsT5NoZzkUIZ4ukORb3hX+
         LnJl6Q9EzGoF8EWH8oWcwV3j/FQz8Aajr0T7UKUL8d0GIVDRL4MFrPCPylZcA98DTr
         fscx+iKcED29w==
Subject: [PATCH RFC 0/8] RPC service thread scheduler optimizations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Thu, 29 Jun 2023 14:42:23 -0400
Message-ID: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

Walking a linked list to find an idle thread is not CPU cache-
friendly, and in fact I've noted palpable per-request latency
impacts as the number of nfsd threads on the server increases.

After discussing some possible improvements with Jeff at LSF/MM,
I've been experimenting with the following series. I've measured an
order of magnitude latency improvement in the thread lookup time,
and have managed to keep the whole thing lockless.

The only thing I don't like is that allocating the idle bitmaps in
advance means we've got an /a priori/ cap on the number of NFSD
threads that can be created. I'd love to find a way to enable
the pool idle bitmaps to expand dynamically. Suggestions welcome.

Cc: Lorenzo - I'm not sure whether this work would be applied first
or whether your rpc_status patch would be. If yours goes first, I
can handle converting nfsd_rpc_status() to use the pool's thread
xarray.

---

Chuck Lever (8):
      SUNRPC: Deduplicate thread wake-up code
      SUNRPC: Report when no service thread is available.
      SUNRPC: Split the svc_xprt_dequeue tracepoint
      SUNRPC: Clean up svc_set_num_threads
      SUNRPC: Replace dprintk() call site in __svc_create()
      SUNRPC: Replace sp_threads_all with an xarray
      SUNRPC: Convert RQ_BUSY into a per-pool bitmap
      SUNRPC: Don't disable BH's when taking sp_lock


 fs/nfsd/nfssvc.c              |   3 +-
 include/linux/sunrpc/svc.h    |  17 ++--
 include/trace/events/sunrpc.h | 160 ++++++++++++++++++++++++++++----
 net/sunrpc/svc.c              | 169 ++++++++++++++++++++++------------
 net/sunrpc/svc_xprt.c         | 103 +++++++++++----------
 5 files changed, 316 insertions(+), 136 deletions(-)

--
Chuck Lever

