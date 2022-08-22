Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F459C733
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbiHVStg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiHVSsn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 14:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209713D58B;
        Mon, 22 Aug 2022 11:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9943360B0C;
        Mon, 22 Aug 2022 18:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0263EC43470;
        Mon, 22 Aug 2022 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661194081;
        bh=+snvdBmnUr2cHSH6c5aSpV+2FEbzaetQvkRujdnGZik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J/BHtot+B9GBWV/+yhMue97NQnuX31eGrcA/VqcPWN+OV2nXlQ82/44MzM0dEcAg5
         Xx8lSNFuWAOx8PgvmKKCRdFBoh8FMO50vE+jRBh+D7cZ7r6KSRf+9lbEnUBHy89wST
         7FZCdyKwmiRTgT3I0yqmkeg2v4yiSevp6NE22TzMpnR1s8ier/kOlCyhBOa2wcEIHz
         XM/wBuiYaooJRLJSFTrLYP6UDpI4cVqJ/CWG7KKYMa20v2IgSUPA7UwQ+40sLUqEZf
         f+ZxQmw10twAA1FgxSr5cNYbvq/cNYkdEaO3U2nKniHo384fdBCXMPwW1f09OkHgL2
         vKxNVn6eJczlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1DFEC4166E;
        Mon, 22 Aug 2022 18:48:00 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for Linux 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b3717e756e8360d0f8ccb70a9b13b4cd9d503a8d.camel@hammerspace.com>
References: <b3717e756e8360d0f8ccb70a9b13b4cd9d503a8d.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b3717e756e8360d0f8ccb70a9b13b4cd9d503a8d.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.20-2
X-PR-Tracked-Commit-Id: ed06fce0b034b2e25bd93430f5c4cbb28036cc1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 072e51356cd5a4a1c12c1020bc054c99b98333df
Message-Id: <166119408091.19448.9475822319416740010.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Aug 2022 18:48:00 +0000
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

The pull request you sent on Mon, 22 Aug 2022 17:40:18 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.20-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/072e51356cd5a4a1c12c1020bc054c99b98333df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
