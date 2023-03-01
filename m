Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6016A740B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Mar 2023 20:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCATIo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Mar 2023 14:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCATIo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Mar 2023 14:08:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901761FEB;
        Wed,  1 Mar 2023 11:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 064EECE1DD2;
        Wed,  1 Mar 2023 19:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 414BAC433EF;
        Wed,  1 Mar 2023 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677697720;
        bh=x9tIGpZPJRVTH+ZOReA7qD9w2V6PTCZo1AvGcpxYkgo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uN4dMRS6b2P13bn9WlvPJMbtAm0uDv5ZajShVcr9s6tGJgue6vX9Pcj3/JVTbjjeM
         gY4678UVV74oSY5/+sAYk2SqXxy0EWfwbdiRn8zeC+HumGv56RJHZOiP8Jm4G4BT7L
         RUUlz+JEf7G2rbjr6NfymlqwoOW+VQ000/UoyVJEoO+oOUoTDmMkVE4LffBK9VsfDk
         v7ZYHH11JoeatqKBGCXuF5W9FBzlNGEI+lv5NRAE/xRGmmQHwEt4MwNZFxlzYU6W/M
         pS2ky0tNR0z6A0VlMUiEwo6OyJGm8pbVksShncw2wd+xWkN3Taddje4Gip8n+1rlIL
         qQ0II7RkiW3Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22AE0C395EC;
        Wed,  1 Mar 2023 19:08:40 +0000 (UTC)
Subject: Re: [GIT PULL] a few more nfsd changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <B67BC63D-90D6-49BC-BEDA-92A8F9710052@oracle.com>
References: <B67BC63D-90D6-49BC-BEDA-92A8F9710052@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <B67BC63D-90D6-49BC-BEDA-92A8F9710052@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-1
X-PR-Tracked-Commit-Id: fb5b855d9f34927579baa0a20b4d0d8ea3740abd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee3f96b164688dae21e2466a57f2e806b64e8a37
Message-Id: <167769772012.16550.5789226791698262714.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 19:08:40 +0000
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

The pull request you sent on Wed, 1 Mar 2023 19:02:37 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee3f96b164688dae21e2466a57f2e806b64e8a37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
