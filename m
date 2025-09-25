Return-Path: <linux-nfs+bounces-14717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B86B1BA09A3
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017581C21AE7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE9306486;
	Thu, 25 Sep 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrDpMXmO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA63054CE
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817737; cv=none; b=a7u5kZTtA3JoyEO9HrJ+WgJLBe2K2ue/C9VR1BSLcDZhFA2A+ZVcJn1vcJYxGt1q7ekabArReqeNP4+ugerimHmK+ZOlzfTVRwf1HynKLfxZgz+DWU5vj178EbvjR0a30NKgs3l8+Oy6IKn/H48dVDhmytQrmNYEJXt7fGkUG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817737; c=relaxed/simple;
	bh=yVeHh1fU0YWUnblDCmkhki4+QgyK1imp/E2+6A4Pn4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abq84GGherHeLR/EsBuY1NF4Nm+ipK2xMApCzK1kLXq0TgoKdn0D3NV1H7pnCMGFwTQIC++srdhFNwnVa35Vmo9enBtIrK1f5bhUlKEBVFYKeEEZEl3jfzr4EI2+A7rtOuiD2gVIPHqxf/OLJUWK/rg72ws+1UZcnH3pEZnBcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrDpMXmO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso11390091fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817733; x=1759422533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnKoWYkEWH2fw2AAVRtHV79ItoxRJrbqLAVJ4MFNxIk=;
        b=nrDpMXmO7xA3w1Clr8JUDJiFyYr1fyhwu8EjeLJRnFuNHhliYTIH5LeKdLahi/JI8P
         yzeanFKkhPL3a+K7nJzIRVH3sJu56xdoiBYcPY/KVxL7H6088S5oYTZePVnF/vcagEoB
         /rroMFrxAOEn3lxVNbTWFsnh99VIm+M0Fbrd0v4V/J8ztR3YJgBKXVbd9BbNx08X8Q2r
         vwU8NyHttxsezGQnfgKTnMEXv5zIEiscC4M2hPjHL+IpY3STqJ7iCfJJ9/ORjk0esIqS
         mwOG6B/ovWTkZ8F5gPo1UiKQw3C7i6XQN6nLl06nsB9yMJP/RGAd3lupJrpwHU2o7jXu
         kY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817733; x=1759422533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnKoWYkEWH2fw2AAVRtHV79ItoxRJrbqLAVJ4MFNxIk=;
        b=vZArAPYEptVrvOkTCmsmujBTzB2ZJIe3SSpjPqmLvly6KSOsTgFcC3je/4FFYc0At5
         NSdRsoB+z5YGhHMTC29cV+85G6yViYMRCC6uEiZVRI0Oesm5L5Vm9kCRtcKYT/2Wk/OA
         A9Bmf5v1grAAcUFuF4mHULCp7zsxn+XMdVUXXOsXXoy1Dw2hJtHKKSe5GMqIf/gK1Yuc
         /DE+uVb3XLgv6y8DSObC47KJWhy7AtDF6l4wz9tRcQ3yO4KAetuzQExit35spHuixgwN
         FYi1/05jxhAGVIJeKxK/E255ADvRnQ6ypAPZSsp/WiEkbUDMCuhpKsbMgj6XAu+JtWzx
         Msag==
X-Forwarded-Encrypted: i=1; AJvYcCUArH//KDmk895JZbiSCqFoqow8h8/gZvyXBQjQqa0FAYIfFvtajEyX1GIEJfsisedZ1rYUUGD4dDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQJ7wpMTM5QeOgRWxltC9WJNRp0K5Hfx5yNHRDTir25hIzaY3
	jMbReKqc8pm+acdE7FIdisH5Tt26nsSHpl8TpZ5Y0Ohjv/SiLrJ9j5gA
X-Gm-Gg: ASbGncvl++rEAFstiEmn4zvhrkVbtr6oUl5clLMhdE3+1r015gxRQC/iEqys8EdTMPJ
	/0X1vXhIKQV/tkxr0AKJ0lQMp13TRCUj0NzbPoC04q2N4Vru+K+Ju8tN3f4NEI5ioq6i3ecLjyp
	f3KUun88xowcWw0xBrLgKlmlIw7xWRCt5dvaPu35xRmUXoNU1FFZuOb4RaEFez5FfhmsnPjXRmI
	wiWADk5mhWFv3aCqi5Y1+PSbEl3wTmeCidnHXJIftH6gbqeXH316mx6fzoVKec2YIKzPWmho/nM
	EclsTzHmdZzJo7t7bSnA0lcxwH4KxPIffCO4057sVM71QwMmwLGBHlexCAKlI8f4U+kd0chF+MQ
	PX8M1Kip8C3jWAR8u9kb7OyeCvhEp2NaNtyGC8PTXrFJE7gsGkLxkYHa9uNI3HnK9OZUCHzVn3h
	gPEWsA3Rz3uh6EAm/S
X-Google-Smtp-Source: AGHT+IH0F4IcWkrWVCR3Qs2WUMHWwcPaxX4SRtmDCxFKqMOqVSiVXerIdiqRjKIypJnd8h3S0hrFDQ==
X-Received: by 2002:a05:651c:154c:b0:36e:6146:673c with SMTP id 38308e7fff4ca-36f7dda4c6emr12606361fa.15.1758817733208;
        Thu, 25 Sep 2025 09:28:53 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe7ba2sm6541231fa.64.2025.09.25.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:28:52 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Neil Brown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfsd: fix arithmetic expression overflow in decode_saddr()
Date: Thu, 25 Sep 2025 19:28:46 +0300
Message-ID: <20250925162848.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The value of an arithmetic expression tmp2 * NSEC_PER_USEC 
is a subject to overflow because its operands are not cast 
to a larger data type before performing arithmetic.
If tmp2 == 17,000,000 then the expression tmp2 * NSEC_PER_USEC
will overflow because expression is of type u32.
If tmp2 > 1,000,000 then tv_nsec will give be greater 
than 1 second.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 fs/nfsd/nfsxdr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5777f40c7353..df62ed5099de 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -172,6 +172,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 999999)
+			tmp2 = 999999;
 		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 		iap->ia_atime.tv_sec = tmp1;
 		iap->ia_atime.tv_nsec = tmp2 * NSEC_PER_USEC;
@@ -180,6 +182,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 1000000)
+			tmp2 = 999999;
 		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 		iap->ia_mtime.tv_sec = tmp1;
 		iap->ia_mtime.tv_nsec = tmp2 * NSEC_PER_USEC;
-- 
2.43.0


