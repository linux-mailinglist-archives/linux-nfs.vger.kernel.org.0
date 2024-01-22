Return-Path: <linux-nfs+bounces-1221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685D83629A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC7B288B63
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D833CF4B;
	Mon, 22 Jan 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbjRnaQj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CF3C070
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924220; cv=none; b=Xg84YkUL8v89xZjv8W0S5Hl9tn+fi+bAotbCalbotCrVmk8MPbX4tUT4h5UG/p7bxCY9PvAz3MslLjftMiKAKle94P5PIbcey/61+ERY1ijXpmSUApdkIK5xPIh0kg9a4WYEAGOxw00vY35GNYryeNUSWo+Q243tO2WmlRThsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924220; c=relaxed/simple;
	bh=kFnATUc6YR+2EBGeiZ34YCxV4uvK7zx2v+t9COfwuaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0mLCPOQCUQMmhxPyFPq4qd+SsTxJW+ZH506mBuIK8Tv/hCQv9I0NH2rhVjaiC8P6yPoO6qFuiWijuqGzXhFt/eyR+LVsl8RxiKNxD1fMksgkpgEdpmQPh/kbrjX9eQr+Hr9rvZWVnA9dPLjVtgXfIikqp/oXwB6hTcdGM0X2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbjRnaQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWBG3EUB+eR+nnWK36e3AyikYbZKtHzO5qoTjiHlzFA=;
	b=ZbjRnaQjj7EaMV2a6RR3BlUkaChtXJawc13eiBu93FMRVQMIiBbCUD9xlcnO31AGxhTrGU
	Ks9C/EOSHcoL5fFd5srdsoRW21ALn97WAvRD4UrJ77je0O1tnKCOWQN5EtMm4vYYerp4mP
	XVYSnSr6OLiMADb0TYJ3cixo1yAvkcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-dkNhJT87Mlyeyizr-tyMEA-1; Mon, 22 Jan 2024 06:50:12 -0500
X-MC-Unique: dkNhJT87Mlyeyizr-tyMEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0238684852A;
	Mon, 22 Jan 2024 11:50:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E527B111E40C;
	Mon, 22 Jan 2024 11:50:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netfs@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] netfs, cachefiles: Update MAINTAINERS records
Date: Mon, 22 Jan 2024 11:49:59 +0000
Message-ID: <20240122115007.3820330-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Update the MAINTAINERS records for netfs and cachefiles to reflect a change of
mailing list for both as Red Hat no longer archives the mailing list in a
publicly accessible place.

Also add Jeff Layton as a reviewer.

The patches are here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

tagged as netfs-lib-20240122.

Thanks,
David

David Howells (2):
  netfs, cachefiles: Change mailing list
  netfs: Add Jeff Layton as reviewer

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


