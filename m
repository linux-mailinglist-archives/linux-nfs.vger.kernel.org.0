Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE86626219
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKKTgn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 14:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKKTgm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 14:36:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3C76F94
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 11:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F155B620C0
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 19:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE164C433C1;
        Fri, 11 Nov 2022 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195401;
        bh=pieUoc40pCQE81cbAnTejzcC9ffv4ACSK4iP622V4s4=;
        h=From:To:Cc:Subject:Date:From;
        b=MjOXI59Vz5jlp2Ez16vhT/4xkLRG8gh5n/BCv1r/s2NMvug+PAbHPSlZmcFaO4eUt
         g8r4uplUoe9KHll9FQeh/KeNNHnVvRAXoYmAMj0OGT9i6JqxUM5ek4kOYD4q1DeGjQ
         nylPbJqV4UEPOQFzRIsLAqfxCkc2CI8tGxHorVW2TVEWd9QOmAI9cyRhy8/E2R4Ep6
         4TMWAaUrWi9FszurtFXgIAn5dY69hrPyZlmeM/AornNulUSho8R30bZrPy7ZOjO+0a
         yC/Lh7GKM6i7wlMQnmGQXLXCUidMBsN0+6O6+Jqmnscn8clWrNTbTGdbCUPrEp6pS5
         5BN6PZbGqrorA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] filelock: WARN when @filp and fl_file don't match
Date:   Fri, 11 Nov 2022 14:36:35 -0500
Message-Id: <20221111193639.346992-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Eventually, I'd like to reduce the redundant arguments to the locking
APIs, but to get there we need to ensure the callers all set their file
locks sanely.

Adding the WARN_ON_ONCEs helped to find a couple of warts in lockd's
file handling. The first 3 patches fix those.

Chuck, would you be willing to take these in for v6.2? I'd like to see
the WARN_ONs added for that so we can try to clean up the file locking
APIs for v6.3.

Thanks,

Jeff Layton (4):
  lockd: set missing fl_flags field when retrieving args
  lockd: ensure we use the correct file description when unlocking
  lockd: fix file selection in nlmsvc_cancel_blocked
  filelock: WARN_ON_ONCE when ->fl_file and filp don't match

 fs/lockd/svc4proc.c |  1 +
 fs/lockd/svclock.c  | 17 ++++++++++-------
 fs/lockd/svcproc.c  |  1 +
 fs/locks.c          |  3 +++
 4 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.38.1

