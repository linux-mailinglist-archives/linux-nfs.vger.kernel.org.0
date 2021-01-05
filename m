Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC12EAE8F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbhAEPdt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbhAEPdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:49 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484CC061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:33:09 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a6so21088291qtw.6
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HbmW3W/7YjSYXC44ifqVRuh7T/TD+bsWwBPo6LaheKI=;
        b=RX6bFiuI2MyCmmDq0xzpUk7tsSraoXfU0+/yKnHM0zX7Di5S93b41QYdOml6Xpq8ne
         5MJPRgN2g7KK0Ilp9AMdIFfHpHtlruHjA/a4HFdqI4LbkcnM5PN60f3cOJdoK34hwvHA
         vHaYrCd3eDBxh+1BdFOuDvLho4DNNLGZ5nHB1RCL8AwohdNu160h7bi3LDPS1VPLOWz7
         ZEhHumimfxpXKAkyfxQg0X4FPzFVghNbhYo/inzFZ7XHE1DVDRiPNqFnng8vdHEEg8oQ
         udiRniNTZUdwvY6y2N1I/rxQuHZayOYlaXbp6PACOYLB2fgUU9SEuc+KfgH/61qc5KLY
         lLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HbmW3W/7YjSYXC44ifqVRuh7T/TD+bsWwBPo6LaheKI=;
        b=GUC6FaHN9XTpclIcVVhM2aP1djf9/nFsZ89CJWXmiz4BBeMNedB7muM+7a1nxCqLm9
         gdCOIyApierN/2WdGMazuW8duGm9/kbyJijAKQrIQUn2TMmUh5AElx+/R2/dFtQ29Bmo
         VdR14qXcPIA1Ps1a8e3QCnq3OZ0cqi7pDj9n/gSHfyVw1l4RFXCIHfT9G3t8KHMK1qCw
         hMUpBxrLZS0iEr7lqBwlRkz7daEp6aKJGxf8yuOxlajYxR7FD124/g5lVH/cHZv/JXY/
         cyWC7ZH+K71n2Rn1LQaKll3Dz2LZ9j9iGrAIzZgBXiEvpkeSYgkNVLffe8KKvI3CK9Yx
         GyGA==
X-Gm-Message-State: AOAM531XjUlpKaT0IrMQoZ6R4JgDaTHqQE7+WB/J/KGiQgHdivZiHlTs
        wNa/gm3eNV6NmOH5lIko/vQAYSul468=
X-Google-Smtp-Source: ABdhPJx68rZaoXqBqI6tBf7idF/dfaVYKdDEFaN/UiBvhy+naVXIwiL32whmQBJ+QEzQR+lgG1GAWA==
X-Received: by 2002:aed:208f:: with SMTP id 15mr63327qtb.290.1609860788120;
        Tue, 05 Jan 2021 07:33:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y10sm135101qkb.115.2021.01.05.07.33.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:33:07 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FX6xa020937
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:33:06 GMT
Subject: [PATCH v1 39/42] NFSD: Clean up after updating NFSv2 ACL decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:33:06 -0500
Message-ID: <160986078631.5532.3261748463317557658.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   18 ------------------
 fs/nfsd/xdr.h    |    1 -
 2 files changed, 19 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5ab9fc14816c..5d79ef6a0c7f 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -26,18 +26,6 @@ static u32	nfs_ftypes[] = {
  * Basic NFSv2 data types (RFC 1094 Section 2.3)
  */
 
-static __be32 *
-decode_fh(__be32 *p, struct svc_fh *fhp)
-{
-	fh_init(fhp, NFS_FHSIZE);
-	memcpy(&fhp->fh_handle.fh_base, p, NFS_FHSIZE);
-	fhp->fh_handle.fh_size = NFS_FHSIZE;
-
-	/* FIXME: Look up export pointer here and verify
-	 * Sun Secure RPC if requested */
-	return p + (NFS_FHSIZE >> 2);
-}
-
 /**
  * svcxdr_decode_fhandle - Decode an NFSv2 file handle
  * @xdr: XDR stream positioned at an encoded NFSv2 FH
@@ -62,12 +50,6 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
 	return true;
 }
 
-/* Helper function for NFSv2 ACL code */
-__be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp)
-{
-	return decode_fh(p, fhp);
-}
-
 static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 035c99c7b384..3018b52b6d5e 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -164,7 +164,6 @@ void nfssvc_release_readres(struct svc_rqst *rqstp);
 
 /* Helper functions for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);
-__be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp);
 bool svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp);
 
 #endif /* LINUX_NFSD_H */


