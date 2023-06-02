Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256D720882
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jun 2023 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjFBRln (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jun 2023 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbjFBRlj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jun 2023 13:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1641BD;
        Fri,  2 Jun 2023 10:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB58060C43;
        Fri,  2 Jun 2023 17:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D55EC433D2;
        Fri,  2 Jun 2023 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685727694;
        bh=MeJZHg99CKlydE+P+L7Y5wugVA7dLNcMZaQ+hUjc8g4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qX0DiatAjw/Q9ngbWfH9L6nnWRXtnrJdY/HwPUm5CCz1iEplVI/81N5HjzBPmYQLS
         +0MBC1J6VV0tkLDObWXStpgtuNnSaJ+JW2v70EYUI0+4KrGRiGg8zL/RC7gW5LtJSI
         3+BkX+AlVeu+UVZwHtgXXZwhQSS7Gt1vT0zCzOtjIGvi9Nn2disn5rQEuaJ32nvvKL
         AV3ahf60IYlvcvjp4IFE5FdT/geG9jdqfbj6ual+KRqK3RSfwrCCZnoPaAjW7VejUT
         EyH18F6kELV2ELR4i5GZbAhM99LkSFvaJtC3KvbSyDtFAd1Z5HqLbJK5nj62KUUJMZ
         KRzSJKivmQ8lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B258E52BF5;
        Fri,  2 Jun 2023 17:41:34 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <10156F3D-A4B8-4462-80EC-65ECDECE7B44@oracle.com>
References: <10156F3D-A4B8-4462-80EC-65ECDECE7B44@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <10156F3D-A4B8-4462-80EC-65ECDECE7B44@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.4-2
X-PR-Tracked-Commit-Id: c034203b6a9dae6751ef4371c18cb77983e30c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a746ca666a8486a04b6c0584966bfce16f6b1e1a
Message-Id: <168572769417.31437.2089839050320893526.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 17:41:34 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 2 Jun 2023 14:42:30 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a746ca666a8486a04b6c0584966bfce16f6b1e1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
