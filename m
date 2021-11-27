Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A8460106
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Nov 2021 20:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhK0TD3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Nov 2021 14:03:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60840 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355981AbhK0TB3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Nov 2021 14:01:29 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C765B80931;
        Sat, 27 Nov 2021 18:58:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id E6B2C60041;
        Sat, 27 Nov 2021 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638039491;
        bh=fJnJOos6hKxOm1WT8DmeYABgAiLyQjyHd5tyT2FZdpQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DnOFYt5FeDQ1igT1DDeQuYcui496NCMmlE+jqUphxkmi0jpHawJ5JLDxgc9/Jg7cW
         j6Se3usznjLoqBtDdY/pMyEngTLvRALb4IUKPUTJ8lJ3mmRceJ1S+VoTM08AYZUW/0
         SdE31iRvdTbAGydX2JMObH7ZNXZbuS+7sftW5/ROp+kNBC7cvsaLgmClINsCNVhjPx
         7cSS9ITAMdM+SElma4Z30qw/DOmblxGNiHQPcnNw53oRQbMyWr//TfPBWGbcpOWLQ/
         Hfcbj22SyMJHN+Le/yUbeB6eVc8kIxbTXunJYSU864dB9OG7YqCuRUB3Fji5N1qZ0p
         NUcvAU1LRjm8w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D20EB60074;
        Sat, 27 Nov 2021 18:58:11 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8b451da7c237eae6e008f00cfc3b8aad6f5d8b67.camel@hammerspace.com>
References: <8b451da7c237eae6e008f00cfc3b8aad6f5d8b67.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b451da7c237eae6e008f00cfc3b8aad6f5d8b67.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.16-2
X-PR-Tracked-Commit-Id: 064a91771f7aae4ea2d13033b64e921951d216ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7413927713388c21d844b38444fb2b91e077ab2f
Message-Id: <163803949180.17852.5028387960112630711.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 18:58:11 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 15:32:01 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7413927713388c21d844b38444fb2b91e077ab2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
