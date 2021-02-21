Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B21320CB0
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 19:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBUSkP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 13:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhBUSkO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0391464EB4;
        Sun, 21 Feb 2021 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932774;
        bh=K35BYwWJOUiRmKHMJaekn72d/gs1nA+u4xg2Hz108eE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JELh4Rpsoq26rAIK33Rk0L3sJFADidif6z9Rtd8eXg0u8ZbQbLNYN+ErDKpQ3kYdz
         KLUA+xNg1e7nXlUdkTKp+RUWUgKILj1WRzk1YLejARgrrXigfN5YzlCYPvIeAjXkE2
         2D2hkFDctn97CNAKUhpBIoZL7a6GJVMfjOOPSCYeXYIHNKqNyS4vvIW6wSc6YcFD1J
         Tq93/5rTzo+6HMAWdOA/BXOFc3MWTpEvNEsmEIQFzWbYB0Nt5k6U2Jtd59popxFNbN
         bJQcEIQ03Ko2I85Osu9eMjZyzWCbzAmD9Io1Hm3ZmtbWCxHkLAOz8tpY6bt6ta7O1o
         77Nb4XuxQ0Xaw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E147160191;
        Sun, 21 Feb 2021 18:39:33 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <E90C3C1D-7D82-40E5-ACF1-44CB86B362BB@oracle.com>
References: <E90C3C1D-7D82-40E5-ACF1-44CB86B362BB@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <E90C3C1D-7D82-40E5-ACF1-44CB86B362BB@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/ tags/nfsd-5.12
X-PR-Tracked-Commit-Id: 428a23d2bf0ca8fd4d364a464c3e468f0e81671e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99f1a5872b706094ece117368170a92c66b2e242
Message-Id: <161393277386.20435.6263856135032775414.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:33 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 16:13:13 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/ tags/nfsd-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99f1a5872b706094ece117368170a92c66b2e242

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
