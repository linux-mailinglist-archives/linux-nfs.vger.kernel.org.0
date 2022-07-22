Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967457E650
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 20:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiGVSMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiGVSMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 14:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57D79687
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 11:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ADD5622CE
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 18:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB20C341C6;
        Fri, 22 Jul 2022 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658513542;
        bh=frpbxeynjZEb09kk8uKmqEnXqmQFUvdsJcdzZJs+3CI=;
        h=From:To:Cc:Subject:Date:From;
        b=HLGBTM7Kb+Qea+Zqq4L44NDBwnrFBA/6vUKDGFKPVRxQa5lRgyesQAt9MQsNlCBCf
         Ay1LB8pp5wswNWVustmXPKqsSUylWhAOdSY5SF5spNUZQ0BhpdIGOHzR2rDWQSStL3
         WZp6eFxfXsTVMkMHSmXTE+t72cCHIGbFoOr0BoFtCEQ7SufVVHAvzGoAMMA59je4IY
         QZSlGzK9dpSnzxsFsrd1WvqqBn6tpiMgZ9xIkzhb/8ny5UCBgD2A8ij4k0Lu1WvoUq
         hLkFA1KByaM9l5kXG3sAdrwsnEbdiV8dDb+kc6YRU2CzfrovinvsVXBbsi5cP7tx7m
         5iAv37om8tn6w==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com, bxue@redhat.com
Subject: [PATCH 0/3] nfs: fix -ENOSPC DIO write regression
Date:   Fri, 22 Jul 2022 14:12:17 -0400
Message-Id: <20220722181220.81636-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Boyang reported that xfstest generic/476 would never complete when run
against a filesystem that was "too small".

What I found was that we would end up trying to issue a large DIO write
that would come back short. The kernel would then follow up and try to
write out the rest and get back -ENOSPC. It would then try to issue a
commit, which would then try to reissue the writes, and around it would
go.

This patchset seems to fix it. Unfortunately, I'm not positive which
patch _broke_ this as it seems to have happened quite some time ago.

Jeff Layton (3):
  nfs: add new nfs_direct_req tracepoint events
  nfs: always check dreq->error after a commit
  nfs: only issue commit in DIO codepath if we have uncommitted data

 fs/nfs/direct.c         | 50 +++++++++--------------------
 fs/nfs/internal.h       | 33 ++++++++++++++++++++
 fs/nfs/nfstrace.h       | 69 +++++++++++++++++++++++++++++++++++++++++
 fs/nfs/write.c          | 48 +++++++++++++++++-----------
 include/linux/nfs_xdr.h |  1 +
 5 files changed, 148 insertions(+), 53 deletions(-)

-- 
2.36.1

