Return-Path: <linux-nfs+bounces-20139-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OC0LsBws2kEWQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20139-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 03:04:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3627C778
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 03:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA33306826E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433A3148DA;
	Fri, 13 Mar 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvZ8CyiY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138A2F6918
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367473; cv=none; b=HLqVqdO006+ufKO97XY71JclGEKvCRW9Ae+YJFl+j6gVZWyrf8njFDVlJYFIzR/jT3cWs9LP3jePjVybFpasFlvJQm8SLntGiUSQzr+VQyhKUy2JojfLZCh0swngZxOpUXle0L0hJULH80PeeqNNW5wE2thfA/xwG73t+AD1bbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367473; c=relaxed/simple;
	bh=Eoj5BXWS7CJuhJrRWoQgivJWAX4nd4r1LJP0Q8E5/f8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KSxtBR+vVz3o6qWjhzTDbXm7lnjdQ23hn5oFOMPN7MyAY0geZD6UqScJyI66tmXpQ+Fc751ZcLVsMDwVXqtnCiTjx3rR9FliEPU7F8Wl03m83qnFfIhMQZCWqWIRjeEyE5fK9t3vVGXYgKs93YRTOvNoeyNTnaQCLGP6U3M38vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvZ8CyiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D496C4CEF7;
	Fri, 13 Mar 2026 02:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773367473;
	bh=Eoj5BXWS7CJuhJrRWoQgivJWAX4nd4r1LJP0Q8E5/f8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dvZ8CyiYqxQg8BChqpyOXrFpCZy5Scbwh6ExFCitH3nrpG0XJA30eBq1+9wpIczTA
	 zjEI7dwUGajCmJC+wWmrraqtjdQRkdME3NM0En8E9wkVlRkv2tbnorRWji6rK56Z+W
	 NVfXCiOa8Fl/mBQbdAfEi66z33On5u9lBUxfqLjsEJwJur15QCipCFvLrQpyWsxve3
	 gV1GEbv4XbfMdNeUZTwGuSORDxlgeJsnt/ifilkjUTpWbin2J1eqrv40MAzXYgEXEf
	 jxJa/fsqVpdb4D8PDk5aWoICJVRZ8ShLmI6LU85cIUVhN6igo3T8mjOuX3v3oc9YUd
	 oyo5rNKGPuBrQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E7D59F4006A;
	Thu, 12 Mar 2026 22:04:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 22:04:31 -0400
X-ME-Sender: <xms:r3CzaRMFNKVlSL5h1hw54HKw7q6C5SZokeWfrvVOxI4DJH43skjy3Q>
    <xme:r3CzaewOyBYNpgMkZfelslYbuQUTUH-twaHnKv9IH_lbwL6Z-2hsxLyLw3OuqfFg2
    kkJdW6awuTAI2xT_O5k0aZCT_SocYKlNH0yYqgHAI2IBCxSwJqcUho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegumhgrnhhtihhpohhvseihrghnuggvgidrrhhu
X-ME-Proxy: <xmx:r3CzaajphZuqZLdyV4JFye9_Rcj29GHC5-p6FMUWnM1FR-0KpLT8hQ>
    <xmx:r3CzaVCKuhOtSU6V5NulTVojqxvSbxZF5k_lU94IR2L_5dnDknFjNw>
    <xmx:r3CzaYtSrwhshn4WbTqblpoeX4DZp-5cO7UbP9Y_aXfuzu4Xda1Phg>
    <xmx:r3CzaRcFq7kWmeLczxmSkmFm7UY64PdbX46jes1-1V7jcOa6BNZ-SA>
    <xmx:r3CzaV8lW9pI3qy4x6qNZzoocy8i-ojo3JMPhZetw00uPTbmuDCxPDEM>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B9F07780075; Thu, 12 Mar 2026 22:04:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARXusodW7anc
