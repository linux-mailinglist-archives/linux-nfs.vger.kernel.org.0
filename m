Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1417E6154CE
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 23:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKAWNT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 18:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKAWNS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 18:13:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D9193C6
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 15:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84731B8117E
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 22:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D45EC433C1;
        Tue,  1 Nov 2022 22:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340795;
        bh=ROLiU0dHEz67vD7MD6ywvUvA5pEGmz5x/njFgMaAGNE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dVV1kcWUr9ieyAU1MDrvTQ2UIiGWCgabPCcNRICEbqsW0Viin06h3bibOq4dI7Bd6
         Vtjkfs3QvFl1UkmD617Bdk2JWsT+O1Z3To0fghsNzV3vqYAytlBlP5nAMcqTcxrTuD
         NX2y5EraBIthm1rZXEAvZKzTRgtSfyC3Gtl537eVkeZo/K8g7LNOfhFQtvMATzaC7z
         aKTszhi/U2C+BU+2SiDHGBNUkFwCPE7uHglIq7/IWEIM7weQubNX770B3n0STvZ9nz
         ZnX4bKikc87MbwoOZD2gplh+Mw5ke+oxat3xBUYANxnrEuttLcY3LojETnfhRzksp+
         J6vxkdAsAYDJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CFE5E270D5;
        Tue,  1 Nov 2022 22:13:15 +0000 (UTC)
Subject: Re: [GIT PULL] Another NFSD fix for v6.1-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4A2FD32D-3EF6-49F8-80ED-E92F92AA8EEA@oracle.com>
References: <4A2FD32D-3EF6-49F8-80ED-E92F92AA8EEA@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <4A2FD32D-3EF6-49F8-80ED-E92F92AA8EEA@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-3
X-PR-Tracked-Commit-Id: d3aefd2b29ff5ffdeb5c06a7d3191a027a18cdb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6eafb4a13dde4998bfef03e7e862eeb7f522d2fa
Message-Id: <166734079511.28322.10449665554370148931.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Nov 2022 22:13:15 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Petr Vorel <pvorel@suse.cz>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 1 Nov 2022 21:39:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6eafb4a13dde4998bfef03e7e862eeb7f522d2fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
