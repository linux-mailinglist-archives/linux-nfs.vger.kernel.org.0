Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F68116009
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2019 02:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLHBKE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Dec 2019 20:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLHBKE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 7 Dec 2019 20:10:04 -0500
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575767403;
        bh=2h7clWFiCRfAkjiVhopDaAGV3evdxGbSsY0iJjMtIuQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LXH9PrKleFZ+NHLjy2TqTUNpWWCCtXsSIxIzOkT4i/memfpWK4lEYAxFp/Lo7jF22
         Ox5DYBkx0+TkCepcyY8ORYXuqKjCdn441+/6SaeYDm2e1FmR5QIEsUif9pngGeClTy
         qQ2WQhn80GBasb/wNZPTyWEdLzFZJfF6mZPmQsf4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <71a579b2d8e4225902b37f4ac12d074d8a0d71c3.camel@hammerspace.com>
References: <71a579b2d8e4225902b37f4ac12d074d8a0d71c3.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <71a579b2d8e4225902b37f4ac12d074d8a0d71c3.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.5-1
X-PR-Tracked-Commit-Id: a264abad51d8ecb7954a2f6d9f1885b38daffc74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb9bf40cf028ebbe7d5bdf8f7e93abe8e30bed0d
Message-Id: <157576740385.7292.2441886593175349222.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 01:10:03 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 19:14:01 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb9bf40cf028ebbe7d5bdf8f7e93abe8e30bed0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
