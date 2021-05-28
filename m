Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AE39475A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 May 2021 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhE1TBg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 May 2021 15:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhE1TBg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 May 2021 15:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4681361108;
        Fri, 28 May 2021 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622228401;
        bh=q/s203PFD8+87voymdQ/+a1JdP+7gsm6+oPZLU3fDLA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WSILbAZTXS9ky7/qEbRVnArdqIcoqinDqF16RbUL1ppJLpi6x3YWui/aMHge1xuog
         jKqHFSUdsBL3ijw4HXUgYtSvEQf5cxJ/fcsyGz7202F0Ov6v/ts+PcOT28mi7b5gjA
         eC0owf3hWNy70ZMggFA22AlcdMdso6M2JFgm0IvxgV+qpZ/Xc8/x6E/qBhPi6enYjK
         wuiWe04NaukNSLUABJOJ85tpqNc1F8LYLaBu/cnxL+OKOHvM324x7QHJlXV4SXaAX7
         NJ61rbqVi0SyaYFbxBoZDumN5AExN4NJNyzL9odC61hoxWr01r/FgJXDiyjQopq0u0
         riFihMIDHteFw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 395BF609EA;
        Fri, 28 May 2021 19:00:01 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3e2e6ebe7d121f9f26404253c6f360d829129f94.camel@hammerspace.com>
References: <3e2e6ebe7d121f9f26404253c6f360d829129f94.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <3e2e6ebe7d121f9f26404253c6f360d829129f94.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.13-2
X-PR-Tracked-Commit-Id: a799b68a7c7ac97b457aba4ede4122a2a9f536ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ff2756afde08b266fbb673849899fec694f39f1
Message-Id: <162222840122.1554.5753445721617255804.pr-tracker-bot@kernel.org>
Date:   Fri, 28 May 2021 19:00:01 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 28 May 2021 14:15:42 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ff2756afde08b266fbb673849899fec694f39f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
