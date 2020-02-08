Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE915629E
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2020 03:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgBHCFD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 21:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHCFD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 Feb 2020 21:05:03 -0500
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581127502;
        bh=eDC7bDWZfRSLGx49tX2WezqUO5rMQQNGQ5ug0XVOteU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1bw1BEiyxXKD12PoezhuE5/d0hiW+ewPWrZZk5il+inhNaf73R1hyGa2HJqGnbEgZ
         ibjMFsFf2XYXXtnDJB3ZKG3IRZhDCcEO16LOSfQ6yf31z2kzHFJXGu71VSaq3t9yKe
         puo29SxPZ9xfrWu2w8m4Tv1iYiFshDiu5z3KAt7g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6a5ac820658697e7460006ddf08d10caeb7b33dd.camel@netapp.com>
References: <6a5ac820658697e7460006ddf08d10caeb7b33dd.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <6a5ac820658697e7460006ddf08d10caeb7b33dd.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.6-1
X-PR-Tracked-Commit-Id: 7dc2993a9e51dd2eee955944efec65bef90265b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f43574d0ac80d76537e265548a13b1bc46aa751b
Message-Id: <158112750282.31333.4017631717324710986.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 02:05:02 +0000
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 06 Feb 2020 17:31:18 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f43574d0ac80d76537e265548a13b1bc46aa751b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
