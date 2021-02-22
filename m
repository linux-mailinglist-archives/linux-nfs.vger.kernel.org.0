Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417C322181
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 22:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhBVVgE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 16:36:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhBVVfz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:35:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1AB1D64E4B;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029715;
        bh=4fn7aF/ZTgqYL/9w51TgbiJuVcTUs+5V/uMqmc3Sv+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iBTLVbWY1gbgDrdoZW1WqZsv70R4dJniFZFCH2qDv9ZG4a3wMgJf+FY7iDw2i1oet
         eKe18GZMjmSlGP6AO7JbcGnEu+mcqTFv7J4BlAhcGpTmhwZZmN5cr7QnxFn3liyyyn
         K+YGYmHpRGxsC7lbvbwnfWEo1baXenpUXH7tYFTKrQjM91EXkkWfPlVUJp8S835dQw
         ExTsRdZcYBLtBu5aabPsFH6fZKlFuIQOdlsOs7Q3BgVZLh7GfQVHSzWtlZeWd7QcQV
         W16Lcc38acUSqDRDENlX9mypbghI6cB3o9iRayJIcIUHsHqoujVy3G9E96bRLmME9/
         4KM0JpU9/4Vig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1619E60982;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] a few additional nfsd changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <73C9BC02-D5AC-4F17-BEAB-1BD5D99F5D6D@oracle.com>
References: <73C9BC02-D5AC-4F17-BEAB-1BD5D99F5D6D@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <73C9BC02-D5AC-4F17-BEAB-1BD5D99F5D6D@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.12-1
X-PR-Tracked-Commit-Id: 4d12b727538609d7936fc509c032e0a52683367f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c70f3a7488d2fa62d32849d138bf2b8420fe788
Message-Id: <161402971508.2768.5108767141420295738.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:15 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 16:54:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c70f3a7488d2fa62d32849d138bf2b8420fe788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
