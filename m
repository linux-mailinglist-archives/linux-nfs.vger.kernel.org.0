Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D56F7761
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEDUtG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEDUsf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972093CF
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7955A60DF7
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A67C433D2;
        Thu,  4 May 2023 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233233;
        bh=qvQu4LXgjVw2wB+VMbVv/WzNkwcOWUxkAWAR1sdzV0w=;
        h=From:Subject:Date:To:Cc:From;
        b=IV1pGmY8KQNWbCOWlDZggYTWSK6DnWjDbz3+wHRGr/S5X739nz9Iv1pjzUZXko5FY
         tUQMsfjw4EyjX7agaLByT0MPeCMD0FMIoc+RX4QVkKSO9JoLvIg20CUNsdKch2nrxX
         0D/5wF55w1EHMrx3gSbqOUnzzY3ZETAmaQRP2EWPnYQmW56hLbNGrBMX1mQBSOj7Hq
         DvENu1PWZt64N2s6XY08tqAoGMI5FgpYJhjhs1BYrLdnJ0uW+RHxVbWsnBDYP0QHpV
         Sz/Jt8uMI1XQL+99ZMlEcRNXWPJA2apIZGki/EMvoaE9a+0IvLNJrwywyvyTa36FtU
         Ob8jCHKjZTTEw==
From:   Anna Schumaker <anna@kernel.org>
Subject: [PATCH 0/6] NFSv4.2: Fix xattr ctime updates
Date:   Thu, 04 May 2023 16:47:10 -0400
Message-Id: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4ZVGQC/x2NQQrCMBAAv1L27EJM2lD9inhI4rZdqKtsogRK/
 27qcRiG2SCTMmW4dhsofTnzSxqcTx2kJchMyI/GYI11ZjA91lCKYir8JLTO+cvo49D7BK2IIRN
 GDZKWo1lZPhWFajnkW2ni+l/d7vv+Awvd6DF6AAAA
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=qvQu4LXgjVw2wB+VMbVv/WzNkwcOWUxkAWAR1sdzV0w=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnQWuoiL/MYCSHPy5RIA5XjKpWKtv59UrWMe
 yet3ozUuiOJAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0AAKCRDXy1S/sKVA
 6wxmD/0e+YZr0QHl3hgB2qzeyJQuqBzAI0mAekgm34WM85XLwbjQ0JMJ2c4PLnFYSYxHC8r2WKL
 lo3qzz7OfFeWfIyUw5dGJ6jo5lpiQO/t3CyxYm5gAuYqMWE0N42kpUsi8f8ZgqiIwoxugziQKqB
 gI0bc+X6hIoVQQPTmhiplyIff3ut4BEpLKEVHgbvi2Wz2sNzbTJu0nYHChCMTMDYyrZRnNeQQ3s
 KJvGBWyfYKGn2y2i707+k03tf5pV0YnyXniVbrr1ixuVCAKYzPrmTGBmzrBwy8iJq+gulWzsiwq
 UDq1a9MtCmILOqpzWeHCqRzhGAjBbx6if5LQdV7bE5MfsjEqLGcLNIerVJYbjCAnpLL7c++Xl3e
 Hz8whjO9e+mIGJvr5XGqIGME7XhRyDAIh3TpRfqcTs0hPml5M7kTJ0YOm3ZynXjOnffqBQSNOfz
 NefHe1o0txirTEnSALr4vV5y7LMLpnaVfEV6BJr/nXDTPiIoW6KDATnou45m5n5nmB40VMS1NQe
 zMnTokr8aEXud6pqY6ABXmKYId0jbzD9/ihy2eq/GEAhPjLD4Uxd5YNxEfFEGxY3+YYaohsmDhR
 T+uPTg6LBOEor8fEx9FDrHj8b6w41HhO9+MuEGPg5j9V/3+nqEkWDNxRnMoS3fY3y1JLWjUs92Y
 NsO3n6yiPcPe4sw==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The first few patches in this series are cleanups that reorganize the
code in the nfs42xdr.c file to match how the rest of the file is laid
out.

The last patch fixes a bug where we are failing to update ctime after a
SETXATTR operation. I also added nfs/002 to xfstests (submitted
separately) to test for this going forward.

Thanks,
Anna

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
Anna Schumaker (6):
      NFSv4.2: Clean up: Move the encode_copy_commit() function
      NFSv4.2: Clean up: move decode_*xattr() functions
      NFSv4.2: Clean up: Move nfs4_xdr_enc_*xattr() functions
      NFSv4.2: Clean up nfs4_xdr_dec_*xattr() functions
      NFSv4.2: Clean up xattr size macros
      NFSv4.2: SETXATTR should update ctime

 fs/nfs/nfs42proc.c      |  25 +-
 fs/nfs/nfs42xdr.c       | 621 +++++++++++++++++++++++++-----------------------
 include/linux/nfs_xdr.h |   3 +
 3 files changed, 346 insertions(+), 303 deletions(-)
---
base-commit: 4a60aee504c244ba5814b27c33c6250d98ac562f
change-id: 20230504-xattr-ctime-2336986b546c

Best regards,
-- 
Anna Schumaker <Anna.Schumaker@Netapp.com>

