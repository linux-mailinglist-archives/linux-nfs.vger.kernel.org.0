Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA9310FB7
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhBEQdc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 11:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233729AbhBEQbV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Feb 2021 11:31:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 74C4F64E4A;
        Fri,  5 Feb 2021 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612548782;
        bh=4BABv1Fg4Fs9XA1ap2A5Q3xhnkIKdd8jyyYbTJrrDOA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NctUk10QMTBUnujMSAO1Zi29LWauixxr2GOhM1u/omK3yFicXqGcSNu1xRB5WHnl1
         ichRm+z1MoFTsK2w74BgoOFvjJyVLeb+VwLD5MbyLWog2yKLt+pOM8VYAm4DtADc8R
         /U3JcaBVJ5dexnEIb0jFdHzBilxqvxTxBvRgpKcWc1MpbTaLIG4ETQS2+KiiA/QykW
         iMkJQcDWmq3BTKydA2cERIaAZAQ2kaD0HoAIOHsWMdx8LqAKX03FeW31uOtwDDQlWU
         NRAN8OVUSdM3TNRYR01lwv4SDm7oJ64h0223Z5RsbooA5ywOnyMVmPa7NkdyQoLrpn
         hGU8U+J4PbWsg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6F41D60978;
        Fri,  5 Feb 2021 18:13:02 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.11-rc (third round)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <13567C92-64A5-4165-909A-2CD199285C7B@oracle.com>
References: <13567C92-64A5-4165-909A-2CD199285C7B@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <13567C92-64A5-4165-909A-2CD199285C7B@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.11-3
X-PR-Tracked-Commit-Id: bad4c6eb5eaa8300e065bd4426727db5141d687d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17fbcdf9f163e6c404c65bb8c17cd8d7338cc3e7
Message-Id: <161254878244.14736.440102464879736520.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Feb 2021 18:13:02 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 5 Feb 2021 16:42:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17fbcdf9f163e6c404c65bb8c17cd8d7338cc3e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
