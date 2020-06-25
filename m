Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840D120A1FB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405775AbgFYPch (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405773AbgFYPch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 11:32:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E6C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 08:32:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so5669118qkg.5
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1HkPKhZQKEFuuwh3nYF5i0Z39kVLm5lQ6wGQ8mUbjuE=;
        b=TeR5PAD6K8PnpC27N76HI3IhXZb1J7hOSomoIOBskpQVb6QrOOGDVJ3NST1PH/2yU4
         awtkMjMd18jJHRZykSM/OItoL3W62tZ47/paOOy8qtalLJHFYPZgsaeTbBDQNkJX6wAa
         +ZfcXvkoUIBXbvJzFGoMzZeNgmhY0Bl0z+GwnpjDLuzIHEVDVAGdM+a8P7HN1JbNsdzO
         4MC9P3oFWb9gS+eCesZcTK7XrfnRYKq+BSruoXuSb1pa2KA0/DMGeeXtgNF3Zb43kuc3
         O+kS+vg6JinPvjqDs5Ve1voYgsXeEPu00I2CmOC8SBZREMULZ2m2TpCjYL06v93G3eqp
         EEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1HkPKhZQKEFuuwh3nYF5i0Z39kVLm5lQ6wGQ8mUbjuE=;
        b=HTV5pHv+jbhfkJiI5njrNbPb6vouNacgA9/JJkckplYDuRsJo9CZhdIEZVxfyqmHUj
         AeYROabpomJrLiSPyIQSwYlj4kU11sGQwreVeHVbpHlBr2ElHvL+H/NyJdNHcA/b7LS/
         eVU/2Uz9s8dNOVWduY0wKWBOvQo5QyGMNeJDRr/QtUWbVpL9/EggGLQ6DftSSSAG9PpU
         RkuITVRdr+6p4qlrOhUVGEpLHWanMjaTJQWZ8v8zSO0o/Nn6BAh7U4jm6/OEtNP58uzq
         0GeCUXMN1GenR3+iYsaQOaiku9daxv/W+T7sIyo88p8zEytNs2FGFkrf9rREPXnAbEKS
         5PSw==
X-Gm-Message-State: AOAM530u3rOkOCVBlHdIy8NtNtJJaphyO3WrPz6La5DyHVlY/02l4Pgx
        CFH6cMBoaQ4O6ZCjpxs/8KdCxwH4
X-Google-Smtp-Source: ABdhPJyymSl70iwIJnDhpIBUlBsuRMM+WDba6LenoMdUbIWsuS6uSdsp31SfWU6u+8RaGTE3xxdBcA==
X-Received: by 2002:ae9:f808:: with SMTP id x8mr668067qkh.357.1593099156269;
        Thu, 25 Jun 2020 08:32:36 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w1sm5146868qkf.73.2020.06.25.08.32.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:32:35 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05PFWYuI028832
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 15:32:35 GMT
Subject: [PATCH v1] SUNRPC: Properly set the @subbuf parameter of
 xdr_buf_subsegment()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 25 Jun 2020 11:32:34 -0400
Message-ID: <20200625153234.4448.99187.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

@subbuf is an output parameter of xdr_buf_subsegment(). A survey of
call sites shows that @subbuf is always uninitialized before
xdr_buf_segment() is invoked by callers.

There are some execution paths through xdr_buf_subsegment() that do
not set all of the fields in @subbuf, leaving some pointer fields
containing garbage addresses. Subsequent processing of that buffer
then results in a page fault.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@vger.kernel.org>
---
 net/sunrpc/xdr.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 6f7d82fb1eb0..be11d672b5b9 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1118,6 +1118,7 @@ xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
 		base = 0;
 	} else {
 		base -= buf->head[0].iov_len;
+		subbuf->head[0].iov_base = buf->head[0].iov_base;
 		subbuf->head[0].iov_len = 0;
 	}
 
@@ -1130,6 +1131,8 @@ xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
 		base = 0;
 	} else {
 		base -= buf->page_len;
+		subbuf->pages = buf->pages;
+		subbuf->page_base = 0;
 		subbuf->page_len = 0;
 	}
 
@@ -1141,6 +1144,7 @@ xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
 		base = 0;
 	} else {
 		base -= buf->tail[0].iov_len;
+		subbuf->tail[0].iov_base = buf->tail[0].iov_base;
 		subbuf->tail[0].iov_len = 0;
 	}
 

