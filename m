Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0192F4BC369
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiBSA3I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 19:29:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbiBSA3I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 19:29:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C712B7C4E;
        Fri, 18 Feb 2022 16:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFBAC61F82;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51A2AC340ED;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645230530;
        bh=gIMZLn4Q9/LKSvS4WzeGjDlGcZ4bQhXwN/jNdrIEJ54=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CEIPLMRSaZsA1Vl1Rinu1V+odPdYcrXWKKDsAhSvmoo4U/NS0xIe+fpT7gevlHDxP
         jK+MJhdhz8kPwINE/f2u+KzZUXQfgR/Pj1psROLe1MQxB7C1kjZRp0AOqwpvWTiyrA
         V3LTCEJ348lrATqu7L26xawvBiuiK+PQdh0Mdv216DHPJMhtSiCahRD/9Wr16ltk5l
         Q7vbSHHZJuXzd9norV3OEXdNNYcXQtxc+oIS2ggyUjdDanz1gBrA5f8ZhgNMZ6spXn
         pPasr0dF2VYOdhP8fg3ZVGgNvff8PxBC3BCB8imtEazjqyTDoPUnV94or07+g2o/GR
         i+VQqQPWSNi0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C959E5D07D;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull A Few More NFS Client Bugfixes for Linux v5.17-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220218222320.386771-1-anna@kernel.org>
References: <20220218222320.386771-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220218222320.386771-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-3
X-PR-Tracked-Commit-Id: d19e0183a88306acda07f4a01fedeeffe2a2a06b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
Message-Id: <164523053024.25426.2356686124435032276.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Feb 2022 00:28:50 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 17:23:20 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
