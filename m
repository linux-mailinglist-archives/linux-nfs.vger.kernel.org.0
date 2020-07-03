Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2000021339F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2020 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgGCFkC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jul 2020 01:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCFkC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Jul 2020 01:40:02 -0400
Subject: Re: [GIT PULL] nfsd bugfixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593754801;
        bh=kNleJkAWKZvx+iwUJt4yKWIGyM7h176BHp1WjJbIc+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WAtSYguye5SVxrjo49NlzbjbIu1qTJpOrWsJrzXpia3Ki9qXMFuxod9ngPqU201n3
         CBLGzhTCyr3l2a/A7bOaTpvklgH5Htcu9x9mVqSvHQNyMXRGqZ2SQmZPm7KOZWkssh
         jnQfJKHaSoRA976xLCO51ssZ6eDVMY3f0OYjlJ+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200702151039.GC6904@fieldses.org>
References: <20200702151039.GC6904@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200702151039.GC6904@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.8-1
X-PR-Tracked-Commit-Id: becd2014923ff259b8155df58199f605dd50cb8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 083176c86ffae8c9b467358eca5ba05a54a27898
Message-Id: <159375480186.400.10690168272088373129.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 05:40:01 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 2 Jul 2020 11:10:39 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/083176c86ffae8c9b467358eca5ba05a54a27898

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
