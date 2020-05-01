Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAD1C1D93
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgEATEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729839AbgEATEI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 15:04:08 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E61DC061A0C;
        Fri,  1 May 2020 12:04:08 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ep1so5218423qvb.0;
        Fri, 01 May 2020 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=96QSejN1XjBz5VbtJDX6HxKzPqbLYh9wojk8iWHqLno=;
        b=MI+zjTglh3QnVcwW0brnjedn+laYrJJuSNbxiYnKzoh09rTfENcuFFmwo7VpxdmHwc
         f9QO33giWqcvpLqGew+yysKEKAlq5FyDCaY6z4FAIYeJTNcd19PUKu2AK5MEeDY8S7tU
         r6x8eBPy+G01ix3lhkgxraQO/RrSPQOw+sWYp2r5dl/r782tVvWnQfDZetVl/xMOkQ93
         mixRIu8bfjtjAjEvy64MbsdoNeTkMX5glunvzcmc1F0EeyGBqaWc0OLy5evB4tu+dAX0
         NnAfnGUkxpqz9Nd0P7Wuet3lkAvLkekAchxAPE5OICjjTLkgpzWa3B64bYqsrXyZ2RZy
         EzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=96QSejN1XjBz5VbtJDX6HxKzPqbLYh9wojk8iWHqLno=;
        b=NKVHWSesUiAnNKkbaXNC6ISJA6F073GXd72LDplZzqGtQ1lSX9rxMleFCFbQi7JatT
         d3Pzdimvckw+ZtkNH8Ye0q8QVfcMgXMlVB9FLLoD96fVASA2JwVyvKdyOfjhvBT02P8B
         ra9T1gceoPHpIec0DRHy3OXcXnroDeTCnii1P4o6/Bj9SFiufJRXgRS1uLxp7tHSi/Td
         QYYkzFYblrQGeJyEdABR/pvI6zXJHDB8SU4A4pYX3Kb/C1gH3Ayqyfor4X2KwYE8MDsy
         6IQPVQa1/G1oNYwAPr9cdbgUMnz572mY8URUOdppFb10ukf/DZwyjSsJiBEdQtaRKD7V
         LilA==
X-Gm-Message-State: AGi0Pua5+7S8+K2mnngL8aLGWE9ksOQcVqLOsZxQWEt8l9icp/HtkV0M
        UcpeCKrFVmgi25FwoD0FW3y+JEZk
X-Google-Smtp-Source: APiQypKCCqgHkqrg06aLIKuVkScXSBXvW87TYSiB7WpvGUMoYl7PEWKtk4K4UFrlh74lym20CDc39A==
X-Received: by 2002:a05:6214:a14:: with SMTP id dw20mr5356066qvb.179.1588359847374;
        Fri, 01 May 2020 12:04:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g8sm3295927qkb.30.2020.05.01.12.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 12:04:06 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041J45Ua026984;
        Fri, 1 May 2020 19:04:05 GMT
Subject: [PATCH RFC] SUNRPC: crypto calls should never schedule
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org
Date:   Fri, 01 May 2020 15:04:05 -0400
Message-ID: <20200501190405.2324.25423.stgit@klimt.1015granger.net>
In-Reply-To: <20200501184301.2324.22719.stgit@klimt.1015granger.net>
References: <20200501184301.2324.22719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Do not allow the crypto core to reschedule while processing RPC
requests. gss_krb5_crypto.c does make crypto API calls in process
context. However:

- When handling a received Call, rescheduling can introduce
latencies that result in processing delays causing a request to
fall outside the GSS sequence number window. When that occurs,
the server is required to drop that request and the connection on
which it arrived.

- On the client side, ostensibly RPC tasks are not supposed to sleep
or reschedule outside the RPC scheduler. Otherwise there is a risk
of deadlock.

Generally speaking, the risk of removing the cond_resched() is low.
A block of data handled in these paths will not exceed 1MB + a
little a overhead, and processing a single RPC is already
appropriately interleaved amongst both processes and CPUs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index e7180da1fc6a..083438f73e52 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -209,7 +209,7 @@ make_checksum_hmac_md5(struct krb5_ctx *kctx, char *header, int hdrlen,
 	if (!req)
 		goto out_free_hmac_md5;
 
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	ahash_request_set_callback(req, 0, NULL, NULL);
 
 	err = crypto_ahash_init(req);
 	if (err)
@@ -239,7 +239,7 @@ make_checksum_hmac_md5(struct krb5_ctx *kctx, char *header, int hdrlen,
 	if (!req)
 		goto out_free_hmac_md5;
 
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	ahash_request_set_callback(req, 0, NULL, NULL);
 
 	err = crypto_ahash_setkey(hmac_md5, cksumkey, kctx->gk5e->keylength);
 	if (err)
@@ -307,7 +307,7 @@ make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
 	if (!req)
 		goto out_free_ahash;
 
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	ahash_request_set_callback(req, 0, NULL, NULL);
 
 	checksumlen = crypto_ahash_digestsize(tfm);
 
@@ -403,7 +403,7 @@ make_checksum_v2(struct krb5_ctx *kctx, char *header, int hdrlen,
 	if (!req)
 		goto out_free_ahash;
 
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	ahash_request_set_callback(req, 0, NULL, NULL);
 
 	err = crypto_ahash_setkey(tfm, cksumkey, kctx->gk5e->keylength);
 	if (err)

