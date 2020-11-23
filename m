Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37C2C15C9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgKWUIa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgKWUIa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:30 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5FC061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:30 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z188so6818051qke.9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2hPYTwNS/Ywav1XEbM2c8+2miBjaZyYzbSMSWwDdPBc=;
        b=vGvNmUozL0DIfhC6dzpYbT0o9Lu3LzIPs2jKUaK/GM5thn9F/iHJUonZUQqj/lH3Bg
         tKBVCobgVmAgCZglhRGz+lkuJ3Hg7GIJY7NJRTpiSKuFW3bBOBjSlbEjmH0iyfYdVa6T
         L5C59cZ9MdMeav9Fn4L3N1OAhrCD93s2zPjpw2IVTKzllseIwT5p8Km4ktjsRgVrxd2u
         mY6NUv1xNBNAHYTnmOYMNE7ebalhcSVZ5u5ZDKUDaNIWAmMewm5Rae66tKzN47JbI+G2
         ngxI4+q6UguX/06PyXus5FS7Gqkfb7PQtkOTQwO2hmFHkO//05Vqxr8kxXbLB7jo23PK
         CgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2hPYTwNS/Ywav1XEbM2c8+2miBjaZyYzbSMSWwDdPBc=;
        b=A/I71ha+Km2XMEQccwETEVnsKN8CeqZo+7GoxPIaujL7BYerXspUNEpoRDWRDc9Bm+
         933NZ/4MDqp/fM0Av21gDjKqMKVLq8AITl8h9vLiCU9loA8rZsstQWjffHc7P8cmaoDm
         rHDYUSyvQt+aUCvRep01O/ud16rz1f950WSZNW4ESMAD6FhoKAYTl75IveF3FiVJvTrW
         x3m04u8FM1q8DeP8yFqSoskFF5WlDhIJ8GL8imODgfL78NqMP+A6tnahsTtzNxVvYcAs
         18++eZLYNz26n/pL9W3a451iksLrnMQ9WXYUO9rEpYC5jaoxXR66ec2UMsefIknzYVv6
         1Rgg==
X-Gm-Message-State: AOAM5333FyiRLj/qLxJb3w5ag30srZ4x1XOOCr9N/5TXzYgOWgRCUph4
        WTYELk359BmUrqzg5+xMHtuBfgqgJ6k=
X-Google-Smtp-Source: ABdhPJzDbejww2PTxsxkIJl0DxjGKRomA+RYZ7uRv6NacB6yFoxLoFMKPXcyfnyIaHOH36/o4XgdIw==
X-Received: by 2002:ae9:ea14:: with SMTP id f20mr1185331qkg.239.1606162109169;
        Mon, 23 Nov 2020 12:08:29 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l28sm9782986qkl.7.2020.11.23.12.08.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:28 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8RER010429
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:27 GMT
Subject: [PATCH v3 51/85] NFSD: Replace READ* macros in nfsd4_decode_write()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:27 -0500
Message-ID: <160616210749.51996.12880752418411320389.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d4497be2c583..226c37957556 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1396,22 +1396,23 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 static __be32
 nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &write->wr_stateid);
+	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
 	if (status)
 		return status;
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &write->wr_offset);
-	write->wr_stable_how = be32_to_cpup(p++);
+	if (xdr_stream_decode_u64(argp->xdr, &write->wr_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &write->wr_stable_how) < 0)
+		return nfserr_bad_xdr;
 	if (write->wr_stable_how > NFS_FILE_SYNC)
-		goto xdr_error;
-	write->wr_buflen = be32_to_cpup(p++);
-
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &write->wr_buflen) < 0)
+		return nfserr_bad_xdr;
 	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
-		goto xdr_error;
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


