Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861FF64AEE5
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 06:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiLMFAq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 00:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiLMFAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 00:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5431DF30;
        Mon, 12 Dec 2022 21:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DFF761323;
        Tue, 13 Dec 2022 05:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E886C433D2;
        Tue, 13 Dec 2022 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907614;
        bh=leAcdic38CbpApwafL+Ci06USfMIh+sX+cBGXGc1rsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V2uyC7DQlKdG/RKON3Sya44tanO16MWGxvtwmFY34X3duwDtjOAPt6yHaglGIeOE+
         WrMQDOM68zwJzuYgCykqsRMSwZAjf8lYXtRHZvcQeOtLviiev3sVgHkXA03Zl2pjup
         kwzYOdodHAD6Zbtk7HXCtSWigvPMM3RHbS5XOvt6Lji05pUZ0047rk3zxtS7CVYsbk
         3Yucq79fBRcnOMX2s9fq/QUjZHBIlF5a1QPbzwXs3JtoqmQXyIEUADNybTGwyFCZXI
         2ViO8hByOhdyM7DxxvcWOd4h0jgfczcswIJ9JL2NpHQ7x1zyqHk/5peSyivP/SSsw2
         V3zWJ4eipcd1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8960EC00445;
        Tue, 13 Dec 2022 05:00:14 +0000 (UTC)
Subject: Re: [GIT PULL] initial nfsd updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ECE34A45-6FD7-4559-8F68-9340E6B3FDC6@oracle.com>
References: <ECE34A45-6FD7-4559-8F68-9340E6B3FDC6@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ECE34A45-6FD7-4559-8F68-9340E6B3FDC6@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2
X-PR-Tracked-Commit-Id: e78e274eb22d966258a3845acc71d3c5b8ee2ea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 764822972d64e7f3e6792278ecc7a3b3c81087cd
Message-Id: <167090761455.4886.7014181387863711533.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:14 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 21:46:26 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/764822972d64e7f3e6792278ecc7a3b3c81087cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
