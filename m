Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D3454B56
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhKQQwO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 11:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhKQQwL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Nov 2021 11:52:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 00A1F61360;
        Wed, 17 Nov 2021 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637167753;
        bh=dJgr49md2/DJwvQ4nf8T3TAiN7Q3mQ/A2us7fsZdIZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DPeydbZgNAXY3VJGvIQ4Qxti+uU+YMdXY+hdpdisyilkIqzomMv8iG+MhDFsleIhH
         rTrv87corY+sE1yy46gmOaBXn6tp2jOY+A3GxR5u2ycOp7kmfH37q9R2HxIAOi92y/
         ucBZFPcxNuvYU2/Xyw05CnB2OZnBUPhbDuMXlri+N8yM4z9hoAQJ4wwSODVEcLUPF0
         UvIMLDjB0KONYAwaNKgY7GXMauIJ2xe393g0qK2ghACfS15MKoeGg+byDhvKuy5S0U
         aanE5Z88eXVzosvQw7Fd3YfwBAYWl+HGHUVrFfYaEhlXhU1kiYt87mI+LDvVRHrrjP
         Cxo3oLkKmhNbQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EE73160A3A;
        Wed, 17 Nov 2021 16:49:12 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd bugfix for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211116015332.GJ23884@fieldses.org>
References: <20211116015332.GJ23884@fieldses.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211116015332.GJ23884@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16-1
X-PR-Tracked-Commit-Id: c0019b7db1d7ac62c711cda6b357a659d46428fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef1d8dda23e7df10b48c90f86b12c9b4c62da1ab
Message-Id: <163716775296.2428.13725518141872334049.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Nov 2021 16:49:12 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 15 Nov 2021 20:53:32 -0500:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef1d8dda23e7df10b48c90f86b12c9b4c62da1ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
