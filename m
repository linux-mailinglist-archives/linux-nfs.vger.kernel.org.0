Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9D2C159F
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgKWUFV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgKWUFU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:20 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:20 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id u23so9449619qvf.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7hF7ieFqsu6i+8+NfU/CsHEiy5OAg+2MqRJKJJ2UjAg=;
        b=IfOEOmglsyZ6zfPGSfv03wTnh4cDNXV6dFeJr+hnbJ6nNZbmDSVAjQncFugI5QSb/a
         9EbwHk9ho4GpeQgUl+R8B8aOLezigKI+IqtSC9jizwhXIFSVCLm3Lt9Lww9+n6JAwUTM
         LlgJiIXy+QPWmtVPxCTmos2VfAZxBsGifv//2J8uJHlFWKBZHZZ8Y/WHyIIGglFF89Ty
         W2HI32dVbc0ckpyLWy/ee7njrLQO5EfQHrLLBV2b5WSdlLQEVTnqB1okHJ7MYqVmNvOX
         BH0AVxekJdnQYnEbJtZu2QLc0BasmMTF+oYsAQiYulTbMpu2t45RPY2BzgE8lQBSg+0N
         iHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7hF7ieFqsu6i+8+NfU/CsHEiy5OAg+2MqRJKJJ2UjAg=;
        b=d2DCVKokkVT1NXhIi39ytW1pgj/8qcU+plWGN2SYOMDWfZKgiR5OJ5kJIrh390bRFx
         lqf28tmXZ6otOwcF7umBy4LvELoQGyMtQ6yT6B0f37CxKYZMn55tGYElwQqCZ1kMQe/b
         esYs6HfrK5l10XzmuhovTnI2ZGF2SCCyHgsXMX6JtZuhqGadx3vIBJAA/Ce1qf29m/x1
         HTN+DdoCuWZAcD7LyIDdBoVLcs4kh9C4UY3CR5abyBakWgzAEUvOPKximINOXa/WYPWQ
         rSJ2OJGoHDYLH9ma4EWvafR7xlcb+l/hJ/0BfrLFoqKRUeAGL8uFFNGHLbLOkXNQY1DW
         a0WQ==
X-Gm-Message-State: AOAM532fl6Z9Y9gTLzJBBUkqG6QwssTroYhha4oEOdCMPdH/cywg4vLv
        13phwbJulf7thXjqI7DCY54X+80oYfQ=
X-Google-Smtp-Source: ABdhPJzlw0FugNX7GmdZ/bflHa0G2x+2NCzZsS3tUGbgloN/ttvoPHI783PJ5/yN4ZDzRmbKCSP8AQ==
X-Received: by 2002:a0c:abc8:: with SMTP id k8mr1202498qvb.14.1606161919695;
        Mon, 23 Nov 2020 12:05:19 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g4sm10354843qtu.82.2020.11.23.12.05.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5ICK010313
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:18 GMT
Subject: [PATCH v3 15/85] NFSD: Replace READ* macros that decode the fattr4
 owner_group attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:18 -0500
Message-ID: <160616191805.51996.10833465502263704335.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0b46cb9e3867..e5f73bfc79dc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -374,11 +374,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_UID;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_gid(argp->rqstp, buf, dummy32, &iattr->ia_gid)))
+		u32 length;
+
+		if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+			return nfserr_bad_xdr;
+		p = xdr_inline_decode(argp->xdr, length);
+		if (!p)
+			return nfserr_bad_xdr;
+		status = nfsd_map_name_to_gid(argp->rqstp, (char *)p, length,
+					      &iattr->ia_gid);
+		if (status)
 			return status;
 		iattr->ia_valid |= ATTR_GID;
 	}


