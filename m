Return-Path: <linux-nfs+bounces-8583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9739F3ACC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A8F188A308
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2428013D29A;
	Mon, 16 Dec 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+Q916uK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BKxTf4zv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+Q916uK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BKxTf4zv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E71D222B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380826; cv=none; b=gjMLS6xmYr4G9McspHAmuagCZIGERmGwMz0gy3oQrfoReZD+wllfL1b3R0D9meowUhZiPPhk6u9VBezB5fPlVg33xuHmgHGSBF+dVpB/pNCh6Guq0vVqeutMRXU52k8tdPPlH4vfL3eKte/AIQNVQ3KfwbnzD+dFI0kGeFTtWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380826; c=relaxed/simple;
	bh=wba3CXo4CZOjc8RnTFUlImUR6VFEhddm9QLf7Y+unTA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nNgSGfmqbcvDrKOqVuiXgE3jzSY3Q+7WaeeeASn7dHdnJ2JGPuYVMdP4HZ5UNMRBHRxr6eZ5WejDGNX0Rj5CGjCebarrc6dscQyO1mnVWWrFojm3ZyXJHnOp39MvdTu8tgtoUDl0VDJ7h8k3AqE4tRdbngWJdS99TurAPNL1mR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+Q916uK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BKxTf4zv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+Q916uK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BKxTf4zv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB5C11F37E;
	Mon, 16 Dec 2024 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734380821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sZkiaJq7Uda+CtgrGzlKCQgA6idz50G6sd2iF63F3CY=;
	b=j+Q916uK7LBI3dtj3AFPK4IaYdSgKoFFgkI/L9SUhT4cSDGkew3d/BR7HhWiwwQdfkgXIJ
	Jb+0Ra3cwfJF2TLheomO/e41nyCE3yGU754C5vdu2H2+qwdLdnZqjlIQB0kCobDO/S+i14
	sak7SmpYpK8wSAyWaMdFE7IyfJhZ4vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734380821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sZkiaJq7Uda+CtgrGzlKCQgA6idz50G6sd2iF63F3CY=;
	b=BKxTf4zvQPnbRzbV0EPjSvI7Yu5qCNpMMoK4T1ZZ9lVn6VU3qCMyYnqHnZz2sHbYl0K10v
	gOyBvDh/h+d3mQCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734380821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sZkiaJq7Uda+CtgrGzlKCQgA6idz50G6sd2iF63F3CY=;
	b=j+Q916uK7LBI3dtj3AFPK4IaYdSgKoFFgkI/L9SUhT4cSDGkew3d/BR7HhWiwwQdfkgXIJ
	Jb+0Ra3cwfJF2TLheomO/e41nyCE3yGU754C5vdu2H2+qwdLdnZqjlIQB0kCobDO/S+i14
	sak7SmpYpK8wSAyWaMdFE7IyfJhZ4vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734380821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sZkiaJq7Uda+CtgrGzlKCQgA6idz50G6sd2iF63F3CY=;
	b=BKxTf4zvQPnbRzbV0EPjSvI7Yu5qCNpMMoK4T1ZZ9lVn6VU3qCMyYnqHnZz2sHbYl0K10v
	gOyBvDh/h+d3mQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 565A1137CF;
	Mon, 16 Dec 2024 20:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bGMsCBWNYGf6XwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 20:27:01 +0000
Date: Mon, 16 Dec 2024 21:26:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Abstract address for rpcbind in kernel not working
Message-ID: <20241216202654.GA619856@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Neil, Steve,

some time ago I reported a problem with nfslock01.sh test on NFSv3 [1].

Neil send various fixes to support abstract address for rpcbind in kernel:

* kernel [2] released in v6.5-rc1 as:
4388ce05fa38 ("SUNRPC: support abstract unix socket addresses")
626590ea4c93 ("SUNRPC: attempt to reach rpcbind with an abstract socket name")

* libtirpc [3] released in 1.3.5
d4d6c80 ("Allow working with abstract AF_UNIX addresses.")
33c687b ("Change local_rpcb() to take a targaddr pointer.")
d68523a ("Try using a new abstract address when connecting to rpcbind")

