Return-Path: <linux-nfs+bounces-11875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF2AC297E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2654A2EED
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31C298C1C;
	Fri, 23 May 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DL+BWkyH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474F296FCE;
	Fri, 23 May 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024507; cv=none; b=m7VjBDR0YdU0ZmCOLhNZzAGxbrBpYOZWW89KdC+/rdlSUVdprhhXBQOixwuim1YjbtKjdZw1ZJxaFttQW8TDTbOquHrwZHKkqPFAKoa8Le/FXuJUitzvNnLEW04oZ0mDIT5cvNOA06aHF5NPZNNawe66FvdzXVF7wEgpHD6xh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024507; c=relaxed/simple;
	bh=Zb/t1XmyUsNgz59d1x+D62leU7tYzGQ1gxjim1sPgmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Plx3bh2cKzdpBm37e6MidazfiNbrMx8QUkmTKjE1ieUzc0d8oz3OD97raNgQdnzl/0/A6SDYok6ook3+MN0pB7m2RS6Olb7qGeQJ/cY/cVH0G1e9EJasvTLRO+0DVJmtEbnk3u1kDl8+DzDtqqozgj+A4LpJbODC4EG8psGFbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DL+BWkyH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024504; x=1779560504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RXRRDXfYtw//d00o91r1AOezWUhlE4T+rBTg72iuK0Q=;
  b=DL+BWkyHNnhmZrl/QnYRCldJUo7k1LSxx/826+eGjW0KFvRq7X+r4fdw
   yRBfllEnhaJ7+sQYsLNL1o0K/kFvlT4cUeJNSKI17MiTlSuEldJ2ooEeg
   2Q80W1z5BofKYcCfsjosSyQ9VWbVzRYg5W2Xlt/X/oKoibOm/55KDnuQz
   R+GL6FP6+inHCtsUH28XZfQIF9HISWj+z4Kdtd3ACCLf9GXb/BHg/E3ou
   jHbbnJxVWwr/7rBfGoib+VzcPMWfeep6/1BWK76J0sHaiQvW9s4G1rUT6
   4r9I4cTWyTqY9TrTgP1rJoBik2pMSGlW+/gWp7eh+L8899Wuhe+aDt8Cu
   A==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="204004099"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:21:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:16865]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.109:2525] with esmtp (Farcaster)
 id 0de42267-1e9c-4376-add3-2511ce0a08b2; Fri, 23 May 2025 18:21:42 +0000 (UTC)
X-Farcaster-Flow-ID: 0de42267-1e9c-4376-add3-2511ce0a08b2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:21:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:21:37 +0000
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
	<linux-nvme@lists.infradead.org>
Subject: [PATCH v2 net-next 0/7] socket: Make sock_create_kern() robust against misuse.
Date: Fri, 23 May 2025 11:21:06 -0700
Message-ID: <20250523182128.59346-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are a bunch of weird usages of sock_create() and friends due
to poor documentation.

  1) some subsystems use __sock_create(), but all of them can be
     replaced with sock_create_kern()

  2) some subsystems use sock_create(), but most of the sockets are
     not tied to userspace processes nor exposed via file descriptors
     but are (most likely unintentionally) exposed to some BPF hooks
     (infiniband, ISDN, iscsi, Xen PV call, ocfs2, smbd)

  3) some subsystems use sock_create_kern() and convert the sockets
     to hold netns refcnt (cifs, mptcp, nvme, rds, smc, and sunrpc)

The primary goal is to sort out such confusion and provide enough
documentation for future developers to choose an appropriate API.

Before commit 26abe14379f8 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets."), sock_create_kern() held the
netns refcnt, and each caller dropped it if unnecessary:

  sock_create_kern(&init_net, ..., &sock);
  sk_change_net(sock->sk, net);

But that implicit API change ended up causing a lot of use-after-free
and finally introduced another helper:

  sock_create_kern(net, ..., &sock);
  sk_net_refcnt_upgrade(sock->sk);

Patch 2 renames sock_create_kern() to __sock_create_kern() to mark it
as a special-purpose API, and Patch 3 restores the original
sock_create_kern() that holds the netns refcnt.

Now, we can simply use sock_create_kern() or __sock_create_kern()
depending on the use case (except for rds).


Changes
  v2:
    patch 3: s/ret/err/ in sock_create_kern() for clarity
    patch 4: newly added
    patch 5: drop unnecessary change for sunrpc and updated changelog

  v1: https://lore.kernel.org/netdev/20250517035120.55560-1-kuniyu@amazon.com/


Kuniyuki Iwashima (7):
  socket: Un-export __sock_create().
  socket: Rename sock_create_kern() to __sock_create_kern().
  socket: Restore sock_create_kern().
  smb: client: Add missing net_passive_dec().
  socket: Remove kernel socket conversion except for net/rds/.
  socket: Replace most sock_create() calls with sock_create_kern().
  socket: Clean up kdoc for sock_create() and sock_create_lite().

 drivers/block/drbd/drbd_receiver.c            |  12 +-
 drivers/infiniband/hw/erdma/erdma_cm.c        |   6 +-
 drivers/infiniband/sw/rxe/rxe_qp.c            |   2 +-
 drivers/infiniband/sw/siw/siw_cm.c            |   6 +-
 drivers/isdn/mISDN/l1oip_core.c               |   3 +-
 drivers/nvme/host/tcp.c                       |   5 +-
 drivers/nvme/target/tcp.c                     |   5 +-
 drivers/soc/qcom/qmi_interface.c              |   4 +-
 drivers/target/iscsi/iscsi_target_login.c     |   7 +-
 drivers/xen/pvcalls-back.c                    |   6 +-
 fs/afs/rxrpc.c                                |   2 +-
 fs/dlm/lowcomms.c                             |   8 +-
 fs/ocfs2/cluster/tcp.c                        |   8 +-
 fs/smb/client/connect.c                       |  11 +-
 fs/smb/server/transport_tcp.c                 |   7 +-
 include/linux/net.h                           |   7 +-
 net/9p/trans_fd.c                             |   9 +-
 net/bluetooth/rfcomm/core.c                   |   3 +-
 net/ceph/messenger.c                          |   6 +-
 net/handshake/handshake-test.c                |  32 ++--
 net/ipv4/af_inet.c                            |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |   2 +-
 net/l2tp/l2tp_core.c                          |   8 +-
 net/mctp/test/route-test.c                    |   6 +-
 net/mptcp/pm_kernel.c                         |   4 +-
 net/mptcp/subflow.c                           |   7 +-
 net/netfilter/ipvs/ip_vs_sync.c               |   8 +-
 net/qrtr/ns.c                                 |   6 +-
 net/rds/tcp_connect.c                         |   8 +-
 net/rds/tcp_listen.c                          |   4 +-
 net/rxrpc/rxperf.c                            |   4 +-
 net/sctp/socket.c                             |   2 +-
 net/smc/af_smc.c                              |  18 +--
 net/smc/smc_inet.c                            |   2 +-
 net/socket.c                                  | 138 ++++++++++++------
 net/sunrpc/clnt.c                             |   4 +-
 net/sunrpc/svcsock.c                          |   6 +-
 net/sunrpc/xprtsock.c                         |  12 +-
 net/tipc/topsrv.c                             |   4 +-
 net/wireless/nl80211.c                        |   4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   4 +-
 42 files changed, 219 insertions(+), 185 deletions(-)

-- 
2.49.0


