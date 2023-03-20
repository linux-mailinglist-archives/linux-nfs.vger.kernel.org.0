Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095BA6C1EB0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCTR6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCTR5p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 13:57:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE171969E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 10:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D42DACE1268
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 17:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AA0C433D2;
        Mon, 20 Mar 2023 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679334646;
        bh=a7A6ChUAiW0Nevds7YdHkL2VS/S4ClxAk5l5ntEIj3A=;
        h=From:To:Cc:Subject:Date:From;
        b=jCtCvv6NRzstJNAVpjVjS3ZV17s4Kd1oqFnDLhdGRjWmU4v7mSJsjwa5PHQTIdrzU
         wH5Wrc8YQpOYidoyd4vHq5vY4qmJoCItTG2XEHj9PAXzIhbKdMqMK5IQphlafcyAlC
         fcERPTuZC074Qqiu/SsvQ/uO9B+F7mDfuIl0CxwhUM1zNLESwSRng1QeGxxndjX+Nf
         HWc5Mu36x32UCmmxy2DRXyaQNeHs/s3pbXgw7HTgYA9p4Zh3eD2I1xjhVJb4+feq7/
         YVibRP13d5iNjYJebCfV7brPGeSPU2gI+Ei+1xPzEcpm6giTxt2a6UAo0+X2jIhl48
         HAIVrL//Ylgdg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please pull NFS Client Bugfixes for Linux 6.3-rc
Date:   Mon, 20 Mar 2023 13:50:44 -0400
Message-Id: <20230320175044.173626-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-2

for you to fetch changes up to 21fd9e8700de86d1169f6336e97d7a74916ed04a:

  NFS: Correct timing for assigning access cache timestamp (2023-03-14 15:19:44 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.3-rc

Bugfixes:
  * Fix /proc/PID/io read_bytes accounting
  * Fix setting NLM file_lock start and end during decoding testargs
  * Fix timing for setting access cache timestamps

Thanks,
Anna

----------------------------------------------------------------
Chengen Du (1):
      NFS: Correct timing for assigning access cache timestamp

Dave Wysochanski (1):
      NFS: Fix /proc/PID/io read_bytes for buffered reads

Jeff Layton (1):
      lockd: set file_lock start and end when decoding nlm4 testargs

 fs/lockd/clnt4xdr.c        |  9 +--------
 fs/lockd/xdr4.c            | 13 ++++++++++++-
 fs/nfs/dir.c               |  2 +-
 fs/nfs/read.c              |  3 +++
 include/linux/lockd/xdr4.h |  1 +
 5 files changed, 18 insertions(+), 10 deletions(-)
