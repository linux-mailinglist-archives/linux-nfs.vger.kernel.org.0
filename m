Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50D56F25C3
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Apr 2023 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjD2STv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Apr 2023 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjD2STu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Apr 2023 14:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F51BF4;
        Sat, 29 Apr 2023 11:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710C760ADA;
        Sat, 29 Apr 2023 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D48E2C433D2;
        Sat, 29 Apr 2023 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792386;
        bh=LMNk9uciWZtFfdEkJIhEbCeaYbO3nx4qLLMcxWUYYN8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ckQLI/sSLDBsFp7bEZqvii8A845R3dEMnuswaM9+lTl+ybjK/AgXvDuIRgdlnL19R
         JAVP7IDQEUSkqfFHq55iugCbcff2BTRyAeumLOEQW2UjUs0MYzUrxNFhklwT+xiW9+
         Io1PvGmFJgnJ/GJMWAUE+I8uw2c3u89SgmS48DrFvuA8OFHV3Mtb3QwoVJ4A046bQD
         YTuBm6d8N+xRMCNsUXqJSavOQiJkO/wbxoRd73oCJjnJkaoDyOvDf10qE3zWp8EeSR
         OKRCoBkNb1XgYMeo5oxPDuSon4BMs0BSXQrIGWH2sWoSWo+KhIz4WJdI/bAtk3/C4V
         WwAfLXxXkjESg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4173C43158;
        Sat, 29 Apr 2023 18:19:46 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <E0771535-05EF-4EAE-9BFF-E070C4D32F3C@oracle.com>
References: <E0771535-05EF-4EAE-9BFF-E070C4D32F3C@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <E0771535-05EF-4EAE-9BFF-E070C4D32F3C@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.4
X-PR-Tracked-Commit-Id: 9280c577431401544e63dfb489a830a42bee25eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e1c80ae5cf458792bec9815ee77bc3851046fb8
Message-Id: <168279238673.22076.15540579577427431470.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:19:46 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 13:29:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e1c80ae5cf458792bec9815ee77bc3851046fb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
