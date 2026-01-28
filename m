Return-Path: <linux-nfs+bounces-18582-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNlyBpc9emlB4wEAu9opvQ
	(envelope-from <linux-nfs+bounces-18582-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 17:47:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F958A61B8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 17:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C05073180DFE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EB30DD03;
	Wed, 28 Jan 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r23bneBn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0D30C60D
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616726; cv=none; b=GU2lXRbRy8czZCJ9h5clpXOpTUoqfhObXJr5HeEmU4V9Z8dtzHma+lBj+oLqf6J+LEs6QvIrnkfZhxXjKMnVJO2rwprnZQHdOHEah1wJMguqLyNMDskBObyUuUR3hVpn2AgjUmsRJVglyrG6BgrEeMmYdN6czFxQc8RXoNGmpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616726; c=relaxed/simple;
	bh=FKRWRQQ7B9wc0bxM0FtDQG06PgQG3VJgJtyuEjjQM2Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uTyfQlDdKQZN99BS6Wl1E4lTCL9DttfSWbjqQ11D4FT2wfnkRqddv/9Ds9GMJOSVZQuc0cjn5i7Svt8QSogSoLWd+l9cD1ifEMilPakenruHKXKouuMEyMWxW+iylkhm55ehWhgZEn4sZKN992FGEaRJCa6xlwtA7yxvF9hhtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r23bneBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B691BC116C6;
	Wed, 28 Jan 2026 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769616726;
	bh=FKRWRQQ7B9wc0bxM0FtDQG06PgQG3VJgJtyuEjjQM2Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r23bneBnpuBtwQOCuFLja/7Apl/k3IDN3I1SI8NPGla/9Rslo7ojLc/tBkrB5n95v
	 NpOLL5Afh+YenBuSTwGiSc65tbvgJ+BzziU5w6CGZknLShGEqD0sLs9a9zpR6czagV
	 JoKsLwx50IwUmmpxxz3kMnUxyupcNlKy2uJhSA5R5FCGFAkJZR8oEtLAf2+EXXUFCu
	 Pmr7mXduV3ddwaUviTYJwzNrnPEDxcJtTkQ0m5SV/hULiyqjiInnrkVZ+38DBzm3uN
	 zcZ06I8Jub1ilRe7Vne3yFJ1Lu1uybLg1mZngb09WdFlDImOTKiHpQFJCcRQGjPm/K
	 X1ogLnQy+3xWA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C1107F40068;
	Wed, 28 Jan 2026 11:12:04 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 28 Jan 2026 11:12:04 -0500
X-ME-Sender: <xms:VDV6aQwNs5HgI7AxopBBUkREUds7ER-_QDNV7RY544t5L_bsNlSEmQ>
    <xme:VDV6afEplDGjnd0hg4l-v6ydLZC31oDnVLEHM9AHxtr7162teHii48zyUmCXwioyL
    V8x3IoNpr40eCnN1eCUNC4jorgUPkxYRGr95BJn5L69gocGf3LFb6if>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhtghhsehlshhtrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VDV6aWAnnImY_WkxY79JEtR4EBkVYQG3RsYlTnxTd0J9U8W3wFRvsA>
    <xmx:VDV6aQ-6_oA0efrTrATsozhQPAuFum_uBGu08fpd01r0_FKahCFn9A>
    <xmx:VDV6aaSueRjPdXcb2mCQdUFSuu-h3buiu828DOFLiyaV21y7Vl9J3A>
    <xmx:VDV6acWasm2govUhfGoDtgosoOxJ-Wo3JMABNMR-6GFESkKsVJxw6A>
    <xmx:VDV6acQcWyNf2uk2ofXjamVKjJYVI7pem9zk2ko4Gf2pi8cunPj6T8cA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E569780070; Wed, 28 Jan 2026 11:12:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqZtfaGcuMoJ
Date: Wed, 28 Jan 2026 11:11:10 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 NeilBrown <neil@brown.name>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <dce0e412-1a56-44b3-b910-29247ca23325@app.fastmail.com>
In-Reply-To: <20260128111645.902932-3-amir73il@gmail.com>
References: <20260128111645.902932-1-amir73il@gmail.com>
 <20260128111645.902932-3-amir73il@gmail.com>
Subject: Re: [PATCH v3 2/2] nfsd: do not allow exporting of special kernel filesystems
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18582-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F958A61B8
X-Rspamd-Action: no action



On Wed, Jan 28, 2026, at 6:16 AM, Amir Goldstein wrote:
> pidfs and nsfs recently gained support for encode/decode of file handles
> via name_to_handle_at(2)/opan_by_handle_at(2).

s/opan/open

One more below:


> These special kernel filesystems have custom ->open() and ->permission()
> export methods, which nfsd does not respect and it was never meant to be
> used for exporting those filesystems by nfsd.
>
> Therefore, do not allow nfsd to export filesystems with custom ->open()
> or ->permission() methods.
>
> Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/export.c         | 8 +++++---
>  include/linux/exportfs.h | 9 +++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 2a1499f2ad196..09fe268fe2c76 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -427,7 +427,8 @@ static int check_export(const struct path *path, 
> int *flags, unsigned char *uuid
>  	 *       either a device number (so FS_REQUIRES_DEV needed)
>  	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
>  	 * 2:  We must be able to find an inode from a filehandle.
> -	 *       This means that s_export_op must be set.
> +	 *       This means that s_export_op must be set and comply with
> +	 *       the requirements for remote filesystem export.
>  	 * 3: We must not currently be on an idmapped mount.
>  	 */
>  	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
> @@ -437,8 +438,9 @@ static int check_export(const struct path *path, 
> int *flags, unsigned char *uuid
>  		return -EINVAL;
>  	}
> 
> -	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> -		dprintk("exp_export: export of invalid fs type.\n");
> +	if (!exportfs_may_export(inode->i_sb->s_export_op)) {
> +		dprintk("exp_export: export of invalid fs type (%s).\n",
> +			inode->i_sb->s_type->name);
>  		return -EINVAL;
>  	}
> 
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index fafd22ed4c648..bf3dee2ad5f97 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -340,6 +340,15 @@ static inline bool exportfs_can_decode_fh(const 
> struct export_operations *nop)
>  	return nop && nop->fh_to_dentry;
>  }
> 
> +static inline bool exportfs_may_export(const struct export_operations *nop)
> +{
> +	/*
> +	 * Do not allow nfs export for filesystems with custom ->open() and
> +	 * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
> +	 */

The comment says "with custom ->open() and ->permission() ops" but the
code blocks export if either one is set. The commit message correctly
says "or" - should the comment be updated to match?


> +	return exportfs_can_decode_fh(nop) && !nop->open && !nop->permission;
> +}
> +
>  static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
>  					  int fh_flags)
>  {
> -- 
> 2.52.0

-- 
Chuck Lever

