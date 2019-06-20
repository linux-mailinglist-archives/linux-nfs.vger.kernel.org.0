Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08E74D0C3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFTOtv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:49:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34105 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOtv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jun 2019 10:49:51 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so163122iot.1
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2019 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6dH/sM7Wc8glPTF6o57Mt2MUGYTntayEUbhoPZsDhU=;
        b=N4HO22bmL0GQReDjVIZ2LpSg/fufe22ecLRMbO+dGeuAveKKHIxXikR47mgmc9As7r
         AmWsjTIRMJw2NH+GjkfxmeOEjL6GXU+ocy30dPRu/nuTfEjN48D7CX9mMGrH8l6vJEPb
         bMepQMSirdraLEBM22t4sg4b6IrPrNUNu60qaYQo2PyqI7lfnwrND/UNTWRIN0cpUMKL
         Ri/TP3sYKrrI9Nav8yaxXJjA8pGT+ahTLAp9bFw+NOt9Yw6+gIRnJaY7ouoO1sWXLCQh
         AweCuzT9FxOSfaFTSppHIpyTjmxMoMgSsQz71f5RDfAO8kDgyX61B0HnbGsBNGZmBSAV
         IbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6dH/sM7Wc8glPTF6o57Mt2MUGYTntayEUbhoPZsDhU=;
        b=reBcMxsrKGd5L61wQvXSaAOqJuFh00ue3kT/VUQjmkC85arWPGEUT/ICfK8BDVG/T8
         9eV7YZqx2WsjrXmCJE9hbxKWW9A4nYXNIT0OqPdMFn6MVlkw31174xZ8hRFTLvRlKZrL
         kB/l0c4WlgnbLPk0k27Y8qsavhD7VlVVtXgT8KL+b0XHs47l8b2kxiSwI6UWWoSdT22I
         w9np2lE01unmLDbghRk2hfsG3rz1SOFehQYn2HSQq5VeoI7VEwC4rk6wu5wAq5XWfHQK
         iFjGl8vQmwxevdvK3bu40KU2YIkYHE5+wpW+LziarIvOeeT/CKw/Jn8d3+7bUGy1LTG9
         LEiQ==
X-Gm-Message-State: APjAAAUVrDfEc6rTFeL9xrqi018aeY48/ygQqVMcKI1A9Q+WeZQ/k4Mt
        bExTRJAP0gOUNGuQBR0J+w==
X-Google-Smtp-Source: APXvYqym/oQplmVkLADTKcOJaYZaKQ0azwnlpSZ1HNjC97zdTb2GFN05Amq3gV9Zghm4Q2/uooKbaA==
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr30290572ioq.50.1561042189834;
        Thu, 20 Jun 2019 07:49:49 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id b8sm39416ioj.16.2019.06.20.07.49.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 07:49:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Ido Schimmel <idosch@idosch.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix a credential refcount leak
Date:   Thu, 20 Jun 2019 10:47:40 -0400
Message-Id: <20190620144740.4169-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

All callers of __rpc_clone_client() pass in a value for args->cred,
meaning that the credential gets assigned and referenced in
the call to rpc_new_client().

Reported-by: Ido Schimmel <idosch@idosch.org>
Fixes: 79caa5fad47c ("SUNRPC: Cache cred of process creating the rpc_client")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 627a87a71f8b..010e59cf2ae0 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -634,7 +634,6 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	new->cl_discrtry = clnt->cl_discrtry;
 	new->cl_chatty = clnt->cl_chatty;
 	new->cl_principal = clnt->cl_principal;
-	new->cl_cred = get_cred(clnt->cl_cred);
 	return new;
 
 out_err:
-- 
2.21.0

