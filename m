Return-Path: <linux-nfs+bounces-18508-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLASD97Id2lOkwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18508-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:04:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 816D98CDDB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361CC3012248
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D82BEC5F;
	Mon, 26 Jan 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTff7aza"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87E2BDC13
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457883; cv=none; b=swrv5JJJb0TYE/cTR7VGG8KLtmjBFRGZo6//ZhYg5fzLpWrKV2cx6qlzeWeyRIoNK6eWMBCKMiRNO4PdHQTXbrS5MvepXfq21CRvMVIJJdofyTVc3IuNHZ9blc+oXv2D+IDJF1VXJKx2vcX7eAg1fAF+KAPto4h515LaN2DbTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457883; c=relaxed/simple;
	bh=xtSxQMNFcx0cavsI+3R0RgA4Euw8oZOFHt+VygaANyk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LIKooGZzxKd6zrZa25ReE2+rCgXFZ8reafjFYGZZyUcLaF2LEyv5/J3XUg+Um3McpbjkMnv8jQmNxXmq7Wim834bdsra7UPGPqJIEgJBdzQeLDQH6OLuyHD2q9qk76QDmhy6RtSNyKhaGqmLry9mtStk7Tq/kO7CSS+T01pdfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTff7aza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350A5C19422
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457883;
	bh=xtSxQMNFcx0cavsI+3R0RgA4Euw8oZOFHt+VygaANyk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bTff7azaKdu+HA019ZmYpFmxjT1EGXWXS9bZreXy7hhg6btjybWG08fidEyWPAqdo
	 7BQwm4maG1B3iUtg4/FgAjqLugrFm+8k/M39VYde4xw2pHcLr6nfLo0lg+IPetNduu
	 U1cBv8pGlf2XZNgFXwYVvjNDStpNihcUKLzBLZpmW5AVL8W/okHVxPNnSaE1nc5YgG
	 4A0CwmX82sVdxOY+sX8jiMybzD3A0lz3VVBdAfcJisQQhJhtKvTykan32aDq7goJ7s
	 a+Ca99hHr7Sv2SZqhIbgxkKnPp23PsdUgLqmv66ItT5AhQcZwI4LUI8AVndU9WPqnI
	 MAT3wNLeAk0tw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 20A2CF4006C;
	Mon, 26 Jan 2026 15:04:42 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 26 Jan 2026 15:04:42 -0500
X-ME-Sender: <xms:2sh3aWbTfzjVo-TYNL33wNGQ8J4klY-JwSJwYuZF3qrkXcCcp1vusA>
    <xme:2sh3aUN68Rdg6HsDSfJnZT0g7SJ6lP29uuWhcf_4qJgEYhZJg0xLob-YMhMk9HH2T
    svQ9CylSCQK3EvCFaXSZ087ZjQ0s6XATxeexHSnXaryHwmVoh1xCfKy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvffejhfeiudffvdeugeevieeuffefuddtveetffejleelvefghfehvedutdduheen
    ucffohhmrghinhepudekrdhlihhkvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpeepkh
    gvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrihhrvgesughnvghgrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2sh3aRHgnV2WNNcoBdNkyav0HQbHeUM4WAhpCwozl2pHfAZ4e8hGQA>
    <xmx:2sh3aUT2DSm0Luku1WQ9Kkz8IchRVYGanbtmlkI9_C1ydCDzxuZO5A>
    <xmx:2sh3aatwqe5-46aoQWSzERjppzC_b2a4DWD2SkQi00qSYwIT9g9G2g>
    <xmx:2sh3aTyGmp7Q7-uu7iFj5BAPy1CB5qPvm4CQmmrdo2p77_BVBwMdLg>
    <xmx:2sh3aU7CSf_HpJnUECZjLAX5AvNJtI9-GUwRTnDdMy-GLq4CeDMZTXzI>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02661780070; Mon, 26 Jan 2026 15:04:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7FasjyZ6tmc
Date: Mon, 26 Jan 2026 15:04:12 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <d9926f9e-50bf-46e7-9109-21b30dd695c1@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
References: 
 <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com>
 <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
 <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com>
 <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
Subject: Re: knfsd read iops limits?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-18508-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 816D98CDDB
X-Rspamd-Action: no action



