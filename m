Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD41D5B34
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2020 23:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgEOVKB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 May 2020 17:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOVKB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 May 2020 17:10:01 -0400
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589577001;
        bh=n62c4oAA0sKfvg3VImY76EHLXbju9LHeKVrwZICJUa8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bAJLbg3J/d55tr94uma+ugptUJp6xCKh7ivTCUm6ESOwfzgHxSusl9q2zJdUdXouu
         eWOlbfZDm594cxv7khdCO1P8nky/bbZrvSkADCgDJzTsVhp5kS70qhukX4MSGWXr0x
         gcvJv73YHTR11QBApwIPXjTD8p+TyZSyFdEWKT4E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <550cfc745cc5ee9dcae06db50594088aad09fb45.camel@hammerspace.com>
References: <550cfc745cc5ee9dcae06db50594088aad09fb45.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <550cfc745cc5ee9dcae06db50594088aad09fb45.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.7-5
X-PR-Tracked-Commit-Id: 8eed292bc8cbf737e46fb1c119d4c8f6dcb00650
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12bf0b632ed090358cbf03e323e5342212d0b2e4
Message-Id: <158957700139.24319.4633070353214508470.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 21:10:01 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 21:00:11 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.7-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12bf0b632ed090358cbf03e323e5342212d0b2e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
