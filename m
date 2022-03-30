Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43F4EB817
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 04:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiC3CB4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 22:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbiC3CBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 22:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F77C177;
        Tue, 29 Mar 2022 19:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5957F61378;
        Wed, 30 Mar 2022 02:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C6D2C36AE3;
        Wed, 30 Mar 2022 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648605607;
        bh=Ntzo4/s2EN4rXPDFvvBJ5pTW6NgqDcLBkvUMY5709aw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s5DpdXH4xVeIYAY5L8ahIxje4/RWLilUDFIyUTX58HOXppPTRtksCc8w4N4cHfO5R
         LCmnZUftSeyUdLOSmJZiI1ZgMQ2MbJyT2/52QSLEXSAHPaejwW/CGEOP2/U7XQc0fO
         UhXOgTFmf97z1dWPEF/l6ACXtU0OI83QFyGEh8k9hiBC0PfUTm3uH3zhqoaQF463+r
         QAIxYYP/OJBzTroVRjIvtv+MBDhIh8tE3F90CsxCzR1pR538F09QiOmQ6ZD0HyHbep
         2t1FX6TlSgR7RNc+CUxyMPUwh21+3boMmGqnrILfZXbaPXHTkE1vF5guAAOa8MVq1c
         P7yWqc5ReB+AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A867EAC081;
        Wed, 30 Mar 2022 02:00:07 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-1
X-PR-Tracked-Commit-Id: 7c9d845f0612e5bcd23456a2ec43be8ac43458f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 965181d7ef7e1a863477536dc328c23a7ebc8a1d
Message-Id: <164860560708.9387.14167102034464992472.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 02:00:07 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 19:36:00 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/965181d7ef7e1a863477536dc328c23a7ebc8a1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
