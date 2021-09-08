Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAB4041C8
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 01:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhIHXcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Sep 2021 19:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235669AbhIHXcx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 Sep 2021 19:32:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D95660F01;
        Wed,  8 Sep 2021 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631143905;
        bh=WtDQjcQN8asSXHXwzo1/oNs2PkXSeLTZU7UqAwvOo/M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uTrsFe+ODiCTdyKnHGw+4wXO9w9t0Uq5ekZgdoFoNp3g15KrnULPcu4hFAcguC1oQ
         F9ftFlu0T1GkVVoJvSN+0J93DRYXIpRrWybCG0dmVpQrZtpU/HPRT+iG1Zz3iW1SBk
         43XDyDhJcI/qZEdwA1GbjkYU93kdUZ9apBb6/7M/8jiC+XMTZHsKUQm/qeJlnxTtNQ
         ZXQFIKDaLIrztxdNa+Jr3chAHQkAzJAokDbrLcw3oSZMrZgBkwc6LIzUzqSbPyfCGA
         gvxx8Al6Q1ts1ChxeIKnwVsHbAYDzAMktnbSTFIoFSJQoaTHFsifRNAO0ZR0Z+cAb0
         iQ2KpQj0Gv7jg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 476E860A38;
        Wed,  8 Sep 2021 23:31:45 +0000 (UTC)
Subject: Re: [GIT PULL] more nfsd changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <01D391FF-7022-487D-9659-D36AA4947CC0@oracle.com>
References: <01D391FF-7022-487D-9659-D36AA4947CC0@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <01D391FF-7022-487D-9659-D36AA4947CC0@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15-1
X-PR-Tracked-Commit-Id: 0c217d5066c84f67cd672cf03ec8f682e5d013c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14e2bc4e8c40a876c1ab5597320d523c12a97f39
Message-Id: <163114390528.13056.6755936169488437107.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:31:45 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 17:47:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14e2bc4e8c40a876c1ab5597320d523c12a97f39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
