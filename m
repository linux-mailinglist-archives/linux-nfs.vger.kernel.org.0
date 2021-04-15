Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8923608B4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDOMB0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 08:01:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:47234 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhDOMBZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Apr 2021 08:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Gp9JuVm8PIoFZwWEqiMuEESmrpY5DjH1d6RzJ7tHnuw=; b=yfS14VJD2e4iD2dWeme
        hEhiBL3EfKpSNH3uSMGrk8pS8UVt3gPixNMKB7k9rT5EePnHnPq5u9cvNzu/wIIkpEnMvH/iq7/nt
        DP9cRWcOyjSZXZ+uYGp9TQS4X+OSEY181tUK9j0lvStWf4NJInTfD9lX+WmE4vLLElb81+OvrJo=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lX0g7-000lqg-Ps; Thu, 15 Apr 2021 15:00:59 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfsd: removed unused argument in nfsd_startup_generic()
To:     "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Message-ID: <b77da875-4a01-3f88-ef65-26ce2394becc@virtuozzo.com>
Date:   Thu, 15 Apr 2021 15:00:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 501cb1849f86 ("nfsd: rip out the raparms cache")
nrservs is not used in nfsd_startup_generic()

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/nfsd/nfssvc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6de4063..1669f5b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -308,7 +308,7 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 
 static int nfsd_users = 0;
 
-static int nfsd_startup_generic(int nrservs)
+static int nfsd_startup_generic(void)
 {
 	int ret;
 
@@ -374,7 +374,7 @@ void nfsd_reset_boot_verifier(struct nfsd_net *nn)
 	write_sequnlock(&nn->boot_lock);
 }
 
-static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cred)
+static int nfsd_startup_net(struct net *net, const struct cred *cred)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int ret;
@@ -382,7 +382,7 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
 	if (nn->nfsd_net_up)
 		return 0;
 
-	ret = nfsd_startup_generic(nrservs);
+	ret = nfsd_startup_generic();
 	if (ret)
 		return ret;
 	ret = nfsd_init_socks(net, cred);
@@ -758,7 +758,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
 	nfsd_up_before = nn->nfsd_net_up;
 
-	error = nfsd_startup_net(nrservs, net, cred);
+	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_destroy;
 	error = nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
-- 
1.8.3.1

