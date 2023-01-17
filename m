Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858E166E52D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jan 2023 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjAQRqp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Jan 2023 12:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjAQRqB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Jan 2023 12:46:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA392582A0;
        Tue, 17 Jan 2023 09:35:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03914B81979;
        Tue, 17 Jan 2023 17:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA8AEC433EF;
        Tue, 17 Jan 2023 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673976944;
        bh=848o8merYVghBcHYEWOivqD9/a9CjqlP1t7aqAt7q1M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YBvuINTDfXWHDzAUb5YAiQgXttHPl5JxgiMOXwngjb1Qp/dPpXvrQpgGCewF/4fJi
         NzdsedKVHUWUEwy3sGHlUR1PbDN3aNrgshi0X+ff7AkP/rgDp4NrRxNg7UHycbgxzR
         FX5O7UlOJasmaflrXrkm5FsEhibKYUdUuFVZtE30H2UVaGDOm8qWt9zVg2Fyvt9QHd
         D1MLUFzI3hv9dimo+VC/TYv3v+TQNsLSAOZAQkR8oe2q6GUEngo2kO6gEMvGhePueJ
         0sEXN6k8Dco/JQpfNri/eCBgd981SgQHG485OSiGWTcfl6wLfF5QahNCubOlyQjEWh
         ZnpH9Uc36rB+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 939E4C43147;
        Tue, 17 Jan 2023 17:35:44 +0000 (UTC)
Subject: Re: [GIT PULL] third v6.2-rc request for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <A5F12427-0E66-4650-A3B0-D2FB5407401B@oracle.com>
References: <A5F12427-0E66-4650-A3B0-D2FB5407401B@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <A5F12427-0E66-4650-A3B0-D2FB5407401B@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-4
X-PR-Tracked-Commit-Id: 7c24fa225081f31bc6da6a355c1ba801889ab29a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1649ec55708ae42091a2f1bca1ab49ecd722d55
Message-Id: <167397694459.24435.4250290502716476081.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Jan 2023 17:35:44 +0000
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

The pull request you sent on Tue, 17 Jan 2023 16:53:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1649ec55708ae42091a2f1bca1ab49ecd722d55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
