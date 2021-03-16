Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF633DB27
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Mar 2021 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhCPRnF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Mar 2021 13:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233848AbhCPRm5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Mar 2021 13:42:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F8F96511D;
        Tue, 16 Mar 2021 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615916577;
        bh=lmmj31OE8li6idVZs9vPuQ1WFwY2Rru9FjaQ+ehouzc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rBcBgFnuVYCAzn9QUShijIlTVPYkBhEMH7nBwJMuZUmp2GsbqQoNQMW3aD3iMs3Du
         lW1C7657lH4D1qb6LmA3J3ARlXL0qwEgfZxA4+2ydwqEJsFnIHzvDDg9VszcSyPMWF
         WN78LiRR5KSjmqtT2HNfcRoAbrgyV5kq/skR1B+/3ACg0Tki7jChL8sd+XJwx6jGj1
         Eve/qPsNh6t2oXRYiba5ZxvrVxurnHDJBxezn+/zjw5z+BI/VGNuVTiSnRtKFpdjkX
         54N7rCCZmdRVXaCy/Y53RuQHEQAUQ6vRq51Bsngmp6jOwiyUfrR/6BZ7rM3+J4K3W+
         x02HZ/OIVgCgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2791160965;
        Tue, 16 Mar 2021 17:42:57 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 5.12-rc (first round)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <B73DACE8-1CFE-4289-97E8-B99D0F0F99DC@oracle.com>
References: <B73DACE8-1CFE-4289-97E8-B99D0F0F99DC@oracle.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <B73DACE8-1CFE-4289-97E8-B99D0F0F99DC@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.12-2
X-PR-Tracked-Commit-Id: bade4be69a6ea6f38c5894468ede10ee60b6f7a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4108e101972ce4e25d87fd4806b182505ef22ee8
Message-Id: <161591657710.21676.8832330882122273020.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Mar 2021 17:42:57 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 16 Mar 2021 13:44:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4108e101972ce4e25d87fd4806b182505ef22ee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
