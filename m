Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F9C2BB76C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgKTUjU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgKTUjU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:20 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1924C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:18 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f15so4615295qto.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GYVthZSprqOe/r4UqZp7VHPUMhkUJ2WpLAF5voFcnfA=;
        b=d7YTcPNMtJQUaqhKvjsBL4v5y557YAc/zrVKT+WZIYRTcNm35wS2XHpUtbyUVYBA5A
         Z/HE9IzKm6nfnkO4+Ef8Xm7/SasKUQBTVVB/htpOLrYqyV4g9JctO87FrmI0X9w5DC07
         5+6zmjiewg+uK8zkCYN1WZ4wnHswESpBU1rNGxDSMDdm4aTBEejW27ay5UuPscvprj96
         77ycO+pHZWGPP4aLH178PHQEPBMuvewTp20EJXhydKZ2de/+/CNKHcddmoBvTWIqvzGx
         x62U3I8v/JQKd/XUggoNr9ArzTIHs/WcwoXYG206ulAboGqqXYhASmTtoeiJKjwfrCwB
         Ibtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GYVthZSprqOe/r4UqZp7VHPUMhkUJ2WpLAF5voFcnfA=;
        b=FbIt1FUn05c346NFmo3nfesfX9FJCaYg+sIJwqFAzIkVPaVzPbqYiTCHT97pQ14qjL
         fe4rJR0k3SO7cvEuR1UEVN8P00HWVPsw1NBHYtuKJw6tyXmHF1e7PhX7142F4b3CIDLL
         y7R/5xCdg6izFaih7oqAlOHjREOoOXuCc323eGSsBn+Zo990spOVscW4l0xzGWKPfDg9
         UyyZPBG6qmY8+aDbbSFwV3SHpDdn1ann3j71wqx6p0NAs0sM3D6L87gDFjwxdRhhjU1y
         MxfpdZOTAGKh7MBwBoqKX/Pa77peLm7BLfCvlP1IRDp1jtJ9L6CLAMMfDtQ2AjOvM1yY
         S7YQ==
X-Gm-Message-State: AOAM533MlVmSopq8olQnn+d7dYdtuo/iyIkI54hNZtff+hzxRMYU/m9J
        3ukKBI2C2wBRVm/5d6pVfaP6ftK8pac=
X-Google-Smtp-Source: ABdhPJzURy4UkLgAOHGBJmBTc4banyXEyRDt3ccLBxXDxTYfSRUF7plTvCUov3TJ9QoPzEl2lNFcHg==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr17674329qte.385.1605904757679;
        Fri, 20 Nov 2020 12:39:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r19sm2693407qtm.4.2020.11.20.12.39.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:17 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdGlQ029389
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:16 GMT
Subject: [PATCH v2 062/118] NFSD: Replace READ* macros in
 nfsd4_decode_getdeviceinfo()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:16 -0500
Message-ID: <160590475599.1340.3473334728686022951.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1fb79a597b47..04dfb578bec8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -583,6 +583,21 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	return nfs_ok;
 }
 
+#ifdef CONFIG_NFSD_PNFS
+static __be32
+nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
+		       struct nfsd4_deviceid *devid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
+	if (!p)
+		return nfserr_bad_xdr;
+	memcpy(devid, p, sizeof(*devid));
+	return nfs_ok;
+}
+#endif /* CONFIG_NFSD_PNFS */
+
 static __be32
 nfsd4_decode_sessionid(struct nfsd4_compoundargs *argp,
 		       struct nfs4_sessionid *sessionid)
@@ -1706,27 +1721,20 @@ static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 		struct nfsd4_getdeviceinfo *gdev)
 {
-	DECODE_HEAD;
-	u32 num, i;
-
-	READ_BUF(sizeof(struct nfsd4_deviceid) + 3 * 4);
-	COPYMEM(&gdev->gd_devid, sizeof(struct nfsd4_deviceid));
-	gdev->gd_layout_type = be32_to_cpup(p++);
-	gdev->gd_maxcount = be32_to_cpup(p++);
-	num = be32_to_cpup(p++);
-	if (num) {
-		if (num > 1000)
-			goto xdr_error;
-		READ_BUF(4 * num);
-		gdev->gd_notify_types = be32_to_cpup(p++);
-		for (i = 1; i < num; i++) {
-			if (be32_to_cpup(p++)) {
-				status = nfserr_inval;
-				goto out;
-			}
-		}
-	}
-	DECODE_TAIL;
+	__be32 status;
+
+	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_maxcount) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_uint32_array(argp->xdr,
+					   &gdev->gd_notify_types, 1) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
 }
 
 static __be32


