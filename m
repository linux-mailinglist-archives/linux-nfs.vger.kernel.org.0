Return-Path: <linux-nfs+bounces-20539-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDC5EDXKyml3AAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20539-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 21:08:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC963602E7
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99802303B4D2
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17E36894F;
	Mon, 30 Mar 2026 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+iWDLoe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E4366560
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897493; cv=none; b=U4jMd8QtDMYru7frFq7+CmgGB2QF2iS6ryd+jMRXd2K05+lp55GIiwG5mPb2nXxFD3h1/4UOKZyTFwLgKOb21DO3/U9GLkIqaEbDs/PM6qCZfs/7j7yAfiDN1NZSB06WK/M6wMpY2fHGVqny4LRjqOXK4KJp9S+AnTKG4kW1G1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897493; c=relaxed/simple;
	bh=IyQiSsWAI16NRED382ENJpEKuHa4+ifSp2QXDZovYw8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Of0wS9gOsXq2f8xZbfV5wpjOKIIJzbtEcZ2pi/Tl8XFmpQtgJC6eujwvpHzZss6PY0C47fSD9EHs0iV35dEO9PJOHnGztl4n2D/ugbAWAJl/7a/vAi4gQ0S+0pqvf4EfObQ0S7TufLPeA4F2xLH0W64YqO2LmBBz/SX/aVLIKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+iWDLoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BC8C4AF0B;
	Mon, 30 Mar 2026 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774897492;
	bh=IyQiSsWAI16NRED382ENJpEKuHa4+ifSp2QXDZovYw8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=a+iWDLoeRXxqPZakXt6PxG4zo16w2dAUvp5plE4DvyPvOibdV7S94NMC8aFBma/is
	 DRwRFvrfG2y98IEZ4C9f1t1QJ/pGWPgzehrQTfVYgRAhaLavNZipkl5Ybq2ZAhEvRW
	 3ITwDatEBXm1MZenFz0hDBbF2Zb84JXTnEPclhVPdEIrwdJ+v0wFNyrl4NFLc1oXvy
	 47pgEjaDn0Z2LP4luUZLbx42JPySq81bgSy0t+3MRB82f/NLiOR/yiNILc15x76xLQ
	 Q31Mx3Pl8J7oBJIP2lNLT8A2IKaqzpdSZgsFcek4mZXq6hZMEW/PX1ttVeq24T839Y
	 RlnO9CF0a06KQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E86ABF4008C;
	Mon, 30 Mar 2026 15:04:50 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 15:04:51 -0400
X-ME-Sender: <xms:UsnKaXdYxenmMpYB7TYn6Kma_qM-IO80LS8OWsomkiCIhtKeZ_ix_w>
    <xme:UsnKaYBoxHHybJANa8WQo502ZkIbehsUglx9dxCJ9gJYPxHMzWYlIHIB2Ep3JNaTl
    bUkuTDI3ze1AHkU38CHhJcotAKKir050STtdsS7nVWtgCc_9edM85nR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghirhgvsegunhgvghdrtg
    homhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehnvghilhgssehofihnmhgrihhlrdhnvghtpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:UsnKae56lunAkIOxPbYHVilHFgKh_ZfHrpNjCqx_1E8gESLVZ0z6bA>
    <xmx:UsnKac3geGwCKYV8aMNFQ4VpKFYZy75iJIuT9skONkDK-tlpOcuJfw>
    <xmx:UsnKaRsV7E3Zpo_CIQbqe3TzjcNkbyb1LJZCmBPdfmIF6cnc9ponng>
    <xmx:UsnKaa70ADnLjPlzWwHehPM_b3ldCGbNN1c8YunJTSkJsncnGQueAQ>
    <xmx:UsnKaVd-q15lfgdELDmJx0RWvdm6k76b6wHB_F-FJcklbgVOf1_P38CY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BF646780075; Mon, 30 Mar 2026 15:04:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APSc37mEaDqJ
Date: Mon, 30 Mar 2026 15:04:30 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Daire Byrne" <daire@dneg.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <f3e70f87-df09-4c3d-8995-ced68a028ed8@app.fastmail.com>
In-Reply-To: <acrHmvgWjJijCo1U@kernel.org>
References: <20260205155729.6841-1-cel@kernel.org>
 <acrHmvgWjJijCo1U@kernel.org>
Subject: Re: [RFC PATCH 0/7] sunrpc: Reduce lock contention for NFSD TCP sockets
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,dneg.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20539-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ADC963602E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Mar 30, 2026, at 2:57 PM, Mike Snitzer wrote:
> Hi Chuck,
>
> On Thu, Feb 05, 2026 at 10:57:22AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> High-throughput NFSD workloads exhibit significant lock contention on
>> TCP connections. Worker threads compete for the socket lock during
>> receives and serialize on xpt_mutex during sends, limiting scalability.
>> 
>> This series addresses both paths:
>> 
>>  - Receive: A dedicated kernel thread per TCP connection owns all
>>    sock_recvmsg() calls and queues complete RPC messages for workers
>>    via lock-free llist. This eliminates socket lock contention among
>>    workers.
>> 
>>  - Transmit: Flat combining allows one thread to send on behalf of
>>    multiple waiters. Threads enqueue requests; the mutex holder
>>    ("combiner") processes the batch, amortizing lock acquisition and
>>    enabling TCP segment coalescing via MSG_MORE.
>> 
>> Supporting changes include a workqueue affinity fix for single-LLC
>> systems, a page recycling pool for receive buffers, and explicit TCP
>> buffer sizing for high bandwidth-delay product networks.
>> 
>> Base commit: v6.19-rc8
>> 
>> ---
>> 
>> Chuck Lever (7):
>>   workqueue: Automatic affinity scope fallback for single-pod topologies
>>   sunrpc: split svc_data_ready into protocol-specific callbacks
>>   sunrpc: add per-transport page recycling pool
>>   sunrpc: add dedicated TCP receiver thread
>>   sunrpc: implement flat combining for TCP socket sends
>>   sunrpc: unify fore and backchannel server TCP send paths
>>   SUNRPC: Set explicit TCP socket buffer sizes for NFSD
>
> Curious to know your thinking on this patchset?  Can you post v2 given
> your note about having adapted based on Tejun's feedback here?
>
> https://lore.kernel.org/linux-nfs/af3a034c-4829-469d-b55d-9414409ee425@app.fastmail.com/

The workqueue-related patch is not important for the server,
it turns out, but I've adapted it for use on the client.

Regarding the series you listed above:

One reviewer balked at the idea of starting a kthread per
connection on the server. I've reworked the receive side
to use ->read_sock instead of ->recvmsg.

The flat combining changes on the send side are still good.
One further optimization was to replace xpt_mutex with an
llist queuing mechanism.

A number of other improvements are in the pipeline ahead
of or behind these two.


-- 
Chuck Lever

