Return-Path: <linux-nfs+bounces-3709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A749062FA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA01C21133
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5281D559;
	Thu, 13 Jun 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luxTeRwe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987D8BFA
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252263; cv=none; b=n5LBRqqTpYk3A2xl/Tvl4gDJlvJ19UlhU90+nKQUnjqRNriKJ09hDfZq/8PPh/NCAip+NvCs/wOvzVJ7CR6frwdgt7yeYby/QI5HrnX0DNhowsPhamA00hih3w0Li2oENj/lZGjxN1RvMlOPqGC18FjyqlxOL8JJzEOD0t6eM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252263; c=relaxed/simple;
	bh=8Mq8uAtZWia3UTnxT6VFmnSllAMR8K3s36eiGH15SR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U+t3dn+Yzi+K8w5AXtfxiwNGKlstcBk8pJ4wLq4Ac+y7uvarwRkKpGvp5d2jbizHMMMPh0qiEpC5ZSaleTDvB7vO4xzMBetrtZCzWz3cnARcdfVDqrpRcXm83IwAJCNC492EDIGFodQdtJN6lXBlVUHY3e8hg2/yNhgYW9/mah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luxTeRwe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7955f3d4516so155061685a.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252260; x=1718857060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=es9LhqZ4Jm05dyI++sDpBq6+bzr8UYOF4BC+q1+J0JY=;
        b=luxTeRweE2QLt97lto7ps3edHGQ1aYD/lQ2i1tFF3tJPDBAKGIBQUGBP7VRl3MdHys
         67SalaXiln0LyUjlZKntKenIU+b2jpbHNr9utptzwn88LYDgEet2O2a98bjL0n/iC1Do
         1F6NhX8+CUDZpAH+xoCuKhKxzguJ1YM1N3PZK1BPJKH/vtiresRn9eWi8Vec7B+Fw+4K
         o1cTrFfG3Dc0mwcVLYgoaq1NxBNt2PGkSudUFL6XRUAp74P3XFuUNODe+WGpv2zkGwSE
         TsxZencowqklbfHHRwTvGy3XydmBbh4sZD6xBzwCWd19mYETAkMDJQ6NQOLh+7pukEa2
         +sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252260; x=1718857060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es9LhqZ4Jm05dyI++sDpBq6+bzr8UYOF4BC+q1+J0JY=;
        b=KmHB8v0PLUELBOyKRlK7KwA8oOpoILEc+Yw6oxA7U8WIAhC2eKP4KVbpb5IoVFlp4h
         mUeoDhAcax8x9aMJQVeUGxRJ0jO/LjCo0SfQxyD0T0sR6NR4c9nUSRne3RCgftLQp6JT
         i9noyCYBMQDICzmiKFSpTc5P/6mVK8gMNjHV3EonClUW149uWdGJRs3bgODCRTLKLqH9
         lk+4vGktG+sbSfgBXc/zOyw+PU0Mgx7L2NvmhCGa9esQW2o4ppsOAvgMB6Ire6KTXBq8
         CHS+k6aH1L0t5n/k0LYNf48WXZXeZY1vV8MUhdVVmwYmWULkTyhP4ycZKC5wLdb+AbHi
         qTcw==
X-Gm-Message-State: AOJu0YzyLUwJl7C2TzxsEAy3zapJYdGLN0Ax2I7IqM6ja05dKzObB8gK
	9OMtCdp8gBdXseLPjbEnSy1ZmfTUzntM9wrGLoCebsUT/N5n2qPwnfCb
X-Google-Smtp-Source: AGHT+IGTHVGW3Z7K/D+Oj3EcR8uJ63IK5ybH6rdylF6tGWs6jknuSfU994BP6worMxfO3KWbygFagg==
X-Received: by 2002:a05:6214:2626:b0:6b0:6625:135 with SMTP id 6a1803df08f44-6b2a3448fbamr28042956d6.28.1718252259789;
        Wed, 12 Jun 2024 21:17:39 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:39 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 00/19] OPEN optimisations and Attribute delegations
Date: Thu, 13 Jun 2024 00:11:17 -0400
Message-ID: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Now that https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/ is
mostly done with the review process, it is time to look at pushing the
client implementation that we've been working on upstream.

The following patch series therefore adds support for the NFSv4.2
extension to OP_OPEN to allow the client to request that the server
return either an open stateid or a delegation instead of always sending
the open stateid whether or not a delegation is returned.
This allows us to optimise away CLOSE, and hence makes small or cached
file access significantly more efficient.

It also adds support for attribute delegations, which allow the client
to manage the atime and mtime, and simply inform the server at file
close time what the values should be. This means that most GETATTR
operations to retrieve the atime/mtime values while the file is under
I/O can be optimised away.

Finally, we also add support for the detection mechanism that allows the
client to determine whether or not the server supports the above
functionality.

Lance Shelton (1):
  NFS: Add a generic callback to return the delegation

Trond Myklebust (18):
  NFSv4: Clean up open delegation return structure
  NFSv4: Refactor nfs4_opendata_check_deleg()
  NFSv4: Add new attribute delegation definitions
  NFSv4: Plumb in XDR support for the new delegation-only setattr op
  NFSv4: Add CB_GETATTR support for delegated attributes
  NFSv4: Add a flags argument to the 'have_delegation' callback
  NFSv4: Add support for delegated atime and mtime attributes
  NFSv4: Add recovery of attribute delegations
  NFSv4: Add a capability for delegated attributes
  NFSv4: Enable attribute delegations
  NFSv4: Delegreturn must set m/atime when they are delegated
  NFSv4: Fix up delegated attributes in nfs_setattr
  NFSv4: Don't request atime/mtime/size if they are delegated to us
  NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
  NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
  NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
  NFSv4: Ask for a delegation or an open stateid in OPEN
  Return the delegation when deleting the sillyrenamed file

 fs/nfs/callback.h         |   5 +-
 fs/nfs/callback_proc.c    |  14 ++-
 fs/nfs/callback_xdr.c     |  39 ++++++-
 fs/nfs/delegation.c       |  59 ++++++----
 fs/nfs/delegation.h       |  45 +++++++-
 fs/nfs/dir.c              |   2 +-
 fs/nfs/file.c             |   4 +-
 fs/nfs/inode.c            | 104 +++++++++++++++--
 fs/nfs/nfs3proc.c         |  10 +-
 fs/nfs/nfs4proc.c         | 230 ++++++++++++++++++++++++++++----------
 fs/nfs/nfs4xdr.c          | 131 +++++++++++++++++-----
 fs/nfs/proc.c             |  10 +-
 fs/nfs/read.c             |   3 +
 fs/nfs/unlink.c           |   2 +
 fs/nfs/write.c            |  11 +-
 include/linux/nfs4.h      |  11 ++
 include/linux/nfs_fs_sb.h |   2 +
 include/linux/nfs_xdr.h   |  45 +++++++-
 include/uapi/linux/nfs4.h |   4 +
 19 files changed, 586 insertions(+), 145 deletions(-)

-- 
2.45.2


