Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D152B1E0C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKMPEc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKMPEc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:32 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14894C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:32 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so4716564qvy.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4gZyntLgWDxeFWnDd5ziknLFI4GKdViSRVKyyg6Lv9w=;
        b=quFTLXruCHkTInC6ZdYyuLOiHfh52sBGNSSyKgyF6XD8rMHBlJrnabDDoFRbVRKfR2
         vlHrL5Y5ubMC3WOg0wgwckvpLyblSsnYUIhxq55bN4KwdIZwgpnkCspUMCMkOOyXP/wi
         8nH01/sSgzRuN/TK++K0kzlC59A1+P9wJnu/9mXcgDq0gNq4iqwXfOZ8oOVWhZTzO/QD
         h1skpfU6AQUVY4+z8ewduL2DUQTFOScDlvm/H8Aiq1yFNRI56CJ77dy7RcfcwE7ZrHu6
         27GxFLboTaIszmqhfCirWoLsBkVsFPzIrbmxJ4mrlnaIrtQOctnlaWeffG++vysIjxdG
         Q5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4gZyntLgWDxeFWnDd5ziknLFI4GKdViSRVKyyg6Lv9w=;
        b=gkmHVfLNaYJy23vE9g6QIXN65ZEIUNZlB0yXuUpBJWVle1Fv2MrCK6hirfMHfKW1bc
         H+NDl1I/7k0hXgEtnidJUot1wM8U1sSRH4lg14bANi6epEiuthKSKsx6Zs3Zc7j7INEi
         Eq4H86kHTdD/dL2dSySBX1Js8ULSbLJiF4skEbPNT25wyUIdCtThAjskFze3aeAu8U2t
         V/NRvFpM0U4C4hpLEar/6+IcfHgU/rkvXCmkvDWFRvu6OBkw7Mwma/OVBzmnj9BMVRg/
         XnpCO7N3gP8Vcl8Ae6/eYbRm3QYcSZhmy3ZQ+gFCU47pf1zybA8W5l5tRkPK7RITvIJQ
         IeIg==
X-Gm-Message-State: AOAM533neVBn0fsaGaGh851UXhk00gmTOxiUr46ottY7i/MhN1dhyLmy
        8J2rW1J/7ntvtUIt+0YJnE2VrJW+Ug4=
X-Google-Smtp-Source: ABdhPJzMa4yQTxHU1JHVx8YDThavTmz2ihRfZFXDklYftv5W76WI6DYtwIHF/Qgl+XphhsEkgC+zug==
X-Received: by 2002:a05:6214:612:: with SMTP id z18mr2752752qvw.41.1605279870920;
        Fri, 13 Nov 2020 07:04:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c12sm6454048qtx.54.2020.11.13.07.04.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:30 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4TeF032709
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:29 GMT
Subject: [PATCH v1 24/61] NFSD: Replace READ* macros in nfsd4_decode_readdir()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:29 -0500
Message-ID: <160527986916.6186.10421850230732928464.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1f00fe6febf9..2e163c23d013 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1197,19 +1197,27 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 static __be32
 nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(24);
-	p = xdr_decode_hyper(p, &readdir->rd_cookie);
-	COPYMEM(readdir->rd_verf.data, sizeof(readdir->rd_verf.data));
-	readdir->rd_dircount = be32_to_cpup(p++);
-	readdir->rd_maxcount = be32_to_cpup(p++);
+	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
+		goto xdr_error;
+	status = nfsd4_decode_verifier4(argp, &readdir->rd_verf);
+	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &readdir->rd_dircount) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &readdir->rd_maxcount) < 0)
+		goto xdr_error;
 	status = nfsd4_decode_bitmap4(argp, readdir->rd_bmval,
 				      ARRAY_SIZE(readdir->rd_bmval));
 	if (status)
 		goto out;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


