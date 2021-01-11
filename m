Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D252F207C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 21:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391529AbhAKUPG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 15:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390529AbhAKUPG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 Jan 2021 15:15:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CC7B0216C4;
        Mon, 11 Jan 2021 20:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610396065;
        bh=nK7QkfzILQPfN04b1QRGUQYv21ri+3O5e8h3iqgyVLU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D8gnQRSGHj3uRmyELoMY3VPzWtXIdj5wgL/v51NCBe9xzeDqK02mB06IddkWGk9QS
         at3En2+VtJE4SQtCMkvITnsSnXNuh2zOaOkq/SD3aiDPVskE4UHEbhSG96hfGC8ntE
         LdZqnzEvlwi+yLUvJhp29HMSSE/zfm4ZrU2BgbHEyCziBpoDbfCIqFMC/A2X5LTkOz
         cgpNKfEzahFfe7McFxtJ2PEjc/a2qNn/UlwEJ6uh4QvFivNa/P02DkF0ysopoXQpYh
         hTF6llgWxduzPqJsydh/r5Qiay1GC8oqSWm0CIPHeo4RbaxGIaed2jNEestH6lNoYA
         RCMk9etJUXGpg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id C7570600E0;
        Mon, 11 Jan 2021 20:14:25 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.11-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
References: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/cel/cel-2.6.git 7b723008f9c95624c848fad661c01b06e47b20da
X-PR-Tracked-Commit-Id: 7b723008f9c95624c848fad661c01b06e47b20da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c912fd05fab97934e4cf579654d0dc4835b4758c
Message-Id: <161039606580.25323.4810673421260126722.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jan 2021 20:14:25 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 11 Jan 2021 09:40:40 -0500:

> git://git.linux-nfs.org/projects/cel/cel-2.6.git 7b723008f9c95624c848fad661c01b06e47b20da

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c912fd05fab97934e4cf579654d0dc4835b4758c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
