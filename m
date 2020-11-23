Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708CB2C15BD
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgKWUH7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgKWUH6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:58 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC21C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:58 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id q7so9418120qvt.12
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NfzVNkUokah+aFmU14vL8CdLYkXIt1+1eozBSxVmhyU=;
        b=d4hI4Uj7MkL1uY1n8HvvalWJfA51NQrbaBuuVzFDUr1wyaOMMkkt66uNOEwgcIYv+h
         5XprjCV/H9OMn+YbrQoz3Hc368evdoVmWXGzs4H3U/tRRnzRk8xzuLtHQxxeFMWjaqh3
         ThFa3lM2t3TzJMXqIXcnWbwtUtUsrEbQ21GQgGL+JfWRG/J5iBzAP7YVci81rVHJARec
         RU1l8KG8/8jg6SAQ7eiZ1JOZtSXDb65k0ohitvCjaS0gYA8BAodGdx8M/OPznJ0TJaqL
         LzDESSuI/sIW+uiMggtN0dm6voLn1BcOem5oaBguPd0dd8vSwkTJgsy4s+8krjT5cLci
         aKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NfzVNkUokah+aFmU14vL8CdLYkXIt1+1eozBSxVmhyU=;
        b=M6DN+MHKGMkPBJuRLDF1fwQ7WvJiJpsjexe39GVpD5mh2GriTp9WBOBTrH1cOTkhGE
         ZbfMaw29ETvjCSuk+NXcQDQpqF9KQdslMXytr7RW8P0Ik0piKJzbn49vQk1vYJkuUbso
         fALrIzxLg+ZNJHrdiPr9CFtlrISyhbwB92smj+ptNg5S/l6sgDzhCprIXk0VR4Vsxlgn
         O56VaOsZ3184n81O3CJbEw8OEcfyzotk1CA4goiWdxmJa50bo9cxEHPnbV0eLWtzbmW3
         R/nJowSkeOxHldPVPWVljpVRN+FtDP2ccygAcSt7Gh2PzEzxRYSaGNTEFzz0hlFww7rr
         jsNg==
X-Gm-Message-State: AOAM532ITXZYiHysTqgyaZbGimlF+VAAxgO45gu2+Iu5VgGmrUKBQ1eD
        5tu5AZ+MjLARaHVB24kibNwVEOULxpU=
X-Google-Smtp-Source: ABdhPJw3PTWCSP9sqe1W789d2lMqCfPDFfZB9Oruht6PqwW0yzm+a5kOrKddx5pvd0Yr7MwGR8GTYw==
X-Received: by 2002:a0c:e911:: with SMTP id a17mr1310339qvo.18.1606162077613;
        Mon, 23 Nov 2020 12:07:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm10315239qtp.5.2020.11.23.12.07.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:57 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7u8a010403
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:56 GMT
Subject: [PATCH v3 45/85] NFSD: Replace READ* macros in nfsd4_decode_renew()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:56 -0500
Message-ID: <160616207621.51996.8189584044738083845.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ea687ea78c18..064020c187dd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1272,15 +1272,7 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 static __be32
 nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
 {
-	DECODE_HEAD;
-
-	if (argp->minorversion >= 1)
-		return nfserr_notsupp;
-
-	READ_BUF(sizeof(clientid_t));
-	COPYMEM(clientid, sizeof(clientid_t));
-
-	DECODE_TAIL;
+	return nfsd4_decode_clientid4(argp, clientid);
 }
 
 static __be32


