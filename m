Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFB58E391
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 01:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiHIXIo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiHIXIb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 19:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A82611F;
        Tue,  9 Aug 2022 16:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D42FD6119E;
        Tue,  9 Aug 2022 23:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F07C433C1;
        Tue,  9 Aug 2022 23:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660086510;
        bh=upy6vBSeJZevoFy3SFNaslhoTsa5S5ok4I58aUEt2X4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rVBDSIrBW0iA91nAGljoUkKKDoV+yH5WsL4sK1yTVlmTh8n36Uu8Qh4izhbvqW2JO
         z7kk7Zr/Dqzv+29ClroLqtgvREOgTtOHSt0XTrFK9iIkq2e+/8KgPSTwbditfX1SMe
         PWAodDcvfDK6peMDXQLfnwX5zU0x51tmPg88cEsRh83A0piKBuS+EZni+JR95hP+2v
         1ugj9BBu5tH6VgZOq9IVsZhrpAbVM0kVhdQwCMapQBVaaXQizymHeZnEm1GzSgMEHM
         rZYnOuoroQgWF/jYn++mB1kMDSLtXDjIxrHFyXswAR00DNmS0iRNriZR7/UJ9gg7l9
         VfIDqAqpAHbQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BCDBC43142;
        Tue,  9 Aug 2022 23:08:30 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <961E618F-200A-4C73-80E4-A6E720D8A45A@oracle.com>
References: <961E618F-200A-4C73-80E4-A6E720D8A45A@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <961E618F-200A-4C73-80E4-A6E720D8A45A@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.0
X-PR-Tracked-Commit-Id: 6930bcbfb6ceda63e298c6af6d733ecdf6bd4cde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e394ff83bbca1c72427b1feb5c6b9d4dad832f01
Message-Id: <166008651017.14169.5219667989562684717.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 23:08:30 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 9 Aug 2022 13:56:19 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e394ff83bbca1c72427b1feb5c6b9d4dad832f01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
