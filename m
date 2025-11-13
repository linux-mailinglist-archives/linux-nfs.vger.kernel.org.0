Return-Path: <linux-nfs+bounces-16336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400AC55C5B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 06:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3AD9345B53
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 05:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2498830103F;
	Thu, 13 Nov 2025 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QVOkEyPM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E86303CAF;
	Thu, 13 Nov 2025 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010806; cv=none; b=feWehCvU8ZV+5cnwyBna/vBPWMr6AZKCPMP/U226VqYgJ/BjMXvsd9KwuvMbXBipW4UnA0k032gS8cSmjnRrAbUGQf7xl04s5DPdElxTQqqaSFG/jxl4vQlLR+7Ac6t4Ecy76M5/mE1/dNObEz+Fb+F4Pqk9sM2Be1xPELEHQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010806; c=relaxed/simple;
	bh=w6VnChjWXLaUIHw0Uj2aPaJuRb2LWVTU3UZD2pZaYao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7vsWodZ3gJOOm83x4BeNYM/eF4nhHjZrTVfJ2fp2Ma1JI7FCVVPtZWs2GXv50SlIzwjGJ3VrlNshFs5PbFFzYo+PwTfUsdaqZDs0z20rlSidOOPnFBLT4Dy0A/9OuwFWwyTsjum40W5z/XWBmGEb7BAEhaHfD1ufQRKGGmkEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QVOkEyPM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eRdN4W5FjgTTUfIcBQJPO5dB8HkX8B/+7CnhV6rjIQ4=; b=QVOkEyPM+/M2NRH/lxyazd21lH
	GeBc4xzbmNsCeXqekcl4cQP8qNO/GBPPJ7QUgBj3GCGdu6CYOibNqqhp72lXD9hr5hTtABg5CEAf7
	SdwhLzGIUWjic0V8iJH97QMqayQigmy9kYlMHMLN/OIboYduUAwqJGmDbmhMeLnl+UoOMNvjW9r+M
	HwBH+9J4cq0palFTV8XGkI2VVRP5AEKMJQgFIaLZ9wS30SJJ9DaTUUFLy8zX+hzIXXAjUu82wOB4R
	mtTHYzuJDv2Y46Ur3yXOXM1KwxyuPxhG0cO6AnAnOI5f/BKsk6tuU5/mnyx6sdEVnCxI4PYN1VnJr
	X4/OKhOw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vJPRk-00AvY4-Kv; Thu, 13 Nov 2025 05:00:36 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 86BF2BE2EE7; Thu, 13 Nov 2025 06:00:35 +0100 (CET)
Date: Thu, 13 Nov 2025 06:00:35 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "Tyler W. Ross" <twr+debbugs@tylerwross.com>, 1120598@bugs.debian.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Scott Mayhew <smayhew@redhat.com>,
	Steve Dickson <steved@redhat.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4
 client using SHA2
Message-ID: <aRVl8yGqTkyaWxPM@eldamar.lan>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
X-Debian-User: carnil

Hi NFS folks,

