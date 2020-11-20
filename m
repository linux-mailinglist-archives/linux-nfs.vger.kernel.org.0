Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33A2BB73A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgKTUgX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbgKTUgX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBCCC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so10164182qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=efh/GwsacU+nWn6TEJsJXU06h8cS1liEo5ADwzWigZI=;
        b=tIdFF/qEzOdZVuQFpua3wf/EdWhw8SGklGIM2rCMBiqgc0BFeaxnfmONDhs0TRA6eO
         PYdktkcLVs9Q+AMCsy2+mKniJMv7U9sl71CUf2RmvF0VolY9x8fufM3OgjlbFHcBBPKQ
         AN7eV7iu2zhNneHqw10ln6lb5B/qUnDMHyY25GsBvBVQSojTH6uzn/n+jEKew+jivbda
         ITt483erXiqz7yBczVUzKTdgtUz4DbecGR8UpYRNrPcJk5f9Cw2PrlPnNM5xfTK89eIk
         jY8cZd6CgrgagzUEa4gwj84kuIbWJBTSa7So6P3Z1ilaTfDGwlYP6eb/3DN/JKBO3Jh9
         Wajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=efh/GwsacU+nWn6TEJsJXU06h8cS1liEo5ADwzWigZI=;
        b=HlcAH31RS0FeIoc7ugWCPBxsdlfog2M08cmKK84ALIh0duTkJF+EyLI3rSM7Ktz73X
         WHLEc5IqA38yjinzhr8ooBANJRFA3uC6SHsQZ+WiL8m1LnedQK5JYa0/Vtlt/Q+EMp/B
         U8P77eJ0VoG027lRF4pYdHAtTNNmx8fgSbWcASuPHhE/LjvyI3Uxz75pHnUACNxtzFL+
         AVBXH18Obn18d1D61H1lSQeBx/guivGY+bslw+h19gLi8mQILVl9t8zR9jrGyJELnvGI
         cNQgw+uEKBrrCT4RFlMsb9PvaJNXpnC8ggq2mOszK92f/Ot6qK02u67DtDITiIS7a9Qx
         cqcQ==
X-Gm-Message-State: AOAM533a3tGVrc0Sc6kQEY7DAqY5+tW7Uh8kfXsM4lq8II8A2VuBgNqW
        qRJItJAjPfWGkwvZ8y7mWOLTbBB8N6c=
X-Google-Smtp-Source: ABdhPJxT9jfswCJFkk3HJYC830ajpFAH05alN2oDRvCvHzaaiRTW/+S8ebGI/aNbZEHpcg7wv/kSaA==
X-Received: by 2002:a37:5243:: with SMTP id g64mr18595365qkb.248.1605904582234;
        Fri, 20 Nov 2020 12:36:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i192sm2986370qke.73.2020.11.20.12.36.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaKFL029289
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:20 GMT
Subject: [PATCH v2 029/118] NFSD: Replace READ* macros in
 nfsd4_decode_lookup()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:20 -0500
Message-ID: <160590458050.1340.11289077025297020633.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9b532e500e55..2fe719f64ec9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -878,16 +878,7 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 static __be32
 nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	lookup->lo_len = be32_to_cpup(p++);
-	READ_BUF(lookup->lo_len);
-	SAVEMEM(lookup->lo_name, lookup->lo_len);
-	if ((status = check_filename(lookup->lo_name, lookup->lo_len)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
 }
 
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)


