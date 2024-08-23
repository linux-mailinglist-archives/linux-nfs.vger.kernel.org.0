Return-Path: <linux-nfs+bounces-5615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926595CFD5
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37461286139
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655F1E517;
	Fri, 23 Aug 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC6jRlhm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0D18455C
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422451; cv=none; b=rlPrTH1H8CLzjdMMkeS6ur1xY/wK9MBy+5n6iORby2yRfxm1F6gUvO2nWvy2wLmwF85zz8iflcZG4Xtg1EHhhcYvUsE9z0ArkKMGSiEE+KQu5OjJEVILvUpKOlW/ccLoX30OQvLx6J19adR0vMH/H+YBFUQ5BOBRbs1gDDN/kB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422451; c=relaxed/simple;
	bh=8SLyFlX+1KUGJ5VeeYfnrOLfSioUGxBezz7eYYWcH5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JuRPzpx3fiQmTf4IaoQwGVTImh/JRP1B7G31xSLQE3A6AjtdGoM28C5yV2otz4MgIPsJNnxfESVvrqrlYjWbyzjMgah6PGpv4nfGKIv8qPvD5I0niXWl/DHdBOVCOnkJ6ve8GuBEmyQe5O/upeC70izubezvL+SSXEg5bGNBeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VC6jRlhm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724422448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dgwn+Uc/koOhcRV5TBhrWYV0miZSr0hqrXHmYrPCgsM=;
	b=VC6jRlhmoOuey5i32qSknQMyl4dORR2qDqEXcRuRhFNOXRIFFaSmvG4R3K2ECX/m2UgxFl
	UIxuj91xspFxBbCE6hpSO44NxkPua6sXErZ0Wsv0g4EAu48MMr5dvVIab/Phv0UHXzq3cK
	7ZDrXa2fxBg2AJNQ6BS3rKCGSbqcZ2k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-qZN9oTr9OZGTtnjp34UFjw-1; Fri,
 23 Aug 2024 10:14:06 -0400
X-MC-Unique: qZN9oTr9OZGTtnjp34UFjw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B17921955D4B;
	Fri, 23 Aug 2024 14:14:05 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.16.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70EB419560A3;
	Fri, 23 Aug 2024 14:14:04 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfsd: prevent states_show() from using invalid stateids
Date: Fri, 23 Aug 2024 10:14:01 -0400
Message-Id: <20240823141401.71740-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

states_show() relied on sc_type field to be of valid type
before calling into a subfunction to show content of a
particular stateid. But from commit 3f29cc82a84c we
split the validity of the stateid into sc_status and no longer
changed sc_type to 0 while unhashing the stateid. This
resulted in kernel oopsing as something like
nfs4_show_open() would derefence sc_file which was NULL.

To reproduce: mount the server with 4.0, read and close
a file and then on the server cat /proc/fs/nfsd/clients/2/states

[  513.590804] Call trace:
[  513.590925]  _raw_spin_lock+0xcc/0x160
[  513.591119]  nfs4_show_open+0x78/0x2c0 [nfsd]
[  513.591412]  states_show+0x44c/0x488 [nfsd]
[  513.591681]  seq_read_iter+0x5d8/0x760
[  513.591896]  seq_read+0x188/0x208
[  513.592075]  vfs_read+0x148/0x470
[  513.592241]  ksys_read+0xcc/0x178

Fixes: 3f29cc82a84c ("nfsd: split sc_status out of sc_type")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c3def49074a4..8351724b8a43 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2907,6 +2907,9 @@ static int states_show(struct seq_file *s, void *v)
 {
 	struct nfs4_stid *st = v;
 
+	if (!st->sc_file)
+		return 0;
+
 	switch (st->sc_type) {
 	case SC_TYPE_OPEN:
 		return nfs4_show_open(s, st);
-- 
2.43.5


