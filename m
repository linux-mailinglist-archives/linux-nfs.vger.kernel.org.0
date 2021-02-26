Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6F3266F5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBZSdh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 13:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhBZSdX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 26 Feb 2021 13:33:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D2E0E64F2F;
        Fri, 26 Feb 2021 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364339;
        bh=Pi2T9EsTZpM5Lgobx8xXQaJ3yEdalbwpqMXDQeofbrY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k3ixHN5WYT3BgB3NPmdeZaVx2AkrkgOFLo0QAma1T+L+xG6Wa8hAcnHe1/IO9CDhf
         6Zae/rmWi7vYKiNXNI7xBYuHwnwGE2kDgTvJXhtES5D0b32uvVpj+zG/si5z2iqCpT
         M+PVH25zwYdMjnZ/H2eVrwhEwVy89HBqX4BSVJ5zOUTUWH99zsBhfK34bOnSvKwehT
         6z1JJ+6Stp2TW8FylCnseI9X4KdhZyBi4U9cypdFVsQw/wTG26wztA0mwtJbHgzQku
         sKu9FScg3iJcecSG/jzQkAC7lEwz+ne9t13+dm7SupjoIM61G+MbV0Z+Jtbt+gKOjI
         QgSE84PqSNwnA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CF132609D0;
        Fri, 26 Feb 2021 18:32:19 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client Updates for Linux 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
References: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.12-1
X-PR-Tracked-Commit-Id: 7ae017c7322e2b12472033e65a48aa25cde2fb22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c9077cdecd027714736e70704da432ee2b946bb
Message-Id: <161436433984.9780.12191524580869722398.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:32:19 +0000
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 17:19:45 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c9077cdecd027714736e70704da432ee2b946bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
