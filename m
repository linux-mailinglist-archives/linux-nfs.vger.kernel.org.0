Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAC2C15C5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgKWUI0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgKWUI0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:25 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u184so3661208qkf.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=j++YOtt+ltlu5ltIe0epQUe2T7kaYbhq1qBu1VqKhDU=;
        b=KB39cgYPI1Ub4uP30Wubw22yqY7k9pCDuTD1tY3eTri80wi/TOfCiXOSpf02uRA3fu
         iJiKxTZt8QzDSU9PEQXyttrUzrHyoDGTMY2zDfLPSwFm/aMgFBTwy2L8scsyhsIWIcqJ
         mwEW2L9b2MLdHKQidJ1mORcpFaQA6VKzShjqXo2kc38zM/bxukomTVNW8BImggufF5xU
         FiyIwiyHytxb9zGrUtZ4NxGA4quHnpoYbVKSRjHP9XiG6o2wd1kd2vx1G6KeCC9Ccona
         oq4MEEB3qJz9sd0u4zKpIaa4mkp4v02l57gDGE3t4jlldyaJ7HIxbSxfAetJ3fQkNnGP
         oVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=j++YOtt+ltlu5ltIe0epQUe2T7kaYbhq1qBu1VqKhDU=;
        b=txNgdIhvJeiaUWClT5xPKREecLX6vJZIpnooq75YCQGYMBSfQvw+RHwoMe4Vwe+7d5
         +MWBhhTWjq2vW8RLqgcFzTa2LHCQVkMhUC8MXFGEwWLc1Fr0S/4ypbJSR0clQ2K9allr
         tblsmK+TiK8NSmYDkzop+WdcJGpkBOikO3GAiKmJQMiWsjDpsZpz6V/A5EMhjlo5QVg6
         9P0EXK1Dxg7ZQgtDrXGzfFBWWjfSwOEMU2ez2xTCmJr29F87QEAZ11VHMyqyKeg47bgl
         zu3WoQmPxU9rH2h6QiMhK8tVqLhR9YeTFHIcsGqruthfxJu6EO/yiCpX+4+VktTi17uS
         eO8g==
X-Gm-Message-State: AOAM533S0r5/jn8jnkGM0MPCsDaDf7L+sJUpzYn8K2Ukf9cuiVtPxAaG
        8A7QhaUfQw+bIfiL74KKqr9zXggVV+c=
X-Google-Smtp-Source: ABdhPJy+TgaLCRkuEU3PyEjNb2wqC1mr5UAzlk6xAMf+lU/c1UR8GYPtsd5LIOxL1vZxjRRxARaDfg==
X-Received: by 2002:a05:620a:16ae:: with SMTP id s14mr1158251qkj.461.1606162104023;
        Mon, 23 Nov 2020 12:08:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g70sm10595706qke.8.2020.11.23.12.08.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:23 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8Mqe010426
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:22 GMT
Subject: [PATCH v3 50/85] NFSD: Replace READ* macros in nfsd4_decode_verify()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:22 -0500
Message-ID: <160616210221.51996.4096838677421642494.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6a6659e07eec..d4497be2c583 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1370,20 +1370,27 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_s
 static __be32
 nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
 {
-	DECODE_HEAD;
+	__be32 *p, status;
 
-	if ((status = nfsd4_decode_bitmap(argp, verify->ve_bmval)))
-		goto out;
+	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
+				      ARRAY_SIZE(verify->ve_bmval));
+	if (status)
+		return status;
 
 	/* For convenience's sake, we compare raw xdr'd attributes in
 	 * nfsd4_proc_verify */
 
-	READ_BUF(4);
-	verify->ve_attrlen = be32_to_cpup(p++);
-	READ_BUF(verify->ve_attrlen);
-	SAVEMEM(verify->ve_attrval, verify->ve_attrlen);
+	if (xdr_stream_decode_u32(argp->xdr, &verify->ve_attrlen) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, verify->ve_attrlen);
+	if (!p)
+		return nfserr_bad_xdr;
+	verify->ve_attrval = svcxdr_tmpalloc(argp, verify->ve_attrlen);
+	if (!verify->ve_attrval)
+		return nfserr_jukebox;
+	memcpy(verify->ve_attrval, p, verify->ve_attrlen);
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


