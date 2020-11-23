Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563BA2C15BF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgKWUIE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgKWUID (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:03 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F68C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:03 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i199so4785214qke.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6wrDpVEo+RmhagD+Nx8qoQHWzG42nsQ1CvZhrT4NK6E=;
        b=n97CW+ke/kCNpGZ4KGcbL5CBPi33jE0mQEb8Iz2eoOt/5sDgH0n6IQorXc4AMKTWsl
         UxQBH39TLCzYA1KbpejXMho/ujdOHB/YF+z27+qtadpp6kvmcOx/umILLvn3euxdP7c7
         8pxNP9uaculDGRTLXwFO/NIMCdhD/5R2K63f1nRYyqxcJObRa/tIXaf/t+aZOOu2WCYO
         e3SvzlXbwjBwYW6LhDEfwPeAO2k6xwiHperkg/EvamiXN5pXkemth1iQyudGFgjSs1xi
         LgiYgnqAggcyySkwSLzPRKBGppclaId5+jtUBBo1plPAO2MIAAdnTrYU7ND6MU5S7GqE
         t+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6wrDpVEo+RmhagD+Nx8qoQHWzG42nsQ1CvZhrT4NK6E=;
        b=UypbtBknz47VOtr+A8RgXktCwsiF7FzohIlBfj+ciuzbLTfYjTGcWLxKZdy7T/OFoK
         DB3q55gfHMumVyFjBWlFG3H7zqBzAKxcAKNN7OkVskknDLHGB6+SV7wdSTjuSEFoBbpz
         XC+AOXPv8b+fiI38GW+oY1LP1S27wW7/UIatNR3pnZuwirVBj3Abk5eCbJwToVyT5Onb
         Y0Fg+poRJXtkN/BwC4sS+3MagInr4RjwawcFUm3owpSrFvEH+vIu24smbN73xDyOHpbD
         z1Yc/S07EUunhUCT/O5BTvubMPiDT5AVJFvuNOUbibjd0yADm/8bhCUT2cvhzBHRw9K/
         wsqQ==
X-Gm-Message-State: AOAM532Gld1El49+UW7YfAnki3IJ12Au8S4nV6W158YUvJQnjzoezg2w
        d6lC6xcovezEHywM568624olBUMIej0=
X-Google-Smtp-Source: ABdhPJxfnhyO7afz+0YHeOJXdq7kp5zXcMWTslSNSYNSd4hpLUKPle4ORA1gjGc5agaqkQJJxB32Rg==
X-Received: by 2002:a37:6296:: with SMTP id w144mr1253224qkb.312.1606162082685;
        Mon, 23 Nov 2020 12:08:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l8sm10065197qtj.93.2020.11.23.12.08.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:02 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK81fD010408
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:01 GMT
Subject: [PATCH v3 46/85] NFSD: Replace READ* macros in nfsd4_decode_secinfo()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:01 -0500
Message-ID: <160616208128.51996.15161555644579025881.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 064020c187dd..21b3b4e5a525 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1279,16 +1279,7 @@ static __be32
 nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 		     struct nfsd4_secinfo *secinfo)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	secinfo->si_namelen = be32_to_cpup(p++);
-	READ_BUF(secinfo->si_namelen);
-	SAVEMEM(secinfo->si_name, secinfo->si_namelen);
-	status = check_filename(secinfo->si_name, secinfo->si_namelen);
-	if (status)
-		return status;
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
 static __be32


