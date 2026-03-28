Return-Path: <linux-nfs+bounces-20492-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAQ1C+EOyGl+ggUAu9opvQ
	(envelope-from <linux-nfs+bounces-20492-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:24:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871AE34F4D2
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88EE3039EE0
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C673A544E;
	Sat, 28 Mar 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he2Tc3id"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C4345751
	for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718624; cv=none; b=d5zEdpEnE4Vi3MdbjmBKa6MVoczPPmnXJMSIEHIQ/TOkazpntwsQkzbJMZfvK59mF/wNlSDTOwE/EtEMW1rTeQN213jx54THnuwR4ePu7oAz9H869xdAUNVR3F/nNQBkibYCv8AvZoyqFqyzThYz1rl33LpmFcOmpZdxZ4Mj0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718624; c=relaxed/simple;
	bh=WbXqvQhn4qwD4XjOM1f/RolmfvXydvP/QpIVZ5/s984=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIKnbfoR+PRv+Em4yCTIgzppLcw7+lIai1jJjQ+0QC0RIQudD0BZxzcRDBVZbQGSvpl9I3cUOySR2p4lVAKFIj/EuoxtbFvwAsQzZ3QG0PYLXNG0QnhLUsD57mPQbgV6Htl0eidXGLA4YqV5EMUVl8GtGrflxQ5VB4IeEkiCfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he2Tc3id; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35c238f1063so1520067a91.1
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718621; x=1775323421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=he2Tc3id36N/dNrImAB0FtQFWApWtJHTjZ72YR26i8lE+n/7H96TCzG9qYvHmqk+2e
         uhIK/YFXplWVcKkPvGinoa+vojsICJPfJOCo90pDQcWKUw0bcf9YMhWHaGc6t3aDXzaz
         J0ZN74GIXjZxZ1cHytdCxoivIZe9H2+5LHik+R0ySUgsb7V81/k2KYAcaoJxglkogLHt
         itgBsuq/w5xhyhloX2BJw9loZpXt2izQxnRHpMpCU28qK6a3lsRUy1qiplwSVk2WBqXf
         i+gHVslEVJre6VrlGsJP/g1RxCmDbsoFkhecX6fevPzYq0iINcrs9faBGCP9baFUrKFp
         WCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718621; x=1775323421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=V7HrsHMvAHxzQY18/BeBJEUtDQB3pYvqCwsVABSpdxJ1OWpS7y2FagBYQGhpcZIIzi
         1N3IQ1JUMOPN42amT1Sb4PGyo+qJTF8K1HRwVxtObDKpqmUk3UExPb9W5hTWT0j37AA3
         af1QyzxPJava8/vT15pzWkaAfZx2e9m1mqyJHlkntoLZ2JjDDPBCrwyQ5x5RCCMyTVCj
         uAZW4LZ6BQWyHJhzMyabKphQ3hrVlB2+DyMXFtgfOq5iwTzw8RxkmmjA2lBS7wRTAMev
         4j4ZHQ/SlvusgZEOG5cJktgeNAdIx/AhA78czTBgu+XXq0/lL1EG9x8KRwUUTrva6lIu
         yDaw==
X-Forwarded-Encrypted: i=1; AJvYcCVclQC6UPbpCNHfivAXHuxjQSoGM3T5D6+ZCGWua2nDgK6Ahdf6XWnBObMNfHxNnc+YgNr08E3HFA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zVrSaX19B7sFR/zC6IE7WpEsLAQPuoRw17vUXT2kAAQPECvA
	kDvFK3ydW2keQkmAY5RnU/VVkV/n0D3Ko9Bdu/TRkG6HbuJ4tG+6mu7+
X-Gm-Gg: ATEYQzz4f/xedAW4bgHYg1KeCoX7hHjxTSDN90yHAhqlq4OZR6GPfzWTc/JglF47zVM
	3OUBDwFBdzQCmC9jWFYF3RNBVliqtmcGM621P+0jpLxJeOfY0Rns8N3nV4NSmWsdhZBNO879kKQ
	9G9l1bC42nbM1YbM8R3BLrMco4rWVcx1XO+0B4AjtlvyKF7NgDwN9dbnJQ3oaNDblv9kgi7QRbE
	sauQ8Zau4QSr9zlkj3Yee/D18zvNbvHb7dUMF2nlxSZQbkGT5lGYtwC1f7WSbyVUprUOdldPulo
	kC1h+bqAR6sgF89R15Z17RxayQovk76qkiYnxm7xkWVnK2gal9Jz+U0ItBXHklkPJdad5VgfRYe
	5CrL/zdc7TRib91VVLt3gjJrjK2tqh4XOAtN/LwzHAUIIaA6rtTp3WZ16pkkK+1oCLeqpljwgs1
	eeqs5qhnXoffYCZfpG9nj66ZV2ZqyWVtF0IjoSEkOw3mVLmQv/HmX407I=
X-Received: by 2002:a17:90b:2744:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-35c30094a5amr6635171a91.25.1774718620730;
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
Date: Sat, 28 Mar 2026 23:22:21 +0600
Message-ID: <20260328172314.45807-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20492-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 871AE34F4D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

The following filesystems have been tested by building and booting the kernel
x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
regular files can be successfully opened and non-regular files (directory, fifo etc)
return -EFTYPE.
- btrfs
- NFS (loopback)
- SMB (loopback)

Changes in v6:
- OPENAT2_REGULAR stripped from file->f_flags in do_dentry_open so that it doesn't leak in fcntl(fd, F_GETFL)
- BUILD_BUG_ON updated to use VALID_OPENAT2_FLAGS instead of VALID_OPEN_FLAGS in build_open_flags and in fcntl_init
- v5 is at: https://lore.kernel.org/linux-fsdevel/20260307140726.70219-1-dorjoychy111@gmail.com/T/

Changes in v5:
- EFTYPE is already used in BSDs mentioned in commit message
- consistently return -EFTYPE in all filesystems
- v4 is at: https://lore.kernel.org/linux-fsdevel/20260221145915.81749-1-dorjoychy111@gmail.com/T/

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- atomic_open codepaths updated to work properly for OPENAT2_REGULAR
- commit message includes the uapi-group URL
- v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-dorjoychy111@gmail.com/T/

Changes in v3:
- included motivation about O_REGULAR flag in commit message e.g., programs not wanting to be tricked into opening device nodes
- fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
- fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 060000000 to 0100000000
- added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O_* macros from hex to octal
- v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-dorjoychy111@gmail.com/T/

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (4):
  openat2: new OPENAT2_REGULAR flag support
  kselftest/openat2: test for OPENAT2_REGULAR flag
  sparc/fcntl.h: convert O_* flag macros from hex to octal
  mips/fcntl.h: convert O_* flag macros from hex to octal

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
 fs/ceph/file.c                                |  4 ++
 fs/fcntl.c                                    |  4 +-
 fs/gfs2/inode.c                               |  6 +++
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 ++
 fs/open.c                                     |  8 ++--
 fs/smb/client/dir.c                           | 14 ++++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 24 files changed, 131 insertions(+), 35 deletions(-)

-- 
2.53.0


