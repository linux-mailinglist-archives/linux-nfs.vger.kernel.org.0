Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E354FE44
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jun 2022 22:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbiFQUXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jun 2022 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347398AbiFQUX1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jun 2022 16:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53850E34
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 13:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB256201F
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 20:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5EE7C3411D;
        Fri, 17 Jun 2022 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655497405;
        bh=Pemqi22VBYYD+wqOh5aX6+0XyyVLRnLfgqsFnXL5KLQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hg2B8TQYhKbaut730kqt9yEHBzVpQyQyApe6rT26fboq1O3E1Egguh+3+4aezojcu
         qmYMeL4GqeYoSjTR4jffTVmoW0R4MN4/dXYpFQElMtCk0KPvWgsmRj8a8kBtI/S8gw
         K1U8MWAx2Wdra9h9cHqoZ1jhFq6SiehnO+K6jyVemLExxc8Ih4CuXOJSXv5bjnTqs7
         EuZO/7dLzTGLDbvvlp9MQeO9bXJUS/OPjS48/El16bzynJYP/QG5G8qRtZstUOVtah
         EQQqRB+xOqGdoD/dQ3ljgt7L0LpNZO/b2MwlSTLuchOSbE5BYoLuPPPCdZ29QsDLrB
         h9BjfeUR/2mGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D5BEFD99FF;
        Fri, 17 Jun 2022 20:23:25 +0000 (UTC)
Subject: Re: [GIT PULL] NFS Client Bugfixes for 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220617195651.1028948-1-anna@kernel.org>
References: <20220617195651.1028948-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220617195651.1028948-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-2
X-PR-Tracked-Commit-Id: 5ee3d10f84d0a32fc11a55c70c204b6d81fd9ef6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
Message-Id: <165549740564.12674.14980853172608626540.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 20:23:25 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 15:56:51 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b35035bcf80ddb47c0112c4fbd84a63a2836a18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
