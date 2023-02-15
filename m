Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225B3698822
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 23:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBOW50 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 17:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBOW5Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 17:57:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF237442D7;
        Wed, 15 Feb 2023 14:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD2761DE7;
        Wed, 15 Feb 2023 22:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 913E2C4339C;
        Wed, 15 Feb 2023 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676501842;
        bh=PzhbWHFJ107yZMkDYyhP34SidCinmAAXsIbFdxdm9kg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N3FDjZY/sV2M8FAEMGAFBTeP/TmSgtKqx9FYDp9jRZFgdfUqR833vq/4Z0iAV+tzq
         sYbgwFSM4+lKSm8iDh9LL4ICKnQ38ALy4Hx+zeXLdnMAA2YTRgqsNl1TRnuGsCN6lK
         loxWZ7bZ0udG8axWdgrbWKAt+LnviGiJxkS7PA8pL8CovzJ+UfHsX9ZCgIl1T4k1fF
         MJm4SaTm7TvVzlOVvL++r7kjN8mkQZTTFmU+GU3r+B8inFOLvgwkA6SfJuclOgRSDv
         CFtn2hzLFb5pj5rzWGtG50LfYuC7sx3/M8fwpVfv2a9NWNhRwQqjHEhQcwrd/iRUWV
         mf7JMDsdyZDtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72D99C4166F;
        Wed, 15 Feb 2023 22:57:22 +0000 (UTC)
Subject: Re: [GIT PULL] fifth v6.2-rc request for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <A1496B44-86CE-4F63-8A84-DF0C04F6A6BC@oracle.com>
References: <A1496B44-86CE-4F63-8A84-DF0C04F6A6BC@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <A1496B44-86CE-4F63-8A84-DF0C04F6A6BC@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-6
X-PR-Tracked-Commit-Id: 4102db175b5d884d133270fdbd0e59111ce688fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3402351a5a8f3bcb1488877f85072a0141c97939
Message-Id: <167650184246.1740.18294257652450629378.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Feb 2023 22:57:22 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 15 Feb 2023 14:30:40 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3402351a5a8f3bcb1488877f85072a0141c97939

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
