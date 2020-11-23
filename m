Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E3C2C15B3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgKWUHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgKWUHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:06 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA06C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:06 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id n9so3154857qvp.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9tvn62bV/+P20BgOBhg5EKe7ylbarIRTZ6z+hr/V6Wo=;
        b=JsKSpnNHkJFBg3Sdwgx6yfotiuX7l2NvC5as7cdv/G0VxS9fgqjBaSHFPuuaXvfSU2
         fH+Yg21h597f8XMoo0VUFSwre15sxdHXq3zNhv3jPi5HLWFbqOTE8osfqGBeS6sbBKnv
         x4usNJ5teVPJ/FLif/AEj4Cg1Vzrdu4gCUUjUh+OZGBq/HbFtqWKQZlIu0TjnJIsgN0E
         C1ZhvVAcq8yis//t3Rf35j1fbE2XH2wZ2EiJvok8mPTOngIF3UNfJSk3fljPF4mZws8g
         LWml4ElQ0eg+ZktZEcYT9hNlWphxkY/rvo/KbDlpeEeDXPM+O959P5XtC/OWJvFoavEf
         0o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9tvn62bV/+P20BgOBhg5EKe7ylbarIRTZ6z+hr/V6Wo=;
        b=C91l4dXISCCn9BRv4uOiwRf0AoAq8WDHPnoU86cDLwBAEj3oC0t5dE+uWcehQTTvX7
         EsxikcNoFlr9+3LmwKvBktthReRMsp70sNu8bDDjYP+NaBCWHOGUevGaZWI/NjmA6twP
         nGXPCe9vEPQVm/0R6V7PUh4t2LravAKlPvAdNNvmcQo4V490TbBHvY3HlnUguxH2CA4V
         Zu57Cbb8huMSQyM49P3w3XZhUJ7HL15uKDrqMDkviCxUnmxNnA8qoFX84lBY9DiRTYE9
         wtg5gDEPELgSw3zWGs1c60iuA7o8jdAa+M4I12tEDpGAF9jRHcYtoZb3AjIWviKNIH8V
         9Rcw==
X-Gm-Message-State: AOAM531P1LxNAW0XT6IGYPEP5AIn0p6iB/PJXBy5YP5kT21nGcXV26zS
        R96ea8QcY0yAlMTu2GixbeP+/WqjnJc=
X-Google-Smtp-Source: ABdhPJxdRQwmfHieZdjpYSawgytJN6jYKgunM2To1+fDibTLeFfKxX0+dqAfxo6CmalKBntkWWFrAQ==
X-Received: by 2002:ad4:4cd0:: with SMTP id i16mr1108482qvz.13.1606162025031;
        Mon, 23 Nov 2020 12:07:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w192sm10513356qkb.17.2020.11.23.12.07.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:04 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK73dd010373
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:03 GMT
Subject: [PATCH v3 35/85] NFSD: Replace READ* macros in
 nfsd4_decode_share_deny()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:03 -0500
Message-ID: <160616202332.51996.15963677065764215766.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b1a4d3b85900..521b51b5607b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1063,16 +1063,13 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 
 static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 {
-	__be32 *p;
-
-	READ_BUF(4);
-	*x = be32_to_cpup(p++);
-	/* Note: unlinke access bits, deny bits may be zero. */
+	if (xdr_stream_decode_u32(argp->xdr, x) < 0)
+		return nfserr_bad_xdr;
+	/* Note: unlike access bits, deny bits may be zero. */
 	if (*x & ~NFS4_SHARE_DENY_BOTH)
 		return nfserr_bad_xdr;
+
 	return nfs_ok;
-xdr_error:
-	return nfserr_bad_xdr;
 }
 
 static __be32


