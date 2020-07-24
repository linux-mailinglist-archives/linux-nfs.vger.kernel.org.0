Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10D22CE30
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgGXSzM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jul 2020 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXSzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jul 2020 14:55:11 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE45C0619D3
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 11:55:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c16so10833418ioi.9
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FRjvCfO/dKe/I49SQgPyRDs92Ez30Nh5sjzTmD1Wtfc=;
        b=BuGsJ5lj2vRKhP4F1xGRPoT84tvsvGhkfEGeksOXXyM+2m26Uq1oEB9rznTdDdn2Pp
         Zu0/M8Zoq4COPVCTyUDGRut7qOTg/VH9a2QO8q+d49A+dXOk6dnn3r7uOF6V/iwEpqcm
         kmYMxKaNKF55mQj0xfs/kh7TWCyZtshodG51P91aww3jbNi8NA14HE/ZgNr/1vZR9pzi
         1GS5BpxqdAGa7x0R4olp5LuumzfXBvgbLUsGDtBuazIufDP0o/ASl1H/KUbuzHypwYZE
         MWvt7njNOeArbj4kLWFtQDLlkA3zmfAMJljrNV6xJkG8AWjPATEXXU0wRYVf829/5f5B
         Y+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FRjvCfO/dKe/I49SQgPyRDs92Ez30Nh5sjzTmD1Wtfc=;
        b=DPlv8FZAxkWZyemwjAnEr8064q9as0jycu2J6OIy30fE1wm4GApFKHoMrfsvT0PBTw
         +1PrCyYVIn7RAYrZIXJuikOkTrOZNnJ3wQJhgdICaSHzFDMLPf9N0KXccdnIuMUWTAuy
         uIJahgHsAs2ytf7EiXECJvxFkagQ7RvOcKUaoVrEZfLVIpySVbyogS4qV+sz7KwR1r3T
         sjChApvJTwoEKxLpk5p0IwQl4i5ePlSfJ+AEM5zyC1Xf5cIS1oARvCTZ36qf4V+DjMpf
         do8eNcAGJfOTkAYpoO7hj45ZX3ZvXmG5D5ndvqeuRwznAb6p4vWqb7S9N0eFk9Q538M+
         GRbQ==
X-Gm-Message-State: AOAM5334PSDOcaNgLpWuNH5Ep/ApJXFTPLcc96o/B1tvTNoUN0TE09n9
        ZWMc/PzFN2uka8W41wcIrf00azlX
X-Google-Smtp-Source: ABdhPJz5zLMGVQQUTl9CCg9jjXpTUqqr2Iy2l2jDxRMtX1kO0zNGp1q/AXONu0/qhdreV2a5aaQ4Hg==
X-Received: by 2002:a02:7691:: with SMTP id z139mr12616165jab.6.1595616910441;
        Fri, 24 Jul 2020 11:55:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j4sm3698325iog.35.2020.07.24.11.55.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 11:55:09 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06OIt7Gb006266;
        Fri, 24 Jul 2020 18:55:08 GMT
Subject: [PATCH v2] SUNRPC: Fix ("SUNRPC: Add "@len" parameter to
 gss_unwrap()")
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:55:07 -0400
Message-ID: <159561664051.1673.12679579228291628238.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Braino when converting "buf->len -=" to "buf->len = len -".

The result is under-estimation of the ralign and rslack values. On
krb5p mounts, this has caused READDIR to fail with EIO, and KASAN
splats when decoding READLINK replies.

As a result of fixing this oversight, the gss_unwrap method now
returns a buf->len that can be shorter than priv_len for small
RPC messages. The additional adjustment done in unwrap_priv_data()
can underflow buf->len. This causes the nfsd_request_too_large
check to fail during some NFSv3 operations.

Reported-by: Marian Rainer-Harbach
Reported-by: Pierre Sauter <pierre.sauter@stwm.de>
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1886277
Fixes: 31c9590ae468 ("SUNRPC: Add "@len" parameter to gss_unwrap()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_wrap.c |    2 +-
 net/sunrpc/auth_gss/svcauth_gss.c   |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

Hi Bruce-

I can take this in v5.9 if you agree it's a righteous fix.

Changes since RFC:
- series squashed into a single patch
- "pad" is still calculated in unwrap_priv_data for later use

diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index cf0fd170ac18..90b8329fef82 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -584,7 +584,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
 							buf->head[0].iov_len);
 	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
 	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
-	buf->len = len - GSS_KRB5_TOK_HDR_LEN + headskip;
+	buf->len = len - (GSS_KRB5_TOK_HDR_LEN + headskip);
 
 	/* Trim off the trailing "extra count" and checksum blob */
 	xdr_buf_trim(buf, ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 7d83f54aaaa6..258b04372f85 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -990,7 +990,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 
 	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
 	pad = priv_len - buf->len;
-	buf->len -= pad;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to
 	 * move it around. */


