Return-Path: <linux-nfs+bounces-17398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B62CEF77E
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E3343001609
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8411C84DE;
	Fri,  2 Jan 2026 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg2Ptkh/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACD45C0B
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396625; cv=none; b=IO4H2TCQfy+eIHIbmqbrg4FbOwQH2vMosAE+PZlvTXswe7GzqImScCn1qzp0zX5KPlILNkYvYr8o8N2s0iG/VtN+4ldQIUp0zAUa4IAb1XrzvfGJOZAAORxcFDNRxO4hako2sc2k+Kw5VXdsQ27D0cNUe1fXurqQVby0v9P1wfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396625; c=relaxed/simple;
	bh=rLFVd+VfFCfaPhsMpU23+GRtCfG5eMdf/RcpcDcxZg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOQx129qWKHxYDUcekcCI/VvXSuxhDfgvZzeu0ovFvG022wVGUSv+UFi8p+Z6NFVvU+R7UiKPEwltYOBnnv3+0GdOJ9g2bCbwlJzyc57brhr+lR9ZC0XI8pWZFjL8qqNLk9c+ioBg0sy39hkZXOHhoMS0FJWTINNwIE0QJ/7r68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg2Ptkh/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso128362445ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396624; x=1768001424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oh2uFiPoRIpYVaQNBhSENkpksGDD9Pj9bwf98fNl2t0=;
        b=gg2Ptkh/alC+B2kZuQ1bnqJPnwgIa54uJAgPOht/8Kn2Q3ZOrKlU8SYtMKDdZwhxDv
         suPnBo9GrNHb8heeR9MtUqD00NZtlNvNl4Hgt/FAZE64CV49CcbphcjiezmLZ7jbPjgE
         HUbiwf1LqdMAAmDDY51IgXIcWKAEDE0oAIlOK1uexQrU3sjqFjbbZRM38Z+K1pxsown6
         NzxXQ62rMuKXrSBt+sNQtY1MgdKrgw1wKl0iou/QeRfX0cG1aBuTN/mUHblohGml2GXB
         +bn+W0cigPotJGdW+MPSK1CiSVdDXblQnondHeN0SDCeapNivlfUtZy6i5Oj+k9OEHFG
         qrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396624; x=1768001424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh2uFiPoRIpYVaQNBhSENkpksGDD9Pj9bwf98fNl2t0=;
        b=BPO6QSYA0HgBrLJWGCAwbKcM1Fpqh13l0xxJbEStIi+DTE5KicDawtTQux8tBbUfig
         ZTkCQJchj/0MMvn54aiPUF0/aI/mDLn0xg7Yyo0aWW0K/7PW39Z26bl0Vd8upZhfD9U8
         epaq+DYtpyXyFsuF3FoSr+hCOUTxWN8x88EgRuZSjj247gQcN5CJqAebQF9F66Swvfi1
         0NhPb45lqNREAI78Va+s1KV+fQH6Yd6+m/BNOzjTjn7Dw04kvzgeVoUFGo/4r/rNRXmq
         qsgIzfoRWpmA4ByO0/E0iUhJsAOkF/bA7RfezLXsh3fToxIV7hVYcpLRw6CvyuHlGPHH
         InbA==
X-Gm-Message-State: AOJu0Yxt56od7Uo93QsPfA6NBa7DMy6nhB0PpO1cdIUWtU7Vw4IyKJYy
	EZDzky8hJJG+ox+b7Agu/3b/y2kQ1RNTkW2I3XGgroCrn37G9+wM99I7wRiRTJ4=
X-Gm-Gg: AY/fxX4tFS7rcPhm+5fjxLgnW4xymVu9MtqZ0dSS685LVJPsWPzhpz9w4JBwcb0YYpo
	KJLBGEdqVWG+D9+w3+FCpx1XXPb8C546o6IPTpAVGgUIpNxWhPe841O8ixuVijlIQLDLnCnIhUL
	zxgk4hhqCUA5OsjNPYAMXEqkB22nLB/7UXLddQvfqCGfpb/3zx72/u1eJg4O9PkFSzsdSNndAtW
	3bXvnXMbh0uJGLGwDVblp22n1AsooB7/n1NevpAw3/fuZFPsqhvnlOvqS9PRPbMmrQPMGAIAshQ
	EmpBRAZtSZo88uCzLhgxgyXDrApx4apIwhWdHN3BGuPa1ux3wx0zToB3SZL2oVOJzUx53KfXw8t
	T6i4RfIyohXAkmpo0vvPy5DURjGEK6taCcbDQYM1RvKe8Hv6DvEc4o+wE5BUsgeT4BMK+nbF01p
	d8ybk1f2KjGKBqE3/1Kgzpx/wgAzwRN+qdTF2wPCKMciJ+xOQn9kL4Rphw
X-Google-Smtp-Source: AGHT+IFDkjsu6v26E+8Cgixw+2O+Qnm4PHimu8c373kWztTKTo6UOcPfZYGq2xxmvKRsfpNSUmF0qA==
X-Received: by 2002:a17:902:d54b:b0:2a2:d2e8:9f25 with SMTP id d9443c01a7336-2a2f28368eamr430203605ad.33.1767396623619;
        Fri, 02 Jan 2026 15:30:23 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:21 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 0/7] Add NFSv4.2 POSIX ACL support to the client
Date: Fri,  2 Jan 2026 15:29:27 -0800
Message-ID: <20260102232934.1560-1-rick.macklem@gmail.com>
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

This patch series requires patch 0001 from
the server series to be applied first.

Rick Macklem (7):
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
 include/linux/nfs4.h    |   2 +
 include/linux/nfs_xdr.h |  51 ++++
 include/linux/nfsacl.h  |   2 +
 14 files changed, 1085 insertions(+), 42 deletions(-)
 create mode 100644 fs/nfs/nfs34acl.c

-- 
2.49.0


