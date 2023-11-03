Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FE7E0101
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347661AbjKCKLA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347559AbjKCKK7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 06:10:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4308D19D;
        Fri,  3 Nov 2023 03:10:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C65C433C7;
        Fri,  3 Nov 2023 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699006256;
        bh=lKYtwzrTfdA3Ak9OmlTg0WTnIsn4VIP2yekr4/oHDos=;
        h=From:Subject:Date:To:Cc:From;
        b=D6EoR3cq1biHVCTRhFpblGn2Wi4m07pVnvFU5r/iTbbIYsv25CBkrPRhKDbPRBXAF
         ffanLE/NdafL/19S7Kluc9gn1+7/mDeRVyxMqhLhLXTHKz9CHaOxiPNAkB/LQ2dsbP
         7DncWfx+5UJy+eDvq91EyoN92ZRKIGwdPv2d4E9RpEyH2bvm4OVgPk7NtaR/70DmUp
         NQFrasf2tdpMAVlZER2Jmwpt3slyulzHRJewRnYrURoiR9hoZrERGgWlLxhzaCg3S0
         XJFBW1H27Lk7iAVAr6ed8gujagVN6JKwYTL8omdoTg8ljhfUyV7+s6LTPjfjhMGb9g
         iQAacYOqMgThA==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfs: clean up some tracepoints in the lookup /
 revalidate codepaths
Date:   Fri, 03 Nov 2023 06:10:48 -0400
Message-Id: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjHRGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwMj3by0Yl0zXQtd80RLi1TjVBMLgxQjJaDqgqLUtMwKsEnRsbW1AM8
 tKdJZAAAA
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lKYtwzrTfdA3Ak9OmlTg0WTnIsn4VIP2yekr4/oHDos=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlRMcs/7ntg9tTYX/jzCwiKJBKP4xWRm3nmbA5R
 ZvoLuJpJjiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZUTHLAAKCRAADmhBGVaC
 FfuLD/9X7UrslLmnkSRLg3UMFWe+9CuHzn/wb32oLpVoIjQHNkEQAkeExcJDzpHjZE1dJtEtD/I
 Y8m6/OA7V4Jr3itScG3K4itLftkVp380cy6GRiKvkdfQj06den9EZ/nRV8BQeL3Ol16MScs5LbH
 hr7Swx0Gs8prmCl1N5pqffmL6vYH1UO8J1b+MXMq919oyfc/lE0rAJPIZ2XtJBFsRBn3G5UwO0p
 qmrc3kGtCYNL7XaW+KJ9KdUNX1Y9uKAXl8ekLM0a6pXiqszBE0spfoiACbBorMViu/dXDy/g66M
 eVQkfFGLXshOT9f+1kE6LQ8VEQPcxvn1pjBVPwwSXQ/GrJVhZ4XeOvYT9bMLh1Vguts9Lxzpl+o
 ajOVUGGuNj+eHZJh2+H8xFaqv88QIelSI8yMPq6d/3ggePrnen2zqKRSxn2RWzIgvquZT6uceH6
 b64pDI6dGusMUZfgibFD1FYhza4cBInTtfvqhTMA6+atPsijrlqAGH0v8+nAoMOdfYg93by6O2O
 mL2TU5gjghl2p1jK90WXe8jzF2PkmM0y4vvLvmoEP62usUDZPwQAKaAdEoMjgqg0Cn4MLtBIQEy
 w1VVoZpJ1+lnuQTEZH/U8Y4QLw/Ef2dl4hxZbZeNvvRng47Emz+9dugT5aEXEd5H+qdG6sBsAa1
 ZZ+8zqbBr0NjfLw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I was looking at a lookupcache issue the other day that turned out to be
a false alarm. While looking I needed to turn up some tracepoints, and
found some of the info to be lacking. These patches just do a little
cleanup to the nfs tracepoints, and flesh them out a bit.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfs: add new tracepoint at nfs4 revalidate entry point
      nfs: rename the nfs_async_rename_done tracepoint
      nfs: print fileid in lookup tracepoints

 fs/nfs/dir.c      |  2 ++
 fs/nfs/nfstrace.h | 16 +++++++++++-----
 fs/nfs/unlink.c   |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)
---
base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
change-id: 20231102-nfs-6-8-7a98e3e480d2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

