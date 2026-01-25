Return-Path: <linux-nfs+bounces-18449-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zSV6BrNCdmlkOQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18449-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 17:20:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D88167C
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E84130048DD
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4F1D5174;
	Sun, 25 Jan 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ/ViEco"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA818E025
	for <linux-nfs@vger.kernel.org>; Sun, 25 Jan 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357998; cv=none; b=pNtqvrWbc2WL+V5FY2SRHD5X7EFXsi6Uok99pmxtUTFKIaRstvclZynkWxKnIm0YoaG/LLrVTSKZeSUkNQAWEMs/mSPfisxqgj0g/R+LMEkwwlPePmL4gRhSVbzl1GLek1akdD6J+4PQfvBxSmrrDcH2+uA0QTPVwW2+fj8LYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357998; c=relaxed/simple;
	bh=B+rOEEGbuumpy/J14Xwtf6nx5nL20eYa9jevjFTDU3U=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ldmgtNqv7Niw65SQCp32A5RUcayARFYseGtYLkNEAtk5l56UHSrI7i0i9AxFZeYC6hPU4PLscDtQvLIia6z9MXRYZeQF0+387w+6aqD4KWbuoBfQ9KqHTDgdmnX/aseFeJXkV9avY6w9wmC8+MkO8NAqNQP/PJklZD8o8slRpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ/ViEco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33665C2BC86
	for <linux-nfs@vger.kernel.org>; Sun, 25 Jan 2026 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769357998;
	bh=B+rOEEGbuumpy/J14Xwtf6nx5nL20eYa9jevjFTDU3U=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=SJ/ViEcoCZbNEs1c9llY+0ykHQ/9woIq0UoTjCb/RL7Q+UwZwYgO3/jRISshK1kwL
	 B7+SW3D/MqcSRYQXjjWNX/mqLKD7x4ndiuggmogSthStzAXlZ1shbOkmR7dKnpSrfF
	 vsJtOWmkHhtqsDvT/p7zdS7Uhm5ilH2t/kD4glqYy1xmgP8GJaP0uT4Z4M1KULJ0i8
	 r1ACe6rNPWwdEs7iUYzqg9JSmrfgZhw8QqrbI+uTXjkxXdLjS5KW/d8bWN3tSI//yA
	 G6mgJaT6hy5MLEVPhqq8/FUHpchEBfWrBghddd7cwwCUQ3EePUokvfsjMv9+rdHbsr
	 dFZbHluOK9ItQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2177EF40068;
	Sun, 25 Jan 2026 11:19:57 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 25 Jan 2026 11:19:57 -0500
X-ME-Sender: <xms:rUJ2adta4mhdbndTomnSMYjv7oPlYJV8SsbJjMNI-uFH6zJScl58sA>
    <xme:rUJ2aRRFdI37Tv26eRpPbxREQeE--oyuJ1oBS7eU8rwg9LPoQCODftYxSs4J1MgNM
    11ur13VRrMXeV4HLUYHWJOwMUKp8LFc7cOX55-qMj1tS07oMrTzU0bx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgefgvdejffekkeevueehjeeuvdelfeefgfeuveevuedukeelffdvieekheelvdeunecu
    ffhomhgrihhnpedukedrlhhikhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlheppehkvg
    hrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghirhgvsegunhgvghdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rUJ2acYutaz-e8ilshwTMV0xUmqQVvaqo0Rj8OIEwBSFzDpYwtDccg>
    <xmx:rUJ2aVUXjUsresmVW8II_nIy76pG7MpEGI-h3bVlhibNgkYXiFy2tA>
    <xmx:rUJ2aejKKxC1atB8SfL5njgghEHazeuygp8VqMGVVERoknMTcyuDmQ>
    <xmx:rUJ2aTXAaRZl_l6ThBKbaBTp35MUI_gP9J8BBKJkA8mh3Crhg9vT-A>
    <xmx:rUJ2aVMnJ5BL4wq96vG6hQOmZNB9PL5o4XKsSSGJ6s0iVv93xggwwAvP>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ECA02780077; Sun, 25 Jan 2026 11:19:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7FasjyZ6tmc
Date: Sun, 25 Jan 2026 11:19:29 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
References: 
 <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
Subject: Re: knfsd read iops limits?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18449-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 404D88167C
X-Rspamd-Action: no action



On Sun, Jan 25, 2026, at 7:26 AM, Daire Byrne wrote:
> Hi,
>
> We recently came across a workload that consisted of 100s of clients
> under (cgroup) memory pressure and so their page cache was all but
> exhausted. This resulted in lots of repeat small 4k-8k random reads
> hitting our NFS servers which maxed out their CPUs and flatlined
> performance.
>
> Uniquely, the data being read easily fit in the server's page cache so
> there was no backend IO to limit throughput.
>
> The fix was to put in place a system to kill workloads under such
> memory pressure. But it piqued my curiosity, so I decided to do some
> simple benchmarks to see where the server limits are.
>
> I ran something like this across 200 client hosts simultaneously using
> NFSv3 to reproduce:
>
>  fio --directory /hosts/nfs1/xfs1/ --name test-file --direct=0
> --buffered=1 --size=1g --time_based --runtime=600s --bs=4096
> --rw=randread --numjobs=2
>
> By reading the same small file from many hosts, we are essentially
> serving from server page cache so can rule out disk IO (I even tried
> files on /dev/shm)
>
> The main things I found:
> * across a wide range of server hardware, we top out around 300k-400k
> read iops/s.
> * whether the server has 24/48/96 cores, the results were pretty much the same.
> * 24 knfsd threads is the optimal with more threads reducing
> performance until threads=ncores
> * multiple nics (bonded) or single socket (no numa) makes little or no
> difference
> * different nic hardware make little difference (2x100g, 4x25g,
> broadcom, mellanox etc).
> * various network tuning (queues, txqueuelen, qdisc, etc) makes little
> difference.
> * NFSv4.2 has less read iops/s (160k/s) but it also has sequence &
> pufh ops too (+ 2x160k/s).
> * increasing nconnect (>1) reduces aggregate read iops performance (8 -> 120k/s)
>
> It feels like there is some thread locking contention limitation such
> that the number of CPUs and/or knfsd threads reaches some plateau and
> throwing more cores/threads at the workload just results in more CPU
> time spent spinning but you get no more performance out.
>
> The top level perf report looks something like the attached (for v6.18).
>
> Like I said, we can work around this pretty rare workload (random
> small reads from server page cache), but it just piqued my interest as
> to what the underlying (knfsd) server limit is (it doesn't seem to be
> hardware).

At risk of being glib, the performance data suggests your workload is
tickling one or more contended spin locks. To collect more information
about the contended spin locks, see

  Documentation/locking/lockstat.rst


-- 
Chuck Lever

