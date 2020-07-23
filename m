Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C5022BA0D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 01:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGWXOs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 19:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 19:14:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE63C0619D3
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 16:14:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c16so8050955ioi.9
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xESjL48MSTWK7fMOff3ZgZF8I9AAoOusKzFqzbC/vcw=;
        b=L3kY2oQ7bk3AWNWG8ySC0TQTxuwxB0SbAd2W0Nefuy8zGc4mO8zWS52qdbXUggdg74
         xkHQ8RqENsSHaLa1UBg6zE0Vbkrk8c6UMhr61dVu4jqvI1Gv067f/ftBRHpbYOoIQujh
         ZbaGXVJ/gkjrtcyokfsc0MaI8D6znXnKKZVglFlb6MLoIDvnym68zuAU3J90Ub3RD73y
         DCX0FV4cjSIYITEzBIXmSFU3X0CMIDQZESEp52BnUJgykT/h3Qtk9Mh1mr7wcw4FMy3J
         XN5f+yRMkRqw0KnlavQkCRF0fLNncGmqzZcJfALPTkUimU0T4GSHuBLIzGDPDnDpPAea
         pt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xESjL48MSTWK7fMOff3ZgZF8I9AAoOusKzFqzbC/vcw=;
        b=gRDT7K8MlIy1XY2k59R+iaY7rECZuHUnBSGocIJ0ieGaeb5qVmIMoQIp5tw6kWXCgM
         TVmsBT0yCvbTDbQMTUbULMvbs87F6/4OsKAozGG9umb1ArksKlUQiw3mlbdCSOfi5It+
         mLcmtYM2U2gs0PfA4dMo7YYjuocYa4z9Cw3blEBEdByqD806Srm9MofCXQxwH/kEzC+M
         d1vjTYX2tFYA4P4rldJkO2qh2qk+b+7yiC0tJEh75eYllGBaUQ+jKIFIwDkqtVg+qLyF
         l8cxZ5gIWEHXe/LWIMBNhLRdUreZJwK2JOJ7I+iaA8orMk2JnOWZ1tX4EKucYEBayo3o
         RhdQ==
X-Gm-Message-State: AOAM533WkFkGuZXuNS6wEcVlA5Mp6baqXYbccUXXrXSnSgDVWFaKDIOj
        s0I8Hr2WikG1EYhFbwNLvlGRVbQm
X-Google-Smtp-Source: ABdhPJwk6oTmvr4jtwkhM1mdoOiLMg+eXMO1D+HTg4S2eI9Gto8gUcyTS/WcJfyQ7ewI5rB+yEJiCw==
X-Received: by 2002:a6b:5c0a:: with SMTP id z10mr7333927ioh.131.1595546087109;
        Thu, 23 Jul 2020 16:14:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b13sm1068195iod.40.2020.07.23.16.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 16:14:46 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06NNEjiT003338;
        Thu, 23 Jul 2020 23:14:45 GMT
Subject: [PATCH RFC 1/2] SUNRPC: Set rcv_buf->len correctly in
 gss_unwrap_kerberos_v2()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Jul 2020 19:14:45 -0400
Message-ID: <159554608522.6546.6837849890434723341.stgit@klimt.1015granger.net>
In-Reply-To: <159554528704.6546.6823326959131917327.stgit@klimt.1015granger.net>
References: <159554528704.6546.6823326959131917327.stgit@klimt.1015granger.net>
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

Reported-by: Marian Rainer-Harbach
Reported-by: Pierre Sauter <pierre.sauter@stwm.de>
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1886277
Fixes: 31c9590ae468 ("SUNRPC: Add "@len" parameter to gss_unwrap()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_wrap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


