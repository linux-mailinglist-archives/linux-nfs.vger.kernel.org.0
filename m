Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A391E985AB
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHUUfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Aug 2019 16:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfHUUfC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 21 Aug 2019 16:35:02 -0400
Subject: Re: [GIT PULL] nfsd bugfixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566419701;
        bh=f2vThZms9ade6ULNLIYBpJ1ksg1haTxzagrJMrBGACw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xzqbnHsQmRYPjwrXdzw8uHtUga6MTUW3/HUBEdHV1bnXCDztSzkoeggrlMokqCatx
         Wvw0w05qZ48fO3AGUfKx+O9i+4ymfG5aQqyuCSt5Z7FqY/TJxGIblUFi3cJl2nufOc
         Y3EusHHUuDq6kbiuYJ89D/z+XzHK8ghScKBvsRMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190821150646.GC22104@fieldses.org>
References: <20190821150646.GC22104@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190821150646.GC22104@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3-1
X-PR-Tracked-Commit-Id: 78e70e780b289ff59ec33a9f9c1fcecaf17a46e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2babd34df2294a72df02dc4a3745df3408147eba
Message-Id: <156641970165.4116.17330431153924630328.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Aug 2019 20:35:01 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 21 Aug 2019 11:06:46 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2babd34df2294a72df02dc4a3745df3408147eba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
