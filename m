Return-Path: <linux-nfs+bounces-6842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF898F711
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C297E1C22625
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B11AC43D;
	Thu,  3 Oct 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE/4wFrv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8511A727F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984106; cv=none; b=dVCLcQT5BbC8CPVbpI5SYoBRqQMY/ka1Ey4QNpbA1zVD+9JxSN86UWXtFAmbYaxIr7b8S741PTTBGE+iiKKPsEDq9/Pjnx1B90cumt8OrtIgtT9RzCdinDySuRr78c3V7B/Ggo07TnwN1RDt4faZWT24XAI0jgVkVlcWaPDKt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984106; c=relaxed/simple;
	bh=lXnFhatC0gr2S9l+QmlKyrqj7IVkAxRke2ZBrlkLh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A51QLq1YciLHDzxYI9G3xuLUFI8KhH6vSyjy267pi87XtNOabF8AUq+nrtupZduyipuUlAmejZR/exabUMbjykxunTie6Q18UxQ0LoCqs88GjnIvuSdbk2poACoaDNPAqMe0yOp7GL2kIM08vA2sdaWYGsa8yTDbcpqi8hZ/KFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE/4wFrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7908CC4CEC5;
	Thu,  3 Oct 2024 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984105;
	bh=lXnFhatC0gr2S9l+QmlKyrqj7IVkAxRke2ZBrlkLh2I=;
	h=From:To:Cc:Subject:Date:From;
	b=qE/4wFrvsi6GiyjLuhfcqA6y3sDUp1GED9JFJyAPPk+FQ8dydJcNAxS9fFFdqIUQR
	 9P0iOuAjs/JRDTD3EiugUGsu5Q2eEU0NlEHVtdb8at/MBtWWCu364T4Ki/xSWp1QoI
	 rxGho4WihD4EsXJLGXYfdaz1ZTr9/fRLw947T2pjU3Dz/JvYxJ67AebewECt71A+fL
	 92JToLqFUUjMxhtnWQoUMrlp7ff2L6ccoJK0/IVccNVaGTm9YHYX7rAsC1J8gf1+3L
	 l0+ZWtBmu6j/RWFyiDLQ9imCybSSpRWeyKD2NKZV/t4ncEyHrBcNhNdvXPKbuLSDWY
	 nkC7j8voznAtg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 0/7] NFS LOCALIO: fixes and various cleanups
Date: Thu,  3 Oct 2024 15:34:57 -0400
Message-ID: <20241003193504.34640-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The first 3 patches are clear fixes which are needed ASAP (patch 1 is
the same from v1 of these series, patch 2 and 3 are new fixes).

The other 4 patches are cleanups that are more subjective (relative to
them being sent for 6.12-rcX), I'd prefer they go upstream now but I
can carry them until 6.13 if that is how others would like to proceed.

Please note that there are 3 other LOCALIO related fixes that should
be merged into 6.12-rcX:

filemap: Fix bounds checking in filemap_read()
https://lore.kernel.org/all/c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com/T/
- still needed, Willy or Christian can you please pick this up?

filemap: filemap_read() should check that the offset is positive or zero
- Christian has staged this in linux-next via fs-next

sunrpc: fix prog selection loop in svc_process_common
- Anna has acknowledged the need for this fix but it isn't staged yet

Thanks,
Mike

Mike Snitzer (7):
  nfs_common: fix race in NFS calls to nfsd_file_put_local() and
    nfsd_serv_put()
  nfs_common: fix Kconfig for NFS_COMMON_LOCALIO_SUPPORT
  nfsd/localio: fix nfsd_file tracepoints to handle NULL rqstp
  nfs/localio: remove redundant suid/sgid handling
  nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
  nfs/localio: remove extra indirect nfs_to call to check
    {read,write}_iter
  nfs/localio: eliminate need for nfs_local_fsync_work forward
    declaration

 fs/Kconfig                 |  2 +-
 fs/nfs/localio.c           | 96 ++++++++++++++++----------------------
 fs/nfs_common/nfslocalio.c |  5 +-
 fs/nfsd/filecache.c        |  2 +-
 fs/nfsd/localio.c          |  2 +-
 fs/nfsd/nfssvc.c           |  4 +-
 fs/nfsd/trace.h            |  6 +--
 include/linux/nfslocalio.h | 15 ++++++
 8 files changed, 68 insertions(+), 64 deletions(-)

-- 
2.44.0


