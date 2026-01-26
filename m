Return-Path: <linux-nfs+bounces-18476-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPwFA+OWd2n0iwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18476-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 17:31:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C18AB1F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EB3301BCC8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890934253C;
	Mon, 26 Jan 2026 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDh4gh8Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5634253A
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445064; cv=none; b=sJ6nI8D0iughsjYlMa7kgr6UwNHezD3qIHgenGBOTfaVOJdFhNfRdrmpa/gOkG7q7kWIgAGk1uGRbywV5O5l8VLxBwR8e4C5ybSwxPZ6bBGTw/lHqXhmQMAGQSXqyxnAgF//SWIrPxgNpfIefqkjn2wCXkrOJrGyXcUOYM5NdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445064; c=relaxed/simple;
	bh=3b2fqxUdfcljQzjh0nGl8D0KzDPxm4hbPpRbXLEA9TQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e+KrKmfE1qePy2rZnxOrLBensXOHANifD0xpAGgEHKrnG+WY9rWKJe8tEdC6qFAPZVa60ih2gPbZpSqAqGXOHJQDfcdVW5b5umdCgub5ZUs4aGfVLmnc+SnQS+Z/U8PqL05MXQ+sz6uL0A5SUv/uwnuNVzrdo7C2CgdJpF3dmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDh4gh8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A082C116C6
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769445064;
	bh=3b2fqxUdfcljQzjh0nGl8D0KzDPxm4hbPpRbXLEA9TQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nDh4gh8QP0CNVQCtpUUSCHZWIxAv+gdlMXhDfcBMID3ENZ900neZc+tFUeVXhcz3X
	 ZJH3gCwfzEydGmF+MLMED/f5GVhCL6Vn2l/p6HtbD4fWcTBnepgfZJkG1QrBWBWRLm
	 3Er8ufPuY9RkETciQ+hzACM8Wr+1NNKPGAGIQfQ69+fL+PWKA+Yf75XNnJ0HfxRxeV
	 4PxSAM5nJg7TmVN3iKOFXwIQsyV3ci2ztyt7KRZbpwKcbUFX8Y+m6xAIGz93gQQ73e
	 b3qxrHwyt5YdQg5QklxQBrHdYnbe+cPwBqp0n5R2JiW9mcpPkyrtxEVWwiY2KIOMV8
	 ngDlNeQ1tP3iA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B6F8F40068;
	Mon, 26 Jan 2026 11:31:03 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 26 Jan 2026 11:31:03 -0500
X-ME-Sender: <xms:x5Z3afJItanNTfP6hEfaRJXwh2gv3-EBgfCP3uY54soybV4652xdSg>
    <xme:x5Z3ad9OYBhmRg0zDIBLV-6sN8tAy3d-G_Oqj9m2v-jqDH3Qo-rHqttc-GPpC-nIz
    jm_eS1MHgUNmINt6zt2Y4ub9SQCOK1cpUqFqJgPRzRcK-2-zafQQXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekudeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:x5Z3aZ3Qi0rxgcPqMxaSltbM2KqanIP2ElwyCZXqyBzoW-HYzi1diA>
    <xmx:x5Z3aeApi_lyDpZxcqK-eCDCaJb3iHqk6XtlbVxISQVbPqadce18tQ>
    <xmx:x5Z3aReSJgxmfiiL8bE_rjiViKqPzTd4z91KsElTUSk3-KFoAKdxhw>
    <xmx:x5Z3aTjJeBDm997SmdpdIol45UrdgrThZ7RpDlUDF1KsNU85j6rQDQ>
    <xmx:x5Z3aZqvanNXfjVCUyqFljvSSASSVzS6_2DmxjKJQG7ySQeeLioqBumg>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EBA01780077; Mon, 26 Jan 2026 11:31:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7FasjyZ6tmc
Date: Mon, 26 Jan 2026 11:30:24 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
References: 
 <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com>
 <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-18476-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
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
X-Rspamd-Queue-Id: C95C18AB1F
X-Rspamd-Action: no action



