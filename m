Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80786F58
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2019 03:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404866AbfHIBaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 21:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfHIBaC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 8 Aug 2019 21:30:02 -0400
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565314201;
        bh=lQpUOAG+MSyFqtDjyKkL9Wh5WWiAzXZvnNQ88z4NGd8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ryITWyQwTXipY8gQ+nyMkcFzEp43JYabVaeoLD7JEVv91cPuvS3XRGYvp9klL7MC0
         oTvF3dg+5pmqPoZpUTONso3ChFNFIaC9iwOP8xcrSrXXLnUk1a6ppofL5i9WILARK0
         9xPbJzXRWbd1p6cauRxgREfsthGYbcOmGXdWz4zY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c898416a146ef77bd5a61a0cf3e219fccbfcf508.camel@hammerspace.com>
References: <c898416a146ef77bd5a61a0cf3e219fccbfcf508.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <c898416a146ef77bd5a61a0cf3e219fccbfcf508.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.3-2
X-PR-Tracked-Commit-Id: 67e7b52d44e3d539dfbfcd866c3d3d69da23a909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b678c568c561cf7e4ed40f4bcc3e85d2b50310a2
Message-Id: <156531420142.8489.9770687123110941227.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 01:30:01 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 8 Aug 2019 21:26:49 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b678c568c561cf7e4ed40f4bcc3e85d2b50310a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