Date: Thu, 12 Mar 2026 22:03:22 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Dmitry Antipov" <dmantipov@yandex.ru>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Message-Id: <03562c81-1de2-45a1-8d0f-e37e3d8de063@app.fastmail.com>
In-Reply-To: <20260312120720.27899-1-dmantipov@yandex.ru>
References: <20260312120720.27899-1-dmantipov@yandex.ru>
Subject: Re: [PATCH] nfsd: simplify nfsd4_interssc_connect()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20139-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[yandex.ru,oracle.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22F3627C778
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, Mar 12, 2026, at 8:07 AM, Dmitry Antipov wrote:
> In 'nfsd4_interssc_connect()', 'ipaddr' of size RPC_MAX_ADDRBUFLEN + 1
> (64) is small enough to allocate it on the stack and so avoid explicit
> 'kzalloc()' and 'kfree()'. And, since 'rpc_ntop()' returns the length
> of the result, an extra call to 'strlen()' may be avoided as well.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> Neil may be interesting in adding missing space to MAINTAINERS :)
> ---
>  fs/nfsd/nfs4proc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6880c5c520e7..ec8a8ad8bbc1 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1706,7 +1706,7 @@ nfsd4_interssc_connect(struct nl4_server *nss,=20
> struct svc_rqst *rqstp,
>  	struct sockaddr_storage tmp_addr;
>  	size_t tmp_addrlen, match_netid_len =3D 3;
>  	char *startsep =3D "", *endsep =3D "", *match_netid =3D "tcp";
> -	char *ipaddr, *dev_name, *raw_data;
> +	char ipaddr[RPC_MAX_ADDRBUFLEN + 1], *dev_name, *raw_data;
>  	int len, raw_len;
>  	__be32 status =3D nfserr_inval;
>  	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> @@ -1732,19 +1732,15 @@ nfsd4_interssc_connect(struct nl4_server *nss,=20
> struct svc_rqst *rqstp,
>  		goto out_err;
>=20
>  	/* Construct the raw data for the vfs_kern_mount call */
> -	len =3D RPC_MAX_ADDRBUFLEN + 1;
> -	ipaddr =3D kzalloc(len, GFP_KERNEL);
> -	if (!ipaddr)
> -		goto out_err;

The old code zero-initialized ipaddr via kzalloc, so an rpc_ntop()
failure (return 0) would produce an empty string. The new stack buffer
is uninitialized. If rpc_ntop() returns 0, snprintf formats
uninitialized stack bytes into raw_data.


> -	rpc_ntop((struct sockaddr *)&tmp_addr, ipaddr, len);
> +	len =3D rpc_ntop((struct sockaddr *)&tmp_addr, ipaddr, sizeof(ipaddr=
));
>=20
>  	/* 2 for ipv6 endsep and startsep. 3 for ":/" and trailing '/0'*/
>=20
> -	raw_len =3D strlen(NFSD42_INTERSSC_MOUNTOPS) + strlen(ipaddr);
> +	raw_len =3D strlen(NFSD42_INTERSSC_MOUNTOPS) + len;
>  	raw_data =3D kzalloc(raw_len, GFP_KERNEL);
>  	if (!raw_data)
> -		goto out_free_ipaddr;
> +		goto out_err;
>=20
>  	snprintf(raw_data, raw_len, NFSD42_INTERSSC_MOUNTOPS, ipaddr);
>=20
> @@ -1781,8 +1777,6 @@ nfsd4_interssc_connect(struct nl4_server *nss,=20
> struct svc_rqst *rqstp,
>  	kfree(dev_name);
>  out_free_rawdata:
>  	kfree(raw_data);
> -out_free_ipaddr:
> -	kfree(ipaddr);
>  out_err:
>  	return status;
>  }
> --=20
> 2.53.0

The kernel community has a general preference for heap allocation of
buffers to keep stack frames small. The kernel stack is typically only
8=E2=80=9316 KB and shared across the entire call chain. While 64 bytes =
alone
isn't alarming, this function already has struct sockaddr_storage (128
bytes) on the stack, and the cumulative effect matters more than any
single buffer.

The commit trades a well-understood heap allocation (with clear
ownership and cleanup) for a marginally simpler control flow, while
introducing the uninitialized-buffer subtlety. The kzalloc/kfree
pattern it removed was idiomatic and not a maintenance burden: it's
the standard way to handle buffers in kernel code.

The simplification benefit (removing one goto label and one error
check) is modest compared to the cost of moving against the prevailing
convention and losing the zero-initialization safety net.

The commit message does not provide a sufficient justification to
warrant applying this patch.


--=20
Chuck Lever

