Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0523F2C1614
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbgKWULC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgKWULC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:11:02 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A4C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:02 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so9467221qvy.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2RQb4Lm3ONR+NnOJ0hloeQG7iNuglTAlDV5e7dmPZxU=;
        b=cI+H17p7UAkgbd8Q3tpjZvjWl6vlVRFrCQ+219aienVnd/yRibsPzRUOY/FO88TzSn
         v38/vLy22iOXR2z0TVFhicipltRxnapmKiHZI22g/uFKsj9tzhOXsHbvAlAv9ILvTk7m
         vdd8TVqMLFdwHXAfcm5IciqoOrj9RE7/Vh/8GMeW5yGJharlGq/SzZEs81o1kU+CAjag
         F2UU8CrxueJo0+lOwX8kBP+YpqNVZAPbLRdR0KWyhcFlsnh2NbbT9JDZIwGjf7B8WJVF
         U25qrZHJE6ux3/eRl1XU8Z48iFMT0h8JpH7wV5X3SCcKhZymFa6uM+6FW4XPxz3oo/hw
         ktSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2RQb4Lm3ONR+NnOJ0hloeQG7iNuglTAlDV5e7dmPZxU=;
        b=LOEXiCGfoicAiHVm2H6NUVGdUKMG8rhT80O+GMXj5JN+jJEKpw7XIK8K/xMj5Fz/vi
         hqHZRJ8AqO/DpqW/HsZcxCs6vkWoWNOrPWMn7HPHj6Gky/1BpJMo8l4kT37aU1yRijkU
         jzjF9LEuw/cjqFVGR1SC9cPuOrDC4uKSoBknS+Njv1UeQfIquHoCm9QZkhBMa2UVYre/
         qEGxW4vMTaCLeY3wB+5pAyqjYfEYkHW8X3y2sSm8F2K2f4ykukO+2QMMAuNIZPf8gaAP
         rO2tUgft1rRbDz8TTraprw29hnCMFLcaWDDmaqV/M17u6MKMQdpa/4V5wJ2HnEQ8gomv
         tySg==
X-Gm-Message-State: AOAM533skPWvD8IE3P713yWl2tIuCzjctZC+5+obrGRbTxb6ullVPU8j
        HsQ/8ZiFiTM6zBsbaVPq+tuCCFmn/Fo=
X-Google-Smtp-Source: ABdhPJz3acAhECDcDemKrL0QHSlQRyYz0Qo7fQZRRwtqNUsv5hMraEfphVHX5/jc7rSlkfXvbUBqLw==
X-Received: by 2002:a0c:9d07:: with SMTP id m7mr1111438qvf.5.1606162261115;
        Mon, 23 Nov 2020 12:11:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h8sm6254141qka.117.2020.11.23.12.11.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:11:00 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAxCT010524
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:59 GMT
Subject: [PATCH v3 80/85] NFSD: Replace READ* macros in
 nfsd4_decode_xattr_name()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:59 -0500
Message-ID: <160616225970.51996.11211965596963744857.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 493168608815..90068c32a566 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2117,25 +2117,22 @@ nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
 static __be32
 nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 {
-	DECODE_HEAD;
 	char *name, *sp, *dp;
 	u32 namelen, cnt;
+	__be32 *p;
 
-	READ_BUF(4);
-	namelen = be32_to_cpup(p++);
-
+	if (xdr_stream_decode_u32(argp->xdr, &namelen) < 0)
+		return nfserr_bad_xdr;
 	if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
 		return nfserr_nametoolong;
-
 	if (namelen == 0)
-		goto xdr_error;
-
-	READ_BUF(namelen);
-
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, namelen);
+	if (!p)
+		return nfserr_bad_xdr;
 	name = svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + 1);
 	if (!name)
 		return nfserr_jukebox;
-
 	memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
 
 	/*
@@ -2148,14 +2145,14 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 
 	while (cnt-- > 0) {
 		if (*sp == '\0')
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		*dp++ = *sp++;
 	}
 	*dp = '\0';
 
 	*namep = name;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 /*


