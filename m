Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0951E023
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390768AbiEFUdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 16:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359144AbiEFUdj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 16:33:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673276A057;
        Fri,  6 May 2022 13:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14174B83966;
        Fri,  6 May 2022 20:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D722BC385AC;
        Fri,  6 May 2022 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651868992;
        bh=h4uCns5ki6S/wrApp5nDjfg+emucPIYdb4o/8ayvsUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OG2m7kHs6aDn6pevDY0sC+dflU/HCL7MelU13tqY8/Aksod/S+IG7JANUhtTkeX5B
         mOtE9EPEvK2h+x8UKdtiY2fWExMwKARr/lnz/0ogxtTTdTWv3XLpnwnrM9Gr9JL+wH
         t3P1gtwp5io7CMWpT+j5i5s38TBlw/Ldfh1aaSUg78AF2RyWeLkDuEJ7BzZd09JYWg
         aCXC4OFz/6fTWOqzk300fiP8RekG9aj16pHGrarkFIpHuTFAKo4dbFbHdfbWETluy7
         CpF0PVWCMfQj78wTW80YbnNc29YWgvnmAltVgHNm4O0pckSN0luD92LbGJH3rFa0Lu
         zSUVjTAxZITtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3F2EF03876;
        Fri,  6 May 2022 20:29:52 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdd6481d128894041e6251218a309ae9cfa15f0b.camel@hammerspace.com>
References: <cdd6481d128894041e6251218a309ae9cfa15f0b.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdd6481d128894041e6251218a309ae9cfa15f0b.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-3
X-PR-Tracked-Commit-Id: a3d0562d4dc039bca39445e1cddde7951662e17d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adcffc1716f875610ba57195ec979a4ef655ddd3
Message-Id: <165186899279.14783.9764930667103287068.pr-tracker-bot@kernel.org>
Date:   Fri, 06 May 2022 20:29:52 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 6 May 2022 20:09:29 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adcffc1716f875610ba57195ec979a4ef655ddd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
