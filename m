Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1A2C159E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgKWUFQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgKWUFP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:15 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DFC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:15 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so14375169qtp.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ek9mp6KvuYLbDR6TLP/AcPNtzm6FNrNbLlruqgeb5Gc=;
        b=eMdgHWgLi2vukYy4oIela6bI+zBRzuTO8iy9HOu/TwV/0mgCwaPwabGJI8zdB97s/9
         xluT8MoSNymcUUYwOsGFsZc7IZ59ZfbNsLW58/EkFqiR5BOs/93oCF3Idvg+mPiCUBHS
         IRdnzaV80FF1eAKLiWWgrmKqI+y9AkFxPzhGBEHuwrfNnwJ4mkCyqs15lwowP52jcoUG
         a3buiOGDc6ydjlpc+J82MPj6FrjBbg+I7Ji0MUTw8sKf9BhcRGsyPNKmhUywQ0zOSayn
         e0mec6MSHs9xgpEIKlAetb5YOmenjlkMaQ8t8PHNKzL8B+pK3nOPGoTwyarfjQKB3b+D
         piRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ek9mp6KvuYLbDR6TLP/AcPNtzm6FNrNbLlruqgeb5Gc=;
        b=sMsDVUhNNTRu+x15+KzewF86Jkfpg8JESEE2SYDJCJbCGM8bOLO9emJ7aoCk75i82T
         AXXINfLELB/xOqUOLOuNjOjDEQmwUthk6EmJ5SVvdG53LI+q3RzC8pAl2I0/xgDm1JVB
         vZ3pSxen/YSOYv/JpyPgik6u2xtd5OHur5aODLcZ7Kfbx3glZ5XsE+GMM4nh594F+3ZW
         X/prYj3kZpTJnnyjBM1gFt4LuY53vzt0DLEYme3y4cVyQ7MrKS0087O0QizRrKWWU3zd
         VAVg8mx1OxZzd40SoMzoc+n/ifPJrehmbDNmVgAiih/r8xgsI9jcRPndNSuwUAkmiSBe
         UARQ==
X-Gm-Message-State: AOAM533FmyajtgD1kCUaC5glQPDy3Un0InUutpowS28IYenJ62kTTGeP
        XgLRuh5BMly2saJS3f8RGCruH4EGOiA=
X-Google-Smtp-Source: ABdhPJzu5koEgDM2PvIcHgKVn3DheMvuphtCqkKhfap/Q68CzkJ6rkGTa58uVoxzYKWoUvU0yayMSg==
X-Received: by 2002:ac8:734a:: with SMTP id q10mr831785qtp.389.1606161914411;
        Mon, 23 Nov 2020 12:05:14 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d82sm10143455qkc.14.2020.11.23.12.05.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:13 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5Cl2010310
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:12 GMT
Subject: [PATCH v3 14/85] NFSD: Replace READ* macros that decode the fattr4
 owner attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:12 -0500
Message-ID: <160616191276.51996.13499570109676145470.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 597da7cb28af..0b46cb9e3867 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -360,11 +360,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_MODE;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_uid(argp->rqstp, buf, dummy32, &iattr->ia_uid)))
+		u32 length;
+
+		if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+			return nfserr_bad_xdr;
+		p = xdr_inline_decode(argp->xdr, length);
+		if (!p)
+			return nfserr_bad_xdr;
+		status = nfsd_map_name_to_uid(argp->rqstp, (char *)p, length,
+					      &iattr->ia_uid);
+		if (status)
 			return status;
 		iattr->ia_valid |= ATTR_UID;
 	}


