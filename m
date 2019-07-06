Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C660E7E
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2019 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGFCfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jul 2019 22:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGFCfD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Jul 2019 22:35:03 -0400
Subject: Re: [GIT PULL] nfsd bugfixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562380502;
        bh=ClYPlsLkGJ0ky7+3uGwX+CqeUFrp4gTbfIxB86npQH0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j/j6Dj9I2RxkhjWFrabffKYGabTyojsDtLPa2u1LQ157iiUFw3IRIZTHM8bJREcok
         VJ9HddL+LBCd7MUT+JM1g80GIxlTQi0AS1VasINjt+tTX3VGlvl5rJ3OGjf9NYlilK
         V4gdrp8xs5cQPnd96ZI8i6pZZcoosoHiPYVfQYqc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190705174037.GA4203@fieldses.org>
References: <20190705174037.GA4203@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190705174037.GA4203@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-2
X-PR-Tracked-Commit-Id: 3b2d4dcf71c4a91b420f835e52ddea8192300a3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8f46b5afe1c0a83c3013a339e6aeccc2f37342d
Message-Id: <156238050256.5324.1208784276842590540.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 02:35:02 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 5 Jul 2019 13:40:37 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8f46b5afe1c0a83c3013a339e6aeccc2f37342d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