On Sun, Jan 25, 2026, at 6:45 PM, Daire Byrne wrote:
> On Sun, 25 Jan 2026 at 16:19, Chuck Lever <cel@kernel.org> wrote:
>>
>>
>>
>> On Sun, Jan 25, 2026, at 7:26 AM, Daire Byrne wrote:
>> > Hi,
>> >
>> > We recently came across a workload that consisted of 100s of clients
>> > under (cgroup) memory pressure and so their page cache was all but
>> > exhausted. This resulted in lots of repeat small 4k-8k random reads
>> > hitting our NFS servers which maxed out their CPUs and flatlined
>> > performance.
>> >
>> > Uniquely, the data being read easily fit in the server's page cache so
>> > there was no backend IO to limit throughput.
>> >
>> > The fix was to put in place a system to kill workloads under such
>> > memory pressure. But it piqued my curiosity, so I decided to do some
>> > simple benchmarks to see where the server limits are.
>> >
>> > I ran something like this across 200 client hosts simultaneously using
>> > NFSv3 to reproduce:
>> >
>> >  fio --directory /hosts/nfs1/xfs1/ --name test-file --direct=0
>> > --buffered=1 --size=1g --time_based --runtime=600s --bs=4096
>> > --rw=randread --numjobs=2
>> >
>> > By reading the same small file from many hosts, we are essentially
>> > serving from server page cache so can rule out disk IO (I even tried
>> > files on /dev/shm)
>> >
>> > The main things I found:
>> > * across a wide range of server hardware, we top out around 300k-400k
>> > read iops/s.
>> > * whether the server has 24/48/96 cores, the results were pretty much the same.
>> > * 24 knfsd threads is the optimal with more threads reducing
>> > performance until threads=ncores
>> > * multiple nics (bonded) or single socket (no numa) makes little or no
>> > difference
>> > * different nic hardware make little difference (2x100g, 4x25g,
>> > broadcom, mellanox etc).
>> > * various network tuning (queues, txqueuelen, qdisc, etc) makes little
>> > difference.
>> > * NFSv4.2 has less read iops/s (160k/s) but it also has sequence &
>> > pufh ops too (+ 2x160k/s).
>> > * increasing nconnect (>1) reduces aggregate read iops performance (8 -> 120k/s)
>> >
>> > It feels like there is some thread locking contention limitation such
>> > that the number of CPUs and/or knfsd threads reaches some plateau and
>> > throwing more cores/threads at the workload just results in more CPU
>> > time spent spinning but you get no more performance out.
>> >
>> > The top level perf report looks something like the attached (for v6.18).
>> >
>> > Like I said, we can work around this pretty rare workload (random
>> > small reads from server page cache), but it just piqued my interest as
>> > to what the underlying (knfsd) server limit is (it doesn't seem to be
>> > hardware).
>>
>> At risk of being glib, the performance data suggests your workload is
>> tickling one or more contended spin locks. To collect more information
>> about the contended spin locks, see
>>
>>   Documentation/locking/lockstat.rst
>
> Yea, good idea. I ran a quick test (200 NFSv3 clients, 4k randread)
> and attached the resulting top locks (abbreviated).
>
> Again, this is for the latest v6.18 kernel. A couple of expensive
> looking locks, but the xpt_mutex/svc_tcp_sendto seems to have the
> highest overall cost?

There's kind of no denying it, the xpt_mutex numbers are shitty.
The maximum hold time on that mutex is 293379.40 usecs, with a
mean hold time of nearly 16 usec, giving it the worst mean wait
time by an order of magnitude. And it's not even a contended lock.

It's probably not easy for you to bisect, is it...


> I do remember seeing a lot of contention around the file cache in
> older kernels but I think lots of improvements were made to that circa
> v6.0.
>
> If I do a "local" 4k random read fio on the server to /dev/shm with
> 200 workers, you get silly numbers like 2 million iops/s. I don't know
> if that is a particularly valid test of just the backend storage
> contention (when reading completely from page cache).
>
> Daire
>
> Attachments:
> * lockstat.txt

-- 
Chuck Lever

