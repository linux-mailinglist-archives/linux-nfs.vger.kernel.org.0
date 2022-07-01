Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5862B563909
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiGASPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGASPn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 14:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713DC14D1D
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 11:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D2F3615C6
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 18:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA32C3411E;
        Fri,  1 Jul 2022 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656699342;
        bh=AifXQBOrGr6QCkz3PunaH8rdc8Gu/nK3uL2Ogdy6ZIo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E4ZjB61ZpsebzMySlLTH2Fqnq4P24OgSXHwMXo+RAZsvcuGjKzsIO3hozD5+K5vuE
         Pbrft1ETav4afQlMZaEK0Ql7iKPSU+Iac+bD0m4CVsh1Djg8FexgsXMqHSGxazj99w
         Oi81lDc0PVimBrvMzF8oHIHskq6QPxGmIbtVfbs6iBZswe6QMr2l/h+zYCFS609l3+
         z4yN4Z3skiYVBiW7fDKdP1oZu4eCW3fb2hNUc34KDATLpBSKm2MAWBoPWEYxaumX9n
         8RvFz8C/mLKf8twsa97bDd7CsBGrTD+AG5DSsDh6gnYkmQsos/y1uSMwngbJhcqL1T
         aY9qmn9Om0Quw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50E4AE49BBC;
        Fri,  1 Jul 2022 18:15:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull a few more NFS Client Bugfixes for Linux 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220701175639.1793038-1-anna@kernel.org>
References: <20220701175639.1793038-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220701175639.1793038-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-3
X-PR-Tracked-Commit-Id: 4f40a5b5544618b096d1611a18219dd91fd57f80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76ff294e161921e9867ad68775ba95a210eb5ec3
Message-Id: <165669934232.22761.11122401077804906519.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:15:42 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri,  1 Jul 2022 13:56:39 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76ff294e161921e9867ad68775ba95a210eb5ec3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
