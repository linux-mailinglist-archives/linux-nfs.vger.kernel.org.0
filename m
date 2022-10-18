Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06605602A86
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJRLsC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJRLsB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 07:48:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCADABBE0A
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 04:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 701E2B81EB4
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 11:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6C3C433C1;
        Tue, 18 Oct 2022 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666093678;
        bh=UvfGPbx2hET3D1g957WLKOOq3TrmkCzkMEUSNI6O+6E=;
        h=From:To:Cc:Subject:Date:From;
        b=S3onbXBhis+NsTc7DJUtX4+Sn4Z2Wtx9SxGbYt6beOjaOfU4aOZyJB9qEWxzu0Whe
         aO+JbrCzFvdSaLHAWcnCTNre1pBLLQVjCC3VFQ64LmbsYAQSzWt7KNLJSWQG4PuJpB
         pE5f0ms+Vb/bGXqhe4noT33m6WhfM0cgoil4+jPc0Ju2glr16cZ7GCd2DVRZLO+mvh
         nisRpz67sJ65y/cE4OqLLvaxpXZPbpfc0S9Ebbu0OUhiRgyiS9oAO5ZXIagM0bwXOD
         elhRG2oKnRxmEufSR6tRnBy8OBSsfKf0tsXuIZ/RGV2tdDeh5b2xLW7GxV1O1FhWHG
         3nJuqQBesbhng==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     tom@talpey.com, linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/3] nfsd: ignore requests to disable unsupported versions
Date:   Tue, 18 Oct 2022 07:47:54 -0400
Message-Id: <20221018114756.23679-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The kernel currently errors out if you attempt to enable or disable a
version that it doesn't recognize. Change it to ignore attempts to
disable an unrecognized version. If we don't support it, then there is
no harm in doing so.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dc74a947a440..68ed42fd29fc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -601,7 +601,9 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 				}
 				break;
 			default:
-				return -EINVAL;
+				/* Ignore requests to disable non-existent versions */
+				if (cmd == NFSD_SET)
+					return -EINVAL;
 			}
 			vers += len + 1;
 		} while ((len = qword_get(&mesg, vers, size)) > 0);
-- 
2.37.3

