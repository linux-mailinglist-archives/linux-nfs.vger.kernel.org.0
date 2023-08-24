Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13232787BD8
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 01:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbjHXXPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 19:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbjHXXPa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 19:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852191BDB;
        Thu, 24 Aug 2023 16:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C04648B4;
        Thu, 24 Aug 2023 23:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89BC1C433C7;
        Thu, 24 Aug 2023 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692918927;
        bh=oi1G9lH977lXd8Y3lxb67JDphH/s/19Bf/NzzHu0nDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vy3GgKCjT5HEmo0R+9PKor+rFIAL90fpG6cYf/szlit/obF+fHjoOC5+zeLgRT40n
         kBIslQV/Aef5S9MRJzOPxWcwWzrB5aO/Ktl8qNsDjHfVS20viAW4ek89zt7VXG1NIo
         NHGqcgmdNiSJTwZwCadQopv4AUpTzl1f3IqT/D+PoaWLXleiLjd79AekyL5tDhaMMO
         nGB8uorfec31t1oO7YBG+iNtyRdBHDEAAbOqL9Ecb/A6ncVROENhq/wewcVmz0lbkD
         Yi2HN5T3F7GcqntvQicfHiboDelY5XcH3SgCDhF9obuR88J95AcEacfqlUTvXNdjLC
         Nyd1wRK+ARpLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B77AE21EDF;
        Thu, 24 Aug 2023 23:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] late nfsd fixes for 6.5-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <DCE0F098-3F69-4C3A-A74B-34F4E6AF0AA5@oracle.com>
References: <DCE0F098-3F69-4C3A-A74B-34F4E6AF0AA5@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <DCE0F098-3F69-4C3A-A74B-34F4E6AF0AA5@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-5
X-PR-Tracked-Commit-Id: 8073a98e95323abdea5491533bf5cb51e0ba18d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8d6ff449094b4b5eff40d4af08e47c520b78bc5
Message-Id: <169291892743.17835.4411620027382743612.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Aug 2023 23:15:27 +0000
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

The pull request you sent on Thu, 24 Aug 2023 19:58:23 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8d6ff449094b4b5eff40d4af08e47c520b78bc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
