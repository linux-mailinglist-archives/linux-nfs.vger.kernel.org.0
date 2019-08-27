Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC19F494
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH0UzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 16:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfH0UzD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 16:55:03 -0400
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566939302;
        bh=UxQO7FIOj6mG250fGU5cCX/bdK2Gf+7g6CRwXFKg+1A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=miY4KzuAcffHbLKmPIK1HX8lHlyvBPivEcfbE59DVY8QFWlEXfMmiPKqyXJhjISfc
         iGVxBz1OrEn8gkwcwRfKRRrqYVy/shg3lDXoc640npsYdezQRzPHU3EwgQ1lawxrME
         FhvnsPCxCMSK1ElDp6GI2FIzaBgzIL10REv+5Ekc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e5010947fb92781e7e5eebc6750fa61d0c5e2399.camel@hammerspace.com>
References: <e5010947fb92781e7e5eebc6750fa61d0c5e2399.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <e5010947fb92781e7e5eebc6750fa61d0c5e2399.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.3-3
X-PR-Tracked-Commit-Id: 99300a85260c2b7febd57082a617d1062532067e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e8312f5e160ade069e131d54ab8652cf0e86e1a
Message-Id: <156693930273.9420.6053224282397353518.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Aug 2019 20:55:02 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 27 Aug 2019 19:26:51 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e8312f5e160ade069e131d54ab8652cf0e86e1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
