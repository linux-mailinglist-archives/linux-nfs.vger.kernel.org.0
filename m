Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC52BB776
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgKTUjp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgKTUjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:45 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C314C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:45 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so10195910qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=51O7H7pHzl3XzRb+S1yOCwFwBRZWfO3L/R7pEzL7Elc=;
        b=QvzT8krEtrFuSkzBk3O8J//e+p3BCTeearAQrgX+Figt943uDOxtDQYFW+fbg9kTVe
         LydHAMpmFqgJWGE0vm5Vp7f2UhsJZcpdPswhUylpC7RZ6CmXqk5r5OfWI+2c2AB5gjT/
         l8yH0RCzy4CYzpzzVXhaTUaR4+LTzULaLJ1ShZS998g5IZXBFd603gdju+HGIMMMCZyf
         X+dHn6CiwuaR+P/8ftSaSH6QuPOawLW9Wfr4okVuoPcPBB7Yu1WwAdbO+gaG17Na5Eo3
         4++ZqhG1vjWOGi3Z6WEWyhvkGHp98KHt8qZbVGoz3yNr/rRmgirSEUHIK7lopK1BwgGX
         s+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=51O7H7pHzl3XzRb+S1yOCwFwBRZWfO3L/R7pEzL7Elc=;
        b=DQxInOdf43ko7ziX7dJzU4XHU/YJgg2oYv+LJhooSEBgcTIdgZLxMsBEO2FKQ7SLSQ
         trl61Jj8VMXvV3k2+wgaIA0ohWH14QrzK6kDRPWPhsHQ1a9BjAUOmCoShrGIKh4yTB77
         F8ons3qDUJd7LRoxb+lrbIgGIvHc3J8do3NRVCX+tXfsT572ZymaI5uhEa7vkZiXEVoU
         OOMasws5Gy0PRi1ZM0yTMZnCTXS4GgS/vTBxSONbQuiIVrLlQNL8rA90fZchQbd8u20F
         JnKHvRPFMg52GTJT4vwWbcNWvQMtm4Zm3zGGNFz1YeG2V24U2as50XsAMm/H2DOjQCvG
         Ek+A==
X-Gm-Message-State: AOAM531WSVJvZvT55KyZFJG2NjDQmn1G+GCQiEbbWA5A2FnphhOy4kHK
        Dt/xcQ0X4bvQbreJSGlgmSy3lQlTHuI=
X-Google-Smtp-Source: ABdhPJyna+boenFSuWewGlp5TROuAJ9qDwQaW45icifKjI4q+hicEnu+se5agsaO4X1PG0s71JMg2w==
X-Received: by 2002:a37:8581:: with SMTP id h123mr18362372qkd.328.1605904784135;
        Fri, 20 Nov 2020 12:39:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z186sm2756013qke.100.2020.11.20.12.39.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdggM029404
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:42 GMT
Subject: [PATCH v2 067/118] NFSD: Replace READ* macros in
 nfsd4_decode_sequence()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:42 -0500
Message-ID: <160590478244.1340.3922893198036439484.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9bd20faa96..5544e85b8897 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1679,22 +1679,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32
-nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_sequence *seq)
-{
-	DECODE_HEAD;
-
-	READ_BUF(NFS4_MAX_SESSIONID_LEN + 16);
-	COPYMEM(seq->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-	seq->seqid = be32_to_cpup(p++);
-	seq->slotid = be32_to_cpup(p++);
-	seq->maxslots = be32_to_cpup(p++);
-	seq->cachethis = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
 {
@@ -1855,6 +1839,26 @@ static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
+		      struct nfsd4_sequence *seq)
+{
+	__be32 *p, status;
+
+	status = nfsd4_decode_sessionid(argp, &seq->sessionid);
+	if (status)
+		return status;
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT * 4);
+	if (!p)
+		return nfserr_bad_xdr;
+	seq->seqid = be32_to_cpup(p++);
+	seq->slotid = be32_to_cpup(p++);
+	seq->maxslots = be32_to_cpup(p++);
+	seq->cachethis = be32_to_cpup(p);
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


