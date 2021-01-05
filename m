Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99B52EAE8B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbhAEPdk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAEPdk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:40 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3156CC061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:33:25 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a4so14788462qvd.12
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jFDcHPeUzcjs9y3sBQWD0TZmsBPaSp+m+XjxZ668Eqk=;
        b=uwFYw0W0zqTTFZGW2D2h5uLr41fETfWJvTX3WKZIiv2LTTilKhoX7FSqA83uklLKsE
         38TDCj6f6AoH802dOmR8koK5kf0iQ1Dh6I5zFZimRipyRChHu68zK2yuxv8WZXc/umx9
         FC0mHx9rFrg6GPL8L5ihUVYXyFkVOEYCS6X6nCXlRbSZ4zuXwt4+PBhlHry+bjkpcwc2
         DZh4oTheXGUz+l04HaxXO8DtQ7tCuE80YgZnZej7Myeo0pFE5l7IQIco7SbtkWB8RNz6
         /n17xZjoLlNEGuUlZaN/irTbC1gfLRvl9kekdJgbIHJXuK1Mf5KyoXERdLeubzmCinc2
         n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jFDcHPeUzcjs9y3sBQWD0TZmsBPaSp+m+XjxZ668Eqk=;
        b=NYwe0ZLKA08vxdSnqwfv3NmIcMi7dsMfUXhUkcYa9vqxiqFA4ymivMcoNHM1BnGdqO
         kHatVzSnIB3bTc6/cGH0W35yiPP1f8zJ1lZfzwhWQQok1kLhpqYJlDmYinXV/RIQ2Ir6
         EstXLpfpS/UGYyBMN1yTWTd84rAOFpmLg25Z6k4sgvgthAjuY7UNjbCJNLfL+8kw9a5l
         COTgNFP//UlWGLaEygx2tqD9giZ+UedOuky8D0WuErwVRpjqSDtK3cOzNg1JPg+Zkzdc
         uBX6YfMon+WRJJqEr8xhP+WahbmDUGs1z4+3uLYZ9dyqM8/llkNVa24EQ2GRWqjqqL8+
         mmbw==
X-Gm-Message-State: AOAM531TXZsFVeq9VbLhyAOeLEXlCDjJ2z3p20LePHtrP2P6fqWD0gsS
        mJLUSDddSI3PmkJCuDhD1hUNEtazb/o=
X-Google-Smtp-Source: ABdhPJx66FLOnr7hRBbNf5TbQ/LvagUsMUGY34egnsy8uHFykPYJV6N8OBG11RMjyHKeXK5fsZh5Dg==
X-Received: by 2002:a0c:b797:: with SMTP id l23mr65169qve.42.1609860804128;
        Tue, 05 Jan 2021 07:33:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u5sm135575qkb.120.2021.01.05.07.33.23
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:33:23 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FXMxY020946
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:33:22 GMT
Subject: [PATCH v1 42/42] NFSD: Clean up after updating NFSv3 ACL decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:33:22 -0500
Message-ID: <160986080235.5532.572599583334345770.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   20 --------------------
 fs/nfsd/xdr3.h    |    2 --
 2 files changed, 22 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 4be38599f331..023f310ba488 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -82,26 +82,6 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 	return true;
 }
 
-static __be32 *
-decode_fh(__be32 *p, struct svc_fh *fhp)
-{
-	unsigned int size;
-	fh_init(fhp, NFS3_FHSIZE);
-	size = ntohl(*p++);
-	if (size > NFS3_FHSIZE)
-		return NULL;
-
-	memcpy(&fhp->fh_handle.fh_base, p, size);
-	fhp->fh_handle.fh_size = size;
-	return p + XDR_QUADLEN(size);
-}
-
-/* Helper function for NFSv3 ACL code */
-__be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp)
-{
-	return decode_fh(p, fhp);
-}
-
 static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 7456aee74f3d..3e1578953f54 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -307,8 +307,6 @@ int nfs3svc_encode_entry_plus(void *, const char *name,
 /* Helper functions for NFSv3 ACL code */
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);
-__be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp);
 bool svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp);
 
-
 #endif /* _LINUX_NFSD_XDR3_H */


