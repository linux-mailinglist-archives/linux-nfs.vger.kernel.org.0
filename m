Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC731CE3A7
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 21:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgEKTPC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 15:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTPC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 15:15:02 -0400
Subject: Re: [GIT PULL] Please pull the second round of NFS server -rc fixes
 for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589224501;
        bh=6nEntGBqg9GZAcn3Le7ZlMH3ksbXb8ECQpsYvPFmYAs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t/PGFoCHHUiJOCZbXL+Ef1q9geMwsej6BqltoaaNfI4uLJa+yy9pIEptGV1eCnC3r
         6203v3XkjtdWAdN2CBfqc2wXgB1Va8zujAomKEFgrFKOhpwrZeoZ0+OsjArpSLEZDX
         0HoP/5b7zawdBdvs+5ipZv7oy5gRiYOlyRTL19uk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0D57DEB9-C336-47A6-8219-6C3525B2EB0F@oracle.com>
References: <0D57DEB9-C336-47A6-8219-6C3525B2EB0F@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <0D57DEB9-C336-47A6-8219-6C3525B2EB0F@oracle.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/cel/cel-2.6.git
 tags/nfsd-5.7-rc-2
X-PR-Tracked-Commit-Id: 0a8e7b7d08466b5fc52f8e96070acc116d82a8bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 152036d1379ffd6985262743dcf6b0f9c75f83a4
Message-Id: <158922450176.1653.11285705842580856422.pr-tracker-bot@kernel.org>
Date:   Mon, 11 May 2020 19:15:01 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 11 May 2020 14:14:09 -0400:

> git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.7-rc-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/152036d1379ffd6985262743dcf6b0f9c75f83a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
