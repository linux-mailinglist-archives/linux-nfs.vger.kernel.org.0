Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7E2BB7BD
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgKTUoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgKTUoB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:44:01 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59470C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:01 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id a15so5328489qvk.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=666AyFq1D9qQYerIxAMAAzfbK+WmtUzArwF1B2EFKsQ=;
        b=PqfJISTf/zFP2GE+o6yH//8h1/gt9z3ol7767PG4NnaSB3L5o7uq9bYLYzLVOrRo4k
         Q3QEJADPbujRySSEHZSOdnBXla0Umql1Jy4hKMI5vY2Liax+R25E/2ZFwagE1aevgGqi
         SwPPDLLjVc6tdePotNNNEGjVcH00Po5n1ueHOH3IG+9daPrLIT12ZFzcPFEZMuATI1em
         5Fwb2z4855FgB1HFxQiXKghFZi5muTWIUJDsnbPhEQiUkVigGCEmqPka8qJwmyN+yn7N
         SufSrPMWvw6+ZsDEmN+cP6ye60nCCphfxk+/1TP+2k1u6QXY1Z3GAU+131ni0NN8z8ft
         aX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=666AyFq1D9qQYerIxAMAAzfbK+WmtUzArwF1B2EFKsQ=;
        b=QFvTu9z4yStLUrDNh2rYNhrzw4rNy/2vr3Y9BTa8O7J69YV8JBUpnucJ4EmO/1VzTj
         ptLBFgR/i3GLwg+Qrtv6YSVbGIE48y+YnCR1I08ZY/cKuz8lZ1ZC+IdCjZfkj8SHhp1X
         y5qNByzFnLvBr3/Z4H8qIM8n+HjI71rKkmhtqDQEmnUuZo+aMHvOr7UQ/IO0Bt/MXmFF
         RZ2feFf/A+ej0sFm06HLBfiRrjbNI2ue33LJ6/yLFi05PMDp81n/F+DQrp8ViHlMC9F1
         xuVySGMDH9REzeoRxFgNNMF1fi1lTtgRTcmGN6Hoyq0ACQ7gLCSYlOOJlGbjHoZYkwra
         maYA==
X-Gm-Message-State: AOAM533nOALYZulSkpQd/Q1Lj1ysq78TSLbWp8Y25WPR/gQ5Qc2CwJqc
        MqrzTU7rvVH/QTO8PDB1EpMoRI/UzSA=
X-Google-Smtp-Source: ABdhPJy+P98OBIn5QNsr7ErGc1bMiIYA6CJ871jRN+veFB/CzY6E9Ls78wb2puuqWGPc/+pzEkuDYg==
X-Received: by 2002:a05:6214:9c4:: with SMTP id dp4mr17230054qvb.44.1605905040222;
        Fri, 20 Nov 2020 12:44:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s3sm2799872qtd.49.2020.11.20.12.43.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:59 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhwHI029559
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:58 GMT
Subject: [PATCH v2 115/118] NFSD: Clean up after updating NFSv2 ACL decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:58 -0500
Message-ID: <160590503846.1340.1600484363253541165.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   18 ------------------
 fs/nfsd/xdr.h    |    1 -
 2 files changed, 19 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index efa2760316eb..416a53d4be16 100644
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
 	return XDR_DECODE_DONE;
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
index 6d3fb133f366..dc5fc2f77f4b 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -164,7 +164,6 @@ void nfssvc_release_readres(struct svc_rqst *rqstp);
 
 /* Helper functions for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);
-__be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp);
 enum xdr_decode_result
 svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp);
 


