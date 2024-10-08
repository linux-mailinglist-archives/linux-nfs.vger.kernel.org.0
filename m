Return-Path: <linux-nfs+bounces-6926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1199502B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062D11C211A2
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348D197A65;
	Tue,  8 Oct 2024 13:32:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out28-63.mail.aliyun.com (out28-63.mail.aliyun.com [115.124.28.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335E1E498
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394379; cv=none; b=HJnkJkBSk6feE3a0+t9LHRQOywX7OaVpsiQBQJDXBsjd4ynzbtviiKTAMLwDgoAw9C5hgsd1A1cwpADvLjTyRzdXLrrU/XxSs0NKi2nuBB7qaMG3HEJngHSJ66hC7lxbLuZ1+jbf7joglmCP6kQCHggG2ej1sZOoZ4xEU5308Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394379; c=relaxed/simple;
	bh=jNjlBw3RyJ1RoND1N/YhAXIskyh/dFM7knA5TCtCPmQ=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=UrNT3dqCWoZLK0nvyTFZwzld8dRnzxtfctN9e4t9CD3PMv646zUmYADBVUIexXe0VkBeTuST9U1oPD/yzWEzxf0hVKeo+IfegtgIQXY5IDCxZPrNpH3Ol1UaD+dOi94p/dKw0wE55xz2UM1Gccggs0buYs5F7vxBwQIx24mlaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ZbbR02F_1728394048)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 21:27:29 +0800
Date: Tue, 08 Oct 2024 21:27:30 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-nfs@vger.kernel.org
Subject: nfs client deadloop on 6.6.53
Message-Id: <20241008212729.0F9A.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

nfs client deadloop on 6.6.53.

[ 9409.381322] sysrq: Show Blocked State
[ 9409.386146] task:bash            state:D stack:0     pid:2323  ppid:2226   flags:0x00004002
[ 9409.395225] Call Trace:
[ 9409.398376]  <TASK>
[ 9409.401172]  __schedule+0x232/0x5d0
[ 9409.405370]  schedule+0x5e/0xd0
[ 9409.409217]  schedule_timeout+0x8c/0x170
[ 9409.413837]  ? __pfx_process_timeout+0x10/0x10
[ 9409.418989]  msleep+0x3b/0x50
[ 9409.422656]  ff_layout_pg_init_read+0x1c1/0x290 [nfs_layout_flexfiles]
[ 9409.429910]  __nfs_pageio_add_request+0x29b/0x480 [nfs]
[ 9409.435911]  nfs_pageio_add_request+0x221/0x2a0 [nfs]
[ 9409.441715]  nfs_read_add_folio+0x1a3/0x280 [nfs]
[ 9409.447175]  nfs_readahead+0x235/0x2d0 [nfs]
[ 9409.452193]  read_pages+0x56/0x2c0
[ 9409.456298]  page_cache_ra_unbounded+0x134/0x1a0
[ 9409.461626]  filemap_get_pages+0xf5/0x3a0
[ 9409.466355]  ? __nfs_lookup_revalidate+0x53/0x140 [nfs]
[ 9409.472325]  filemap_read+0xdc/0x350
[ 9409.476614]  ? find_idlest_group+0x113/0x530
[ 9409.481614]  nfs_file_read+0x74/0xc0 [nfs]
[ 9409.486461]  __kernel_read+0xff/0x2b0
[ 9409.490838]  search_binary_handler+0x70/0x250
[ 9409.495908]  exec_binprm+0x50/0x1a0
[ 9409.500102]  bprm_execve.part.0+0x17d/0x230
[ 9409.504993]  do_execveat_common.isra.0+0x1a2/0x240
[ 9409.510489]  __x64_sys_execve+0x37/0x50
[ 9409.515026]  do_syscall_64+0x5a/0x90
[ 9409.519298]  ? __count_memcg_events+0x4c/0xa0
[ 9409.524348]  ? mm_account_fault+0x6c/0x100
[ 9409.529129]  ? handle_mm_fault+0x154/0x280
[ 9409.533903]  ? do_user_addr_fault+0x35f/0x680
[ 9409.538935]  ? exc_page_fault+0x69/0x150
[ 9409.543537]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[ 9409.549277] RIP: 0033:0x7f57378d987b
[ 9409.553572] RSP: 002b:00007ffdb5978708 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[ 9409.561847] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f57378d987b
[ 9409.569690] RDX: 000055d26e403600 RSI: 000055d26e5cdc50 RDI: 000055d26e6ce7f0
[ 9409.577534] RBP: 000055d26e6ce7f0 R08: 000055d26e5a5b60 R09: 0000000000000000
[ 9409.585375] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000ffffffff
[ 9409.593208] R13: 000055d26e5cdc50 R14: 000055d26e403600 R15: 000055d26e6ceb40
[ 9409.601047]  </TASK>
[ 9409.603946] task:bash            state:D stack:0     pid:2550  ppid:2462   flags:0x00004002
[ 9409.613027] Call Trace:
[ 9409.616185]  <TASK>
[ 9409.618983]  __schedule+0x232/0x5d0
[ 9409.623186]  schedule+0x5e/0xd0
[ 9409.627033]  io_schedule+0x46/0x70
[ 9409.631140]  folio_wait_bit_common+0x133/0x390
[ 9409.636294]  ? folio_wait_bit_common+0x100/0x390
[ 9409.641624]  ? nfs4_do_open+0xcd/0x210 [nfsv4]
[ 9409.646854]  ? __pfx_wake_page_function+0x10/0x10
[ 9409.652268]  filemap_update_page+0x2bc/0x300
[ 9409.657242]  filemap_get_pages+0x21d/0x3a0
[ 9409.662042]  ? __nfs_lookup_revalidate+0x53/0x140 [nfs]
[ 9409.668010]  filemap_read+0xdc/0x350
[ 9409.672299]  nfs_file_read+0x74/0xc0 [nfs]
[ 9409.677126]  __kernel_read+0xff/0x2b0
[ 9409.681476]  search_binary_handler+0x70/0x250
[ 9409.686526]  exec_binprm+0x50/0x1a0
[ 9409.690702]  bprm_execve.part.0+0x17d/0x230
[ 9409.695573]  do_execveat_common.isra.0+0x1a2/0x240
[ 9409.701047]  __x64_sys_execve+0x37/0x50
[ 9409.705559]  do_syscall_64+0x5a/0x90
[ 9409.709805]  ? do_user_addr_fault+0x35f/0x680
[ 9409.714834]  ? exc_page_fault+0x69/0x150
[ 9409.719414]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[ 9409.725126] RIP: 0033:0x7f3c492d987b
[ 9409.729362] RSP: 002b:00007ffc6413a458 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[ 9409.737609] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3c492d987b
[ 9409.745429] RDX: 000055c6a8f07600 RSI: 000055c6a90e72a0 RDI: 000055c6a90f7890
[ 9409.753256] RBP: 000055c6a90f7890 R08: 000055c6a90f6250 R09: 0000000000000000
[ 9409.761078] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000ffffffff
[ 9409.768904] R13: 000055c6a90e72a0 R14: 000055c6a8f07600 R15: 000055c6a90e1ea0
[ 9409.776732]  </TASK>

Notice:
1, nfs server:  kernel 6.6.54
pnfs optin in the service side /etc/exports.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/10/08



