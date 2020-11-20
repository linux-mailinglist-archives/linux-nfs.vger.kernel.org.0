Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493532BB76B
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgKTUjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbgKTUjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:13 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75832C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:13 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so8077161qte.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mTPqBtLQH/dArrbDQ4IWLAGsko/D9O5IM2XaFqZPnWA=;
        b=V6qVIZXPMqXlKkJrrssTv40MnI40jpKjigr1iweXSvVx2HryBwi4n3W223lDj/FJaX
         f8I3NO41T611Ynq7UKrJjtl1d+kOSP3nh9XFBJbwZ1f2pBH/aPBq/4azVfXcNroRurj/
         tmdfN7QZ6byxpoiyGgMOXgIIJBFcl1G6atL7thFJwOVEoMOvYzDNpdW1mJ8cGTgWB8CH
         K574sGgWzyA0KRvNvGp/vWaJORuHKYtfA+kduK/CL4Tjqa7d/oFW5LK1StCtgfnglPoe
         br9mdJx87sofx77MhSGo9WodWFe7QTV3eIg1R+aC51ipxGNs6cu1dDP69p2YUAMKcslK
         ccuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mTPqBtLQH/dArrbDQ4IWLAGsko/D9O5IM2XaFqZPnWA=;
        b=B16xeofIpDlhFrvFbPNe6D9kVudksZrZcRx9231QyNMIAARpSmJE2dDv5+w9x2erD7
         poaWBz6t3MpCxlivTL8EmNaAWAc8hqzLJGXsgxSSGRB/lLJGTQmG7sozBEutTppPJ5ez
         O+3g4FZjxpuilSDFPsP0OFa3tuWcJ1GEZMHlULLFqUBk5ZbM/3BLSV9mpi/cCfPMAceC
         QV6TLSpocPoFlg+fzvQ0bcGFB4ioOH57lfiPnNlCPYPjOqtEYcJKhFBZkQ6kiLI0er2J
         PZJBBwS6hE1lpebNv4rUlXkpdv+y1t9iGQfGRnAvHABAOxeDPOIhp2u+byyVr7bNMFbG
         gG0g==
X-Gm-Message-State: AOAM533ypzwzCOGnuR925TaR+lM7rqBolDfPegzxSb+H/tRzZuycj2RU
        /FajRrdhBH+PHEOawdNl4xjXe/Dlaig=
X-Google-Smtp-Source: ABdhPJy54WTNRz8QeWgMcAJipITH930yC+4b6ElknyxnBUGFpcfdEMeuB8tX+ebyna6IMIfH9kHMCw==
X-Received: by 2002:aed:2051:: with SMTP id 75mr17156783qta.332.1605904752384;
        Fri, 20 Nov 2020 12:39:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e10sm2741321qkn.126.2020.11.20.12.39.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdAG5029386
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:10 GMT
Subject: [PATCH v2 061/118] NFSD: Replace READ* macros in
 nfsd4_decode_free_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:10 -0500
Message-ID: <160590475062.1340.1655685411758152083.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9c17cf541e8c..1fb79a597b47 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1626,13 +1626,7 @@ static __be32
 nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 			  struct nfsd4_free_stateid *free_stateid)
 {
-	DECODE_HEAD;
-
-	READ_BUF(sizeof(stateid_t));
-	free_stateid->fr_stateid.si_generation = be32_to_cpup(p++);
-	COPYMEM(&free_stateid->fr_stateid.si_opaque, sizeof(stateid_opaque_t));
-
-	DECODE_TAIL;
+	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
 static __be32


