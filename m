Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0782C15EE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgKWUJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbgKWUJk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:40 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5ADC061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:38 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so14386133qtp.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WmiWZz556S6KIjcRVh9fmQMJChbZre2LBivK0xf7HW4=;
        b=ECy+KWe+N5CN8ZqEJFRt2No5XPG0mubGO/wLuq8eq/KuLBZRSSlZIm9zzzskkUsie1
         KcFfVQRyqXKABb/hwYyDYPT2UTRFtXbTyxq2bivGqpgcQEg5HRlVqTUqU0k1lGlQk9a5
         EFcbonn2UYoNdqb7EVY8Qh8mX33ERyDBVuz4J2yBaLZWHuEhyyiurQ9rRN5qUbRCEovm
         U2Jk3JFte1kKmlwUvRM9pWyCzVdndGtS49G5GqpZevOiBRNbU1C/aQp8voIfEFOQ9TvD
         FYmMLKVWKIA1+K8lbsiYYOo1sr/jK8P6wuK8pfMRrE2XplaW73vXSJfPMlcXybz2OMCh
         ndLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WmiWZz556S6KIjcRVh9fmQMJChbZre2LBivK0xf7HW4=;
        b=N0ZWexR1rIMIPnqIMz51Mhq+BGYUQbQNqqWyRlczICiPHPiQKImiJBseROtX7AiNAX
         WB4MJ3EvItDHMx7egb85PuLKx4BYdfcg7pZdVUykTFBVHzVO9HhuOgDnBCe9VNEyvpVH
         CKHE2rAjFWrjS1EE4r/DhrxVjZqYHs6yRYbSsundmzvpln9ulrRl5ryhEum8cZmSjREI
         /moxAAr8BfmJtzokJ2PXH3mMyNwEkIXvxW/bfoMvEQo1EgZbzedXQzO218lCRWhC+MKr
         ei4jtoFP/16PtrAMlhuIhvgidZSEZbbfex+aXb6Q7JbWwqmBcugzFZxIFsbaodH0mcYf
         MZhA==
X-Gm-Message-State: AOAM530vLYsBe1scoSokxCvRCdIhydXWBy1wFDdpdM9MdzqJ6C0Vr/fh
        qtMmOhstxSbp7ho5UnsevAAIOTTMzls=
X-Google-Smtp-Source: ABdhPJwlcnldg488MxeKbjaSSM5rM2mbemkjFQBhjcUW+CM0OmgNGenFb1FHsQPS2Y9DqiiIHJ5Fqw==
X-Received: by 2002:aed:22c5:: with SMTP id q5mr873500qtc.247.1606162177625;
        Mon, 23 Nov 2020 12:09:37 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t2sm5475234qtr.24.2020.11.23.12.09.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:37 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9aIM010468
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:36 GMT
Subject: [PATCH v3 64/85] NFSD: Replace READ* macros in
 nfsd4_decode_getdeviceinfo()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:36 -0500
Message-ID: <160616217602.51996.12946553675831247424.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b326d5b4e7f8..4be809f00eb1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -638,6 +638,21 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_opaque(argp, owner);
 }
 
+#ifdef CONFIG_NFSD_PNFS
+static __be32
+nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
+		       struct nfsd4_deviceid *devid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
+	if (!p)
+		return nfserr_bad_xdr;
+	memcpy(devid, p, sizeof(*devid));
+	return nfs_ok;
+}
+#endif /* CONFIG_NFSD_PNFS */
+
 static __be32
 nfsd4_decode_sessionid4(struct nfsd4_compoundargs *argp,
 			struct nfs4_sessionid *sessionid)
@@ -1765,27 +1780,20 @@ static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 		struct nfsd4_getdeviceinfo *gdev)
 {
-	DECODE_HEAD;
-	u32 num, i;
-
-	READ_BUF(sizeof(struct nfsd4_deviceid) + 3 * 4);
-	COPYMEM(&gdev->gd_devid, sizeof(struct nfsd4_deviceid));
-	gdev->gd_layout_type = be32_to_cpup(p++);
-	gdev->gd_maxcount = be32_to_cpup(p++);
-	num = be32_to_cpup(p++);
-	if (num) {
-		if (num > 1000)
-			goto xdr_error;
-		READ_BUF(4 * num);
-		gdev->gd_notify_types = be32_to_cpup(p++);
-		for (i = 1; i < num; i++) {
-			if (be32_to_cpup(p++)) {
-				status = nfserr_inval;
-				goto out;
-			}
-		}
-	}
-	DECODE_TAIL;
+	__be32 status;
+
+	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_maxcount) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_uint32_array(argp->xdr,
+					   &gdev->gd_notify_types, 1) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
 }
 
 static __be32


