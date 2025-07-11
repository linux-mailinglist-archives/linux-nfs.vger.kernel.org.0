Return-Path: <linux-nfs+bounces-12995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46749B02018
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FD2545503
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944A2EA478;
	Fri, 11 Jul 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hparBPnt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E382EA14A
	for <linux-nfs@vger.kernel.org>; Fri, 11 Jul 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246620; cv=none; b=XjRWjYe14AYwakPyPSSRGraKWVkl/S0LDZNXQUByxB6D+cWmMBPawyhIUdOo+hJUp5KtAwidxzYRIqi9VtMlwZkDBiiKdeliollXthc/FJ9V+1TQqu4uAw7lCzrJziB1IyhGIRikOAW04hZoa6akjKuZRMbWUinY1J7S6lkx/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246620; c=relaxed/simple;
	bh=vl5/+yZjr/5bLFxQsllWnUlwlQ8txEkCdIKXTXUNMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MM5OoHYLNonaztopsmiF064Ym/ZBgs8Y5ZpkQCTQDZ/8YmEG8ubdyKkp2RGzWrMIOyDC0NEFqaKF0VziqCyohabDOrO0dv+S78mK2ZBlmpACFukMW24oRwH1UI24dAvoSoViouRmJKdE3kOoRQdpicmhBsivpxZVilH7E7j/hJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hparBPnt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752246617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Wi1ac6epZO5NoWEvSel2tFSY9RY1xohxrC8k+pRSGw=;
	b=hparBPntBidhcOoA69mvkzb24I/kObYPgw7qxTjWMWw65botSN8BkvGZQHPpAt8sVpUCX0
	8car8RGnvA965XRu+YA6AqGTowxviGS3/BTY2QMcyijYRqY+09udenpeofZb3O7AExXM3c
	rLJDOqitKp528AMtR+n50v5heDWjrBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-8CWVbDW_MRW249P7RwTGIw-1; Fri,
 11 Jul 2025 11:10:15 -0400
X-MC-Unique: 8CWVbDW_MRW249P7RwTGIw-1
X-Mimecast-MFC-AGG-ID: 8CWVbDW_MRW249P7RwTGIw_1752246612
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFC2D18011EE;
	Fri, 11 Jul 2025 15:10:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CAB71956094;
	Fri, 11 Jul 2025 15:10:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] netfs: Fix use of fscache with ceph
Date: Fri, 11 Jul 2025 16:09:59 +0100
Message-ID: <20250711151005.2956810-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Christian,

Here are a couple of patches that fix the use of fscaching with ceph:

 (1) Fix the read collector to mark the write request that it creates to copy
     data to the cache with NETFS_RREQ_OFFLOAD_COLLECTION so that it will run
     the write collector on a workqueue as it's meant to run in the background
     and the app isn't going to wait for it.

 (2) Fix the read collector to wake up the copy-to-cache write request after
     it sets NETFS_RREQ_ALL_QUEUED if the write request doesn't have any
     subrequests left on it.  ALL_QUEUED indicates that there won't be any
     more subreqs coming and the collector should clean up - except that an
     event is needed to trigger that, but it only gets events from subreq
     termination and so the last event can beat us to setting ALL_QUEUED.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (2):
  netfs: Fix copy-to-cache so that it performs collection with
    ceph+fscache
  netfs: Fix race between cache write completion and ALL_QUEUED being
    set

 fs/netfs/read_pgpriv2.c      |  5 +++++
 include/trace/events/netfs.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)


