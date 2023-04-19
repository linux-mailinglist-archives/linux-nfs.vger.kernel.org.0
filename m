Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC016E7CB6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjDSOc0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjDSOcY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 10:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1946BD;
        Wed, 19 Apr 2023 07:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D908963FC1;
        Wed, 19 Apr 2023 14:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46261C4339E;
        Wed, 19 Apr 2023 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914730;
        bh=fdqtw+OCktaeS9oJbsosp9XkbwF0W/Sq3aIIjhj/D1o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B/cP5agCz9ZvPItnQJCovVl/6LHUuC3uyc3cN+UcKy7EaZjvwxwyhG9Nd3ZesNPz2
         whut0Lb0djMGhVS/1+nbnnVph7iD/+K2TtuDhUtlh8OvKGscz1lSlPP721QokKNQoK
         fcmF3+7tIVJdhPmmOxqTGMRyV0rgmATclQJfhJhczHwRWpNdcCmTZDByYkW1nMt5aS
         DoBt2PVkV+kyA1QG6HK2QNfJ/2We4+kW8i1CzGiX6ps9NpXxg+Xt4Zr1I1EkLwzj7x
         ObDkwV1nIAMn6muMJkECTWB8ZCgZlN0uc8YoY5kfchFMw8liAggVhDfVRuV1EXYBoj
         OAc3vW41BN8DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D85AE330AB;
        Wed, 19 Apr 2023 14:32:10 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <54D84D86-4B89-4575-84AF-3EC7383B0779@oracle.com>
References: <54D84D86-4B89-4575-84AF-3EC7383B0779@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <54D84D86-4B89-4575-84AF-3EC7383B0779@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-6
X-PR-Tracked-Commit-Id: d51425190805d47aecc1910b272e65476dd3b937
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 789b4a41c247ed654322a6150815025b5497cad0
Message-Id: <168191473018.24893.8952091049956534343.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Apr 2023 14:32:10 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 19 Apr 2023 13:42:12 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/789b4a41c247ed654322a6150815025b5497cad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
