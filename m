Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECF2995E7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790970AbgJZSyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:02 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35592 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790967AbgJZSyB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:01 -0400
Received: by mail-qv1-f65.google.com with SMTP id cv1so4826103qvb.2;
        Mon, 26 Oct 2020 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kpfr4F0on43i4V/zu9BuZKzeiR4ktVja9X2eWer5VgQ=;
        b=dspodzqnm43fSgfcnYiLK5ikoj9NXgdHbh9/QAWwPyCYBTlVRu+faHRPotrYLRbEZE
         yWJqNcolEvsLNJK048Mv8M18keR7k6G9fxUvYQqiYeteUePqZ2nCDVYNysKvFFVMlP/f
         I3w5U8z4JD52vjfIaSpVrsWtH4UW5JA1eNIPgbHsgTKKNqGaHirRyuBDA2gPr7HFELfS
         ieDkovoGcJH1R46u5IAZG7IodgvwXniTjfvOPcwN5Rl6Td/dNVVWgRl2MTB/RSzLHViB
         q1ELOOpRuONWl7frwjO2wFla7QnBe5G7YRJbs/AC9GEPIcBVZb+iqkIX4sRn/l33ho47
         8o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Kpfr4F0on43i4V/zu9BuZKzeiR4ktVja9X2eWer5VgQ=;
        b=Itdzjhq4PcLVPF7n0sAJnKEnA/8DFEN3MuvEQ7MMjZvw6tGHDlnXjnJ+oTutRRwnde
         SiNQZ9eCIXd/iW04qpAZBTOGqYZ5NapRrwhU/uyCdqtK5Pmc8MrUzT2KNcbE4UhUuaei
         HIahwEFhqyvGmgL6Aqn40FCeHxOfZ4d9dnB5kbn3/4qCLCbuYT+cHb/dykgYwqWvlfy3
         veeANu88htPpEMKN/KE2zM/ecjhJSAT4TEguLG4TRsTl5hjL612dI0PVC0zYPaLlFTMv
         BpiVV/JWWP3uJL7smdfqSN7ODYXCTAOmfBmnA5XzQoqbrMf1yg6FgjmE/djiwrmDGE6g
         GQvQ==
X-Gm-Message-State: AOAM533/0B5cnJJTgo0SVNH0c55gm83yh4UgY5Xqb92hgolKikayQdZ+
        dv22AY0gKVQh0eBiAlGiV9UrZ8HSXi8=
X-Google-Smtp-Source: ABdhPJxITajcEXTKryhppiIXCPihrfwQ5i5j1wDextPKAPbWwXUUNTGPUrfrGluFMLAVr8TqWNwk5g==
X-Received: by 2002:ad4:55ea:: with SMTP id bu10mr19049524qvb.28.1603738439973;
        Mon, 26 Oct 2020 11:53:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 128sm6924148qkm.76.2020.10.26.11.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:53:59 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIrwIm013616;
        Mon, 26 Oct 2020 18:53:58 GMT
Subject: [PATCH 01/20] SUNRPC: Adjust synopsis of xdr_buf_subsegment()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:53:58 -0400
Message-ID: <160373843825.1886.3133196140333045174.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: This enables xdr_buf_subsegment()'s callers to pass in a
const pointer to that buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |    3 ++-
 net/sunrpc/xdr.c           |    5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 9548d075e06d..ec2a22ccdc2a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -183,7 +183,8 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
  */
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
-extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
+extern int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf,
+			      unsigned int base, unsigned int len);
 extern void xdr_buf_trim(struct xdr_buf *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 71e03b930b70..28f81769a27c 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1379,9 +1379,8 @@ EXPORT_SYMBOL_GPL(xdr_buf_from_iov);
  *
  * Returns -1 if base of length are out of bounds.
  */
-int
-xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
-			unsigned int base, unsigned int len)
+int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf,
+		       unsigned int base, unsigned int len)
 {
 	subbuf->buflen = subbuf->len = len;
 	if (base < buf->head[0].iov_len) {