Tyler W. Ross reported the following issue in Debian (in
https://bugs.debian.org/1120598)

On Wed, Nov 12, 2025 at 04:41:28PM -0500, Tyler W. Ross wrote:
> Package: nfs-common
> Version: 1:2.8.4-1+b1
> Severity: important
> X-Debbugs-Cc: twr+debbugs@tylerwross.com
> 
> 
> When the session key of a kerberos ticket uses a SHA2 cipher (aes256-cts-hmac-sha384-192 and aes128-cts-hmac-sha256-128 tested), readdir requests fail.
> 
> SHA1 ciphers (aes256-cts-hmac-sha1-96 and aes128-cts-hmac-sha1-96 tested) work as expected.
> 
> ls reports the following:
> ls: reading directory '/mnt/example/': Input/output error
> 
> stat and touch of files and directories is working, and cat'ing a file works (see also: later note about cat with NFSv4.1 and 4.0).
> 
> 
> 
> Example of a non-working ticket, as reported by klist -e:
> 11/12/25 18:37:30  11/13/25 17:49:03  nfs/nfssrv.ipa.twrlab.net@IPA.TWRLAB.NET
> 	Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha384-192 
> 
> Example of a working ticket:
> 11/12/25 19:01:46  11/13/25 18:27:33  nfs/nfssrv.ipa.twrlab.net@IPA.TWRLAB.NET
> 	Etype (skey, tkt): aes256-cts-hmac-sha1-96, aes256-cts-hmac-sha384-192 
> 
> If rpcdebug is enabled for nfs and rpc modules, the following is logged to dmesg: 
> [332376.797836] NFS: nfs_weak_revalidate: inode 262146 is valid
> [332376.798512] NFS: revalidating (0:58/262146)
> [332376.799169] --> nfs41_call_sync_prepare data->seq_server 00000000e22b1bd9
> [332376.799916] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=64
> [332376.800764] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
> [332376.801507] RPC:       gss_krb5_get_mic_v2
> [332376.802009] encode_sequence: sessionid=1762048597:1479457708:22:0 seqid=27 slotid=0 max_slotid=0 cache_this=0
> [332376.803204] RPC:       gss_krb5_get_mic_v2
> [332376.803726] RPC:       xs_tcp_send_request(260) = 0
> [332376.804536] RPC:       gss_krb5_verify_mic_v2
> [332376.805093] RPC:       gss_krb5_verify_mic_v2
> [332376.805643] decode_attr_type: type=040000
> [332376.806149] decode_attr_change: change attribute=22
> [332376.806866] decode_attr_size: file size=4096
> [332376.807398] decode_attr_fsid: fsid=(0xfdcb5a40986843e0/0xa4fc6c44ad8345ad)
> [332376.808154] decode_attr_fileid: fileid=262146
> [332376.808742] decode_attr_fs_locations: fs_locations done, error = 0
> [332376.809495] decode_attr_mode: file mode=0777
> [332376.810042] decode_attr_nlink: nlink=3
> [332376.810695] decode_attr_owner: uid=591200000
> [332376.811229] decode_attr_group: gid=591200004
> [332376.811761] decode_attr_rdev: rdev=(0x0:0x0)
> [332376.812291] decode_attr_space_used: space used=4096
> [332376.812878] decode_attr_time_access: atime=1762383044
> [332376.813487] decode_attr_time_create: btime=1761952933
> [332376.814098] decode_attr_time_metadata: ctime=1762055558
> [332376.814895] decode_attr_time_modify: mtime=1762055558
> [332376.815578] decode_attr_mounted_on_fileid: fileid=262146
> [332376.816225] decode_getfattr_attrs: xdr returned 0
> [332376.816796] decode_getfattr_generic: xdr returned 0
> [332376.817374] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=64
> [332376.818135] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
> [332376.818873] nfs4_free_slot: slotid 1 highest_used_slotid 0
> [332376.819604] nfs41_sequence_process: Error 0 free the slot 
> [332376.820228] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
> [332376.820930] NFS: nfs_update_inode(0:58/262146 fh_crc=0xad8c294c ct=2 info=0x4427e7f)
> [332376.821767] NFS: (0:58/262146) revalidation complete
> [332376.822342] NFS: nfs_weak_revalidate: inode 262146 is valid
> [332376.823056] NFS: permission(0:58/262146), mask=0x24, res=0
> [332376.823684] NFS: open dir(/)
> [332376.824087] NFS: readdir(/) starting at cookie 0
> [332376.824641] _nfs4_proc_readdir: dentry = /, cookie = 0
> [332376.825229] --> nfs41_call_sync_prepare data->seq_server 00000000e22b1bd9
> [332376.825967] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=64
> [332376.826814] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
> [332376.827616] RPC:       gss_krb5_get_mic_v2
> [332376.828114] encode_sequence: sessionid=1762048597:1479457708:22:0 seqid=28 slotid=0 max_slotid=0 cache_this=0
> [332376.829146] encode_readdir: cookie = 0, verifier = 00000000:00000000, bitmap = 0018091a:00b4a23a:00000000
> [332376.830144] RPC:       gss_krb5_get_mic_v2
> [332376.830720] RPC:       xs_tcp_send_request(284) = 0
> [332376.831431] RPC:       gss_krb5_verify_mic_v2
> [332376.831967] RPC:       gss_krb5_verify_mic_v2
> [332376.832498] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=64
> [332376.833254] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
> [332376.833994] nfs4_free_slot: slotid 1 highest_used_slotid 0
> [332376.834695] nfs41_sequence_process: Error 0 free the slot 
> [332376.835318] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
> [332376.836016] _nfs4_proc_readdir: returns -5
> [332376.836519] NFS: readdir(/) returns -5
> 
> 
> 
> Environment/Supporting Systems:
> - The NFS server is a fresh Debian 13 cloud image. freeipa-client, gssproxy, nfs-kernel-server, and qemu-guest-agent have been installed. Joined to FreeIPA via ipa-client-install.
> - Kerberos is provided by a newly installed FreeIPA instance on Fedora 43.
> 
> Failing NFS client configurations:
> 1. Freshly deployed and updated Debian 13 official cloud image (debian-13-genericcloud-amd64). freeipa-client, gssproxy, nfs-common, and qemu-guest-agent have been installed. Joined to FreeIPA via ipa-client-install.
> 2. Freshly installed Debian sid via mini ISO (2025-11-01). Same configuration as 1/above.
> 3. Minimal replication config: freshly installed Debian 13 via debian-13.1.0-amd64-netinst.iso . Installed nfs-common, krb5-config and krb5-user. Manually installed keytab: no additional krb5 configuration done (realm was automatically configured from hostname by krb5-config).
> 
> Working NFS client configuration:
> - Fedora 43 installation configured via ipa-client-install .
> 
> This issue was escalated to me by someone with a matching production environment (FreeIPA on Fedora 43, and Debian 13 NFS client(s) and server). This original reporter also found that a Fedora 43 client worked as-expected with SHA2.
> 
> 
> 
> Miscellaneous observations:
> - Testing was primarily conducted with NFS v4.2. Error occurs with krb5, krb5i and krb5p on 4.2. Also confirmed with krb5i on 4.1 and 4.0 (other combinations of krb5/krb5p and vers 4.1/4.0 not tested).
> - readdir failure observed when client is mounted with NFS v4.2, 4.1, and 4.0. ls reports "input/output error" and dmesg reports "readdir(/) returns -5" in all 3 versions.
> - When mounted with v4.1 and 4.0, cat'ing a file also fails with SHA2. There is no obvious (to me) error in dmesg. stat/touch of files and directories remains working.
> - Failing state is cached on the client: if a user runs ls with a SHA2 session key, then acquires a new SHA1 session key ticket, the "input/output error" persists unless the NFS share is remounted. Setting noac, actimeo=0, and lookupcache=none mount options do not affect this behavior: the error persists until a remount. Error persisted when left overnight (about 13 hours).
> - Cursory examination of a packet capture shows an apparently normal NFSv4 readdir call and reply. The reply contains the expected directory listing.
> 
> Attempted file/directory operations with SHA2 session key and sec=krb5i:
> (all are successful/OK with SHA1 session key)
> ls directory:
>     4.2: "Input/output error"
>     4.1: "Input/output error"
>     4.0: "Input/output error"
> stat file and directory:
>     4.2: OK
>     4.1: OK
>     4.0: OK
> touch file and directory:
>     4.2: OK
>     4.1: OK
>     4.0: OK
> cat file:
>     4.2: OK
>     4.1: "Input/output error"
>     4.0: "Input/output error"
> 
> 
> 
> 
> -- Package-specific info:
> -- rpcinfo --
>    program vers proto   port  service
>     100000    4   tcp    111  portmapper
>     100000    3   tcp    111  portmapper
>     100000    2   tcp    111  portmapper
>     100000    4   udp    111  portmapper
>     100000    3   udp    111  portmapper
>     100000    2   udp    111  portmapper
> -- /etc/default/nfs-common --
> NEED_STATD=
> NEED_IDMAPD=
> NEED_GSSD=
> -- /etc/nfs.conf --
> [general]
> pipefs-directory=/run/rpc_pipefs
> [nfsrahead]
> [exports]
> [exportfs]
> [gssd]
> use-gss-proxy=1
> [lockd]
> [exportd]
> [mountd]
> manage-gids=y
> [nfsdcld]
> [nfsd]
> [statd]
> [sm-notify]
> [svcgssd]
> -- /etc/nfs.conf.d/*.conf --
> 
> -- System Information:
> Debian Release: forky/sid
>   APT prefers unstable
>   APT policy: (500, 'unstable')
> Architecture: amd64 (x86_64)
> 
> Kernel: Linux 6.17.7+deb14+1-amd64 (SMP w/4 CPU threads; PREEMPT)
> Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8), LANGUAGE not set
> Shell: /bin/sh linked to /usr/bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled

Is there anything which could help us debugging this?

Regards,
Salvatore

