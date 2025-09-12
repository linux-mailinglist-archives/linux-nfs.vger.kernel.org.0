Return-Path: <linux-nfs+bounces-14376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 570ABB55352
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EC0178C44
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88711D54E3;
	Fri, 12 Sep 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7L+iUge"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375041C69
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690822; cv=none; b=ktXcC7IMOvTXBc5QHNGOOZlrYKmkac2JkZqInGkmVQSLt0s8SJWI/e7hFlzuWqcMWtjR8A65P3iE3sone3k5ECImSAqCeI5XdO4NDfTt9jYbmISG8Y/wioZi3ZXO1MMWGGCsdnSf3w+ck47RoOtn6u97xkz4+AJsPkKP+dp+6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690822; c=relaxed/simple;
	bh=UXb6oiZ1a08xukqMWGzQmWMh6jz5S2O37oTIMSab7EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdFNGLIqZ8XTJcpnvXU6WrEVjHFokIm44cuTbL67NZKd4L4BtmYSoYfdfHjmt4ss5fNJnSHdGPMewPuPfgjdGFw7K7kMVYUQhnS6fyYWchaBY0JILe6SDtwk6ylD6nLI6kdUfOUWL+ZidAz9HGGpPbOYYBIMJaHYLQRaq7YaPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7L+iUge; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so1749230b3a.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690820; x=1758295620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrD09NwNNaCCc36kTZDK/vKByj38vuDQyaEDdfXfDJU=;
        b=b7L+iUge4aytQjBq4HgJkLPgCqGydals+8HXZasSFisCsDY3Co81nrXf1I5AA7Pn5q
         6Syc1etDQw+j5O7mAwTR/T+zjpgnRou+nizOfm/u4q0m8Rfgkpcl30eQXnaWO+EXUECZ
         qOuUsJT6Z66MXugQn139UwNPYmBDn0KhCVVXJufy15aSG++QAiUhovWJB3y6gY7lveoC
         1X+JNRVI2KakKoHMevrdZcF/T57+QCk39CS1atfzy3tWJAQrAcFXyEbUGPf9l1qjVlGe
         zRAr0/kUBN/tT/R9lXzJSWq90HzW9drgKZuAlQTEP46T+FZVzOzecbYseyD3QnBRcMEE
         BYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690820; x=1758295620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrD09NwNNaCCc36kTZDK/vKByj38vuDQyaEDdfXfDJU=;
        b=xS+3S6R2k+E0pM0QszkmjDMU9DTczWsTf+eYU+ObOMzwJorGrQzmzXJCfSI6thRQvH
         a6oSgkeknt1PcYepJ1O6vTjLBzWy6xCMpZSGaFiiKn2ipzq9tsdkvZrWPj8LXXqakA2N
         zdYjfAtfjFH41WacWySSHVa0p5ieViA0satLpjT5ilpaCz6kBvhkpTZSLFVf1nOaj891
         jHd3qGPNSfE3lthGv6LBwyfJ3cDC3g1XcBIGGSoWaN86DdmTlKVzkwfOFSctjSnqigXw
         N3nw6J7zSoHl8a07mHWc6bYJ5P3/jpQ1tJqTk2Ri0U/+Zjut+OHUBewYpQh/JfUiYCoa
         39Ww==
X-Forwarded-Encrypted: i=1; AJvYcCW0GlTjJ2ELh4qpHo4fYruyIhQeHZNP9YtwsU7nM5XsKx1skbca7QzutHkENPPZ2E75aHm2OnndCKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLR30xW29EI28fyBl5RWUGISMqN3Td04FrT64lqX9j/q7USgn
	yybbzA/IqumrLtyfBpirnEgNQzrgY1OvSYFObqyTevAyGcNQVqYctB2R
