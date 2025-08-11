Return-Path: <linux-nfs+bounces-13557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E40B21429
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 20:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7D21A21BD0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E1C2E2844;
	Mon, 11 Aug 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4wsQJfA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81F2E2675
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936328; cv=none; b=o+Ic+tXXVjdIgpexO1iSr+HmeskM0Pmuz4JIWZlVAZZTlcdtWhYjRtpatl7xp93PrPVSgwQ1e6EbrYnIvlkoO1Ttutk3atAWvel7Nv4PCpxR/U+AfA5kgF/zTbhpU6BKBOLcFuzUG2zWfFpt8IlLXfRaEbC5M8g7iPsW17+2E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936328; c=relaxed/simple;
	bh=t4oS5IKbOzTrdkHkHO9VCG2LW/hWOygoycWTdWcylgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pYvltcHV+GJKZiU8jfG9lS4kwKU+/lYMutBEYQE8bKPtx0xpq0t4lDTNMfz5RL9lLa7q6IZnxl2lLwi0E4csIhdn8wYEwho0gM+gI/6GVqguz99v4UEzmuQON/r87LpCxkCIRdcaGCt6WN5+F9Ogw4PMpDmhi7C0uwABCV1VWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4wsQJfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQYBYWghlqCWPZYgiMWjqWWjG1XdGMGte6u9fNqlmgo=;
	b=G4wsQJfAuBrSsMAfVTmZU6nlTAujhwH/X2arI+aAZ7lRKIg7MLas3ApeSNG8jEMoBZRQlp
	d+wpb18x0pWDTp6s7OSA0FCa7u0FuTnoOkGhoSntI9C5+P8k48UETueIHRTszEqz+07/HJ
	SsCsyrgsJhXVAUhsqqw7Bto4rjfiniM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-4vHKfSCeNUSFtDP6z0MZSA-1; Mon,
 11 Aug 2025 14:18:44 -0400
X-MC-Unique: 4vHKfSCeNUSFtDP6z0MZSA-1
X-Mimecast-MFC-AGG-ID: 4vHKfSCeNUSFtDP6z0MZSA_1754936323
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEF6619560AF;
	Mon, 11 Aug 2025 18:18:42 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F53C180028E;
	Mon, 11 Aug 2025 18:18:41 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 0/2] nfsd/lockd: v3/v4 lock conflict in presence of delegations 
Date: Mon, 11 Aug 2025 14:18:38 -0400
Message-Id: <20250811181840.99269-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi folks,

I see that an NLM lock request when another client holds a delegation
triggers a delegation recall on the server. Is that normal?

Let's say it is normal. Such an NLM lock request fails with
"nlm_failed". Alternatively, if another client doesn't have a
delegation but holds a lock, NLM request gets nlm_blocked and gets a
callback. It seems incorrect that just holding a delegation would
prevent somebody from getting lock?

I believe the reason NLM v3 request (while there is a conflicting
delegation) fails is because break_lease returns -EAGAIN error and
nfsd_open calls nfserrno() which maps it into err_jukebox which gets
propagated to nlm_fopen() which maps any error (other than stale or
drop_it) to nlm_failed. Should nlm_fopen() have mapped jukebox error
into dropit (so that the client tries the lock again?).

Now, let me tie this to a server reboot. Why isn't nlm4svc_prov_lock()
checkin that it's in grace first thing before doing anything further?
When that v3 lock request arrives (during grace) when there is a v4
delegation given out, it prevents the server from triggering a
delegation recall (while in grace) and causing issues of failing the
lock. But I guess it's wasteful if there no conflicts.

Attached to this email disguised as a cover letter to a patch series
are 2 patches where I attempt to address the problem is a failing
NLM lock in presence of a v4 delegation.

I asked about NLM request triggering a delegation recall being normal
because during grace period, when v3 lock comes in and triggers a
delegation recall, the client sends local LOCK request (note it's no
a reclaim-lock because the client sent its RECLAIM_COMPLETE as it was
given a delegation), now this LOCK is failed with ERR_GRACE and the
client can't handle it. Be it a client issue for which I'm sending 
a separate patch. But it all revolves around the issue of whether
or not delegation recalls can happen during grace.

Olga Kornievskaia (2):
  nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
  lockd: while grace prefer to fail with nlm_lck_denied_grace_period

 fs/lockd/svc4proc.c | 15 +++++++++++++--
 fs/nfsd/lockd.c     |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.47.1


