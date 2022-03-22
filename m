Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A484E4614
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 19:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbiCVSdl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiCVSdd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 14:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71DD8CDBB;
        Tue, 22 Mar 2022 11:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C6C615EE;
        Tue, 22 Mar 2022 18:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E22D2C340F3;
        Tue, 22 Mar 2022 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973924;
        bh=BvO9xjxorPKzNtbifAaDXxRI1tcjr1BhPyp+LlIQtuM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HQVEsQwGA0+ZKorsmA/4EYBA/dapDHMbMDgwOnfGlEmOBQlpHCAziVhdlpw4adoub
         cBlpkabSrLlF8rIusVhQ0eEKmrzSZ7jq+ScRmMZRC2pP/tLoTrVR9NZ9esQEvrdJ+N
         KH1ZoCW4pRQ+HhILpy+q+kwhRHlgHuCHEGdq8LzLBIo48G6hEIY0tANeICvve4XsS1
         C3iV0pzQNQ8QmPLlyWdcbPL/8lQlBPBbSC/aZX5kx528Y8Lok9+VR/EgbLvBKLgEhf
         B6lIu4L1j/t8eEUrWyz1vKZWZy8BIE3JAmK4rdNW3axkVyv8RoRur5+Yqkg+Ix4XU1
         ltUUi1othumCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D08BDE6D402;
        Tue, 22 Mar 2022 18:32:04 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.18
X-PR-Tracked-Commit-Id: 4fc5f5346592cdc91689455d83885b0af65d71b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14705fda8f6273501930dfe1d679ad4bec209f52
Message-Id: <164797392485.17704.2835311924225586670.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 18:32:04 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 14:12:31 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14705fda8f6273501930dfe1d679ad4bec209f52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
