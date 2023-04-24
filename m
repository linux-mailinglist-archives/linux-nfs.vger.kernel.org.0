Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629506ED68D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Apr 2023 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDXVIQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Apr 2023 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjDXVIP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Apr 2023 17:08:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEAD61A4
        for <linux-nfs@vger.kernel.org>; Mon, 24 Apr 2023 14:08:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD4471FD94;
        Mon, 24 Apr 2023 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682370492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iyzeLzCsMCdsmJwHyVbIHUwIBHNpy11fYoEtMxyvpk=;
        b=U4rmdr9cQT6ujltj2tGLrrVOw4jfXby9gVqC3Y/2kt2QWKiZyS7aSE3YO7ugrgT7sNrTHE
        AJHDhorMu0bFVoH7Qp5Y7PVKJAC8TTpjtv4JinVAPJpG8V3h42wNqrtUAiyjikjuaJm4O8
        jjgZTpK2tjAt8CVXjkKf4Qw2RbWahIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682370492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iyzeLzCsMCdsmJwHyVbIHUwIBHNpy11fYoEtMxyvpk=;
        b=1N8e7Zb00xKsGhfSvd7jIk0ZAjyMLFWhAKO8aDc7cXMQy76YH1AFXNkSK6W4z/O55LLTO5
        qcaJpgR6QzuyGjAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D0A61390E;
        Mon, 24 Apr 2023 21:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMLlELzvRmSzIAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 21:08:12 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org,
        Steve Dickson <steved@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Subject: [PATCH v3 2/3] nfs_lib.sh: Unexport on proper side on netns
Date:   Mon, 24 Apr 2023 23:08:17 +0200
Message-Id: <20230424210818.2885479-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424210818.2885479-1-pvorel@suse.cz>
References: <20230424210818.2885479-1-pvorel@suse.cz>
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

f6b267055 changed exportfs run locally on netns, therefore unexporting
should be also run at the same namespace. This is not problematic now,
but will be a problem with TST_ALL_FILESYSTEMS=1, which is sensitive for
timing.

Fixes: f6b267055 ("nfs_lib.sh: run exportfs at "server side" in LTP_NETNS case")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 1b5604ab5..042fea5e4 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -215,8 +215,16 @@ nfs_cleanup()
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		remote_dir="$(get_remote_dir $i $type)"
-		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
-		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+
+		if tst_net_use_netns; then
+			if test -d $remote_dir; then
+				exportfs -u *:$remote_dir
+				rm -rf $remote_dir
+			fi
+		else
+			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+		fi
 		n=$(( n + 1 ))
 	done
 }
-- 
2.40.0

