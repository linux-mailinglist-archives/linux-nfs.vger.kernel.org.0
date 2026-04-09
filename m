Return-Path: <linux-nfs+bounces-20800-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLfEKi3y12n6UwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20800-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 20:38:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F53CEC08
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB2D3001BD7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAD9246774;
	Thu,  9 Apr 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNqLAoUu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205C2D6E58
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759882; cv=none; b=n2jPOxqrvIC91QweTVSYxWhgnhmpxzso8JXJzdcqGeSYHkaN9nEDT28yP8udF51ynPGxD9hXVz5ctmoZ8MBXAhQuFIzRDf132uPp3gH3OQvkTuMDDJTWBxWujpGQdCtrTYkFgGJKBtuS2U5SncvIkQmkFmg6KYxiGstsJhbZjjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759882; c=relaxed/simple;
	bh=h+dexYItGErmOm7aED1Or55x9C3qxIM8WUYC8Df8DUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FvIQQMXFrGulibC3ttn82HPve4FhgZH/86/hsZKQEVFv/qhXW0tP/LceQrlulWHFF4VvAsqbK609g9MSafq7wX5F+MLuoSaV4iAlB9m2cZbzmhe7LfkUCySCUGPRI2VJnRjL9otxVHp6AUTaD07RTHAXkY5jR6hB7RFQgUmFyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNqLAoUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF23C19424;
	Thu,  9 Apr 2026 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759882;
	bh=h+dexYItGErmOm7aED1Or55x9C3qxIM8WUYC8Df8DUM=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VNqLAoUutrhmfw4wLl1tCr0VM5q/u7SnsF82ZvXvvB0EqFZbFJsbJ1n8xMxZa4aHj
	 xFgJ2kUIJP+rmiDjqd0yCWgom/uywBsM7/f3oubQuNVxZQ0692b/sGYfA+aO43WZmo
	 cAMHJaWBkP6lansu3090NN3LhvDRecbd2/pCxOdDexDG/uj3enbMEcsx1ZlM97DXwK
	 p9BBbLsRRzFC1MAzlhJ4Ai2aMiZu0nTD6um5yf37F7LtzMCi3AkT9Q57ktoOu9kqbL
	 tcADspx/vFYi3T0M6VBvNXWI8v1a6+dbNg/O/CsJzl/OfY+JU06UwY4viMVsJGv/0M
	 1r1FicBMqWAEA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB383F4006B;
	Thu,  9 Apr 2026 14:38:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 14:38:00 -0400
X-ME-Sender: <xms:CPLXaWuiQqw3qoP785tdTZCMhVUKL7Sq7syKCI7BgwRN9NwbSy6J8g>
    <xme:CPLXadtNvbmSSsiHvTadJBUorFQQuma6Se9YDqrlGs1k3mmfyh2dPww37pvflryCl
    WI5fLi4fh8hyVts-WRe8gVPwhCGswhZwTzPxs53_0k8iZ1-ywWDQxs>
X-ME-Received: <xmr:CPLXaUDEtMTv0z18Mi48uoIimJzho2IAKG0rPTVredUGTmAaNiz8j2ewLR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epueelvdetjeeihfelleevkeduhfelffelkeeukeelvdetjeekleehieelkeegvddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkh
    drlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphht
    thhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehtohhmsehtrg
    hlphgvhidrtghomh
X-ME-Proxy: <xmx:CPLXaXN9-CKQ4VYyMEvYPauYQRL9kfSw9B5PIvT1xFE_cvbcUg94Jw>
    <xmx:CPLXaVyQO8xJyvD_qgB0cArBqHZlmk_-vgulyd28ISHAVJ0lnVv2lg>
    <xmx:CPLXafV-LKhqUCHT3CbBnDFzTSZorV-j8aWQPeGZ3lJ4SZvF8U6WoA>
    <xmx:CPLXafOHuIgf8SQIwfx8BcyVU5IUrTIQggHY6Rj-4VpGgXKmVHWddA>
    <xmx:CPLXaZAvI51JsiuYt8nT5VJkAp9wtv9hPBj8Y1C0oG9yUhrWIMmtDGuO>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 14:38:00 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 14:37:59 -0400
Message-Id: <DHOUCAZKI2KW.3PU9H7KPOE2H7@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>, <chuck.lever@oracle.com>,
 <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>, <neilb@brown.name>, <Dai.Ngo@oracle.com>,
 <tom@talpey.com>
Subject: Re: [PATCH v3 2/2] nfsd: update mtime/ctime on COPY in presence of
 delegated attributes
From: "Chuck Lever" <cel@kernel.org>
X-Mailer: aerc 0.20.1
References: <20260409164316.19748-1-okorniev@redhat.com>
 <20260409164316.19748-3-okorniev@redhat.com>
In-Reply-To: <20260409164316.19748-3-okorniev@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20800-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5E5F53CEC08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Apr 9, 2026 at 12:43 PM EDT, Olga Kornievskaia wrote:
> COPY should update destination file's mtime/ctime upon completion.

Let's provide similar rationale here as was done in v3 1/2.


> Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE=
_ATTRS delegation")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4proc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5091527a6dc7..4418e71c8458 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2124,8 +2124,22 @@ static int nfsd4_do_async_copy(void *data)
> =20
>  	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>  	trace_nfsd_copy_async_done(copy);
> -	nfsd4_send_cb_offload(copy);
>  	atomic_dec(&copy->cp_nn->pending_async_copies);
> +	/*
> +	 * choosing to check for existence of set dentry pointer to indicate
> +	 * that we need to update the attributes and do a dput because the
> +	 * file flag could be cleared by a DELEGRETURN and then we'd lose
> +	 * that copy was started with file opened with NOCMTIME and we got
> +	 * a reference on the dentry.
> +	 */

Now that you're not dealing with dget/dput, this new comment is
perhaps stale.


> +	if (copy->cp_res.wr_bytes_written > 0) {

Don't you need the FMODE_NOCTIME guard here too?


> +		struct iattr ia =3D {
> +			.ia_valid =3D ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
> +		};
> +
> +		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, &ia);
> +	}
> +	nfsd4_send_cb_offload(copy);
>  	return 0;
>  }
> =20
> @@ -2201,8 +2215,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  		wake_up_process(async_copy->copy_task);
>  		status =3D nfs_ok;
>  	} else {
> +		struct iattr ia =3D {
> +			.ia_valid =3D ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
> +		};

You could move "struct iattr ia" into the helper, and just pass a "0"
at these call sites and "ATTR_ATIME" at the
nfsd4_finalize_deleg_timestamps() call site.


> +
>  		status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
>  				       copy->nf_dst->nf_file, true);
> +		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
> +			       FMODE_NOCMTIME) !=3D 0 &&
> +				copy->cp_res.wr_bytes_written > 0)
> +			nfsd_update_cmtime_attr(copy->nf_dst->nf_file, &ia);
>  	}
>  out:
>  	trace_nfsd_copy_done(copy, status);


--=20
Chuck Lever


