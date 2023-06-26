Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C618173EB8A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jun 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFZUGP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjFZUF7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6157F171F;
        Mon, 26 Jun 2023 13:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E236B60FC6;
        Mon, 26 Jun 2023 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52EA3C433C9;
        Mon, 26 Jun 2023 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809759;
        bh=KKzvPENbQc1xRLJOrzxJ/7j2pOqFRbx2SXPnmU1fmKg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NLXIn7bviZwWRyLjmY0At07Vdn1qyq3FimOjRcKUYZl6C9LLDSHzZlsh1NKhKygYP
         oonhLXb666Fy2WR68Vw8aSaRIzV3zrqh+u8GiC+7Dk3yPmNSdv5330QOOn5elniUiV
         KbHEvGPB1WmBgPcCelxH2lkeI4o0uClPM9ZxLnz3LeOsLgMmhUyXJ7YQQ8sPGdjKUW
         yGWOL/r+BKgbI+fc7a2jlwFkayD9a85ssXzneP0T02U5xuHYk9rjfqrQbBXGY9Di9o
         SpYm8rsYbifj4FdOOGaKxkmAmgpcTJyE482g0xeA34nOPWO6XW/tsaASThh86ucIRZ
         4U2DiGn0QVYog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 428DBC43170;
        Mon, 26 Jun 2023 20:02:39 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7849B3C2-CE1C-4C52-9CAE-23CC7FF42A41@oracle.com>
References: <7849B3C2-CE1C-4C52-9CAE-23CC7FF42A41@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <7849B3C2-CE1C-4C52-9CAE-23CC7FF42A41@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5
X-PR-Tracked-Commit-Id: 75bfb70457a4c4c9f0095e39885382fc5049c5ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7976a6493b3f00c4d057a37d9e63c322154ef8c
Message-Id: <168780975926.7651.14476946095245940562.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:39 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 14:11:14 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7976a6493b3f00c4d057a37d9e63c322154ef8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
