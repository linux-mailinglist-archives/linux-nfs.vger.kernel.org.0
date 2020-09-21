Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E621B273193
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgIUSLU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgIUSLT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82875C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so1239312ilt.13
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nbMji9Jr8UAjnYXhxZ2mcTj1y0ZyQ51gRW4PH2vF5fU=;
        b=tNscOsA1AMfNPT6FG+Lkue1sWQn6itks0HXR/hGm4k7QI+zHhIVFzWLMo59Lf9zC/U
         fmwrhJIuvxPmfaAUgE/fm3tkSOeGsryFwQK9paegBuVwpHwwo4GVYUvAN45+XiCeIit4
         n3Nm2D3GYyiJ7muO8SMvGvCUrqYxbut/WC1/f+U/qOCW7ML2coJVQOat/iwbiU0NB4zp
         aAsPDnKLt6/usD4ub5r23esY19ahFxUX0KTXpZD2+Kz7N8kyZ57iDQ0T1lrAhORig6pQ
         LqrRfJSno81NQyLbG4t9B8qBKBotpSeTq7677twRgBZXGZZDSRtTRhCXlQ5a4c5VdbHY
         Bm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nbMji9Jr8UAjnYXhxZ2mcTj1y0ZyQ51gRW4PH2vF5fU=;
        b=o6kHnZO+I6vhQ3a7qgNXIBQpn0pnhdbBJVIfJA5afj3phUB1XNnQeHIawq53jh0Jhe
         3T0i+axDItGFcKDXue5DhhzdkrY8s1Cn306t+THNb++33piD1hSk2v1g4gu0XLPGiRDc
         EP5nv7TTqdxJnRc/31DL3Xxl5+ZvwZEWJG8QkLGBMSPuZ7DpfGjeiU75IjEA8aJwQu6b
         LCRj1NI/XQHhNHJov/NGEe/Q2TzeE+KTFeSze8N6dG3vnXG8F2Y8j2uW+6hnP8s1N1G5
         YVxKeCmcsvdzCmiN8atwDMCHCq4/jCtkWGdeMxmJ0YXOYBmRFl1uQ1oDnNvcHVe0tFwn
         hOTQ==
X-Gm-Message-State: AOAM5327oFnmqr19l+jn5bVlC8hRLR+SsFRvDL7arM1rLmEGaUWO9BTB
        mY6RtIMMYh7ggw0rKNbNs2zQZ+c8VnY=
X-Google-Smtp-Source: ABdhPJyOyZGR/Rlq2zl5VbLuZBU4Deg9cNNDtDfWm9JHLBYVBpVNyUT9+dRPa8x9aFBZy0AW3Nx2fg==
X-Received: by 2002:a92:9943:: with SMTP id p64mr1002513ili.295.1600711878950;
        Mon, 21 Sep 2020 11:11:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f11sm6331067ioj.27.2020.09.21.11.11.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:17 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBGbV003857;
        Mon, 21 Sep 2020 18:11:16 GMT
Subject: [PATCH v2 05/27] SUNRPC: Add svc_xdr_authenticate tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:16 -0400
Message-ID: <160071187634.1468.12114939901512937472.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable examination of the incoming RPC Call buffer _after_ it has
been unwrapped to help troubleshoot problems with the GSS unwrap
functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/svcauth.c          |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 6afd39572dcd..aac12f45bfb0 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1249,6 +1249,7 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 
 DEFINE_SVCXDRBUF_EVENT(recvfrom);
 DEFINE_SVCXDRBUF_EVENT(sendto);
+DEFINE_SVCXDRBUF_EVENT(authenticate);
 
 /*
  * from include/linux/sunrpc/svc.h
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 998b196b6176..593df315b111 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -63,6 +63,7 @@ svc_authenticate(struct svc_rqst *rqstp, __be32 *authp)
 {
 	rpc_authflavor_t	flavor;
 	struct auth_ops		*aops;
+	int			ret;
 
 	*authp = rpc_auth_ok;
 
@@ -80,7 +81,9 @@ svc_authenticate(struct svc_rqst *rqstp, __be32 *authp)
 	init_svc_cred(&rqstp->rq_cred);
 
 	rqstp->rq_authop = aops;
-	return aops->accept(rqstp, authp);
+	ret = aops->accept(rqstp, authp);
+	trace_svc_xdr_authenticate(rqstp, &rqstp->rq_arg);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(svc_authenticate);
 


