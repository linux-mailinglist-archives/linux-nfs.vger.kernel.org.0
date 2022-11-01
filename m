Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132D614CFF
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 15:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKAOqy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAOqx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 10:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4301BEA4
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 07:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 193F2B81DE9
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFC2C433C1;
        Tue,  1 Nov 2022 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667314009;
        bh=7wDsMPKy/LOrtobqeDnYgmC5AGJ7arCeLyp8mp7em5w=;
        h=From:To:Cc:Subject:Date:From;
        b=TiF01zcZ1NWqxCfgPV9cnU6S6oFSBnhhkBmyHsKmykbH4D6xhKmawU/xjssZbvUQZ
         DYjYePp+FOgB9LzxcPkOX+S2T5+hvpnsC8uEhBxnQqKxmoTwsFWlh8DorYhm5oAYp1
         Zu8pjNWxIgrTBRi6iFx+KdBZNeCA/H+OIhhHpYJd3CdvcjFfvkg3Y3pWG7ifuxqc/H
         hTGwl1ogxbU0kG3GWsWO3A3QVr2Hlt1CTo/NIYA/wN3u0gCKrqGFTyAt3Q2lmkYKbK
         q4Vs6Mzk5Ohh2GgHlXJNaoYuUCRXzfXa2htC68dmXi+e6dn4fwP8IdC7wy2cfxlMuQ
         pfjL5takaHBKw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/5] nfsd: clean up refcounting in the filecache
Date:   Tue,  1 Nov 2022 10:46:42 -0400
Message-Id: <20221101144647.136696-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v5:
- drop the SYNC_NONE flush on addition to the LRU
- schedule the laundrette when adding to the LRU
- base laundrette scheduling on having work to do
- fix potential race in NFSD_FILE_LRU handling
- drop comments that mention NFS version

A number of changes in this set, mostly around the LRU handling. I've
done some light testing with it this morning and it seems to be OK.

Jeff Layton (5):
  nfsd: remove the pages_flushed statistic from filecache
  nfsd: reorganize filecache.c
  nfsd: rework refcounting in filecache
  nfsd: close race between unhashing and LRU addition
  nfsd: fix up the filecache laundrette scheduling

 fs/nfsd/filecache.c | 397 ++++++++++++++++++++++----------------------
 fs/nfsd/filecache.h |   1 +
 fs/nfsd/trace.h     |   5 +-
 3 files changed, 207 insertions(+), 196 deletions(-)

-- 
2.38.1

