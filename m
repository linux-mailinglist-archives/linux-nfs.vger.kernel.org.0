Return-Path: <linux-nfs+bounces-20170-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MExJMDmDtWkr1QAAu9opvQ
	(envelope-from <linux-nfs+bounces-20170-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 16:48:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06628DBE7
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 16:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA7223012202
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54071A9FAF;
	Sat, 14 Mar 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL6R+i0S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC38C1F
	for <linux-nfs@vger.kernel.org>; Sat, 14 Mar 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773503286; cv=none; b=Mq2Ga6DuQKu/QOptMn1goqZMDWK2N1Q1gOHklPTFKkOGrrWQsLAezlMtH9oi+nuA6ebkw5uXk8y37VD4EdkouVWNSX01bT7B71tEBpqv9GbTZw3qqdsd+ue+CvOYL8BCgUfTYoccurSl03Y5j4V9AgKS0/tgvUv8RFJaYU2hjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773503286; c=relaxed/simple;
	bh=Rta8eUwUfkXoye+FzUv26CQyJXngJEr88sT+ogFsIVs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e9gdIA0/nJhu0iVgBsadv2MsZCJQ/MPKlfCc7Aq7yLgHN+JxiLChlBJaR/HUzujaLqEtIOgZJPQEyb8SFOW7yeLPuPZC8nBRHCFh4ZPh6lKF+4MCJ63RT0jVGK1dgJGy6vLVehLBPLyJ1BJUEN37DalLQlxwj8BH2wRIBITAK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL6R+i0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E23C4AF09;
	Sat, 14 Mar 2026 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773503286;
	bh=Rta8eUwUfkXoye+FzUv26CQyJXngJEr88sT+ogFsIVs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PL6R+i0SJEDRz3YocYQbgS6+2OCyXbwlHMRWY/Kmg9JjPPZLtUsCo+t0DMRX+pYn3
	 tnaBqaBxOYwZXmnBry9tU3wUbYRji+N7jrIbJZ4W882ihCCznGM5FuCbEZh+VpvAA5
	 Wy/9wSihmVb0afbn8p8lGVA9Qy914u84J2ZZ12QHqztoeiD8XNmVPvDTczNUZFsuHZ
	 vx4Xx8Vqg/sbZ1hR9ux4rCRGSBj8ach0NMGZPKGAkhyj3y70WpWSfV7TIeFxzdhSdT
	 w1zu82pcuw0q07hVhj7EZK9zA8I/h3c6T+n+frO5oMIBJlBfMzzjbgk+yrOEnImmru
	 6tYPpUH8JqXRg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E1827F40068;
	Sat, 14 Mar 2026 11:48:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 14 Mar 2026 11:48:04 -0400
X-ME-Sender: <xms:NIO1aVadMMYdLkFdVTfcVvc8fp77LBZyKjs-Jp2Wp3vArUVWiRiYag>
    <xme:NIO1aXMV5YpTsb0qOexN3ZtLgh19iePTofY9fC5Lp9oXTnpz4VPU9zroYN3uf_mDy
    4siCkUl3w1K9Wi32-ZZcOciJ1Vgl8-R7JsELzAx8F8KDasU0wN5DkNW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnh
    hgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhgvihhlsgesohifnhhmrghilhdr
    nhgvthdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NIO1adEZJ1vjD68macLinUxBBWs74o93VrbJvst4-Ew9seDcZVHU2A>
    <xmx:NIO1abozcd93XhAWwC5aDBfxgYxtzfFfaLpLlJQVbZWgW5-UBYh8eg>
    <xmx:NIO1aWbxmTnZVGEX-Z2cxq6Sty72YAT4i5AHjs17NUfz6MS2iqdB6g>
    <xmx:NIO1aUWLpWKMnxNpV7IqQvDSwrwKetziCD7cmmk3vgvQcN2rjtUlnQ>
    <xmx:NIO1af_AQANyIce9u2FYHZJWyNDT0yPu7O0OdvxWvH_OXX4G4UfIuMm9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0B77780075; Sat, 14 Mar 2026 11:48:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aa6hBl78K8EV
Date: Sat, 14 Mar 2026 11:47:44 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <e4a646d0-a916-419d-a78e-1a89977141a1@app.fastmail.com>
In-Reply-To: <5df3076a22438f5be6b070e62c0d3fc567341b20.camel@kernel.org>
References: <20260313163148.281676-1-cel@kernel.org>
 <20260313163148.281676-3-cel@kernel.org>
 <5df3076a22438f5be6b070e62c0d3fc567341b20.camel@kernel.org>
Subject: Re: [PATCH v7 2/2] NFSD: convert callback RPC program to per-net namespace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20170-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E06628DBE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Sat, Mar 14, 2026, at 8:04 AM, Jeff Layton wrote:
> On Fri, 2026-03-13 at 12:31 -0400, Chuck Lever wrote:
>> From: Dai Ngo <dai.ngo@oracle.com>
>> 
>> The callback channel's rpc_program, rpc_version, rpc_stat,
>> and per-procedure counts are declared as file-scope statics in
>> nfs4callback.c, shared across all network namespaces.
>> Forechannel RPC statistics are already maintained per-netns
>> (via nfsd_svcstats in struct nfsd_net); the backchannel
>> has no such separation. When backchannel statistics are
>> eventually surfaced to userspace, the global counters would
>> expose cross-namespace data.
>> 
>> Allocate per-netns copies of these structures through a new
>> opaque struct nfsd_net_cb, managed by nfsd_net_cb_init()
>> and nfsd_net_cb_shutdown(). The struct definition is private
>> to nfs4callback.c; struct nfsd_net holds only a pointer.
>> 
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/netns.h        |   3 ++
>>  fs/nfsd/nfs4callback.c | 111 ++++++++++++++++++++++++++++-------------
>>  fs/nfsd/nfsctl.c       |   5 ++
>>  fs/nfsd/state.h        |   9 ++++
>>  4 files changed, 94 insertions(+), 34 deletions(-)
>> 
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 6ad3fe5d7e12..27da1a3edacb 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -25,6 +25,7 @@
>>  #define SESSION_HASH_SIZE	512
>>  
>>  struct cld_net;
>> +struct nfsd_net_cb;
>>  struct nfsd4_client_tracking_ops;
>>  
>>  enum {
>> @@ -228,6 +229,8 @@ struct nfsd_net {
>>  	struct list_head	local_clients;
>>  #endif
>>  	siphash_key_t		*fh_key;
>> +
>> +	struct nfsd_net_cb	*nfsd_cb;
>
> Given that there will only ever be one nfsd_cb per net, why not just
> embed this struct inside the nfsd_net instead of doing a separate
> allocation?

The reason I did this is because otherwise netns.h would need
to have knowledge of the details of the NFSv4 callback program.
Things like the NFSv4 callback program's RPC program number
are implementation-defined...

I'm avoiding a weak layering violation by hiding those details
behind a pointer.


-- 
Chuck Lever

