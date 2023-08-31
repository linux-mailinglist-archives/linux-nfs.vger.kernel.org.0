Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A178F5B9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbjHaWm6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 18:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347828AbjHaWmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 18:42:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D0C0
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 15:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E086CE2259
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 22:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEA87C433C7;
        Thu, 31 Aug 2023 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521769;
        bh=ytfxFpWOGT59xai+TdSY7m7MWOIrneEISZ/JFcEDJ7Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H7mt6vy5NKcgNsSEULA7ZntI4G7nqheCoYGFjg7IyiP1X9hlC77u8mnGN+LvMUMnh
         /N00oSHW8VUIPU7gXQ6VfpVvtA70W5blnSEw9i8v+uvRuYm3K2OhosHie0uZ6yWV+b
         tqyML6wglbIIdCYjbJd289Afy6wJ0nBl/GTEtLDAs+w/dMoWDiJZo9AiZ5KVVfru83
         kaC0Fs1JA/dq/7uVg2CwWwLpU/MbSrlKxE5tR+V8Lb0lHJRqtVb1pTJzeziY+H1p5Z
         8M72sBwuNbrYCiZZjGcgqM8oTGk3GCFJabzpdMewL5R991LTEVGJ6jr15dLQueStH2
         cELXbRXsVlGiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7A26E270FB;
        Thu, 31 Aug 2023 22:42:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client changes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230831184115.811493-1-anna@kernel.org>
References: <20230831184115.811493-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230831184115.811493-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-1
X-PR-Tracked-Commit-Id: c4a123d2e8c4dc91d581ee7d05c0cd51a0273fab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f
Message-Id: <169352176887.24475.7665360740554137678.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:48 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 14:41:15 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
