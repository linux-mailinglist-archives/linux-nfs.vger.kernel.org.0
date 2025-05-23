Return-Path: <linux-nfs+bounces-11879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7191AC2990
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4100C1C02FEA
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFE299A80;
	Fri, 23 May 2025 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GMd+ofqT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4204293736;
	Fri, 23 May 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024615; cv=none; b=NZ4evkFD9CfcV58c4nBB1tk9RV0aiHBcAR5Lp9Pg8b+yHbvgaiXhabUldojQZE/UGmmQKCvYYDQPXUz1HlTsW/W9hUDnwqxfOSNM7z3SnIKYxY0i3ceIGqQX05u9SBAjChtD208vQiqW4OphL9/VtMdN+6efEflVr4LcObTmQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024615; c=relaxed/simple;
	bh=kk1IdyuvQHEYLkwFxKS16QH/uS4bDTicb8ITJd/htD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMYXAcyRN5GbFcEKBvvtg8QkDIZv1VoQyTE76G0nUAq+pMsxG7aD00hjYLpJVEGb1kZHrNdpEzPNqisv8WTmzkOypQ9xZuI1cxOILfRKZw20G3wHw7yBHEUzwbeVt7WqnTP4wsqfja/vhNzLbaytaQrU8T99ENoglvEF/9IxaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GMd+ofqT; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024614; x=1779560614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ae8iei/MxNZ1GAywSlI3IUvxi3FmxgZOmA0ImXXwfDo=;
  b=GMd+ofqTXuOFD/Yzak3KREAqLtV86NjcXX7Ru3XFGL/6TwgyBw3mHUrn
   X5dZuYJsFrfHz6/cUyLZAuEDU13bJ5h9j+MIy4N+H1X9jCw09Wyz9WZbc
   +C8WKdkTZrYGcyu95FO5PLMZOts1mIGOrAN+RVBF7HOH2soTzJ0VcKK+O
   6GR9cdRPiZP+W7QvFrFkZcw1tEJyE8RSRn686ohsFbTYUpvglkZ8dmZMf
   x/m5bFx/Rk1qLShA8E2AEFhyAV1GWrUmclMN1lf1RthKakGw2zm4oMrRQ
   CWAB8ZkJN1zRqmkQQQG/CKtrnSilgxlu8Q5gNJS4c8YTyzZ8PjP42tWUi
   g==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="96732876"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:23:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:47636]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.22:2525] with esmtp (Farcaster)
 id f65fbf90-224c-415e-a7b2-3925684c748d; Fri, 23 May 2025 18:23:27 +0000 (UTC)
X-Farcaster-Flow-ID: f65fbf90-224c-415e-a7b2-3925684c748d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	"Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	<netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 net-next 4/7] smb: client: Add missing net_passive_dec().
Date: Fri, 23 May 2025 11:21:10 -0700
Message-ID: <20250523182128.59346-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523182128.59346-1-kuniyu@amazon.com>
References: <20250523182128.59346-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While reverting commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock
after rmmod"), I should have added net_passive_dec(), which was added
between the original commit and the revert by commit 5c70eb5c593d ("net:
better track kernel sockets lifetime").

Let's call net_passive_dec() in generic_ip_connect().

Note that this commit is only needed for 6.14+.

Fixes: 95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock after rmmod"")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/smb/client/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 37a2ba38f10e..afac23a5a3ec 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3359,6 +3359,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 
 		sk = server->ssocket->sk;
 		__netns_tracker_free(net, &sk->ns_tracker, false);
+		net_passive_dec(net);
 		sk->sk_net_refcnt = 1;
 		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
 		sock_inuse_add(net, 1);
-- 
2.49.0


