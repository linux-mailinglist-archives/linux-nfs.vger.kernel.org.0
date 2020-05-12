Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565D61D00D2
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgELVYf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731334AbgELVYf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:24:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27634C061A0C;
        Tue, 12 May 2020 14:24:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so12448667qts.9;
        Tue, 12 May 2020 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=S3EtqSkTBfvGqy3tMIEJwg+iT336gbBxx4CTFb+MbL3f/0sh9Wy0yAuOif7nVxy5OY
         17Jkg3UOUlxZQ0sHApoQUmFMZiCZ4IUp3j73Fk7kRg9dYA81v8AzEXByOTaYlwD9rnY1
         2nRtFnpcJeXyidTQ63cFHU/01PbKAYtgG749Oau0yJlWrZw+I1ttDEa4R/XhgbyYQKcg
         9zdiP2V2SyqpIMwWvgnKefSQvXMC7QQoaN55iaNVn6X4T6jsRii3kbNYgXCPTULgIB6H
         XQErwnQqUVdvQ3s6U5F4oh2yBvf5DN11WUSTHNebk/X05CqyBOZn4I/w/JMR/mF8RPQy
         XeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=qJvzWc6VnGe8XptSL7JnVuLb/02fikyi/S8j5ghvuvJrOrBgbxQ10VJ21AQgaUrwNE
         AvNNYC6ZWXa+tLsCSyDT/eHlMyDTkn4nULtnzWQQuz0zz03AMN6J03p28DpOjSGXA5Wd
         KSjSk4ym2WOU/FxFMaL2AyPnMUsfyFQgM5Cx802PIXbsulL+eHVpG60Uf4MpB0DvPsu9
         mKsktMv4a0Cg/f8RbGN8jP0ePG2dRB/wDSl6/d7Rczi4XD4EkPB6oeKWM43IT2fqEczq
         cMuLd1ssuczXIXDTrgVVNlYu2Ak0d4Bl6s6QO+MgNCI5g3akSKZU32x/tCJfM85x5yrU
         QsAg==
X-Gm-Message-State: AGi0PuZMaRAF3WF7jdgDucY/jEaabMr+iRm9e5sSVtnvz+CVc5ZBGWd2
        farC6M8rSCRCFhGLikD/Lb1GjiKC
X-Google-Smtp-Source: APiQypK5Y75ctGptTBbtCYEnnRw5CsbuXaOYHxbVvdbeHsbIxE7iQMEru8OyEH1DL8RJ19w/0sVlFw==
X-Received: by 2002:aed:3ac3:: with SMTP id o61mr24403502qte.132.1589318672723;
        Tue, 12 May 2020 14:24:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a188sm11521281qkb.68.2020.05.12.14.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:24:32 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLOVR3009960;
        Tue, 12 May 2020 21:24:31 GMT
Subject: [PATCH v2 28/29] NFSD: Squash an annoying compiler warning
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:24:31 -0400
Message-ID: <20200512212431.5826.89537.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
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

