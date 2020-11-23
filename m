Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8BB2C15A5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgKWUFw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKWUFw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:52 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DCC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:52 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so3719185qkc.13
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JgH9BpW90l8ZCvcLzt4BID4EhzQfgb2TOjzLRJKep9A=;
        b=KOyKRc2BnSKfL5VcYdaRZzJQlKxwEenmbwMXyNjYIh5aKlFigXtdIM0tZ86EPfDxUz
         t6EC+1ktp284tcb9fUM4dMoaS+R8agaDbI046LnfFlqC3YoVK8N/8W9gS0yszqADSL6/
         dcZyqa1+Xm+4NJ8dqscFRXKB8C+wYsniu/BqnyJcVp/r/RRf0LUfTo1fZ4jVhU1nNPNQ
         eeEY4uUMO4v4pVeeqEQXNmBWGzYTYvMKRa2OL+PfSa3U3NKucmppTTLXbeJZ/VeLJKmD
         tMq6S1hUfjMx7lhhI4bw1Qzq/8F5qcQvT2PifLEJrc4DDaTcEMhoryle9Y+oCr09uh/D
         /Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JgH9BpW90l8ZCvcLzt4BID4EhzQfgb2TOjzLRJKep9A=;
        b=P27C5sndSHfI91jMVDusCVw5no8AqV6pFXTDWsO7l5NeEyN0ohIEY6GahaceAFEYmz
         WJdQDaqZaIee0sYPGqeofEiZm94z49oYGAXU6JSz3C0wb+/lqV3Qf8HYmZojyln9YQtl
         CBoEz1Wcm7DyP49XsmNi+jwBjo8hhTcB5NQ1ZGlSBU1Pe6Uv78pp+gtw0HGngNEptCjE
         I/txmBSW9G6uYbOgcDovLQLd+QMNDuWWWmdMCz/VBSFsRKzEKaUG5mQmxelS9p+x4r5i
         ThrfSeISW4SrshzmlelZ9LhkxU51Jfi6TH+OkhUWP7WnC3QWWaIObQCFEQNWHRLrVhun
         jhBQ==
X-Gm-Message-State: AOAM530srMEty5fSCXCKBAauSTmN5HRA7YXHXrN3tMQ8fT542Lzcv33u
        JoVix5ud8y4pPWPPVrTWCSfLKtRQNQ8=
X-Google-Smtp-Source: ABdhPJz5iX79SDV0wvA8gL2Pb4O2dPZnS+vL78UJ6lPCYcFrJiJask34AOn8zuTeCxKUPOa4/P8XdQ==
X-Received: by 2002:a37:793:: with SMTP id 141mr1259847qkh.215.1606161951133;
        Mon, 23 Nov 2020 12:05:51 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm10309601qtp.5.2020.11.23.12.05.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5nKg010331
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:49 GMT
Subject: [PATCH v3 21/85] NFSD: Replace READ* macros in
 nfsd4_decode_delegreturn()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:49 -0500
Message-ID: <160616194954.51996.14513409527990281508.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 59f5cd2575bc..cdddc62a8fb4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -766,7 +766,7 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 static inline __be32
 nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegreturn *dr)
 {
-	return nfsd4_decode_stateid(argp, &dr->dr_stateid);
+	return nfsd4_decode_stateid4(argp, &dr->dr_stateid);
 }
 
 static inline __be32


