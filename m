Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C75269B4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383447AbiEMS55 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 14:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383418AbiEMS55 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 14:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9556B7E3;
        Fri, 13 May 2022 11:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7971621EB;
        Fri, 13 May 2022 18:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C332C34100;
        Fri, 13 May 2022 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652468275;
        bh=/827bVme/NmK7e1LC/ELjRGWck//f9dr4kdSGxjn4eU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k1zShLR5K4rb9aYcdwD8QjzBN5oqWvlDsyJZmJEKige4caUXOAxkKiF6Lu8u9M9pq
         htmJqh/wW2gpPBp8Y2aWzb1KSk4O/9GT+NXZrlTxi+zOIMBVqvKpkRAQNJDeVvWVDK
         ia4NXcMIbYUvR79c/bmmUdD1z6VWf+laK9rI2YJ+bZk16psIWCeQ2w8+btzp83DUfu
         PdnN+24wgP4UhSfl//bWkCaMkKXjQ+nwOAWSmenKBgbJs6+P9tlqLcZ5x8+CNuuINw
         MEIE6/oE4/VmDt/s96wJr9PCv64K99rpYBTOQF3sC6IPIX6iGS9EHFMc+DufXDAxzj
         3B7Wn9VooN0rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05481E8DBDA;
        Fri, 13 May 2022 18:57:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bfd5b2161954d919909450ab9737308e6299ee11.camel@hammerspace.com>
References: <bfd5b2161954d919909450ab9737308e6299ee11.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <bfd5b2161954d919909450ab9737308e6299ee11.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-4
X-PR-Tracked-Commit-Id: 085d16d5f949b64713d5e960d6c9bbf51bc1d511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dd5884d1d6f6a0613f6906b14fc1f3feaf8adb9
Message-Id: <165246827501.27296.7265530409572155211.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 18:57:55 +0000
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

The pull request you sent on Fri, 13 May 2022 17:12:18 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dd5884d1d6f6a0613f6906b14fc1f3feaf8adb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
