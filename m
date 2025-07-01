Return-Path: <linux-nfs+bounces-12835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4FAF0014
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319741883A9B
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9727CCEB;
	Tue,  1 Jul 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnq39Rlp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BC2797B2
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387949; cv=none; b=E6ltCJVVoy/gzkeV+uwRsajP4Qk3NPECONuEyRJ4wReVny55jklSdw3PqOVt4+eKR5Gb6F0k5zDrOh9VGhcyOHtzbE3lORkm9hg6hFqSHnLgahQrUt7mLhmVQmPSjhWv8wBcX3fHkrSuWKhKoL1fkVnGET3McgcvyR9t1lrFZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387949; c=relaxed/simple;
	bh=xn3QiWrr/cxslpYxf0U8Cs6CKjpJPB/cl9dWWjh25Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rqj/23cnGvZG9nbXLMxmkhyB25/VZouQTIJW1u+1QOC7FPwHAMqdXaF4nUbl+fa+k7zhu35kW5VTKfR1uFWKsNgQeF5102jse0n62+LvAFifF7w6OBbwui2Dhss/5advR2Ld/IHkMyJTaJx88CpjAw18ZQu7q+9IkOl4ohPJShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnq39Rlp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vgctXpywFIFHu8j0mDgv2ScSkjltwbJbaiW5QTw6DRI=;
	b=fnq39Rlp78BJrUQXtAujzKmk8Dar+hvwBtmlpD5CMl7h04lUbgeCT0H+V3JzDfoj0levCL
	yaf+7zKQK/78zO4c02LQrBgr9XsNPhkWDW4tLCtQNuVS5pIWKO+UV93VZWk6m7yeG5oVv1
	nI8qwILMs31IXtcD9JuYNt/NUTx30sw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-tdwkJTqnNP6BVvGZ9z97Dg-1; Tue,
 01 Jul 2025 12:39:02 -0400
X-MC-Unique: tdwkJTqnNP6BVvGZ9z97Dg-1
X-Mimecast-MFC-AGG-ID: tdwkJTqnNP6BVvGZ9z97Dg_1751387940
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17FC01944A8D;
	Tue,  1 Jul 2025 16:39:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FC1A1800284;
	Tue,  1 Jul 2025 16:38:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
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
Subject: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Date: Tue,  1 Jul 2025 17:38:35 +0100
Message-ID: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Christian, Steve,

Here are some miscellaneous fixes and changes for netfslib and cifs, if you
could consider pulling them.  All the bugs fixed were observed in cifs, so
they should probably go through the cifs tree unless Christian would much
prefer for them to go through the VFS tree.

Many of these were found because a bug in Samba was causing smbd to crash
and restart after about 1-2s and this was vigorously and abruptly
exercising the netfslib retry paths.

Subsequent testing of the cifs RDMA support showed up some more bugs, but
the fixes for those went via the cifs tree and have been removed from this set
as they're now upstream.

First, there are some netfs fixes:

 (1) Fix a hang due to missing case in final DIO read result collection
     not breaking out of a loop if the request finished, but there were no
     subrequests being processed and NETFS_RREQ_ALL_QUEUED wasn't yet set.

 (2) Fix a double put of the netfs_io_request struct if completion happened
     in the pause loop.

 (3) Provide some helpers to abstract out NETFS_RREQ_IN_PROGRESS flag
     wrangling.

 (4) Fix infinite looping in netfs_wait_for_pause/request() which wa caused
     by a loop waiting for NETFS_RREQ_ALL_QUEUED to get set - but which
     wouldn't get set until the looping function returned.  This uses patch
     (3) above.

 (5) Fix a ref leak on an extra subrequest inserted into a request's list
     of subreqs because more subreq records were needed for retrying than
     were needed for the original request (say, for instance, that the
     amount of cifs credit available was reduced and, subsequently, the ops
     had to be smaller).

Then a bunch of cifs fixes, some of which are from other people:

 (6-8) cifs: Fix various RPC callbacks to set NETFS_SREQ_NEED_RETRY if a
     subrequest fails retriably.

(10) Fix a warning in the workqueue code when reconnecting a channel.

Followed by some patches to deal with i_size handling:

(11) Fix the updating of i_size to use a lock to avoid a race between
     testing if we should have extended the file with a DIO write and
     changing i_size.

(12) A follow-up patch to (11) to merge the places in netfslib that update
     i_size on write.

And finally a couple of patches to improve tracing output, but that should
otherwise not affect functionality:

(13) Renumber the NETFS_RREQ_* flags to make the hex values easier to
     interpret by eye, including moving the main status flags down to the
     lowest bits, with IN_PROGRESS in bit 0.

(14) Update the tracepoints in a number of ways, including adding more
     tracepoints into the cifs read/write RPC callback so that differend
     MID_RESPONSE_* values can be differentiated.

The last three patches (12-14) could wait for the next merge window.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (9):
  netfs: Fix hang due to missing case in final DIO read result
    collection
  netfs: Fix double put of request
  netfs: Provide helpers to perform NETFS_RREQ_IN_PROGRESS flag wangling
  netfs: Fix looping in wait functions
  netfs: Fix ref leak on inserted extra subreq in write retry
  netfs: Fix i_size updating
  netfs: Merge i_size update functions
  netfs: Renumber the NETFS_RREQ_* flags to make traces easier to read
  netfs: Update tracepoints in a number of ways

Paulo Alcantara (4):
  smb: client: set missing retry flag in smb2_writev_callback()
  smb: client: set missing retry flag in cifs_readv_callback()
  smb: client: set missing retry flag in cifs_writev_callback()
  smb: client: fix warning when reconnecting channel

 fs/netfs/buffered_write.c    | 38 ++++++++++++++++-----------
 fs/netfs/direct_write.c      | 16 ------------
 fs/netfs/internal.h          | 26 ++++++++++++++++++-
 fs/netfs/main.c              |  6 ++---
 fs/netfs/misc.c              | 50 ++++++++++++++++++++++--------------
 fs/netfs/read_collect.c      | 16 ++++++++----
 fs/netfs/write_collect.c     | 14 ++++++----
 fs/netfs/write_retry.c       |  3 +--
 fs/smb/client/cifsglob.h     |  1 +
 fs/smb/client/cifssmb.c      | 22 ++++++++++++++++
 fs/smb/client/smb2pdu.c      | 37 ++++++++++++++++++--------
 include/linux/netfs.h        | 21 ++++++++-------
 include/trace/events/netfs.h | 29 ++++++++++++++-------
 13 files changed, 183 insertions(+), 96 deletions(-)


