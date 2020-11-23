Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578A2C15AE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKWUGk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKWUGk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:40 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5597C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:39 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id n9so3154166qvp.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IHFKLqLkvQvOcOozT93LaBtAQD1dnOCJbXIkFKB9a1g=;
        b=PSL/YOXXp8GgyMIRE3F2BJM9JW8ZdYUxGWPQZNapdFRD3PeQYpPX6h+wSa0Yc5a/Nc
         QnAv0S6aj4S/4MY//caFF8PODJTl5sRgFgK4DEHJh0f0vDf15IrA0tCVQsn+A1LrhGoO
         7sPgUj13TRtPl0ybZsh24ZrdvyV6yi5TPi6gsWreuxmVoy540mcVjAT+5JOfzoi7GVMq
         b1R90vHzf6UWquQGAKxUmrM/SPxaSjvMxJraNWTdGIoR2eZPAolEueVcVWOxph18DyA5
         PWqOiLBImS0JAI6o08BOSRaja/mdD6kTCmeTHXhORzyD2iuQPzmXKWmdKJSHTI3/XUCK
         EESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IHFKLqLkvQvOcOozT93LaBtAQD1dnOCJbXIkFKB9a1g=;
        b=TLkcK/ipMmM66NGJkIusM6balveBAiAM1sAbkZHZZvQVmKMEV2cvEYHgd1gmjbH9YT
         NxeaL0bSrodgnnqaCDm5U6eXJgj9Hv3BuKUny/UnmIGbX1eDVAmwkRq628jV11mhHtac
         pCiYTPUj2E9c31TH+WX/j/xEMI/Sjz1b55nxxWahdS7lihKAULTactkbwvi8mhQxFtHz
         d9BIeIJ05CM11gKy7LYE6SPbmdnjQCn++RNsT3j8llaF7CwVZJfKMBTGmW6IZe/alGT2
         vfkiT+JJqH/ziY/Wye5dIKD3Tqo31PsbSUlOkiec+edOx+XqULxn5fSS4fe01DsMj5bK
         vSeg==
X-Gm-Message-State: AOAM533RG64bT6IZb4VSR5AfKJ1aUtd/LBy7gDpzeP5IcCJQJ9esbNSR
        X0orBDsrvLSd2HZA9qfo6YfyokVBs4w=
X-Google-Smtp-Source: ABdhPJy5ihTgP4WXDSnrv6xZOjJ6Fen+ROAWRNtcpYIEotGCfdlHtGSlc+Tl8yGmT1JyNUrKUeJHyA==
X-Received: by 2002:a0c:b29b:: with SMTP id r27mr1111262qve.50.1606161998882;
        Mon, 23 Nov 2020 12:06:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a83sm10494899qkc.77.2020.11.23.12.06.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6b4q010358
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:37 GMT
Subject: [PATCH v3 30/85] NFSD: Replace READ* macros in nfsd4_decode_lookup()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:37 -0500
Message-ID: <160616199710.51996.15161127418429912657.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0e7032030cec..4c2a7b4877ad 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -931,16 +931,7 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 static __be32
 nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	lookup->lo_len = be32_to_cpup(p++);
-	READ_BUF(lookup->lo_len);
-	SAVEMEM(lookup->lo_name, lookup->lo_len);
-	if ((status = check_filename(lookup->lo_name, lookup->lo_len)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
 }
 
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)


