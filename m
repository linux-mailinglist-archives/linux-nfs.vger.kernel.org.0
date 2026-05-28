Return-Path: <linux-nfs+bounces-22039-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKfQNtZ/GGpBkggAu9opvQ
	(envelope-from <linux-nfs+bounces-22039-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:48:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6655F5E01
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDB9D30B8340
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604F3FD95E;
	Thu, 28 May 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcfRb1uo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D53FCB05
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989851; cv=none; b=kR+wMYb+UrlshbjczcM0ksA2vYIVAWhmYWhiIftWK0ui/2wnlMTLFqNcCkUYbtWbOKWo/Hhe5x86v55hpRLiN57uBOtes2+uNYgcYqYTHyPkB7OBAfETAAYvdmmfvEkuxX/PhuDsFo0+PqW9DcnZlqbnQ4LmHdBE3ihJDJPCuag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989851; c=relaxed/simple;
	bh=c1K1y6gLLxtbnzwbwcbUWDPtbmEZJlvA6I3m0vyeHbk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UsijJq9ouWmPCH5RG6AdZ/q9EAXpn603beb+bqlPD2qfOJ3mQAm2tdrRsLgf3Ln1Vs9sV6UBn/N3pyv52+VKqQEuAoWW4SkXjF2FlWuIHCViUphPx3Gse5uVrEaJIHrTcZQa83/QIMwisLJqTWSTylDUTh7kKMQ0J6ivQcDJd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcfRb1uo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998831F00A3A;
	Thu, 28 May 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989849;
	bh=P7Srh6JxWVieDvkofrv7DpZzFh3h1DNGMj6JkUzKEEk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=AcfRb1uoWJOj0AvStuaNEBBio+jSsiyngiBiObHiOhVp1Bz2OjPvMqW0jDV2kvOkF
	 1pVanMjCLD0cSyXSQ0RqeHSI3rW0v22Sw1dJFpJYovTShLPCKhloKfNu+ZudBE157o
	 KD/R4pc9iXtjwyhoYxEfZwxgyDVCUQ62gov54OQVV5mjr8EZnjFKHve/cNo8LLig0q
	 zcAxkXIuzVgInBlHLNs5C0Xa4vI8GgnF+EYSg7rofeH0bjwoXlU8Q1GaFWEzd/xbu6
	 E/05ClZn8OqyJm7F4E091EExsl3vtsRPvLgGfKmA0E1O5Z4vb0Jv/Tj42rljJSK++B
	 8QYJTaHxtdxrg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BBD70F40085;
	Thu, 28 May 2026 13:37:28 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 28 May 2026 13:37:28 -0400
X-ME-Sender: <xms:WH0YalAZ2yr2aJzfToxxGZ1JyoHHQ0syVgoi6uPNjyI356fAMKfqhA>
    <xme:WH0YauV6VqmB2QK1fmNq1OfW0SRmjcpwJzW6O_l6t2tb9PW80F7YFj74cSST9ykKc
    UdBaP1PvDpvsQCH31O_uiZ0zyEDk4Z1yN81Umuafe4JDGZkbskVuS8>
X-ME-Proxy-Cause: dmFkZTFdrySEVwiXQAm8a3BovyT8ZpOwSaBWEWIlJtGjqV3l+l1T3l5QIS98QCJD8MPgoE
    cLxPCeccyTyn6e/SyX14wTHVlJ1w7+fAQZK+kz8eV3BgZtm4IkQjURDKpD6odR5lbfBOi5
    PVfUFAHT8Bi/EHfs4U4TLtJsuKqQxQpneu+T10O95Au7NOESVoWy/MO/HIIll67PRNaqKN
    hr0wg979K2BF9iAvURHIN84j9cz8HJDQPkwCtsylFemjF1LtaOsX4PcHp8HOyDKrchzyti
    X3uHfwyd4owrf5DXdVOaMPPN5DcckpWiUBy+lF6NOm5Have6c4K5R0OlhmWt7jDZ+7fEK7
    Cgen/s1xclaM7UYD3GEA4EQ8e8oD+mHyPYsNYiFEbYe0411ZQO8i3nr3NrQzQPn8yfMwCL
    cwZa2T05sZtcIbKDs3rtNYyUKMncBHF3464ItVDfK0xZbgDjMGLdX5SAWCsJ8qnPDyhCWl
    3cVxGoMIgSWaf89bricaFlyCtgSUE+S0UwoeOFMZtZNPFyDoQJRgGw460Vm5YBpwYMQYT4
    CHM+eAfP/0XAKGU92UTS/rGRdtUJ+UdROav24HAUehZUAm21TZKMnNkCQeUO6N/8A2ijX/
    5U3EFn8r/B4Eg9gD037se6NFGOUDurBCMnwDIsRbOlEjR5YSq0e9cdfc1W9A
X-ME-Proxy: <xmx:WH0YaqB674MQ3lgcfJ-I6czvxwArLRPDpOp4ZtHSQp3vFfOY8bTKJw>
    <xmx:WH0Yagj0WgHb91ibl1eLS13LkDhU298iUctZhXUd9xwQqWwdXOlFJQ>
    <xmx:WH0YavxnHLVUlkRfo1vjgdccgGhoeGutPxBJ3whd9S4ALjqjKi9SWg>
    <xmx:WH0Yap2OiDmH3KsaSKyjPOa0H2c54HKYgEysuNqWzXipbnBIGz2S8g>
    <xmx:WH0Yas-bH1XSujdjj4gKDT25DcarbQ9z9Wk35qzNBIvmPCs8Pfm9VrIG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 97E20780092; Thu, 28 May 2026 13:37:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-V76fb2Vfz7
Date: Thu, 28 May 2026 13:37:08 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Farhad Alemi" <farhad.alemi@berkeley.edu>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3b7cc21f-34e2-4752-8dc6-14abab41e955@app.fastmail.com>
In-Reply-To: 
 <CA+0ovCgab7F-y5ev3jz+4dDOv_e9XyVNb0GUJpWvVjOLiUeZPg@mail.gmail.com>
References: 
 <CA+0ovCgab7F-y5ev3jz+4dDOv_e9XyVNb0GUJpWvVjOLiUeZPg@mail.gmail.com>
Subject: Re: [BUG] sunrpc: cache_seq_start_rcu() slab-out-of-bounds (unpriv-userns
 reachable)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22039-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DD6655F5E01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 12:53 PM, Farhad Alemi wrote:
> Hello Chuck and the linux-nfs team,
>
> I am reporting a sunrpc cache slab-out-of-bounds read found by syzkaller.
> Flagging up front because the read site is reachable from an unprivileged
> user via unshare(CLONE_NEWUSER|CLONE_NEWNET) on distros that enable
> unprivileged user-namespace creation by default.
>
> Summary:
> A read(2) on any sunrpc-cache seq_file (e.g. the nfsd virtual
> filesystem's /exports, or /proc/net/rpc/<cache>/content) drives
> cache_seq_start_rcu() -> __cache_seq_start() at net/sunrpc/cache.c:1351.
> After the iterator walks all hash buckets, __cache_seq_start writes back
> *pos = ((long long)cd->hash_size << 32) + 1 (the literal final-line
> assignment in the function). The next read re-enters __cache_seq_start
> with that *pos, decodes hash = cd->hash_size, and the very first
> hlist_for_each_entry_rcu() walks &cd->hash_table[hash] one element past
> the array end. The existing "while (!ch && ++hash < cd->hash_size)"
> check only guards later iterations within the function, not the entry
> hlist_for_each_entry_rcu().
>
> The KASAN-reported 2K allocation is cd->hash_table allocated by
> kzalloc_objs(struct hlist_head, cd->hash_size) in cache_create_net() at
> net/sunrpc/cache.c:1733; struct cache_detail itself is a separate,
> smaller kmemdup at line 1729. The 8-byte OOB read at the right edge of
> the 2048-byte region reads hash_table[cd->hash_size] -- one struct
> hlist_head past the end of the table.
>
> Observed on:
> - Linux v7.1-rc3-200-g70eda68668d1-dirty, x86_64, QEMU Q35
> - KASAN enabled; panic_on_warn set
> - The only local dirty file in my tree is drivers/tty/serial/serial_core.c,
>   containing a local ttyS0 console guard for the fuzzing harness. It is
>   unrelated to net/sunrpc/.
> - __cache_seq_start() at net/sunrpc/cache.c:1351 still walks
>   &cd->hash_table[hash] without bounding the decoded hash against
>   cd->hash_size before the first iteration; bug remains reachable on
>   current mainline.

Hi Farhad -

Your report appears to be an independent rediscovery of a bug syzbot
already reported and which we've already fixed. The fix was pushed
this week to Linus for merge into v7.1-rc5.

Your novelty check noted that you searched the syzbot dashboard but
did not find a match. See syzbot instance ID 60cfa08822470bbebe44.


-- 
Chuck Lever

