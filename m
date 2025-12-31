Return-Path: <linux-nfs+bounces-17377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56835CEB0AF
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5303C30078BD
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929A83A14;
	Wed, 31 Dec 2025 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpokef81"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31EF23C4F3
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147748; cv=none; b=ufYs58UGfgPAfsnpZ04U4cAsnnh7zKkdsab1VlNDg6aFHU7xFSyi877tykiDMP2tlupKhtRhIHTTO16MsgVLLeLQSNbN1VphwXZavLo+lJFnkb0/G+b/DcsoRcK4zitCMS78cgCEBZvMLdUHBWPY+PtbeKr1sTGonBLrkXDhJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147748; c=relaxed/simple;
	bh=OGkW0aqLZ8dwHsHtKfV1+c/yqddPYmy0MWHKnoGxlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8sojzPmR/7U8Xt/CCWf8rJRAdbKbjZXJMhylCjFXBIsK4Y1beYtC1oDPJMVQcW+TB42lwOEayap8YTKhyoRrB5ip1dFrvS5L9X1uzRQkBI0x+Vv4K9QnSkC3pYFhPKiV27iPrWKqvrzcWHrMb2z/c5cUN8cdppFfYjxyDjC80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpokef81; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba55660769so8118274b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147746; x=1767752546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCDF5kSOEh62xaAdkQDjR62MqL11t+aVEZ+ZTmEMnpo=;
        b=gpokef81pjzgqDRSwmDy1da6pD1XTwIRnT45bqdc1Y+DrpZrSOt/GZUUk88nybmvAm
         1W3NE2e3KA9yFiUZJr6f99co500LIvbat+ilpnq3wksyI8FVAH1cXmsDHMVqUUEG6WQk
         nlkMN0mkxZLGqNx9pyo3zBKXU+tMYa2XGUoqQewp4dMTONZVHBRy2Stv0rbr9Qn+M9Qo
         c8BwKMYpwCZoIu5zVRXt4hN9HZ9HzY/LTtmh3VsGscqOrcbJBiPhZBFAKDYPrKPP9mxS
         KKaXxNMtAjEhTqZCUszflf4xnJQYSviWdIYDtwm/xaODT9Cy9xrA8roQt0am3TiIDCO5
         eu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147746; x=1767752546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCDF5kSOEh62xaAdkQDjR62MqL11t+aVEZ+ZTmEMnpo=;
        b=N4msMse35pQ7PLOJKEpcfT7U574yKyrjmtV7un+Xm/IsecMUI7B171qBLGHNVznq6j
         AiuxXhfl9Iq6jILNKdj+wzoYlPeHW65CtzOr+kPb93zqzv3vzURNpFOy+0Dk06N2x1Xr
         Eocq2eSNpyiNuhqzdFXGK6/6ItlgC6P5Y2RskOWFXIxb62wH4+BWxzevyCDNFuRaaFNq
         Aw14MP6tJMNm2MHnjx0lg5YOu2GwdiZVD2LK/oPeyQ45npMH85e+Jp6bCXBucehxo2Nw
         8Waa63d381ijtot3vH7vaRRTi5a4VUypWZ8IuxWRuO+Dus0m3CiOr/2XB0OH/nCgJx8K
         4VHQ==
X-Gm-Message-State: AOJu0YwWa5zV+OJqgEnCH3L2L9ZsGhBMLZ9IXBwQn18KB9rgaj9O9lAW
	VFi4IDOUtlEy/5SyexS6UD0bbWVl3og1ojNMzq8eOgXlAa6oTiRIMxX7jHqti3M=
X-Gm-Gg: AY/fxX4qWwTMYpuOYf4sIVNqc+fRdXt4h5Pu8GqMFnKLjtjQ+onqEV18wtStK/dVp1o
	h0qwb9DM7WJd46hVTLTrzRaz6w5S9Jc8H/mhmwi4mTYirHazXyL7nGN1jw7ulgyRUZbWzrxPYz0
	axSW8dVJxKPMbSORD6NaWKDXbRdZFD33bPluKec++8U54u30Lu5jFMygPcq0neVFewaBbBxV5GI
	EX7s4Tfp+ixzbxsIvYMQNO7kOpR1L94OfDtaLnqbc3xU9l3C38/MiE1EwPGGq3RFAixlk6FH3oC
	n2joqneKMGrWPrHD388lIX1H9nL+v3sMcyxQG1wccCXgAhGwX6LPjcqdw6Qde/fwKKpvoVdQ22h
	qhZFBg3PD+Ewmkx1XhhNlG3/hwBmGemxpiY9ZGyqQEkl01OV3n2xR9g4Q+/2xpcsYCoX9JXMeHr
	YRwTzbYXBA/NXGNRCk0QrT++OY/DZq66xN5tLenLKCH0rhX+Wn0e9VXLuP
X-Google-Smtp-Source: AGHT+IEhdXDZk+rkpId2uZBSaqVP6MITKUiOnPzbdQe2g0AcIU/Pf5u8NzLnXXMiK6CsHK5dBgfj/Q==
X-Received: by 2002:a05:6a00:a90e:b0:7f1:d6e6:8f87 with SMTP id d2e1a72fcca58-7ff646f862emr23973430b3a.17.1767147745704;
        Tue, 30 Dec 2025 18:22:25 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:25 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 10/17] Improve correctness for the ACL_TRUEFORM attribute
Date: Tue, 30 Dec 2025 18:21:12 -0800
Message-ID: <20251231022119.1714-11-rick.macklem@gmail.com>
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

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4xdr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 60197963c854..d12e479c18d3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3615,8 +3615,12 @@ static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
 					const struct nfsd4_fattr_args *args)
 {
+	u32 trueform;
 
-	return nfsd4_encode_uint32_t(xdr, ACL_MODEL_POSIX_DRAFT);
+	trueform = ACL_MODEL_NONE;
+	if (IS_POSIXACL(d_inode(args->dentry)))
+		trueform = ACL_MODEL_POSIX_DRAFT;
+	return nfsd4_encode_uint32_t(xdr, trueform);
 }
 
 static __be32 nfsd4_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr,
-- 
2.49.0


