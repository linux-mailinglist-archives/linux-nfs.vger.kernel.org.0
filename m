Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5B1A5F8C
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Apr 2020 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgDLRaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Apr 2020 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgDLRaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Apr 2020 13:30:08 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E093C00860C;
        Sun, 12 Apr 2020 10:25:04 -0700 (PDT)
Subject: Re: [GIT PULL] Please pull NFS bugfix for Linux 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586712303;
        bh=NQKG3sieFZziBsWnKTIbtYsYsR1dXln+HTDYfjofghA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KcoWFwrg5WaYW52aT+62LcDQnipnEq1BI/XHm1KjUGZbwmpKWOb5CQ4zVElkAizKq
         PylSpJJow42hrfnsj6IjRSDUsKL/cNBqddgTE0SVkZn9dBz+TPkijU/bfJF3bN9RBz
         iOy4DUrO3AVRJXCON5Eokq2bQr0ogbChQGRgVV/Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b1fd16bb3607f03e60f4e18c0d8d046451f8882d.camel@hammerspace.com>
References: <b1fd16bb3607f03e60f4e18c0d8d046451f8882d.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <b1fd16bb3607f03e60f4e18c0d8d046451f8882d.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.7-2
X-PR-Tracked-Commit-Id: 27d231c0c63bb619997a24bab85d54d90ca71110
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50bda5faa6251da85e82db234372f1fc1c69a9d2
Message-Id: <158671230377.12917.5540924749813551775.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Apr 2020 17:25:03 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sun, 12 Apr 2020 00:59:00 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50bda5faa6251da85e82db234372f1fc1c69a9d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
