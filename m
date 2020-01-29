Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC314CDF8
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgA2QJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:09:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39752 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:09:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so69079ywc.6
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sdEFzA4A97ct3iTWmgmgaA+i8kKdubjYfk10Cf5kSV0=;
        b=es7mGX9p8LvLNVkQUS9bjtomnkc6PD7yHe00ck0LcqJXcUqpABiCYYhiENZd3zdULZ
         afbo82ZGMM9ZIbqMe2rjpeUQz9aObhEr5E3w2bp5864YxEvfG11dQUT0UxN8ZrfF9w50
         RC7LUTyFP7SQ7yf2IJ33UXEiRB469JXvAoCyGiQGTjWCZeo3hHuyC9JmpY9s2dM3mxVM
         bl1+Aa0ocnaN2Vwu8yk+Dxe9yIpRP/5tgqC1e/fUHYNBBRbdnCywcaSXljx5df1SvuWw
         a7V58r5Ynswm6rcH/h2u5yXsHsbAaOVfZ6EyrbB/6cwj8z3jQqBJK+vSXg3XYB8kyUlc
         +qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sdEFzA4A97ct3iTWmgmgaA+i8kKdubjYfk10Cf5kSV0=;
        b=F82llu3dJoiRe7wvXiMbtssvW0QEh/o9M7bxloPVN/JAiFeHBNtpI0vSJlW4yFykcr
         V49GSYnFoJfgebCKQIzGbyUgJM+0fZqM//Obz2Xu8qeILcbojzCeySN7ZklRAbsBfLHB
         ZWeiZEO0VTYC43ZoHvXv9DMB3cp8OOp/pz+jdLw0MUNyHPITVj1pJYe+Dhy+2GXC+pjU
         8iU8RmyBTPOPs3dR9MUOkOQuMo8fBmcMDwOg1b39c2/wln6mP7BBXiUTkpXnErJMDx1F
         FWdkkICqehDz1o3gLF1UrTjacAvO7Oh8VfsMaewZ9x0kgKhsMAYv5b15zWX4IzQBb4T5
         9+7Q==
X-Gm-Message-State: APjAAAWono5x5MGiQyPs4NG1kzdUBMniF/gNX1/OW1ul579MDOLhJSgc
        /gVr0+IEDaUVGY8elLfXAGg=
X-Google-Smtp-Source: APXvYqzePXGgTLfTPTiEY24j8QSFxG/PBR+J4tUMa5xE6DfZEPev/YKr2IRyi4Q5mq11dxDNsh3UAg==
X-Received: by 2002:a0d:c3c2:: with SMTP id f185mr20013834ywd.21.1580314181153;
        Wed, 29 Jan 2020 08:09:41 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g190sm1090380ywd.85.2020.01.29.08.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:40 -0800 (PST)
Subject: [PATCH RFC 3/8] SUNRPC: TCP transport support for automated padding
 of xdr_buf::pages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:40 -0500
Message-ID: <20200129160939.3024.63670.stgit@bazille.1015granger.net>
In-Reply-To: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
References: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2934dd711715..966ea431f845 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -187,14 +187,12 @@ int svc_send_common(struct socket *sock, struct xdr_buf *xdr,
 	size_t		base = xdr->page_base;
 	unsigned int	pglen = xdr->page_len;
 	unsigned int	flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
-	int		slen;
+	int		slen = xdr_buf_msglen(xdr);
 	int		len = 0;
 
-	slen = xdr->len;
-
 	/* send head */
 	if (slen == xdr->head[0].iov_len)
-		flags = 0;
+		flags = MSG_EOR;
 	len = kernel_sendpage(sock, headpage, headoffset,
 				  xdr->head[0].iov_len, flags);
 	if (len != xdr->head[0].iov_len)
@@ -207,7 +205,7 @@ int svc_send_common(struct socket *sock, struct xdr_buf *xdr,
 	size = PAGE_SIZE - base < pglen ? PAGE_SIZE - base : pglen;
 	while (pglen > 0) {
 		if (slen == size)
-			flags = 0;
+			flags = MSG_EOR;
 		result = kernel_sendpage(sock, *ppage, base, size, flags);
 		if (result > 0)
 			len += result;
@@ -219,11 +217,21 @@ int svc_send_common(struct socket *sock, struct xdr_buf *xdr,
 		base = 0;
 		ppage++;
 	}
+	if (xdr->page_pad) {
+		if (!xdr->tail[0].iov_len)
+			flags = MSG_EOR;
+		result = kernel_sendpage(sock, ZERO_PAGE(0), 0,
+					 xdr->page_pad, flags);
+		if (result > 0)
+			len += result;
+		if (result != xdr->page_pad)
+			goto out;
+	}
 
 	/* send tail */
 	if (xdr->tail[0].iov_len) {
 		result = kernel_sendpage(sock, tailpage, tailoffset,
-				   xdr->tail[0].iov_len, 0);
+					 xdr->tail[0].iov_len, MSG_EOR);
 		if (result > 0)
 			len += result;
 	}
@@ -272,9 +280,9 @@ static int svc_sendto(struct svc_rqst *rqstp, struct xdr_buf *xdr)
 			       rqstp->rq_respages[0], tailoff);
 
 out:
-	dprintk("svc: socket %p sendto([%p %zu... ], %d) = %d (addr %s)\n",
+	dprintk("svc: socket %p sendto([%p %zu... ], %zu) = %d (addr %s)\n",
 		svsk, xdr->head[0].iov_base, xdr->head[0].iov_len,
-		xdr->len, len, svc_print_addr(rqstp, buf, sizeof(buf)));
+		xdr_buf_msglen(xdr), len, svc_print_addr(rqstp, buf, sizeof(buf)));
 
 	return len;
 }
@@ -1134,24 +1142,25 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 static int svc_tcp_sendto(struct svc_rqst *rqstp)
 {
 	struct xdr_buf	*xbufp = &rqstp->rq_res;
+	u32 reclen = xdr_buf_msglen(xbufp);
+	__be32 marker;
 	int sent;
-	__be32 reclen;
 
 	/* Set up the first element of the reply kvec.
 	 * Any other kvecs that may be in use have been taken
 	 * care of by the server implementation itself.
 	 */
-	reclen = htonl(0x80000000|((xbufp->len ) - 4));
-	memcpy(xbufp->head[0].iov_base, &reclen, 4);
+	marker = cpu_to_be32(0x80000000 | (reclen - sizeof(marker)));
+	memcpy(xbufp->head[0].iov_base, &marker, sizeof(marker));
 
 	sent = svc_sendto(rqstp, &rqstp->rq_res);
-	if (sent != xbufp->len) {
+	if (sent != reclen) {
 		printk(KERN_NOTICE
-		       "rpc-srv/tcp: %s: %s %d when sending %d bytes "
+		       "rpc-srv/tcp: %s: %s %d when sending %u bytes "
 		       "- shutting down socket\n",
 		       rqstp->rq_xprt->xpt_server->sv_name,
-		       (sent<0)?"got error":"sent only",
-		       sent, xbufp->len);
+		       (sent<0)?"got error":"sent",
+		       sent, reclen);
 		set_bit(XPT_CLOSE, &rqstp->rq_xprt->xpt_flags);
 		svc_xprt_enqueue(rqstp->rq_xprt);
 		sent = -EAGAIN;

