Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4335F6B75E6
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 12:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCMLYI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCMLYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 07:24:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB12A6ED
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 04:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B79AFB80FF1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED421C433EF;
        Mon, 13 Mar 2023 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706643;
        bh=SmjOGWctYeVbnfdsC/hN52ZsPmMxP83sml6hFEurJPY=;
        h=From:To:Cc:Subject:Date:From;
        b=bJrkx3O0pNLA9njDYiZX50+DLsMVTjur2y/lX5iRUYQ6ROd5mLl6CYL56m4ROZFp3
         8zh2ggi/qKsX13CpbknGXmKCc64FM+AHREV3/xOghb3co0k/SR72b/LbnhuMQSWV27
         qKTua8SH45juYp/GVU/+4PFTIPBTR8eHWUdTPSr6iN7HTiOyT25IHMwFzymlrZAhBq
         MEn6MF9MgE4ZRBjUm4gE10XQyt+cnuj5wKevpiC+dZYhplfEKMpC7XdpcGIGHneBpU
         8gStN1RnKmq9l8fAcGmQbujgfepbIOdCSp8BTjfnuiKbayC4TP19TZqJXf6LdBHiGj
         aLc0D7qK8SqGQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     calum.mackay@oracle.com
Cc:     bfields@fieldses.org, ffilzlnx@mindspring.com,
        linux-nfs@vger.kernel.org
Subject: [pynfs PATCH v2 0/5] An assortment of pynfs patches
Date:   Mon, 13 Mar 2023 07:23:56 -0400
Message-Id: <20230313112401.20488-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v2:
- instead of changing the meaning of the "all" flag, add a new
  "everything" flag.
- add patch to fix LOCK24

I sent some of these a couple of weeks ago, but didn't Cc Calum (the new
maintainer) and a couple of them needed some changes. This set should
address the concerns about changing the meaning of "all" and adds a
new patch that fixes LOCK24 on knfsd.

Jeff Layton (5):
  nfs4.0: add a retry loop on NFS4ERR_DELAY to compound function
  examples: add a new example localhost_helper.sh script
  nfs4.0/testserver.py: don't return an error when tests fail
  testserver.py: add a new (special) "everything" flag
  LOCK24: fix the lock_seqid in second lock request

 examples/localhost_helper.sh  | 29 +++++++++++++++++++++++++++++
 nfs4.0/nfs4lib.py             | 21 +++++++++++++++------
 nfs4.0/servertests/st_lock.py |  6 +++++-
 nfs4.0/testserver.py          |  2 --
 nfs4.1/testmod.py             |  2 ++
 5 files changed, 51 insertions(+), 9 deletions(-)
 create mode 100755 examples/localhost_helper.sh

-- 
2.39.2

