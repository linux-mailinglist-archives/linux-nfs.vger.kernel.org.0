Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B862621F
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiKKThl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 14:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKThk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 14:37:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F047B228;
        Fri, 11 Nov 2022 11:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79A5620B9;
        Fri, 11 Nov 2022 19:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 490ECC433D6;
        Fri, 11 Nov 2022 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195459;
        bh=nWaRwP/snHWppC/yNrCmHvi3W7vus7PaJekh2R7dz3I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AtogUaO68Y46eGJOVXAZsFQ+i+VT/Ac+oDd99UGphEQ89ItCS/V7fMe7F2tIDlVve
         vy4fc8VExGt2CKl2WwtrcGZR8w3dwVdsujt1X8nEgY5zHxpLrtI12W53RU50zsthio
         OzdWKvzmIXZuJv826QwTtSVk5iAFn1kQ6wqw5WTMQbmj7Wp4DExqFvrPulwbTxsV33
         Q//N+bDElEEfg1hr509ztDdknLAXDbCL9VTWf8jcCmjUPwEDKyI3hvjeBMZtbpN7hi
         XzZYBgqmp50qGBk9EXXARgtk2SfdJixMvWX7eU7SuegGfFAQb0yfgBk9rMHlr8ClRI
         14VQbs4grsYJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29141C395FE;
        Fri, 11 Nov 2022 19:37:39 +0000 (UTC)
Subject: Re: [GIT PULL] 4th round of NFSD fixes for v6.1-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <90885D9A-C975-4B82-BC17-137F80E14181@oracle.com>
References: <90885D9A-C975-4B82-BC17-137F80E14181@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <90885D9A-C975-4B82-BC17-137F80E14181@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-4
X-PR-Tracked-Commit-Id: 50256e4793a5e5ab77703c82a47344ad2e774a59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9bbe0c99e5b76a76a1a7fe3bbdd7eaab9f5ab57
Message-Id: <166819545915.1340.12265102164354320465.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 19:37:39 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 15:05:35 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9bbe0c99e5b76a76a1a7fe3bbdd7eaab9f5ab57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
