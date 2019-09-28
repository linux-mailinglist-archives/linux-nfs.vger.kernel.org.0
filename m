Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE147C0F1B
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2019 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfI1BPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Sep 2019 21:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI1BPF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 27 Sep 2019 21:15:05 -0400
Subject: Re: Re: [GIT PULL] nfsd changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569633305;
        bh=whttUDvXk++JXhtu9Zyn3rpOPkvHHU7pdnLW7VdLX7M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SKIWikqsEGZSPiu30AFiSkrdcN52NxPIhp9wIAxFWw6ooun1BPY1YanHs8kiVwoys
         0dICVuMmcGttocqAy2Eogssw41Kdu+eIhPVe15BceX8KaaRqYzyC+qkxgzbb/eeYF2
         GSOPr2xaFhZE1aNihRJXuvL1FIG3gTif6ne1TYYc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190927235554.GA11051@fieldses.org>
References: <20190927200838.GA2618@fieldses.org>
 <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
 <20190927235554.GA11051@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190927235554.GA11051@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.4
X-PR-Tracked-Commit-Id: e41f9efb85d38d95744b9f35b9903109032b93d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 298fb76a5583900a155d387efaf37a8b39e5dea2
Message-Id: <156963330509.27765.14952240842544717408.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 01:15:05 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 19:55:54 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/298fb76a5583900a155d387efaf37a8b39e5dea2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
