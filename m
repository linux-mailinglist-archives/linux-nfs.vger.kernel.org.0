Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF3616CA0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiKBSjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKBSiy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D293C5
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AD6EB8240B
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 18:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0909C433D6;
        Wed,  2 Nov 2022 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414298;
        bh=pxetqQSSe4tuHz1JReETAu8WcdxIERkmoOBOUxjHgWI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uil0mEGaJKoAjPTn+wa027OjCA0U4Rma8QKKAPOUw/Ni0I8bOzrK75g3w3j9PsuVg
         RhYJtYXPmP5ANuVE9WDPt50Sm+dqjnAAymKwY5y5t0+xKkJu+G9ohcO9b382bPqAMl
         10vIcQE1fB3/72s2rWbQAvhORzP106YVqm3ak4zSkpF7g+PlmdhzaxfPDOnVST0Cs9
         A7fZvKVUzSRmmDmbAV17BwF6Fxx/hPRBHrYLSIcT6UR+u95LcUlmDw5R3HZPcnuEO7
         gEsHkIRkQGa+ENNK4fd6f2NPj/2evwM9ZjK+k1L9Z3RdK+lo02Db35aW500E2TH9RU
         Ua3W7Ek61rtgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A874AC395FF;
        Wed,  2 Nov 2022 18:38:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client Bugfixes for Linux v6.1-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221102161846.1376981-1-anna@kernel.org>
References: <20221102161846.1376981-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221102161846.1376981-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.1-2
X-PR-Tracked-Commit-Id: 7e8436728e22181c3f12a5dbabd35ed3a8b8c593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31fc92fc93d54d8bedf0d06c1da0510a89867978
Message-Id: <166741429868.10915.14024761605534630328.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Nov 2022 18:38:18 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed,  2 Nov 2022 12:18:46 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31fc92fc93d54d8bedf0d06c1da0510a89867978

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
