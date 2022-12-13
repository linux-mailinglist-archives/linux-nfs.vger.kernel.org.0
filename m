Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701B64BBB9
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 19:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiLMSOZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiLMSNn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 13:13:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180822299;
        Tue, 13 Dec 2022 10:13:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60C561638;
        Tue, 13 Dec 2022 18:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19A7DC433EF;
        Tue, 13 Dec 2022 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955220;
        bh=hRFhErttzIA3RjNxRev7WqFIy2fw7bDpRyb+u6pzeto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u9EHSMKCj8Jis8mUp4LVIBuWYT3dvDcf3oC4ayi5VmaqftlHQ2hLYt5d27FshEmgF
         T/pl7t5brBnMuM0EZisJjFqPmoxyAXGE8JWOrj2wc+8fyBr4SRC8w36GPl7mZ5QUFU
         nIuyvsae9eaTN3owoNp4zLLZtQlH53zS38rhYSGkJPDRz8T6H7yO/8nr4VsnBBt495
         aNPb+d0IT1njxaPfmNUz607Wr0Yq7fDQSfCh5O+8l9D3t0bDOx+5f/RX76xAZeiKsv
         en1X/1Z6lIICUIhlp7uzezAU5FhiymTRJu1eWEFbZFzZ9WOrbNq3i4yZz9sqS3fdMr
         95gU0W+zVxBzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02FA3C00445;
        Tue, 13 Dec 2022 18:13:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a91ef5f6937333955610acebf92c8efb2f9b8391.camel@kernel.org>
References: <a91ef5f6937333955610acebf92c8efb2f9b8391.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <a91ef5f6937333955610acebf92c8efb2f9b8391.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-1
X-PR-Tracked-Commit-Id: 7fd461c47c6cfab4ca4d003790ec276209e52978
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a044dab5e6e5f0c382a6a4af37d537fb2d8bacb7
Message-Id: <167095522000.23919.12424067974136440349.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:40 +0000
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 10:35:50 -0500:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a044dab5e6e5f0c382a6a4af37d537fb2d8bacb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