* rpcbind [4] released in 1.2.7
4e1f1b2 ("rpcinfo: try connecting using abstract address.")
652aa9a ("Listen on an AF_UNIX abstract address if supported.")

NOTE: these 2 patches were never merged
[PATCH 1/4] anpage: describe use of extra port for broadcast rpc [5]
[PATCH 2/4] rpcbind: allow broadcast RPC to be disabled. [6]

But when testing nfslock01.sh with:

$ rpm -q -e libtirpc3 -e rpcbind
libtirpc3-1.3.6-1.1.x86_64
rpcbind-1.2.7-1.1.x86_64

$ uname -a
Linux ts 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64 x86_64 x86_64 GNU/Linux

it's still not working. Any hint what's wrong?

Kind regards,
Petr

dmesg:
[501926.369717] [  T28210] lockd: cannot monitor 10.0.0.2
[501926.372490] [  T28211] lockd: cannot monitor 10.0.0.2

$ cat /usr/lib/systemd/system/rpcbind.socket
[Unit]
Description=RPCbind Server Activation Socket
DefaultDependencies=no
Wants=rpcbind.target
Before=rpcbind.target

[Socket]
ListenStream=/run/rpcbind.sock
ListenStream=@/run/rpcbind.sock

# RPC netconfig can't handle ipv6/ipv4 dual sockets
BindIPv6Only=ipv6-only
ListenStream=0.0.0.0:111
ListenDatagram=0.0.0.0:111
ListenStream=[::]:111
ListenDatagram=[::]:111

[Install]
WantedBy=sockets.target

