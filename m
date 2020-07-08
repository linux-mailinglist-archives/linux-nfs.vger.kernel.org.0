Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977BC21913A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGHUKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569FC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k18so42837313qke.4
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8qVYYlFBeJxyLzIZ00Im2soi51imaOTOTyQLtdfKQo4=;
        b=NboBGGRQi/SERZR7woaTTNHDQm5Vhdglaj/jzqUeF3cBjIME1Fg5Ey7UmWjLGPDJg8
         GG0HKVByVMuyDMRd7huO+OqwlaU9zdHPaG1L0YZp8pGz3wqJ4GPPYy4S/MaDMwPkbJwh
         gHTbdPxGQ9n80H5DmH55+WZmI3QyAhaRhQqgrUaDBUqVSlNrhJuFiZvoryY79QWwS41H
         wagp9QLcJcUszSP322zrYAiBgOAY7D2Fh3bsmFiTUPjGPL+voX6meGCY7H082l/0B7L5
         RotAq50e6zo2fWZ1MPKs6I8U13cH7xNOf/mOMjjX1yEYB5tiAmXmyJmjgcHaEg2+74k2
         TExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=8qVYYlFBeJxyLzIZ00Im2soi51imaOTOTyQLtdfKQo4=;
        b=J3U3RMKMYO1w+tTDC0bNg6UmWoVA4Ug1MOxHTHgozV9DxUosWtmZLdw60IWhe8FWGS
         GnkDj5F4LasJhC9tTzBnnV1GS4hn79itL161TY04/P4boJ535DpZ23w38yNUcd+aCSee
         HEz3vSVujW84m7z3pt9Z9mIpVdUTkVqzLCQw6bPSgmVNknHkOeBMR0EEk5rcFlIDubSb
         DyjbJbyW3/i4NRP7aNZ/TbEafwwtclQvP7Bh1gl6JI+WdT5XBYzb6KC1D7nimbeNg/Di
         HrtXttnVZeUAOF5a84T/1vAVMkSXunR/tO7eevsAcjrgbR+RGpmiA4poJtxZjIJDBLlX
         MmIA==
X-Gm-Message-State: AOAM5318iVVDGtl6zGzQX8vbUYJ6t1GhsoANGSmW96eWFq4uFdzRLTCu
        64DqUfQxs38UAfi3E4VKY7+QJhRt
X-Google-Smtp-Source: ABdhPJx+Qm+ZEJR4lnebt2BV9FmtXPO6XN8rjlwqVQMqHi/RePsyt8iPWepCc3zmn01Se3eqDHR5Lg==
X-Received: by 2002:a05:620a:120b:: with SMTP id u11mr57550454qkj.243.1594239036638;
        Wed, 08 Jul 2020 13:10:36 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p66sm836265qkf.58.2020.07.08.13.10.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:36 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAZLo006127
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:35 GMT
Subject: [PATCH v1 18/22] SUNRPC: Remove more dprintks in rpcb_clnt.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:35 -0400
Message-ID: <20200708201035.22129.6662.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: These are superfluous now that rpc_create() and friends
have tracepoints to report errors.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/rpcb_clnt.c |   25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 6df12a13edc6..af2882c62a3b 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -218,10 +218,6 @@ static void rpcb_set_local(struct net *net, struct rpc_clnt *clnt,
 	sn->rpcb_is_af_local = is_af_local ? 1 : 0;
 	smp_wmb();
 	sn->rpcb_users = 1;
-	dprintk("RPC:       created new rpcb local clients (rpcb_local_clnt: "
-		"%p, rpcb_local_clnt4: %p) for net %x%s\n",
-		sn->rpcb_local_clnt, sn->rpcb_local_clnt4,
-		net->ns.inum, (net == &init_net) ? " (init_net)" : "");
 }
 
 /*
@@ -263,19 +259,13 @@ static int rpcb_create_local_unix(struct net *net)
 	 */
 	clnt = rpc_create(&args);
 	if (IS_ERR(clnt)) {
-		dprintk("RPC:       failed to create AF_LOCAL rpcbind "
-				"client (errno %ld).\n", PTR_ERR(clnt));
 		result = PTR_ERR(clnt);
 		goto out;
 	}
 
 	clnt4 = rpc_bind_new_program(clnt, &rpcb_program, RPCBVERS_4);
-	if (IS_ERR(clnt4)) {
-		dprintk("RPC:       failed to bind second program to "
-				"rpcbind v4 client (errno %ld).\n",
-				PTR_ERR(clnt4));
+	if (IS_ERR(clnt4))
 		clnt4 = NULL;
-	}
 
 	rpcb_set_local(net, clnt, clnt4, true);
 
@@ -311,8 +301,6 @@ static int rpcb_create_local_net(struct net *net)
 
 	clnt = rpc_create(&args);
 	if (IS_ERR(clnt)) {
-		dprintk("RPC:       failed to create local rpcbind "
-				"client (errno %ld).\n", PTR_ERR(clnt));
 		result = PTR_ERR(clnt);
 		goto out;
 	}
@@ -323,12 +311,8 @@ static int rpcb_create_local_net(struct net *net)
 	 * v4 upcalls.
 	 */
 	clnt4 = rpc_bind_new_program(clnt, &rpcb_program, RPCBVERS_4);
-	if (IS_ERR(clnt4)) {
-		dprintk("RPC:       failed to bind second program to "
-				"rpcbind v4 client (errno %ld).\n",
-				PTR_ERR(clnt4));
+	if (IS_ERR(clnt4))
 		clnt4 = NULL;
-	}
 
 	rpcb_set_local(net, clnt, clnt4, false);
 
@@ -405,11 +389,8 @@ static int rpcb_register_call(struct sunrpc_net *sn, struct rpc_clnt *clnt, stru
 	msg->rpc_resp = &result;
 
 	error = rpc_call_sync(clnt, msg, flags);
-	if (error < 0) {
-		dprintk("RPC:       failed to contact local rpcbind "
-				"server (errno %d).\n", -error);
+	if (error < 0)
 		return error;
-	}
 
 	if (!result)
 		return -EACCES;

