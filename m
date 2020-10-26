Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD1299610
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783054AbgJZSzV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46404 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782994AbgJZSzV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id a23so9385756qkg.13;
        Mon, 26 Oct 2020 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rXmy/SzKRHLADNcq+tGVZ5hWUR6cy6tHo3UYwHOKd5M=;
        b=d8MJ69HdcKc9XsQZBFxZEBDIBICKk94UtDCpam5vxfwDM58WJN4n+WyEsNenQvLHoy
         A+O7Ss8dWMQ9ILcs3kSEY8hmuaLKkOUzH+Y6mCZPXoj81KtvLGcVF80D1gPi0yyIKQ8S
         74vOUX6DQcgVbOA7s9hB2pgxD2HTDEOpROWDF7i0aogAlNY26iE+q8lL1FlqJBRwsGeF
         taKLZ6QLm8TAiObVZaIwwfB8jRxeiYSFGriUZVEx5ZHNt2rM71/Gl85aVhKa+lbeApF1
         CCwf+luc1PlKhqjV0rp+ddfXgNbAMLVDffQVmzNXtcqzjV7IOMoEqK1XN9zTVHzCP8Fw
         nstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=rXmy/SzKRHLADNcq+tGVZ5hWUR6cy6tHo3UYwHOKd5M=;
        b=WelJGD0Be5rFduUDmNTQrEDIrtJN9wTEcWYImtfh6YhCC/g160dWTSpAmlUdKxCIqJ
         uGK12x/NVVpKihZY0s6YlFCmpyHdyZOkUOm9/6UbfkRfsyaKx+WfL0uBq7RcbeJ2bIkH
         Bzte6CA2WjG7Kdn752hi1mJdaSJi7jaRCC6fpyWywLYPp0Ofm39smdkFQizvcHq7WrpZ
         +bSNj8Q6TcclDHM612JYL3NCB6HEsVhphRzXFL92P9rSFERU6HgFDeZOqp/2Hp6AGn36
         3ZDps0wjiJhm5GzzNG58UKcL5nUEAaMr7fNXXcnwfjqXfZtMs0Es2zUeK5TLudvVLfOL
         XWaw==
X-Gm-Message-State: AOAM532cm6CV7R3VYR+d0RoHqw4TPzwKUkMPmcpQPI/fOJQI/CulgJIb
        Gwg8hhZpzFz9WKJYhDcpJxSd9ZDL1K8=
X-Google-Smtp-Source: ABdhPJwypUtansVDE3Dc00839n7uL26V2I8zX7H3IyhfqCf33mGHZi+qe+vrX5++C6E4652rMjK22Q==
X-Received: by 2002:a37:4984:: with SMTP id w126mr17935036qka.104.1603738519629;
        Mon, 26 Oct 2020 11:55:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z26sm7008430qki.40.2020.10.26.11.55.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:18 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QItHkp013661;
        Mon, 26 Oct 2020 18:55:17 GMT
Subject: [PATCH 16/20] svcrdma: Remove chunk list pointers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:17 -0400
Message-ID: <160373851777.1886.8052540379115036293.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: These pointers are no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    4 ----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    8 +-------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 85fbec47d4b5..6f247d043731 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -149,12 +149,8 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_call_pcl;
 
 	struct svc_rdma_pcl	rc_read_pcl;
-
-	__be32			*rc_write_list;
 	struct svc_rdma_chunk	*rc_cur_result_payload;
 	struct svc_rdma_pcl	rc_write_pcl;
-
-	__be32			*rc_reply_chunk;
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index af32c3ad45a6..dd10b1de227d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -540,17 +540,13 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-
-	rctxt->rc_write_list = NULL;
 	if (!xdr_count_write_chunks(rctxt, p))
 		return false;
 	if (!pcl_alloc_write(rctxt, &rctxt->rc_write_pcl, p))
 		return false;
 
-	if (!pcl_is_empty(&rctxt->rc_write_pcl))
-		rctxt->rc_write_list = p;
 	rctxt->rc_cur_result_payload = pcl_first_chunk(&rctxt->rc_write_pcl);
-	return rctxt->rc_write_pcl.cl_count < 2;
+	return true;
 }
 
 /* Sanity check the Reply chunk.
@@ -573,13 +569,11 @@ static bool xdr_check_reply_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	if (!p)
 		return false;
 
-	rctxt->rc_reply_chunk = NULL;
 	if (!xdr_item_is_present(p))
 		return true;
 	if (!xdr_check_write_chunk(rctxt))
 		return false;
 
-	rctxt->rc_reply_chunk = p;
 	rctxt->rc_reply_pcl.cl_count = 1;
 	return pcl_alloc_write(rctxt, &rctxt->rc_reply_pcl, p);
 }


