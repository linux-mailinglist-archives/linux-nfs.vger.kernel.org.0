Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780CC616CDD
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiKBSoy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiKBSox (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690F2D76A
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBA361B5F
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 18:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D41C433D6;
        Wed,  2 Nov 2022 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414692;
        bh=MunBeykM06DA0SwWiF1h+Du1EY+2gpZGH1or1w0/TyY=;
        h=From:To:Cc:Subject:Date:From;
        b=Usk/9LU4Drp0E0w5NNJxKDifOBvJMwZwZRutGT2Hw4d5KolTlT3CDaCWjb44AQQap
         cHun0L09aeEyZOW/CZfXQtbbMVLLxIpmD9+Mzx1KdZZ0iFTUVZ5fEpcqN41KTYo/gb
         RXw9jtF3YU46m9Sx+H65LZXPI03+BTxl6tD0rr0cBVLLOxjfk0RwXfmhF1VAuWFDjI
         qEkR11mn1dE7cnG0tkzt7c9tZNJ+esMfI4VETx2Q02ZsXtl3jbunvt+2NmrE/yU90+
         jGH43WqqAV4Ud4H5l9Vwl0o8LlmiH0m2+e1KYW6Vxdu9gsXjQPnumZ6REqFq8jbP/E
         9w8d5TtIT2eqw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v6 0/4] nfsd: clean up refcounting in the filecache
Date:   Wed,  2 Nov 2022 14:44:46 -0400
Message-Id: <20221102184450.130397-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v6:
- merge the LRU handling fixes into the refcount fixing patches
- call nfsd_file_close_inode from the notifier callbacks, which
  decrements and queues any objects to be freed by the disposal
  workqueue job

Only two main changes in this patchset. I folded two patches together
to avoid a problem that Chuck hit while testing. The other significant
change is to have the notifier callbacks use the disposal workqueue
job instead of freeing things themselves. Those don't need to be done
synchronously.

Jeff Layton (4):
  nfsd: remove the pages_flushed statistic from filecache
  nfsd: reorganize filecache.c
  nfsd: rework refcounting in filecache
  nfsd: fix up the filecache laundrette scheduling

 fs/nfsd/filecache.c | 406 +++++++++++++++++++++++---------------------
 fs/nfsd/filecache.h |   1 +
 fs/nfsd/trace.h     |  11 +-
 3 files changed, 222 insertions(+), 196 deletions(-)

-- 
2.38.1

