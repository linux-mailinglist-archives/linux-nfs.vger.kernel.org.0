Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31E62DB9CC
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 04:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgLPDpf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 22:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgLPDpb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:31 -0500
Subject: Re: [GIT PULL] nfsd changes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090258;
        bh=y0DB4jaEiyrLaH6oYMTFSe14OftHTQZ1T+QPUHktxHE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ReWM+M+0wpg4A8G8Mq+dxMGuS2BUy27uu7FsGfFQJuBi6J6HUpkCZpdyQj2DKUbUX
         yQgjFuTsodpsb5i50vbOwk856qe5gD/OsdzPYM5k97mvNQb3ojC79yffhtGGmG0nkQ
         FgNpmzoAR4z7bIz4mwam+rp1Beoq98hjJUHSyxPBRnhVQc6Swk2A1ZtJ0P/4YWvsnR
         GbMId85dlqGehRdbH7o15ri46CO6R03WY3svbCYEUOarTVBDgEfRZG9YyAy4OyHT+I
         8C3G9/GzyiU4ghFhyGGbCZjkryKEHH3Sjlv/qY/JkAcvQ7iHbR6mtflflNZJr4MHwb
         iWkMLqN1ndUOQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <200F1E47-2C8E-42FB-A661-0139F424C0D4@oracle.com>
References: <200F1E47-2C8E-42FB-A661-0139F424C0D4@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <200F1E47-2C8E-42FB-A661-0139F424C0D4@oracle.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.11
X-PR-Tracked-Commit-Id: 716a8bc7f706eeef80ab42c99d9f210eda845c81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a50ede2b3c846761a71c409f53e9121311a13c2
Message-Id: <160809025822.9893.12720781442898862731.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:18 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 15:41:13 -0500:

> git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a50ede2b3c846761a71c409f53e9121311a13c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
