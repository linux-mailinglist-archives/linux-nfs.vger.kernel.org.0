Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A225ECC93
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Nov 2019 02:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKBBKC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 21:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKBBKC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 Nov 2019 21:10:02 -0400
Subject: Re: [GIT PULL] Please pull NFS Client Bugfixes for Linux 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572657001;
        bh=z5/QtKWlj+bei5jaEgaw8ei7br62WPlYXqs9bV+y4yw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TpSrn1ijLKrJVH7K3OkhnWhcO6G2shB1JHEU8DfaIKEqX6ECFK3jlg44ucX5njqLf
         7ilZc5LAiPfeuLWmyyDtmc9mPWYnUIufG2YP4elM9UUra3iUfZ7FlX5BP6zUYXkUBM
         IhwmxHQ4g5x73DTnHQz7YhOFxYH1cQodlh3fk8+4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2c39701ab77496cb78b4955aad532a2f18427465.camel@netapp.com>
References: <2c39701ab77496cb78b4955aad532a2f18427465.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <2c39701ab77496cb78b4955aad532a2f18427465.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.4-3
X-PR-Tracked-Commit-Id: 79cc55422ce99be5964bde208ba8557174720893
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372bf6c1c8f9712e7765acad568a6d7ed4e8d6c0
Message-Id: <157265700141.2997.8876539946752599800.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 01:10:01 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 20:53:30 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372bf6c1c8f9712e7765acad568a6d7ed4e8d6c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
