Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB769FE78
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjBVW1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 17:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjBVW1B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 17:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76F4346D;
        Wed, 22 Feb 2023 14:27:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6011615BA;
        Wed, 22 Feb 2023 22:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36019C433D2;
        Wed, 22 Feb 2023 22:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104819;
        bh=Awm8EptbiVWi+GUOWgfNmNH0g6u1DFVfGfZ2REwOvEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O8Rm33heh/NNuldy7YpYkLMGRvXThDxho1+tbW0qZFGGWq7oTJ7dKnAH/Xli3m51S
         6rsyailXaj1T3sNdrV2TqZkPIDIySmVQXBpL5jml13Ek4Lx3nfYVCu4FkxQyrGotAk
         nze58QiU4uLzEY4ruLt/s72z0OMPVpFpibfc9y5XaN3/wkkOvlTja2hbA4AKmAAyd7
         zsazuA0Hg+PRvsdHhRM+t6OliAvlBbhImqzRZT5fNGvFiU7tTj9AxC+1T4nQ5FPKe6
         fWXl46DYFWTWZ1KXWc66KWNXAMCup/I0CucFj/dPR9QfxtkOvEpdYKKriSzoE7fp5X
         BKVDNs7B+zCag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C248C43151;
        Wed, 22 Feb 2023 22:26:59 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <C34C632C-9163-4825-9E09-9845B0B7DFEE@oracle.com>
References: <C34C632C-9163-4825-9E09-9845B0B7DFEE@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <C34C632C-9163-4825-9E09-9845B0B7DFEE@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3
X-PR-Tracked-Commit-Id: 4b471a8b847b82a3035709dcf87661915c340c8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fc2f99030b55027d84723b0dcbbe9f7e21b9c6c
Message-Id: <167710481910.21044.14681666525548403628.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 22:26:59 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 15:26:53 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fc2f99030b55027d84723b0dcbbe9f7e21b9c6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
