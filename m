Return-Path: <linux-nfs+bounces-12611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE6AE2A5F
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F5A3B8CDF
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071181E491B;
	Sat, 21 Jun 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCS0tUdm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E44A23;
	Sat, 21 Jun 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750524860; cv=none; b=JPNBdyNoQZM4r8DMwkQpiZwUHHm5GjFV03l440h2LQtryRz4LSEVb0WK3fSydwkjoxcCxtIz4yqB/f0M72qYuq4TRwU98JGs/hBGDINMDTM+GQYsQbLw9GDoV/eVbEQ9yUiQEgTIU9+EjZ3HDWG1VTHlZ5jrJaQkXYSyFzxKM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750524860; c=relaxed/simple;
	bh=1g0CYLHUv3gUzMPX4D0AIu+TjrnBkfwFzW1lteEtzFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMv6AuCb1UFh7K0mUjeJu2vwDxfC+5hUoZZ1UPk3WTGxeELNkhg0sZe4o6C8MUAfyVFeFDETw/ezspAoDhRMKOlw01KaXCq+snxoNAfxFAVn7ntd1+oAsBe8cJPyW7/a6uGZTkcJyHJHSfXsgbY0kDOqJLxx1ndmOYGJbUmcon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCS0tUdm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b3b250621so27082411fa.2;
        Sat, 21 Jun 2025 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750524857; x=1751129657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUGvNAuHh3/+ppp8FFmc+U363gy217rT962FVd3cmJ4=;
        b=SCS0tUdmGE7OP4siGDkAu6iVijGxzSp7bHi1QXa9Y0j9/Ngt4m5A5k0bV5uvvU7Iem
         yM22qwwZUpaTks9nFtzP/k69k3l+Gp8m4Ede8luxIWP42QLOM+1BKssSU3evNA2G5FTq
         h89mW1Qi+HRL60YcV5WR4eN/yNtogsH5o+ZAAuJeHPq0ABhFG+XDysZDDdXcRW/dy3rh
         IR/dD0f/zxw00jdxjtFBzPpypr+QLdU5XK7nA7FEfmmsN/n4iS8J194yTAy5YiHA2Gtr
         Pqa94xYszgHGQLWogJk2pbdX65IDktVodRMg1+dQa2LYev9l/rOgUfpG78M+fQllZy4/
         JXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750524857; x=1751129657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUGvNAuHh3/+ppp8FFmc+U363gy217rT962FVd3cmJ4=;
        b=bV68CCuFNmFDrfvBoH5tAxikTcVd0mC8dz46jCH7CDlUX/kWNFg9+e6oHpL7kLozZa
         DaeKl7fadLKkuCRVyoYQGOARXvD2+ra2tDYa+m1GfaRB4q4u3gkiVIxGgMhSuVNA3FcI
         b7RkktCcrliKwiudyypHgSutnJ/9PD6Ba83+4PZfhcvQiFHLUWzuzVlQ+lfKMcGnCXU0
         uB+T0+pInPJkGBCGeoqKnCpdDPNXNMHlbDIOS2oa07NkvKqOHBk1TP3LiAcEQneEkPIM
         CqoWoOlrDYs/pRG5szHc76YVdSZPVJjV2HCSBcK0NvNY0VtrsnG+TbLC5P6m88l+teoV
         XAoA==
X-Forwarded-Encrypted: i=1; AJvYcCWvy5JprN9UihKc5cOg1nNlf7L9bOBcwfTECW6pxO4Pb+FrMahEJiS38sAc2tk1Hm3VHoKX6+Cq1clar0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4fgm7AJlgWsVB1m/zxf5eZWeV1063iyvgcqyGglFSwSNJPVn
	Oq1Xhtu/ZvVZh6vVAAJ6wm21GpI03KxFT1aGPAiEdPIRChVB3MOEnOTg
X-Gm-Gg: ASbGncso9tC7kFYiGyMG6q87dCfbttIXM4LLdg9n7WMOKkDUMeCzbzHyN014oxaZgCM
	C3jSFM4EI4ue8HW5EsFA3v5RtQlnl6SMNF/ooxQ6Pvj1syCrujEb3bFdE4E6PrcxyBpi1UgvdTR
	U17vt6A/Rp3KbgcuQlVBMyfpcW8lw65l6V8L6nS8UM0nAeQ4p/TI97/QrcsnWeIm2YJ5tnd6mgS
	F3oNnCvSTqA+fNe9O82e5Jr4VCT7Sz/JEy1Cr4oqhzV//kkTLseAxeFuqXBDb+tK1M/qCJYInhj
	rqfMFnptq7a7buRWqcYL/Cwcs0dEkkG7XBPIYrZvv17fQCKfRSLepu/IgByCFfK1Y93O0z7ZBxf
	h4L4LZ+xJw7mUJQ==
X-Google-Smtp-Source: AGHT+IFsqqXvtOeNpRHEVWxc0QMNoEtreXMPLlyhziXFt5El535D453HfbuebaN0604K71u3JokH6w==
X-Received: by 2002:a05:651c:4201:b0:32a:6b13:98d5 with SMTP id 38308e7fff4ca-32b98f2d940mr19762991fa.29.1750524857041;
        Sat, 21 Jun 2025 09:54:17 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.201.55])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980c72ecsm6948661fa.84.2025.06.21.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 09:54:16 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v4 0/2] nfsd: Implement large extent array support in pNFS
Date: Sat, 21 Jun 2025 19:52:43 +0300
Message-ID: <20250621165409.147744-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the result of splitting the patch v3. Removing dprintk is
now done in a separate cleanup commit. No additional changes.

Prerequisite patch: [v3] nfsd: Use correct error code when decoding extents

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Sergey Bashirov (2):
  nfsd: Drop dprintk in blocklayout xdr functions
  nfsd: Implement large extent array support in pNFS

 fs/nfsd/blocklayout.c    |  20 ++++---
 fs/nfsd/blocklayoutxdr.c | 118 ++++++++++++++++++++-------------------
 fs/nfsd/blocklayoutxdr.h |   4 +-
 fs/nfsd/nfs4proc.c       |   2 +-
 fs/nfsd/nfs4xdr.c        |  11 ++--
 fs/nfsd/pnfs.h           |   1 +
 fs/nfsd/xdr4.h           |   3 +-
 7 files changed, 83 insertions(+), 76 deletions(-)

-- 
2.43.0


