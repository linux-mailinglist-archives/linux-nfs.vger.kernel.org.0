Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB9744B32
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jul 2023 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGAVto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Jul 2023 17:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGAVto (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Jul 2023 17:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A90CB2;
        Sat,  1 Jul 2023 14:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E995D60A72;
        Sat,  1 Jul 2023 21:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A3ABC433C8;
        Sat,  1 Jul 2023 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688248182;
        bh=CqNsMs1ge4fApjWGu4EO5ntLXPQKj2XEYZR7t2Mcx9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ieu0hdN6blS9LhQRfEtbnABzT6EkGdndgMifiB6L91QcyzqeHbgc86gSb0wQFL41x
         2Y+0c1PEt+cZu1OQBMgstDj30LlsqvavZ8pWKrJsW1c/QduKByPOzc+L54E/MYU8eF
         vT6zGHNkdcMeQgFkEwQLgbei6TDlPr2E8DjVrnL+823jHbl8RJBD8ZPqk+B6sl2Xlm
         bdlx5golS+mKOZR5h85pYI4tVjW06GY/xKHny82a0mQh2uU0BZHyN3jWDqIUK3HOqU
         8nFKNpi2gHZigro0u/3/XvHxprBnhh/tKYLAmcYxFSnsZRO4hdMS2HrLXE2qMe56sE
         QwX4oCcss5cow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A381C0C40E;
        Sat,  1 Jul 2023 21:49:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fc3d657d436e21d86b51fcfa0553c04d217d4b80.camel@hammerspace.com>
References: <fc3d657d436e21d86b51fcfa0553c04d217d4b80.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc3d657d436e21d86b51fcfa0553c04d217d4b80.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.5-1
X-PR-Tracked-Commit-Id: 5b4a82a0724af1dfd1320826e0266117b6a57fbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfab92f27c600fea3cadc6e2cb39f092024e1fef
Message-Id: <168824818229.28886.11565152345827076204.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 21:49:42 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 1 Jul 2023 21:33:15 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfab92f27c600fea3cadc6e2cb39f092024e1fef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
