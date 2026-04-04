Return-Path: <linux-nfs+bounces-20642-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPEEAMhb0GkA7AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20642-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:31:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4591399559
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0337A301CFAE
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A423D7C2;
	Sat,  4 Apr 2026 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0QWcMF2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799022652D
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262657; cv=none; b=Q+Hq2sBYBu79Xns7lRmVO3xqG0vWPCw0LC5sssdYFRECkRVaVKfGMgKGOmMXdZ3dJIlVVcZUgeFLBEFCdJ+MMV14tool/9eE46yGg13bxQOAOSFcwXuf+T9cM/v00Z5/L+RLfDusl1DFe3oQ3k9NasfuTpUihMICXNL0P84i9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262657; c=relaxed/simple;
	bh=DTkf9p+IGlx6vKM8SHLnDpTuDQJTqGtOUmppcFFvUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+Q8OzzJpOspdAHOlTiMghFJyuq1qhhig/D5+F41rcIH9Cb2U305WGzZCo+fOePZSv3A2DM1FNk9EHfCi3s2KvSGpKNieCyuzAK+hL7+GaiwYmC1oOmorbHM8CVRw+Hj9wkdw9tLalqndcm/xXSgS0L1CQzWENmxUSgVzkcKQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0QWcMF2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775262655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiCwDZstq5aJbe4LYzSx+3NktZ9S6qCBfqlln7xo4P8=;
	b=W0QWcMF2Lgpd19gVrYuNHSeJKYLoEAP58gA4qWe8zySOTwJbYwoDbq8Tj+jR1s+TgrXYca
	nYhUrRWiue8ExXT2+mYVflQa10cI54Zl5kTn7TA3fvuJzHTWQ4cUkRjCJqYxM42PzgGFg6
	fdQnsxni2xBA2852oElFXX31T3/3jSE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-3LGtqm_HPjq4WwceI5KIqA-1; Fri,
 03 Apr 2026 20:30:53 -0400
X-MC-Unique: 3LGtqm_HPjq4WwceI5KIqA-1
X-Mimecast-MFC-AGG-ID: 3LGtqm_HPjq4WwceI5KIqA_1775262652
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542871955F56;
	Sat,  4 Apr 2026 00:30:52 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2572A1800576;
	Sat,  4 Apr 2026 00:30:52 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id ED161749EAD;
	Fri, 03 Apr 2026 20:30:50 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 2/5] pynfs: fix the check for delegated attribute support
Date: Fri,  3 Apr 2026 20:30:47 -0400
Message-ID: <20260404003050.1560149-3-smayhew@redhat.com>
In-Reply-To: <20260404003050.1560149-1-smayhew@redhat.com>
References: <20260404003050.1560149-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-20642-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E4591399559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The DELEG24 and DELEG25 tests should work regardless of whether the
server supports delegated attributes or not.  fattr4_supported_attrs is
a bitmap4, so FATTR4_OPEN_ARGUMENTS needs to be shifted when checking to
see if that bit is set.  Fix it, and remove the now unnecessary check
added by 3216fc3 ("pynfs: fix key error if FATTR4_OPEN_ARGUMENTS is not
supported").

Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Jeff Layton <jlayton@kernel.org>
Fixes: f684000 ("st_deleg: test delegated timestamps in CB_GETATTR")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/st_delegation.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index d41f12d..934e558 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -345,10 +345,7 @@ def _testCbGetattr(t, env, change=0, size=0):
                 OPEN4_SHARE_ACCESS_WRITE |
                 OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
 
-    if FATTR4_OPEN_ARGUMENTS not in caps:
-        fail("FATTR4_OPEN_ARGUMENTS not supported")
-
-    if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
+    if caps[FATTR4_SUPPORTED_ATTRS] & (1 << FATTR4_OPEN_ARGUMENTS):
         if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
             openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
 
-- 
2.53.0


