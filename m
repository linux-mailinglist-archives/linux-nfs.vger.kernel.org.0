Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A42B1E3A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgKMPHc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKMPHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:31 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7490AC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:31 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id y11so4693240qvu.10
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5LxcTAe+cqw6aJ09UwYt+0J6QbAh8KbhTavE5bIbLOc=;
        b=fY609x158s5NFgIp1Y01q4VHppOCWOOzgz4XYDdZX5rYyPDJxMGAWuubSG01sCN7we
         egnr0b3GAOz3W62cNC4arUsO+MLtmMCEB33WhDrMhWJRhXgPMSIDDosQ1AD6StVgGBTC
         uocBPpZ0wZkhTQjy7yipfYgQ3yPKcv5+HOWPZBL6D/iflUldfV2GXNgKlhYC//x+KmxF
         XDcfF85nhKqhOqbIBZpBdRO2DmHkZWQCSGK4+gqe36ylsxNTO8PKLTii38i63BQ6cjsI
         d7DOb1rrIDg2XiL0xbjPr7qb3gevaxG16OgudyWHDxb9An/J89AC2qMxeZnjm60/qFwU
         ayUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5LxcTAe+cqw6aJ09UwYt+0J6QbAh8KbhTavE5bIbLOc=;
        b=pcDJIrjPmUY85AmyuiMkVr8ITpxnM9wZ9IrLJ3bI1haUSSD8CdBY/hvo5AmTr2fTe/
         4crkuXzzUL4CiHz32WXpB1vdbTWn4i/Z0SFihz3S7HlR8hGByH7dYU1Ci5FWXBqqjlni
         i7AG+uMaArsk9Rzy9hJ+dHW466L8uIVT0r2PbSaxQ/CW+2YpMS7SWYcMAI+mKuV6+YAG
         BWYCHERizP/LP2h02bwcEJYIjy59pYQo7VJlpimb4wEU5/UW4ZXNqq+nGmh5AS5jIh/x
         Musmb6xK5wmrtsfYk20mi6d+mcXltiYkrEfXXyHh03aOomYkZQLaeT1FB9Nbx9ngPJys
         NEug==
X-Gm-Message-State: AOAM531LQiecEQ4hQjP8AzZm75PlZENnis/O/z2EHjJGpibQ52Zk3NJR
        BXcUevlYu5D1HBk+nFl7tvUcI3ImcDk=
X-Google-Smtp-Source: ABdhPJxd7UaH/a0gEZkiwmXvi58BZ6l44qhEqXKgnKmWoarRP3PO+GZ5Re6MRn2zNMZQNI/2svvilA==
X-Received: by 2002:a0c:9004:: with SMTP id o4mr2818900qvo.17.1605280050384;
        Fri, 13 Nov 2020 07:07:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d16sm6966745qkc.58.2020.11.13.07.07.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:29 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7Ss2000343
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:28 GMT
Subject: [PATCH v1 58/61] NFSD: Replace READ* macros in
 nfsd4_decode_setxattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:28 -0500
Message-ID: <160528004877.6186.2667946875923803861.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 12b90251fbf5..760aac341fab 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2261,25 +2261,25 @@ static __be32
 nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 		      struct nfsd4_setxattr *setxattr)
 {
-	DECODE_HEAD;
 	u32 flags, maxcount, size;
+	__be32 status;
 
-	READ_BUF(4);
-	flags = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &flags) < 0)
+		goto xdr_error;
 
 	if (flags > SETXATTR4_REPLACE)
-		return nfserr_inval;
+		goto inval_arg;
 	setxattr->setxa_flags = flags;
 
 	status = nfsd4_decode_xattr_name(argp, &setxattr->setxa_name);
 	if (status)
-		return status;
+		goto out;
 
 	maxcount = svc_max_payload(argp->rqstp);
 	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
 
-	READ_BUF(4);
-	size = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &size) < 0)
+		goto xdr_error;
 	if (size > maxcount)
 		return nfserr_xattr2big;
 
@@ -2293,7 +2293,13 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 						&setxattr->setxa_buf, size);
 	}
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+inval_arg:
+	return nfserr_inval;
 }
 
 static __be32


