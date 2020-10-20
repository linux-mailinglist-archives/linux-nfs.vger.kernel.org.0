Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2558E2944DF
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393074AbgJTWBF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 18:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392670AbgJTWBE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Oct 2020 18:01:04 -0400
Subject: Re: [GIT PULL] Please pull NFS Client Updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603231264;
        bh=bfvW5CJ+Dvsog6QgaelPdcXCjo+UyYF3TNk8KIsmeOQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FGNHBDJU1PvJZL/iv5zZt17eARgg33Ton0yzaTDa3PO3w7jCggoAo/jFUmh2xMjAa
         Poy5W2CjSQ4k7SFY+mfmoQtoQh6k/K1iyo3GlN6wxP+xoS1nBBS43DcQWbyyyi14M4
         NmrSWHKKds9K2fOpEO7VLCWmPY1aQIwfLLoPdEsg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAFX2JfnGTLccrN4x2FB_m8v+_gJNXCYFfQf=O50mfouiCd+Vsg@mail.gmail.com>
References: <CAFX2JfnGTLccrN4x2FB_m8v+_gJNXCYFfQf=O50mfouiCd+Vsg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAFX2JfnGTLccrN4x2FB_m8v+_gJNXCYFfQf=O50mfouiCd+Vsg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-1
X-PR-Tracked-Commit-Id: 8c39076c276be0b31982e44654e2c2357473258a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59f0e7eb2f9ffa7715ca95908797b52ba35af11a
Message-Id: <160323126398.2890.17389048433911822002.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 22:01:03 +0000
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 20 Oct 2020 14:55:52 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59f0e7eb2f9ffa7715ca95908797b52ba35af11a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
