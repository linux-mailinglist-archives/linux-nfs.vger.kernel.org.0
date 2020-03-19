Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32A118BADB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCSPUe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43687 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPUe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id l13so2077085qtv.10;
        Thu, 19 Mar 2020 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CIxixJZwpGLo0sVVb9Fs9GENGxOabLmSEhF/beS+CUs=;
        b=pKqpvb9Q0p1Pbf+ZrXo4eb6DnCbdVOlbkmfP7SXeHojXC+CMF7XugwNYQwno6zZN7B
         6fEgAyKuT3QwWL5gx1DywyyzhNr2O1IHu0u5REPv1k7deq/E1uABfB695D6w8udU7uX2
         7iNto/liDpkJtdLHzVhPIlyoxGqQxsehUyRADT3UJjk0yZpo1vQOcV80Z8mREDvDmq7n
         VpGL5NwwNpDF8GblXw4hDEqTQmJr8GFuHNxre6YZURJjYAHDozxd7U75TzOwh+GXc6AC
         cTsvzk3miiWE1OrpyDrTdXwlKd0D2Bifudm4v3rztcd39yMeuBnEbVz2qzM+lUBdf47G
         k9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CIxixJZwpGLo0sVVb9Fs9GENGxOabLmSEhF/beS+CUs=;
        b=mJ7lSaSB6C7zK2LDkb5j4rrtudZRMN8TJaBgMOHUWzttJzMgYBuq6Zx3D/CvnOpd08
         1JJTG/N/r2w9BR7Til1zufRwVPqcIln1Sg72zbTpxaV3c/FHacK1FvF+gCkto/9UyH66
         cKgdcdjRM8DlnfUrXlhZFpNiQwdwKwXPvB8Vkcrl8VzK1BrnkzrzonVAEE1pAXJQUSQT
         cOCRmJa536Q9R7uZh2Lkc9Y190nXn9wTOO/sVbbcDT+SYkAAJsyxAUzF9SU8+nSMrBoP
         EzRcJeiUmFEVv73adLfe6MmZU18jvwiGHs4T8vsd0rqLDkdWybZB3je27PJvELxLivNt
         KzhQ==
X-Gm-Message-State: ANhLgQ2MJBXXndpK9z0EKofOhDEgha14UbHvnzwPfnd/w5smArrq4pao
        8klFEfRV+29eYxDLDTO/Ef2ZXqFk5pY=
X-Google-Smtp-Source: ADFU+vuGslyW59Tsmb+QpDMJ17l2ulj/3fKIj/OktAout4Z7lHNr22T3gY6H4296Y2Icn4lHb6VkEw==
X-Received: by 2002:aed:38ea:: with SMTP id k97mr3419602qte.327.1584631230596;
        Thu, 19 Mar 2020 08:20:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v1sm1749730qtc.30.2020.03.19.08.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:29 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKSrs011148;
        Thu, 19 Mar 2020 15:20:28 GMT
Subject: [PATCH RFC 01/11] SUNRPC: Adjust synopsis of xdr_buf_subsegment()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:28 -0400
Message-ID: <20200319152028.16298.49075.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This makes it easier for callers to keep that buffer const as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |    3 ++-
 net/sunrpc/xdr.c           |    5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8529d6e33137..3caa1fe75408 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -183,7 +183,8 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
  */
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
-extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
+extern int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf,
+			      unsigned int base, unsigned int len);
 extern int xdr_buf_read_mic(struct xdr_buf *, struct xdr_netobj *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e5497dc2475b..0f7f5d9058e2 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1105,9 +1105,8 @@ EXPORT_SYMBOL_GPL(xdr_buf_from_iov);
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

