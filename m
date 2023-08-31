Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CB78F5B3
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbjHaWmw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbjHaWmr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 18:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29246CC;
        Thu, 31 Aug 2023 15:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E4760BBA;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28EA7C433C7;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521764;
        bh=UGJNd0s2MSSk5ykOJOh3wJPCqKLtZUHsnNTZVWE3tEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IMsgLlCzIm+sDAcUV6Ge+KXMUQ8NM7amCma7vtUgMZ1+rqcyLWtnMxHPIMy/yrWSu
         zbzppw4jAOlwg4AA+O8LCOVpCnV1C7e7yywMYR9VjoMt9quxJK7s2LNUjoK3aJN0H5
         0dSW6p68t/MRPKfDnr5smaQ1CNm93aqMxvQ7xEv7qooHXprO25bSvmPh43q4+39cx7
         SRBUfytzd0tqw/Dl2kuDPSeAydxfMx36f8uiLR2PnNkuVCfriDySB/PcnreNKkCak/
         KGUHFG7etrbujosKpBQGDlhTwO7afrtJpeRwBgoviTtjms7HOeZJv01CwOfxAxt2n+
         fVpZwzt6WJyGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1140FC595D2;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <F7285657-5A35-42E0-87B4-1EAEE8DDF618@oracle.com>
References: <F7285657-5A35-42E0-87B4-1EAEE8DDF618@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <F7285657-5A35-42E0-87B4-1EAEE8DDF618@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.6
X-PR-Tracked-Commit-Id: b38a6023da6a12b561f0421c6a5a1f7624a1529c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f35d1706159e015848ec7421e91b44b614c02dc2
Message-Id: <169352176406.24475.2460539472651236300.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:44 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 14:39:35 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f35d1706159e015848ec7421e91b44b614c02dc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
