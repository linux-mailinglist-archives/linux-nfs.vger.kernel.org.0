Return-Path: <linux-nfs+bounces-13292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CCB14669
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 04:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D827C5431D7
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 02:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD212147E5;
	Tue, 29 Jul 2025 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGiqIgtc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEB79EA;
	Tue, 29 Jul 2025 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756982; cv=none; b=Fui0/+6qT/vgN2n/bnxWsiqt/oLCspTQpZzPlexiDuivcWYIVYnRgczbJGnngRcE5KEcL+tjdbHkd8wwD+7ndVViSNu1i4lkeRsWi8qON/ESG2EYIDF7sVcnq0mCPRA9fNBa0jZ31RTc1rSwsHoB7TZWdhDcYL2OpknSCkN9Lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756982; c=relaxed/simple;
	bh=FUBW7btLaXRKRkjIgHELqFpqMhpUxePyi5+xQPOOMu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTuLaYB2134o7xsmXZN04e4RaUqHCWJaP96qhNPytRRgPNm5CBn4BLtlwtmKH4+fgBoNkpm4tD2smSKQ2O2Yw/hvZieW6azTmnI2AmSuSbSO2c0xvPEjpkMIYzpAhfINInR0sOEul29rbrJoKWo8/jN0DSvBKhsWesX0QuBkLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGiqIgtc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23ffa7b3b30so20765635ad.1;
        Mon, 28 Jul 2025 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753756981; x=1754361781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltNpeYsaYiriqRttnjOxFTsDxOzsiWp+Zzreeo3S004=;
        b=hGiqIgtcmf5H9MaN/GvK4zM4PYulDit+e1/SrigkIT5LkguA1HFLCuFZ6QRgpa+50x
         VvGfFhfW2bCYqv4EWCX32piu5EpqbmdTNsoc8NddhPsXyUd0IV2/GIvzMDChzf4ReCdW
         GuFW1Hz69wmGIOQDoJ18BYtp/ctEF300dJoTCuZDxkJmPALOElmEOGE3wcNfUWCt0wG6
         AxX+gR4nf+eAvLCgb2dBIHBFfMcurkkgXKL5Mkb918SwECVPnBzFgFhcswXuXGnMp4X9
         8W93mE2n8F1Blrde0HPUkf2TPOMO+23QNqNGglhPqOkSG1UY3QXGhXf6k0a4lQkGdjh7
         KoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756981; x=1754361781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltNpeYsaYiriqRttnjOxFTsDxOzsiWp+Zzreeo3S004=;
        b=Ln1crLz06Dd0SMUx43lXSkf4RZ680Se0m+0vjF6I6gMbDdkn4/lu6HARxUaFqxxpNH
         lOLBBr64Q7u3zWxUpmxkBPy9RhZglLgxW17/t8KsL7nP/fed8GKvuBFhVdb9lFYdOFO8
         zib6VTFKKni8xOr47PVPLZ8PDa4UVLpoqfSjCq0mkYxFoTL9f15Kqc85OSwKIasDPxf8
         XPWhxOfz3WlNNTTLfu7ixX5PzvDgM/KIvGlkjh1Cb3dTtq8ozJ4nhjMzYomNZSwVyN8P
         t1rEukEP8ZxNZzFMWj0ybVxDTJ+fdbi+URe/W5epuK+8ft8ZhK8hepWuYU2Yd/GCdgnP
         6SnA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJUsP8QfuFrWiSjv4jZPJH09SvQnfxU2bvGIC5qwjkiqq9WxXmjSlyXxd3IYXtnTNnIGJLmWZHV2j@vger.kernel.org, AJvYcCVciUi74/Ma25JDdBFfPgoUJIPcMrXFP97/qFJ5QXV5+l9e9L7KQ5HdRbFxZtzUEfSps2ViaqGW@vger.kernel.org, AJvYcCXprEP3Wk5LnaWF1V2+q7jMZ86j1LY12TC8WaK6jxmw+cAl+FP2JBQbdqBX2pSmPlUHEkjqH0vMTe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7SHQV9JWZ75Cyc2pHcfzYwPA7j4cqNFi0jGH/dyqkSMb1czeH
	bHA4jBTm1uLhH15uDGWQRILNRqHpTgYnINLZEFREFSncQlMZwCwiK+yy
X-Gm-Gg: ASbGncsFdT86Eng6D7pr+fPx0OdWWaTpvciKLGh7Y/d4yMRpzVBHXqmgWSihZlROmKK
	r+ZBKh+jy12l5BIH8U4nwgt/jtAMRUe8dKSPNQczyG/AHpGgO+4rz1V6mGWWspCqAR9H7Z55seg
	UX7/n5m1bKmQ1UpY+0U9zUWk3joo6CZzVgmKEdyz5FZw0ApuoBnKV0ptGUqvbXveiTgO/XCoCL1
	Y96aLZk5uL+LfczoW5j/ErlL9UFGAVgaB9rPer+5ZBHO9NKVCFUQsjSEDAKrAQxD+0g8lTVe8hE
	gVALqheY87VbZA30+tHr+c35/xaKaHfApjhYvsFzFuYmZMU5Z5pSDA7oL9NYMyz6uCvFedGhy/C
	8IwZqgGAIC1Xz3MeV1iGnUIs+kw==
X-Google-Smtp-Source: AGHT+IFokfUWEoK1BlXtNlneBLUYXrht2yshaZ90k+I2IvTHjwBEMdVrmYfxeQvJuKnXo6G4WVr5+w==
X-Received: by 2002:a17:903:234c:b0:234:d399:f948 with SMTP id d9443c01a7336-23fb3126f99mr175232585ad.33.1753756980621;
        Mon, 28 Jul 2025 19:43:00 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:00 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 0/4] net/tls: add support for the record size limit extension
Date: Tue, 29 Jul 2025 12:41:47 +1000
Message-ID: <20250729024150.222513-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a tls handshake, an endpoint may specify a maximum record size limit. As
specified by [1]. which allows peers to negotiate a maximum plaintext record
size during the TLS handshake. If a TLS endpoint receives a record larger
than its advertised limit, it must send a fatal "record_overflow" alert [1].
Currently, this limit is not visble to the kernel, particularly in the case
where userspace handles the handshake (tlshd/gnutls).

This series in conjunction with the respective userspace changes for tlshd [2]
and gnutls [3], adds support for the kernel the receive the negotiated record
size limit through the existing netlink communication layer, and use this
value to limit outgoing records to the size specified.

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://github.com/oracle/ktls-utils/pull/112
[3] https://gitlab.com/gnutls/gnutls/-/merge_requests/1989

Wilfred Mallawa (4):
  net/handshake: get negotiated tls record size limit
  net/tls/tls_sw: use the record size limit specified
  nvme/host/tcp: set max record size in the tls context
  nvme/target/tcp: set max record size in the tls context

 Documentation/netlink/specs/handshake.yaml |  3 +++
 Documentation/networking/tls-handshake.rst |  8 +++++++-
 drivers/nvme/host/tcp.c                    | 18 +++++++++++++++++-
 drivers/nvme/target/tcp.c                  | 16 +++++++++++++++-
 include/net/handshake.h                    |  4 +++-
 include/net/tls.h                          |  1 +
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  4 +++-
 net/sunrpc/xprtsock.c                      |  4 +++-
 net/tls/tls_sw.c                           | 10 +++++++++-
 12 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.50.1


