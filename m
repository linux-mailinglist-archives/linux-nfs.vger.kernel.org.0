Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE21D007A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgELVOD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVOD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:14:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64875C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:14:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y42so8983538qth.0
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tHMClt2lNks8fe+jPuekTnqQQE90XD5n3R7IZbP7wmk=;
        b=PWUWe63Ed3SPulNxF4DJ/qoRcdcUTKrKBfLgjl5C+OVEpamlmne36NmKS4Ex9aHFSf
         rcshehBI4PcdIc4VK+Jex9zBpDpvLaJECa2dfwwOn7FVgUeBJIxxBA5WRUMjmg7gTTwH
         eW8MbNERg8w1RtquJMTJOtpe7veAP7K7NuNZf0UHHSGsbJiUIQgwk90KYcwEZQWLaDmM
         KX/0VdsVZQu619I+LbjbtkqpOYuJu2SDJQRNpMd2gADDxbD8FT921fvs9nq/i3iC0hKx
         gSKH6E8WFY2GlZ70EmUhOBOtEWJUalcBkmR03GSO2yngRwD4cfyeB1Xt49horKa/RbCm
         ufRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tHMClt2lNks8fe+jPuekTnqQQE90XD5n3R7IZbP7wmk=;
        b=XOV/cve39eOqIPLmUYOk3CAoOo6KyVuYxb6ZjD+dqmbHA8cqactrkKYZuIKJ0l2v/p
         LKZgrLsami34gisdKDXKy1KmcJMUo+BUPrX87Rz/8n9kiVeJmOaFag4lssNN0X9wLQ6X
         ZHbMkF/y/lgztisS7tVqXMxpF8Mx3iTjpMTiy2FEevLDi6x1lU0ZxY4Hs74oTqhEBVt4
         Vswi+y41jLHZ3WMntaDkcvBw6pMIAFaK5zf3O+5i4N0m3oHpmEh/5kp2050N5LX8OtaP
         0CKqgOlYnv/7CZpELwnoVhEoA4s0pz18CDT94VicIn/V9glGIHuBPle4lhMn6EyuHb5J
         kdDA==
X-Gm-Message-State: AGi0Pub5xKHpPcDDgU6bPJST0+gbzugu3zqEnaqVM1ZV5OW8lksfTmy5
        YLH/XvgKQEyqv0jl+VQ52FI=
X-Google-Smtp-Source: APiQypKcAPLWFS/j58a7rYxcR1I5abuH+mW4nI0tT2BeN3Sqf6yvDDXUEVGqdB/cD4TVHUEpsNvxeA==
X-Received: by 2002:ac8:70c:: with SMTP id g12mr23353700qth.71.1589318042671;
        Tue, 12 May 2020 14:14:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i82sm12190642qke.134.2020.05.12.14.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:14:01 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLE0l9009823;
        Tue, 12 May 2020 21:14:00 GMT
Subject: [PATCH v1 13/15] NFS: nfs_xdr_status should record the procedure
 name
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:14:00 -0400
Message-ID: <20200512211400.3288.51893.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When sunrpc trace points are not enabled, the recorded task ID
information alone is not helpful.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 7e7a97ae21ed..e90651431804 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1312,7 +1312,12 @@
 			__field(unsigned int, task_id)
 			__field(unsigned int, client_id)
 			__field(u32, xid)
+			__field(int, version)
 			__field(unsigned long, error)
+			__string(program,
+				 xdr->rqst->rq_task->tk_client->cl_program->name)
+			__string(procedure,
+				 xdr->rqst->rq_task->tk_msg.rpc_proc->p_name)
 		),
 
 		TP_fast_assign(
@@ -1322,13 +1327,19 @@
 			__entry->task_id = task->tk_pid;
 			__entry->client_id = task->tk_client->cl_clid;
 			__entry->xid = be32_to_cpu(rqstp->rq_xid);
+			__entry->version = task->tk_client->cl_vers;
 			__entry->error = error;
+			__assign_str(program,
+				     task->tk_client->cl_program->name)
+			__assign_str(procedure, task->tk_msg.rpc_proc->p_name)
 		),
 
 		TP_printk(
-			"task:%u@%d xid=0x%08x error=%ld (%s)",
+			"task:%u@%d xid=0x%08x %sv%d %s error=%ld (%s)",
 			__entry->task_id, __entry->client_id, __entry->xid,
-			-__entry->error, nfs_show_status(__entry->error)
+			__get_str(program), __entry->version,
+			__get_str(procedure), -__entry->error,
+			nfs_show_status(__entry->error)
 		)
 );
 

