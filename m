Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341CC5F3BCA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 05:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJDDpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 23:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJDDpG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 23:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2361D108;
        Mon,  3 Oct 2022 20:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C2A661262;
        Tue,  4 Oct 2022 03:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9331AC43470;
        Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855093;
        bh=Li3oROszZIKP6+74i+7bj9ZK8GcAxN+tll9tuil6HJ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NDRuLGEPw+PdomK1N4SGRnrliI9JsoNmGRV1WvApUVQgH3w2FLgekjiMPGO2Wiq4X
         fLLZt+un0S6Ph+uBmQE+kNLsH5v91GV2y5ob2h7W8F5eY4h+CdP8buPg49pkqJkZE8
         5sC3hem02vnEpV1pePPRrYuZWLGhGQt2qO/Yme27Mbatktele9RXmvyZAIhmzyfiEr
         r/glHBTnLZONyySKzvBly1XlJyvyD/IhoDMVP490S9j6F/lz2Eeh0+qZg+HsVPVlFF
         s1438pBm7dQr+CI8wXoPf1ulEDHK4d06a5lm1yS99ADBb4sJmOhpYx4A80xuhcNW/G
         RhZ4Y3gN6RnhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FDF7E49FA3;
        Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1677F534-541E-480D-8C4B-7BF6126358B0@oracle.com>
References: <1677F534-541E-480D-8C4B-7BF6126358B0@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <1677F534-541E-480D-8C4B-7BF6126358B0@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1
X-PR-Tracked-Commit-Id: 895ddf5ed4c54ea9e3533606d7a8b4e4f27f95ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f90497a16e434c2211c66e3de8e77b17868382b8
Message-Id: <166485509352.18435.17018254146758653661.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:44:53 +0000
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

The pull request you sent on Mon, 3 Oct 2022 14:12:38 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f90497a16e434c2211c66e3de8e77b17868382b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
