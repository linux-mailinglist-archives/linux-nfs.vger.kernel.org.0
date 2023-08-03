Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1E76EF7A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjHCQat (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjHCQar (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 12:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B43A93;
        Thu,  3 Aug 2023 09:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976B161E38;
        Thu,  3 Aug 2023 16:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A1C0C433C8;
        Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080246;
        bh=oSDnLkIhKN7dmTpIGVu3LhWHUFXm/wXKu6jq++yz6Fc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kyw1klqGEfyMBHXSyLSiDxQo78FLWiutrBvDPM3MD+X1g2+MfKl48HIy6SNfWI9E2
         RVGnuab8u85HVwp40ejCC9eJc4NjE0RZezGhNl4ydOnEKJGI0TAa5swSg+XCQ75nAn
         tP7QbUDserWjbkaTA9l9T2xI5cW1Pk4QDRf2TcDQD7aeKu5wODYNNYzca2m5rZpX1N
         nyLN5Dyy0ZfRYIz7r7VZ+ERMYfj1M6hp69XWNEkHDxRSP9XquaPCSDg9F4lS2CgRgB
         Gx3pP6G/+5wZEILs72OhijvCszMxJyVCkwH4EhEpzbFcXAkiOiDFSysykDykS8J+9a
         ddydcknrH2Hvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD9B5C595C1;
        Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fix for 6.5-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <95555596-C49F-471D-AB89-6491DEE32C57@oracle.com>
References: <95555596-C49F-471D-AB89-6491DEE32C57@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <95555596-C49F-471D-AB89-6491DEE32C57@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-3
X-PR-Tracked-Commit-Id: 101df45e7ec36f470559c8fdab8e272cb991ef42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bafbd4027ae86572f308c4ddf93120c90126332
Message-Id: <169108024590.31872.17141364662760048330.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Aug 2023 16:30:45 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 3 Aug 2023 15:21:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bafbd4027ae86572f308c4ddf93120c90126332

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
