Return-Path: <linux-nfs+bounces-20802-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F+61NEP812nGVggAu9opvQ
	(envelope-from <linux-nfs+bounces-20802-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 21:21:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AAE3CF052
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97713003EC3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858632FD1D0;
	Thu,  9 Apr 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+RxQkZs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287D261B8D
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762497; cv=none; b=lo973fzFclKbt8CskfjqKBUVsIw6MzWibg196kuuOtlzbDiOln3Jqm4bWOxcjz9cYWISn5rBGVW1ouPFQ9sOuzfAoxHc0d5b9qQHi+tvYHHIUWNxeVz+kV2Dfsy+HuBTqdQvTS3SJP3LZgk5LlhNrsaZDYCBgWp0reheT/UZvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762497; c=relaxed/simple;
	bh=xKci0Z7RGyy8yESGF490YsbH+NT/QwP2DQSJ3Bdofm0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=sDmRkQu4Yi8m8Uz2TUzipJt5w0SGbTjtIQVCLSw2wZE7qw9Tsf3vBkL+HiTqIXCDllY+Cv+K6gkx/IdIUXY3NXp3vB3I2651cyaLb7phNRd56l3kQUXDhXsNKnzUR7JE+Uo+HtlJaTffA7T4YV60MEVAHxFgROzOY1B0noGeIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+RxQkZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAECC4AF09;
	Thu,  9 Apr 2026 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775762497;
	bh=xKci0Z7RGyy8yESGF490YsbH+NT/QwP2DQSJ3Bdofm0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Q+RxQkZsdVjzUB+RCbGDiFuhs6gZ+TrrwsqKSMGGA/jeDcLvQ33PsKW48e7R5Nl8S
	 lmvomgFVGQrrQaf2nufnQ3C1w4hum47QUuTrV25i4ItNAV/TD0RltsCH/UkzrW/A3K
	 8bQZuXLhFgJO3izcxyhh1Kzt0AAGiTajygr8JDtcwS+M8Ps6TmUGsE9BT/i4kyXUmy
	 1VTQmp4zgTJyoYNiR51HEAVmYmBcj7ZZROJoMP9LJdEN+fAFYMo/jO3OxwEXHZa1AA
	 OeoORIeRlcJAra86faATcGQj88tTpAK7LRQsVGJV+OWvDzChk7HrcQH280g8gCaUWW
	 IENiRRbJeBjjg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 90E6AF40068;
	Thu,  9 Apr 2026 15:21:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 15:21:35 -0400
X-ME-Sender: <xms:P_zXafFMvMQbpJkx_QupAVa48ASUpDDvRgiNfNkEaswbR5q7hItG_g>
    <xme:P_zXaelMR9wdm1d1pcjvAK9cuBlqvHEL0j9dzO4Qeh4MY_k3VuWPDFLbF5btAWw36
    ziQnHHK2cGPTkAz9TNo15IoFIBnv1spo69t-Wje1amfkmiW3Qb6YX4>
X-ME-Received: <xmr:P_zXaTbxhLnyKq8jArq9bxjaS1Ob5Lqf_2qe2kObNZdY0_Kai2FqA-sEU8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegggfgtfffkuffhvfevofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epieelvdfhfefhheelgfduleethffhvdduueeiffeivdevffduiefhteegleffheehnecu
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
X-ME-Proxy: <xmx:P_zXaTGmyC5VKWj_5Xvx2nXYIh7G6AgZDgej-EFQ0gKL6UYbpTGhNw>
    <xmx:P_zXaUKdnyvvqNaGBWmXa25QyVQQRd4SvDgNMcLmcJBtMHbKdnCPxQ>
    <xmx:P_zXaeOgZIEZFOeQ9sPBUNWuzrivpt9e3oahuP830KC2lpv9nOd65A>
    <xmx:P_zXaUnOgh-9eIWGvo2RkNVva025qz905qIwQRpb10bwZWRQdogu1g>
    <xmx:P_zXaS5mvPcI-LY8mBxdXfjTot8pfabfP94mnJ19eJHhCVPoGI_i5akZ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 15:21:35 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 15:21:34 -0400
Message-Id: <DHOV9O5VXPQW.2819PQVY7YIB9@kernel.org>
Subject: Re: [PATCH v3 1/2] nfsd: update mtime/ctime on CLONE in presense of
 delegated attributes
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>, <chuck.lever@oracle.com>,
 <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>, <neilb@brown.name>, <Dai.Ngo@oracle.com>,
 <tom@talpey.com>
X-Mailer: aerc 0.20.1
References: <20260409164316.19748-1-okorniev@redhat.com>
 <20260409164316.19748-2-okorniev@redhat.com>
In-Reply-To: <20260409164316.19748-2-okorniev@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20802-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37AAE3CF052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Apr 9, 2026 at 12:43 PM EDT, Olga Kornievskaia wrote:
> When delegated attributes are given on open, the file is opened with
> NOCMTIME and modifying operations do not update mtime/ctime as to not get
> out-of-sync with the client's delegated view. However, for CLONE operatio=
n,
> the server should update its view of mtime/ctime and reflect that in any
> GETATTR queries.
>
> Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE=
_ATTRS delegation")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4proc.c  |  6 ++++++
>  fs/nfsd/nfs4state.c | 14 +-------------
>  fs/nfsd/state.h     | 16 ++++++++++++++++
>  3 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2797da8cc950..5091527a6dc7 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1403,6 +1403,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	struct nfsd4_clone *clone =3D &u->clone;
>  	struct nfsd_file *src, *dst;
>  	__be32 status;
> +	struct iattr attr =3D {
> +		.ia_valid =3D ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
> +	};
> =20
>  	status =3D nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &sr=
c,
>  				   &clone->cl_dst_stateid, &dst);
> @@ -1413,6 +1416,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  			dst, clone->cl_dst_pos, clone->cl_count,
>  			EX_ISSYNC(cstate->current_fh.fh_export));
> =20
> +	if ((READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) !=3D 0 && !statu=
s)

