Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5B326A50
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Feb 2021 00:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBZXFc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 18:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhBZXF3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 18:05:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F7C061574
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 15:04:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gt32so5871515ejc.6
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 15:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=cB2016358WDRES3I+d4CnIlyAYqtK2wddIglZ1rqJiE=;
        b=gSVVwTv7R7PBHracyifM+ygkZ7wUQqjdmEXUap6pmS6HvTdlv+eK5FpjjtGjCP61fv
         YXlv6oD5OD47B8ZgdwTquNX3rw/hfKn/63BHoC3ObomBI5ioHhApl3poxwyvUaP1FjTz
         88DatYGk9y0ng0DVN85oU7he1sFqxNNqbcItw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=cB2016358WDRES3I+d4CnIlyAYqtK2wddIglZ1rqJiE=;
        b=GYAeRRVmCPxftKkeEnPrPIIW8QAPrqyRBou5cceDTj/YZU6I/JbL2N0tmnX0BZM951
         Rwjx57GRmOryImclcjmnQNjRbA07IgjRdUAVlG+82RT1+UEK43FDo638yD1WsXPJ1Pxy
         hhzDycwP89Qz/4HHH4hkatVPsDpmMvHk6yH4U6c5IoOm7gRV0MIN3K1nVCF9Q7e/Ch3x
         /H+kHdRJWTUEjRPLtfiWYJLNCyk3Vf+aXuR9Hcl0AkEH6fpC4Ducqd15UG3Uz8o814mf
         fkjBPiye4cZItbNZ7mycyJm1GpI4tDXs7zhnMOgcCOeDBiR3MpQAXIIRlkfjOFMVE2zq
         HnGA==
X-Gm-Message-State: AOAM533E9kNK7QHm8VDprLTcfUjyMxYCOHTyXJF6Hyv4o/b/C2ha0qTp
        dP9Irf8n5TlRod4tIq7kPuGRcB5SOTYzoGwNZjrYle8lQHnzrAnBq82/fb7dBXnAc2zrLNrW7/D
        iykelcX+OOUyVfzq0KibKrw==
X-Google-Smtp-Source: ABdhPJzKkAyXPWnf0Owckhf4CG+aasQOtVWT/C+6d/nsasaf/1NTsm7RX8rOYQrl6sakvlM7HFjO1w==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr5747991ejb.355.1614380687643;
        Fri, 26 Feb 2021 15:04:47 -0800 (PST)
Received: from tuedko18.puzzle-itc.de ([2a02:8070:88b7:3700:5585:2577:34a8:395a])
        by smtp.gmail.com with ESMTPSA id k5sm6221193eja.70.2021.02.26.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 15:04:47 -0800 (PST)
Date:   Sat, 27 Feb 2021 00:04:37 +0100
From:   Daniel Kobras <kobras@puzzle-itc.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Message-ID: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If an auth module's accept op returns SVC_CLOSE, svc_process_common()
enters a call path that does not call svc_authorise() before leaving the
function, and thus leaks a reference on the auth module's refcount. Hence,
make sure calls to svc_authenticate() and svc_authorise() are paired for
all call paths, to make sure rpc auth modules can be unloaded.

Fixes: 4d712ef1db05 ("svcauth_gss: Close connection when dropping an incomi=
ng message")
Signed-off-by: Daniel Kobras <kobras@puzzle-itc.de>
---
Hi!

While debugging NFS on a system with misconfigured krb5 settings, we notice=
d
a suspiciously high refcount on the auth_rpcgss module, despite all of its
consumers already unloaded. I wasn't able to analyze any further on the liv=
e
system, but had a look at the code afterwards, and found a path that seems
to leak references if the mechanism's accept() op shuts down a connection
early. Although I couldn't verify, this seem to be a plausible fix.

Kind regards,

Daniel

 net/sunrpc/svc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 61fb8a18552c..d76dc9d95d16 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1413,7 +1413,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
c *argv, struct kvec *resv)
=20
  sendit:
 	if (svc_authorise(rqstp))
-		goto close;
+		goto close_xprt;
 	return 1;		/* Caller can now send it */
=20
 release_dropit:
@@ -1425,6 +1425,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
c *argv, struct kvec *resv)
 	return 0;
=20
  close:
+	svc_authorise(rqstp);
+close_xprt:
 	if (rqstp->rq_xprt && test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
 		svc_close_xprt(rqstp->rq_xprt);
 	dprintk("svc: svc_process close\n");
@@ -1433,7 +1435,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
c *argv, struct kvec *resv)
 err_short_len:
 	svc_printk(rqstp, "short len %zd, dropping request\n",
 			argv->iov_len);
-	goto close;
+	goto close_xprt;
=20
 err_bad_rpc:
 	serv->sv_stats->rpcbadfmt++;
--=20
2.25.1


--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Eisenbahnstra=DFe 1, 72072=20
T=FCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=E4ftsf=FChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=F6hl

