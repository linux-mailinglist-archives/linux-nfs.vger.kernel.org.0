Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB619DEA0
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgDCTmQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 15:42:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46641 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCTmQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 15:42:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id g7so7457828qtj.13
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+SeIklzdQavj+tOIcVKFI8xI/Bg24I/dQg2LBlcAVx4=;
        b=re07o8Gjq0SnPFDlSeOc7a85nGptttn28uY1vvd1HjmbYRwOaoiaImLIjX0Djp35Rm
         JrkVBpZ/acmZy2L4L8pqOvBfdBVVw32LfW0uPJtDwIyfWC71/zOfkvMc9oITbBVjIwyL
         b4A/DmPDo3d/Vw6+o5zEHqdTovahLR+SL/wQWlG7SMjXffQSzVsUw19afRgTNQOmkid5
         wNalcpXnYjbCssHXvduzcByY1S57BmG6Cyij8ph8ixRXruZgowREC/40rcgwJQO7/9Fk
         fkT3C0Mak7WSUZWX4KlentCbRd55c1L5+SUdbugG+u2rKZy8uj+xfHMgFbWwwYwh7WOZ
         IGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+SeIklzdQavj+tOIcVKFI8xI/Bg24I/dQg2LBlcAVx4=;
        b=aEwX3/CnO2oA0lk3rpzPs4c+whYFhp/PW7Nyncl41yubm4Vuur+GHyxAcfXUoCHNEN
         8cxGIYuA7kRhr7xXYmDFQGWwUJ+SbL5ma78OE3zmNJVOokQ/GqdKEo1kZNne0pRyws78
         QoQf2eZUyAgFDru3nMHx7yCdT6UPghiHrdeh9o5EsqfevRN2zZD6FgohD4ZtxGrNZ2PE
         zhDsbKD4CsVHAcSWk4PsOdj0UVmkBgSoNne4A1CSw43TfIcDS2u+fZ2UyPyMCrSNV4o1
         6VwR6R9B2gR+vKbzPseJsHZAngJNmIW6eXMzf9GUPCxpQY8rrj39O+VC6ztA6vdoIRuo
         DeQw==
X-Gm-Message-State: AGi0PubcZbmP6zt/xX2ulQlSOeFVfTCqw307ZBi/fNENnMeTvUB5JOlo
        0EP2mHkrsRCZvdaqXc54r+OH0h9g
X-Google-Smtp-Source: APiQypL19TNqkBT/NlZIJwfQrF5FInDtMu5b0X5GnuABpX2nxrMBN7MJEaowRQ0RM1cVbgVh7vdqNg==
X-Received: by 2002:aed:2341:: with SMTP id i1mr10227393qtc.34.1585942934690;
        Fri, 03 Apr 2020 12:42:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d201sm6956074qke.59.2020.04.03.12.42.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:42:14 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 033JgAk6029493
        for <linux-nfs@vger.kernel.org>; Fri, 3 Apr 2020 19:42:11 GMT
Subject: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the transport
 disconnects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Apr 2020 15:42:10 -0400
Message-ID: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-7-g1113
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 3832591e6fa5 ("SUNRPC: Handle connection issues correctly on
the back channel") intended to make backchannel RPCs fail
immediately when there is no forward channel connection. What's
currently happening is, when the forward channel conneciton goes
away, backchannel operations are causing hard loops because
call_transmit_status's SOFTCONN logic ignores ENOTCONN.

To avoid changing the behavior of call_transmit_status in the
forward direction, make backchannel RPCs return with a different
error than ENOTCONN when they fail.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   15 ++++++++++-----
 net/sunrpc/xprtsock.c                      |    6 ++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

I'm playing with this fix. It seems to be required in order to get
Kerberos mounts to work under load with NFSv4.1 and later on RDMA.

If there are no objections, I can carry this for v5.7-rc ...


diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index d510a3a15d4b..b8a72d7fbcc2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -207,11 +207,16 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 
 drop_connection:
 	dprintk("svcrdma: failed to send bc call\n");
-	return -ENOTCONN;
+	return -EHOSTUNREACH;
 }
 
-/* Send an RPC call on the passive end of a transport
- * connection.
+/**
+ * xprt_rdma_bc_send_request - send an RPC backchannel Call
+ * @rqst: RPC Call in rq_snd_buf
+ *
+ * Returns:
+ *	%0 if the RPC message has been sent
+ *	%-EHOSTUNREACH if the Call could not be sent
  */
 static int
 xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
@@ -225,11 +230,11 @@ xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
 
 	mutex_lock(&sxprt->xpt_mutex);
 
-	ret = -ENOTCONN;
+	ret = -EHOSTUNREACH;
 	rdma = container_of(sxprt, struct svcxprt_rdma, sc_xprt);
 	if (!test_bit(XPT_DEAD, &sxprt->xpt_flags)) {
 		ret = rpcrdma_bc_send_request(rdma, rqst);
-		if (ret == -ENOTCONN)
+		if (ret < 0)
 			svc_close_xprt(sxprt);
 	}
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 17cb902e5153..92a358fd2ff0 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2543,7 +2543,9 @@ static int bc_sendto(struct rpc_rqst *req)
 	req->rq_xtime = ktime_get();
 	err = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, marker, &sent);
 	xdr_free_bvec(xdr);
-	if (err < 0 || sent != (xdr->len + sizeof(marker)))
+	if (err < 0)
+		return -EHOSTUNREACH;
+	if (sent != (xdr->len + sizeof(marker)))
 		return -EAGAIN;
 	return sent;
 }
@@ -2567,7 +2569,7 @@ static int bc_send_request(struct rpc_rqst *req)
 	 */
 	mutex_lock(&xprt->xpt_mutex);
 	if (test_bit(XPT_DEAD, &xprt->xpt_flags))
-		len = -ENOTCONN;
+		len = -EHOSTUNREACH;
 	else
 		len = bc_sendto(req);
 	mutex_unlock(&xprt->xpt_mutex);

