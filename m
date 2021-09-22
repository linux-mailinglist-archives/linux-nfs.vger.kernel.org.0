Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4A414E25
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhIVQdH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 12:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhIVQdF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Sep 2021 12:33:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2721E60F3A;
        Wed, 22 Sep 2021 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632328295;
        bh=jqkvTGXd7AjwV0CDGRKqfX57bAup3syzArEuQEd/uHs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KvFlcTAM9IIIg06XXUvp1+wmMbb0qwELgwnTzB222SdeTbiy68hi/BqfZjZvk53ZO
         MoqoanLstAcJVJXtC1Pu87C3EFVORbgm1J46VyK9xuccTzh7qpRTcmJW0RSAk2Q7DN
         IiopHxJAwYSFVwgwTntW6Ss62w5rOsSG6r19wt8xgi2f6TyHv6USIB3PzXeVmDMG5M
         K9T2iwEFvhM1SxYqV25a/i4jZH9CMB4MIK5mcPwtTTHpJRrtyghCmiGvTijLXz1Wjc
         poirj1EmpsmY0QHT5FaGpGyDY4F/mQUkQw8dY5Ue9hEmPmNMf2PGmrWjoP8aj+B+3T
         0ZQkgHoO9qO5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 13D56609D3;
        Wed, 22 Sep 2021 16:31:35 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5EFAF4B5-BAC2-4A6D-9C33-07B714FF00B0@oracle.com>
References: <5EFAF4B5-BAC2-4A6D-9C33-07B714FF00B0@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <5EFAF4B5-BAC2-4A6D-9C33-07B714FF00B0@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15-2
X-PR-Tracked-Commit-Id: 02579b2ff8b0becfb51d85a975908ac4ab15fba8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf1d2c3e7e2f3754fe3d6dc747f7a092b168d9cf
Message-Id: <163232829502.9122.2953252682027946866.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Sep 2021 16:31:35 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 22 Sep 2021 15:56:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf1d2c3e7e2f3754fe3d6dc747f7a092b168d9cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
