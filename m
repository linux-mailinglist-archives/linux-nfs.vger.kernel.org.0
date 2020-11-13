Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAC2B1DFB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgKMPDZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPDY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:24 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A676EC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:24 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so9045788qkf.0
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=M/KJauthuoIsBEhe95KGgmBfOzjpu3BiuGyio/qKBcg=;
        b=alOntFCW45mHTuLAYoR1fW3TpzEkSpLitMJbBovzx8SvXWCjqAUZg8DAPb5Tq3nm9m
         obtKltbE/BmXXmBeYdmnsSrR/POxYq8lEOU1WDWvBrQSCE213++j1vkHjNYPRh4vwmJS
         A52kr2tbzj5d3Y2kokgSo7J5sDF9XM8MuXeoymG0X3O3yKoXA+GkamyckQvvF2H+GNSP
         /Pvzv52WPt+EpmWzFh74ExvSOv6IGVrYHxqqLoNfEqCtdxZam2Kd2ZCkdNZrthfyWEQX
         ZC5/TymrPBoBujw6A8fLJEgdBcnZ8tyoAGVwHSYQ26W9z+QztVvYqEG0/SY0syq5BRUO
         ct7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=M/KJauthuoIsBEhe95KGgmBfOzjpu3BiuGyio/qKBcg=;
        b=QoOAeVFphr81t7GbNjt4xTd05uu94SZ8gBi28WATJuXjmNFzR0ibdbCZsCE7HfMFNA
         x4o5Vd+l4QAw9FCR0byvdz91vTzAT8MGqsAh15g1tl1eNqxG3LqKT390UcLXgcIKlWas
         StVUptsGGpAOrZknMynjfcrBy3NJx2kjA4OEzfa3KN88zr7U83Jfyimo+4oH/azIxjFW
         M0UKEbC3qdXHfVMyYTxqt0/Ky8bvHAe5DIs+F5ZkZMGJhhME/dViyxYvQ6hNWQO0ezqd
         umDbysImngbSHI+ss2x9mlAUrdEAH9h+NIen+CeirnfK2Rg6wo4FRtL9kqZsdBcjs2Dz
         vbTw==
X-Gm-Message-State: AOAM530rcVpt6WDszpMJGgI+xXKqPoUPxtxXFEDqYkasQUfy6Jt7OXld
        BFVQ2+TMUtaIWzfQRChlC33AkXNg0No=
X-Google-Smtp-Source: ABdhPJyL3w/Qf0Hx9Re9Wdv6XRFk/QeZikm+HDiXMinio2LFjEFRIgNwkLv5e/03q/JqBtG8vYYnDQ==
X-Received: by 2002:a37:58c6:: with SMTP id m189mr2435911qkb.129.1605279803552;
        Fri, 13 Nov 2020 07:03:23 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w184sm2493342qkd.47.2020.11.13.07.03.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:22 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3L8c032670
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:21 GMT
Subject: [PATCH v1 11/61] NFSD: Replace READ* macros in nfsd4_decode_link()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:21 -0500
Message-ID: <160527980131.6186.7010248173254076345.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
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
index bc36c746b293..970c647f8df6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -673,16 +673,7 @@ nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *geta
 static __be32
 nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	link->li_namelen = be32_to_cpup(p++);
-	READ_BUF(link->li_namelen);
-	SAVEMEM(link->li_name, link->li_namelen);
-	if ((status = check_filename(link->li_name, link->li_namelen)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
 static __be32


