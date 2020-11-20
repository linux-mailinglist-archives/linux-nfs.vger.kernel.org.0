Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4B2BB736
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbgKTUgE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgKTUgD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:03 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C172C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:02 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so10219394qkb.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zRuQC2llKWA28mnYfcQi05tMxEKpw4RhZV1a8oqyizA=;
        b=Lnhkzm+4X3/ENN8XOvpuhJUwfkJ7HQqce/q4oEKDjc0BcottkFwg8FJR1MB8MW3b5g
         glFr03bJKXQBRmgj06KDjGaEygdzAphVzUUbIYAhnSZTuiChBlHWW24cHp/bWR16vWbv
         Q6cWjmZixSO7J5FW33SwiAYMG1LV85s+8WIItaC7gNjb4rdgHckljnjbax0hbEGaTXLw
         2MpOWfXDZKa2Ea5CRzKljujcNgDpheCHnr51xROZ+MUoV2/BQsJmbcG7F88MkONJS8G1
         P3XbBCzu182onJV5wlt7FWAIR0GKFhWjVNVcW/3Mi83MEf/2ZxZNaiXlYvAEiujPW5cH
         OCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zRuQC2llKWA28mnYfcQi05tMxEKpw4RhZV1a8oqyizA=;
        b=b6MF1H9q0vy1l/OmJZ4/J226htqAOoaDVx91gchNvX2CZ+csEpJE3MDtRSYr7pc899
         cxLh3MOP9DO25vWPoSWR0HITsAc6gEMB914LOmBBtDdYbvbka/vTfnnBp30+H0j4S4un
         vGjydQ5BJCCpAmHl3yqbSF4HnvGA9tqeb2AyFso+GepNwgGCTMTeToFkE0TkjJUN/RD5
         FeYm5AEcEGvHFoHQPd4tC3N6UT0VJmcjiuKvtYFCzwV0UlD4ZVxXkzoJ8HbzhPu10krP
         b3GgqvETAOdGuT3l/cYu0ft1dxb4HdHwabNl9tgi+R4Drlsi0swoEMmNA0Vaw8Q5D3XO
         tq7A==
X-Gm-Message-State: AOAM531BHA1c8WUw3Snb5xh+qEAhWazpLjPsCg3/O9gSKvflmapGlq6T
        omkQMUCFQVzaicOCbZPHLMmVdPEFh/4=
X-Google-Smtp-Source: ABdhPJzgOCvOm7FwBcxfaBL6dmvbCz73HBSuswOG5low9aVjYcomDYlSOWr0af3X3UsCs8/fpvtkKw==
X-Received: by 2002:a37:8c05:: with SMTP id o5mr18881209qkd.396.1605904560857;
        Fri, 20 Nov 2020 12:36:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r14sm2809332qtu.25.2020.11.20.12.36.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:00 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZxc6029277
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:59 GMT
Subject: [PATCH v2 025/118] NFSD: Add helper for decoding locker4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:59 -0500
Message-ID: <160590455932.1340.14843743077242511114.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index a7c9a0368951..94219ceb2ea2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -780,6 +780,48 @@ nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
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
@@ -795,27 +837,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 	lock->lk_reclaim = be32_to_cpup(p++);
 	p = xdr_decode_hyper(p, &lock->lk_offset);
 	p = xdr_decode_hyper(p, &lock->lk_length);
-	lock->lk_is_new = be32_to_cpup(p++);
-
-	if (lock->lk_is_new) {
-		READ_BUF(4);
-		lock->lk_new_open_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
-		if (status)
-			return status;
-		READ_BUF(4);
-		lock->lk_new_lock_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_state_owner4(argp, &lock->lk_new_clientid,
-						   &lock->lk_new_owner);
-		if (status)
-			return status;
-	} else {
-		status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
-		if (status)
-			return status;
-		READ_BUF(4);
-		lock->lk_old_lock_seqid = be32_to_cpup(p++);
-	}
+	status = nfsd4_decode_locker4(argp, lock);
 
 	DECODE_TAIL;
 }
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 22b00104bc1a..abd45f03634f 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -555,6 +555,27 @@ static inline bool xdr_item_is_present(const __be32 *p)
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


