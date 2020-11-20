Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DBD2BB7C0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgKTUoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgKTUoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:44:17 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6AC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:17 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z3so8105914qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VR+1b+4gZzerr40L7/MLry9hbw6sg4pYhZDwaZeAW/I=;
        b=rtdSGb+CU3yPvw12oPO0b/JK88n7G8WPxl+XS4C+ZHs0XnbNvyudtpCAG27UkCJmDb
         TFbgz+TCsrOGPsdNkoWKRsT8JX7MEhim/flPvzeZIBjdMSHXsUfOJzyZqbPATYgMkbSE
         XwzkPTAwkOwwTC0Wy5rBk1/4FHSSQIkyfYJlPLfr531Rf+5qPDio+mk99+ayho/zC4vJ
         SyK5jrvgCcni6lHrZNWtgZ1DaODtFsQEwYIT4M2quYZTpxz6flYo298UnQ1xiFswsnaR
         OAcp+j2MJozf2MS0Sf48CMK84IpHVB+H/LarHLoVJ1KwdlaxcNvH0YADUhIO0p1t9hkH
         oQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=VR+1b+4gZzerr40L7/MLry9hbw6sg4pYhZDwaZeAW/I=;
        b=aSE5X4PzmxEQKzaORv/qS8Y4XUvkbwimDnLD1U0zMRelIXBkmxYNODxfOgk8qKVh75
         xmMbgqdmFhateKBTfGOjejTzpxpmBWewSN2fLu4Iub/k9WmzItQXC/LEFLbEThZmVCJx
         oVdVjG1Ic/GQIEk/b1mEpMdkEv2Eg/AdL/QIFH9bjIsGtne+DSbPrtmU+K3MRK3/y40W
         EOmzMF2AQsTZZbtCVQF4r7DfCTXd/f78OAIdGYRUaokQjgiSheSjZPwhYethmgE0QEa/
         c4MScX5bPf8BkCU4zmJ8SBzybUPmEwpraRuIunQ5U3JPcB6wfRUcOnFjdYoLO7go11OK
         aG5w==
X-Gm-Message-State: AOAM533KLuPfYOjfAUaLTkj1xXbJJc1HIyGzgzSyTGzPXV4EBVhlj+Ma
        guugpZEqEZkN2CuNTgdSSe+9LDfY4B0=
X-Google-Smtp-Source: ABdhPJweqjp2u/wn8qigGXiCA4KhPhGtNqZ019kt8T/NEhbL7MfpmAI9XPp1u8+v98OH5HKmht7MFg==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr16792803qtw.94.1605905056461;
        Fri, 20 Nov 2020 12:44:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i12sm2685280qtr.56.2020.11.20.12.44.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:44:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKiEbt029569
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:44:14 GMT
Subject: [PATCH v2 118/118] NFSD: Clean up after updating NFSv3 ACL decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:44:14 -0500
Message-ID: <160590505475.1340.18047353388317226285.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   20 --------------------
 fs/nfsd/xdr3.h    |    1 -
 2 files changed, 21 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 091baf06c494..6ed396f50a76 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -82,26 +82,6 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 	return XDR_DECODE_DONE;
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
index 1fd5328d867a..59027a9244fb 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -307,7 +307,6 @@ int nfs3svc_encode_entry_plus(void *, const char *name,
 /* Helper functions for NFSv3 ACL code */
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);
-__be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp);
 enum xdr_decode_result
 svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp);
 


