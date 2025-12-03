Return-Path: <linux-nfs+bounces-16859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D6C9D78A
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 02:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D37103484E2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0BB2253FF;
	Wed,  3 Dec 2025 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwz0MiEf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1B219A71
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724170; cv=none; b=UADLzM+XeAb7SGs/ce1G/EWzbXgXkU2Fxux7VvZtML/a7OccR3fenHfGhByGMRtFKy3i6QrOtSl7h3RrWBYZQvWIq7luVICuSaEgv/ghso8j0tDt2D/K1XMp/F3A+G91lb6Iv/o7VgOra1NlK4j2VNmtz8WOUdE895yOVFDBGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724170; c=relaxed/simple;
	bh=4JY80Jc5VQhDDV7Kh5EhUJuY6+Adwyzi2qDz/1SyuHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gppoWQR+jfdAdsJweP8mLb4e1o4VEP0PfQlOyTGKXVY1hXZQg4PQiFMjpgw/IKcm3vl8aw08j9bQFS5KuEbcNCXqK+j74oT2t4potii40UCz7SZAcd5t07+iqf6w4EOm1ZWw+6j6dzO5JQ3CRMJQLafOLApz5buUIn/vaOy+CP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwz0MiEf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29555b384acso68664705ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Dec 2025 17:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724169; x=1765328969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TIaVYC20W3RE8iO6ocjajHpRpv7qVGK5eUmOfQ+3L0=;
        b=Kwz0MiEfPX5FXCIrbXRYj/0sti3ur304P2MH9rMoHeBK9LDEZCwFWlk9LSdvAKbUyr
         WkCJADordsIixGFAkyVahS5hmp6WkcG+hmXHpfqweRnySU0koMUG02DLpQ9Nyx9vIlsm
         fgjXKlqYAD3cEicgcK9/QCaqG3C+GfGKBSdFHDs/OxIBzlvH1t/tTloaHNygNPZdYcOS
         HLvKSDQw1HeqgpVCxNn7enMXK92LIe/4x2Oe8w+5G9/pQ1YYGPVntV/+N+miqARb6+J4
         4jsDaBQZ5aQLqRyE8fXnKpuqrRUOIwO5ZvpnO/ItxGjWtVsVkgTLCd0YlcJqcze2HtbP
         Sbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724169; x=1765328969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TIaVYC20W3RE8iO6ocjajHpRpv7qVGK5eUmOfQ+3L0=;
        b=coaoEIOFA4WPgHcS+oe5v/PEj7uPHGfMFxS1L4QVV9h6YP5o8R4jIffbV1UXxe/CA9
         foKN9Ur/hfuPiRswExzp9hL1CunWgN+ppV57vBFia5dQzPYAPzUbdBmbEOjNzWHKoIV9
         OAUkHFCbjw62e7vBMfjKgKcLzUhfQYEA3dKuxLDAFb/SP1G+9nWOeKp7PpJfc1zsQiJx
         k3hkaNyoql+peScHRG3k8Ws6n+DJ+g6p6Dx9pIqhKywmjP+6lQloLVpmojpPBmX0yMiu
         zwSU0WE6Iytk3ZON73dj7r0d4OXoSM4HHuOKMgJE0Rwe71AMwSwDJBFTW9HjDWXxHCHg
         dMlw==
X-Forwarded-Encrypted: i=1; AJvYcCXFMWqlpCTJeivL3pzEWXJtpAIUomXlIlxUq20wVE9sLExYQRxSD6W/o1av02CXevHDIxkF2Lga/Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtrjrOMoARvNqZB6R/XQWPNjkkBrqdJt/OrYI8sGcAsqb0VKT
	Y6pzDpD/1G5bTWbHpXDEIRp3d7EcFrxZKlmfHCNyS708NDgk130ExZxD
X-Gm-Gg: ASbGncsqzp0nWRdO6Ed6sEYj/MiYC5o83DCboHyxMUUHqrKiJU6psEUktrvlX1nNdyJ
	Kv8vznh6svGUCx2iTl8eeMaubNlq5U4eg49c0K4u6SfO16FGgbwj/UtyiV75jlnQuz8c5jMJAoK
	w8rrFoVvdf/4bEs7EMklMX23fGGdBJA9kTIj8jz0YUCguWQyen6nqCsZiEYgxG5VmKwUhUNsLqv
	QSrjowMecMRZokT/TnKQKDNd2YsLrKfOWrtOXlvt7+kcm2I/EjORTS+ZexJ2QxNkty2WEL456op
	l+IWj7QArZqT/MgFKSU9EZT9ORl/cdDMDnXR14czIUQuHlUmMKZl1XWwPzoqq743P/H15e1lcAr
	T3UHwNhKxBSUseEBcPH8Bpm1idQTgTtCcpYMN5pSu1OykQUGz7p92GEevkZC3C2/HtNJovt144n
	/0+1l7u2cjm4s=
X-Google-Smtp-Source: AGHT+IEwEWQ+iKEzskb8FE6eGD1Bqg5KsYukLRbrEwESQEETNCRQHI55/OPuI8Eu80hzVngbE++2Kw==
X-Received: by 2002:a17:903:1a2d:b0:295:bedb:8d7 with SMTP id d9443c01a7336-29d683b103fmr6744205ad.48.1764724168620;
        Tue, 02 Dec 2025 17:09:28 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab42sm165422675ad.5.2025.12.02.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 17:09:26 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 32F404209E4F; Wed, 03 Dec 2025 08:09:20 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Snitzer <snitzer@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] NFSD IO MODES documentation fixes
Date: Wed,  3 Dec 2025 08:09:08 +0700
Message-ID: <20251203010911.14234-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=661; i=bagasdotme@gmail.com; h=from:subject; bh=4JY80Jc5VQhDDV7Kh5EhUJuY6+Adwyzi2qDz/1SyuHc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn6PS9UPmtLTQgUPqRSsV35+KsNx71aTp14/ab/Pu/pu bbc87TudJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAimc2MDE8irT6HTj/qL7oi wHf7hgUX0zQ+yFq9M/z+ac92I152VQaGv4JGkrvrf3zL8bu/QGXh6afTnkY5dn5d/Xu1czT/3vU RnYwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are fixes for NFSD IO modes documentation as reported in linux-next [1].

Enjoy!

[1]: https://lore.kernel.org/linux-next/20251202152506.7a2d2d41@canb.auug.org.au/

Bagas Sanjaya (3):
  NFSD: Add toctree entry for NFSD IO modes docs
  NFSD: nfsd-io-modes: Wrap shell snippets in literal code blocks
  NFSD: nfsd-io-modes: Separate lists

 Documentation/filesystems/nfs/index.rst       |  1 +
 .../filesystems/nfs/nfsd-io-modes.rst         | 33 ++++++++++++-------
 2 files changed, 22 insertions(+), 12 deletions(-)


base-commit: fa8d4e6784d1b6a6eaa3911bac993181631d2856
-- 
An old man doll... just what I always wanted! - Clara


