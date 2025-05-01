Return-Path: <linux-nfs+bounces-11384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB063AA62C6
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9309D4C286B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87408221DA1;
	Thu,  1 May 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTfQHc+I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA444C7C
	for <linux-nfs@vger.kernel.org>; Thu,  1 May 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124130; cv=none; b=EaLda9Ac262M3mQ5WzDj3jJhnxBzgRViqgIZKZfo2pQDkwxtx307/uS6dJhg1zCkkAvlRZFqYt8quGe1AiVuvJc1/9oxOsVPW6pMopCKqwJDKuADxzjotloSlu9GKBko0Ma9zkCyT7uv9SRzfJxPrKi23XlIyt6XvumRflCNfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124130; c=relaxed/simple;
	bh=tbn/x2WnwUoh8pQowqfbasbBCQboy1WLf2aNoMpOhHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IU7C2rgOdEMK3ecJ9tt74aNWwjhYNYZzzHgM5JKYX2/NBZVhyfhyKg1jgsqemUi4sKSirE8Vfp+vUiEDUuiR8BuFjxFrmGozOfDAfbFRsSHRKLF8drS/h/b/rL5qGok2PuNUY1jMyjBy5DKIsjO5gsRYOetcjk9vXjsoxG/SKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTfQHc+I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746124124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pALNcOjfogUs7lEdft4LU5MtgjIdhAt5z4OBDoHZzKM=;
	b=HTfQHc+IH1WvArT34vkYKB5TNThDEA8YQzHDn9KRaLsrvWypqSgqwz6QzuoIklpMspZNtq
	efbVu5maNO1VfMeM3ipwYbwx1SD8DBurHXLpXfRS11JcmemnqM69V2NmxKNXhPCNOC5INZ
	lwIsl2cVOuHhG0EKeP69r4RTM/EGh0U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-rDE45VF-PgKFOVpONQRIhg-1; Thu,
 01 May 2025 14:28:43 -0400
X-MC-Unique: rDE45VF-PgKFOVpONQRIhg-1
X-Mimecast-MFC-AGG-ID: rDE45VF-PgKFOVpONQRIhg_1746124122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BB781800982;
	Thu,  1 May 2025 18:28:42 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.153])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EEAC1955BCB;
	Thu,  1 May 2025 18:28:41 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 7BA053453F4;
	Thu, 01 May 2025 14:19:28 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsdctl: fix lockd config during autostart
Date: Thu,  1 May 2025 14:19:28 -0400
Message-ID: <20250501181928.125198-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Be sure to actually send the lockd config values over the netlink
interface.

While we're at it, get rid of the unused "ret" variable.

Fixes: f61c2ff8 ("nfsdctl: add necessary bits to configure lockd")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 733756a9..ae435932 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1417,7 +1417,6 @@ static int lockd_configure(struct nl_sock *sock, int grace)
 {
 	char *tcp_svc, *udp_svc;
 	int tcpport = 0, udpport = 0;
-	int ret;
 
 	tcp_svc = conf_get_str("lockd", "port");
 	if (tcp_svc) {
@@ -1432,6 +1431,8 @@ static int lockd_configure(struct nl_sock *sock, int grace)
 		if (udpport < 0)
 			return 1;
 	}
+
+	return lockd_config_doit(sock, LOCKD_CMD_SERVER_SET, grace, tcpport, udpport);
 }
 
 static int
-- 
2.48.1


