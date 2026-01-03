Return-Path: <linux-nfs+bounces-17423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E060CF0711
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B4E7300728B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103A51A9F87;
	Sat,  3 Jan 2026 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/7ovHoF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCF20322
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483679; cv=none; b=kyiI2ilna8CMJKwZR3d6rWOCGBU2fS96e/CE5O456hVEyv+2ec9LCMQJoG3hgVmMpZx01Jh2ar9/MY3w+A5/O5dOZmmy8teiuJ3A39duWTBMa+pUuskXIT2GfvVz1XCUPpzNZytvqZyK8ncgDcJbllwZttmCyEUBQzknxXn1U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483679; c=relaxed/simple;
	bh=j8XlnbkuTl2DjhBdY1lIBcjb2rLWeobiGRb53Hi0kEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhwZDiibyhiR11cYG3Jz8zS3aT/UAkGeO0vE1mcbjwuOb4Bfl0o/x8w4Wmo3dDUsi7ytCB+Y09bg1SpiQnzhveahYvKznDsC4RUBMXzyQFUzWFmLIWdmyp5OrrD7rGhhoVjaO04yLQAekgVLIl+XeZGtw2nIUNRGEuDI6vqMEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/7ovHoF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7f121c00dedso17286439b3a.0
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483678; x=1768088478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fR05hBQZ8fFS9VZTxzR42JvcmfIgn2I3E+WH1P0c5fA=;
        b=b/7ovHoFESIjb74yGdAq6xUF+su8T92TmJ+y8MBQrJW0JrHds9JA4TiwGMNirfpwsF
         Ii3icIdUpu2lmAPOhHiDZNkFwmrBXvDeZ4QxSG14v5sp0QSAkSooGcUGu4bSz8uHMqiZ
         k9PKdwD0tIRXE/0tIT4qfPJb2uR8H/Tv6yFn4t8XligbPkq5UhDzL+MaS03+npBrOHga
         mVEh563qbFv4TU2ccf+y65Lb6jAZbfICRjfMQZtZbtUOKJONu69yXckyn3y6Zw/p6Bpc
         SA/YcyeFJeRedyrrPWNK+QSoU6JwfKv1k9f3IS2tU21mK2DtknSDA7/XFwxDXWeLgnbl
         JSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483678; x=1768088478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR05hBQZ8fFS9VZTxzR42JvcmfIgn2I3E+WH1P0c5fA=;
        b=LxD+ToeV2Hds1Q5AHNvsF8CqWv2HtPIbHcx2A3+PCtOKWpguN7HXTnEVT1jjdB6fRf
         tCMHBrgEvJucdKH7yIdRTKPZYtAXG4IOMW0OFQl2/IdU5bRm/RdtXvFIe2VJH1smkRN5
         ESxGaxCvCZZ9rRMM0Mrv2x/a9wgN1L1/WWJ3RHeZCddM5DtteQGfvLL/88a2tnzuhoVk
         nR7Wb/tNZDycVJe2dKm4z++F2uNZPcnI4+LcS/YBGaWmshCxe/7K3KaH4SGqW2tdazQC
         TgtbFsRHjZPTIrKawXmMLKnG8NzL6bEO5Up9SElN+c6P3NkUw+PklXt9pzMFiIsJJQkF
         1LWA==
X-Gm-Message-State: AOJu0YyOoYa2tbinhjDvlxT+k1FjUWNUQssakaiL5k/QwjU3j/WNPuEP
	ERa7dmB/92YFb9vXR326aQYqNy2yXDUddfu7Wlxir90+BSJx33wB8CVo8syMkK8=
