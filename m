Return-Path: <linux-nfs+bounces-17367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50601CEB097
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E2F0300EE7D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F11FC0EA;
	Wed, 31 Dec 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILXST34C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69ED83A14
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147723; cv=none; b=V+ZQbyOQ+BAc5l9x2nB/WPjcdxLESGPwBDr35fUMFeJ+/OuTzaF1JvuYfmA1KYFHdqgnzPAfDpwpENsOebIOE0ea1nSjWAjVeWq1mrrBqG28t7iiRbstPXo8llF+l5zN0SvPDuEKk7kJbum0h0dZ6Zs7bk42gvt2kxfMWd4fhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147723; c=relaxed/simple;
	bh=Uud3kfiUhEj8pifoPldBbTC49Zy9yaauBHFlktEFHSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUqbYvRQcZpryfuu1wpl8XQdQa04KXcRwv3/oZT43WnDMGN0n5X09asXFUht0ZmlUT8fmUGQFxIGWC/VpETk8mnEsDrzm7YTz3ilJshWEQuvfKqhrfFD9xd93+sgMimSsIclVsr0B/d5BG6ZXc6gzBg+cMLsD8wA4PwYxyKTCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILXST34C; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso8303117b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147721; x=1767752521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/bJFrGi1aMtGj/lYH4fUHPB6AOmHNTC2zaQ+IdkWf0=;
        b=ILXST34C1bMiyJ0uDS9ZLeZM5BUo+KcUQV9Yf8q69Vjsc1IAcHYV+hQe88v01UGzIH
         RLNFy42qtgD2B9VCsf2fK+eLC+0Sn2c+yMfT2faeU+BjEM3WUi+2FD2AVZO4hAdUL/cI
         QROn3sGN/JzR4MlYgnK1dMcEoAqu4N5brRwiiyZjDtJSbiBSmNrQiIBxvL1x505ryMv0
         LIqPguOyynailBsuUeK4amz4A2MV9uLWL0ASg+QarZKgDlyu8gJz1FqhEx5/ayeFt9Mp
         bCHq1T0INhRaoDNeadbras2iVJlnbGo3yuSu2Vwn5nEb/YMTikwl6sBHFN6agLwgbsG7
         JXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147721; x=1767752521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/bJFrGi1aMtGj/lYH4fUHPB6AOmHNTC2zaQ+IdkWf0=;
        b=wzsdK0P3uPLWOPtL3TgDs/VKJJnNp07OUcAqh0wjCj07oULPsKwzewmYkvVVrO/ki6
         mmuPlHEKv7mD5GXbtwc28dw24AlkdWgEtw4BG7sluLRKWbKqn73Rjx7RayDyxtWnw5c5
         uPgod1+TZCB1ELxLPPp6lKNTWma5TRoZWwDucWjeZ6m/LI/QIQxVssRYQzvYiLUG8Nhb
         IALGcO8NFx/lTBk/4YJDFsnY0vjaSDSGBKjV46velC1BtrPv4q4odzQfnx1Pugw72dAN
         k0aeb+b9KrNN7lSxEH1wfoLDfBH9MmPRggtKmH9l8MaXvhwql1Fr9C28BeXwfTV96va2
         kkvw==
X-Gm-Message-State: AOJu0YyOAGGBNfQtv8SLHz1VwTCs4MVEHcJrZ0x+F/iTT0KcqS4ZAjp6
	cBHF+QmF8er2jKFEDLrq601H/3gltyrqH/YVWVuoEmE4+gWxRiIWrfEhsfwk7a0=
X-Gm-Gg: AY/fxX7jExUrcBKb26w1/RsavR5wQVgA5KTDnbbusS69VtbqVfL20m9uQ0WSFCvklrf
	dC+jRIbq3r2gZtySEpTWbo7vciY4f/pBSdgtrPNtSn+5ydr87K2WD+AnvMGldtAyycIPJw8Trj2
	x0C6cLc466NHuDHSU93Px7Ar6yRoy/K2K73Fyz/YY61J6etjvQGcRtueb4OTK+albRuSDvbaZkE
	SS+SP9R0LNZfYWwyC1MTmrILIbLsvo2Sqi6nF3BzbAVWJCBDctax+CE0K4JcKLSB1HXMf6tB9OI
	vghYkPxfmVmyHkaG06rp5D52cTFFz/KUrhq1DOugcRhlWabY3sSDShEqJPeDulhPSgORoWqnGd1
	luz5zRPjFBN8irhiefYD2i0WX6EkUUFtPIfo1koUiPgffwwvry4uQXixdBNeq+ulQTub9DfYt5V
	YGABGtVVNRQuDFuZwZfNeF885pj4ztLErQjDSA2DfrJ+xhlyMQp+lHNNRy
X-Google-Smtp-Source: AGHT+IHyYkCJli8j+ASDhtC7j1oxYa+IR9NdWRNi+tNLdTvMZIgDgRlozKdv12xrlsyhpfpTTeB+wg==
X-Received: by 2002:a05:6a00:330a:b0:7e8:4587:e8c9 with SMTP id d2e1a72fcca58-7ff66a6c17dmr28465590b3a.60.1767147721106;
        Tue, 30 Dec 2025 18:22:01 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:00 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 00/17] Add NFSv4.2 POSIX ACL support
Date: Tue, 30 Dec 2025 18:21:02 -0800
Message-ID: <20251231022119.1714-1-rick.macklem@gmail.com>
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

This patch series implements the server side of
this extension for the knfsd.  It is analogous
to the NFSACL protocol used as a sideband protocol
for NFSv3 and allows the ACLs to be acquired/set
be getfacl(1)/setfacl(1).

The current implementation does not support the
"per file" scope, where individual file objects
store/use either an NFSv4 ACL or POSIX draft ACL
and assumes POSIX draft ACLs are supported for an
entire file system, if support for POSIX draft ACLs
is indicated.

Rick Macklem (17):
  Add definitions for the POSIX draft ACL attributes
  Add a new function to acquire the POSIX draft ACLs
  Add a function to set POSIX ACLs
  Add support for encoding/decoding POSIX draft ACLs
  Add a check for both POSIX and NFSv4 ACLs being set
  Add na_dpaclerr and na_paclerr for file creation
  Add support for POSIX draft ACLs for file creation
  Add the arguments for decoding of POSIX ACLs
  Fix a couple of bugs in POSIX ACL decoding
  Improve correctness for the ACL_TRUEFORM attribute
  Make sort_pacl_range() global
  Call sort_pacl_range() for decoded POSIX draft ACLs
  Fix handling of POSIX ACLs with zero ACEs
  Fix handling of zero length ACLs for file creation
  Do not allow (N)VERIFY to check POSIX ACL attributes
  Set the POSIX ACL attributes supported
  Change a bunch of function prefixes to nfsd42_

 fs/nfsd/acl.h        |   3 +
 fs/nfsd/nfs4acl.c    |  35 ++++-
 fs/nfsd/nfs4proc.c   | 126 +++++++++++++++--
 fs/nfsd/nfs4xdr.c    | 312 ++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h       |   8 +-
 fs/nfsd/vfs.c        |  34 ++++-
 fs/nfsd/vfs.h        |   2 +
 fs/nfsd/xdr4.h       |   6 +
 include/linux/nfs4.h |  37 +++++
 9 files changed, 536 insertions(+), 27 deletions(-)

-- 
2.49.0


