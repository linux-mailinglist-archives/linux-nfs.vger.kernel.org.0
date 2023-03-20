Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3C6C1FF9
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjCTSgX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 14:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCTSfu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 14:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE02DE6E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 11:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1FD261791
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 18:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1328CC4339C;
        Mon, 20 Mar 2023 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679336817;
        bh=Y6y6bhGG/D2dzjQxXma/4ZWyHV7f3FXRwIUYioGHgZo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aL7BOplY3AhvNZ9oynxGgwo2Y2/2Bno2hVHTbtoUdZVpMrASekBrrfBScQtAYg4Lq
         ToV2kmo8rSPc4Y6PAhqm5pxHiyNjspiqHnMxxPn9C8d46Mja7cUbdJIJPUF2Gxdbrk
         XIXJWsfSzuv0mqlcfC6DKoKEUPMqZL7/o16LF1Ud7qDqNvHcAGYmK5/90GY72FNqOS
         SbJorsIT5ZOn7PmozjxaiYQOR49zCyjQ7AYXeTxyc3bDxzvcKDEMOC6KWsf8a1Dv9x
         IskbvcKa8byKUiiRZU9Ji4q5IqHGSgah/LupNgsn5VXzdVeh1f4HIe3puiQQA/DXgI
         lmWjjncMvAyJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D26ABE4F0D8;
        Mon, 20 Mar 2023 18:26:56 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client Bugfixes for Linux 6.3-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230320175044.173626-1-anna@kernel.org>
References: <20230320175044.173626-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230320175044.173626-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-2
X-PR-Tracked-Commit-Id: 21fd9e8700de86d1169f6336e97d7a74916ed04a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d3699bde4b043eea17993e4e76804a8128f0fdb
Message-Id: <167933681685.31472.3193103770726079479.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Mar 2023 18:26:56 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 20 Mar 2023 13:50:44 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d3699bde4b043eea17993e4e76804a8128f0fdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
