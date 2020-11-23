Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153952C15B1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKWUG4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKWUGz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:55 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9041C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:55 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so18249206qkq.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zORj2Xanw0mtJNqfHptijg9zAmhYsmAdanYLTZ8d/qQ=;
        b=EncbxYqlR2qyTNv8Qaw9yIVlWxYlN3pS9Hp0uHGaX5SZ5NWr5smkg+7TqSWVNlJR67
         1FSpi8H+c7d6sAWWjqDuXWD4iM9VQm+XtppZdD+1I3Lceg6v8Q5lQmxLXAkTB69IEP23
         SNyVmWY/BgjwZgnJY9AsJV7TZpZinoao0auaHdASUZcae4NGtRl8yuFVvKCXoSXGMs4q
         v0MHke9xUgmuVd0+z7yNAEJT1t7eU6o8HxMRuuR/Htd98LvXCcLTMR9LqOuRVurdtkc2
         woXnyOHerqx/yd9l4EOzgnqIj++1xJzcOZywkLQZnYVglghj9HL6deUXr+E6JbtReJB2
         wf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zORj2Xanw0mtJNqfHptijg9zAmhYsmAdanYLTZ8d/qQ=;
        b=gTRnWhQNrn1gToxc4eSwJoOSUndRVDlyD+Anf3mwBcYxzuf5W5JrIZ4rNLJtmBGkEA
         sZ7MAXJaY5LRHgdct77Il5n6DD6eRjtc46XVPfGvJr4Wx1+Aww2Lq8WBuxZL+3lfQKy/
         sVsYXwkDoDZ8OKFACnq4IZazsrEKVQSg0beyVnQyOTdZ+tUAqJjcYswQXdYW8ozlmbd9
         KmEQMot2SZ3IiulEo1NDtdsCjnu2jKVhKa4q+uCixsfJ+R/crmDEJ9THe9sZt0/aRiK4
         751n0N81GMBfI6r7O1z0Hxs4U9hPuNbX0gKYTHeClN9DseuXVbN4AETT+IhHD/rTQwux
         8XQA==
X-Gm-Message-State: AOAM533NkvnAx/b6T7HTyG87+N6l1FT7WmAsXmZev6MYNmGAO73jTYqR
        O9yj8kJ6JyXoiwaS2aCBrC3pPjY9fkE=
X-Google-Smtp-Source: ABdhPJyY6M3srhAFB3mZ8X4py6n29vZrTe+/Wb3gvKGUMtEvF5Rs3k76ALle45oSuBfQBgwsMlzh2w==
X-Received: by 2002:a37:8c05:: with SMTP id o5mr1289182qkd.396.1606162014651;
        Mon, 23 Nov 2020 12:06:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w54sm11405259qtb.0.2020.11.23.12.06.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:54 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6q59010367
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:52 GMT
Subject: [PATCH v3 33/85] NFSD: Add helper to decode OPEN's openflag4 argument
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:52 -0500
Message-ID: <160616201296.51996.17429441794086812436.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 579139d727ea..192bce6d359a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -988,6 +988,28 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_openflag4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_create) < 0)
+		return nfserr_bad_xdr;
+	switch (open->op_create) {
+	case NFS4_OPEN_NOCREATE:
+		break;
+	case NFS4_OPEN_CREATE:
+		status = nfsd4_decode_createhow4(argp, open);
+		if (status)
+			return status;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)
 {
 	__be32 *p;
@@ -1082,19 +1104,9 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	status = nfsd4_decode_opaque(argp, &open->op_owner);
 	if (status)
 		goto xdr_error;
-	READ_BUF(4);
-	open->op_create = be32_to_cpup(p++);
-	switch (open->op_create) {
-	case NFS4_OPEN_NOCREATE:
-		break;
-	case NFS4_OPEN_CREATE:
-		status = nfsd4_decode_createhow4(argp, open);
-		if (status)
-			return status;
-		break;
-	default:
-		goto xdr_error;
-	}
+	status = nfsd4_decode_openflag4(argp, open);
+	if (status)
+		return status;
 
 	/* open_claim */
 	READ_BUF(4);


