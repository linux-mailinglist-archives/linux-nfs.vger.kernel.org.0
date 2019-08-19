Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDD694E1A
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHST3G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:29:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37280 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfHST3G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 15:29:06 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so6852799iog.4
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EkaWZAwVF5PrNhAcdD0GA1eb9taUgFuiwCCExhi/vg=;
        b=WSbl9cN0DLPaAnCRn0sRrxP+8jOD08LExFQxl02NNjcNbGwqvCfU9miybeUBUaYiN1
         Fg0c+fH7DNmcV3YY2Sq/7pid3OlMiKDzDcF8UPHWo2deuKrQKN2JJ5hZyciFu/lcOKmE
         9Oxxblnx5cAkszYgc4smV+PGvSC8HYaHp3Twe+wvyD+3vFzsTn4qAX2XMzbSl54ci3Cs
         wev5i1HHL7TpSqIbDm0Oiqw8D7Jcg4XNB1GAXNplWIEoI6lXowP8Fri8HQY2Cki+2ppQ
         tVto1HtrZv3LlIrpJDe1CQ61HmYhwkcey8ONn0aTv6FTE2Wco9rU41gW26he+JMeRXK5
         pYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4EkaWZAwVF5PrNhAcdD0GA1eb9taUgFuiwCCExhi/vg=;
        b=I7do0W2tPHfRj8YbB9R6QA2vqrpaxptYxgExf7RXiIhp56eLQ9nJ6P/aO3mQSaU7pB
         UoWuRc/STY+VOZ1ViYP+0iQW1rZAPvFHisxFySlY6ab8Uodbn+m5O2z3OmV8JGgdapRJ
         B3WiNd1Bb7wZ4xzu2JXu70J5oCZk8RG44LHoyJwqOVodNVIO8InJohrxdU/a8HOmoYlf
         OB1HsT1XfNMsZlHXpyikU0vZMGW486lce6460/jirydqeYDn50unDMHZuXG85SNrHTMV
         S1gHijgoxnEBNLeMlVd2Keiq06SibricMAZSSgdJENDpYihnGqapLXLYmAlhKQ877DAl
         aWVw==
X-Gm-Message-State: APjAAAVjgl8qvpcF9WDgJUQw8z7Ez71L/FHriE5HZSsPPUAAYHPbh0Cy
        O4yRhEHzPFQQl3vhCPusUKaak1nlxAc=
X-Google-Smtp-Source: APXvYqwBGKS0W++PC3tS7k28+l1frGBafgy1yxZHy9EAc2ttbuiCbVBdEh/286vd3uvciMY+XQ0Hiw==
X-Received: by 2002:a05:6602:2193:: with SMTP id b19mr7070170iob.113.1566242945806;
        Mon, 19 Aug 2019 12:29:05 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id v23sm16243957ioh.58.2019.08.19.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:29:05 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call nfs4_call_sync_custom()
Date:   Mon, 19 Aug 2019 15:28:58 -0400
Message-Id: <20190819192900.19312-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

An async call followed by an rpc_wait_for_completion() is basically the
same as a synchronous call, so we can use nfs4_call_sync_custom() to
keep our custom callback ops and the RPC_TASK_NO_ROUND_ROBIN flag.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index de2b3fd806ef..1b7863ec12d3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8857,7 +8857,6 @@ static int nfs41_proc_reclaim_complete(struct nfs_client *clp,
 		const struct cred *cred)
 {
 	struct nfs4_reclaim_complete_data *calldata;
-	struct rpc_task *task;
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_RECLAIM_COMPLETE],
 		.rpc_cred = cred,
@@ -8866,7 +8865,7 @@ static int nfs41_proc_reclaim_complete(struct nfs_client *clp,
 		.rpc_client = clp->cl_rpcclient,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_reclaim_complete_call_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_NO_ROUND_ROBIN,
+		.flags = RPC_TASK_NO_ROUND_ROBIN,
 	};
 	int status = -ENOMEM;
 
@@ -8881,15 +8880,7 @@ static int nfs41_proc_reclaim_complete(struct nfs_client *clp,
 	msg.rpc_argp = &calldata->arg;
 	msg.rpc_resp = &calldata->res;
 	task_setup_data.callback_data = calldata;
-	task = rpc_run_task(&task_setup_data);
-	if (IS_ERR(task)) {
-		status = PTR_ERR(task);
-		goto out;
-	}
-	status = rpc_wait_for_completion_task(task);
-	if (status == 0)
-		status = task->tk_status;
-	rpc_put_task(task);
+	status = nfs4_call_sync_custom(&task_setup_data);
 out:
 	dprintk("<-- %s status=%d\n", __func__, status);
 	return status;
-- 
2.22.1

