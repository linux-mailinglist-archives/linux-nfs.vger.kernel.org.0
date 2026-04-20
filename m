Return-Path: <linux-nfs+bounces-20975-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLnAOr+c5ml8ywEAu9opvQ
	(envelope-from <linux-nfs+bounces-20975-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 23:38:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B632434407
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 23:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6409301D324
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068252D9EC2;
	Mon, 20 Apr 2026 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="pvuIBt0x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1537B00C
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720739; cv=pass; b=rgJdETIL70UOurVyN4tpHgxvprMBQ15SfzohTW+/aHAmkZrwlihGChDz65Ce1tBMs1aTfGeovf3LuRltC6yLDHcoqmvghEICWDwrJUIV8CIyYvbr1qLcoGO66He9GDgtzXgoSyCNjl7Skq9dAv23uDNXgLsBtvGtI6VypLt/9Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720739; c=relaxed/simple;
	bh=UzR+RObfSNeljF8COnAwIKVI8UrR0NYxWx3EZ42JR/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ejjq1gE1OzTVc8pUSGLPweiRLTx2oYlExQzLgtIfmK8AjP+SBCbUoRNz1mL/h1TgAO7ErAgfR2z9zrCMWezpI/ETPi/yRRDtwIYR87y89L77V32uJvW2dcoNtvOOAV9Zf/9DERo7CmeQnZRjJlyGDOH+NXETKpD6EbYKbV8HR3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=fail smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=pvuIBt0x; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8AF0A3E1A63
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 21:26:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.96.238.10])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 43D873E132C
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 21:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1776720379;
	b=WcI54tD0r2YFHcEbCgpRBciBZ9RjroBG2kmbCKHGL5KLV4RUmVLdt+0VACs+bnskXsjlvf
	v5j3kGCNAdvbv3M/6EolLaJxhPcMhkyzbdJ6DBC7UXnT02wD5EDTLL3cH6Z11Bh7IQdIhT
	Q7HQTk0R31tkbsVS6MG/mZqvWyw7zmBoBz0JSI2fXZDO32VNz+2mBEWOCySfIMXltTPmdt
	b2TYBKZuQ/ZOIgoEjHiW4WRe5z1lQjABaAKtAvjiaY4LgrGLaKB3Ud82pRTemRy3lc5grm
	SEDL0NhNf/dne1NhemzWb7ci5dej4OsiHz48O4IwiNtO90wtUmODuioahZ/clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1776720379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BHDmxeL2DA3VqCPf5MPJyBo4SUVpFll+6pgerXytqVk=;
	b=dNtm+2BqeVXZKZgJ4q8M4LEl9sIpj4ChvsFV/rG/N+XEv+MmOrwZSozYTzDJWd3ZxIFstA
	bOQOyS1hlX9vuG8A5p/QVIuSqqspJEbj5kTzUJ/1wlrVSkbRZFO55tGMoa7ZLseJrzw1/d
	FMXy5yfccUEe2NZsLC/PqWBr6cCLMV7KX1xzwBTL4gHYHzx6IZnE8x0AcNOjUEVQFxS9aj
	7lLfEeUrrzcwWNyAbMFi8nH8LgzCmGbLdl0mYxB+plYSDJmAAEuvYUF4ogvHE9izNGis5E
	HbsUvWZVT+A09XAQq8iXStQ1HV/0Khz6LEm16fTQF2D+sMZrHVY5hbs2s0DJtQ==
ARC-Authentication-Results: i=1;
	rspamd-97d8f7d55-g4klh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Ski: 4c1b3f845451137d_1776720379476_2305564884