X-Gm-Gg: AY/fxX4+SI5RPmnaAKyrTHXphhTNUSryXZexvlI3pV/ZHQTS+H1LZdgOGixbajvGV5x
	pnwhNVM8QjlX17nSNjCFwePtAvuN0aFQn4bsHk/554rFM1VNyXkSwmNcVp3vs7MuA1tXhFHN0EO
	tVQobygFntVGOIuJJLXUzRGdIH8ANCb7sTERdtvixEou1YX4jzPQ06T7u1dzD3vtLZLcNTS31R6
	iwQlG+Q6xoLAlKShexIw5TrDZWzp/6a6HMGjDxYFtl81ZyjvcLT2/2mFNJQr4abt174ZcUfYkhx
	zIDb2x64L/iNpIHbFtbEHWDH39ll1f3fJ1f5Of3Fy6iUfmASPUGCUIUvIQ9IgW7hzuX6XyNAAvh
	ajvSxJ59weKtMUYeky2JB9FHgjBS8kREu7/xYBD36frtx/13URqP7NSj/7dvhqqLC4Dsf4vG8mX
	bMpIbLNdD7r5T+hbfRNK/sqwN5jnWnFAoynHfJUUFVEOdKVTVqLhT7gaR60VO5on7nimo=
X-Google-Smtp-Source: AGHT+IF2QYSlfGBjJ0cP4HFppD3bYho3wINrWyzPwrjfOYbF7N6pBuvijGvDaOQJ1dOhFqjjI8pxOQ==
X-Received: by 2002:a05:6a20:6a08:b0:35d:6bbc:e9ce with SMTP id adf61e73a8af0-376a81ddb65mr39989603637.16.1767483677607;
        Sat, 03 Jan 2026 15:41:17 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:17 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 0/8] Add NFSv4.2 POSIX ACL support to the client
Date: Sat,  3 Jan 2026 15:40:24 -0800
Message-ID: <20260103234033.1256-1-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The Internet draft "POSIX Draft ACL support for
Network File System Version 4, Minor Version2"
https://datatracker.ietf.org/doc/draft-ietf-nfsv4-posix-acls/
describes an extension to NFSv4.2 so that POSIX
draft ACLs can get acquired and set directly,
without using the loosey NFSv4->POSIX draft mapping
algorith.  It extends the protocol with four new
attributes.

This patch series implements the client side of
this extension for the nfs client.  It is analogous
to the NFSACL protocol used as a sideband protocol
for NFSv3 and allows the ACLs to be acquired/set
be getfacl(1)/setfacl(1).

The current implementation may not handle the
"per file" scope, where individual file objects
store/use either an NFSv4 ACL or a POSIX draft ACL.
The only known file system that implements this
is IBM's GPFS, and only if the "all" option is
set for ACLs on it.  Until a server implements
this case, it will be difficult to implement
correct client semantics for this case.

The last patch is rather large, but I would
get either build failures or build warnings
when I broke it up into smaller chunks.

The only changes from v1 is the addition of
the 0001 patch from the server series, to
make the kernel test robot happy and a small
change to the calculation of NFS4_ACL_MAXPAGES.

Rick Macklem (8):
  Add definitions for the POSIX draft ACL attributes
  Add entries to the predefined client operations enum
  Add new entries for handling POSIX draft ACLs
  Make posix_acl_from_nfsacl() global
  Make three functions global and move them to acl.c
  Make nfs4_server_supports_acls() global
  Set SB_POSIXACL if the server supports the extension
  Add support for the NFSv4.2 POSIX draft ACL attributes

 fs/nfs/Makefile         |   2 +-
 fs/nfs/nfs.h            |   3 +
 fs/nfs/nfs34acl.c       |  40 +++
 fs/nfs/nfs3acl.c        |  44 +--
 fs/nfs/nfs42proc.c      | 304 +++++++++++++++++++
 fs/nfs/nfs42xdr.c       | 642 ++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h        |   9 +
 fs/nfs/nfs4proc.c       |  18 +-
 fs/nfs/nfs4xdr.c        |   2 +
 fs/nfs/super.c          |   5 +
 fs/nfs_common/nfsacl.c  |   3 +-
 include/linux/nfs4.h    |  39 +++
 include/linux/nfs_xdr.h |  59 ++++
 include/linux/nfsacl.h  |   2 +
 14 files changed, 1130 insertions(+), 42 deletions(-)
 create mode 100644 fs/nfs/nfs34acl.c

-- 
2.49.0


