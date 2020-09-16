Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB026CE8B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIPWSR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAAC061A29
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d190so10030051iof.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nbMji9Jr8UAjnYXhxZ2mcTj1y0ZyQ51gRW4PH2vF5fU=;
        b=BxcfdXKBMuQCcYAm6vWbU4TCrwJq7hWNQvl2vFxgDyoGubb0qHUKSDC2ZFVMTgag00
         I/9SirgI3lJyHKB3xskyIUR1Y8Tisc1DAzB+9aORY1+XmlWCYZs5ay7bGix/vOSPTMpW
         JJuGWQuBkJn5cJVFrcuUVbgMVzeZ9R4CuISKl9bK+kjX966I4N6O9HxCohTgvr25A+68
         j0WnngIgjhfr8hqFRxgso/dNSaqGfkY5qfe4JcSuYP88dewijJrA42wYGUcQ3AZ2GYl4
         z1UGS16mOf+I/dp6XMvEumnyTAmvYliJykifDsLrPry/Fn80cwjKsszArh1TQiL71dET
         +hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nbMji9Jr8UAjnYXhxZ2mcTj1y0ZyQ51gRW4PH2vF5fU=;
        b=AEOlpzSdEkDL3b9naa1wX1PjSkifP/4gvDu5KcqTWo8FzY1xwCva/I+VWuQ46uqman
         G7yASxxSAs5hkKURExlifGrvbdrWvNrmsJ3lba0nR93EGQcTtcmIWXS0z5QtNWW4SzOA
         aBk+asUdaoivD2dXp4YIXDqB1o6obUKd6aI+EJUFIHcGUyEMomo7HfrtJyfNN1oufEcE
         BM3WxoFDz6Nx3s/rTMlcaOYPRFJhM1rpzw8KYk8L+7ejpZdQk3XnbiaSR5VG3Ib4sHQb
         I3kn3mFfWBc0fnPqvV51z2P4ZU62cSSp94DKthDoxfAUK2NBYgzCmjpZZmfv2dMRDZDT
         g/hQ==
X-Gm-Message-State: AOAM530zAq7IS/njNOEK9vB4mfiGAMfbgaizhzrHj7BoHepZT5AEQM0P
        WPAblT3zNSXVNjuhXtzcHis=
X-Google-Smtp-Source: ABdhPJwOkT4N1g/fDJae5C6jnuMiV62jHkQpP9l6bX1xlngcW/SLHTRom6Yi+FvWCEXEPVpqjuZ1HA==
X-Received: by 2002:a02:5d01:: with SMTP id w1mr23678263jaa.81.1600292550463;
        Wed, 16 Sep 2020 14:42:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v20sm11348026ile.42.2020.09.16.14.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:29 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgS4a022987;
        Wed, 16 Sep 2020 21:42:28 GMT
Subject: [PATCH RFC 03/21] SUNRPC: Add svc_xdr_authenticate tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:28 -0400
Message-ID: <160029254880.29208.1225935635296520095.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
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
 


