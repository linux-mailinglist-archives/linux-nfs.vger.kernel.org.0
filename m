Return-Path: <linux-nfs+bounces-9265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78AA12F25
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 00:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1771886CA8
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6A1DCB2D;
	Wed, 15 Jan 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYGigPdE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29611D89F1
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983455; cv=none; b=UOsnXsLI6so734edPD2Yq5l8DGznoWjN0eFTPM0GZlt9IZSOXYCTEhXdsWgE5ZqgMirWSI2vAp9Z6SY0rqG/+N+yqoyfzKi5cdq75t/u5CGrWb6On2YVyBCFr4Cn4DjXLuoCpJR76B9MMWuihdOflc+UfGe3zII+2q5ycJwSnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983455; c=relaxed/simple;
	bh=paxS0srLq4U30Pc9LLxf5Im5wQBC5X0FGePpsMgPKjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOwkXHnRO32KfW8YIUcTQO+jHWMphxCEg1dwo0udOb9OlVZWXPh2fWO6R57biPpiAI5foEYgHoaIuo0OlQwy3g/U1v7Jb2WUj73HSlvF6Cepkn6+JEPKWyUwC3hBcQv32cmQm+DjcbNf/Bkjr4fgSgeA5JAQIXYIOzjBj2cPYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYGigPdE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736983452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jc/f26k7/LLTlZOHbfhfVJ6L37BQA/9YWk0Ct41T9m0=;
	b=cYGigPdEUdZMGMDDxMi8uKXePrTNznl08cwVjsAXlgLT/4DgWy+W4o6thHqst4fPScMf5/
	dMHu2DE7i6L6mJQYjSMshzlGSj2qXtYr/GeIg5ZSlcpaGGB5J7/iGufhsBbUU0W4TXBKfC
	J5j9IpZreAfstTNvcoWcwqvQwoB4Q9c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-HGNGUvLuN82Grvi0a3zEWg-1; Wed,
 15 Jan 2025 18:24:11 -0500
X-MC-Unique: HGNGUvLuN82Grvi0a3zEWg-1
X-Mimecast-MFC-AGG-ID: HGNGUvLuN82Grvi0a3zEWg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A4071955D82;
	Wed, 15 Jan 2025 23:24:10 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1248530001BE;
	Wed, 15 Jan 2025 23:24:08 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 0/3] fix removal of nfsd listeners
Date: Wed, 15 Jan 2025 18:24:03 -0500
Message-Id: <20250115232406.44815-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently if a root user using nfsdctl command tries to remove a particular
listener from the list of previously added ones, then starting the nfsd
leads to the following problem:

[  158.835354] refcount_t: addition on 0; use-after-free.
[  158.835603] WARNING: CPU: 2 PID: 9145 at lib/refcount.c:25 refcount_warn_saturate+0x160/0x1a0
[  158.836017] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace overlay isofs uinput snd_seq_dummy snd_hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_generic mc e1000e snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop dm_multipath dm_mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs libcrc32c crct10dif_ce ghash_ce vmwgfx sha2_ce sha256_arm64 sr_mod sha1_ce cdrom nvme drm_client_lib drm_ttm_helper ttm nvme_core drm_kms_helper nvme_auth drm fuse
[  158.840093] CPU: 2 UID: 0 PID: 9145 Comm: nfsd Kdump: loaded Tainted: G    B   W          6.13.0-rc6+ #7
[  158.840624] Tainted: [B]=BAD_PAGE, [W]=WARN
[  158.840802] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
[  158.841220] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  158.841563] pc : refcount_warn_saturate+0x160/0x1a0
[  158.841780] lr : refcount_warn_saturate+0x160/0x1a0
[  158.842000] sp : ffff800089be7d80
[  158.842147] x29: ffff800089be7d80 x28: ffff00008e68c148 x27: ffff00008e68c148
[  158.842492] x26: ffff0002e3b5c000 x25: ffff600011cd1829 x24: ffff00008653c010
[  158.842832] x23: ffff00008653c000 x22: 1fffe00011cd1829 x21: ffff00008653c028
[  158.843175] x20: 0000000000000002 x19: ffff00008653c010 x18: 0000000000000000
[  158.843505] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  158.843836] x14: 0000000000000000 x13: 0000000000000001 x12: ffff600050a26493
[  158.844143] x11: 1fffe00050a26492 x10: ffff600050a26492 x9 : dfff800000000000
[  158.844475] x8 : 00009fffaf5d9b6e x7 : ffff000285132493 x6 : 0000000000000001
[  158.844823] x5 : ffff000285132490 x4 : ffff600050a26493 x3 : ffff8000805e72bc
[  158.845174] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000098588000
[  158.845528] Call trace:
[  158.845658]  refcount_warn_saturate+0x160/0x1a0 (P)
[  158.845894]  svc_recv+0x58c/0x680 [sunrpc]
[  158.846183]  nfsd+0x1fc/0x348 [nfsd]
[  158.846390]  kthread+0x274/0x2f8
[  158.846546]  ret_from_fork+0x10/0x20
[  158.846714] ---[ end trace 0000000000000000 ]---

nfsd_nl_listener_set_doit() would manipulate the list of transports of
server's sv_permsocks and svc_xprt_close() the specified listener but
the other list of transports (server's sp_xprts list) would not be
changed leading to the problem.

the other problem is that sp_xprt is a lwq structure of lockless
list which does not have an ability to remove a single entry from
the list.

this patch series addis a function to remove a single entry, then modifies
nfsd_nl_listener_set_doit() to make sure the to-be-removed listener is
removed from both lists and then it also ensures that the remaining
listeners are added back in the correct state.

Olga Kornievskaia (3):
  llist: add ability to remove a particular entry from the list
  SUNRPC: add ability to remove specific server transport
  nfsd: fix management of listener transports

 fs/nfsd/nfsctl.c           |  4 +++-
 include/linux/llist.h      | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc_xprt.c      | 11 +++++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.47.1