Let's write this:

  if (!status && ((READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) !=3D 0=
))


> +		nfsd_update_cmtime_attr(dst->nf_file, &attr);
> +
>  	nfsd_file_put(dst);
>  	nfsd_file_put(src);
>  out:
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c75d3940188c..553102da6f7d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1225,8 +1225,6 @@ static void put_deleg_file(struct nfs4_file *fp)
>  static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, =
struct file *f)
>  {
>  	struct iattr ia =3D { .ia_valid =3D ATTR_ATIME | ATTR_CTIME | ATTR_MTIM=
E | ATTR_DELEG };
> -	struct inode *inode =3D file_inode(f);
> -	int ret;
> =20
>  	/* don't do anything if FMODE_NOCMTIME isn't set */
>  	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) =3D=3D 0)
> @@ -1245,17 +1243,7 @@ static void nfsd4_finalize_deleg_timestamps(struct=
 nfs4_delegation *dp, struct f
>  		return;
> =20
>  	/* Stamp everything to "now" */
> -	inode_lock(inode);
> -	ret =3D notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
> -	inode_unlock(inode);
> -	if (ret) {
> -		struct inode *inode =3D file_inode(f);
> -
> -		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x=
:%02x:%lu: %d\n",
> -					MAJOR(inode->i_sb->s_dev),
> -					MINOR(inode->i_sb->s_dev),
> -					inode->i_ino, ret);
> -	}
> +	nfsd_update_cmtime_attr(f, &ia);
>  }
> =20
>  static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 811c148f36fc..683c305a8808 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -844,6 +844,22 @@ extern void nfsd4_shutdown_copy(struct nfs4_client *=
clp);
>  void nfsd4_put_client(struct nfs4_client *clp);
>  void nfsd4_async_copy_reaper(struct nfsd_net *nn);
>  bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
> +static inline void nfsd_update_cmtime_attr(struct file *f,
> +					   struct iattr *attr)
> +{
> +	int ret;
> +	struct inode *inode =3D file_inode(f);
> +
> +	inode_lock(inode);
> +	ret =3D notify_change(&nop_mnt_idmap, f->f_path.dentry, attr, NULL);
> +	inode_unlock(inode);
> +	if (ret)
> +		pr_notice_ratelimited("nfsd: Unable to update timestamps on "
> +				      "inode %02x:%02x:%lu: %d\n",
> +				      MAJOR(inode->i_sb->s_dev),
> +				      MINOR(inode->i_sb->s_dev),
> +				      inode->i_ino, ret);
> +}

Move this new function into fs/nfsd/nfs4state.c and add a proper kdoc
comment. This is a little much for a static inline function.


>  extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_net=
obj name,
>  				struct xdr_netobj princhash, struct nfsd_net *nn);
>  extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd=
_net *nn);


--=20
Chuck Lever


