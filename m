Return-Path: <linux-nfs+bounces-14626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD42B97AB7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8517ACBD8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 21:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94A430F7F2;
	Tue, 23 Sep 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efOg928D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF730E0E2
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664802; cv=none; b=aItbXMLvdso1FE6ebXHO3gKONvkvVgtryKeMuU2IrMOOBcQ3kOLhTc7PQUA05r+JzUT94U3fTWJyPYhLl0Z3HKqeoH4ISnR16XSbhaf4LLfK7izoGM1Mc7Y1Vx+IOvS8tyEkZhlFMhf9dVLPhsBaMcTeYzkzTTNOeYNeM7H9SUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664802; c=relaxed/simple;
	bh=VISiTaaV9IUO2W+Pbepv4dlCeedzdH0GeyejpDul1uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBm71XBn8ovgRWvnR5R3vRCTszlVLWCqBDDa1GFyaiI3fcP26yQ1Em+ySZAf/VuPWg3uqcnqC/IeNoYWCZYKShayuFwNynAlChoNZWNwl1FuWnms+m4NlzE6UdEb1aGfHvoDJ9dqE60bZo1YZqJgTKTbp87fQXm2mzjDE1ZkFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efOg928D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+2fJjJ/8w40O0ZMcCl9eAoVLeCfm1OnaIoZ8e1shI6A=;
	b=efOg928DchRn+9uuaKzac2BzaNnD1g4Qb83snmpRc7aGUerbe2G0ey+ES/FLfiFIkUzxVv
	ACNxUI1iWHMMyTaJonJQ560g3FQULZZJGVTh3nUmgembdghH21J3wsaFG8DLaQle8MAbe2
	t0bmjWIzzqMzlPY/M2ZPOfnB9RBgYRg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-kdt89HTDNIWEf5Q47UVP-g-1; Tue,
 23 Sep 2025 17:59:56 -0400
X-MC-Unique: kdt89HTDNIWEf5Q47UVP-g-1
X-Mimecast-MFC-AGG-ID: kdt89HTDNIWEf5Q47UVP-g_1758664795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AA251800343;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A9CE300018D;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id D7F3846F6F4;
	Tue, 23 Sep 2025 17:59:53 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] pynfs: add a CB_NOTIFY_LOCK test
Date: Tue, 23 Sep 2025 17:59:49 -0400
Message-ID: <20250923215953.165858-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a test to try to get the server to send a CB_NOTIFY_LOCK for an
expired client.  I had initially written the test back in 2018 as a
reproducer for https://bugzilla.redhat.com/show_bug.cgi?id=1504058
and recently found out the test is still run by some of our QE folks.

Since knfsd now supports courtesy clients, that may interfere with tests
that sleep and expect clients to expire.  I've added an option to the
serverhelper scripts to forcibly expire a client, which may come in
handy for other tests as well.

Scott Mayhew (4):
  nfs4.1: make serverhelper() deal with "bytes" objects
  pynfs: add an option to forcibly expire clients to the serverhelper
    scripts
  rudimentary CB_NOTIFY_LOCK support
  4.1 server tests: add test for CB_NOTIFY_LOCK with an expired client

 examples/localhost_helper.sh        |  12 +++
 examples/server_helper.sh           |  15 ++++
 nfs4.1/nfs4client.py                |   6 ++
 nfs4.1/server41tests/__init__.py    |   1 +
 nfs4.1/server41tests/environment.py |   8 +-
 nfs4.1/server41tests/st_callback.py | 127 ++++++++++++++++++++++++++++
 nfs4.1/server41tests/st_reboot.py   |   2 +-
 7 files changed, 166 insertions(+), 5 deletions(-)
 create mode 100644 nfs4.1/server41tests/st_callback.py

-- 
2.51.0


