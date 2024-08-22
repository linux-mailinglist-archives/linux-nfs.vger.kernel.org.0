Return-Path: <linux-nfs+bounces-5569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C295B6B1
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229291C22FE7
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28D1C9ED6;
	Thu, 22 Aug 2024 13:31:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00431C9440;
	Thu, 22 Aug 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333497; cv=none; b=hFj3TM0s47roe8TGeo8rIInYoddkXVbCt3nAl9sxaE2Tz6uR5g4BAFqH+WgB96dUVPoUABsHcTFltVoZbFzOnNW3X8dR++d35Z0sXIqbAeQv5206PiFA6yLth7v0XkMDjehbqNIrHY/v6BPw1S9KQ+ojBiYxyLAxNvAerNZmkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333497; c=relaxed/simple;
	bh=M1n2Xn+9A7edIt9B6vqrsNV3A2y+DbZtbQEJYxLKkro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8T2W+DW1udBbTrzFPwPSpejX4X8Ea0J4ClCY50Msdah95Zj+71VI6EZPNXEt3javgZwnFR0t+LXZdyYnKqH/J/XIv340GkgITr3EUR32LZmLSzMHBKdYoaS+yE5hgC//EVo5qQTVkOHYruK1PhC43tc+UVLmJAFvh5IBp3xdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqPGz2WrxzyRDT;
	Thu, 22 Aug 2024 21:31:07 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 31AA91800A4;
	Thu, 22 Aug 2024 21:31:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:29 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
	<luiz.dentz@gmail.com>, <idryomov@gmail.com>, <xiubli@redhat.com>,
	<dsahern@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<jmaloy@redhat.com>, <ying.xue@windriver.com>, <lizetao1@huawei.com>,
	<linux@treblig.org>, <jacob.e.keller@intel.com>, <willemb@google.com>,
	<kuniyu@amazon.com>, <wuyun.abel@bytedance.com>, <quic_abchauha@quicinc.com>,
	<gouhao@uniontech.com>
CC: <netdev@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next 0/8] Some modifications to optimize code readability
Date: Thu, 22 Aug 2024 21:39:00 +0800
Message-ID: <20240822133908.1042240-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

This patchset is mainly optimized for readability in contexts where size
needs to be determined. By using min() or max(), or even directly
removing redundant judgments (such as the 5th patch), the code is more
consistent with the context.

Li Zetao (8):
  atm: use min() to simplify the code
  Bluetooth: use min() to simplify the code
  net: caif: use max() to simplify the code
  libceph: use min() to simplify the code
  net: remove redundant judgments to simplify the code
  ipv6: mcast: use min() to simplify the code
  tipc: use min() to simplify the code
  SUNRPC: use min() to simplify the code

 net/atm/addr.c            | 4 ++--
 net/bluetooth/hidp/core.c | 2 +-
 net/caif/cfpkt_skbuff.c   | 6 ++----
 net/ceph/messenger.c      | 2 +-
 net/core/sock.c           | 2 +-
 net/ipv6/mcast.c          | 5 +++--
 net/sunrpc/xdr.c          | 2 +-
 net/tipc/monitor.c        | 2 +-
 8 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.34.1


