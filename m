Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9747B376A7A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhEGTIm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 15:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhEGTIl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 May 2021 15:08:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A2C78613F0;
        Fri,  7 May 2021 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620414461;
        bh=Tj3uNUb7N+h1Jy4PXbgoWxtIhHNXgZgz0KcCUQsgOyk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i+IF2I81WnF4QAvFY4cZ6uALbUeIRPSmyPMhItdMjfqc7b8j2v2izoAAGDrG89QZT
         xsNLEozwVeS2Rxlg7zuRvC8j3nBhcp2spYF+JJJSemk090NR5Sv8ma+1gxtD4RWWM0
         hPXyVwmoji2J+r3O9Q6TCBOGmxTw5wBPRE/Pw5aZdN2KYRQ6DERqwDmocoBzpMMcia
         imevJycvIYWg5SXVZZB1ctcVLH8pX+o5PNPgbOs0fqgAj0uiqVeDJRaFkGZo5CUpyG
         7lfbhiZx3vep4en8DXjUjRofD+QDahJVf48HE1xx9WiEPODSIOH6dQ2obTGPHsE2er
         l+NJx/aVXg/Xw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9D87C60A0B;
        Fri,  7 May 2021 19:07:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client requests for Linux 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7895439af9444064f1917fd94a2d0e57ef51a686.camel@hammerspace.com>
References: <7895439af9444064f1917fd94a2d0e57ef51a686.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7895439af9444064f1917fd94a2d0e57ef51a686.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.13-1
X-PR-Tracked-Commit-Id: 9e895cd9649abe4392c59d14e31b0f5667d082d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a647034fe26b92702d5084b518c061e3cebefbaf
Message-Id: <162041446163.12532.14050231539673153503.pr-tracker-bot@kernel.org>
Date:   Fri, 07 May 2021 19:07:41 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 7 May 2021 12:14:55 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a647034fe26b92702d5084b518c061e3cebefbaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
