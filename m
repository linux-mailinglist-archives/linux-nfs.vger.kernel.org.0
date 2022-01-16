Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533DB48FB3E
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 07:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiAPGpl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 01:45:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39376 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiAPGpj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jan 2022 01:45:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23C13B80CAB;
        Sun, 16 Jan 2022 06:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEA94C36AF4;
        Sun, 16 Jan 2022 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642315536;
        bh=Lp9dKBhCU+tc7nQzJIMDq7FJnYgxHm0lbqNJKArgA6A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kUtJ/MN7J2A9eTYXj/RCwNB+3fdv8GZD773trSDwf2XgsxPxhGlxufDo6qp5prjvv
         BZuZVqiT/Giwz2XC4nsMa7vo6+UMHCWHvD5t4djbyubxwIHOclUcz8HxeIFYNaCm7F
         YlhjUlRVuqpNXyJbkvZNrOt3OARf+zcDhStLqFEVT34zvdqE4k/T/iAvgHC27IYFVL
         EPzIJ5+Y6BgtZn4H2tYtU/flJVE7liuvUUysRghHBYN4mf+riINeCwPX8p/tcIAR4d
         vI/2KQAAM/2ZK3qMuo196WQbwcB4f97JJDEjfLgdQENtsShxHFUYDoQgLEHe60tJsn
         zTvEP5NuLFt8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE307F60794;
        Sun, 16 Jan 2022 06:45:36 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6F9150E5-3591-4A8C-8776-CA34D063EB45@oracle.com>
References: <6F9150E5-3591-4A8C-8776-CA34D063EB45@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6F9150E5-3591-4A8C-8776-CA34D063EB45@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.17
X-PR-Tracked-Commit-Id: 16720861675393a35974532b3c837d9fd7bfe08c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 175398a0972bc3ca1e824be324f17d8318357eba
Message-Id: <164231553677.30539.4060710731248299669.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jan 2022 06:45:36 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 15:59:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/175398a0972bc3ca1e824be324f17d8318357eba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
