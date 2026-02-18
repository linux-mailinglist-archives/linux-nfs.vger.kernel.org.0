Return-Path: <linux-nfs+bounces-19024-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uERQOubnlWnKWAIAu9opvQ
	(envelope-from <linux-nfs+bounces-19024-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 17:25:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A998157B63
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A8843002D39
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6107E30C600;
	Wed, 18 Feb 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edZJP45I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F919D8A8
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431906; cv=none; b=L29yh5FiQKoITTFVOVD9y4CWR8oPPPaE4iQgc0xZRNe3JETp4MqjunqyK4/jsdNE01mIa2WHFbhqZMMJNAaWL5HB3SAJCJmifqXyt6t1nf7iGVqqPFhwkc3IhwCTHovWCFAI8vk+GBl10y/bInLxZi7TFGahIRunIxpDJobDy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431906; c=relaxed/simple;
	bh=liipMmOuTuRgK7FlMi4tzyRqy6BdXxnmvTc0tKGmlDM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bmH3ApgxeDTYVnhHLE7VVaoccV16YbbbbSeFHweZdho7wd276u3pOzAVdrXB1RbKl7OEfuGTZbaU9ASV6rmlEqbnm8Px1LwmlO5uVah7JvAAWlNpSwd6EP0KVKMS/W4X2S3d2mkEAlGxVYtSJpgBXstTeHrSdCibzLe4+UzDxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edZJP45I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8BAC116D0;
	Wed, 18 Feb 2026 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771431905;
	bh=liipMmOuTuRgK7FlMi4tzyRqy6BdXxnmvTc0tKGmlDM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=edZJP45Id0kb2rAJLBJ+gUD1OaaK6j2zt/ymqxraTr8dJx7FeB4Q3R1v+KviQh3k+
	 W/QU7lWK7Pknr/LPbD3XJUCy9Eod01i1Spit4Umu1uK89xAczQ6ymZ533D78ar1AoV
	 kWzF0rxWq2olOIYDEXl0pnKvRAnxGrujSe1XJsvRfQfSSK+aqefGfhhQmz3YRGfwkb
	 vfDyfnDQecDH1WYcCgthKNGOcZ2dfe7P8DcnXDS7n82xg/A0i/U/ieSoHVkIxnOwKM
	 mL2xg9vsU6GHk+Qc37oESOXrJFuWriljSQk53toURluFvFnZ3QEq+QoPQjVrng/kva
	 QGlqH5zZctEyQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D2EF2F40069;
	Wed, 18 Feb 2026 11:25:04 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 18 Feb 2026 11:25:04 -0500
X-ME-Sender: <xms:4OeVaURSSl_gvK6AcHYIoaXLcLH6V-NkVu4y0GcQX_jFBN233NqT4w>
    <xme:4OeVacnyzAJVnsrJOK_64k9Gp3WX40YvLcUqpWq8W7nNYCHU9c12F5re83-PkjUnu
    L5bkB3tRjtbxb4P7QKryFnlvuTTkaGUcdQSU6qA3YcDnYTzA2w1xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnnhgr
    ucfutghhuhhmrghkvghrfdcuoegrnhhnrgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpefgueffvdeghfevffeuveffuefgtdegueetvdettefgkeffhfevueelleeh
    gfejtdenucffohhmrghinheplhhinhhugidqnhhfshdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhhnrgdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudeijeejuddvtdejledqfeefvddvfeegjeduqdgrnh
    hnrgeppehkvghrnhgvlhdrohhrghesnhhofihhvgihtghrvggrmhgvrhihrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghssh
    gvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:4OeVaa6dAiAbIDIOooGm5r0qHJlzo9rCy6g7TrR8jyGQoiQ_cDmsFg>
    <xmx:4OeVaRuFTxRc1Ae4tDwld6XdSoRMVAe8Hm7C3X68AmQ_uy3W-mroaQ>
    <xmx:4OeVaT4kl-PGcBRuUh00lk101KLrD3MEy37Z0nMv6wCx05vUZNP3xQ>
    <xmx:4OeVaUVwqC1795YCrzEgl0iIC4_K0ModLtjotLMgDcO5N5XkHT-fgA>
    <xmx:4OeVad_eHKMHA8TsgNteBM_Opq4F3dYLrSdEsej_GkZ6mehkw4YU5d9x>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A9E92B6006E; Wed, 18 Feb 2026 11:25:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABcg2iGbHnJV
Date: Wed, 18 Feb 2026 11:24:42 -0500
From: "Anna Schumaker" <anna@kernel.org>
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
 dlemoal@kernel.org
Message-Id: <537b11ee-575a-4d03-8100-fc70afbefd5d@app.fastmail.com>
In-Reply-To: <aZM4XPFLM4V3YtsD@ryzen>
References: <20260212220625.358550-1-anna@kernel.org> <aZM4XPFLM4V3YtsD@ryzen>
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 7.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19024-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1A998157B63
X-Rspamd-Action: no action



On Mon, Feb 16, 2026, at 10:31 AM, Niklas Cassel wrote:
> On Thu, Feb 12, 2026 at 05:06:25PM -0500, Anna Schumaker wrote:
>> Hi Linus,
>> 
>> The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7:
>> 
>>   Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)
>> 
>> are available in the Git repository at:
>> 
>>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-1
>> 
>> for you to fetch changes up to dd2fdc3504592d85e549c523b054898a036a6afe:
>> 
>>   SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path (2026-02-09 16:39:50 -0500)
>> 
>> ----------------------------------------------------------------
>> NFS Client Updates for Linux 7.0
>> 
>> New Features:
>>  * Use an LRU list for returning unused delegations
>>  * Introduce a KConfig option to disable NFS v4.0 and make NFS v4.1 the default
>> 
>> Bugfixes:
>>  * NFS/localio: Handle short writes by retrying
>>  * NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
>>  * NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
>>  * NFS/localio: remove -EAGAIN handling in nfs_local_doio()
>>  * pNFS: fix a missing wake up while waiting on NFS_LAYOUT_DRAIN
>>  * fs/nfs: Fix a readdir slow-start regression
>>  * SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path
>> 
>> Other Cleanups and Improvements:
>>   * A few other NFS/localio cleanups
>>   * Various other delegation handling cleanups from Christoph
>>   * Unify security_inode_listsecurity() calls
>>   * Improvements to NFSv4 lease handling
>>   * Clean up SUNRPC *_debug fields when CONFIG_SUNRPC_DEBUG is not set
>> 
>> Thanks,
>> Anna
>
> Hello Anna,
>
> This seems to break my setup:
>
> [  103.402033] VFS: Unable to mount root fs via NFS.
> [  103.402476] devtmpfs: mounted
> [  103.406171] Freeing unused kernel memory: 4352K
> [  103.406633] Run /sbin/init as init process
> [  103.406993]   with arguments:
> [  103.407253]     /sbin/init
> [  103.407491]   with environment:
> [  103.407767]     HOME=/
> [  103.407976]     TERM=linux
> [  103.408228] Run /etc/init as init process
> [  103.408580]   with arguments:
> [  103.408841]     /etc/init
> [  103.409071]   with environment:
> [  103.409346]     HOME=/
> [  103.409553]     TERM=linux
> [  103.409802] Run /bin/init as init process
> [  103.410153]   with arguments:
> [  103.410414]     /bin/init
> [  103.410644]   with environment:
> [  103.410920]     HOME=/
> [  103.411128]     TERM=linux
> [  103.411367] Run /bin/sh as init process
> [  103.411703]   with arguments:
> [  103.411963]     /bin/sh
> [  103.412179]   with environment:
> [  103.412454]     HOME=/
> [  103.412662]     TERM=linux
> [  103.412904] Kernel panic - not syncing: No working init found.  Try 
> passing init= option to kernel. See Linux 
> Documentation/admin-guide/init.rst for guidance.
>
>
> Doing a git bisect results in:
>
> commit 4e0269352534715915aae3fb84dd4d3bb3ff3738
> Author: Anna Schumaker <anna.schumaker@oracle.com>
> Date:   Fri Nov 21 14:53:50 2025 -0500
>
>     NFS: Add a way to disable NFS v4.0 via KConfig
>
>     I introduce NFS4_MIN_MINOR_VERSION as a parallel to
>     NFS4_MAX_MINOR_VERSION to check if NFS v4.0 has been compiled in and
>     return an appropriate error if not.
>
>
>
> Before commit above my config has:
> CONFIG_NFS_FS=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
>
> after commit above (with make olddefconfig), my config has:
> CONFIG_NFS_FS=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_V4_0 is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
>
>
>
> My kernel command line has:
> nfsroot=192.168.1.10:/srv/nfs/rootfs,nfsvers=4
>
>
> I notice that I am probably stupid who has the above, as I assumed that
> it meant use the best NFS 4.x version supported by the kernel.
>
>
> If I change it to:
> nfsroot=192.168.1.10:/srv/nfs/rootfs,nfsvers=4.2
>
> The config:
> CONFIG_NFS_FS=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_V4_0 is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
>
> successfully mounts my rootfs.
>
>
> So AFAICT, it seems that nfsvers=4 actually means nfsvers=4.0
>
> I am probably not the only person to who has "nfsvers=4" on the kernel
> command line.
>
>
>
> Possible solutions I can see:
>
> If the intention is for commit 4e0269352534 ("NFS: Add a way to disable
> NFS v4.0 via KConfig") to allow people to disable NFS 4.0, we could
> change the new "config NFS_V4_0" to be either "default y".

This is what I intended, actually. I don't know how the missing "default y"
slipped through the cracks for this long. Thanks for pointing it out, I'll
get this fixed up!

Anna

>
> or
>
> Perhaps we could modify "nfsvers=4" to actually mean "use whatever highest
> NFS 4.x version supported by the kernel", rather than use NFS 4.0 and only
> 4.0.
>
>
>
> Kind regards,
> Niklas

