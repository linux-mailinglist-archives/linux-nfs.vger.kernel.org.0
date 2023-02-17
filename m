Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E569B614
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Feb 2023 00:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBQXAc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 18:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBQXAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 18:00:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE0E0;
        Fri, 17 Feb 2023 15:00:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633E162086;
        Fri, 17 Feb 2023 23:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8EA3C433D2;
        Fri, 17 Feb 2023 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674829;
        bh=SHtEUkVWvx6Pxd5m50gDrkVPdNQ2N7PHLv2MUB25rUU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=llceEM7W4jg2r1EbnuyKcY7MtqWhlgLouvBHTyEXUpWqOC4HluCKgk4vM43cm88TV
         QxVufTsQYqK5U1lUZ/M97Jy6PdU56yfN96d4o2YthhNUrzalyXkgwtv1h0Z+go6jys
         LOZn20oer+pc4woKDGBd/1ArfI2tg8Qdhal94YHFUozgpYb2UigyLyIh9i0fkwwXVO
         JvxGbcC4cJsw9y/pewZE/WZJZweZe/chCz2J2ZetwsnrzT6AFzYLg5XMyZoe4SUbnY
         pry/y8SpRD/gOkhco1+azq1v28XuuXsh1ifxfO19vhvqKVuw90u58yMRK5Usn21lnt
         zsUAS79Fu7H3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD2DAC1614B;
        Fri, 17 Feb 2023 23:00:29 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull another NFS client change for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c2181ba919c59ffde5c9b9fc615608f92a146413.camel@kernel.org>
References: <c2181ba919c59ffde5c9b9fc615608f92a146413.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2181ba919c59ffde5c9b9fc615608f92a146413.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-3
X-PR-Tracked-Commit-Id: 896e090eefedeb8a715ea19938a2791c32679cc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75cc9c4716a7a398139805e62ccc3e0d14d00540
Message-Id: <167667482970.20587.6365505201861217855.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 23:00:29 +0000
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 09:16:29 -0500:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75cc9c4716a7a398139805e62ccc3e0d14d00540

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
