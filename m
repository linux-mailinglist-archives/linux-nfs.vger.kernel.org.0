Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3583A24DEA3
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHURgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Aug 2020 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHURgl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Aug 2020 13:36:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AC3C061573
        for <linux-nfs@vger.kernel.org>; Fri, 21 Aug 2020 10:36:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m23so1910320iol.8
        for <linux-nfs@vger.kernel.org>; Fri, 21 Aug 2020 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tdj2DZghyBM0fDCtLQVzN//ZZN+M6E00K+uyOUSe+b8=;
        b=tKoIorLccOJhJ/IX2zJOHajGsgpC5n0/a8xkSFJosAVntdkaPguZiOAdOlbT66LV0f
         YZdwyaImcOXYUQtsM3cOTLG8efFResaR3WIaOFFySEmculDMXTeEDWa8tSxH3+uE7BS2
         dW6QZwv5wCB/gZvtxcUw/zxeTDL1wx0O9MKI5F0XaUvVB6bHZQmdMBKM9OkLp7ylhS7B
         dZ0s0KrRo4kfHz50PoLJkngiMa+0ZDOKe4eKSW95K6znQTqKv9wrxspUHIKhAvCmnc5D
         zGLanWb/OmUzwOZAlpOMiPLZBr262Dan0sGw6KkEe5iqXA1oJ8O6M8ocqZ8dst7JnyQq
         Jnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tdj2DZghyBM0fDCtLQVzN//ZZN+M6E00K+uyOUSe+b8=;
        b=e0j17CUhQvsXZXWW3gml9bFa2aFV93u76uzi8/UUykqXhXNpqBVL3oIT3fmLJg8yEW
         u7j1q4H84AI4lUvAUSiKD4kwCKkP9AT1v5gMYK+/3ALtHPnrYZ7UBT8aqjYF1bOSBfef
         33mUFC+cQOXJWErsvX6B80rSYytT4WdiquaeXvEY9woK2TD6HLHO74SeIwDNQtvoaYCw
         BFS+ZNouDkGWKWlVzaQbze1S6R+3pomn+cRES7QpxYpepwFa9ibv6Oc6fHmGHHRS/2Ze
         IoY3aL5p0xWyS4ZOQi6fVHvi6O98VSrlsejYFKO4xPK9+n03UZeqzYK9h9BE2aFXf0HH
         Dznw==
X-Gm-Message-State: AOAM530qz0xZEhO4pwrYYGH0RN3BkOoTm2ybDfQE7OaiuGrBtt6hmsYl
        u2GfZfod/VDI195ZXAtvR1U=
X-Google-Smtp-Source: ABdhPJzgvuAyXoCphpwxOYmHOaRx/k9aqKnlBuuORCC+0pZaSjYsJmx/JWavupFpvJXgbWXRvisVIg==
X-Received: by 2002:a6b:b292:: with SMTP id b140mr1151240iof.87.1598031400278;
        Fri, 21 Aug 2020 10:36:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b5sm1565523ilr.58.2020.08.21.10.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 10:36:38 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07LHaZCg016121;
        Fri, 21 Aug 2020 17:36:36 GMT
Subject: [PATCH] NFSD: Fix listxattr receive buffer size
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     fllinden@amazon.com, linux-nfs@vger.kernel.org
Date:   Fri, 21 Aug 2020 13:36:35 -0400
Message-ID: <159803139578.514751.6905262413915309673.stgit@manet.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Certain NFSv4.2/RDMA tests fail with v5.9-rc1.

rpcrdma_convert_kvec() runs off the end of the rl_segments array
because rq_rcv_buf.tail[0].iov_len holds a very large positive
value. The resultant kernel memory corruption is enough to crash
the client system.

Callers of rpc_prepare_reply_pages() must reserve an extra XDR_UNIT
in the maximum decode size for a possible XDR pad of the contents
of the xdr_buf's pages. That guarantees the allocated receive buffer
will be large enough to accommodate the usual contents plus that XDR
pad word.

encode_op_hdr() cannot add that extra word. If it does,
xdr_inline_pages() underruns the length of the tail iovec.

Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended attributes")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index cc50085e151c..d0ddf90c9be4 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -179,7 +179,7 @@
 				 1 + nfs4_xattr_name_maxsz + 1)
 #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
 #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
-#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1)
+#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
 #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
 				  nfs4_xattr_name_maxsz)
 #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
@@ -504,7 +504,7 @@ static void encode_listxattrs(struct xdr_stream *xdr,
 {
 	__be32 *p;
 
-	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz + 1, hdr);
+	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz, hdr);
 
 	p = reserve_space(xdr, 12);
 	if (unlikely(!p))


