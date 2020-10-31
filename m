Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7B2A18C3
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Oct 2020 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgJaQo3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 31 Oct 2020 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgJaQo3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 31 Oct 2020 12:44:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4870CC0617A6
        for <linux-nfs@vger.kernel.org>; Sat, 31 Oct 2020 09:44:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i21so7106683qka.12
        for <linux-nfs@vger.kernel.org>; Sat, 31 Oct 2020 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Gesck89/C+XYwVW4u333xcha3slWGyGYFHSDNuhVlnU=;
        b=Uq7toNsVz4JxDLaYNlxm1PKf79UMMq9Kr/7JtsDnLhLATY6sFjvrVOx3C1nW8IoVS9
         0+SfzlzYuphnlXBVa6KTjSnjbBl8pi7hUCkWgJ/P8i16MYxYaHuMpZtyQxc/UaMLY1kE
         d+67XyIpKZh/B+U3xqmkXlP/o9Eied9mjzdN1KYTpaPIoKDV1dSQaxMv6bR0kounoBan
         Af+kLvjXOgv8CBE/FYaiG3kmY436z/z0ofWzHR8q7nDMMLp30cLSmbdL1xWPBBLBR/qM
         Pchk2T1dKN2nZWfVRA1SJGamHS9OcO6dTDrGfdILszRkBUWHK1CxX7Zsd+JsIHLzIwLl
         R8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gesck89/C+XYwVW4u333xcha3slWGyGYFHSDNuhVlnU=;
        b=tjKkZ0XkmWvp7YFfeAsxkQZmDA7g7WEXF/M5xVlv57Hk1LrO74IyCk+zXTlkhyk4ZN
         C2THlOiveuSH7UKk5kZ69z0pBh5m5Bx+hUiNRDzEOY8fhuYZJeCX6uZeBQkYcIkxrrCc
         j6KrZ1qfOMPBiA8XgSid2Mc6ov6up+D6GUfWXjeOX7LdjqM3vHXPnhjMywodghABQIf1
         nIoDbpmgAegxjtSKTofNbt7fs26N6SDpyV+yfrMgm/Nbu68Yi5PUGZn4VNQ0p5Y//xvJ
         slRhGoWNAGs0wNrL+5N8vx1KFjvbw3bJ2wlaFDVpZFqnaQ6Scy4gWPmJz2l+KCUtoLMv
         TgwQ==
X-Gm-Message-State: AOAM530aZP8FTFP+zUTuSVBZrf4jIHDujomA9MlXgBcgtGiWPR9EisfK
        BIAKuXOZMiR4zvuV0gqAcUNxxt6yXBU=
X-Google-Smtp-Source: ABdhPJzbyn7H0vhmaP/WMX43JCRAGO0qCOXwqmISI3UXYxDU3Y+kUNzm21rnN9qMnizp8Cugwqavow==
X-Received: by 2002:a37:4d11:: with SMTP id a17mr7421441qkb.448.1604162668013;
        Sat, 31 Oct 2020 09:44:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h18sm4788739qtc.17.2020.10.31.09.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Oct 2020 09:44:27 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09VGiPPX027397;
        Sat, 31 Oct 2020 16:44:25 GMT
Subject: [PATCH] NFS: Fix listxattr receive buffer size
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 31 Oct 2020 12:44:25 -0400
Message-ID: <160416263202.2615192.7554388264467271587.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Ah, hm. Did I forget to post this for the merge window?


diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 0dc31ad2362e..6e060a88f98c 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -196,7 +196,7 @@
 				 1 + nfs4_xattr_name_maxsz + 1)
 #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
 #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
-#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1)
+#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
 #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
 				  nfs4_xattr_name_maxsz)
 #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
@@ -531,7 +531,7 @@ static void encode_listxattrs(struct xdr_stream *xdr,
 {
 	__be32 *p;
 
-	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz + 1, hdr);
+	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz, hdr);
 
 	p = reserve_space(xdr, 12);
 	if (unlikely(!p))


