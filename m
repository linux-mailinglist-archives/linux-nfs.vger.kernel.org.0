Return-Path: <linux-nfs+bounces-8888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD2A00140
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 23:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BDE1628D7
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375DF1B87E2;
	Thu,  2 Jan 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esMvtaJr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8E1AF0D6
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857933; cv=none; b=RVnSuUlgbVjb94hgw2o6hxEl6yA3D0MbVqPlqKqQLr8sqAGwg1LQjEDxHzyLhR7izj8kjvZfFAxJWSyKa33NUMy5QIZ+/prlEA6brPxT4h0CHy7m23AfD2uMo+h32kYiSdgbht0y7LtvFxG7I1T4/X7oEcQyUJEXVa0CXh3yECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857933; c=relaxed/simple;
	bh=iWHCd65dzcA6+I+uYXWYBw19GL1zmDZhAUY5YyjoPac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhoaHMrIqVA6RpNi70eVe2ShD1cLKNr4CU9ND9auRm0dKTgaIjXCz1r111iZipQ4ni4Hg/NtwRUHon7BpZasQFtK3cchFCNj+nwENFyGssJGvJxp+OcezBrJKtPgJSocFqiKJSYQPMaLpKE0KZ1Ro248JXZEOtJ8JOquCRziUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esMvtaJr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aabfb33aff8so2066171866b.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2025 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735857929; x=1736462729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xYrOehAnovxd+xYDn5/qgLa86OrPG6Wl9hsE9p+RX6k=;
        b=esMvtaJrtf1kbfMHzfTUyzOstV/50JWQu4lvRpzjFkAEUYqgPX6tKlWnFZVClXywcm
         BAXq28p3pK5/Vtpv8K7YPyVm7boEOSz7oI/8DG+F1/EhS8lMX7H50p4LUfDoK4dEPHFQ
         zCkIndrL4UTmARspTeRVd+584WeqggLy2bGsCW20tNs66DvaZmPvZGFz0GDZt+4z1MGn
         q1kZ7bZUYmRLMHcY4EzeaCHvGWArSR0QIZr8qmTTaEFPH9TRxPzRZf6E1/3yfPdpKcQi
         +IX0ginCAa+gG6rVTOWGF8wIdnCKwIp9ym4jQvgpblCGwkTjjNqrw3XAA1ZrQfv93sNX
         DkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735857929; x=1736462729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYrOehAnovxd+xYDn5/qgLa86OrPG6Wl9hsE9p+RX6k=;
        b=C3KNZ2ogpTNNpLe1ej5IHLCGiIsDx5EHZQQeBjs6ylIXme3cknDNSOCLy8a1VuLvvp
         aSMHqehihKsh683XE/Hs/4YlpSLR+sP7Bb/3rh4XV8vQA2zffFVmbWHuwY90i1A0tZ9r
         p4kYMCTwZqrCeTZupxDD59Bx1lxkUNPrcaJgUspBjMTUk/hLblUdwt1iKvALkg3O5vC2
         rojWFqByOHr7oxoYU7jtQjDneoV1reUOD1pObVeQwFU66ntbnxKDnt2zAVJfAS3IezfK
         UoTee9TqisxqS8TbWxKSuKwN0W+d+sVahgRetQnM7KrcVaC0xUn9CGYtI1BXu+fNdEBE
         WYIg==
X-Gm-Message-State: AOJu0Yy27uCILcclcNo61dxpq+IO9FsWProvsySk6oAnh6jc02BIUmPU
	KXWZlsbLYNmJtL+DYFErU/kZQ/iK4b4J1hQggpcv1J8IAr2OWrHqJE/0LWvL
X-Gm-Gg: ASbGnctpKMCQfgntZ5VeenUTZEfLjRkrDKpXg/ZMHE2cII/selblbteZvDftvTO7gId
	myLp6xABWJJlD9J37ihD8ToNGy9UD8hJ6LYBrCoEsKTNqkNaLqPLmV8uBPj6hPJ8yhVj6vYeenX
	d8Ax5C8EoeZxp0O3JTLswWOBEMzoMd9/XwV1ywl9oqdFzxH+yhNYoDDBi62s5rSZlavgfckpeAY
	1s8woB1nWgAq9Rp6y6OWJEJhvCHDzukJ140PcLeQZiP/1oJFGhQV4IzLG77WJGwQIisxOTE4C/5
	Nfr+Z84NyEDrXbJC
X-Google-Smtp-Source: AGHT+IHOj2g9f4Sg7W6UFT5imLrlFPd4YWRMFhA9+ifH2+LpUCSPGiU49t6e3fe2VkPN4ZNKthy78A==
X-Received: by 2002:a17:906:6a21:b0:aab:edc2:ccef with SMTP id a640c23a62f3a-aac080fe36dmr4129286066b.2.1735857928942;
        Thu, 02 Jan 2025 14:45:28 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4c1dsm1847357966b.109.2025.01.02.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 14:45:27 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C544EBE2EE7; Thu, 02 Jan 2025 23:45:26 +0100 (CET)
From: Salvatore Bonaccorso <carnil@debian.org>
To: NeilBrown <neilb@suse.de>,
	Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [nfs-utils PATCH] systemd/nfs.systemd.man: Fix small wording typos
Date: Thu,  2 Jan 2025 23:45:11 +0100
Message-ID: <20250102224510.1145860-2-carnil@debian.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wording about what is required when configuration changes are done
contained small wording typos. Change the sentence to "When
configuration changes are made, ...".

Fixes: 1b5881d5b9f3 ("Add nfs.systemd man page")
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/nfs.systemd.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
index df89ddd13b76..f49e7776a185 100644
--- a/systemd/nfs.systemd.man
+++ b/systemd/nfs.systemd.man
@@ -91,7 +91,7 @@ Most NFS daemons can be restarted at any time.  They will reload any
 state that they need, and continue servicing requests.  This is rarely
 necessary though.
 .PP
-When configuration changesare make, it can be hard to know exactly
+When configuration changes are made, it can be hard to know exactly
 which services need to be restarted to ensure that the configuration
 takes effect.  The simplest approach, which is often the best, is to
 restart everything.  To help with this, the
-- 
2.45.2


