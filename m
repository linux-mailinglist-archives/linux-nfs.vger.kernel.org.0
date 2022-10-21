Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565606081F6
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Oct 2022 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJUXDt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Oct 2022 19:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJUXDs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Oct 2022 19:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1B2AD9CC
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 16:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 654CD61FA5
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 23:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCCF7C433C1;
        Fri, 21 Oct 2022 23:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666393424;
        bh=NmI65qGU3Rjv5pE5h4S6+mE1ZE+POh/NVMNcAXIgH4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dNVm9+FcHsXv9W9m4KKoHMzn0TR5K2UEXvN4VhqtDF/FiFZcmL06RK+LxAd9r2FQ7
         crxmzxw+/eQ2/1MNI6K+aSBvShu7qN1sa5O/mPOyqDY9foBsB/tBO+oWdFy/9XNXGn
         VSXO4/dp03F4vfE1LjWeYgfftp+JL4uwNiKtGFV4gbJlz9tYHxwTFaIH5e5PtkSxdB
         RMgJAqmXQfOx40Xh1JldPm4X6uV+4/q4mwAa1A4fb6E4LHMJfIw+97hsQ2chd1sEIx
         t+r23YjRrRqtOakUfbg0kfNXENQSEnwgvj8rg0P/XnJCnCSkkjOKi5rQEEr6AntfaX
         CxucbUWzfP6jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC544E270DF;
        Fri, 21 Oct 2022 23:03:44 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.1-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <FE0137AB-C9D9-4496-9CA9-8869A581F889@oracle.com>
References: <FE0137AB-C9D9-4496-9CA9-8869A581F889@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <FE0137AB-C9D9-4496-9CA9-8869A581F889@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-2
X-PR-Tracked-Commit-Id: 93c128e709aec23b10f3a2f78a824080d4085318
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 022c028f4cfd6af728fcb9314712257a327d47e0
Message-Id: <166639342470.3847.11744686588476146401.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 23:03:44 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 13:40:46 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/022c028f4cfd6af728fcb9314712257a327d47e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