X-MC-Loop-Signature: 1776720379476:2070835156
X-MC-Ingress-Time: 1776720379475
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.238.10 (trex/7.1.5);
	Mon, 20 Apr 2026 21:26:19 +0000
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4fzz7b11mbz105K
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1776720379;
	bh=BHDmxeL2DA3VqCPf5MPJyBo4SUVpFll+6pgerXytqVk=;
	h=From:Date:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=pvuIBt0xEAmWtGtS9JqoJT6E4D3FaXYKKAUqlNEEAz/ZtfCAjZXbF4idS6ZZN5Lwp
	 z9SM6+6+f+BS22Dx/nHyOpj5xnntvfH400ag3+xCCu7wSjHvAKJDg3Zaz3WWfSxacT
	 bvVqIGVSKveOuQso6YzDfjSloVbwDVgswjV1l1NvB/IWKYM0UURqwOqpLynBXxOOkt
	 xs08HnVV6BDSLdeUPGprd8z2VhpCgpEqDrGhJLBxFbe/wlUverCUg9HMRRR+kipBGY
	 p5kVW4XsZkRWvgZE/duV0F1mSoR+tBX3alsNSUl8okhOwLpcjhKx6N5JFi6ga1bVlH
	 RYqsCQfxD52xg==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso11780355e9.1
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 14:26:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZ2FW91syLxZf7yXeH5PwxwD+QY6T6spSChQqhmCq5El2qV/NO
	i3xDzv4SXKwIXk0MzBUziCLrVzbf7LG9X9rQtxEsmsfD0WeeqgE0RN0cbe9yR1d775q9an7G6C9
	rZ2ITPc4kgUEqbD3VgWuQTRuAmm2nE4o=
X-Received: by 2002:a05:600d:84ca:10b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-488fb796fabmr139061155e9.26.1776720377571; Mon, 20 Apr 2026
 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153830.463215-1-cel@kernel.org>
In-Reply-To: <20260420153830.463215-1-cel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 20 Apr 2026 23:25:39 +0200
X-Gmail-Original-Message-ID: <CAKAoaQnN16S6Lh0sgCXF7bLB6sxTSxqCjr-RNt69f6YWyiv6iQ@mail.gmail.com>
X-Gm-Features: AQROBzAYt3Om4rHfD9zizdOdbsJc_0b41VsgjKX8xZC8qMl9OyYBTkenSN5Utmg
Message-ID: <CAKAoaQnN16S6Lh0sgCXF7bLB6sxTSxqCjr-RNt69f6YWyiv6iQ@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Increase the default max_block_size to 4MB
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[nrubsig.org:s=dreamhost];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	TAGGED_FROM(0.00)[bounces-20975-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nrubsig.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[nrubsig.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roland.mainz@nrubsig.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[64.90.62.162:received,23.83.209.14:received,100.96.238.10:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4B632434407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 5:38=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Commit 8a81f16de64f ("NFSD: Add a "default" block size") introduced
> NFSSVC_DEFBLKSIZE at 1MB, well below the 4MB NFSSVC_MAXBLKSIZE
> ceiling, with the stated intent that a later change would raise the
> default.
>
> Raising the default reduces per-RPC overhead on fast networks by
> amortizing header processing and scheduling costs across larger
> payloads. The halving loop in nfsd_get_default_max_blksize()
> constrains the returned value to 1/4096 of available RAM, so the
> new 4MB default takes effect only on systems with at least 16GB of
> RAM. Smaller machines continue to receive the same computed value
> as before. Administrators can still override the computed value
> through /proc/fs/nfsd/max_block_size.
>
> On systems where the new default takes effect,
> svc_sock_setbufsize() sizes each service socket's send and receive
> buffers as nreqs * max_mesg * 2. Quadrupling max_mesg therefore
> quadruples the per-socket buffer reservation at a fixed thread
> count, which operators tuning large thread pools should account
> for.
>
> Note well: Your NFS client implementation must support large read
> and write size settings to benefit from this change.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsd.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index a01d70953358..daa63c1b161c 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -45,11 +45,10 @@ bool nfsd_support_version(int vers);
>
>  /*
>   * Default and maximum payload size (NFS READ or WRITE), in bytes.
> - * The default is historical, and the maximum is an implementation
> - * limit.
> + * The maximum is an implementation limit.
>   */
>  enum {
> -       NFSSVC_DEFBLKSIZE       =3D 1 * 1024 * 1024,
> +       NFSSVC_DEFBLKSIZE       =3D 4 * 1024 * 1024,
>         NFSSVC_MAXBLKSIZE       =3D RPCSVC_MAXPAYLOAD,
>  };

Works with ms-nfs41-client.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

