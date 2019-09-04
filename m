Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B55A9232
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfIDTKC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 15:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731901AbfIDTKC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 15:10:02 -0400
Subject: Re: [GIT PULL] Please pull NFS bugfix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567624202;
        bh=B0u7KtP/S4qWMpiog5R6QkXAoTWkFXZ4gppz5eNNcR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xSLhBL89hJgSBv4X8IAF2WaTDnS1/q2zcqywtlgkiOS9UoCaxAh5w3pvvtQhHsX+B
         jxGSm3VAZZUqUpjHQxOqGdu2LIES3LNq0Cd6KuZVq0HZvxjgTYtEOZq3hoiSTIBql1
         lzdaLb3q5cM2m/+aYeA9PF9Hxm1a2uXRgqCEP5Pk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9c0f3a52cd4e0075713fb7b9a2adbc7f05adadb3.camel@hammerspace.com>
References: <9c0f3a52cd4e0075713fb7b9a2adbc7f05adadb3.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <9c0f3a52cd4e0075713fb7b9a2adbc7f05adadb3.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.3-4
X-PR-Tracked-Commit-Id: eb3d8f42231aec65b64b079dd17bd6c008a3fe29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b47fd5ca9ead91156bcdf6435279ad0b14a650c
Message-Id: <156762420197.10973.5210895278625856980.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Sep 2019 19:10:01 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 4 Sep 2019 17:11:29 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b47fd5ca9ead91156bcdf6435279ad0b14a650c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
