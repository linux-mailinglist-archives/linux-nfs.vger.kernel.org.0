Return-Path: <linux-nfs+bounces-13319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF65B16761
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE558188E5FC
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 20:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2621CA14;
	Wed, 30 Jul 2025 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPyDloee"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9790204C0F
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906148; cv=none; b=oSDkiZnlutDWwPEmO/GpArC9kDYBY4tOvfLqLIASM4o2Tzw4lY+X4IKH9UEKT/Z5PypdURgQL5tmawj6vPskUrjBBki+Qr1Q23X8Oi3fc/5UYZmisRR4HLWX9S08xNHuFYobiR2dcasKCftu0xs3McTMsvC7sDVHCVk6QUTa4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906148; c=relaxed/simple;
	bh=TBk4rk+oaMiMIUM/BilQHT0wLcsFLD+oXHWdtsLRjhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZMR+qBmMy11KTHfSPbdT1nIEPxkvLW4FS+NU5d0zhqAnzc0tiEVO/cYYHVy8tu/vKvArPfFvBTFSplLzBa4YJ6i/Lu7LhOMODgtvOL1Vl9RXXhdlJc/FFMbyTiQJck+vfvE79ankh5jBOcTWHCevsXCduf1fOP+p5ebglZOZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPyDloee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753906139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lv7yxZjsANwZuExWF5D6Tu2dwm9bHE1TUeSlxyjQERU=;
	b=aPyDloeexVC74Ay9ZiJdRurtg1B0GvAu3Xmc33HcI8aM8l1/3GW53aS4GYmx2xUl8dqH7g
	xCYOE9EBUkVkwqjHCxb5pe8momMPv3G2Q+ORPwcGJXPbn0SdqYiN6pvKx+I9/8B5zUHQY3
	42uTFdoWo1zPxTtvokVEv3vmhyzYZQ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-thRp1xOjMHu1rmh0xqeHkA-1; Wed,
 30 Jul 2025 16:08:45 -0400
X-MC-Unique: thRp1xOjMHu1rmh0xqeHkA-1
X-Mimecast-MFC-AGG-ID: thRp1xOjMHu1rmh0xqeHkA_1753906123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89DF019560A3;
	Wed, 30 Jul 2025 20:08:42 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.90.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D1F119560A2;
	Wed, 30 Jul 2025 20:08:37 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	hare@suse.de,
	horms@kernel.org,
	kbusch@kernel.org
Subject: [PATCH 0/4] address tls_alert_recv usage by NFS and NvME
Date: Wed, 30 Jul 2025 16:08:31 -0400
Message-Id: <20250730200835.80605-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is a multi-component patch series: NFS client, NFS server,
NvME (target), net. 

tls_alert_recv() has been originally written to retrieve TLS alert
payload out of the msg iterator's kvec buffer. Yet, the callers of
tls_alert_recv() have not been careful enough to make sure that
msg has always been initialized with a kvec-backed iterator (ie.,
some times bvec was used). Furthermore, callers didn't account
for the fact that the msg iterator's kvec is advanced by sock_recvmsg
upon filling up the provided space by the copy. All that lead to
the ability to construct a malicious payload that would trigger
badness in tls_alert_recv().

This patch series attempts to address it in a couple of steps.
First, there are patches for each of the current consumers (NFS
server, NFS client, NvME target) of tls_alert_recv to address
an immediate problem which I think should be backported.

Note, patch#3 is NvME patch that had no testing. Compile only patch.

Second, the last patch builds on top of the fixes but changes
tls_alert_recv to force the callers to provide the kvec directly
in hopes that any future users of tls_alert_recv would be more
congnizant of providing location to the actual TLS alert payload.

Again note that nvme changes in patch#4 are compile only.

Olga Kornievskaia (4):
  sunrpc: fix handling of server side tls alerts
  sunrpc: fix client side handling of tls alerts
  nvmet-tcp: fix handling of tls alerts
  net/handshake: change tls_alert_recv to receive a kvec

 drivers/nvme/target/tcp.c | 37 +++++++++++++++-----------
 include/net/handshake.h   |  2 +-
 net/handshake/alert.c     |  6 ++---
 net/sunrpc/svcsock.c      | 56 ++++++++++++++++++++++++++++-----------
 net/sunrpc/xprtsock.c     | 51 ++++++++++++++++++++++++-----------
 5 files changed, 101 insertions(+), 51 deletions(-)

-- 
2.47.1


