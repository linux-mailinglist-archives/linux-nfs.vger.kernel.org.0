Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEE2B8561
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 21:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKRUNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 15:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKRUNy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Nov 2020 15:13:54 -0500
Subject: Re: [GIT PULL] nfsd bugfix for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605730434;
        bh=tLbWWVsVbNP13mpIn0rfCT4xsjB4FKjy0g0G47H+PUU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l+hL6FWgzcoSoluidZBeMaq48fF4Wv/6QTLNzfXqH1epPWXPMPuxQJtfFS2lEavRg
         ne8xpLKebuYUgFUjV8mkYoHtn4qTE/HPZRIfrcMd9ecice27bGVZXsKcc91X3PZD9u
         kbaVsrEBeCqJBl6ZiS/rU/8MCxvMd31KoLsw9SU4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201118151513.GC7320@fieldses.org>
References: <20201118151513.GC7320@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201118151513.GC7320@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10-2
X-PR-Tracked-Commit-Id: c3213d260a23e263ef85ba21ac68c9e7578020b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce228d45942492580968d698b0216d3356d75226
Message-Id: <160573043437.16719.8380223673835473520.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Nov 2020 20:13:54 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 18 Nov 2020 10:15:13 -0500:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce228d45942492580968d698b0216d3356d75226

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
