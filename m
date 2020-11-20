Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAD2BB742
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgKTUgu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKTUgt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E1C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id e10so651616qte.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KXeFpgcvO6CwX1so0/9qTbi31rwYEyXMaUIHvTcCOXw=;
        b=VejUU/taz5vzZAXl2H7pjo/qnqWsmZGRV0+XYNXlJ29QtOzF4Q2lDxzMn1ZlnJ/Gqt
         OwcHX1so5+zXELKu6dHElT9dSR2I+lsv3KGwJVhqyOwPIAkezmkGBzCU/Ve2agPU/zNq
         zJnwXiFspqaESbJhfufL9sLvtqjgugFV3qYlsfNIOCIPmYAFV4CshT7/H7gw5+2Hhrpa
         Kgc9Er/EUpUPCJWwm7hMDO33rG/qsuAk11k19beF4UlLdPbmQxFV9DYbJISXZzQ5a53V
         ou3Dlbh7A24ejHYdRKyt07FqLII0UMVN42lKBgTi70WmHAppC+ZBFGpBCfviI1UH2O/x
         U47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KXeFpgcvO6CwX1so0/9qTbi31rwYEyXMaUIHvTcCOXw=;
        b=qBBnZBwhiZwnV48d9i0wc5kV8Nc7Ey/l81c+/ydSDCF693HOhf+atX0dPzaurLsXb+
         m+lydsnvXvC3ub6YLScFZ/BF6UDURofgbKJ/Da68ULPPs55ELsXQbE8FBOwrWFtym6kG
         h5GqFjRfW/OzGm1g27DK+2IhaG63l3is9jJ6zWskq+Tb2PuVaLP1rFWFanzqzuzy6r/k
         +7WkF5jRLVrqZkTz0P765nk9ScSJEke82N4oOyz4xHOpVZb+cTaumc5G5KrD7lpIDbG4
         I0QNRKuIP09jWQGmIISKswjvQ+snMskjyJtXw9Ua7adTzL8tBGC1uWBEDFg93sTWoki+
         EqmQ==
X-Gm-Message-State: AOAM531UFqYEYXjY6ezNkBB+W4+7shja3smB58CnEQsooaujzfTmggl4
        2ZsnJNLYMTT0NSO6WXvykoyEegGpQpo=
X-Google-Smtp-Source: ABdhPJwE5epv0T1lm3EoQU1kYoMQuMZk6ePh1vB4A+fb65lzua0EyKgq/pRFHd6BAXPoVz2TsGMwVw==
X-Received: by 2002:aed:2f81:: with SMTP id m1mr17486149qtd.209.1605904608560;
        Fri, 20 Nov 2020 12:36:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f189sm2692413qkb.84.2020.11.20.12.36.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:47 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKakTo029304
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:46 GMT
Subject: [PATCH v2 034/118] NFSD: Replace READ* macros in
 nfsd4_decode_share_deny()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:46 -0500
Message-ID: <160590460688.1340.1410337139984545335.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 29b7c096b5f8..fa16bc32f3c9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1010,16 +1010,13 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 
 static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 {
-	__be32 *p;
-
-	READ_BUF(4);
-	*x = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, x) < 0)
+		return nfserr_bad_xdr;
 	/* Note: unlinke access bits, deny bits may be zero. */
 	if (*x & ~NFS4_SHARE_DENY_BOTH)
 		return nfserr_bad_xdr;
+
 	return nfs_ok;
-xdr_error:
-	return nfserr_bad_xdr;
 }
 
 static __be32


