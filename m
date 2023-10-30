Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8382E7DC357
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 01:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjJ3XuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjJ3XuI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 19:50:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC9101;
        Mon, 30 Oct 2023 16:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2B8EC433D9;
        Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709804;
        bh=w6DJsKwPGRPRodbCGtemYkN8tXZgqD10C65YQ3h6V+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U6B0mvflvcjjyUT0PmpQlEby6KzyRhW9JpJmWVQAFCmqHKi1KTQ094SMXKfNDgc9c
         INIdH4MQGZGr0iErPCfS77FDuSZONCi2b9fBDOUtvxsGc/rtdLiR+ntGpO8ZykcjOk
         rmAKh7yojLq5WL0iLFJTp8hct738amDg5JGSVYeJ8ySfV0v+ie7LUMkRDGCsvGc+m5
         BQv1LL2snL8brr5l2djUVhStw/pssUpYOorbWLsJGSq9pHvnvhzrAZvCTiWzPvY4dH
         jCHwcMCRD709ssIDOFiSzAz/CzRmH9TjQNZHfXKneo5egLPx84JhROR3Urw7gSpU7P
         39uvaHUwB04+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88811E00090;
        Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for v6.7 (early)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
References: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7
X-PR-Tracked-Commit-Id: 3fd2ca5be07f6a43211591a45b43df9e7b6eba00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b16da681eb0c9b9cb2f9abd0dade67559cfb48d
Message-Id: <169870980455.17163.2505665187097681594.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:04 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 25 Oct 2023 14:23:42 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b16da681eb0c9b9cb2f9abd0dade67559cfb48d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
