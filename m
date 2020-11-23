Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE62C15E1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgKWUJO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgKWUJM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:12 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584B9C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:12 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so9451237qvb.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KtglniT35niCajf4434oeyizSzqWor46WMmpz88zeFo=;
        b=V5heRJj28IG8Oh3AmogSIl5yWmHnoUxtr2wuLe96IK3ZLtOsdcIKss62NbhsIKYmZN
         3SWBogLyMtLPYfR5a8isOsUPlnwAYEeVWY35dlyyorvwPhdyNuM5+Qhvz/uom+Ahzw7H
         Mz7AArWeHvOvJ9IJjzuCKnaLXvyy55qZyjl19dYpOiENTerkqzAzE2scoClpqo0kRa8A
         T9N6GU7COLkYQNcSzTyI2HwW2HmRRLlvYtkU+tKcxLRc4bh0EfcICKCIYCswph5+sCnT
         bpGpi4Fisef6jJ8HO3aEgTJ9yGjH1ytKJe8hE72yquZlKlPJb4dTTNAgl4Kwit58hoiM
         FrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KtglniT35niCajf4434oeyizSzqWor46WMmpz88zeFo=;
        b=homT9rCbjqQ0Wbai5dRSHPQAXiLgX15lc6ky5lvUk33dkntHF5GeMqbXx8okQaY2lT
         LoZcyYP5spGr9+Pz9OmGeyFKe0HdytkogPZRUdPwEM0cpZTmNlJakZROdpnviGYbunYy
         KnI9qPGIaPFKa/Kbxz44jinkqUYQEeQrWwQvzHpFkz8AMCJ2ZZEgOR4+TD7ukVpvgw+9
         9mmxscZPsshvIT3syna9rfLqs9InvX4ddrTfzpW6W/OhvwuLS+53L+XOx46fFgpE3q2a
         Y8awNbn4cOU5WOKfbAEc3IMyivYzqZPNdvOJ36R7hxFWUtKfLzcOlctDOBLFB2UHlRq2
         MNog==
X-Gm-Message-State: AOAM530F3BwevL+1Ii9Ofk045uqhrN/AVBNGzprOn5Ps/dEMErsTiCcV
        L25pxYiwsbm7dgxbRsMWVSVSJLGs3eY=
X-Google-Smtp-Source: ABdhPJxW0ajluUazkGWdlvCgtdww0tu8kZuqqlwskeO9fVucXVkFneUSUsMsiYUtX0JkU5q2zXNZ5A==
X-Received: by 2002:a05:6214:504:: with SMTP id v4mr1132259qvw.38.1606162151315;
        Mon, 23 Nov 2020 12:09:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x124sm6514096qkc.25.2020.11.23.12.09.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK99Rd010453
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:09 GMT
Subject: [PATCH v3 59/85] NFSD: Add a helper to decode nfs_impl_id4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:09 -0500
Message-ID: <160616214959.51996.11303465966055146170.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   63 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ecae29ba9bb7..c74aa6203989 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1558,12 +1558,47 @@ nfsd4_decode_state_protect4_a(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_nfs_impl_id4(struct nfsd4_compoundargs *argp,
+			  struct nfsd4_exchange_id *exid)
+{
+	__be32 status;
+	u32 count;
+
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	switch (count) {
+	case 0:
+		break;
+	case 1:
+		/* Note that RFC 8881 places no length limit on
+		 * nii_domain, but this implementation permits no
+		 * more than NFS4_OPAQUE_LIMIT bytes */
+		status = nfsd4_decode_opaque(argp, &exid->nii_domain);
+		if (status)
+			return status;
+		/* Note that RFC 8881 places no length limit on
+		 * nii_name, but this implementation permits no
+		 * more than NFS4_OPAQUE_LIMIT bytes */
+		status = nfsd4_decode_opaque(argp, &exid->nii_name);
+		if (status)
+			return status;
+		status = nfsd4_decode_nfstime4(argp, &exid->nii_time);
+		if (status)
+			return status;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
 {
-	DECODE_HEAD;
-	int dummy;
+	__be32 status;
 
 	status = nfsd4_decode_verifier4(argp, &exid->verifier);
 	if (status)
@@ -1576,29 +1611,7 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	status = nfsd4_decode_state_protect4_a(argp, exid);
 	if (status)
 		return status;
-
-	READ_BUF(4);    /* nfs_impl_id4 array length */
-	dummy = be32_to_cpup(p++);
-
-	if (dummy > 1)
-		goto xdr_error;
-
-	if (dummy == 1) {
-		status = nfsd4_decode_opaque(argp, &exid->nii_domain);
-		if (status)
-			goto xdr_error;
-
-		/* nii_name */
-		status = nfsd4_decode_opaque(argp, &exid->nii_name);
-		if (status)
-			goto xdr_error;
-
-		/* nii_date */
-		status = nfsd4_decode_time(argp, &exid->nii_time);
-		if (status)
-			goto xdr_error;
-	}
-	DECODE_TAIL;
+	return nfsd4_decode_nfs_impl_id4(argp, exid);
 }
 
 static __be32


