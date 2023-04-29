Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995A66F25C9
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Apr 2023 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjD2STv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Apr 2023 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjD2STv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Apr 2023 14:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA341BFB
        for <linux-nfs@vger.kernel.org>; Sat, 29 Apr 2023 11:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7367615C4
        for <linux-nfs@vger.kernel.org>; Sat, 29 Apr 2023 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AD46C4339B;
        Sat, 29 Apr 2023 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792387;
        bh=+uwRh35V2NAEdvvOi4k+F1jeXesbNoCkmq1oOmEM8i0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lZcayjR+a5bwbnAmptLouTvscT+kVS1zH28RAxInDu0FRiLPqk9GUoty2gSIkAJpk
         Yinv8ainQzbxmYBlJi0846N7PacB9qR8b6iV3iG5OR/unsLb9EBvn82ivB1o3sSzsg
         eH/dCNqcp0fzzP3qyiWsvE9GERe8dGEjUjmj3jkb9sYHuKCWPYmfCKFc4cDE1NOaA1
         JOlzOPzLfUapvi0AzueADi1Px6CFMZWq9z9vPPtSh9QMledEI7ZA01EfNXx9n0VGKC
         /sc8/435NW9i6jAzOxfRp+lbowbAXapSXDWrT6WgMOxClVt1Ko0Ze6NodWJ+W/z2Ap
         IrBZf8rsnvwxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16967E5FFC8;
        Sat, 29 Apr 2023 18:19:47 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230428195257.234346-1-anna@kernel.org>
References: <20230428195257.234346-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230428195257.234346-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.4-1
X-PR-Tracked-Commit-Id: fbd2a05f29a95d5b42b294bf47e55a711424965b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0127f25b5dfcc3d0349eb29d692178183e101652
Message-Id: <168279238708.22076.6512443179816431361.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:19:47 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 15:52:57 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0127f25b5dfcc3d0349eb29d692178183e101652

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
