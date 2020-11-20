Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160752BB731
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgKTUfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgKTUfm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:42 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5BC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:40 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so10209268qkq.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0RKn2qkYQQCmFBu/71RLbGyuH4twFB3QQrKOEZLHLUc=;
        b=n3l+GhRbZCyowjoYepyj6/L5a1+FKGk/Fz2KhMCZ5IajuH27EgE2t4xkZvzgit1BA6
         4PV+0shUiAxJjZ8ifx1jhpE+nKTUWf9vc/58ESkkPOMDZK3vDQvmLD0RmXZef92S+9e1
         XBs+ITaYTmBC22lE1+X53HOB0Acz0zEc4r1Fsr4je1ruCwzGZ5BV3NSMCzuutVLkzRfq
         0Bu96ElMTK6UNmLRcY+RKjltgWh4RPl3gNV8iqdvzo/KFNlE9F128F5zJOS00yGLx3Or
         oCJG654xnsDAQfvsN4rFPamt7eTOe8LAt9IfG+RAMoJLyzICrX+8TtYrlnAlRilxVXEi
         L6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0RKn2qkYQQCmFBu/71RLbGyuH4twFB3QQrKOEZLHLUc=;
        b=X6WNZqJaU+uXtl3CTVW6FIJcfL5U34Ohfwc8Mh/511Wl03I1UoL/VCAF3BD22XPhQV
         nkkTKzw9pyUjU+oR7Np+rkZwEm8wdCgR0JEGt21uY6QB7ds+tmkzh6DdYYXSCJNgIuar
         WO2PV+u2Ng/0P1v9EBr4HwyG4HsPa3mVkxy/ZV26gn/yOyysHCRGWEbC5xvi0CNcrSZj
         hKD6xmpPG2AsEAHXxx5XCFR1enI0puxiuPPBZMMcfv//PEjgzV8ZKZ496fBgKzoHUCS2
         VGJ6fHSXh77UPP7i1HdRENan7uvJdakP5NHPB+x+vEzencBBF5b3VThnRd6V+vUvfDU7
         F6cA==
X-Gm-Message-State: AOAM533oPnkAS6D9DNnoM2Jy0dWrdp7fIou+TOa14q6IIY3MMQItclJb
        Z0P1amoF9DXLdFD4z7qejVZ4OWjyD7U=
X-Google-Smtp-Source: ABdhPJy7JeT1Wue55esAnLyYEtQcMaOslW0kplQgVRpN/MJTkzQM1fmsePfgB3oR0g0rjgxD8HxSBw==
X-Received: by 2002:a37:8c41:: with SMTP id o62mr17123095qkd.240.1605904539697;
        Fri, 20 Nov 2020 12:35:39 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v15sm2561122qto.74.2020.11.20.12.35.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:39 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZcel029265
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:38 GMT
Subject: [PATCH v2 021/118] NFSD: Replace READ* macros in
 nfsd4_decode_getattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:38 -0500
Message-ID: <160590453805.1340.10556319533725753532.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4a5b7bc21dab..8594d8751b7b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -717,7 +717,10 @@ nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegretu
 static inline __be32
 nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
 {
-	return nfsd4_decode_bitmap(argp, getattr->ga_bmval);
+	if (xdr_stream_decode_uint32_array(argp->xdr, getattr->ga_bmval,
+					   ARRAY_SIZE(getattr->ga_bmval)) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
 }
 
 static __be32


