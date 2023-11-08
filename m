Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866377E6014
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Nov 2023 22:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjKHVpK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Nov 2023 16:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKHVpJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Nov 2023 16:45:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD462586;
        Wed,  8 Nov 2023 13:45:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8FF4C433C8;
        Wed,  8 Nov 2023 21:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699479906;
        bh=QSSdx472jFekopqxWHdmfqwnGekLUnXV5ePAN6sIqZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gzdkp9f6qnWyn5pF86GTmO/SokWOLXKknnDj+R0+wgZNcREHd6JOO49SU+tNJkBjk
         DBRnuTiD6crzNkQ5hvMGvm9X5DDI1g1pF0agnJunl8icOG+FVO94UeZY9kY6ouJWiF
         4rogODhHkKiJtJAUkoXrk5uUgax6vRcIUbCSkGmM0sm5P6lbvZ5tUmJ16mgHgPZ9sz
         6cfhMmgxkHPRJJUqQbM4ANzINXyLHTm2ZCwNe0Pqf0ZRXsJUem+tvNYuYoHsPCvUcG
         X81LVAG71uDedB1+Fsbo8cfx1MusyooDy/DYMSIYvaMJz0/Cz0g6ylA7Z5lfJol8jn
         XTInRCJT4aP4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 940EBE00081;
        Wed,  8 Nov 2023 21:45:06 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0c5dc383d262d49f842a76893b1efc2545cfe9ce.camel@hammerspace.com>
References: <0c5dc383d262d49f842a76893b1efc2545cfe9ce.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c5dc383d262d49f842a76893b1efc2545cfe9ce.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.7-1
X-PR-Tracked-Commit-Id: f003a717ae9086b1e8a4663124a96862df7282e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bc986ab839c844e78a2333a02e55f02c9e57935
Message-Id: <169947990658.4309.16944282634253739549.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 21:45:06 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 8 Nov 2023 20:23:18 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bc986ab839c844e78a2333a02e55f02c9e57935

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
