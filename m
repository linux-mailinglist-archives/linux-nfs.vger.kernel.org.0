Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84623F8FB0
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbhHZUeq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 16:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243524AbhHZUep (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Aug 2021 16:34:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C2DFD60F91;
        Thu, 26 Aug 2021 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630010037;
        bh=GpK2Mk72crojLmxnXtc6IdinZkQazN0O5/PZ34RkQh4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wbs82FAbaJxofn6BOsRbNhYS9j60/CaND1FGfGh3B9XtczKwqA2U/VqZEfIiMcCXA
         Ms+4V5HdnlSCAFvw+1Dbs9yBVurJRRcxd6XWcsmYw16LAjtU+HXcPs3RXTITN5ZmSu
         vesAVbjgVWwXUh9tw6EMBW2gHzTbM3kJSBSh3Gf+vikbCwBxxjFl3KNP8iErjQ76NF
         dkJ/KK0jq8a1M2Co0AWhLxD5+2vdhWVpo7SzOee0Amoh7EcWCm0DP6PpTGshEBrGRA
         4iKkODQ6TJJfBbXOafkpNmzUKVuc05grVM5k8qvpD1UMj7VTLz3gZOr3RytgdZsYd5
         eesGA1fqJxVTg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BC9CC609EA;
        Thu, 26 Aug 2021 20:33:57 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd bugfix for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210826191700.GA10730@fieldses.org>
References: <20210826191700.GA10730@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210826191700.GA10730@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.14-1
X-PR-Tracked-Commit-Id: 062b829c52ef4ed5df14f4850fc07651bb7c3b33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73367f05b25dbd064061aee780638564d15b01d1
Message-Id: <163001003776.31497.3700186210114504893.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Aug 2021 20:33:57 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 26 Aug 2021 15:17:00 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73367f05b25dbd064061aee780638564d15b01d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
