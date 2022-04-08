Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23DD4F9BF7
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiDHRs2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiDHRs0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 13:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107173917C;
        Fri,  8 Apr 2022 10:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92E29621CA;
        Fri,  8 Apr 2022 17:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 027B8C385AA;
        Fri,  8 Apr 2022 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649439982;
        bh=XLyYWeSHLe/lJ7GQX9owwOYEeLFNU2Jc/5lhqOKrgws=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lv9zC1AIiTgJrfcIY1TgLr+CWzlkoL6DqP95CPAJ5V0na2jV1ADGed/nYSK7UUlG7
         93Hf2L4gg1Hw0ggJ6Py/1dYw4ffG+cdgEBHAtUuY7fkqIli0i3ECoVxYVXIn5vdcY1
         CFXEIyFkV92eowxWAKSvvuEeXMzJ1z/NUG/VybltMD9AgiugEfdOyesAyCtuC//Wbq
         sgtmXZjFRKCYGPU4FxdtoeWnJkAqTUMRb84ISgelakZRayWeCb9Y7n++eCovhsBvYK
         sZprQV4Tx7ZMRmNoZQxDGOT2fxU+C1QF0juUXUGzqlBbAtdRZOD1cwcPGZLcNsPXjX
         2jaxW7D+szbhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3064E85B76;
        Fri,  8 Apr 2022 17:46:21 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9c98642c7b088e4e5a628b1aa144df8eafa25cfa.camel@hammerspace.com>
References: <9c98642c7b088e4e5a628b1aa144df8eafa25cfa.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <9c98642c7b088e4e5a628b1aa144df8eafa25cfa.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-2
X-PR-Tracked-Commit-Id: ff053dbbaffec45c85e5bfe43306d26694a6433f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a3b1bba7c7a5eb8a11513cf88427cb9d77bc60a
Message-Id: <164943998192.23047.6308034752294656205.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 17:46:21 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 17:30:43 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a3b1bba7c7a5eb8a11513cf88427cb9d77bc60a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
