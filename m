Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B96400CBE
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Sep 2021 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhIDTBv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Sep 2021 15:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234432AbhIDTBu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 4 Sep 2021 15:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 12A5360F4C;
        Sat,  4 Sep 2021 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630782049;
        bh=wX9j9tMKB/jQvhCxHoNQ0xqUeNjFr5myRg7/UMXA3rQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HPbSe17RcVt5BMkLoWfbpfbH879fCVFtpIukWhJr41rMoZAbr5LgmE7K+abw5Lb70
         0JBnYqCL7z/5PfEmrSbmYnbnn3C3vQJCMICcXmodxkaRgVsPfZ9SJsxRzys8tDB0v7
         ligp3+Wltbluqn5zXxyl3FvrmZkDkJqAzFgdeFrMOSnqXSvllscOaYDo8Z80p1woNp
         vjI4wlh2c3Nw2Q2M1QAuhdv6Aridf/tsa3pd380nSdRs8ormkli0ZWUHOg4UdDJ/1E
         9l4EErKJ6KMWws8+ezPcRB/jYek+fS2AxxS0+9JQF79YiogV/4jqKsVD/5t0eTyOEq
         Y99BBvzYLbALw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CB8E60A17;
        Sat,  4 Sep 2021 19:00:49 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAFX2JfkOaSFppXPn+o=nwyzFZLWxyHX4_rFEBeJx=fA_G7_6ZA@mail.gmail.com>
References: <CAFX2JfkOaSFppXPn+o=nwyzFZLWxyHX4_rFEBeJx=fA_G7_6ZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAFX2JfkOaSFppXPn+o=nwyzFZLWxyHX4_rFEBeJx=fA_G7_6ZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.15-1
X-PR-Tracked-Commit-Id: 8cfb9015280d49f9d92d5b0f88cedf5f0856c0fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0961f0c00e69672a8e4a2e591355567dbda44389
Message-Id: <163078204904.10287.2699315668847840662.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Sep 2021 19:00:49 +0000
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 2 Sep 2021 17:22:47 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0961f0c00e69672a8e4a2e591355567dbda44389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
