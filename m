Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00877848F2
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjHVSB4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjHVSBy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 14:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856DCE9;
        Tue, 22 Aug 2023 11:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BA28631D0;
        Tue, 22 Aug 2023 18:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF4E3C433C8;
        Tue, 22 Aug 2023 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692727311;
        bh=6xhOSRtjiq+r4qTPh9jXIiO9F8FQgGP1Ilc7DrpUQaw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3pDquHQi6nVv1GlWBmgTCcYhaIq64Yy00Inef4dyBMBzVwrmbSJ06j2Say0oX7Hc
         rUQ7wDdyWlqoisAkOIf2vaIoQEiIMmXYN52w953sCRg99iJ85d5jXT+o1GFAfPFi1y
         iq6Eij3f1J3Pw16vjY/GWDmxlkBBY/MQMWDt3VukVL9D45+Gey0ujPunfL0bMDVShA
         JnYRMvgxbpwJ77+oxUB+Kh7ZTmn6qy4w3xjBr2GvDC3fIW8bICfl2Se9CdPDCG0r0t
         8nQNMIUC9BoWgVXHiAFmvXuLTeTTzbOw3jhKaouN/Vw5mvsmWh2pVlmm+ikZ88ltjG
         LGHtAbOTBHXxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8ACAE4EAF6;
        Tue, 22 Aug 2023 18:01:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for Linux 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <10efd849aa3c182bae0009523ad9c5fbe3be4e8b.camel@hammerspace.com>
References: <10efd849aa3c182bae0009523ad9c5fbe3be4e8b.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <10efd849aa3c182bae0009523ad9c5fbe3be4e8b.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.5-2
X-PR-Tracked-Commit-Id: 895cedc1791916e8a98864f12b656702fad0bb67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53663f4103ff6738e4697004d6f84864d052333d
Message-Id: <169272731181.11168.16209277699808752601.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Aug 2023 18:01:51 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 21 Aug 2023 15:24:23 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53663f4103ff6738e4697004d6f84864d052333d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
