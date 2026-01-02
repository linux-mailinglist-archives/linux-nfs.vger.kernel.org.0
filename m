Return-Path: <linux-nfs+bounces-17399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D35CEF781
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6A1300A84C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BEC248176;
	Fri,  2 Jan 2026 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBsoCWUV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91145C0B
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396629; cv=none; b=bppL8mMF0LfShhA2WqEMsHfvKqeyOy/G/YgG6iGekqUlWzWQUKEyiHTvVFUf1SPtDXF6c+o1d9Z4fRTqlFqhld2os5JkNZ1W2TabkiDk3iqfBiN3xZl8MBq3Xj5Ggv5Y1GVlV82eXOZ6/bFAyU93xI4WBcGIsx7XcRy1iE52f8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396629; c=relaxed/simple;
	bh=Pku9aoJfW11sbCIEuRq13QF67aD6fu0vrBqMVIj4pq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJSzlk/FG71bA3ScvzHcyLdXvCGiMIKb04QhK8guv+1acxL1al372Z8m+NS3mqiCXrB0tL83GAl11TBG/yIoi9i6yRbXLG7FxTVo09hV7sPKjmV8RcSMnm7iToK3hd5h+YjcSjRIfKOIuBDwxLgWk+RBALLGK54qzLEx2U+DQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBsoCWUV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0a33d0585so114570455ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396628; x=1768001428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oegW2UayDRdbpW5YeYJCq3pKu45sA8HvhBHU1Oju9h0=;
        b=BBsoCWUV2pBwAWs9dOAYPmo2y4m5N0xphLSCrwJ1TkdMxPN48XPAj/f89jlwu6D3OF
         uHOREYx9Ub8kZKi/kNYB9sQYEksA8ewAbl87J2Ep5MtL3ShOyNAbI91q0AXogvN6/sSB
         qSvB3AuuGUFmHE/qrfuL8tAlSWuqlTBth7S9jxda0yrB//Z+JR/mEUkSlT/27AAfl6X9
         IghyZlidD9mqHHmAQo9P8VgaRxYLpDS2XLmRTaJkaJl8/RZHY3XNq+OoG7vMWvphrPnT
         c4z6n+nl5ttjfR7SAWTuQgDF7zljn8NA6KW7Z/7jh4Z987CWnacjdDbbvASaStV5Crca
         OLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396628; x=1768001428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oegW2UayDRdbpW5YeYJCq3pKu45sA8HvhBHU1Oju9h0=;
        b=sFIfDQihC5a63Xun+eExLuOlcf2rEuG+QGS0wtsuXgg//j+cgkPyyHJbrGsBkY1tnP
         BFU9V6OI0Aqsr2sy6DHK2tJXO5GBvRCf60c1CitOmyq34lTJlX5KvPqF/mNbBxSY8k5b
         9yEOroOdZvVIHVsjv6Ne8+aEGHmcyFQi76GnCncxCaj6J3KRcRtsmvxMp2Pm8cslLYl5
         urorj7iit6rlRP19I8GoBfOAORZPteKu2PeIdfoPgjaE7Ow/y94nirGh/GHqlfHI5j3d
         vk6znpUZhqfTlSTwuPpmKqpWiDbU7veGEPso97Qd9ZQR3hNTOjOupN5xikgHIizbS8jA
         mocg==
X-Gm-Message-State: AOJu0YxYCwLaF0ToUAX8LHT+pBzOiB1GeHaFwr2bteq1yR4WCy96v+uB
	Dw86lDmDABRy623+Uz4siMzMw63R1iZc9oCfbPi3WbIurgqset6eK7ktR+Vyt7I=
X-Gm-Gg: AY/fxX5FHOeLDZ8aN6O5mG8eUlQY7r82GzGbP/Dqn+PTmV6D2cBMCROA4p27xLKC5a8
	7pvmCcS3Xw5Uq1UttwSENUuCFmW9WEaz2Cl6xcKwiGR0XS4aUxyW7R1Gj9ZTDGcLgKlqT/2bnXr
	oRpdtPSAazEoGf7SimIwdLdVhCdK0bTBouzDniSM/cY1tcjE159C5baEScheroa0JgyOzFvP1Uq
	bNZ37CpZer1n7WCsaUTIh7WIfUm7tJ6tfzPUJMNtyJOQHA81b1zMrXJ4gwnv+jMCjPVAy0q4htm
	pb2HOO5ISqnUTA3XzHtCBVPUwCJIOFDFmYuCXUzmP8ReCaZvPc5czsebeYRJ5eDUWaRNbnac/hb
	F8RmIqcDt1bGsqToZ/Ub+OBajDCUcMdmc+/Q91qe3cRPxF04wGQFS0s9StV1Oe2pKZVNnJVmOuG
	gTRkECmaflb+leYDV7TrWVVB2z/r+VHkS+SMRCDsLZQqGLZuZuadT+/FX2
X-Google-Smtp-Source: AGHT+IEV6BuXKedwsvvk7uey89wjnM88KC9fAJa37u+N86ghZA8+TraY64wRnr5ptljAjq+0HFeHZQ==
X-Received: by 2002:a17:903:4b4b:b0:2a0:c852:5f9f with SMTP id d9443c01a7336-2a2f220552fmr460197465ad.7.1767396627512;
        Fri, 02 Jan 2026 15:30:27 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:26 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 1/7] Add entries to the predefined client operations enum
Date: Fri,  2 Jan 2026 15:29:28 -0800
Message-ID: <20260102232934.1560-2-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260102232934.1560-1-rick.macklem@gmail.com>
References: <20260102232934.1560-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Add entries to the predefined Linux client operations
to get/set POSIX draft ACLs.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 include/linux/nfs4.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e947af6a3684..25fa2fe649fa 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -695,6 +695,8 @@ enum {
 	NFSPROC4_CLNT_REMOVEXATTR,
 	NFSPROC4_CLNT_READ_PLUS,
 	NFSPROC4_CLNT_OFFLOAD_STATUS,
+	NFSPROC4_CLNT_GETPOSIXACL,
+	NFSPROC4_CLNT_SETPOSIXACL,
 };
 
 /* nfs41 types */
-- 
2.49.0


