Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6362BB759
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgKTUib (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgKTUib (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:31 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF06C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:31 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i12so8140326qtj.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=28oQ7O6FCayJCsmi8hsKcu8o7cPX/xW4T1S9Q7dtSbg=;
        b=pMdhOy31QQd80FleVndZFXR7n1Q/xTKY9AfVMD9PvC8eHP69miH+H+vsTybziEBtlt
         FT2HC46Xr9DoONkle5rVe/XcZbyZzst/H3BcfeQo5w05kA73iJ61DARIadkIVX9zqMnh
         o6e0bVIMaI1bYjlZmDUpmg8/wb5cVBBrc0GIfUgw3Slg0tfElekRIWirLb5R7fJK6jqg
         g5D1/E9vZQya1eyQ5rU6EBJtBt+jM1plK87/UY5CI8hQ0IguXZXUfEI8H/E7BVRKb4EC
         19ZGgM9wOM5qQyGu22CXB0mu+G5k6j/6lcU9Jv7eJGWF/THDakMXavrLSA+7Ym3CbvUb
         RBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=28oQ7O6FCayJCsmi8hsKcu8o7cPX/xW4T1S9Q7dtSbg=;
        b=QWGmZGOr8N545VJ8YfB0M7ZKxhwEebBmf2XwRjRKC5mtp9oVWgxDpscEj0LK6xtL7d
         /mZlv49GqI9P2CYTWYhmc2HMNCIe23SXhICY2RsL4lQtNecFHaxLvNnNOhj2Bwwxc51H
         Egb5jHm3p8YWm01VTURmqXCNhFQq5r77ILMsDY1jHBwHfYIW5v9/msmDiypZ4KWsJXnm
         H3VvFV+VcGbl7QedyHo+XKUGlODxAlUGZtSOGdp5Rs9grLluad/1oSbyZsTuP9J/s20b
         +QT4zmF2uopESqTlW4QRx08cpAO3e/sk+7acNWGLM/+ugikVWl5byYP7wOyRaUZ5KihC
         /i7A==
X-Gm-Message-State: AOAM532K9dM0HI9hWjzzzi5TcLrHj5PCmnrf5r+weRGi4201wPVke4Dd
        aSopWczdc5faCPBFEnaXRc1EzVtU9SQ=
X-Google-Smtp-Source: ABdhPJyped1V+BZUoWDxr5mGaPQXWSpemc1o4l9I5Ng93gH/hA3mc8RN66ubvNzihn/WwWxkjW5YFg==
X-Received: by 2002:ac8:5191:: with SMTP id c17mr18162903qtn.116.1605904710109;
        Fri, 20 Nov 2020 12:38:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i21sm2689241qtm.1.2020.11.20.12.38.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:29 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcSMb029361
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:28 GMT
Subject: [PATCH v2 053/118] NFSD: Replace READ* macros in
 nfsd4_decode_bind_conn_to_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:28 -0500
Message-ID: <160590470826.1340.9380897669536041752.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A dedicated sessionid4 decoder is introduced that will be used by
other operation decoders in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 82282fceec5d..48cb409f11c2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -609,6 +609,19 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_sessionid(struct nfsd4_compoundargs *argp,
+		       struct nfs4_sessionid *sessionid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_MAX_SESSIONID_LEN);
+	if (!p)
+		return nfserr_bad_xdr;
+	memcpy(sessionid->data, p, sizeof(sessionid->data));
+	return nfs_ok;
+}
+
 /* Defined in Appendix A of RFC 5531 */
 static __be32
 nfsd4_decode_authsys_parms(struct nfsd4_compoundargs *argp,
@@ -733,18 +746,6 @@ nfsd4_decode_access(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
-{
-	DECODE_HEAD;
-
-	READ_BUF(NFS4_MAX_SESSIONID_LEN + 8);
-	COPYMEM(bcts->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-	bcts->dir = be32_to_cpup(p++);
-	/* XXX: skipping ctsa_use_conn_in_rdma_mode.  Perhaps Tom Tucker
-	 * could help us figure out we should be using it. */
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 {
@@ -1424,6 +1425,22 @@ static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, stru
 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
 }
 
+static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
+{
+	u32 use_conn_in_rdma_mode;
+	__be32 status;
+
+	status = nfsd4_decode_sessionid(argp, &bcts->sessionid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &bcts->dir) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &use_conn_in_rdma_mode) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)


