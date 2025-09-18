Return-Path: <linux-nfs+bounces-14548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B850B82AF3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 04:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E381C0727A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 02:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB61FC8;
	Thu, 18 Sep 2025 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqT4IW9i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5547DA93
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163612; cv=none; b=Yk0vO+/h+3MhMpeH+NXiL7AEsAJN6ii0KRuMjFjhw1y6QhYj6LTPsnxBacjDilQGjXmrOJdFKZEL9/Q2CSvhOwE3PIWOapbWH6b6vWyTjbFkDe1jc/HcilaFqZWngZYgJh1WZfzGthmzoi3bT0v+gGipF9E+zS1PCHhsC2NcGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163612; c=relaxed/simple;
	bh=Wmy2ADOogVGuwG1J4TlqwCWzzw77GMcfhajkmkpg3MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4TgM1+/RPzs21kNIpp90rkdnqJlpjS+EuSI0wObi4mVrnGQXTLJaFyxjbH04p4SES+kQtsTR8IuEYvqU8rndr2SIVoypFTQRyadFXOosU8A4TEa+M0BRtBf67PUXtd0SXv6sX5WmID72YaLbYI1v06+y7s+9BUNfH2xkPqOt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqT4IW9i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758163610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zw7zzxn1de4YzJOm+YI7H3omcM1mXPEZQSZKDgXbFWw=;
	b=iqT4IW9ikojUdlrP+2ZmbfvFM+dFje983qhkNYZ/obBYPnZE3rgSjeRqQpqeIcnWALClqQ
	TEYdNhsa2pwVCb5CFYGT7IoedxtWd1Fy1Zv5cHXseF9ntecD/9n0OPnmWQyO27csZDQz5y
	E492H8/ZFNbpv0QaAl65lIC0uKwG0f4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-QiElR3STPjCjZlFjl8b4cA-1; Wed,
 17 Sep 2025 22:46:44 -0400
X-MC-Unique: QiElR3STPjCjZlFjl8b4cA-1
X-Mimecast-MFC-AGG-ID: QiElR3STPjCjZlFjl8b4cA_1758163603
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EE3718004D8;
	Thu, 18 Sep 2025 02:46:43 +0000 (UTC)
Received: from localhost (dell-per660-10.rhts.eng.pek2.redhat.com [10.73.4.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7BE519560B1;
	Thu, 18 Sep 2025 02:46:42 +0000 (UTC)
From: Jianhong Yin <jiyin@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: calum.mackay@oracle.com,
	jlayton@kernel.org,
	bcodding@redhat.com,
	Jianhong Yin <jiyin@redhat.com>,
	Jianhong Yin <yin-jianhong@163.com>
Subject: [PATCH] pynfs: fix nfs4server.py TypeError problem
Date: Thu, 18 Sep 2025 10:46:38 +0800
Message-ID: <20250918024638.3540302-1-jiyin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

without this patch, we will always get follow error:
'''
[root@rhel-9-latest nfs4.1]# python3 ./nfs4server.py -r -v --is_ds --exports=ds_exports --port=12345
Mounting (4, 0) on '/config'
Traceback (most recent call last):
  File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 2115, in <module>
    S = NFS4Server(port=opts.port,
  File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 577, in __init__
    self.mount(ConfigFS(self), path="/config")
  File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 620, in mount
    for comp in nfs4lib.path_components(path):
  File "/usr/src/pynfs/nfs4.1/nfs4lib.py", line 552, in path_components
    for c in path.split(b'/'):
TypeError: must be str or None, not bytes
'''

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 nfs4.1/nfs4lib.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
index d3a1550..984c57c 100644
--- a/nfs4.1/nfs4lib.py
+++ b/nfs4.1/nfs4lib.py
@@ -549,7 +549,7 @@ def parse_nfs_url(url):
 def path_components(path, use_dots=True):
     """Convert a string '/a/b/c' into an array ['a', 'b', 'c']"""
     out = []
-    for c in path.split(b'/'):
+    for c in path.split('/'):
         if c == b'':
             pass
         elif use_dots and c == b'.':
-- 
2.51.0


