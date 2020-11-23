Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DEC2C15AA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgKWUGT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgKWUGS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:18 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F202C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:18 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so14367211qts.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QZScK38Ffc/kD+dSDrz6Tn8jmqVc0fYHXXAEhUoDq1g=;
        b=stJxWUGiJIxzt3rJIG4qTZpbmUB9C9Fpd6iBw621ukf7XrbDUtznFf3WmMUzsWEQiQ
         bErQSmpAJh1nkFjcnlcOlgelomoUgOqG/qH/JU11wySgfjcJOONWRcv9dUuvE1h+Dyj8
         YgENjV8MGyK8FpEjNFcBZiTpAF2CHG43U0KzayFO6gQT/85ozQreh4kNsV4f1V0kBkHd
         mq17jO+9OWxYmDZ29jsBYuBRg0F6ngy1ZjehIHeLiv90+QgVlNlIzJDralpeHkMJv1Ih
         Zgieq6vhlV0TaW9QX197tMVJ60X1HI7Eodfvljg2fr8yL6JNUTWKe5gMmir8rctba8Cb
         N4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QZScK38Ffc/kD+dSDrz6Tn8jmqVc0fYHXXAEhUoDq1g=;
        b=iSWxm/NrUJuYDYN9Ezh/FVca/EtelJ1qVnAfPCccDkyU6j2w5aHChwRTENWv48yxS/
         4D6cpN1SXNqfs+gskNqvrXHP/DyLSeefw5pADXBGyD3UbapHpemq1bRTDG4qXP2W4XNo
         5dHuy46FlEx8GBkMViyKfb/sN7Q42s/+4CyP5rNSkBfFOYorHfjUXhWXr9XclkKXkpB0
         ETdtBA5CCnkW133q4TI5xpUh+jj7qoeEhFDK1y5tlps+9ocWBu2LvSXUgLGW8S8INWZd
         sjMW7YBL7H5ZXgKDpyaou0RdQOgxW3fe2Y8OAepr0bWxMtWiW9p9Om+MDL+nh39PFdBL
         nSpQ==
X-Gm-Message-State: AOAM530udOp+EKYGTjUvu1MBEe17s9b9VtNWoqe/iRkHccZvHI/r9NnU
        DNhqroXAEYwpbPUy8jzyxFNelMjzq30=
X-Google-Smtp-Source: ABdhPJygwH6mUDsLmEGyCMxN0ayYU+/lsnr11ZxIK/3UXkEJVkFeOe8GVpG3sHDx5vQ+Ruge28PxbQ==
X-Received: by 2002:ac8:380f:: with SMTP id q15mr893233qtb.102.1606161977566;
        Mon, 23 Nov 2020 12:06:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t51sm9704694qtb.11.2020.11.23.12.06.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:16 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6FSR010346
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:15 GMT
Subject: [PATCH v3 26/85] NFSD: Add helper for decoding locker4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:15 -0500
Message-ID: <160616197596.51996.1992350133667838568.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c          |   64 ++++++++++++++++++++++++++++++--------------
 include/linux/sunrpc/xdr.h |   21 ++++++++++++++
 2 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index dec383225722..a209f3c8ec06 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -833,6 +833,48 @@ nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
+static __be32
+nfsd4_decode_open_to_lock_owner4(struct nfsd4_compoundargs *argp,
+				 struct nfsd4_lock *lock)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_new_open_seqid) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_new_lock_seqid) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_state_owner4(argp, &lock->lk_new_clientid,
+					 &lock->lk_new_owner);
+}
+
+static __be32
+nfsd4_decode_exist_lock_owner4(struct nfsd4_compoundargs *argp,
+			       struct nfsd4_lock *lock)
+{
+	__be32 status;
+
+	status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_old_lock_seqid) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
+{
+	if (xdr_stream_decode_bool(argp->xdr, &lock->lk_is_new) < 0)
+		return nfserr_bad_xdr;
+	if (lock->lk_is_new)
+		return nfsd4_decode_open_to_lock_owner4(argp, lock);
+	return nfsd4_decode_exist_lock_owner4(argp, lock);
+}
+
 static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
@@ -848,27 +890,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 	lock->lk_reclaim = be32_to_cpup(p++);
 	p = xdr_decode_hyper(p, &lock->lk_offset);
 	p = xdr_decode_hyper(p, &lock->lk_length);
-	lock->lk_is_new = be32_to_cpup(p++);
-
-	if (lock->lk_is_new) {
-		READ_BUF(4);
-		lock->lk_new_open_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_stateid(argp, &lock->lk_new_open_stateid);
-		if (status)
-			return status;
-		READ_BUF(4);
-		lock->lk_new_lock_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_state_owner4(argp, &lock->lk_new_clientid,
-						   &lock->lk_new_owner);
-		if (status)
-			return status;
-	} else {
-		status = nfsd4_decode_stateid(argp, &lock->lk_old_lock_stateid);
-		if (status)
-			return status;
-		READ_BUF(4);
-		lock->lk_old_lock_seqid = be32_to_cpup(p++);
-	}
+	status = nfsd4_decode_locker4(argp, lock);
 
 	DECODE_TAIL;
 }
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index cc669d95c484..9b35ce50cf2b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -550,6 +550,27 @@ static inline bool xdr_item_is_present(const __be32 *p)
 	return *p != xdr_zero;
 }
 
+/**
+ * xdr_stream_decode_bool - Decode a boolean
+ * @xdr: pointer to xdr_stream
+ * @ptr: pointer to a u32 in which to store the result
+ *
+ * Return values:
+ *   %0 on success
+ *   %-EBADMSG on XDR buffer overflow
+ */
+static inline ssize_t
+xdr_stream_decode_bool(struct xdr_stream *xdr, __u32 *ptr)
+{
+	const size_t count = sizeof(*ptr);
+	__be32 *p = xdr_inline_decode(xdr, count);
+
+	if (unlikely(!p))
+		return -EBADMSG;
+	*ptr = (*p != xdr_zero);
+	return 0;
+}
+
 /**
  * xdr_stream_decode_u32 - Decode a 32-bit integer
  * @xdr: pointer to xdr_stream


