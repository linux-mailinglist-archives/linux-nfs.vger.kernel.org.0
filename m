Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D741E91B7
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgE3Naz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3Naz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC82C03E969;
        Sat, 30 May 2020 06:30:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so2280927iow.8;
        Sat, 30 May 2020 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=Rrxco8rusXJveTtATq8HD1r/4r/Qd89EwHNF5LY77kx/8w5YAt5Nq19ralT9+8BfTx
         8ekbj/m7htOI34rb3f43NXS8NElXbB7+oTnVaZRs1NaXQBjFNwW/nu7c8Z0fp/5hfd+R
         2te1o906Zrw6S0hL05ujZ5zhQyokv4ocmNhzay8VW/kL5BPTDi7Cqh0QVE+RzYxKpxSA
         Ye/UteUPOqzqLLr6HF3EmrOabuCk3nBVCRcO2EwZooRzI0Z1ODIlBYi/viA21LKOAjfw
         dsdhetCfD30GFKwDPpeJcpxYdwPLYE7iTFFtSbb8scGYm2r3Pg86WsCmUH58XpeZKs7k
         PnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=fKUZyJBuON1KdKfrUK9/jApeVTo3mYBJ+BKcqkwsPtRtW5ddQhFCbe0KSAADFQIcRU
         QOkL3wvikyUuPhzZfROSOynQNW7BpPIu9HIDzPlRCERS+GhfNsFUUoWYVs062Yyb+4YF
         mBYShtB8sXM6iL56zrnxD3DqAwuSXCNJJhMqrwYyx9LMsnFIlYx3s5yC2ZiYujYqPGNp
         sepfA01LjUKRUWEhqcC9jQBKty2ALgOXATLt/2SiDz483AtKqoXs//XIVv5xrQEqT8RX
         sbDsglE9B5+BXVhivsHIFQYhr4X1tagkVef7nWEAFfMg91dEe18QOe5HKRblmgMhK+Rt
         UYLA==
X-Gm-Message-State: AOAM532zXstGfrR8UXS26R7BTqovszOl7XS3TrBuKS53pyDPHqvT/EMB
        dlVNOCJMHG5OlHJEVBrZMngABQlo
X-Google-Smtp-Source: ABdhPJyRyFOkfO/zEPwPejvrsxAwQscsqUTIGBniN1Pyvai45DHVghJxPvdstg1gjvhgK80zv/ip3g==
X-Received: by 2002:a05:6602:2f06:: with SMTP id q6mr10981543iow.135.1590845454447;
        Sat, 30 May 2020 06:30:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w15sm886456ilj.21.2020.05.30.06.30.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:53 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUraG001489;
        Sat, 30 May 2020 13:30:53 GMT
Subject: [PATCH v4 32/33] NFSD: Squash an annoying compiler warning
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:53 -0400
Message-ID: <20200530133053.10117.49466.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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

