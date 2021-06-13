Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838313A5A4B
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jun 2021 22:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhFMUTy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Jun 2021 16:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhFMUTx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 13 Jun 2021 16:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9B69B61245;
        Sun, 13 Jun 2021 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623615471;
        bh=rtFzOnRvs7+uaGqfNO48CYYD07MWsnB62UpJnlbULVQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RMjQ+zmQ1S5g7DZFu3VyRZrF4Z4sjuetVb9GCOlsh+xXQAnfv6+/729gRzS2K+Xrk
         mrYlun0J3t94Gf4YKbKvvCnJNPgq1X721OuUep7rMeHPp5aH9v8xz2myl7ZD7f03Sk
         Hz7WGw4FnSHDV5TGdNKmfgkB82zQr2g9RT/3/Xbx9WHAc9nxThRzoD1UUUhFT2I/2F
         m8QX4SvCXsFV3R4jo7LMYyGQVZOx4AmiHQZWTh8YH4t3umIhRcB6uDNLMKBSXNVJHs
         u8ku+ml1VuKOokLTbKeLbpLI75PaQM1i4x/vuSr0w0/xFPDpKMS6oGLzypztXE/rfM
         kqTwB4AuXxcMQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9594E60953;
        Sun, 13 Jun 2021 20:17:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a163fa3530e0c39ae83bdbee68dd189b1d15fe27.camel@hammerspace.com>
References: <a163fa3530e0c39ae83bdbee68dd189b1d15fe27.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a163fa3530e0c39ae83bdbee68dd189b1d15fe27.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.13-3
X-PR-Tracked-Commit-Id: c3aba897c6e67fa464ec02b1f17911577d619713
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 960f0716d80fb8241356ba862a4c377c7250121f
Message-Id: <162361547160.15542.12770815176268999518.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jun 2021 20:17:51 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sun, 13 Jun 2021 15:36:38 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/960f0716d80fb8241356ba862a4c377c7250121f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
