Return-Path: <linux-nfs+bounces-10620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB866A61685
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 17:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72B219C47C7
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8294D204081;
	Fri, 14 Mar 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNLXJqA9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6620371A
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970539; cv=none; b=rlJA01LCFSQJ4GclreC1As7/Xkr4Ni7DqqBR8XT7CPe1Fi/ZNEXgFYft9k88InND+A/MvAm5xTNNiiNJP97fN7cLqIYyGl7Yz6TQZHInWq1OdjGZJ+2Za0TRapaHWyAKbx/WSAXUQaMqpxHn2QlzugOGPBOyYw88sIORf/3H22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970539; c=relaxed/simple;
	bh=2+DwG16QMBDPEwdUhdPr1yjqYgoqnj3ZTWCkDR5/ffk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mirwCGmwz2qFA8k79kmbgvAcszVCvuIo39x5mtLDkxA9D2S8IP9pVcH84AiKFNTgfW2wlEdY8gUrfjXjNrUFJvUT4uW868RPmI9+ClFsuaYzb1NW8PcKGu1Q5G3CD7DUQZOCxpjoUd0KswQQhpRZIBMfOLSTrqaofH1L6XuoKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNLXJqA9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741970534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhpC7Em79XhLPABL01d5PWBwRTBpeD4EFKa0TLLjn5w=;
	b=gNLXJqA9eqYHhWIi3Z54bVj2ZHc+ksPjbSllPpbBA5j0To74Gn+KMdp2MFxYyaYYWmonBE
	D1QScmMxHBb1a+m0AoUapqi7snPft0rjCFfKrIu5s/jX+1c4rJxeWFRUn2aqa0wJ8DDiXH
	fLQFlqC3RzKrrrjztOBbLZY7n3ScoHw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-R5nNYq_EPR67xztwtHa9MQ-1; Fri,
 14 Mar 2025 12:42:09 -0400
X-MC-Unique: R5nNYq_EPR67xztwtHa9MQ-1
X-Mimecast-MFC-AGG-ID: R5nNYq_EPR67xztwtHa9MQ_1741970528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7578B180AB16;
	Fri, 14 Mar 2025 16:42:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 083141828A83;
	Fri, 14 Mar 2025 16:42:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] netfs: Miscellaneous fixes
Date: Fri, 14 Mar 2025 16:41:55 +0000
Message-ID: <20250314164201.1993231-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Christian,

Here are some miscellaneous fixes and changes for netfslib, if you could
pull them:

 (1) Fix the collection of results during a pause in transmission.

 (2) Call ->invalidate_cache() only if provided.

 (3) Fix the rolling buffer to not hammer atomic bit clears when loading
     from readahead.

 (4) Fix netfs_unbuffered_read() to return ssize_t.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (3):
  netfs: Fix collection of results during pause when collection
    offloaded
  netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
  netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int

Max Kellermann (1):
  netfs: Call `invalidate_cache` only if implemented

 fs/netfs/direct_read.c    |  6 +++---
 fs/netfs/read_collect.c   | 18 ++++++++++--------
 fs/netfs/rolling_buffer.c |  4 ----
 fs/netfs/write_collect.c  |  3 ++-
 4 files changed, 15 insertions(+), 16 deletions(-)


