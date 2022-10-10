Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2F5F97FE
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 07:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJJF7U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJJF7T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 01:59:19 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0E51A1E
        for <linux-nfs@vger.kernel.org>; Sun,  9 Oct 2022 22:59:17 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29A5xF3D007648;
        Mon, 10 Oct 2022 14:59:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Mon, 10 Oct 2022 14:59:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29A5x5qW007628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 14:59:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <66b0ff35-c468-1a5b-3327-7e2ffcc768ee@I-love.SAKURA.ne.jp>
Date:   Mon, 10 Oct 2022 14:59:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: [PATCH] NFSD: unregister shrinker when nfsd_init_net() fails
Content-Language: en-US
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
References: <0000000000008c976e05ea9f491d@google.com>
Cc:     syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000008c976e05ea9f491d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

syzbot is reporting UAF read at register_shrinker_prepared() [1], for
commit 7746b32f467b3813 ("NFSD: add shrinker to reap courtesy clients on
low memory condition") missed that nfsd4_leases_net_shutdown() from
nfsd_exit_net() is called only when nfsd_init_net() succeeded.
If nfsd_init_net() fails due to nfsd_reply_cache_init() failure,
register_shrinker() from nfsd4_init_leases_net() has to be undone
before nfsd_init_net() returns.

Link: https://syzkaller.appspot.com/bug?extid=ff796f04613b4c84ad89 [1]
Reported-by: syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 7746b32f467b3813 ("NFSD: add shrinker to reap courtesy clients on low memory condition")
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6a29bcfc9390..dc74a947a440 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1458,12 +1458,14 @@ static __net_init int nfsd_init_net(struct net *net)
 		goto out_drc_error;
 	retval = nfsd_reply_cache_init(nn);
 	if (retval)
-		goto out_drc_error;
+		goto out_cache_error;
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
 	return 0;
 
+out_cache_error:
+	nfsd4_leases_net_shutdown(nn);
 out_drc_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
-- 
2.34.1