On Mon, Jan 26, 2026, at 1:46 PM, Daire Byrne wrote:
> On Mon, 26 Jan 2026 at 16:31, Chuck Lever <cel@kernel.org> wrote:
>>
>>
>>
>> On Sun, Jan 25, 2026, at 6:45 PM, Daire Byrne wrote:
>> > On Sun, 25 Jan 2026 at 16:19, Chuck Lever <cel@kernel.org> wrote:
>> >>
>> >>
>> >>
>> >> On Sun, Jan 25, 2026, at 7:26 AM, Daire Byrne wrote:
>> >> > Hi,
>> >> >
>> >> > We recently came across a workload that consisted of 100s of clients
>> >> > under (cgroup) memory pressure and so their page cache was all but
>> >> > exhausted. This resulted in lots of repeat small 4k-8k random reads
>> >> > hitting our NFS servers which maxed out their CPUs and flatlined
>> >> > performance.
>> >> >
>> >> > Uniquely, the data being read easily fit in the server's page cache so
>> >> > there was no backend IO to limit throughput.
>> >> >
>> >> > The fix was to put in place a system to kill workloads under such
>> >> > memory pressure. But it piqued my curiosity, so I decided to do some
>> >> > simple benchmarks to see where the server limits are.
>> >> >
>> >> > I ran something like this across 200 client hosts simultaneously using
>> >> > NFSv3 to reproduce:
>> >> >
>> >> >  fio --directory /hosts/nfs1/xfs1/ --name test-file --direct=0
>> >> > --buffered=1 --size=1g --time_based --runtime=600s --bs=4096
>> >> > --rw=randread --numjobs=2
>> >> >
>> >> > By reading the same small file from many hosts, we are essentially
>> >> > serving from server page cache so can rule out disk IO (I even tried
>> >> > files on /dev/shm)
>> >> >
>> >> > The main things I found:
>> >> > * across a wide range of server hardware, we top out around 300k-400k
>> >> > read iops/s.
>> >> > * whether the server has 24/48/96 cores, the results were pretty much the same.
>> >> > * 24 knfsd threads is the optimal with more threads reducing
>> >> > performance until threads=ncores
>> >> > * multiple nics (bonded) or single socket (no numa) makes little or no
>> >> > difference
>> >> > * different nic hardware make little difference (2x100g, 4x25g,
>> >> > broadcom, mellanox etc).
>> >> > * various network tuning (queues, txqueuelen, qdisc, etc) makes little
>> >> > difference.
>> >> > * NFSv4.2 has less read iops/s (160k/s) but it also has sequence &
>> >> > pufh ops too (+ 2x160k/s).
>> >> > * increasing nconnect (>1) reduces aggregate read iops performance (8 -> 120k/s)
>> >> >
>> >> > It feels like there is some thread locking contention limitation such
>> >> > that the number of CPUs and/or knfsd threads reaches some plateau and
>> >> > throwing more cores/threads at the workload just results in more CPU
>> >> > time spent spinning but you get no more performance out.
>> >> >
>> >> > The top level perf report looks something like the attached (for v6.18).
>> >> >
>> >> > Like I said, we can work around this pretty rare workload (random
>> >> > small reads from server page cache), but it just piqued my interest as
>> >> > to what the underlying (knfsd) server limit is (it doesn't seem to be
>> >> > hardware).
>> >>
>> >> At risk of being glib, the performance data suggests your workload is
>> >> tickling one or more contended spin locks. To collect more information
>> >> about the contended spin locks, see
>> >>
>> >>   Documentation/locking/lockstat.rst
>> >
>> > Yea, good idea. I ran a quick test (200 NFSv3 clients, 4k randread)
>> > and attached the resulting top locks (abbreviated).
>> >
>> > Again, this is for the latest v6.18 kernel. A couple of expensive
>> > looking locks, but the xpt_mutex/svc_tcp_sendto seems to have the
>> > highest overall cost?
>>
>> There's kind of no denying it, the xpt_mutex numbers are shitty.
>> The maximum hold time on that mutex is 293379.40 usecs, with a
>> mean hold time of nearly 16 usec, giving it the worst mean wait
>> time by an order of magnitude. And it's not even a contended lock.
>>
>> It's probably not easy for you to bisect, is it...
>
> I can certainly bisect through some generations of kernel, but I'm not
> sure there has ever been a "good" one when it comes to this extreme
> (niche) workload (4k read iops).

True, having a "good" starting point is a pre-requisite for
obtaining quality bisection results. I'm going to try some
simple experiments here to see if I can spot any structural
problems with the TCP send path.


> We have a few generations of hardware and OS versions like RHEL8
> (4.18), RHEL9 (5.14) and mainline (v6.18) in production, but I see
> similar performance plateaus for this workload in all cases (~300k
> iops/s).
>
> But it could well be that they are all limited for different reasons
> (lock contentions). I distinctly remember seeing high
> nfsd_file_lru_remove & nfsd_file_put (perf lock record) contention on
> the RHEL9 (5.14) kernel which I don't see now on mainline.
>
> I'm happy to record the lockstat report for this workload across a few
> different kernel versions if that is of interest to anyone.


-- 
Chuck Lever

