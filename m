Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12C444CE9B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Nov 2021 02:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhKKBKp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Nov 2021 20:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232621AbhKKBKo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 10 Nov 2021 20:10:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A9FFB619A6;
        Thu, 11 Nov 2021 01:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636592876;
        bh=Os/nGoCntru26Hn7elgDYfFUD1gZ954VnRevSbRRgtE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FlkQYQQOwaLa3exNOzKcHJedPf2DOOc+cuJ4lufRkCLYDBegbpzrWBavKM6CnSd12
         eCEWgG4vVvgImEPvsXy30vX85pe1Cqdxy590nYcDpO0MS/0ED0jpguhlanncVkGs8i
         y8Fl78wtwfG969BiAMFlfQEEO7eNAOUoLYlPDAmKWcqwpZMDTjyuG5C3FADKQtqf9x
         NMzaekxmsUdyhRdp9dPZ7f/Xlj7K9PKf0u/73a4+pyFepf3J4ohxgGsTG0D8aRZ6hP
         u5xZpSr31X20cEICH/eEI+/Sdi3LuLsjQK+KcOLpyH7Y2rVB8VDACZ+dV/qfJbzj6Q
         7P+JU/m6AZZ3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A11746008E;
        Thu, 11 Nov 2021 01:07:56 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211110215022.GA17888@fieldses.org>
References: <20211110215022.GA17888@fieldses.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211110215022.GA17888@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16
X-PR-Tracked-Commit-Id: 80479eb862102f9513e93fcf726c78cc0be2e3b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38764c734028bf0ae4cf262f3eb7d965c86298bd
Message-Id: <163659287665.32583.4714912593557446253.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 01:07:56 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 16:50:22 -0500:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38764c734028bf0ae4cf262f3eb7d965c86298bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
