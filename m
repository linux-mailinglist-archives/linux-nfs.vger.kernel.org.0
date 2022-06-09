Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BED5456A2
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jun 2022 23:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbiFIVmp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 17:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiFIVmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 17:42:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0BE66CA7
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 14:42:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 34F721FEAF;
        Thu,  9 Jun 2022 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654810953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lg3+kMHDoOC5AiOpaP8JlSQdjMtlWF34C+hOQNw/yTs=;
        b=mYYNKIv2knFYiXBNRNxk/3Y/td20GA8Osla77NcsBTUI25bQP9waUC3K3aR3f9OmkFLwK8
        L30a/2q/cFsWIEgNLVzEckDDkOblyzzyrq3w1hCTJcV9oLlp2Dl6mVFWTDisxCnaE38fOb
        h8yNlEcqxf//N4tG/SMC9PPGcGxqJl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654810953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lg3+kMHDoOC5AiOpaP8JlSQdjMtlWF34C+hOQNw/yTs=;
        b=PI66gB9W78PVwxe5X98odS0u6dC5sODVMk5ymzaaxTtaXXTTLv/1QRq19RtdOj3ozoWLIA
        7uLZieJEZMWZL2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3D2F13A8C;
        Thu,  9 Jun 2022 21:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SBDDOUhpomIQDgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:32 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/9] tst_device: Remove unnecessary braces
Date:   Thu,  9 Jun 2022 23:42:20 +0200
Message-Id: <20220609214223.4608-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609214223.4608-1-pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

to keep checkpatch.pl happy.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index 2a3ab1222..d6b74a5ff 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -40,11 +40,10 @@ static int acquire_device(int argc, char *argv[])
 		}
 	}
 
-	if (argc >= 4) {
+	if (argc >= 4)
 		device = tst_acquire_loop_device(size, argv[3]);
-	} else {
+	else
 		device = tst_acquire_device__(size);
-	}
 
 	if (!device)
 		return 1;
-- 
2.36.1

