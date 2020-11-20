Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C982BB7B9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgKTUnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgKTUnj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:39 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8905FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:39 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so8151274qtj.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0muUFbr51AcV9lsONUVhq8M7yIVUAZabR0JRQBIklPQ=;
        b=dxulIbCTzOMY+4kRaYrfaZRWbSauxPdEMB0j1kPmXTKGoKP4YU/Q3IS7bkf1imHzxw
         u+rGXac30rDTG1EVg3MXfooV91OFAKifv6yxvoTbyu251ngRuDezNySs8Sab1AwjihYD
         EpIi6e2F8aEG4B5YUck4ipqRQW05lCXjikq/pIXDBC9JMwFnJ2Nt6nix0VF6+6ZgERl8
         FpA+xaAwvOAFKGAbqUWgAIeiMlTjLieUffC5gahIvs8bV2k79cq2KdKBTyHL8j+nLmyq
         cw7KzUV2dJBgm4X8VBi/Z2YBwF/seEBiqEa4Yj6VZbzVKR9gyBdzgYx34fK+YlIqca/A
         z/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0muUFbr51AcV9lsONUVhq8M7yIVUAZabR0JRQBIklPQ=;
        b=m4Fm1imGItHvpJDlTKghRnJ63f8ljcFhUH6q93R56GumLcQTcSW2WKhH+NnCUWRQeY
         ETsqZCe3HMtfXBBlKDxhZDsamtWpQxVruHHggbCQIiroxkyS/rSgj3aTIkpIko9ZKVa+
         TNB3HpwgnGXcfyexRZK2rxP/EGoZ9BoQ/drudjVV7w6q8KmUMKcayd2ey0/CQN+khGaE
         yObIUBJqfDoUTdzuos2qcUzCdeW/8RDmUJEq0B9Kh5aVhsnDnaf1FGhSTOiLN8YCjLP+
         D0Tw93VBa+7QBj0vAbgsQXnOKDukjyeFMsxkQYQLUkuDrjQkrfXBsDow51DvRXOZjHvl
         lAIQ==
X-Gm-Message-State: AOAM532h8ux+qTcBr6H0zzOGilyViXoGyBlbufzE2ybMa35j6vxMMjaD
        BW+2KvXcjtRXjOpuAJ/fY4Py/kV+o0c=
X-Google-Smtp-Source: ABdhPJzneErqKDfDFhcpjPuzNSnpCVuwScX0DGOqajVSh1RbkzwiSPWKEa7LRjVjvrXjayCj+E234w==
X-Received: by 2002:aed:2be3:: with SMTP id e90mr17777669qtd.127.1605905018468;
        Fri, 20 Nov 2020 12:43:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f14sm2654912qkk.89.2020.11.20.12.43.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:37 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhavW029547
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:36 GMT
Subject: [PATCH v2 111/118] NFSD: Add an xdr_stream-based decoder for NFSv2/3
 ACLs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:36 -0500
Message-ID: <160590501674.1340.17812051346945067469.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs_common/nfsacl.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfsacl.h |    3 +++
 2 files changed, 56 insertions(+)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index d056ad2fdefd..e2ec0f241a4f 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -295,3 +295,56 @@ int nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
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
+ *   %XDR_DECODE_FAILED: The encoded ACL is not valid
+ *   %XDR_DECODE_DONE: @pacl contains a decoded ACL, and @xdr is advanced
+ *
+ * On a successful return, caller must release *pacl using posix_acl_release().
+ */
+enum xdr_decode_result
+nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
+		      struct posix_acl **pacl)
+{
+	const size_t elem_size = sizeof(__be32) * 3;
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
+		return XDR_DECODE_FAILED;
+	if (entries > NFS_ACL_MAX_ENTRIES)
+		return XDR_DECODE_FAILED;
+
+	base = xdr_stream_pos(xdr);
+	if (!xdr_inline_decode(xdr, sizeof(__be32) + elem_size * entries))
+		return XDR_DECODE_FAILED;
+	nfsacl_desc.desc.array_maxlen = entries;
+	if (xdr_decode_array2(xdr->buf, base, &nfsacl_desc.desc))
+		return XDR_DECODE_FAILED;
+
+	if (pacl) {
+		if (entries != nfsacl_desc.desc.array_len ||
+		    posix_acl_from_nfsacl(nfsacl_desc.acl) != 0) {
+			posix_acl_release(nfsacl_desc.acl);
+			return XDR_DECODE_FAILED;
+		}
+		*pacl = nfsacl_desc.acl;
+	}
+	if (aclcnt)
+		*aclcnt = entries;
+	return XDR_DECODE_DONE;
+}
+EXPORT_SYMBOL_GPL(nfs_stream_decode_acl);
diff --git a/include/linux/nfsacl.h b/include/linux/nfsacl.h
index 103d44695323..434471cc4b62 100644
--- a/include/linux/nfsacl.h
+++ b/include/linux/nfsacl.h
@@ -38,5 +38,8 @@ nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
 extern int
 nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
 	      struct posix_acl **pacl);
+extern enum xdr_decode_result
+nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
+		      struct posix_acl **pacl);
 
 #endif  /* __LINUX_NFSACL_H */


