Return-Path: <linux-nfs+bounces-22205-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SCFRCbAAH2oQcwAAu9opvQ
	(envelope-from <linux-nfs+bounces-22205-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:11:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303063016F
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CojUq1mV;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22205-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22205-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3426F3007E08
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70123F39C7;
	Tue,  2 Jun 2026 16:00:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F653F23B5
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jun 2026 16:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416011; cv=none; b=A7+nqn5Ud4TevHKoT1XXVWAhgAtryWrivGC/ub/9/M5FGhL0uPROFNaRC7i2BA4vGnawUZaTISyymXeUpCyEgfv9V4mxs8PxAQUaNxQUiDMl/R6SwTMrRR6J1u3HMMrJx797QcO4bWLPsaogY+4Lw4hj1DvnlpkGOyPcLbVbgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416011; c=relaxed/simple;
	bh=57rMn/0EZ3x6IXyJimA+fwdGVCPxwuCpwKe+xk5jTic=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sI7wZSwz8hCG4UnGTYuGI5K9RSwCN5euzH7Le9FsOnLK9WS02lRCYmUgCZTsncEZX9yPOL1ourSDugrE752CQQzVQKV7brzR5ufqwQ1Apudmwk8s/SuFu80VM2+4kBRkGPQ0w4sMdvNSTJpmuTDle8SyhYh4RJHbNIejcXsAtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CojUq1mV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B481F00899;
	Tue,  2 Jun 2026 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780416010;
	bh=BEHR8ze24SyZJBrL1pA7nVPYf7sE8uNT00yc/6Gx19o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CojUq1mVGUp6wqJ2ttixTPGTOYnWhWMNoM+huAKdaP5KXgSSRV/HOnQsrKa0r0ubz
	 g/2fqYzzlKyWbjbezvGSOBuU7/lxahMrHEVMNYJsXbQRAqwj/Z+DIfypXt048ajcZG
	 qnQPXwjm8X8cwlvY2UinsG6WYYEyyJ783c5U8f0tzwRiAOdu446yy3dMNcdx/QssZE
	 iOIRi/V/zZThP2XgMz/I6c6M4yJA+U9mUaBVVEcpf7xunhWTAmYMNf0GM1HD9z+DrH
	 qSGRxBkJZ/BlhOtl9pkpNNB+qdn/SXKUuDOEl0KcKqih2510Z1gGie3PJUVVkQLYsA
	 YIBJXkU195TFQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 22AB9F4007A;
	Tue,  2 Jun 2026 12:00:09 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 12:00:09 -0400
X-ME-Sender: <xms:Cf4eah_qjOjVGbuwT-rEA174_Q3PuLWOt4GGI8MGdr_lWh61QwKd4A>
    <xme:Cf4eaghdejCN7yO_W_ZRNUkPSvgGOT_b69PUk5Hc5TTcKAHgU5UNL5HeTEx7BpZrM
    zTlMKBFJpEzRTnIg1PcyyZLLkE1KpgqzRovdZwwMfm5dkOWYU1bPgs>
X-ME-Proxy-Cause: dmFkZTFaGV8MzM3OJKc+HfmPXv6Se7zjc5Ynp8Pd6ghhePPJRXILF2eVF1nSaX1FFXfMxi
    1R/IF74U5ktSjYatvoG9d9aYv+ygG7uGnGxSQqMWGdoA/XTf3DFUz6CfNZK4d3zrjixBLa
    9R5xzpbs1btp30XZPGwXMXS3xgAcGNY+FleezIlX5OWk8fsw1wMSJxdMUEkktp9TkzqNJ8
    mxcPQYhBaQhxHqn0LAOIOjuNUDqv3vlAY66xMzWJuCBboBnu5rC9onQhE0pV1fkn5Dh8U2
    46E0f2QevnkkwE+yzm+zyzucdHmIaG9K9RgPMcXOlFgMa2F6MvSJID6pYUhdkwTB3qpDG1
    oAazJMUlTaaVKl8sxG7uHHlIvoSX5oMv2EW2GndySbUlyD934Tu1jcEjZH5NBJWkIKZGS/
    wHNACIzzhtZlTGJc5wtrIY2b6FwAW+yhzwwvqCFdc69yU+ArdXwml3w0m0MEjawpq8jYgE
    9Or6jlOUyxlswpCvv+SztXm/EjsErguJ71q1vocKK979uprbTzTyD6lS+Ae3zHW9RN3/RZ
    sjuVW8VpjHDwIcqMNcx8+8pE/fEg1JO8dg5GXduJrEiMBuo3VFXGXe9uTLmy3K3Zz6IR7h
    3TC46Ji+hXjHaw/D0VoojPnwV5h7uJNxz2kO1TZ6WCg8Melgw9lOoUbYFmBw
X-ME-Proxy: <xmx:Cf4eavf683o93XKwkU9zSST1WBWw-6xmZ08gYsVKJHGoqSgol716rw>
    <xmx:Cf4eahiPkchKnHCwgspAUNjXLrBj0VLtVklYiPXe--dKo7VHI7GNoA>
    <xmx:Cf4eaqIfn6BrCf0ME0rILzcS4ye82f2rBEF2NlHQNrdQTXuEvi7OIA>
    <xmx:Cf4eauHCyEgxqXb1WG6JEYpbO-FPdtyOabt0DCxDsMbxhUpo_1j8xQ>
    <xmx:Cf4eag283uQ7pCv8RNK_uF5sjkZqK8v3AlNW2HgrVVqNeel9fnukgUiz>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1A14B6006F; Tue,  2 Jun 2026 12:00:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA_jvV1aNDqJ
Date: Tue, 02 Jun 2026 11:59:47 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Hongling Zeng" <zenghongling@kylinos.cn>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, zhongling0719@126.com,
 stable@vger.kernel.org
Message-Id: <c3dc789b-c8c0-43e6-ae8d-615c932f4fa1@app.fastmail.com>
In-Reply-To: <20260602083205.183807-1-zenghongling@kylinos.cn>
References: <20260602083205.183807-1-zenghongling@kylinos.cn>
Subject: Re: [PATCH] sunrpc: fix uninitialized xprt_create_args structure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22205-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:zhongling0719@126.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6303063016F

Hi Hongling,

Thanks for the patch!

On Tue, Jun 2, 2026, at 4:32 AM, Hongling Zeng wrote:
> The xprt_create_args structure is allocated on the stack without
> initialization in rpc_sysfs_xprt_switch_add_xprt_store(). While some
> fields are manually populated, critical fields like srcaddr, bc_xps,
> and flags contain uninitialized stack garbage.
>
> This can lead to:
> 1. Kernel panic when xs_setup_xprt() dereferences garbage srcaddr
> 2. Information leak if srcaddr points to sensitive stack data
> 3. Unpredictable behavior if flags has random bits set

I took a look through the transport setup function to see what they
do when these fields are set to NULL, and it looks like thy do their
best to choose a default value which might be different than the
values set to the original transport that we are trying to clone.

Can we instead set the missing fields in the xprt_create_args based
on how the main xprt is configured?

Thanks,
Anna

>
> The fix is to zero-initialize the structure to ensure all unused
> fields are NULL/0, preventing the transport setup code from acting
> on garbage data.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  net/sunrpc/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index a90480f80154..0a99d0f1eb4c 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -333,6 +333,7 @@ static ssize_t 
> rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
>  	if (!xprt_switch)
>  		return 0;
> 
> +	memset(&xprt_create_args, 0, sizeof(xprt_create_args));
>  	xprt = rpc_xprt_switch_get_main_xprt(xprt_switch);
>  	if (!xprt)
>  		goto out;
> -- 
> 2.25.1

