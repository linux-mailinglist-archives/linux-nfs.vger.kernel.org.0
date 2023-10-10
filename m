Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05187C4423
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjJJWbb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 18:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjJJWba (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 18:31:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297591
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 15:31:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 477172183A;
        Tue, 10 Oct 2023 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696977088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7d90yGy6j1Z+zShNyhLn4RoSC5IpwnmxSENdTEDxVMk=;
        b=jiI9ufyoRtObBWanGuHeHlyrDWxixsg7kghGRZGpKh2BJcd408KzzuvO3DVpEDNs4yvXaV
        RBB1scIHZY9AwMNJpMCr5yBe26EXyNwHSBJ4wtKyZAt8mHvtJYmao3H3nGBexpVt+SMzT8
        Xs9OdREFzkwqXqXrqzmCYaWhZgQW2Dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696977088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7d90yGy6j1Z+zShNyhLn4RoSC5IpwnmxSENdTEDxVMk=;
        b=qupyHEtVR0VA4pwqX6sNtK0+aEjRJbTGyZpfwC5Dk/9arFsRzXCJIViGbRQ2M/wbco0XN0
        jR+fgFr3haiF+qAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A2D61358F;
        Tue, 10 Oct 2023 22:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 98miL73QJWV6MAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 Oct 2023 22:31:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH v2] lockd: hold a reference to nlmsvc_serv while stopping the thread.
Date:   Wed, 11 Oct 2023 09:31:22 +1100
Message-id: <169697708281.26263.8555620245361496067@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Both nfsd and nfsv4-callback take a temporary reference to the svc_serv
while calling svc_set_num_threads() to stop the last thread.  lockd does
not.

This extra reference prevents the scv_serv from being freed when the
last thread drops its reference count.  This not currently needed for
lockd as the svc_serv is not accessed after the last thread is told to
exit.

However a future patch will require svc_exit_thread() to access the
svc_serv after the svc_put() so it will need the code that calls
svc_set_num_threads() to keep a reference and keep the svc_serv active.

So copy the pattern from nfsd and nfsv4-cb to lockd, and take a
reference around svc_set_num_threads(.., 0)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 6579948070a4..365cc7adff66 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -373,7 +373,9 @@ static void lockd_put(void)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 
+	svc_get(nlmsvc_serv);
 	svc_set_num_threads(nlmsvc_serv, NULL, 0);
+	svc_put(nlmsvc_serv);
 	timer_delete_sync(&nlmsvc_retry);
 	nlmsvc_serv = NULL;
 	dprintk("lockd_down: service destroyed\n");
-- 
2.42.0

