Return-Path: <linux-nfs+bounces-20627-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBT5FFnAz2kM0QYAu9opvQ
	(envelope-from <linux-nfs+bounces-20627-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E463946EC
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BB08300E5BD
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85253B895B;
	Fri,  3 Apr 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAItGCo0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A533B9DAE
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222869; cv=none; b=li/V9G8Ge7KvZpKQDwhsoKJmB3UOlKwL8TaLLFJ594VDQRusCQJrMEpBKnjTp2Bp8yUJEC8JZong/OhgcfNAed3LNwKmem3W/T8zhsdAnHiK8vXrQ8J3QfZMnBovcUlyIGzyHgxIxIOskCb7MmKSaEFyPBaAsLn1AFLVC0zz1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222869; c=relaxed/simple;
	bh=BzZkz7wdI1s39Wool85LDyR37WvjAdptH4C7ykru6eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iowhvCpTMFSNim5XqdV1kJxSwgncyr3Nzco3mZtnMwY+DMFlHXlqWBM+6ZMxW82NVu2kXF+lGyFFNQfVXYMZ1hao/tYM2hbiFJ+aYpRpMF5LAwtcEmGe3pj++3K3/DPEclkRQVgB/QqXQ+GZpuuiPOGu+uPGmcBA3wKbZMgh4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAItGCo0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veaHtuVgdOLj4+GgGnm7a7yoZoN6SkddlHNv7d5F1rs=;
	b=DAItGCo0DEMAmX0J45S3SJdFLRBUf0auVPtJd1T/m1NYgtSO37I4W70wSaHgabaQIYauUa
	6xSWNe6TsUFPaZjW1ZHXEyeDEKIvUOpMLCYwKGPmrVrwK05ZoDeuegyQrnHBbzRTCWmr8U
	7Z5yvycQLX09Te8l/J3dqHAwj7eRW0c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-FN1er9G8OYC0W4e7XqmAUg-1; Fri,
 03 Apr 2026 09:27:45 -0400
X-MC-Unique: FN1er9G8OYC0W4e7XqmAUg-1
X-Mimecast-MFC-AGG-ID: FN1er9G8OYC0W4e7XqmAUg_1775222864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D65A1851060;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AF8A1955D84;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 45B5F749DEE;
	Fri, 03 Apr 2026 09:27:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 3/5] pynfs: remove erroneous test from DELEG24 and DELEG25
Date: Fri,  3 Apr 2026 09:27:36 -0400
Message-ID: <20260403132738.1482011-4-smayhew@redhat.com>
In-Reply-To: <20260403132738.1482011-1-smayhew@redhat.com>
References: <20260403132738.1482011-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20627-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E8E463946EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fattr4_time_deleg_modify is valid in CB_GETATTR and SETATTR.  attrs2
contains the attributes from a GETATTR reply, and will never contain the
fattr4_time_deleg_modify attribute.

Cc: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
Jeff - not sure what you want to do here.  We can compare the the
FATTR4_TIME_DELEG_MODIFY that we sent to the server with the
FATTR4_TIME_MODIFY in attrs1 and/or attrs2, we just need to return
it (or the whole cbattrs dictionary) from _testCbGetattr().

 nfs4.1/server41tests/st_delegation.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 934e558..6ed1f5d 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -400,9 +400,6 @@ def testCbGetattrNoChange(t, env):
         fail("Bad size: %u != %u" % (attrs1[FATTR4_SIZE], attrs2[FATTR4_SIZE]))
     if attrs1[FATTR4_CHANGE] != attrs2[FATTR4_CHANGE]:
         fail("Bad change attribute: %u != %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
-    if FATTR4_TIME_DELEG_MODIFY in attrs2:
-        if attrs1[FATTR4_TIME_MODIFY] != attrs2[FATTR4_TIME_DELEG_MODIFY]:
-            fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " != ", attrs2[FATTR4_TIME_DELEG_MODIFY])
 
 def testCbGetattrWithChange(t, env):
     """Test CB_GETATTR with simulated changes to file
@@ -419,9 +416,6 @@ def testCbGetattrWithChange(t, env):
         fail("Bad size: %u != 5" % attrs2[FATTR4_SIZE])
     if attrs1[FATTR4_CHANGE] == attrs2[FATTR4_CHANGE]:
         fail("Bad change attribute: %u == %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
-    if FATTR4_TIME_DELEG_MODIFY in attrs2:
-        if attrs1[FATTR4_TIME_MODIFY] == attrs2[FATTR4_TIME_DELEG_MODIFY]:
-            fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " == ", attrs2[FATTR4_TIME_DELEG_MODIFY])
 
 def testDelegReadAfterClose(t, env):
     """Test read with delegation stateid after close
-- 
2.53.0


