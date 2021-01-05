Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10D2EAE7F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbhAEPdD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbhAEPdD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:03 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10906C061798
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:48 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id f26so26835123qka.0
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Qx5XLzqsdqZoy2l1sbxft7U1zWtg0T+upqt17SH16Xs=;
        b=a1TCMQvSJP5dRuIjQyJWEbTstogXr+mO7kpckdpd5Loa4C/v3Qnck5sxetjzRJwfLk
         30dWVjf4s5JODCrf9MbVR7ybJ58syzcGW4JlU4WNYEopSOTZ+d4Wp2SOT0mQfFZtGfOq
         A54xiuxzL/XsZygnLH3BVQof9IJnbx8pbCDA+B2sNnOVrZfYeH5rRJOiuhwweb2yYcI7
         V1EBFIAx5s2+j7O9In0XwIDVe7c10L7Owo2xT2eGoJ+WM60ntMQDZs24WyKVabW3RqEx
         5we0qUN82MIqiR/Xv1b0W6pVcCA/3Z+1XfR0F7+WDDyTgSKLh/t4CXkSYqFTQhZFHeNW
         yxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Qx5XLzqsdqZoy2l1sbxft7U1zWtg0T+upqt17SH16Xs=;
        b=HEwDKxURsUwPFe74ZqtGoaC8g+lMScVCuNOPMRyUUN8zLYf/51+Qj1ZCfy2hMAIlNh
         v+8JIQBiCPWvtlRkVbapoPF32qPLFwTzH5XTZ1k5imCFbDt/dNP+i6HDWmWmP0Q8tD+q
         q8do4cFTle4QFS1FJESsrgS4yzF34qU/gK2o+I2z2DJ6Z3to+ODS5AEy6G0z8fZHrV6b
         wxu6/4o5OfSkR4o9gDd9sOCtsQiMPgZkHhvOjZ6+hIDAhClX/8yp9y6cL6bX19bt8uwp
         mQ5LzHyzHDQA6ZdH8u3cMKtM95OTZKmML8zqTz7xcPVudU08Wnu6JINDlfsgWL63Dp0R
         Cktg==
X-Gm-Message-State: AOAM533/G0PHhMkTMi46HcvKkCN21BzBpHg99n4iiLYeg4pprtuCNeBq
        +f3qQ4Yz4g/U213//OTNj0oRy4LVGgc=
X-Google-Smtp-Source: ABdhPJy1RNTxv14vtQ4LGS33xcTujlnmBn6n1skQN4M8SuyaYQehLxeFzvpJMxoulebOnWCKabalYw==
X-Received: by 2002:a37:a8a:: with SMTP id 132mr15832qkk.327.1609860766997;
        Tue, 05 Jan 2021 07:32:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e10sm19389qtr.92.2021.01.05.07.32.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:46 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWjkY020925
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:45 GMT
Subject: [PATCH v1 35/42] NFSD: Add an xdr_stream-based decoder for NFSv2/3
 ACLs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:45 -0500
Message-ID: <160986076534.5532.16229382857405416474.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs_common/nfsacl.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfsacl.h |    3 +++
 2 files changed, 55 insertions(+)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index d056ad2fdefd..79c563c1a5e8 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -295,3 +295,55 @@ int nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
 		   nfsacl_desc.desc.array_len;
 }
 EXPORT_SYMBOL_GPL(nfsacl_decode);
+
+/**
+ * nfs_stream_decode_acl - Decode an NFSv3 ACL
+ *
+ * @xdr: an xdr_stream positioned at an encoded ACL
+ * @aclcnt: OUT: count of ACEs in decoded posix_acl
+ * @pacl: OUT: a dynamically-allocated buffer containing the decoded posix_acl
+ *
+ * Return values:
+ *   %false: The encoded ACL is not valid
+ *   %true: @pacl contains a decoded ACL, and @xdr is advanced
+ *
+ * On a successful return, caller must release *pacl using posix_acl_release().
+ */
+bool nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
+			   struct posix_acl **pacl)
+{
+	const size_t elem_size = XDR_UNIT * 3;
+	struct nfsacl_decode_desc nfsacl_desc = {
+		.desc = {
+			.elem_size = elem_size,
+			.xcode = pacl ? xdr_nfsace_decode : NULL,
+		},
+	};
+	unsigned int base;
+	u32 entries;
+
+	if (xdr_stream_decode_u32(xdr, &entries) < 0)
+		return false;
+	if (entries > NFS_ACL_MAX_ENTRIES)
+		return false;
+
+	base = xdr_stream_pos(xdr);
+	if (!xdr_inline_decode(xdr, XDR_UNIT + elem_size * entries))
+		return false;
+	nfsacl_desc.desc.array_maxlen = entries;
+	if (xdr_decode_array2(xdr->buf, base, &nfsacl_desc.desc))
+		return false;
+
+	if (pacl) {
+		if (entries != nfsacl_desc.desc.array_len ||
+		    posix_acl_from_nfsacl(nfsacl_desc.acl) != 0) {
+			posix_acl_release(nfsacl_desc.acl);
+			return false;
+		}
+		*pacl = nfsacl_desc.acl;
+	}
+	if (aclcnt)
+		*aclcnt = entries;
+	return true;
+}
+EXPORT_SYMBOL_GPL(nfs_stream_decode_acl);
diff --git a/include/linux/nfsacl.h b/include/linux/nfsacl.h
index 103d44695323..0ba99c513649 100644
--- a/include/linux/nfsacl.h
+++ b/include/linux/nfsacl.h
@@ -38,5 +38,8 @@ nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
 extern int
 nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
 	      struct posix_acl **pacl);
+extern bool
+nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
+		      struct posix_acl **pacl);
 
 #endif  /* __LINUX_NFSACL_H */


