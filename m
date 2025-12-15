Return-Path: <linux-nfs+bounces-17111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71252CBFE18
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 22:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E74430155DD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A281D329C5D;
	Mon, 15 Dec 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IWb4FFy2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6D32938A
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833260; cv=none; b=Cdbv/6wGzjTTsjsoobEIZ0eSxASl3awovZYjD1MsLfsXv4OUgGIUdUv+dxTDjsoIN7wBKjWewTIKHL21+iE8eRiuauQj2LWJ7yt1qJlUrwwaw1hjrLTKnXSig0aeaeuzflJu8AxU4S/9/hErOJ6IzCbirxLeYa032nkOX2mzbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833260; c=relaxed/simple;
	bh=ABGXAXTFX+Q4xFX9IYbyE2MYadhC3VOsW+6jqFC7E04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JmKmiAIx3oIo5eCHS5ct56tl9aTDPWCdxtobxdfswl5vw2WS93ADMR1zGSqiO5JsAySUa8n60mdGjHvSDeqk6inLiXb9hVcPV4ku2SDyrDrPfbjaudVtFWfieO7+VFn/gHvp8W98jEIB3cMSCz/iSAZmhh2b+Wbtz+/XrmltukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IWb4FFy2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so7459199a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 13:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765833257; x=1766438057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKhekWbIhV55MQi7/K8aoylNIuhDucq3XWpKz0tEg6U=;
        b=IWb4FFy2UTzaRSL6bDQXUacLXuxNfTQQt2fi1lQ56vawvs3rus26fzAZNUN3hjQXsT
         yPFMJHfaHSR2lEVU7Fp+NRy7zZLZkR6ZcxPhqO4g/nUTG/wR+OAJKpBRd/tgt/xxVbO9
         26dsQbIylCYjlUmp5qr0yzsM0hFf75/qnTfPnn9+0Y+rZxfN2C6pG9jjONFNmiuFrg6s
         DGkIrxqxu9TR7e1e39uo7JC3JFzls5rhEVBVxmgBP8P40lcpoaXTHhdVTQkQm7jAFphF
         DXbUPfCGLdteVnRqOtDFVgFxl/qqDhnYedyvjhJJhsv+63+g3Q+7Fg1ZUTllERLYWRJG
         xHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765833257; x=1766438057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKhekWbIhV55MQi7/K8aoylNIuhDucq3XWpKz0tEg6U=;
        b=ImxKQhYJ5egSivLDPnew2VlrQklB4ePUHHAmB5MIdR+VCqdLhguYoysJukQJ4Z7iGr
         0dbr2se9QW2D6Z4G7k4Ga+/a+iDtD+vCIACIsUN3f03CnjIxRPvFJ8VTX3SMxXc+Knal
         RHcTiXW9zGwklUAcgSbIvhoWnAZ4mXY0P/5ilC/2atSSRvHKHCTmwZF7p1KLDxJnTrai
         cb1pU23XymgnayG5dRbF/hrYzjMRwrYg/Wc4jpkw2TjPOX4WOyzSv/zGzebbyxNKMq4/
         cVziBLDjFMuUCugjnf3R0RRCzHtvCpT1UrrCQYtoKrtRghQfo63+P+ArBSyUPNRNsEBx
         eULw==
X-Forwarded-Encrypted: i=1; AJvYcCXzBqpSG8vC6gWwMx/azTRKUmtN4dNSQjpEMg2Celx/zxndBKOjv60kwQfor7m7EX50WV1ysJqCWpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oqo/EQHgXszTuGpuVmy9vo8HIIGSGgywUqdIfNmUPIdtnprM
	81CmYAArdDCLAnZOMFR2Ft3DjAUnOqg/u+siFo/vJnjpyMgxkWmHaJEHk0dKNwV3ep8=
X-Gm-Gg: AY/fxX4cSSsItkB0LxvSUcvAMzmCg5PuQuUt5nJedtp0ysCGWexlvtikgLYJvG6mDDI
	E6CzZV1YSaWwHD/qt0yGa6FZJmGXHy4eGemraQC5V5ZTDCGFlryCdejcsHXIOm+xB5QP8MKje/l
	9kbJ3ks0tIp/oeS9fCiXCASaBwZH8oYHf2qvy/5o1GYU9VxvSK4JhkQQhrGFDXgh3up3N5CbCH1
	MPFstT7tCtqoMDZKQVdn0LVwe+EeRTaK1vA1nLnpLoa9bHpaLHShUFXGkebeqMwIHEv6/1Fa8HR
	ZQrrXesEkbqqfT4SJIc9dLtoCkOETD5vwGsIc4TLoK8Y1VlOr6R0EX4+czizim1CP/Y+GlGEY2G
	Sx+bAZ8pBBzI3i9dIe0CmKOYa54BlW/mR/6gA7+HkdKGm/XQKR/Eyt3csS1nxHCH94yAvho1S8W
	YMg6k8BGIZOn1ykhr6xew03MrVxWoGiyaFYRZYu1faXw==
X-Google-Smtp-Source: AGHT+IGjuu0yW58P8FDP3arG9c9fEC0sh6HQ4EqgaNTa4L5+1N3GCmXIrxCshGdHEyeqTYGq7G+srw==
X-Received: by 2002:a05:6402:2114:b0:640:947e:70ce with SMTP id 4fb4d7f45d1cf-6499b12ff90mr13205593a12.5.1765833256849;
        Mon, 15 Dec 2025 13:14:16 -0800 (PST)
Received: from irdv-jcurley.dev.purestorage.com ([208.88.158.129])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6498222b01csm14492583a12.35.2025.12.15.13.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:14:16 -0800 (PST)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] NFSv4/flexfiles: Layouts are only available if specific stripe has a valid mirror
Date: Mon, 15 Dec 2025 21:14:03 +0000
Message-Id: <20251215211404.103349-1-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stress tests with HA + striping discovered a deadlock with the read
has_available_ds functions. Looping over all the stripes looks correct
when one considers the helper functions in isolation. When considered
in usage it results in a deadlock. The problem occurs because the read
variant returns true if any stripe has an available DS. This means
that a read for a particular dss_id can hang forever if none of the DS
it needs are available while there are DS available for another
dss_id.

This diff changes the helper function to consider the specific
dss_id. This integrates fine with the call sites since they only work
with IO for a single dss_id at a time.

I also updated the rw version of this function to consider
dss_id. While this doesn't avoid a deadlock problem there may be some
availability benefits of letting IO continue for stripes that have
available DS even if other stripes may not.

Jonathan Curley (1):
  NFSv4/flexfiles: Layouts are only available if specific stripe has a
    valid mirror

 fs/nfs/flexfilelayout/flexfilelayout.c    |  6 +--
 fs/nfs/flexfilelayout/flexfilelayout.h    |  2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 55 +++++++++++------------
 3 files changed, 30 insertions(+), 33 deletions(-)

-- 
2.34.1


