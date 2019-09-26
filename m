Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9ABFA71
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfIZUKE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 16:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfIZUKE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Sep 2019 16:10:04 -0400
Subject: Re: [GIT PULL] Please pull NFS Client updates for Linux 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569528603;
        bh=wMNBPFcaE4vWI6ONdeFcr/WV5DkaZXPipdTW5NX3iG4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZoacfFtc47qQt4LSO/wHSldDE+u+/JN/7+UfboNvn4zYYD4X+g0Yt8NHTNJG8h4eH
         mrrhw62MBLLqOhLxfseUQeioJTUsZP3w9imxDNTWvxEa801dZD56whlpxFua4ohMmg
         5vN/D2u4z63GGtyJn+c3235njzR6yIb26hR3TL9s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8448ef6bd5fa881b3114ca30d2e71730ef357e4f.camel@netapp.com>
References: <8448ef6bd5fa881b3114ca30d2e71730ef357e4f.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <8448ef6bd5fa881b3114ca30d2e71730ef357e4f.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.4-1
X-PR-Tracked-Commit-Id: a8fd0feeca35cb8f9ddd950191f4aeb777f52f89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 972a2bf7dfe39ebf49dd47f68d27c416392e53b1
Message-Id: <156952860345.24871.1430075400174501894.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:10:03 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 19:13:30 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/972a2bf7dfe39ebf49dd47f68d27c416392e53b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
