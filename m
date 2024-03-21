Return-Path: <linux-nfs+bounces-2431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A895885B2C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 15:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92C6B20CAA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8B784FA0;
	Thu, 21 Mar 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxgwhGo+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707485651
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032687; cv=none; b=tI73Qioi/HucAWinMwq56AwAtQirpykv7td5jv8fkYyKTPRkJxXI9bMkSCRMgD7jBBuGF9T+SMF2LaVRUO3Ht6oJ6A9Wsp997AhX/+mL2wvlcMiohuLw2HuyCbe857+o1yQkAfD2lnzh4uIItny43lIBW9ECdV1WSsNq44pO2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032687; c=relaxed/simple;
	bh=sE6svCUa6H+Vlkf0fUjti5LICUPd44RRToJGWT/QujE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hmi9VL8LAiqxs3WFF8lNZWgjB6sfs6LiTgvCuIrH30YT06pHPhctrTaUTRFhyUaEu3eXKAW77uYClui51VW/kHXcGuzYCNIw7TuShGcqzB9X7t+M+RU0H23MT5J0WXnEjYDa9ugQ9nKJZmDKr10oLm/LC7cr83d+hH7WEB86yi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxgwhGo+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711032684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8/6lv/G8psIdjORamk6a0rITn42DzjGhrlhjnhf7BkU=;
	b=CxgwhGo+7v7H4sVVBoNwt9D2VuWHBkl70MSL6akox7NqteN9LvUyHqIVspHkoIgP4fFkgi
	IiJN1Qesn8sGgt+hTXspK0hBpT8Z7USmwM1JaOftdk0ppVIRFogico0COZO0JvMfO89l05
	sxmtBcluEJry2OakMQqf5//ouuEC5Rc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-HN-Zy8jJP3CGoc5y9Cjm2A-1; Thu, 21 Mar 2024 10:51:21 -0400
X-MC-Unique: HN-Zy8jJP3CGoc5y9Cjm2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C62068007B0;
	Thu, 21 Mar 2024 14:51:20 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.32.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B69BF2022C1D;
	Thu, 21 Mar 2024 14:51:20 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 3D4E612E0FB; Thu, 21 Mar 2024 10:51:16 -0400 (EDT)
Date: Thu, 21 Mar 2024 10:51:16 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com
Cc: npache@redhat.com, linux-nfs@vger.kernel.org
Subject: Problem with the RFC 8009 encryption test
Message-ID: <ZfxJZFwXqqurfet0@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Chuck,

When testing a fix for the problem that Nico reported [1], I found some
oddness with the RFC 8009 encryption test.  Sometimes it would pass,
sometimes it would fail, and other times it would oops.  I bisected it to:

561141dd4943 SUNRPC: Use a static buffer for the checksum initialization vector

If I build a kernel with CONFIG_DEBUG_SG=y, I get the following oops

[   40.417220] ------------[ cut here ]------------
[   40.421884] kernel BUG at include/linux/scatterlist.h:187!
[   40.424490] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   40.427511] CPU: 4 PID: 3688 Comm: kunit_try_catch Kdump: loaded Tainted: G                 N 6.8.0+ #13
[   40.430025] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[   40.432291] RIP: 0010:sg_init_one+0x85/0xa0
[   40.433238] Code: 51 5b 37 01 83 e1 03 f6 c3 03 75 20 a8 01 75 1e 48 09 cb 41 89 54 24 08 49 89 1c 24 41 89 6c 24 0c 5b 5d 41 5c c3 cc cc cc cc <0f> 0b 0f 0b 0f 0b 48 8b 05 3e 26 9f 01 eb b2 66 66 2e 0f 1f 84 00
[   40.437191] RSP: 0018:ffffab2ac2d87cf0 EFLAGS: 00010246
[   40.438129] RAX: 0000000000000000 RBX: ffffffffc0ce8740 RCX: 0000000000000000
[   40.439359] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040ce8740
[   40.440566] RBP: 0000000000000010 R08: 258143ae43c375cb R09: 0000000000000000
[   40.441741] R10: ffffab2ac2d87d20 R11: 7e6f455c48ff50b7 R12: ffffab2ac2d87d20
[   40.442920] R13: ffff90de0a3e1400 R14: 0000000000000020 R15: 0000000000000010
[   40.444142] FS:  0000000000000000(0000) GS:ffff90df77c00000(0000) knlGS:0000000000000000
[   40.445498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.446485] CR2: 00007f64586dc998 CR3: 000000023f220003 CR4: 0000000000770ef0
[   40.447743] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   40.448962] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   40.450196] PKRU: 55555554
[   40.450700] Call Trace:
[   40.451155]  <TASK>
[   40.451544]  ? die+0x36/0x90
[   40.452090]  ? do_trap+0xdd/0x100
[   40.452690]  ? sg_init_one+0x85/0xa0
[   40.453361]  ? do_error_trap+0x6a/0x90
[   40.454029]  ? sg_init_one+0x85/0xa0
[   40.454671]  ? exc_invalid_op+0x50/0x70
[   40.455358]  ? sg_init_one+0x85/0xa0
[   40.456009]  ? asm_exc_invalid_op+0x1a/0x20
[   40.456776]  ? sg_init_one+0x85/0xa0
[   40.457408]  krb5_etm_checksum+0x114/0x1d0 [rpcsec_gss_krb5]
[   40.458372]  rfc8009_encrypt_case+0x397/0x8f0 [gss_krb5_test]
[   40.459360]  ? __schedule+0x3e8/0x1520
[   40.460027]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10 [kunit]
[   40.461180]  ? kunit_try_run_case+0x93/0x190 [kunit]
[   40.462043]  kunit_try_run_case+0x93/0x190 [kunit]
[   40.462881]  kunit_generic_run_threadfn_adapter+0x17/0x30 [kunit]
[   40.463929]  kthread+0xcf/0x100
[   40.464498]  ? __pfx_kthread+0x10/0x10
[   40.465165]  ret_from_fork+0x31/0x50
[   40.465810]  ? __pfx_kthread+0x10/0x10
[   40.466477]  ret_from_fork_asm+0x1a/0x30
[   40.467173]  </TASK>
[   40.467593] Modules linked in: camellia_generic camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64 gss_krb5_test rpcsec_gss_krb5 auth_rpcgss kunit nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill nf_tables sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common isst_if_common kvm_intel kvm iTCO_wdt intel_pmc_bxt iTCO_vendor_support i2c_i801 rapl i2c_smbus lpc_ich virtio_balloon joydev loop fuse nfnetlink zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_blk virtio_net net_failover virtio_console failover serio_raw qemu_fw_cfg
[   40.478684] ---[ end trace 0000000000000000 ]---

Looking through the git history of the auth_gss code, there are various
places where static buffers were replaced by dynamically allocated ones
because they're being used with scatterlists. 

I think this patch should be reverted.

-Scott

[1] https://groups.google.com/g/kunit-dev/c/QDK1PgWJEdQ


