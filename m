Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2754D6B4DDD
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjCJRBd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Mar 2023 12:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCJRBO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Mar 2023 12:01:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A4F12C0E2;
        Fri, 10 Mar 2023 08:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 914AC61C4F;
        Fri, 10 Mar 2023 16:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 002BFC4339B;
        Fri, 10 Mar 2023 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678467491;
        bh=qJRS7w5TI/JGIIV9uDwoy5FXNCY9GhhUWgUmpcbjwco=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wg6ocL8hdVoixrFbPh4aZ8mCuolEyYUI6lpLHGjXkYDH23OAAm9x9rTPVxUwgPC4g
         4Xgt5IjXDyVQ/8+k6mOmxjwWW2kXvV/hWXtg0UBKenTEyOXtNuc110o5lMi9ZbueTO
         wAeFLDDFN1k/OOOZKawp1hq4Gc7SwNKvYfuzO39dYJ5n14y/ngB4dI7ek92Hheyk0D
         RMJCCvDdMm9PDBjf+f38bXboS/e1XO8bVdxiXantC827VMEFJ1FwLiREqka8EpKd84
         FagptZYcIeHhmM+lD2Vz2wdGXfmVIy8s+7o+ooSx0cvIpXVMA4eYiBrDEzu+M16a6Z
         vnIzVf6EkGfhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC0A8E61B66;
        Fri, 10 Mar 2023 16:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70CF2D89-B9AD-46B9-8B2F-8164655297E0@oracle.com>
References: <70CF2D89-B9AD-46B9-8B2F-8164655297E0@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <70CF2D89-B9AD-46B9-8B2F-8164655297E0@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-2
X-PR-Tracked-Commit-Id: 9ca6705d9d609441d34f8b853e1e4a6369b3b171
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92cadfcffac3ff2dafc892b7725d1016c8a1b6ee
Message-Id: <167846749089.19444.12286846761649181735.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Mar 2023 16:58:10 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 10 Mar 2023 14:34:51 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92cadfcffac3ff2dafc892b7725d1016c8a1b6ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
