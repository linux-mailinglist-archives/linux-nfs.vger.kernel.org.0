Return-Path: <linux-nfs+bounces-18860-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OExwEIFii2nDUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18860-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:53:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87D11D735
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A9443004DF7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4C3203BC;
	Tue, 10 Feb 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bce70tqf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4E31B825
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742397; cv=none; b=ggwEE0QdWDu4vhZiuTQ4hTkV0TGhq+iBbEgk/vtHzT0n18CjNXyhkIPaTM0gzCrwg0ayf/GBPBPchfdLwomOzBIk+ojLzWamGYVbPeRagvscShTs4i53fnlG0LxcA5nV+NUklgGSks2zEBSGqeZI9bh0IpKS6zdCHhukKuGuVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742397; c=relaxed/simple;
	bh=MnoH34eq22ehSvAWAWW9MOJJCT2AAOoEMtyGYJWbM1Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LMLPt86gF6VrhTayH6UJbH4Sk7RZhBEb5tHJL1gw/DqDb4wDipjH8zM5jpZaxq7HxF7cn9HaWqCFPNjdzTYFZGSA3BYe1U5hvnPjMGDdydgQCfxKBh+EC0wV+WOwsjsZ7sK6r7ZVxg+WR3eZtmuxYZq3hztirHNMaszh7oGyJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bce70tqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D648BC116C6;
	Tue, 10 Feb 2026 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770742397;
	bh=MnoH34eq22ehSvAWAWW9MOJJCT2AAOoEMtyGYJWbM1Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bce70tqfbkx1C7onjnmnMCQ88QG1HCm3WG/1P4Gzh9huENx/bnqEYoD2Zp7F7CZs+
	 LOPPO36Sq8dyGRdUbe1ZPzh4yo+rIKU+59gE4fTxobHcpD6D7VErok7FIKZ+eaVVgh
	 6c+bDo6+OBCmkwZ6ae+F7QZ+eP4Uxxbs9EqXjQTMvnAN4eNLOAba60xqSMKnMJGzTP
	 E8M148XEagb0sRWq+fEq+xwG6kbyXhtw4Bk09/7tOiZTXMpyDRSi5w30Ny1LmmHhBB
	 t7mY3tYLL8eysS7Ow4MhM/ZpLBCGvMiazLLNV7KtShuc+vWTW0eSS0PeyukslbEwUD
	 O7sHhcets6QxA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B375FF40068;
	Tue, 10 Feb 2026 11:53:15 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 10 Feb 2026 11:53:15 -0500
X-ME-Sender: <xms:e2KLaQ93-8vuI18uve_Halv-s8CLM_VfLNaOM2lU4TpAyTLjkMIXgA>
    <xme:e2KLaTj_a2bUgveQLXuku0qfRFDpTcZaiXwffcKPmhWdwmUH_rG4nIbbK7BZlt0IM
    Ljj7xTwnzikQ0uqcRxL8bKQI4XVxjdv-EbEKUcHHw8pnT6NcFz1zOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrihhrvgesughnvghgrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:e2KLafq_3U_jef3eYrHzvDX5syiFDedEAZWzSZOmbYFPYvMZOIVyrQ>
    <xmx:e2KLaXmiNyoknGODFkE4IYDWJoOZtBEHchTygHgIRNn_fEBNRGhCRA>
    <xmx:e2KLaTxh-5QBx8PAAqiUdBucJfJinWLBx_g_mBLKae_MIEWLWRKwgw>
    <xmx:e2KLafk5TJEwX6vp-YQhiPDy96-hGXS38ibMY2TZiW7Gw8HHolUs1w>
    <xmx:e2KLaccXq5Sf2QYqHrF7T0sK4emZ8NKSo_rG_bikLJqd6TyWDxHzF1TL>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C195780075; Tue, 10 Feb 2026 11:53:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7FasjyZ6tmc
Date: Tue, 10 Feb 2026 11:52:53 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <110b6190-ed55-41d0-a3ca-580ebc38c1e5@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGOsCLrG30s7mrOvd3N5t018T+gJhGWd88pw0WbOnagO=A@mail.gmail.com>
References: 
 <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com>
 <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
 <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com>
 <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
 <d9926f9e-50bf-46e7-9109-21b30dd695c1@app.fastmail.com>
 <CAPt2mGNbZm9YDjuCUwJHiJUQUUnKQtbf1ggYPzAytgWjMp68LA@mail.gmail.com>
 <CAPt2mGOsCLrG30s7mrOvd3N5t018T+gJhGWd88pw0WbOnagO=A@mail.gmail.com>
Subject: Re: knfsd read iops limits?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-18860-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dneg.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CB87D11D735
X-Rspamd-Action: no action



On Mon, Feb 9, 2026, at 6:43 PM, Daire Byrne wrote:
> On Tue, 27 Jan 2026 at 00:48, Daire Byrne <daire@dneg.com> wrote:
>> > > We have a few generations of hardware and OS versions like RHEL8
>> > > (4.18), RHEL9 (5.14) and mainline (v6.18) in production, but I see
>> > > similar performance plateaus for this workload in all cases (~300k
>> > > iops/s).
>> > >
>> > > But it could well be that they are all limited for different reasons
>> > > (lock contentions). I distinctly remember seeing high
>> > > nfsd_file_lru_remove & nfsd_file_put (perf lock record) contention on
>> > > the RHEL9 (5.14) kernel which I don't see now on mainline.
>> > >
>> > > I'm happy to record the lockstat report for this workload across a few
>> > > different kernel versions if that is of interest to anyone.
>
> I thought I'd run the same workload using v6.19 vanilla & v6.19 +
> Chuck's sunrpc lock retention rfc patches. I've attached the lockstat
> results.
>
> The workload is the same (10 minute) fio randread from ~200 clients
> where all the reads come from page cache on the server.
>
> It's hard to get exactly the same workload reaching the server each
> time as the 200 clients are also doing other things so there is some
> randomness due to that.
>
> It also took me a while to realise that something was setting the nfsd
> process cpu affinity on boot - some runs were spreading the nfsd
> threads (512) across all cores (2 x 48) and other times it was pinning
> the nfsd threads to the second socket only (where the NIC was).

Perhaps not pinned. The new receiver kthread is affined to the core
and socket where the NIC is, and the scheduler might be favoring
dispatch of the servicing nfsd threads on the same or a topologically
close core.


> Anyway, the attached lockstat is consistent in both cases - the nfsd
> threads are using all the cores of both sockets.
>
> I don't see much difference in the patched and vanilla cases. I will
> triple check that the patch series was applied successfully and I
> didn't mess up the install.

The lockstat data shows that the patches are applied and that flat
combining is reducing xpt_mutex contention, as designed.

This time, the lwq spinlock in the thread pool dispatch path
shows very high contention (246M events, 54k seconds total wait).

Could you collect "perf record -a -g -- sleep 30" during the same
workload? A perf profile should show whether that's the throughput-
limiting factor or whether nfsd threads are spending their time
elsewhere.

-- 
Chuck Lever

