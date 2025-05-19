Return-Path: <linux-nfs+bounces-11797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C3ABB83C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3261892207
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291526C38D;
	Mon, 19 May 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsCCb64K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4C26C3A1
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645647; cv=none; b=NoKzzU1Hvxu5EuCOEBxsLKvix7RJXGvWMKGoYO4xKXvKlko0qHwhS3Bk/zapTLhvnsy2Yekel6FPzmmSOpe0QYvgb/rnv3Doxg4pMIJHRmtMKrHRP0hcOVcQ8KM8IOigKeLQCZLTHFa8ZWVBCb037ER/Pzn/9iHOQMTMIOz4YN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645647; c=relaxed/simple;
	bh=4rBX6YspVYCIDPNLZKRc2wJwrp2OYC47FhKHqNl0FwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1bw+Gxleo92iXGjUCZbL2cgiBRmSg6ILpRBS3d8VD/bFcrwpOkPRwakpGZqyPOq1mePndIQlIJ51rDtAvM91ze5ZrkrUIJR4mNjUgTCUYW3dQwFgzLyeY7NVDf+tl7viAIIBkzHCVknFTqrSKJwJ1DrE4qSXkeHeenM+JtRcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsCCb64K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DkN9GuwbtueXsDOI2wUEzNlSJ5jf3RNLBFIQXl+y3I0=;
	b=NsCCb64KZQtKGAAmCgpM1gtrBwUzd5J7toCwL7hi3oyVhl5MP4Hfg2u1keWAKdNc+kuLWD
	7Cfyow9ri6yDt8ANNYlgQJIELRkcJkx1Of5NlgCr4i99f40emro5aS0Dlzw04jfkZbK2D7
	q77kj16UbkVkPQCOu2XO2GBCSLEa8mw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-1IDUbA_mOAWUFZRkcSDKlg-1; Mon,
 19 May 2025 05:07:19 -0400
X-MC-Unique: 1IDUbA_mOAWUFZRkcSDKlg-1
X-Mimecast-MFC-AGG-ID: 1IDUbA_mOAWUFZRkcSDKlg_1747645638
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80BD41800447;
	Mon, 19 May 2025 09:07:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEBE9195608D;
	Mon, 19 May 2025 09:07:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] netfs: Miscellaneous fixes
Date: Mon, 19 May 2025 10:07:00 +0100
Message-ID: <20250519090707.2848510-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Christian,

Here are some miscellaneous fixes and changes for netfslib, if you could
pull them:

 (1) Fix an oops in write-retry due to mis-resetting the I/O iterator.

 (2) Fix the recording of transferred bytes for short DIO reads.

 (3) Fix a request's work item to not require a reference, thereby avoiding
     the need to get rid of it in BH/IRQ context.

 (4) Fix waiting and waking to be consistent about the waitqueue used.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (3):
  netfs: Fix oops in write-retry from mis-resetting the subreq iterator
  netfs: Fix the request's work item to not require a ref
  netfs: Fix wait/wake to be consistent about the waitqueue used

Paulo Alcantara (1):
  netfs: Fix setting of transferred bytes with short DIO reads

 fs/9p/vfs_addr.c             |   2 +-
 fs/afs/write.c               |   8 +-
 fs/cachefiles/io.c           |  16 +--
 fs/ceph/addr.c               |   2 +-
 fs/erofs/fscache.c           |   6 +-
 fs/netfs/buffered_read.c     |  32 +++--
 fs/netfs/buffered_write.c    |   2 +-
 fs/netfs/direct_read.c       |  10 +-
 fs/netfs/direct_write.c      |  12 +-
 fs/netfs/fscache_io.c        |  10 +-
 fs/netfs/internal.h          |  42 +++++--
 fs/netfs/misc.c              | 218 +++++++++++++++++++++++++++++++++++
 fs/netfs/objects.c           |  47 ++++----
 fs/netfs/read_collect.c      | 178 ++++------------------------
 fs/netfs/read_pgpriv2.c      |   4 +-
 fs/netfs/read_retry.c        |  26 +----
 fs/netfs/read_single.c       |   6 +-
 fs/netfs/write_collect.c     |  81 +++++--------
 fs/netfs/write_issue.c       |  38 +++---
 fs/netfs/write_retry.c       |  19 ++-
 fs/smb/client/cifsproto.h    |   3 +-
 fs/smb/client/cifssmb.c      |   4 +-
 fs/smb/client/file.c         |   7 +-
 fs/smb/client/smb2pdu.c      |   4 +-
 include/linux/fscache.h      |   2 +-
 include/linux/netfs.h        |  14 +--
 include/trace/events/netfs.h |   7 +-
 net/9p/client.c              |   6 +-
 28 files changed, 427 insertions(+), 379 deletions(-)


