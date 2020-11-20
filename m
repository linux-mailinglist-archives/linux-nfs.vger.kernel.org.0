Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF942BB781
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgKTUkj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgKTUki (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:38 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893AEC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:38 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id x13so5310175qvk.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JqV6vXrezmLuLaRTN7OB6qdkXyFh2UzBBqpznD0O0+g=;
        b=iLqqFYHeIJ9JRb6/vqKfL0X1P7TVoiozwanzpJV74Eq10aW7pInsKrbKCpL8Na17lq
         r4A7kWonxuHie/0cH4oVzO8y7tVtGN6FX0B/QRWhzqasUXl0nKUZb9UI+MYWTzI0NiOn
         7DyK0iphJgY4nhQMS1FKvsqD9DiYKbHLTkUyBPdkwIs1njO6iNcvlIamJV7LoG/7jE2V
         K+xK0umEMSi5h2Q/TCmh+dnj2hC/N2vBMAJLFzyydhA15gKyAEYJmMOqSgm/ih1rnrjX
         h7E2LyiAwx1UiI9ItNgJjzaXh88kUKCjrSqaA7TAQNm3YvGRK9Ji6174C3Jdem79lmdi
         ZDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JqV6vXrezmLuLaRTN7OB6qdkXyFh2UzBBqpznD0O0+g=;
        b=go3VMupftsK3+M7as3/sDMkoVgMw04jR+MRyv3MdjTSWTRTjpdQ6GpAIfwKlgZPZcx
         S97yAxpcrlr9+YoFH77BCjCMmDISotshVKbzYCSvozM8N5TOsrJkBOzrBb5B4GRv1956
         FWjMa1JIOnCRFqgdIW6acVqAreUWUbeiBuX9Yc25nBhaHfaVNpm0kWaxjO5CrSkDa/yU
         DvrXWo6bbqcP4hzroaWVyO4hiDSzwiltjLyVH97usN5p3Q7g/4+NM8Fr9xHmWd7JpZI4
         AgLADwVDY/YZiZOQyC41R38ApWXlVQ+7aL9a2fJGz5Ux1e5Dp44XDnuJQ+UKF6+aV0Vt
         UIHA==
X-Gm-Message-State: AOAM530V7NgV4g6/7KZPUPWC7hZkLmckhdpcFZtO/BDRefGCgrw7ftvp
        Sqm/zCe58EJDHuCl/PZiaXOXYf5TSeY=
X-Google-Smtp-Source: ABdhPJzJ6T0pwGZhmULn0hWKAOar9vUqr/S3THLLZFXjFe2Ysn+l3dN1jryVxdL2zzt9XqTEtfypPw==
X-Received: by 2002:a0c:be02:: with SMTP id k2mr16673963qvg.49.1605904837482;
        Fri, 20 Nov 2020 12:40:37 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z11sm2631963qkz.38.2020.11.20.12.40.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:36 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKeZWK029444
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:35 GMT
Subject: [PATCH v2 077/118] NFSD: Replace READ* macros in
 nfsd4_decode_setxattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:35 -0500
Message-ID: <160590483568.1340.3137629344040051927.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e1f8de971c0a..6c471fa1fae3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2136,11 +2136,11 @@ static __be32
 nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 		      struct nfsd4_setxattr *setxattr)
 {
-	DECODE_HEAD;
 	u32 flags, maxcount, size;
+	__be32 status;
 
-	READ_BUF(4);
-	flags = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &flags) < 0)
+		return nfserr_bad_xdr;
 
 	if (flags > SETXATTR4_REPLACE)
 		return nfserr_inval;
@@ -2153,8 +2153,8 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 	maxcount = svc_max_payload(argp->rqstp);
 	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
 
-	READ_BUF(4);
-	size = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &size) < 0)
+		return nfserr_bad_xdr;
 	if (size > maxcount)
 		return nfserr_xattr2big;
 
@@ -2163,12 +2163,12 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 		struct xdr_buf payload;
 
 		if (!xdr_stream_subsegment(argp->xdr, &payload, size))
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		status = nfsd4_vbuf_from_vector(argp, &payload,
 						&setxattr->setxa_buf, size);
 	}
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


