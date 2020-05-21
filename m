Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCEF1DD01C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgEUOg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgEUOg3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:36:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A84C061A0E;
        Thu, 21 May 2020 07:36:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c20so7306267ilk.6;
        Thu, 21 May 2020 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=lmLWQw/NQ8Qnzrklf6Zbc58p8e0yGf4Jw13wPz/KPDyYgS+OAFFQ+q8OrV5INAlQ29
         ZaFcsMAcEnEFJr/aYy1MEuUVW+NNLpB2/3e4ODa2kpKVjp6xtmDbs3XNDeXwBa5n3I7C
         H4vXKKSTOO4vdEKj4XaIRmCLzQDJXBt/uTQx0NGanJqTJLtziisbR5GON6AC1CPpHoy0
         FvikNsyK3iqHgyt0DZmeMmzuf37qUtQmCJW3xzjipSrMtbHdCvqwElaaS6BmNymqBkzD
         2OqbBOS8FTVYmFG0QLLYQlAybcpTu1oe+ycMYZZrFlbR99CGjePVUJyIZzQKaRI1wHhi
         EG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=DGFoN8BAPaEU2zPYzRzfiaS+ZGule4Lx+9xH6EG2qCVnpDr0xxuEaEbgCLPqoT0ltO
         aZi/D6iamiFTkVUb6HKbt/lp45t5PrZna450uq+2UeEWInC36vzy262F5VGBM3s+fVLM
         urdPIemrRDj/IK+OQF6dOKARWLJzH6Ixv4MxeFmPWi4CVfFqYjHjjVHF355/KAekMu8X
         AmnhPcF1E+/BDITVOnACwDPuli6ZkED9UOpmzYVcmHMZe6REaiVNcdyUMbkXPffGjOrZ
         eplRYrGkngVHRJ/bDo+Em5Qy5lQSbIgLUf0tlAhT3dvra7BSb1Ep1Z1/0q6bK8VhsN2/
         M1Bw==
X-Gm-Message-State: AOAM532CEcH+qodE8SegkgRo9238/lBZ5/azNISld4qUhJG1Q8hiHutz
        2sLOvqkEp/+b4sEB7fLuNyAWynR6
X-Google-Smtp-Source: ABdhPJyncnAaffMmktMtJloFhhZAJRDqWx0nt+RJxvf34KsEnOb+eKbmq1ETKaLA4iK8TBH9XVW+WQ==
X-Received: by 2002:a92:b10c:: with SMTP id t12mr6067202ilh.158.1590071788116;
        Thu, 21 May 2020 07:36:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f143sm3015993ilh.17.2020.05.21.07.36.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:36:27 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEaQWu000932;
        Thu, 21 May 2020 14:36:26 GMT
Subject: [PATCH v3 31/32] NFSD: Squash an annoying compiler warning
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:36:26 -0400
Message-ID: <20200521143626.3557.73332.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Fix gcc empty-body warning when -Wextra is used.

../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88433be551b7..8b83341cae6b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3881,12 +3881,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	unconf = find_unconfirmed_client_by_name(&clname, nn);
 	if (unconf)
 		unhash_client_locked(unconf);
+	/* We need to handle only case 1: probable callback update */
 	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
-		/* case 1: probable callback update */
 		copy_clid(new, conf);
 		gen_confirm(new, nn);
-	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
-		;
+	}
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
 	add_to_unconfirmed(new);

