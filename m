Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF39575677
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiGNUmh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiGNUmg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 16:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787C4B4A8;
        Thu, 14 Jul 2022 13:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D915B61458;
        Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49B11C385A2;
        Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831354;
        bh=WlL4xd9IG6iQ8maF/GSaYWdPO86S+eg4JFrATnxTHio=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lMnQSLb/57ge32F6iREjO3RcPxVi5W9WJOxCEDXQR/cur9f1gkiPqtsVZwVcUWCIF
         qRqMhHD3SxR3fXBxyMEql8d81oDXstuceD1BmIozAdqaxuyjVy1AbAEHcUpQJuHI9Y
         Jrm85hPoTYZZKpN2yPMpROuER6foH6lNWraWY6mgAdvTZE1klneAjuJg2FgrrahntI
         RzdZqEf37947ZQpgYUsYVN6YQm6raeeKchg2PdYFGyP9iFtmDg3JkVrMFmNqlTA/b1
         ViG3Zx6hGJk+bm971hcIuMj+4PQKHEccpJ6wiEiRQZpBH+OrQtZhC50j4AMRRcLU/O
         7B5NqF5GjKjow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FBEAE45225;
        Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] 3rd round of nfsd fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5E921C2D-2309-4EEF-B360-A27361CA9F2B@oracle.com>
References: <5E921C2D-2309-4EEF-B360-A27361CA9F2B@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5E921C2D-2309-4EEF-B360-A27361CA9F2B@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19-3
X-PR-Tracked-Commit-Id: 1197eb5906a5464dbaea24cac296dfc38499cc00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a24a6c05ffa7adb3f2d4b417ca46eedbe67b7302
Message-Id: <165783135419.13350.7631576889920728960.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jul 2022 20:42:34 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 14 Jul 2022 17:02:35 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a24a6c05ffa7adb3f2d4b417ca46eedbe67b7302

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
