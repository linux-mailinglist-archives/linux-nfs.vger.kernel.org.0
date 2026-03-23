Return-Path: <linux-nfs+bounces-20330-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK4KMw9NwWmhSAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20330-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 15:24:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C3D2F461B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09C333207FE3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3C3B0AC4;
	Mon, 23 Mar 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX0fw951"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045D3AE1B9
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274736; cv=none; b=g2Ot9R4WaQe+hehzP/Ha+B1BrXhBMNSGFI4Rwk/cIyBdcpSSv9er3QusjJ36aei/zsL9JjzvL47p3J+NE9erFldKhA0bDJttvLoKd/Rn9y2+whOWn74S3bIV3fNaDgWSjtlI3cFAW5i2/8fUb/PpyIuExVu/T9AYPAfm4LmONEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274736; c=relaxed/simple;
	bh=RUrl1tC9Kr3jqEbVSpZdBYuWMCVBY/50KSqo4yIjkiM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FXsez2PGcCPR8jDcXaS2qwLouUOtsi54tylFSL9E3hnZ/o08QcYEsh2TljXg4enc4bXzOOOSjJT0Fdq8KDVcysht8n8KY+9s8prX8i8kIeU/qN7/UhfZGIX35QxaYLXTsbtbck+AQZUHGCgEjOv+mEHKdLBMtKZ6JewhpeBbnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX0fw951; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AC3C2BC9E;
	Mon, 23 Mar 2026 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274736;
	bh=RUrl1tC9Kr3jqEbVSpZdBYuWMCVBY/50KSqo4yIjkiM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qX0fw951yTuYgTFVdMlLoZyHSjSGf4EsjKeRPupIboJahLDChBoBz3KGGnBd5XhgH
	 ++ed/XPmwDw1ONLT0pKrAa7O6ofhSYLqfLbp4NYCVI22BRcRyhjOlCt3NUZUbz9xWF
	 Qf3IIgNdSHEh3/S+P0NGGkRUCfY/qScou2vcyqCVq03zvOpnGLJzGm5fCTgLq+a6RJ
	 8KQuwXiLlf0yIMDIhkilmdM6tlWV46iHj5XUmXY0fzBMwyCrZMIK2pa5yO01Hf2abz
	 rzeVyCAzNciPWydICfg3j77GvpZ2Xl8zpKj3o8FLKRj/fGqKx8W+ms/TEWs6jV3NQr
	 3LYTZ6SQ2GMkg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 22F9CF4008C;
	Mon, 23 Mar 2026 10:05:35 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 10:05:35 -0400
X-ME-Sender: <xms:r0jBaU4w0_-8Vk_EEC1aBZEk_I6XsWETTJJhN0tEpd-UHa82I06Hng>
    <xme:r0jBaQt5yLHZoFqpYJPIC1n68mKB9uhMkiQNBVRheo-mNSvhT-1EN68ZiMzarXMAT
    OPG37w04TreekiyGsR-7Dhxb6HDXz2El2REyIVs3CZtEizfRaZTX8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthh
    eslhhsthdruggvpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghl
    phgvhidrtghomh
X-ME-Proxy: <xmx:r0jBaQ1PfxGESZP-ato7Sx-Bzy8Sgp-S0zyaD8gTSafcFp8A5yvuQA>
    <xmx:r0jBaRfVoEx8NVneSUAh4etjLKIYO5WWE5TcMT4TbcLh-hcj3SLxLA>
    <xmx:r0jBaVKGEQDF03r2s3SqWJToKyQ1Z-O9AHjm7muP3gEjUZD7y3W7cg>
    <xmx:r0jBaXp8KRue6e8aEC67OsmAuPhlP94hwK-VQqSo1e7pEk2eUCk9_A>
    <xmx:r0jBabum4fu3QIbToDPm-g7d8rUnSezoTZQ0eowZDAgMZ7HrQGlA_zlo>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2F2C780075; Mon, 23 Mar 2026 10:05:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfS3vEoGaRRw
Date: Mon, 23 Mar 2026 10:05:14 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Carlos Maiolino" <cem@kernel.org>, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <81da6f4c-7523-496d-b8ed-8e78f4f83ea4@app.fastmail.com>
In-Reply-To: <20260323070746.2940140-3-hch@lst.de>
References: <20260323070746.2940140-1-hch@lst.de>
 <20260323070746.2940140-3-hch@lst.de>
Subject: Re: [PATCH 2/7] exportfs: don't pass struct iattr to ->commit_blocks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lst.de,oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20330-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50C3D2F461B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, Mar 23, 2026, at 3:07 AM, Christoph Hellwig wrote:
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 7464e9e37af1..0dd36f3d5a51 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -180,22 +180,15 @@ nfsd4_block_commit_blocks(struct inode *inode, 
> struct nfsd4_layoutcommit *lcp,
>  		struct iomap *iomaps, int nr_iomaps)
>  {
>  	struct timespec64 mtime = inode_get_mtime(inode);
> -	struct iattr iattr = { .ia_valid = 0 };
>  	int error;
> 
>  	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
>  	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
>  		lcp->lc_mtime = current_time(inode);
> -	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
> -	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
> -
> -	if (lcp->lc_size_chg) {
> -		iattr.ia_valid |= ATTR_SIZE;
> -		iattr.ia_size = lcp->lc_newsize;
> -	}
> 
>  	error = inode->i_sb->s_export_op->block_ops->commit_blocks(inode,
> -			iomaps, nr_iomaps, &iattr);
> +			iomaps, nr_iomaps,
> +			lcp->lc_size_chg ? lcp->lc_newsize : 0);
>  	kfree(iomaps);
>  	return nfserrno(error);
>  }

After this change is applied, nfsd4_block_commit_blocks continues
to compute lcp->lc_mtime (honoring UTIME_NOW etc.) but never
passes it to the underlying filesystem. The old code set

  iattr.ia_mtime = lcp->lc_mtime

and propagated it via setattr_copy; but now xfs_fs_commit_blocks
unconditionally uses inode_set_ctime_current(). The mtime
computation here is now dead code.

This change introduces a regression against RFC 8881 Section 18.42
(LAYOUTCOMMIT's loca_time_modify is ignored).


-- 
Chuck Lever

