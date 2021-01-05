Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69132EAE5C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbhAEPbS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbhAEPbS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:18 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C4C061796
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:02 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v126so26712475qkd.11
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0Y8TkPWSG0A5AAw5oQM15pPVLvuUh1CSHPSe4B7fuGA=;
        b=U4lELdMKqMjxuhgPD2X2kZAQbLL4hAY7brXDJVUC/im4L6e3fpt+c6l2fStW6NrmXO
         PtUBDUocpMlfe31xGuTCWBDL/75gzM1jycqIjgnLRwvZOMdiECSdN7YPi4rz8fbcw8J+
         SMQVMSEdowcXE/CPiAEPiY0ybFXDGZNyStQl+AGLlZYkFyEyZgmKiSVCkPVcUtVfHNtL
         rIeqg3jV6ba/Wdnrgh/OtJbvb3Mne3Ag4nqEOhFU9w3LGEh0vL8UClWP66NbucNJViQl
         Ap/MmB+CHPiNYC5ooi5IgZO74rFkLFpH6Pyy3veCjyC8G8PlbM+NDIX8tNWVKVH+Wlbk
         lYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0Y8TkPWSG0A5AAw5oQM15pPVLvuUh1CSHPSe4B7fuGA=;
        b=nkIQShBEAuNeLjqXk1yuJ05dCvvOECpcZ0P5m4PhZQ8YytZLB4K5Owy+rTRekofPQS
         XR8C+77aIn/mGiSbDuHBaUcR4SCcNv4nStSwGPSHYbwpCVuBEWjXhSNT2k0bnT92xinI
         DMNr0YuheHtE+NSGKS6LuJYdUxDYoukvAeVdJp23fBrYJgC6H/nisJn4pl76Fg2CwY6E
         759ojJlX88O4b2rJXWFYhdgOWe+K3KNpdJH5n26BUp3KPoOLDmEhPM8jz8QrTGSJGijl
         E43Jc1Uc7L0ear4zrhHtCywpxcyaTtDMcIJGqRYPuVYtePcolOR5d6XpG+rMt1DUks4N
         H2XQ==
X-Gm-Message-State: AOAM5317DbZsaY1qjKndPUcjwSx3yhUkZSl19byzTG71cW4nPhVh7srt
        lx4aD4+HVcQ4imYiZokyDFU8ziPAtaw=
X-Google-Smtp-Source: ABdhPJw092qalrCBTP5XMH0tWaqMqO5egz+tPS6INRa151474YIsYHjYtJyU3h1rwEac14eCZiRBdA==
X-Received: by 2002:a05:620a:528:: with SMTP id h8mr91882qkh.40.1609860661932;
        Tue, 05 Jan 2021 07:31:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n62sm127557qkn.125.2021.01.05.07.31.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:00 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUxPl020865
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:59 GMT
Subject: [PATCH v1 15/42] NFSD: Update the LINK3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:59 -0500
Message-ID: <160986065972.5532.14792984567589235354.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a5bbf9571821..ba5ec9cdafa1 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -574,14 +574,12 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_linkargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_nfs_fh3(xdr, &args->ffh) &&
+		svcxdr_decode_diropargs3(xdr, &args->tfh,
+					 &args->tname, &args->tlen);
 }
 
 int


