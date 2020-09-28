Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6038527B43C
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1SQC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 14:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgI1SQC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:16:02 -0400
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601316961;
        bh=4J0QdD/J9oSZzfS+t/0iVnpJnoYdUEfRIR/3vRFfChg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fHgxLriQVx5WfWuYtVdKHsbaUF+luvVrGOyCe59MM0spcDGKiqa2rvtNFaoDkxmaA
         h7Koq/SkaQwyW7NsE5WIrJ7uoVJkQadMV/T4F23DsJBDYiDEhh6FhRO4zoK5KfbQZ2
         E7jI1CDVb/OvTA8sQlEmIp2S9A6op7bw7JFrVPpY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <93a6b36e466a389330945f8c515ad7fd86e8b714.camel@hammerspace.com>
References: <93a6b36e466a389330945f8c515ad7fd86e8b714.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <93a6b36e466a389330945f8c515ad7fd86e8b714.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.9-3
X-PR-Tracked-Commit-Id: b9df46d08a8d098ea2124cb9e3b84458a474b4d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb0155a09b0224a7147cb07a4ce6034c8d29667f
Message-Id: <160131696161.3008.5503515051957934053.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Sep 2020 18:16:01 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 28 Sep 2020 17:27:14 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb0155a09b0224a7147cb07a4ce6034c8d29667f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
