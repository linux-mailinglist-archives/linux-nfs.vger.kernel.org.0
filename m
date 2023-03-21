Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1596C3D92
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 23:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCUWRL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 18:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCUWRK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 18:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEAD166E8;
        Tue, 21 Mar 2023 15:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE0E961E90;
        Tue, 21 Mar 2023 22:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F5C5C433EF;
        Tue, 21 Mar 2023 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679437029;
        bh=nsvy8aesyTEka+6Srys4rjAATtd1NvjM2e3+TvVwVGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o0cZh4gWPY+dpdma2o/xmbQTY3KwjhkvDzdH3cesN9DMUzPz0xiZwfbi0SXnP4sIR
         CIkoLHwaCkf5Otzp4XK5BeO7RIp6OijCnDFKGD3dmjQlRKVabDL56m1Cd2H+aU542J
         UCCX96Phvf6i0ZPmybr2TpTTk48CV9lMznrcWXty0TNVvx5OYcOBl85R7nWGAF6Hjk
         xrV5ZtNappJ/Vpok9J7AxUxOIFx0jFf059D/bRi6SxW5sxe4NZNMPxcDxdDDIRDkv6
         MsXG2MmQYfCCTbMzYxdCjxC3498XKYW+VOm64c8KC2n70PgPGRXVVa9i1Tj1PkJvuq
         n1J0H6yyzn8Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 307FDE4F0DA;
        Tue, 21 Mar 2023 22:17:09 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2AD73E1B-E81B-4553-9975-11FA02841471@oracle.com>
References: <2AD73E1B-E81B-4553-9975-11FA02841471@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <2AD73E1B-E81B-4553-9975-11FA02841471@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-3
X-PR-Tracked-Commit-Id: 27c934dd8832dd40fd34776f916dc201e18b319b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2eaf246f5732519f3dcc34e18fd41909e226284
Message-Id: <167943702919.20068.16327885462078996611.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Mar 2023 22:17:09 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 21 Mar 2023 20:20:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2eaf246f5732519f3dcc34e18fd41909e226284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
