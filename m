Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD3661115
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjAGSnR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjAGSnP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 13:43:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B321482B1;
        Sat,  7 Jan 2023 10:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A01060BC9;
        Sat,  7 Jan 2023 18:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F941C433F0;
        Sat,  7 Jan 2023 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673116993;
        bh=NklOW+zibc4MG+fLRS9/qKIyGARywukZjbGLHQIl/bI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WCxxVHyqUCtQ9YI4iR+qHLB/DkBl/cUf/ckGFkkoTVLxgvWmRGKpiHWvIKKJQTpod
         3ZVCva8KScRvvA5GLuLYiLpruUmTsTSsK+0VCi9XIKKXsl5nruXZf/j8bNtnaJ+XG/
         2HUal/0LfkLmAtOUR74zVkAJIqR5aeoczCuBjsepLI87LW0+zIslAzSta3JbFmrhCi
         a/yAKXQNMYpB+1KjXr93w98ZsZg/jjDEsToTj0+E3c2yPGCRl3v1LMLMEEbfXw3gC0
         IYBFHn7EtOTM97/H7gwacKFIOqetlEMgzjOVnyCoCcuKv7DeGTu31gXxPhNanhgvDw
         0ykhu5F7VRiCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8321DE57249;
        Sat,  7 Jan 2023 18:43:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <79e77f294451933c2264d8e149d45cc546e31066.camel@kernel.org>
References: <79e77f294451933c2264d8e149d45cc546e31066.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <79e77f294451933c2264d8e149d45cc546e31066.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-2
X-PR-Tracked-Commit-Id: 5e9a7b9c2ea18551759833146a181b14835bfe39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b43a525db125799df81e6fbef712a2ae50bfc5d
Message-Id: <167311699353.9095.15473683704569814770.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Jan 2023 18:43:13 +0000
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 07 Jan 2023 13:09:18 -0500:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b43a525db125799df81e6fbef712a2ae50bfc5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
