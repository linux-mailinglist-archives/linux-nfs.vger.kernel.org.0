Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF4D49F1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfJKVfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 17:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfJKVfC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 17:35:02 -0400
Subject: Re: [GIT PULL] Please pull NFS Client bugfixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570829702;
        bh=9vz4Xxpjz07Krax/K16bG6ZIyQ95TNjzskvI0ZvgMaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M3ATU9zjXv0tA2GmyucK2fKIKZ7Ep319m3V30s3vlmQlU6BgRzLrgLrYAd1wSOSMz
         BaSe/9R0axxf4sum8gF6fTL7xAETKy7PcgzPyZzxJpgPzyhoHmuDp2ZfFaUYE4uYyL
         plglKfgLPuC2tcFFaLQRCGnkc5WTZ2py1u5cuWP8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
References: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.4-2
X-PR-Tracked-Commit-Id: af84537dbd1b39505d1f3d8023029b4a59666513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a
Message-Id: <157082970195.1897.12724883565139279738.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 21:35:01 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 11 Oct 2019 21:14:20 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
