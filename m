Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13721321B0C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 16:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBVPOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhBVPOI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 10:14:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F33C0617A9;
        Mon, 22 Feb 2021 07:12:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n10so14712516wmq.0;
        Mon, 22 Feb 2021 07:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65uTl/DL0ujA6C8p6tAwX4+93DKKilnR81zX6h8q1v8=;
        b=b1r1t7/9FkfFvI8NzbPsWItaj3Vp8C1YOhKzqWDv/cIeky/XuHH9lL48rVM1yGCDQM
         rYYwTs+SOxYhOfw5Z+59Gn+navsY/NfttlX1NbrQUYk/Qc68NddzJFdzbuDTX8GpQLTB
         wBhgKXIFZug2leJR1e8TkH+md11czHNCQqs3jqi6qv/eTwSfES1On6EUG6wqwVsDiUix
         Arv9gm7BT3V09ls3cWgJky4r8RyyC5tqLKw9aJDFkjVJrMUgDoc1sjDc5ACqVM5Up1wS
         KWkZfPcFZM7K4Dxoj66LfT6arTk1SvQk5+ZkE9/v9Ipd9E7sGPqzMMaStGYWCyqNPQSI
         YxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65uTl/DL0ujA6C8p6tAwX4+93DKKilnR81zX6h8q1v8=;
        b=Q721dZrUqQ8C7HUAm3vaJWTpVnTu28nx4CwyikwXJDNJI6LjrvBP9Pf+i2XpxoMqt2
         th8EAFcLK3AG1vrfoZzpbH2a8DEdC0tdXRPsYFjHFbpQtap/xDzTVPst8mKEZD7L+hAu
         6dLBQIOYg8NK/4Kd1/Z86FJ20mGlQ8Zm03g/yz292a3gJSyG6A0n9aZhDDSUn2Dav4AG
         7fld4TiLGgBn66Ag2GOnKsj9ZGF1uxkaLL1SttkmGBqzhw1YUqikcijFmRGLUgIt/HA8
         SMU4qM9266FZqGlneZIZD4CMHzhI5LGYvwC4MdOH/9NK9UEbdf+PfAzTiVbdYEMx4Bhk
         APhA==
X-Gm-Message-State: AOAM531PWSAt9mzfBW9LtMda9NMAR9FMpJWL3Y4XR+VDNpCERLxNoNSU
        hoYSFnT1ouzqkfErCWTJufmsnsOKctpg2Lly0Jw=
X-Google-Smtp-Source: ABdhPJyr+0yYY214oKEDBI29fhzZwAOghMQnhkDW+SagA7DHVRiuybGQ/ITWc05OdOmwnuyzlppXNA==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr20718184wme.175.1614006770799;
        Mon, 22 Feb 2021 07:12:50 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id k15sm27612368wrn.0.2021.02.22.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:50 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Romain Perier <romain.perier@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] SUNRPC: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:18 +0100
Message-Id: <20210222151231.22572-8-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 net/sunrpc/clnt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 612f0a641f4c..3c5c4ad8a808 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -282,7 +282,7 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 
 static void rpc_clnt_set_nodename(struct rpc_clnt *clnt, const char *nodename)
 {
-	clnt->cl_nodelen = strlcpy(clnt->cl_nodename,
+	clnt->cl_nodelen = strscpy(clnt->cl_nodename,
 			nodename, sizeof(clnt->cl_nodename));
 }
 
@@ -422,6 +422,10 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 		nodename = utsname()->nodename;
 	/* save the nodename */
 	rpc_clnt_set_nodename(clnt, nodename);
+	if (clnt->cl_nodelen == -E2BIG) {
+		err = -ENOMEM;
+		goto out_no_path;
+	}
 
 	err = rpc_client_register(clnt, args->authflavor, args->client_name);
 	if (err)

