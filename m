Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7681F6D63
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2020 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFKSZC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 14:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgFKSZC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jun 2020 14:25:02 -0400
Subject: Re: [GIT PULL] nfsd changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899902;
        bh=D+a/v3b1rEutML0pkkNJGDHkgaOU2pFJT6eV0aeMpnk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UPD0UorhXBS+EZuczB6Bqk4LmIwAoQC53NKd+LY6QGJQ82/ubncd80MCC15gO4imd
         rp+1TutKh2QEjAVA1nCnEDMsuSHNZj3nwG8VXmuY2pMD4eMVhCckfb6oNzjbAzmNEM
         /oEjDdHbr5j3Z6XNnR3h61CSB8KNMY/X25rA8Fz4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200611155743.GC16376@fieldses.org>
References: <20200611155743.GC16376@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200611155743.GC16376@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.8
X-PR-Tracked-Commit-Id: 1eb2f96d0bffb2cca1fb7249ad9b6b4daa1d1d6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c742b63473b3c5180db8b5d74fdbd56e4371dfa2
Message-Id: <159189990249.7248.5024233513278020801.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 18:25:02 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 11:57:43 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c742b63473b3c5180db8b5d74fdbd56e4371dfa2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
