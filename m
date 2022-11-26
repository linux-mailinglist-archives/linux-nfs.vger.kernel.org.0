Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7BB639873
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 23:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKZWej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 17:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKZWei (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 17:34:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537851260C;
        Sat, 26 Nov 2022 14:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBDB60C37;
        Sat, 26 Nov 2022 22:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 426A0C433C1;
        Sat, 26 Nov 2022 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669502077;
        bh=6WjCimYVY7kw2MtD4H36OjfMeVhWlqhCNivUr3JUnWk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NGvcu4y5kpz7DVXO8H6pLyLkDhVx4J0WdJCYI0OuxOXS8XNdgXlOKl2wTroeJ1fjG
         EU9jiYKktdbmsI1n5eVn+NJelP/6zh/5GzRBPm9F4+OFAxVLhQdLrRjTtxjB2rQ5M3
         pPPRPFxc3mYL7h73GfE6Sq1jzGaLsNDkngRfMLGhsaGsmNlCEEWTc7mLv73irem+hF
         2Uu6/6WUlVf/l8+UQsr0XVZZHAGouIwRgdSXjvO+/B5oV6z4lpKeBfguHp9t/uZM0I
         JUwYFbLS3MRnTdfra9hLtPJxId0Dv6p3DOWlW6wdQFugRMKqOA8gedIRbbSYye7HKc
         yDo2FdXYHyP6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25C9CE270C7;
        Sat, 26 Nov 2022 22:34:37 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd round 6 for v6.1-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5941731F-0278-4620-AC7D-006EA5ABDB95@oracle.com>
References: <5941731F-0278-4620-AC7D-006EA5ABDB95@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5941731F-0278-4620-AC7D-006EA5ABDB95@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-6
X-PR-Tracked-Commit-Id: ac8db824ead0de2e9111337c401409d010fba2f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5f3ec38c8496dd7f6ada8a5e8d4958ef46ddb3f
Message-Id: <166950207714.9915.6100350797011123343.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Nov 2022 22:34:37 +0000
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

The pull request you sent on Sat, 26 Nov 2022 16:32:13 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5f3ec38c8496dd7f6ada8a5e8d4958ef46ddb3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
