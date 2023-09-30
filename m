Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C67B4270
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Sep 2023 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjI3RCT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Sep 2023 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjI3RCS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Sep 2023 13:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0A7DA;
        Sat, 30 Sep 2023 10:02:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D945DC433CC;
        Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696093336;
        bh=qreqIGXpQlD8rrZsSfwWjvg5dT2aaoQefTHzNEdbpiE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CxdGr2YRt0gSUnMrZNaeIZErmzDvbJxn0m73vPksbvrrBg9TO9DyWrqvE90mvzM2z
         fBFW9wWTw14v0sptbc2mE6OM3BC5DCR6LyOZ9B7EOuBFj9OaHCInBXKOH/Qhtpk2nE
         1ythB+wAobJpniCZLDLmRoDgc/1nyQdrFx9TmeGCCBLKdGM9SVSidwLf40i2La9B2s
         y/QMHiwiLLCMp99/fhUi0Ooi/ois1PyVXqYohNr0H7x5+1MDAHNfTdDDBUMyu26VNS
         z4MHizUkbEsO2gaOmZ3Plm54plLlOQf9aiaX8iiNHiqMEyXQl9GIp9cx1AHuzFgKQM
         PiQbM68F8uUDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0616C43170;
        Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
Subject: Re: [GIT PULL] second round of v6.6 fixes for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <857386F1-ED95-4113-91D3-C082C39040FB@oracle.com>
References: <857386F1-ED95-4113-91D3-C082C39040FB@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <857386F1-ED95-4113-91D3-C082C39040FB@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.6-2
X-PR-Tracked-Commit-Id: 0d32a6bbb8e7bf503855f2990f1ccce0922db87b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae213639983a5406849d62d33257dfc076bc48a7
Message-Id: <169609333678.18163.12519448826943820871.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 17:02:16 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 16:22:50 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae213639983a5406849d62d33257dfc076bc48a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
