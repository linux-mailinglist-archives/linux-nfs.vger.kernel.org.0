Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15A650E8B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Dec 2022 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiLSPWt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Dec 2022 10:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiLSPWs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Dec 2022 10:22:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67263EE;
        Mon, 19 Dec 2022 07:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 825EDB80E7A;
        Mon, 19 Dec 2022 15:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 308DDC433F0;
        Mon, 19 Dec 2022 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671463365;
        bh=jDxSJDMTWt13FePZzSNyAo9bsTVsnhQKvIKfDSGpKYA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g7P55TVlxO9/vnI7D61UYWRppYjrE7rM1dfJE1nr4qTMj2b7mXOYDzgdheZ04njTE
         WPHLFD/9nS8if06YqwnR/TwPHNsTYSEaTJXNW9e7uXBAZjkkFHvT+1atlTIdVnlvWC
         01IW7GQY85X2QtMW1XD0ZbeTeUdgOQq8+rq1asWws8OnWGt+2pJfiT6AKEU+h1lQXe
         aJTMN7/O8y1mgihJO0PgfHbX7cs68/T9TFTUwGJbNHvaGccZ6fbA120C+9OwcfinT0
         weR8kwArFugXpY/00IxxT7pjiOU/zsr0SBaPlQZLNez19mvlPSyFEz349TzFlEjWKe
         +Qo0RPf9ZLkjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 157CAE21EEE;
        Mon, 19 Dec 2022 15:22:45 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd v6.2 PR for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <B9418BA0-EBAC-4CE4-AA12-206083581C42@oracle.com>
References: <B9418BA0-EBAC-4CE4-AA12-206083581C42@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <B9418BA0-EBAC-4CE4-AA12-206083581C42@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-1
X-PR-Tracked-Commit-Id: 75333d48f92256a0dec91dbf07835e804fc411c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aeba12b26c79fc35e07e511f692a8907037d95da
Message-Id: <167146336508.2518.10690228005733903437.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 15:22:45 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 19 Dec 2022 14:19:51 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aeba12b26c79fc35e07e511f692a8907037d95da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
