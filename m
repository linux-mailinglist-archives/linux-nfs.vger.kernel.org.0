Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562432BB753
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgKTUiB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgKTUiA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:00 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403AEC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:59 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so10184872qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Jwru0kr0Sx25x/2mJB7/3jKGABB63Q5LYZiBXkBYbK4=;
        b=b6wrOmu59Wzon+LQwIw+MHEX100weju1aaNExr4qktwEgcc7SuqSuJZXYpEvFuBwib
         JNbUn/edj/yAh6jtYZetO7xLrHVdlae+4K2Oy5gAr8/XBWH1PS17ALirt3ENgk1RPVGE
         1vqarvCc5FVIvbSWeVXzrKxAMsrQke6+qPtJbejc0UPcY5MAQAN+eGHJSrkluv4Kj3R7
         H3pZLjs8yFHqNJK5fpQgULLEGkPkqCjlfSuuahhbDS5ykLZMLsuTn90vYC/IUgve0vU9
         OIuzL2BeZHd+G7WjRbpQytCHazahBQwKiWLGazqYRlz/uVZfZNCeiXMzCa7l1pzYAHGe
         7N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Jwru0kr0Sx25x/2mJB7/3jKGABB63Q5LYZiBXkBYbK4=;
        b=G1k9eBfrSNybhBROk8ah4Gga7a3/LWR+s9xPybEcHNVuDP0TFdcKtGt0Xy1GKH0J5p
         f6rurbJIa9IR25hptEKS7qTbmvrWjiS3AIuTbnUO89tt3wIUwvRWHhXrtxjtwqyycIj7
         7nYS9CqV0sYw19Hy5W6p17+uFAfAD2xzX4J/BWYzRLNB/58F9SX7UHInhq5J89u7MQne
         s2VCJUDdnBHzws/G0/CLWeyMera412HvYRXgX+uL3KOimZfwRwb2SWC3dH292dmczxD2
         mWBCVmZpkGOFVZ1SReiVbYBoZl4Pf0hHINCjZ7++U9br2YL8qUz+cm56cHCArXexk2vG
         IfJA==
X-Gm-Message-State: AOAM5327+JnV0yx9hfrhpA3eGxctsG5vqhGew4VE71xZiXNHIzAWt3fZ
        eJtadNugevGezeM3B6S/sn4dP2oXt5c=
X-Google-Smtp-Source: ABdhPJwXx/0zS2ZMSt3Ocp9tekoDc4Ug7/QptYtvplJaccXyPtxbLg+5fDwfSXchjyT7cdnISmEg9g==
X-Received: by 2002:a37:4911:: with SMTP id w17mr17252604qka.468.1605904678211;
        Fri, 20 Nov 2020 12:37:58 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j13sm3090440qtc.81.2020.11.20.12.37.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:57 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbu73029343
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:56 GMT
Subject: [PATCH v2 047/118] NFSD: Replace READ* macros in
 nfsd4_decode_setclientid_confirm()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:56 -0500
Message-ID: <160590467635.1340.15201330874233513759.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bd950ad7021c..5266a5a1bdc6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1301,16 +1301,15 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 static __be32
 nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid_confirm *scd_c)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	READ_BUF(8 + NFS4_VERIFIER_SIZE);
-	COPYMEM(&scd_c->sc_clientid, 8);
-	COPYMEM(&scd_c->sc_confirm, NFS4_VERIFIER_SIZE);
-
-	DECODE_TAIL;
+	status = nfsd4_decode_clientid4(argp, &scd_c->sc_clientid);
+	if (status)
+		return status;
+	return nfsd4_decode_verifier4(argp, &scd_c->sc_confirm);
 }
 
 /* Also used for NVERIFY */


