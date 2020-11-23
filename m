Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D662C15A0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgKWUF1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgKWUF1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:27 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BFC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:26 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id e10so6886173qte.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3M88BWG2KaPxDVuMz2rPXZO7oeNufUPuQ1bPgNy0Z+A=;
        b=rFhwSk8uDI+UZi2B/sy0cPUj1K2gPjuZLDSQ8GETM7SW9eSAkXzkqncbezy+RtJpVF
         gTALmpyJmVnbwN+Q1n4huM6vyg0knqvzPApCMpgWMi1VuzYTLmMPMgZ+nUAaGW/jlKiZ
         TjHLGUFnzZehAK4PQr0iYt3+1y3PhQdXwpoKC7ibUjpRjsT/yE4ZUE59r7PFO0G8fvPl
         4fpBF13i6nwEd2vnG6pXBxVqZBrDxcrORTgnNDrNrJVSqjegR+d+PXNqd8mzN3zS3GLr
         kQwPhQLlG+XIIB1OkXqpNAMciRhaU6hWHCiYMSR5vr2eoLfTRnwoGG1zHS+hGHJckd5L
         shfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3M88BWG2KaPxDVuMz2rPXZO7oeNufUPuQ1bPgNy0Z+A=;
        b=L1FtOZo3Tyt/Calx5TAl4gCDOq7jW2PRS3Aclep9b0Hp0AOyqPOX/j6Al0giZuH0dc
         w9a1h+40GBpuyxNEqe9lK2Qf5UKhph1W863Wy+HMLvlXxQcsUXHt3wAhtrnCgtW5BJe0
         4LdZsMmIMx0y0zjy6HB4kgWR5TPeIubYcdyumQwQ6nQIb7LNDc5IjWn3TYhTKsfIx9yC
         mMdvT+FD9yyCf28dnF2q3agSXWDrLmZLsvZdVcarHZyLsLW8BoKs1ou7TBi7P09hXHv+
         5g/QD3Bva2YGOgWyz3jmG7hUTdHoNVq2lZGtmYtmuN7H4pW6i/4iV2tRrv5gubdn45aT
         I+Kg==
X-Gm-Message-State: AOAM532a+RvRY8HUf4lkHx6/uf38F6KXH9wqIa3R1NcR+KV3ga483/ac
        zbOLlD+oSsZxmFnvoKO84fsUxgBL3wU=
X-Google-Smtp-Source: ABdhPJyiiSERQJoPWQffdHGw5ugtd82izVIAJfHqu9jLKudoQ/QLutY0gNRJdSEbrLR9xlWTmqJ0ag==
X-Received: by 2002:ac8:444b:: with SMTP id m11mr930454qtn.122.1606161924993;
        Mon, 23 Nov 2020 12:05:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q7sm2604044qkb.22.2020.11.23.12.05.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5N0H010316
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:23 GMT
Subject: [PATCH v3 16/85] NFSD: Replace READ* macros that decode the fattr4
 time_set attributes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:23 -0500
Message-ID: <160616192333.51996.682877163956950323.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e5f73bfc79dc..2668c150042e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -219,6 +219,21 @@ nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 	DECODE_TAIL;
 }
 
+static __be32
+nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT * 3);
+	if (!p)
+		return nfserr_bad_xdr;
+	p = xdr_decode_hyper(p, &tv->tv_sec);
+	tv->tv_nsec = be32_to_cpup(p++);
+	if (tv->tv_nsec >= (u32)1000000000)
+		return nfserr_inval;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
 {
@@ -388,11 +403,13 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_GID;
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		switch (dummy32) {
+		u32 set_it;
+
+		if (xdr_stream_decode_u32(argp->xdr, &set_it) < 0)
+			return nfserr_bad_xdr;
+		switch (set_it) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			status = nfsd4_decode_time(argp, &iattr->ia_atime);
+			status = nfsd4_decode_nfstime4(argp, &iattr->ia_atime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
@@ -401,15 +418,17 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			iattr->ia_valid |= ATTR_ATIME;
 			break;
 		default:
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		}
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		switch (dummy32) {
+		u32 set_it;
+
+		if (xdr_stream_decode_u32(argp->xdr, &set_it) < 0)
+			return nfserr_bad_xdr;
+		switch (set_it) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			status = nfsd4_decode_time(argp, &iattr->ia_mtime);
+			status = nfsd4_decode_nfstime4(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
@@ -418,7 +437,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			iattr->ia_valid |= ATTR_MTIME;
 			break;
 		default:
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		}
 	}
 


