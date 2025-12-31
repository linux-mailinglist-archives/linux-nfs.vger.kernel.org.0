Return-Path: <linux-nfs+bounces-17376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA771CEB0B8
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40699300F301
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD72D7D27;
	Wed, 31 Dec 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEFNTpmy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701942E22AB
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147745; cv=none; b=ZnTX3Jld1u+6vPVArw+XC/cKqh12QWpUPwtR7CmzAkZRTeWaykIj1mp5hvMinAUWwspHRpNZX8F1FBgY8no11BrQ9y+PTmKv8+sj9z7H8pxQ5wjf0D+uDGH+9VA9GdaE2IjXie8sNAJ5E+6Az3Ps93RNxNmAzhWSPVrfqpwJlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147745; c=relaxed/simple;
	bh=1aEg+pRJiFXjvyRV+fKgkgbBEH1yGV3ErYlXskb4Lqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOUXmBzH32Xh2/pD5bCKKngzb+05V66qZwGmoMTAnVC9Cbb2YGrV5mZyxZaryr573ktNFBogSDxn6Twn7DoPTojF8h6KLWM8RIadAl7+2IHMGlBp+nccOBvDUbiddwT1MvRynPewXBrAZHp46BX1clVLRbPmxzklVwnQ7n+vJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEFNTpmy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so7746408b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147744; x=1767752544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+x7KD0HZDuyMp6tkjQMV02E40k8AAXoZ6cXhkFKYgU=;
        b=YEFNTpmy+XxNMptf99i1s/Ki0TIeg9ARUYLJuBGR9HRO99W0123s630sqqoemFk7eu
         lrzgzMSx+/ksSQCNxURLovwuVGPlynf1SJpQWz6OfR9biprqmjPZkc52wm+YIXSu2ut6
         mOlqkbKmwfWdtJtf7Wb2OOT8WCY51Fp32yxJxzHdMASyq8iNrP+IS1IRzIyxIn9kn1YE
         sJKG+wWwdXlE4vB+CfYGDh9RQgllpleYx316RD0RoShGZOCPq1sIzlCNV/UmOkehpvgG
         YKALw0smDBVXI0JmLlh39oeby/LlZmEY5fEXHw1rH9LpmEfMqlkSacGEkMT+5Sye3guF
         Kg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147744; x=1767752544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+x7KD0HZDuyMp6tkjQMV02E40k8AAXoZ6cXhkFKYgU=;
        b=D8oz4ESxCgIFRl3wREh9AEgXJybDOyZ2MUKgCU6hI+C/vLw4gao//yJQ3U4QJOPtV3
         O8/nHyXGcRKY12SJ/DVb0V/blFSzK5GJpkEQJp8QvFDJSLt8McWwwZI/ocFB9SFmBjhi
         d1dAqibpQlUvrM3FJqhvjRN4G/4yw8JX0LGr7edC8CIVokWQkGIjzUmSCMxBeQJuGGX1
         +K+2sbuy5Vnc85EnRyqeprEjESZ1Wa8zrnf6iaRmGG4nRT4H2KDyQ2TGfsTTiQiigJQF
         WDgUafMWTyvJ4Ifikg/ZdQfxS8CC37DNX1DHkFA+Ocrq2WTIN6fieVHqv2/zt0L04oAn
         aBRw==
X-Gm-Message-State: AOJu0YxGk+k/elWMADcrZ9Dp0ySz/19u06wGUgrWBxSVog+OCB8O7nlj
	zzhduFODcNvn9etOrL79JyWWQJ3r8Gn0s7U1HcwJ8l5Jg7hmo1GOCpIAULRCCt8=
X-Gm-Gg: AY/fxX407rLvOA4R2h/excCojUg7/7JmNuDqX03w47wj8zJC9wiFdvbZ5MGOzaBM/9E
	okNNwFYIYz+qkoAxvW/ZEMScjF/3wo+SZCt2P6x9Ml/1sJ9KVdxPQ+QkLes0xpy8nKoqkeoLiP3
	EL9INEIaeoC6qvh311K2Ihbng/Zanh12Wxe+uxW3f72vJVvG9gYxQ+8l4Pn2zIkccTth5TL4W/8
	pG5i+Gc1DH3pB8VHovtjquoqDxEcEzx/Ejf1eECaRCAy8964rsDrCMqqaLzoEuwu8mcRXugEoo2
	aituQqQMrJUr2OrQaXVWbEraK9Pmh2sZYDdxBH7S9gii//U20gRieQD4MY3BkAyLFk2cVpaLotw
	/TP7B9KIKspD0l7oW5Rd6ITdrLt3BgL9ztj4sgm+amcPVirIznYZc7DWTF+cqlFt/J3gb3lAmn4
	hzmsxlaS0oL4S2fLlkkfyhuau0NStY3cESCD5YU3H0576fY/ru3SxRU47s
X-Google-Smtp-Source: AGHT+IEnrDmJh9964SJm04uY8A4ozR0fnw855kiMC/C5JH3CNjdwfZ9kT810Swk6xNDRzUF5R5G8kg==
X-Received: by 2002:a05:6a00:450c:b0:7e8:43f5:bd3e with SMTP id d2e1a72fcca58-7ff66d5fc16mr34439922b3a.42.1767147743614;
        Tue, 30 Dec 2025 18:22:23 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:23 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 09/17] Fix a couple of bugs in POSIX ACL decoding
Date: Tue, 30 Dec 2025 18:21:11 -0800
Message-ID: <20251231022119.1714-10-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

1 - Handle the case where the who is of zero length for
    ACL_USER or ACL_GROUP.
2 - Correctly calculate the minimum XDR size of the ACL.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4xdr.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1a6ed0836c40..60197963c854 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -434,12 +434,18 @@ nfsd4_decode_posixace4(struct nfsd4_compoundargs *argp,
 		return nfserr_bad_xdr;
 	switch(ace->e_tag) {
 	case ACL_USER:
-		status = nfsd_map_name_to_uid(argp->rqstp,
-				(char *)p, val, &ace->e_uid);
+		if (val > 0)
+			status = nfsd_map_name_to_uid(argp->rqstp,
+					(char *)p, val, &ace->e_uid);
+		else
+			status = nfserr_bad_xdr;
 		break;
 	case ACL_GROUP:
-		status = nfsd_map_name_to_gid(argp->rqstp,
-				(char *)p, val, &ace->e_gid);
+		if (val > 0)
+			status = nfsd_map_name_to_gid(argp->rqstp,
+					(char *)p, val, &ace->e_gid);
+		else
+			status = nfserr_bad_xdr;
 	}
 
 	return status;
@@ -455,13 +461,13 @@ nfsd4_decode_posix_acl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
 
-	if (count > xdr_stream_remaining(argp->xdr) / 16)
+	if (count > xdr_stream_remaining(argp->xdr) / (3 * XDR_UNIT))
 		/*
-		 * Even with 4-byte names there wouldn't be
+		 * Even with 0-byte who strings there wouldn't be
 		 * space for that many aces; something fishy is
 		 * going on:
 		 */
-		return nfserr_fbig;
+		return nfserr_bad_xdr;
 
 	*acl = posix_acl_alloc(count, GFP_NOFS);
 	if (*acl == NULL)
-- 
2.49.0


