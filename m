Return-Path: <linux-nfs+bounces-3732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649C906344
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A41BB227FA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30084135A4B;
	Thu, 13 Jun 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD2pCDVL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195313210A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255228; cv=none; b=DdpQaJQC4bbvMK7OyGlX9dlPwN1q6CVV73D0CDi95f18MxDnm7qzwxXNK/yU26cfJ7t/p1x/EaSrZ6UYnY32M9mVDkKhA2mU0wt73/9AJWzn2htn4OoNBbUR/lpGEEwqNXwASa8GziRsJmggcajEPjp0AJHbHcjvLUkF4oH+ru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255228; c=relaxed/simple;
	bh=CdANIOaNsG8iASQaX0gla21G3OnBWY7i2Ee32nL8g4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg4Np8GB3+juD6dtttD0jL0PoODRq/Ggfy4j4eaG+rNPMe04Wy9yxyy8eUvr14u1WpzaQSuQQUJMdB7RHDk2Ph31SIZ3l/RqF4TZM2kt+wPG1ql6Szww/V32OWrA8kMFmq1wrzLXrXxj2kQHXfiFbM4j9YuYvMiSwmuSA3j8hSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD2pCDVL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b06bdbf9fdso3568636d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255225; x=1718860025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iy//GQLlcZ5aHkYIb8MscB8H27aF06UkdefW9lmLNCA=;
        b=JD2pCDVLLZLdNHkkPZUU7xIYFxdQmQ9gZz1X+LLZV4i+eH8vJSazJnqyEUd4j/40Zx
         qrB5PWHtCnOW/gX9JY0DLo8+EMqu6B1toqunvoY+aCVG1OPjF86EXAlz3oWZugdYrzGR
         zGwF5whLcw2M3CaWVDv5UThekSiaGuRlJlBkxnJ4kq0KCC0sAARirXeUc+HRtp6yDkVp
         GOGaF21ReRauQIL3qPWSoeTrDsOQ9O9bX/wOUO+78RGq7/AIrMFGNzEQ0WH2hW5vcZRI
         nqkWpPpdOGyjxwxo7Ac9Ng1myVNddSuhGBuudbP24Bd3LZvT1uZkgOglE6T6tIjHA1Za
         12Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255225; x=1718860025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy//GQLlcZ5aHkYIb8MscB8H27aF06UkdefW9lmLNCA=;
        b=HT046dPbU9vDl0vPoh3hgadHOWzulwr+A59SeZp8V1IdSCGokgN+/z0r5KfEn1Va1D
         K78bJjk+yWk/io0fj+ndbY+DjUsEiQbBVmT4ClU45H1soMiAuNVex00QEnU/Xr7meA6R
         HCzHp8bZVitNcdaJsuCSNLzsohHH+WdQCoPvYt6KUsuj4OQ0XfBzAQITkxraaEKyPEwT
         ZuPGTJ0j17U791QoxgutMFrNHv1QSmUN/WuvPrQABG483V/cNvyPQtCMpEO3YQF24KZj
         LAqFWe2qybDsJR3tVoTJEhlcuzz2JHf5UjVaS/cY2PZHJilLM/niJD5IpEAFTtfMcYfw
         S6Gg==
X-Gm-Message-State: AOJu0Yyzn5bmIeyVJZjn8lfVMan8KSHN4Aah3OcJDW06fCcT2fCtBFxw
	llVK/gChR1uuGmiWqXC7RYWp99YC7ZTS7x7E4bvW/MJ+llTClYr7C/Lx
X-Google-Smtp-Source: AGHT+IHcaqVRCCLFoXjAVYYK+QDu7nH/mg1uNh04sJmX6Ln3d9t3Qn89jckU6nVENv0dVWJkNThnnA==
X-Received: by 2002:ad4:4484:0:b0:6b1:e371:99d9 with SMTP id 6a1803df08f44-6b1e3719b2dmr31717346d6.8.1718255225197;
        Wed, 12 Jun 2024 22:07:05 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:04 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 03/11] NFSv4: Clean up encode_nfs4_stateid()
Date: Thu, 13 Jun 2024 01:00:47 -0400
Message-ID: <20240613050055.854323-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-3-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we encode the actual stateid, and not any metadata.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 4bf7d5c09282..7704a4509676 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1067,9 +1067,10 @@ static void encode_nops(struct compound_hdr *hdr)
 	*hdr->nops_p = htonl(hdr->nops);
 }
 
-static void encode_nfs4_stateid(struct xdr_stream *xdr, const nfs4_stateid *stateid)
+static void encode_nfs4_stateid(struct xdr_stream *xdr,
+				const nfs4_stateid *stateid)
 {
-	encode_opaque_fixed(xdr, stateid, NFS4_STATEID_SIZE);
+	encode_opaque_fixed(xdr, stateid->data, NFS4_STATEID_SIZE);
 }
 
 static void encode_nfs4_verifier(struct xdr_stream *xdr, const nfs4_verifier *verf)
-- 
2.45.2


