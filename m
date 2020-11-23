Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBB2C15E6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgKWUJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbgKWUJX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:23 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F196C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:23 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f27so4800151qtv.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vY14K9HjPNANhQMuRDefDP0SeKwcKICSeZuiBq4P6rM=;
        b=t5Tu8XMClEmuSgDpcYZo3QoWWBrohUx4lmXVdyEAPMI237ZOwXG/EYTpBqpFbQICPa
         ATaIT/lQAOTh/ogfg5br80e62J6ABvwJEbZjxXLGQQFQKxlV8TVGr5fh3i5z3URVBto4
         P1/cj+3EFpSTxaHu6NE0ELKNGmmRTkb0k7E6ZU9pXXY1q/uhSL7oMAJux6B2hacsaqZZ
         0yet93TqiS4Cgr/YlJQeY0lLiQhhQVpe1hdlWffQfoUgJWfQwlNGDVDVS+qNZicPS2sS
         X9jaaMc5V7V+2qFtVvMEBf4LbXq4Gx8YtLznz1DYqzK1een6ol7CbGlLYoa+0P2ZbUto
         vnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vY14K9HjPNANhQMuRDefDP0SeKwcKICSeZuiBq4P6rM=;
        b=GwAZJMoc5HSuZwsQyn8B1d+3pISO2+3EwwbbeEuguNajRy67FjdtfWUukmfmQ32jX1
         0zh7i4MEorbcNSAjGOIcaVZREZpL5rMzEMxMN/BBP2ukVQfFJ1vCFmuCdrd+4XtL1+hv
         OtjLs23/4gNxr2/fB9qkE4ZTPB2OfeEnyjlLMsuFAZHvUjrRnfiV4c9nebipdAo5orY8
         jRwrSM6ckjB5bq7TS7fatFhxR4bFaeKg8aU+rVkZhP7xCy8zwMnmvGFd+VVFlnpLqXSg
         JpCjOjurb5ZZ2WmodgWyWNi4R5/Wpe9oZokJOt+f4ON4Fat2a3rWJDJDA9AU/zoB1+ja
         HYfQ==
X-Gm-Message-State: AOAM533uKVjPskfcAOFlwopA9+ih1ghH0E0NvNZUMGmv8qGcWKVBfWmi
        Xr0YQM2/eV3qryymYyln5gNQjW9fUD4=
X-Google-Smtp-Source: ABdhPJyoctxYieTeMYAOq+rYeFEgjYLduGocIwNmEhOLPyC2EqnA1wicMkxUFWM5IlXDT5N/hHrHYA==
X-Received: by 2002:ac8:59c3:: with SMTP id f3mr876389qtf.214.1606162162139;
        Mon, 23 Nov 2020 12:09:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t63sm9764470qka.128.2020.11.23.12.09.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9KDD010459
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:20 GMT
Subject: [PATCH v3 61/85] NFSD: Replace READ* macros in
 nfsd4_decode_create_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:20 -0500
Message-ID: <160616216016.51996.46404110576435704.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 06de62f8185c..3904ebe8077a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1650,24 +1650,28 @@ static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
 {
-	DECODE_HEAD;
-
-	READ_BUF(16);
-	COPYMEM(&sess->clientid, 8);
-	sess->seqid = be32_to_cpup(p++);
-	sess->flags = be32_to_cpup(p++);
+	__be32 status;
 
+	status = nfsd4_decode_clientid4(argp, &sess->clientid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->seqid) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->flags) < 0)
+		return nfserr_bad_xdr;
 	status = nfsd4_decode_channel_attrs4(argp, &sess->fore_channel);
 	if (status)
 		return status;
 	status = nfsd4_decode_channel_attrs4(argp, &sess->back_channel);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->callback_prog) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_cb_sec(argp, &sess->cb_sec);
 	if (status)
 		return status;
 
-	READ_BUF(4);
-	sess->callback_prog = be32_to_cpup(p++);
-	nfsd4_decode_cb_sec(argp, &sess->cb_sec);
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


