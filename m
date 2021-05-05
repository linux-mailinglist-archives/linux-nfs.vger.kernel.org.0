Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C593749B3
	for <lists+linux-nfs@lfdr.de>; Wed,  5 May 2021 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhEEUuj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 May 2021 16:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhEEUu3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 May 2021 16:50:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BD7E2613EC;
        Wed,  5 May 2021 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247772;
        bh=AP3irDjXHLvvnt6/4olMg5U7kVl0ZwI+NF3LxPr2kMM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RvYuF6UjC8IJwJTn3ItnngATVD0GjL5lqz9AjDImlYeFjIIUOdnQZXhiOfhkh2Xwu
         sAUF3cG43o8S9ul/uQzkGWFA5f/6EtCgWULiTUDoDtf6WXy8AlWtyeeQufrMlCMCao
         fo1uV9jYIL+13h/CHiYe7VsvudsH4tlO/HHl8QnpcOlODt+u7hkcFfHQwEM4/CVFB/
         fuU+mSC7eBxY/gbbZq8ULuS549lNGqhFLXFf2YcxtB4c7w/ogfiTLu1QyXemmPofxV
         QCBfFuuedDsYiFVPdzzRZdrkCd1IZk4tEyQ28WTTWHqWrqOkpN9/4CoiyDy/YXvItq
         /9oo5kvQ0b7yw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B8340609E8;
        Wed,  5 May 2021 20:49:32 +0000 (UTC)
Subject: Re: [GIT PULL] more nfsd changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4FD9AA6A-3880-4C39-9A32-F22A42ADB508@oracle.com>
References: <4FD9AA6A-3880-4C39-9A32-F22A42ADB508@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <4FD9AA6A-3880-4C39-9A32-F22A42ADB508@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.13-1
X-PR-Tracked-Commit-Id: b9f83ffaa0c096b4c832a43964fe6bff3acffe10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a79cdfba68a13b731004f0aafe1155a83830d472
Message-Id: <162024777274.12235.16163291295420630973.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:32 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 5 May 2021 16:20:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a79cdfba68a13b731004f0aafe1155a83830d472

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
