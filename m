Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFE2C15FE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgKWUKQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgKWUKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:16 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE52C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:15 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id k3so2600920qvz.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EaSaDwTpOwckou5Mlr5/K/KUgYlZxkLJP1fujrokd7Q=;
        b=cHlT6QJctDTip6HK1D+Ih5dc0TbDZuxeRAiNUKwrcewrzJQHWpAqmV5CJSkAfkONGP
         r54g3RZtcMH6z6mFuptt7SBnVLSep0H2wpYSlUTKghws8l3baRqr1U6wxuFqWpDnz32J
         bLOUIW9kd3pkVaF1MKgxguRHxzr459feyt1M93mSEnAwgXB5JJ9jMvEZT7c7n7yqOJ++
         2lMVOh26DEhotOhHCnNf5T1fDqsw4QOMhEVJnWfOYrqlYBqgChyoVVsfTGI086QV1uAQ
         rkqz4nG2O1LS3URrXSgd35bNkDolEnsybsYK/fTKRL/BYNuKtQ+H8v1C+BXg2lAZ/Atp
         rK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EaSaDwTpOwckou5Mlr5/K/KUgYlZxkLJP1fujrokd7Q=;
        b=irOaXh/IRLnjnyaU1EN8z8pUrkmYdYKqrwogJCi179bh7CIpKmn+la0XYqsZSJRSY2
         WKdr+Y6ZkkPX017cAP0L+zArZIENtdiz3BIJoLA/cgXp0k7Oqiq1ubz4HQ2FiUrEuib+
         4WsjmIgTyP6gMtEpFrTxCWbHuwze64e5m4IffEInJ/QG9V00ozOWa+5K0lqnyry6AgR9
         8H1xnYHE+xrumbxwH7sfoIR4JqMeq5toYq5wSZyDtng7iAWZpvWGjdxI/IbLqTPCcSLf
         a76lJMo9CXQVRtch71AO4hCkLWaIv0W8xM9lDVadBfOeQPaOVV92e3+WPP0A0SMLc1j8
         pEUg==
X-Gm-Message-State: AOAM532cjlVw+3sqbVp/KnnThIuQZEHCnmXbVyoYlkXIqnEjrKgM29eT
        xgXCSF+DPLlV2mKqUOcMGQySY9kmz4g=
X-Google-Smtp-Source: ABdhPJwLOvCjFpq1cz6+B2uIyw+QoPclGuqovCakNVEdiPZkwmEPpmyKrKaTCD48LQu3hfjAtmy37g==
X-Received: by 2002:ad4:5483:: with SMTP id q3mr1240795qvy.24.1606162214742;
        Mon, 23 Nov 2020 12:10:14 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p128sm6182304qkc.47.2020.11.23.12.10.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:14 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKADUC010497
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:13 GMT
Subject: [PATCH v3 71/85] NFSD: Replace READ* macros in
 nfsd4_decode_destroy_clientid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:13 -0500
Message-ID: <160616221302.51996.10543965890986609670.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 937f5262d619..8225e3994204 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1738,16 +1738,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp, struct nfsd4_destroy_clientid *dc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(8);
-	COPYMEM(&dc->clientid, 8);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
 {
 	DECODE_HEAD;
@@ -1908,6 +1898,12 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 	return nfs_ok;
 }
 
+static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp,
+					    struct nfsd4_destroy_clientid *dc)
+{
+	return nfsd4_decode_clientid4(argp, &dc->clientid);
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


