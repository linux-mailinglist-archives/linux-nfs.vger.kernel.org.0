Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B3297183
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Oct 2020 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750705AbgJWOlK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750667AbgJWOlJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 10:41:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7AC0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 07:41:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h19so1086717qtq.4
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Yw+3IPC0lkMjGS75J0+SsaeBsAG9hHM3LgU8NtHR4S0=;
        b=pExa8eLPgxYi1i6AB580YF9YSVtUnPUlZGtrSrvQBa1CERUufRNd0pyZio616EHVBE
         QfGyY8xKGoG2rezYDq209GfLTI/qjaxOPmLfs94vBo+aDew0GcWu/zs+KtZeAmmcgknl
         7wjKeIsqDlIwVW2Do0bUo2r3WMrOFWpocrVgD5/pNCed6l5q6LWImGynfn+NOthYe8Fs
         N73DxozQObi0PdtM8Dqa7hfyKmT2gX6ymW5P291AnJ9UUcpMS0y3i/Cool8OfodVY05+
         IkNolNeMky9yQL1FoCjNXOhmjzEDbgrE9/H/C4IQ/s69CZDlFEq3i80rx4qxwO+ooXod
         2t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Yw+3IPC0lkMjGS75J0+SsaeBsAG9hHM3LgU8NtHR4S0=;
        b=gBd+7+54uDOFHXd5zUvrAq1F//d0M7xT9GiJ8yqmmIQ65JskVLFgyEv+N/LBnkQVbz
         0Pvv9ruCEbjoXH6TE/MnqgEu9QtWgcUj3iMv08fkm/d0a33KEPRALU9xqgWd6+8KTcE3
         Lc9G2PVVHg0OG42zDpFQ1ngpvERJuU8AjRBtfXZXV58/sjSSx95sZiuw7fYpPPRhw8Aa
         TLjYPAgmHMgbbb27XN6BwmTup4qvL8gskph43uYT/DwrvCTRArzhI/3UzczkEhI5P0Fm
         u3YhE5ofujLEVcTztEi7MNp1ZgeOHDeiTH6O0gqnN4tV5Y6d0zBo0IbDX5LzkolD92O1
         15zA==
X-Gm-Message-State: AOAM532NxtmzviDeZT1ckBabyXaNdtxJOYZ9M8EWPpXJ5pX730srgDhE
        nrakyeohnJ52GLtJyzAC55U=
X-Google-Smtp-Source: ABdhPJwhdz5dCC4+t5nyvt1a08viNxGGEdvBqbVPqZrttbwN7jBRR4MVM/+ifukfvF/O8/FJOUwsuw==
X-Received: by 2002:ac8:703:: with SMTP id g3mr2441380qth.319.1603464068942;
        Fri, 23 Oct 2020 07:41:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m4sm803636qkh.131.2020.10.23.07.41.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 07:41:08 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09NEf7WN004143;
        Fri, 23 Oct 2020 14:41:07 GMT
Subject: [PATCH] SUNRPC: Fix general protection fault in
 trace_rpc_xdr_overflow()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Oct 2020 10:41:07 -0400
Message-ID: <160346406748.79082.3077185849414818247.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The TP_fast_assign() section is careful enough not to dereference
xdr->rqst if it's NULL. The TP_STRUCT__entry section is not.

Fixes: 5582863f450c ("SUNRPC: Add XDR overflow trace event")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f45b3c01370c..2477014e3fa6 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -655,10 +655,10 @@ TRACE_EVENT(rpc_xdr_overflow,
 		__field(size_t, tail_len)
 		__field(unsigned int, page_len)
 		__field(unsigned int, len)
-		__string(progname,
-			 xdr->rqst->rq_task->tk_client->cl_program->name)
-		__string(procedure,
-			 xdr->rqst->rq_task->tk_msg.rpc_proc->p_name)
+		__string(progname, xdr->rqst ?
+			 xdr->rqst->rq_task->tk_client->cl_program->name : "unknown")
+		__string(procedure, xdr->rqst ?
+			 xdr->rqst->rq_task->tk_msg.rpc_proc->p_name : "unknown")
 	),
 
 	TP_fast_assign(


