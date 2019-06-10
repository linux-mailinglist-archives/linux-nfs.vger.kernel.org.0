Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622CF3ACE0
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfFJCRM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jun 2019 22:17:12 -0400
Received: from m12-15.163.com ([220.181.12.15]:42115 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbfFJCRM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 9 Jun 2019 22:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=VtNxh
        qgNuhAXI6wf7or1jR1mdLlxPT12xbJh+4Ao0m8=; b=a+fz0lgy0D+3fhqCxAbLQ
        dTwhQzJHxeGPmLzoh2JJJWZ4pmSDEgoH9YHe4HZcVPmOukEZ/WGSHe9Anl+QcnPk
        jYOTMfDa9F+cNVmy7ycrMdAwwo7BGb1xmCupMVp3+VDiDoCgqhtP4QUihwcVC5gK
        4SpYljXk/FjeDjNj3hhO84=
Received: from tero-machine (unknown [124.16.85.90])
        by smtp11 (Coremail) with SMTP id D8CowABnZ2WYvf1catboAg--.21215S3;
        Mon, 10 Jun 2019 10:16:56 +0800 (CST)
Date:   Mon, 10 Jun 2019 10:16:56 +0800
From:   Lin Yi <teroincn@163.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, liujian6@iie.ac.cn, csong@cs.ucr.edu,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com, teroincn@163.com
Subject: [PATCH] net :sunrpc :clnt :Fix xps refcount imbalance on the error
 path
Message-ID: <20190610021655.GA14779@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: D8CowABnZ2WYvf1catboAg--.21215S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrAFykuw13uw1rJry7Ww17Jrb_yoWxGwc_Xw
        1xXrWxXw4DGanrtFZrAws5CrW7tr40kry8WrnFyrZrXw1UZ3Wjvr93W3Z3Gay7GrWxuasx
        Ar98G345Cw15tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1RpBDUUUUU==
X-Originating-IP: [124.16.85.90]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiLxLPElUMNRFJRwAAsT
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpc_clnt_add_xprt take a reference to struct rpc_xprt_switch, but forget
to release it before return, may lead to a memory leak.

Signed-off-by: Lin Yi <teroincn@163.com>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 627a87a..2b35347 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2805,6 +2805,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	xprt = xprt_iter_xprt(&clnt->cl_xpi);
 	if (xps == NULL || xprt == NULL) {
 		rcu_read_unlock();
+		xprt_switch_put(xps);
 		return -EAGAIN;
 	}
 	resvport = xprt->resvport;
-- 
1.9.1


