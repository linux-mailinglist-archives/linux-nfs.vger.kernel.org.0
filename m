Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7963739A8B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFVIr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jun 2023 04:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFVIrO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jun 2023 04:47:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782B0269F
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jun 2023 01:46:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACB732278B;
        Thu, 22 Jun 2023 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687423613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=J1TXXkFnQOTXBWHWQr71pNqDt+gA23LnV7lfAUEwHKQ=;
        b=1+af6DkFHTQ9tLkpZWaaRKdt29Jo9BIEJjom7OJXCRIQKg4TIiw9FZxSHvIG/L1UypxY/4
        pJJuqpJDa4QGRr4e8xoVTPDtZjPbEXULxzcz2M0S1uF5EnSxHdMY9NNJniWToJ5NMaYZxZ
        DXtpE6OkhM1yMfJZGHSdmkXcmMk9MsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687423613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=J1TXXkFnQOTXBWHWQr71pNqDt+gA23LnV7lfAUEwHKQ=;
        b=ewtV+aKUVyoMHKaIQGw7+KerxBTVOxNCtwryYFDnHzMhJuttFjX1FUCPqCxgEuQuz11FmK
        FUNmwDZXJWdMGcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A251132BE;
        Thu, 22 Jun 2023 08:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yRTdCH0KlGTBBwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 22 Jun 2023 08:46:53 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
Date:   Thu, 22 Jun 2023 10:46:48 +0200
Message-Id: <20230622084648.490498-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

UDP support disabled was on NFS server in kernel 5.6.
Due that 2 of 3 nfs06.sh tests runs are being skipped on newer kernels.

Therefore NFSv3 job in nfs02_06 test as TCP. This way all jobs in the
test are TCP, thus test will not be skipped. This also bring NFSv3
testing also under TCP (previously it was tested only on UDP).

Keep UDP in nfs01_06 jobs, so that NFSv3 on UDP is still covered for
older kernels.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.nfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 72cf4b307..15a960017 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -58,7 +58,7 @@ nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
 nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
 
 nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
-nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
+nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
 nfs3_07 nfs07.sh -v 3 -t udp
-- 
2.40.1

