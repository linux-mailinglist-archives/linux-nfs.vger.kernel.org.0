Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967E76248C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjGYVeg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGYVef (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 17:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6A1BE2;
        Tue, 25 Jul 2023 14:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11496189B;
        Tue, 25 Jul 2023 21:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 227A3C433C8;
        Tue, 25 Jul 2023 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690320874;
        bh=dDuaO03brdw1iYzOwL3PX2dry5UVxc9RYnnURakU5Us=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JtVRaXE7PqdvStJEybRTcd/XozYJyPHyA1LZr1Dd6wjTsNMMRU1/n3Yb1inQtalMG
         ASZAsvll8VhyMqx0m/ef0OGb945xr3FA7aORsBVPfHxp25ejPuiLB7g11lrmsVFlYj
         8S7NmEaxOAu7deWnrpSGODWS/DGZ6JzgkLmUKy+nPZAlrKJLyymJ6BbnTHcQNcU8iz
         oLLRP9nn6rId3AuC6Dd2mT5iLYeQ8QW+SXuLYynzVj0VucXGZVtewOIi2LQxJAAYn1
         HgsfO308aoTZCy/ZBjGmyPydVjZ13ha6rH6oXofexvGtU9juloBstYj75+XnT174Mp
         s84sIzqrPzlhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F33A1C4166D;
        Tue, 25 Jul 2023 21:34:33 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 6.5-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMAt+QaAHn0XIGDt@tissot.1015granger.net>
References: <ZMAt+QaAHn0XIGDt@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMAt+QaAHn0XIGDt@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-2
X-PR-Tracked-Commit-Id: f75546f58a70da5cfdcec5a45ffc377885ccbee8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b4a9fdc9317440a71d4d4c264a5650bf4a90f3c
Message-Id: <169032087398.13532.9018732702267049465.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Jul 2023 21:34:33 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 25 Jul 2023 16:18:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b4a9fdc9317440a71d4d4c264a5650bf4a90f3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