X-Gm-Gg: ASbGnct9IW2i/2iga6wQ+pFLds0MMjJb5XiJhHROyORZIlfWwK6z+kBiWF23gyHvIzW
	yxeAuWGbfMjHsPNHT9cuKrrzpXVjvbDvcK3XiGKXVOaPHSJVm56I9XQD4Z/+mtfAWToV5fmmxeT
	dtJftaVDEC3Suxxy655CDyRKbUv64UZCWsYuoC17Y4mz+ec6h5mAuMkynn/NDZpQD3s46+0E8Fz
	DHHt998IXIAtVKcyPnYuWeRTB5VnuOzhvi03KHudP1lctl5fqJQptmpgmSfH4D3+Ua6fUicHyGz
	hymIsXqxWUOerPAB1FmEo1ORadUlj09TFeutAUeghm1w0++a9k0q/MahqImL9LIQfoYFowd0Oec
	g6wVZQK/F+12lUsnTSAeKglFgV3XyyvuVtrH4
X-Google-Smtp-Source: AGHT+IGUo0K4zIFMUfzF4WpP86EMKMNSUkcTVtq3VjmtoSg0kTDxGd/EyfD7RbMVVOytbEOUNyiPxQ==
X-Received: by 2002:a05:6a20:2583:b0:24d:56d5:369e with SMTP id adf61e73a8af0-2602a593376mr4421336637.3.1757690820222;
        Fri, 12 Sep 2025 08:27:00 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:26:59 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 00/10] add support for name_to, open_by_handle_at() to io_uring
Date: Fri, 12 Sep 2025 09:28:45 -0600
Message-ID: <20250912152855.689917-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for name_to_handle_at() and open_by_handle_at()
to io_uring. The idea is for these opcodes to be useful for userspace
NFS servers that want to use io_uring.

For both syscalls, io_uring will initially attempt to complete the
operation only using cached data, and will fall back to running in async
context when that is not possible.

Supporting this for open_by_handle_at() requires a way to communicate to
the filesystem that it should not block in its fh_to_dentry()
implementation. This is done with a new flag FILEID_CACHED which is set
in the file handle by the VFS. If a filesystem supports this new flag,
it will indicate that with a new flag EXPORT_OP_NONBLOCK so that the VFS
knows not to call into a filesystem with the FILEID_CACHED flag, when
the FS does not know about that flag.

Support for the new FILEID_CACHED flag is added for xfs.

v3 is mostly the same as [v2], with minor changes.

v2 -> v3:
- rename do_filp_path_open -> do_file_handle_open()
- rename the parameter fileid_type in xfs_fs_fh_to_{dentry,parent}() to
  fileid_type_flags
- a few minor style fixups reported by checkpatch.pl
- fix incorrect use of '&' instead of '&&' in exportfs_decode_fh_raw()
- add docs for EXPORT_OP_NONBLOCK in Documentation/filesystems/nfs/exporting.rst

[v2] https://lore.kernel.org/linux-fsdevel/20250910214927.480316-1-tahbertschinger@gmail.com/
[v1] https://lore.kernel.org/linux-fsdevel/20250814235431.995876-1-tahbertschinger@gmail.com/


Thomas Bertschinger (10):
  fhandle: create helper for name_to_handle_at(2)
  io_uring: add support for IORING_OP_NAME_TO_HANDLE_AT
  fhandle: helper for allocating, reading struct file_handle
  fhandle: create do_file_handle_open() helper
  fhandle: make do_file_handle_open() take struct open_flags
  exportfs: allow VFS flags in struct file_handle
  exportfs: new FILEID_CACHED flag for non-blocking fh lookup
  io_uring: add __io_open_prep() helper
  io_uring: add support for IORING_OP_OPEN_BY_HANDLE_AT
  xfs: add support for non-blocking fh_to_dentry()

 Documentation/filesystems/nfs/exporting.rst |   6 +
 fs/exportfs/expfs.c                         |  14 +-
 fs/fhandle.c                                | 155 +++++++++-------
 fs/internal.h                               |  13 ++
 fs/xfs/xfs_export.c                         |  34 +++-
 fs/xfs/xfs_export.h                         |   3 +-
 fs/xfs/xfs_handle.c                         |   2 +-
 include/linux/exportfs.h                    |  34 +++-
 include/uapi/linux/io_uring.h               |   3 +
 io_uring/opdef.c                            |  26 +++
 io_uring/openclose.c                        | 191 +++++++++++++++++++-
 io_uring/openclose.h                        |  13 ++
 12 files changed, 409 insertions(+), 85 deletions(-)


base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
-- 
2.51.0


