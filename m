Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F14425E7A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhJGVSN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 17:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhJGVSM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Oct 2021 17:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F9A761077;
        Thu,  7 Oct 2021 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633641378;
        bh=gSJwisStepASGNw1gIVmk/BzlIDsDPAWoJ7vb8f34vo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dnZuxSFFk7QxiZ67eBMht2hoBV1ud1/4Lmdt2UTJ+YKlKPDAmk6lm8CPwEFQxFLEj
         z+/UpqIk/fhOG6KFXikqWTlnsOquzUhQqCgj7ya0Jzz8cAZ4Q7eBGl0gpLHpYy9kdB
         Zfr9Pd3tPmRC0YbTYg+wlJCS1p/bbHqejWUfYkLLh64MHaU7OKLPQHXqtDfdz+2R3s
         Q6ODBNMHg151vTkOPr4OAHZF798JbSLKV65zBQfAMW4mNwXt+OoZWAp8Q5eB2keuvG
         uTZCmHofwDmgTaJd0uj/QBde5Mpnn38XxyMSla3Gwe631ClkoXfWlgHWh5RWf3k1VN
         SV5bTIPJZZxaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2F8406094F;
        Thu,  7 Oct 2021 21:16:18 +0000 (UTC)
Subject: Re: [GIT PULL] more nfsd fixes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <39B6F288-2C96-4FF7-955C-43CEA8AC9075@oracle.com>
References: <39B6F288-2C96-4FF7-955C-43CEA8AC9075@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <39B6F288-2C96-4FF7-955C-43CEA8AC9075@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15-3
X-PR-Tracked-Commit-Id: c20106944eb679fa3ab7e686fe5f6ba30fbc51e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1da38549dd64c7f5dd22427f12dfa8db3d8a722b
Message-Id: <163364137813.4361.11032488844279463381.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Oct 2021 21:16:18 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 7 Oct 2021 20:06:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1da38549dd64c7f5dd22427f12dfa8db3d8a722b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
