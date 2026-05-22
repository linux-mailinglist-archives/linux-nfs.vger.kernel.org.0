Return-Path: <linux-nfs+bounces-21813-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFadH2OiEGpuawYAu9opvQ
	(envelope-from <linux-nfs+bounces-21813-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 20:37:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4875B91E8
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE7493008502
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938D352028;
	Fri, 22 May 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvUTCQ+n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27434388F;
	Fri, 22 May 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475039; cv=none; b=NXk3NXK2cAvTmvtex5P+V7FO13lHJ4W5kZiWUrbmpdP4Frfxc8Dw6j4/oW1Ov+WxES2Sh8L1TBTpVYDhHsVsCEVguSdTLNcjNPCo69iiyts3yByz5ASapF7wFHf0bgskzQ1Wjzrccuz6bVZqnyDX34kjClOiCN2AK1f+qj8wP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475039; c=relaxed/simple;
	bh=ILRi3mHvofBvZX4Zxvz8a+6uM10/1VdCjDLT1BUb8HA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J8OSmk8vsVgQyux6qyHnqfsfOJFp3ybRyfu1vC+6/tXbG+0VVWmC0maHUR+N5nDqlVaN9jtMcxKz+ZeEJVewj+Yq9iKv7dgtNew63Tz+l4aeRACoXJmgOmY0sue9Dvqv4SVhNCgfUZXsQG3s3MOxTlsGauRH64RlhUeu2wmpO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvUTCQ+n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF9D1F00A3E;
	Fri, 22 May 2026 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779475038;
	bh=N3/Lfob3K3z/LwX9Mv23zn07HcL12WrlkOACfQoMpTc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=NvUTCQ+n0Li8PCRNu3a47xMiG6i35LJ1/RI3CK069jkxuCWS7VzfWtScYCgOtPjnU
	 vZgvoncwjRi9DAmz6t1BKIEqaUsopPjaNosW0Z/e7ZBqUUCEERnWrpa5FFBiMxGouV
	 diYBPTXIFA0+1LwLmdhd8xHYkBnVPqMkP3Lf7g+3gqgLfpVdtwqp33DZUxRr3fXExu
	 lmwAgp55C9xReDS/7XAFROpMPP4cu/DBmfkCW3foEGLvFk+arb+VZ6YBhL7HfgS86a
	 L15ndStROg5d/4u3o0xmmdidTuXbhE3TOajFcSCO3Z9qLXrTMOdHfClj208kBinlh/
	 TB/AQNEIDUoew==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D522F40068;
	Fri, 22 May 2026 14:37:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 22 May 2026 14:37:17 -0400
X-ME-Sender: <xms:XaIQageS5mz0KXHTI-0ZMbTCBOkIyEBleOMnUudXqImtjNELOEas_g>
    <xme:XaIQatBKYREsf38AC5VY-TaE-P2Mm1Xb-vf6nTej6kOkm5T8u1JDhOAX8aBzLbiIH
    5RV_JAd7RpRob4NCBmTbRjnIOgyLueHoSlrdHnm5pybPt6LYEmvgI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphht
    thhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrd
    hlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XaIQaqvltn1ZmVyJd1cDPA0-9FrYLa4cyudeaztBQ6cAZkl1zI3jLg>
    <xmx:XaIQav4hfe6GMZl6kXoKhmZac82_LJrAY1k_n2foTTgPZAKkYnT9Bw>
    <xmx:XaIQamepAFvpPAc5IRqudBT0aQYPu-zBXYGYEpNp72BJqxDC41eSkA>
    <xmx:XaIQasyROkzNNB7szKRg9cn02dV4MnQmZoZldF4QNItjDQgFW-Q1qw>
    <xmx:XaIQar-Uo9dgmvHCGkP96jqZO9b6xGOeklKpHZ4ZbsA1Vsp-rxDRwDtn>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18401780070; Fri, 22 May 2026 14:37:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaocredu4Z0c
Date: Fri, 22 May 2026 14:36:56 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Chris Mason" <clm@meta.com>
Message-Id: <f57dc5ce-65ce-461e-bce7-5234b8873e8d@app.fastmail.com>
In-Reply-To: 
 <20260522-missing_verifier_reset_on_wb_err-v1-1-bf9f427f9b26@kernel.org>
References: 
 <20260522-missing_verifier_reset_on_wb_err-v1-1-bf9f427f9b26@kernel.org>
Subject: Re: [PATCH] nfsd: reset write verifier on deferred writeback errors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21813-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB4875B91E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Fri, May 22, 2026, at 12:44 PM, Jeff Layton wrote:
> nfsd_vfs_write() and nfsd_commit() both call filemap_check_wb_err() to
> detect deferred writeback errors, but neither rotates the server's wri=
te
> verifier (nn->writeverf) when this check fails. Every other
> durable-storage-failure path in these functions calls
> commit_reset_write_verifier() before returning an error.
>
> The missing rotation means clients holding UNSTABLE write data under t=
he
> current verifier will COMMIT, receive the unchanged verifier back, and
> conclude their data is durable =E2=80=94 silently dropping data that f=
ailed
> writeback. This violates the UNSTABLE+COMMIT durability contract
> (RFC 1813 =C2=A73.3.7, RFC 8881 =C2=A718.32).
>
> Add commit_reset_write_verifier() calls at both filemap_check_wb_err()
> error sites, matching the pattern used by adjacent error paths in the
> same functions. The helper already filters -EAGAIN and -ESTALE
> internally, so the calls are unconditionally safe.
>
> Reported-by: Chris Mason <clm@meta.com>
> Assisted-by: kres:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cba473969429..7e6468bdc723 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1513,8 +1513,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct=20
> svc_fh *fhp,
>  	nfsd_stats_io_write_add(nn, exp, *cnt);
>  	fsnotify_modify(file);
>  	host_err =3D filemap_check_wb_err(file->f_mapping, since);
> -	if (host_err < 0)
> +	if (host_err < 0) {
> +		commit_reset_write_verifier(nn, rqstp, host_err);
>  		goto out_nfserr;
> +	}
>=20
>  	if (stable && fhp->fh_use_wgather) {
>  		host_err =3D wait_for_concurrent_writes(file);
> @@ -1694,6 +1696,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_f=
h=20
> *fhp, struct nfsd_file *nf,
>  			nfsd_copy_write_verifier(verf, nn);
>  			err2 =3D filemap_check_wb_err(nf->nf_file->f_mapping,
>  						    since);
> +			if (err2 < 0)
> +				commit_reset_write_verifier(nn, rqstp, err2);
>  			err =3D nfserrno(err2);
>  			break;
>  		case -EINVAL:
>
> ---
> base-commit: 6167e81847ba3adca17d8881ed9415beae993e2d
> change-id: 20260522-missing_verifier_reset_on_wb_err-480eb64a4ebe
>
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>

Do you have an additional fix pending that addresses the same bug
in the async COPY path? If not, I can post one.


--=20
Chuck Lever

