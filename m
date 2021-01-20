Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDE2FCA1C
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 05:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbhATEvU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 23:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbhATEvD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 Jan 2021 23:51:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3FB652313A;
        Wed, 20 Jan 2021 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611118222;
        bh=MLrutSGoQ0+r8mDYryLJ4c98mV61Zooygjg7lFKDXJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VTE4eX9kke/obWbH41IMn2QYJqwTwsYgWCVdjyHnupDK0iiYJRKgmw2PVnWrVqwE+
         Ntdncb5LiaH/0UUNrlE5iXefW4/UDYjg0e3Kw3l8987FfHhKbgielJH+yzpZ7owjeF
         fpb8C8nJU4hR4GE5B5555xA2plmWsGfvuhEogLz2WEdtT1XL/AojUi865LcwoX4Qs5
         lfSmHW80//hK15AzvmhCR1IQa4Cg44LKJuRtisljFg/7qp/kD8bVhqC5N6qt3n8srK
         2tDyPePnCZR4cEoPVQC7pPLeHvg6bd6MZGPS3bamUTWq9DdU1hRf+2MvJPks3tYcxA
         Xo5tVRq0riwPA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 37C10604FC;
        Wed, 20 Jan 2021 04:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.11-rc (second round)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <04E864E1-CE3F-4DEE-9A0E-CAC4DEE51D7B@oracle.com>
References: <04E864E1-CE3F-4DEE-9A0E-CAC4DEE51D7B@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <04E864E1-CE3F-4DEE-9A0E-CAC4DEE51D7B@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.11-2
X-PR-Tracked-Commit-Id: 5f39d2713bd80e8a3e6d9299930aec8844872c0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f419f031de1498765b64ddf71590f40689a9b55c
Message-Id: <161111822222.31434.13485546994322587969.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Jan 2021 04:50:22 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 19 Jan 2021 15:38:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f419f031de1498765b64ddf71590f40689a9b55c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