# PATH="/opt/ltp/testcases/bin:$PATH" nfslock01.sh -v 3 -t tcp
nfslock01 1 TINFO: Running: nfslock01.sh -v 3 -t tcp
nfslock01 1 TINFO: Tested kernel: Linux ts 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64 x86_64 x86_64 GNU/Linux
nfslock01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfslock01 1 TINFO: add local addr 10.0.0.2/24
nfslock01 1 TINFO: add local addr fd00:1:1:1::2/64
nfslock01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfslock01 1 TINFO: add remote addr 10.0.0.1/24
nfslock01 1 TINFO: add remote addr fd00:1:1:1::1/64
nfslock01 1 TINFO: Network config (local -- remote):
nfslock01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfslock01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfslock01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
nfslock01 1 TINFO: Using /tmp/LTP_nfslock01.cXBE0JezwN as tmpdir (tmpfs filesystem)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:169: TINFO: Skipping ext2 as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping ext3 as requested by the test
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
tst_supported_fs_types.c:169: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping ntfs as requested by the test
tst_supported_fs_types.c:169: TINFO: Skipping tmpfs as requested by the test
nfslock01 1 TINFO: === Testing on ext4 ===
nfslock01 1 TINFO: Formatting ext4 with opts='/dev/loop0'
nfslock01 1 TINFO: Mounting device: mount -t ext4 /dev/loop0 /tmp/LTP_nfslock01.cXBE0JezwN/mntpoint 
nfslock01 1 TINFO: timeout per run is 0h 5m 0s
nfslock01 1 TINFO: mount.nfs: (linux nfs-utils 2.6.4)
nfslock01 1 TINFO: setup NFSv3, socket type tcp
nfslock01 1 TINFO: Mounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.cXBE0JezwN/mntpoint/3/tcp /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 1 TINFO: creating test files (chars: 64, lines: 16384)
nfslock01 1 TINFO: Testing locking
nfslock01 1 TINFO: locking 'flock_idata' file and writing data
nfslock01 1 failed in writeb_lock, errno = 37
TINFO: waiting for pids: 27919 27920
failed in writeb_lock, errno = 37
nfslock01 1 TFAIL: nfs_lock process failed
nfslock01 2 TINFO: Cleaning up testcase
nfslock01 2 TINFO: Unmounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 2 TINFO: === Testing on xfs ===
nfslock01 2 TINFO: Formatting xfs with opts='/dev/loop0'
nfslock01 2 TINFO: Mounting device: mount -t xfs /dev/loop0 /tmp/LTP_nfslock01.cXBE0JezwN/mntpoint 
nfslock01 2 TINFO: timeout per run is 0h 5m 0s
nfslock01 2 TINFO: mount.nfs: (linux nfs-utils 2.6.4)
nfslock01 2 TINFO: setup NFSv3, socket type tcp
nfslock01 2 TINFO: Mounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 2 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.cXBE0JezwN/mntpoint/3/tcp /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 2 TINFO: creating test files (chars: 64, lines: 16384)
nfslock01 2 TINFO: Testing locking
nfslock01 2 TINFO: locking 'flock_idata' file and writing data
nfslock01 2 failed in writeb_lock, errno = 37
TINFO: waiting for pids: 28005 28006
nfslock01 2 TFAIL: failed in writeb_lock, errno = 37
nfs_lock process failed
nfslock01 3 TINFO: Cleaning up testcase
nfslock01 3 TINFO: Unmounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 3 TINFO: === Testing on btrfs ===
nfslock01 3 TINFO: Formatting btrfs with opts='/dev/loop0'
nfslock01 3 TINFO: Mounting device: mount -t btrfs /dev/loop0 /tmp/LTP_nfslock01.cXBE0JezwN/mntpoint 
nfslock01 3 TINFO: timeout per run is 0h 5m 0s
nfslock01 3 TINFO: mount.nfs: (linux nfs-utils 2.6.4)
nfslock01 3 TINFO: setup NFSv3, socket type tcp
nfslock01 3 TINFO: Mounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 3 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.cXBE0JezwN/mntpoint/3/tcp /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 3 TINFO: creating test files (chars: 64, lines: 16384)
nfslock01 3 TINFO: Testing locking
nfslock01 3 TINFO: locking 'flock_idata' file and writing data
nfslock01 3 TINFO: waiting for pids: 28103 28104
failed in writeb_lock, errno = 37
failed in writeb_lock, errno = 37
nfslock01 3 TFAIL: nfs_lock process failed
nfslock01 4 TINFO: Cleaning up testcase
nfslock01 4 TINFO: Unmounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 4 TINFO: === Testing on bcachefs ===
nfslock01 4 TINFO: Formatting bcachefs with opts='/dev/loop0'
nfslock01 4 TINFO: Mounting device: mount -t bcachefs /dev/loop0 /tmp/LTP_nfslock01.cXBE0JezwN/mntpoint 
nfslock01 4 TINFO: timeout per run is 0h 5m 0s
nfslock01 4 TINFO: mount.nfs: (linux nfs-utils 2.6.4)
nfslock01 4 TINFO: setup NFSv3, socket type tcp
nfslock01 4 TINFO: Mounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 4 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.cXBE0JezwN/mntpoint/3/tcp /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 4 TINFO: creating test files (chars: 64, lines: 16384)
nfslock01 4 TINFO: Testing locking
nfslock01 4 TINFO: locking 'flock_idata' file and writing data
nfslock01 4 TINFO: failed in writeb_lock, errno = 37
failed in writeb_lock, errno = 37
waiting for pids: 28210 28211
nfslock01 4 TFAIL: nfs_lock process failed
nfslock01 5 TINFO: Cleaning up testcase
nfslock01 5 TINFO: Unmounting /tmp/LTP_nfslock01.cXBE0JezwN/3/0
nfslock01 5 TINFO: AppArmor enabled, this may affect test results
nfslock01 5 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
nfslock01 5 TINFO: loaded AppArmor profiles: none

Summary:
passed   0
failed   4
broken   0
skipped  0
warnings 0

[1] https://lore.kernel.org/linux-nfs/20230502075921.3614794-1-pvorel@suse.cz/
[2] https://lore.kernel.org/linux-nfs/168375610447.26246.3237443941479930060.stgit@noble.brown/
[3] https://lore.kernel.org/linux-nfs/20240311014327.19692-1-neilb@suse.de/
[4] https://lore.kernel.org/linux-nfs/20240225235628.12473-1-neilb@suse.de/
[5] https://lore.kernel.org/linux-nfs/20240225235628.12473-2-neilb@suse.de/
[6] https://lore.kernel.org/linux-nfs/20240225235628.12473-3-neilb@suse.de/

