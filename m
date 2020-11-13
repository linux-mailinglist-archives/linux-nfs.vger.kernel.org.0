Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59C52B1E2D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKMPGj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:39 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54941C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:39 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so9049325qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gGKoK09l6/8ejiVSZ0VIz4sgB8+SfdaVecieNaYkxlg=;
        b=UDN8AZo7diVmzJgK9jSaYCSv1mKs4M4eRcnDGgsXKXVfAEk7onIRDz7ZK9ti8qDBlc
         iwnKYYXuEgVBt1M5WwetUO5WF4Jt6Arzi3zbT6zbXqxRFVr/DPre6B/HhYgte2G+Fjwf
         oWH9COka1MRmMKfNoZ57glPCqNPpk3AEzSHo6NbyC0ZdXlXJnD9gjiuGuyLeBYWfZv9n
         hXr9S0xpHCUju9Ozb2Dyl10X0cfngPF/yjxjhKuUOMxmg3DJFDyV9kSVLtff7fOnditu
         bPbdfQLRAXcwktPohll1bQXZXif2CG1cFt8M6ho0b5lXfio3D/j2naHYDPChR+tAOUJo
         aVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=gGKoK09l6/8ejiVSZ0VIz4sgB8+SfdaVecieNaYkxlg=;
        b=Br2x1qmoTQk1/sOYWetKP7PZTON7T6pateLnRGPcKaaNaITAvxjubkKOsEkIFIA4e6
         BFMKr4YG+9WERW+NowdTnF80QE/NVyz99LMAYhml3pj4Ar4SrF06iIWiZvHjOOHUFpNm
         XeWSqiL8Rje99Am8HJEvJa8vGtl3PqK5+AIuJG57epQt/uVmhssH5sRyvlOF3dj9xViL
         LkKPAFp0pcgvOH/i89oiHucm0xbNneRmqkhYxyVfxcWkX6SgWiR6Nxu0cru/U3NXfeiP
         uXlYgOjWA+IWz28UHgPJ8V0I5PK5LfFF6rUqj8AWZGLBU3wPNO0Tdijdw3UkqrKi3Pbb
         C6TQ==
X-Gm-Message-State: AOAM531GpvaZvA8fVghZQ8avhLJJt/fRlMRNx82pfhUFeiOKFM7B+fka
        6dWOZPe4QDTnKS3fqbrg8tOVxGmQru8=
X-Google-Smtp-Source: ABdhPJy6DL8nV31m7mJ6CeAcyaH3Fs2QAi6LDKvm+tQ/sZr0HQOvc2PGJbon+HzaN3p6bPnp7FiAeQ==
X-Received: by 2002:a05:620a:41c:: with SMTP id 28mr2434471qkp.270.1605279997308;
        Fri, 13 Nov 2020 07:06:37 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v14sm7013836qkb.15.2020.11.13.07.06.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:36 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6Zdp000313
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:35 GMT
Subject: [PATCH v1 48/61] NFSD: Replace READ* macros in
 nfsd4_decode_secinfo_no_name()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:35 -0500
Message-ID: <160527999567.6186.14516198696933872603.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 91f2612b3d2c..9585cb9febbc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1283,17 +1283,6 @@ nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
-static __be32
-nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
-		     struct nfsd4_secinfo_no_name *sin)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	sin->sin_style = be32_to_cpup(p++);
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
 {
@@ -1949,6 +1938,17 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 }
 #endif /* CONFIG_NFSD_PNFS */
 
+static __be32
+nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
+		     struct nfsd4_secinfo_no_name *sin)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
+		goto xdr_error;
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


