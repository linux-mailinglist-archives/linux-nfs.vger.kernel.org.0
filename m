Return-Path: <linux-nfs+bounces-20628-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCgULl7Az2ky0QYAu9opvQ
	(envelope-from <linux-nfs+bounces-20628-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C01394702
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 904BB3025E73
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE503B95F0;
	Fri,  3 Apr 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeO97Xne"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DC3BA220
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222869; cv=none; b=QrzB5MBe8mo5cIt4GO3/NhSW7Xbwrsq+mmNYWo8KFJJnzxgwy3aotqlXsa9ObcHOZbjjC0VWeAPaHIkMfXkOTRqQSIVU9/dyZg+RJYwv5kiAMRDNKmgUMFfPRilF1WtEKljwbBz44wP07uMfqt/9jIv06LSvxc+hO2o8WCqW1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222869; c=relaxed/simple;
	bh=4BCY1E1yCglGm3QImKnrHl1d1TO+2aAft8DQTd7JumE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6+OkpSOSQ6htKkDFGCwy3BRbuYYMChcAMTZsgR14sUQ0sRJAOBZpLitnL52PVqO/4nwOQCjKXkomyE6RPXFs8Gv9nWYoLt3HHTFC1AyUOH/wU2uBbofEovDBx2CWsxPhRekD00cU0ljAxo+uD5Vo/46TFGzepK1JjNAO76W8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeO97Xne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AiEBUqa7vpMmGtjNYCiXtICxTFblCYTMocnz570eWd0=;
	b=TeO97XneH/7Y+GjQVson3hvJsvCj4VURB4F+eiPTzKeUm3SruUxBVXMxrqnNODNJL0q9iI
	OwwAhhJwnX1+pDA6eMCtmBrZm6QlWpnYc8sZYMPhLaIeOzGA5PXBMOX5KxA51LZe2MEObu
	TEbSTAL9r3e0l0cUco94pYfU6eZJAL8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-J9RxWmGvN5Wc_338xblrLA-1; Fri,
 03 Apr 2026 09:27:46 -0400
X-MC-Unique: J9RxWmGvN5Wc_338xblrLA-1
X-Mimecast-MFC-AGG-ID: J9RxWmGvN5Wc_338xblrLA_1775222865
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73AE8191DFD6;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E3EF19560A6;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 1E118749DEB;
	Fri, 03 Apr 2026 09:27:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] pynfs: a handful of fixes and a new CB_GETATTR test
Date: Fri,  3 Apr 2026 09:27:33 -0400
Message-ID: <20260403132738.1482011-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20628-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73C01394702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patches 1-4 are fixes/cleanups, but patch 3 might need a change (I
removed the erroneous check, but we might want to replace it with
something else).

Patch 5 simulates an actual application issue where the application is
failing because it's getting a unexpected/surprise mtime update for a
file that it's tracking.

Scott Mayhew (5):
  pynfs: ensure tests clean up after themselves
  pynfs: fix the check for delegated attribute support
  pynfs: remove erroneous test from DELEG24 and DELEG25
  pynfs: _testCbGetattr() should check the delegation that was received
  pynfs: add delegation test for CB_GETATTR after sync WRITE

 nfs4.1/server41tests/st_courtesy.py   |   2 +
 nfs4.1/server41tests/st_delegation.py | 227 +++++++++++++++++++++++---
 nfs4.1/server41tests/st_sparse.py     |  10 +-
 3 files changed, 215 insertions(+), 24 deletions(-)

-- 
2.53.0


