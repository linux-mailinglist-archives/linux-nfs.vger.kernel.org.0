Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981D7D17B1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Oct 2023 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjJTVIE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Oct 2023 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTVIE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Oct 2023 17:08:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D3D60
        for <linux-nfs@vger.kernel.org>; Fri, 20 Oct 2023 14:08:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5422BC433C8;
        Fri, 20 Oct 2023 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697836082;
        bh=HJJ7C1SmjTsTxZPUx03Xagej6NBCinxnAHCKI7TZCX4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iO8QuhwPnLDflqfq/qkCMe/tfbem+RfyMpDd8nXxrTkf8xpk4ZiSvsZFjsOcNRHF0
         9p9lRlxv7WKSdWm1ecF3nr1Nrcbh8vuwOswtE5dFT1ishQMhiquWtc6GKGHZb9f2b/
         83wMmnaRrQcKw1RNtl40g7ZmIk93hBJkiom8jz8g91r8JhgUETnyAH4LH6UQRAEUDv
         1CH73Jd+cRcxFY4iiA9J8svuyKmXbWpXmaQb2fFIwNs4cj0QikQHuP1sOgiOXnoPKx
         GTanp55L8QHddGBmA6ioxCtD68/Jeyu1B0FZclhvR9dSgNXvCDzWrd8xat7u19zGd6
         QqfI4oVHL1SAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BB28C595CE;
        Fri, 20 Oct 2023 21:08:02 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull a few more NFS Client Bugfixes for Linux 6.6-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231020202551.162687-1-anna@kernel.org>
References: <20231020202551.162687-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231020202551.162687-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-4
X-PR-Tracked-Commit-Id: 379e4adfddd6a2f95a4f2029b8ddcbacf92b21f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f74e3ea3ba9cdef948999c29c1c9793ea26787b4
Message-Id: <169783608224.30992.4905898172187400062.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 21:08:02 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 16:25:51 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f74e3ea3ba9cdef948999c29c1c9793ea26787b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
