Return-Path: <linux-nfs+bounces-17375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815BCEB0A9
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A4EA3007AC8
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4323C4F3;
	Wed, 31 Dec 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9gccp0V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383602E36F1
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147743; cv=none; b=oNto78uvN8FCpSCDww008qtEF7/hWGMMPTFbUAP+2TisXGcBOcZExhIosaTvNlpXEPtsEXHYX0NOnTQfQFFyWvQ+ByxoVoDcVnEgl9gA7HB4Er8yTMKThG1WTbUwPngsedtsPKTivsKPBx6tLE0RupEqkSnAItKpdcwZb7Xzbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147743; c=relaxed/simple;
	bh=R/+zjdYFry+JauiBC2gVZdHvrzdhWSRKQ1dkno4TbaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db3E/jycz4F34nLuWNEqQo8taEnKF7cxKM6yvHOoO1fwmKpYfUSWTCRBeOBknm9zniNRYVH9td5NGrOPSM5Go57VM8RszfbPKtxwUZ4qlLS5HCWc4vaClM2pdXLy+jf90a7d4LJII8O/5ArY7Bp9ZqHnEOuRe+l67jgU8clYOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9gccp0V; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so6422056b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147741; x=1767752541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKa6qLnSoBLTuFjwHHpNfsdpu4G8VgktSDDpWML+V+A=;
        b=I9gccp0V/jLxKTj31OoJHUk1C7mqPcAbMx1ip8ECIerdjmo8EdYlTS6cJNgNRt6AE/
         ZLgRd+EnxGUUfGbKA+VEpPLdEx5m5qzB/gNWQuMqPx+Z5xvKJuDsUBOO3bMc531+0k06
         ZBV4PIfQyK8olMiduUUiLh5/S3lV1XerbqyXrgxetyjVEPsOEVUHotFVgmYq+kmslBma
         r9s0juSUm9k8JuWAieZ9CRVZYIdgnhct1Em7YKYmGnD52twMoyXhFmpIAsf9i1KCG8TV
         UEF2wrtDk/REPP0vfr/TVvJ6DhyyvCSdCDZ38H36vlUGFXIq810YtUJYIyPKdJwywzu/
         13yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147741; x=1767752541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKa6qLnSoBLTuFjwHHpNfsdpu4G8VgktSDDpWML+V+A=;
        b=t2FiFerATGBur6VIeddhrGgdAzKKM9I1PrtNr4LPlolEhdR+/K91f7y+mMs0BSQ6Uc
         wv1vm8ZebUZbD8DU+26ZoVDiPBUm2165zMHeYNWA/yyjvARu3OyyBPwK4R7ICFEQQ0aX
         iHJ+uFEaqevTJtOofxecPydGMI2HJUgFXFVGrh2v8kH4nsXDcXKQvs846AO8nhOCBBRN
         58FkcQab7q3Rj8m7/uZaOMImXCsPfSFKNetywoLStElfJqA3vxXlRRXS72PwYGU5d27X
         SYyGdkboe+u9puVqZSxFQiIn3dpIqmpnrykvdizbFIEkdngwgAfBa5P28yzbBZYXh49d
         PGcQ==
X-Gm-Message-State: AOJu0YyGoM5QBrASqHrTIu6i4MaJzNJvfpyYCCMJF8BNweESY+1+J6y1
	Jjn5vGAQZerCm+H+1VmunTcn8We2MP12tCV483fZMrJMlkXndwqNznhABGo0B+E=
X-Gm-Gg: AY/fxX56px+p4Hs6mxVkTjnMG5BOhVvPYNV05rbUKS74mQAUx6gy/cDP6F4CJhgZugv
	WrUOEEtKdSt9ThMjBU+2wwmk1HgKIWqU60oLKPt68W/NWqbYAU/tVYg8N0r189vthpn2JDcpzKv
	Egz/Ep9pccG0rz/hfZowglX7kCGwnELL8WPwgRJG6v1FU0KeMlRWTB7trdZ+QzEeb2ce+VIrzbQ
	0/HmkfxlayLjT4dkFrCGilzWOrM089RUqe2cxCcLpflEDG+HIdiwezaTA3G+SXCwF5HYgUQI/Ew
	gJOR31lAtaP3zEg7cj8xH2gd/eco0ZhAv0j88Naad9FfoAxsxMtfsCNd5LLFZ6ukd9zfRxjYHGd
	6Hsk5xzGX/RwxCG78quaUP3ZrwVwIvk5zeu/L67H968Q8LMg+Un+i3M8xj8BL0Isy9YPBAvxNNm
	ejbYuJdILQLISMi4JepDhJgFZ51X08j6aBkuDWk2OfDmgnVllC/+eEm3dK
X-Google-Smtp-Source: AGHT+IF4nJzcceVqj1gsBb4CTQS7USTS/D94OjQcQYdzXOvo/v1Vaia9MY3O6n9j2xPEGmeE73EvNQ==
X-Received: by 2002:a05:6a00:3497:b0:7f7:2f82:9904 with SMTP id d2e1a72fcca58-7ff642122ddmr28889232b3a.5.1767147741568;
        Tue, 30 Dec 2025 18:22:21 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:21 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 08/17] Add the arguments for decoding of POSIX ACLs
Date: Tue, 30 Dec 2025 18:21:10 -0800
Message-ID: <20251231022119.1714-9-rick.macklem@gmail.com>
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

The NULL arguments are replaced by the correct posix
ACL arguments.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4xdr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5f996b3a4ce4..1a6ed0836c40 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -980,7 +980,7 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 				    ARRAY_SIZE(create->cr_bmval),
 				    &create->cr_iattr, &create->cr_acl,
 				    &create->cr_label, &create->cr_umask,
-				    NULL, NULL);
+				    &create->cr_dpacl, &create->cr_pacl);
 	if (status)
 		return status;
 
@@ -1132,7 +1132,7 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 					     ARRAY_SIZE(open->op_bmval),
 					     &open->op_iattr, &open->op_acl,
 					     &open->op_label, &open->op_umask,
-					     NULL, NULL);
+					     &open->op_dpacl, &open->op_pacl);
 		if (status)
 			return status;
 		break;
@@ -1151,7 +1151,7 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 					     ARRAY_SIZE(open->op_bmval),
 					     &open->op_iattr, &open->op_acl,
 					     &open->op_label, &open->op_umask,
-					     NULL, NULL);
+					     &open->op_dpacl, &open->op_pacl);
 		if (status)
 			return status;
 		break;
-- 
2.49.0


