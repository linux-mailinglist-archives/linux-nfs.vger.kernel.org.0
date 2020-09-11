Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABF266867
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKSsC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKSsB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 14:48:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261DC061573
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:48:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 16so10868925qkf.4
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dcpcJOAfdX7phZTBJ6X9Xgyoq5LLGtivwxggKqT1L6c=;
        b=sl1WOq58MJuy9+fM0M1MN2kiN31ThEJAdWt8ggH3iS7MORzOD6QyOGMUELja/vCk6H
         5LJD+R+DF7rBLc5XnM7Wd8agg6K4WM2/5xDhNWbGYeRpjrZl0xVLSgPf5LNogAFY7IZE
         oF5BXkZQEmZaC9+WxfKjRorFXiKqGwo0Q3oMXjYjcqnRFAn47d58yPXGpbZlUT2+0Qla
         Bl5VcOemK1yWFsrjJcEFbAhhfq53uDCfGu3ThvGqPWR/gpMge/kVuHnb31UM/bAkde/U
         qPDabKxQLAoWvReQM58h/O7vvyCYIa3CSgzbVbw4EMrY3KqhFRkLUf22Jh0hxVZypaok
         EvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dcpcJOAfdX7phZTBJ6X9Xgyoq5LLGtivwxggKqT1L6c=;
        b=EAffEvhVpQT00JKUZ6MIvm/D8ajW/9v/9SOpE3RNRspnLi9A57DhJCAmsfEhBYetFu
         pS28vq0M2UEeuhiql/mcY5YTgYXhu1oGDWFEVoMkkDdpPB8Y5bNm60xtlwoxX959IPCr
         MGNtCnavBBOiagJXL2w2wTSEqXTlh5acOuMKPm/reJ5BamBtq4SwVL77eqjp7e510bKd
         n9IJvB/Jg+D5q2GGO+Dxfzw/ugE81DeVkfYXs16eNRSTRbyqetk+Ok3PBxshwAktjiYq
         Rnfuv+NwojAh+PKAthkmu/G5qWfsM0A+rX3l/jK3BV99NMtIIAYsfGx2O2k6YU5B7G7a
         N1Kw==
X-Gm-Message-State: AOAM530UY2pGx6zqEduCtMp+n2jHhF6b5PpUUCBG2qm0IOcbwQXpex07
        lPVxx8QSdUSzDcLqpC7Yr0g=
X-Google-Smtp-Source: ABdhPJyhOYJAUa2HOYZJXGRQUGoNVO88W6H3KGUf3YwSJtIKJgGLIzoGO5dbrT5+EYPKo9Wbq2uBNA==
X-Received: by 2002:a37:381:: with SMTP id 123mr2802860qkd.320.1599850080696;
        Fri, 11 Sep 2020 11:48:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e90sm3728306qtd.4.2020.09.11.11.47.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:48:00 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08BIlx1U000615;
        Fri, 11 Sep 2020 18:47:59 GMT
Subject: [PATCH 3/3] NFSD: Correct type annotations in COPY XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 11 Sep 2020 14:47:59 -0400
Message-ID: <159985007900.2942.167096627702671917.stgit@klimt.1015granger.net>
In-Reply-To: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
References: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Squelch some sparse warnings:

/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:1860:16: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:1860:16:    expected int status
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:1860:16:    got restricted __be32
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:1862:24: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:1862:24:    expected restricted __be32
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:1862:24:    got int status

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 400b41b86595..f14d90a95fe3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1855,7 +1855,7 @@ static __be32
 nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_copy_notify *cn)
 {
-	int status;
+	__be32 status;
 
 	status = nfsd4_decode_stateid(argp, &cn->cpn_src_stateid);
 	if (status)


