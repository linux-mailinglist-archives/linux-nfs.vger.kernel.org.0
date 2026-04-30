Return-Path: <linux-nfs+bounces-21300-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMzANmFb82lfzwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21300-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:38:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B04A391C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98A63009007
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C501421F01;
	Thu, 30 Apr 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9cR27Gz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E5425CD5;
	Thu, 30 Apr 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556317; cv=none; b=DYBHfSIAA1X3u9wNazGjtGYS4hdCzF4Uefr1dpBT+6Ce4VWEas3tn1eR0SZotYbzB6E7mgsS5Z1dNEiw0cijXFu07cjU5Mhb4e7pKGA0tzwml33wo8M5j8OFnau4uHXpiqqpmHtuGg07WhB7jBF2f+1H9gNOwmHNzmQFf+1eUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556317; c=relaxed/simple;
	bh=JO+8obeirInH0eSNTrpSn62OIOprwjzghCneErFnGzE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cg0oGuBNMs2Jq0/DE2spXVpPpBEKcMBG8ZiWv+8eYLmhRxmT8mmwoE5HtDSirjSZnPvJEqO7/glfvgRZdStjWozMpbB5ZN5Tk8lX+jsBIP94n+3aiAw7BTp4B1f9RCAOAqNy44dl6OmQIaz1GUcUJZ7UuwqBIG+gIbMIqQZQIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9cR27Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E032AC2BCB8;
	Thu, 30 Apr 2026 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777556317;
	bh=JO+8obeirInH0eSNTrpSn62OIOprwjzghCneErFnGzE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r9cR27Gz77DrkLbdQ9m/OXSE77wP7cWjrs6gdD2IthGZnYkSPG2Rq/7HGKd4M74Hr
	 Jhj2zmka/PQ9zc2RV0353uPOwPa6TvHL/MaFTh4N5hwEMdh3vaRoaiveX+BykjuAt/
	 vo92aQZ4mFd/pXQbSE9/AioEzhtf/HJI6K1/YHOoQUtiOffLEP7+0eIzlnJhTKfGSK
	 NGJ5zg5ecMwHkU+JqpV1O/0D4Yk1cas/PhE8lcuqO7Yz1uzK7lemrNkql45FCzMY1Y
	 ByTbeuTba18qfownIMoHflcOkxlpxeCdV39Z+fqzcpLBJYxCVzMWgknaV5OGhcj+oP
	 xQBYdOfwYpN7Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02497F4007C;
	Thu, 30 Apr 2026 09:38:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 30 Apr 2026 09:38:36 -0400
X-ME-Sender: <xms:W1vzae8uRJExJTcy3BTo9OIDX_Z1jZu96xvJOxnzUDbRsKIbGIzJUw>
    <xme:W1vzaZiJFX7Qw5vwLomBJZAr4nM0I68dMwec-5XZFPbQvzCkaVlpc5x3EQyLhxcjL
    CuCqpyitjaPRPLJmNLqM8Z1-_eeor1eP7DcV9UhOFpUmIxeSqD8o2jZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehkvghrnhgvlhdqth
    hlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsmhgrhi
    hhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W1vzadILAsVEPTaIGaAf7tK0ObJwZ7OiUoXsV7HmMoaKGZaHTkBXUg>
    <xmx:W1vzaSEOEr5t5pgBP34elxD9-NeIOe_vT9YayNarabjdUP314hZ7QQ>
    <xmx:W1vzaRTyBiFkG638Z-ntoOfpw6aUYCgCEIL3W84WSsuvVCPGw2UqyA>
    <xmx:W1vzaedLVMfQbAphVV6MEoHW1ZXdoUxgAps1qBYrj5xhN3i_A7ve8g>
    <xmx:W1vzaQo2zS4aJ1sUfYbQd2tPEYsXeJdaIEtU2yUK3SrLT2relD-5Ivj3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8DF4780070; Thu, 30 Apr 2026 09:38:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak5ktnwSWV1c
Date: Thu, 30 Apr 2026 09:38:15 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Scott Mayhew" <smayhew@redhat.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
Message-Id: <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
In-Reply-To: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
Subject: Re: Breakage in ktls-utils with nfs keyring?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 598B04A391C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21300-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

Cc'ing the ktls-utils development list.

On Thu, Apr 30, 2026, at 9:32 AM, Sagi Grimberg wrote:
> Hey Chuck,
>
> Upstream ktls-utils fails passing client certificate and private key=20
> using the .nfs keyring.
> Bisecting leads commit facd084e43fc ("tlshd: Client-side dual=20
> certificate support").
>
> I manually apply this (probably wrong) change and keyring works:
> --
> diff --git a/src/tlshd/client.c b/src/tlshd/client.c
> index 2664ffb..a946797 100644
> --- a/src/tlshd/client.c
> +++ b/src/tlshd/client.c
> @@ -327,7 +327,7 @@ tlshd_x509_retrieve_key_cb(gnutls_session_t sessio=
n,
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlshd_log_deb=
ug("%s: Selecting x509.certificate from=20
> conf file", __func__);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *pcert_length=
 =3D tlshd_certs_len;
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pcert =3D tls=
hd_certs + tlshd_pq_certs_len;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pcert =3D tls=
hd_certs;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *privkey =3D =
tlshd_privkey;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> --
>
> But, I have a feeling its not the correct change...


Scott, can you triage this?


--=20
Chuck Lever

