Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01085470FF0
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Dec 2021 02:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbhLKBma (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 20:42:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47216 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbhLKBm3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 20:42:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C628B82A90;
        Sat, 11 Dec 2021 01:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 261E5C341C6;
        Sat, 11 Dec 2021 01:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639186731;
        bh=/m8hd0KlZwF+D9ew/IDvZW6FvzK6heN9E7Ms3hk5/Ns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B6l8dmpn3KKJCZzP210okw6DhjFiLDiaQ/oWSrpc8JKEfrvtbP86yYhpjG2QkC58D
         irF46dTTzEQXIA2hsqBg9T/pfSmSCOzWLFynTKjK2p/0TbWoE2ITai7waI2brgD/Fv
         BCxzOyG23hJBHvp68/kJn8POqMTg9wZHsdU+5v614o0pYusVrSh6d0MYhky4X/m7v+
         4Sae3Ng+dG/eNA3/VwlW1bvrVV3l0w7+RWmsELQM+MCmqsRkE+5e60C0RDWCNDo45O
         qfjvqI+Fr1MUjsK2hWaqvSrvPLAVbA/lAXql5vKufS2IATJPW6Kd/7C3Y041GxLAjh
         iY2sPbC1DzMRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1163A60A4D;
        Sat, 11 Dec 2021 01:38:51 +0000 (UTC)
Subject: Re: [GIT PULL] more nfsd bugfixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211210203601.GA4596@fieldses.org>
References: <20211210203601.GA4596@fieldses.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211210203601.GA4596@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16-2
X-PR-Tracked-Commit-Id: 548ec0805c399c65ed66c6641be467f717833ab5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e80bdc5ed065091ef664a5ee91cd0a15f9bd6994
Message-Id: <163918673106.12736.3389026885070364493.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 01:38:51 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 15:36:01 -0500:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e80bdc5ed065091ef664a5ee91cd0a15f9bd6994

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
