Return-Path: <linux-nfs+bounces-22081-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIazMVfSGWodzQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22081-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:52:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD5606DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBBC6367F574
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F43AEF3B;
	Fri, 29 May 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5PrARxs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82B3F54D9
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073852; cv=none; b=mkGcEumNbW70/PbIwsBPhcbMwyPYcbqjC60vxJQ6mjmEk5smap2FEDbJO3THKFTQ5jfp5My6dpfO+5l6Q23a6gSe6DREyV4UU5zW5rBYuxg2Gs7Mr5Yl4lzGqWUGZxrfjAE4AufrQo9oZlLGhdAlwxi68l5sM7KDFAVCfVFhBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073852; c=relaxed/simple;
	bh=IBVNMZMKt9+CcC0nKcD+/y5bNQQhf03gkQ1lUfFOPUQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AnKPxpnJuDCjiZO93o8LJzVEdva6RdQnvX3hCOh1qOgupbYRW2R9BP0ImcdkaKh35LUVUSrAQV6ebiecPL/maLhrrOBKeH7N2/Lfg/dB65bqKKhCugXhzl5/dPi8D3+IaPkBPv8rTgp/pbVqTv0VG26XDju9aDk018wDwxY0yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5PrARxs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE3D1F00898;
	Fri, 29 May 2026 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073850;
	bh=vfqm4EzFeISI5EMIsatbs1qADgmNIzBHrc+Jl3IVqNo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=U5PrARxs5W9N1u6mPVfDs/GWZnTEFX7Nd2TF1fMufkFaawZNnAadkoBTq6SlxrWtn
	 7lgU+Y9kMg1q4vwd+EPGnQZjXi0kA+krB2YWNzoiYwTDI/jw3CiggeFT/2zW2KQKnY
	 OtBLoFEdBwJtB5JaTB72A7YtMe8NLVL4N1EhnFjgPd4BM02OM+1hgWDHg8QwFSJX8f
	 NzyIT6Aub3+9Z1Ma7UrmRNkR5Y5HrsJXgPKldEs1H5JlKC7yuKv+nkjSqDQ6uFvA2+
	 ONjQvemGLXFnxL9ZsgE4AVF6CRa4wZ6caQBuADLYKPakjhk2AJAAZu8ZOKvjH4cfXy
	 B5cqLXPKOyNng==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BFBFCF40079;
	Fri, 29 May 2026 12:57:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 12:57:29 -0400
X-ME-Sender: <xms:ecUZar7iMo9hif39UtOs2fN8p1C4Rhrth4DR8WyqRmO-hOAVwhTNQw>
    <xme:ecUZarsSGFd6GQgz3jP7uV574MmcKonw7tHvdl9T8-6gOpjXbbMru6z3aNjs1PA2Y
    vkN0MNNy1lMoPaBctuGJEt6BpJax1jMeKlxlgYHcvMoDhBSMig1Ouo>
X-ME-Proxy-Cause: dmFkZTFbhADjggBGeFpR/9c97921yHw65p80jIVcZgBUPokUv9HpPBi1gSaOJQE8MwX2LP
    UK0e6cbdwHd4KT92YAxVxNvyhYWi4eIiTO42Srh5K+6k/QdSFWhro0QkX/wojZ+tQhv2eh
    8JDWFPUOLasFehay1fwjVb3CpvsKICVmOC//p/B463/Apl+g86TD7crQW2h2jMvLEa2D/V
    A6s3Yuo+k+/kRrw3a6nKpwFrdCavpnX311zpvnFQs6TTbmNca8jN+Fk0uyt77W8k0QtroB
    S0cMCcqaKAEdRxINTd7bFyvmDw1JfTz9g9unx502H8D24zMxm2Z6cfxKmen03DMnC1ywVS
    KfBnckaYTpxV0En0FkBM0wwqmcSmKFuYV3ltYxafbIdXwmG1jQXXsScSvVYkcmC8DwErch
    tr8kDrEU9ouEAiBTSI/Ql07usfV5ZkZJD062pvFH55SlEg/dOMxPt/Xde1w/AeNDqEa2lH
    9KPyt6DltYgylWWkYyQaqJhpMT1aRCvwIo3F2CaAhLf3d9pXJLw4C+ds8yf6dyWSX5+rzT
    9OU4xbUrray9yxwQeCkx6jZfaGGMlE8I1Hdu55I2hfMfPTKJq5mrmWUZUB5KJMT9VZzyHL
    JiTvF+eTxhNZapbeIGeuqVqWmmNqHdE6BcIeFvR3mTScCUiGRQLcwh1jm/Sw
X-ME-Proxy: <xmx:ecUZan2iC1WLInIqIG01kIL0-V-x-T0HM8wl5Nnpz3wA68hHBZgPyg>
    <xmx:ecUZalihk_bOaXQAufoL_3ebGNCO8wU9jJ6wroUjVshkCi868cM4sA>
    <xmx:ecUZao_HG0E9r4lbFyPPmn4z1ZbyFfdn5k2sJlgjHBsGVBi6ZMZDPA>
    <xmx:ecUZahLlnNveeMzMK9DSR6sMvuSQukk-hKFnS15K1UEaVkuhdog5KQ>
    <xmx:ecUZatwkF6HSu03_BTs8zjtBzWsBGwSNbHEkScDEU-H4NHrKVS0VdIit>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 980AA7800C5; Fri, 29 May 2026 12:57:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkbnI7IgJebB
Date: Fri, 29 May 2026 12:57:08 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <5ef47df4-c9f4-4b7a-a493-71be1a95ee90@app.fastmail.com>
In-Reply-To: <20260528-nfsd-fixes-v1-8-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-8-e78708eff77d@kernel.org>
Subject: Re: [PATCH 08/10] nfsd: fix partial-write detection in nfsd_direct_write
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22081-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3ADD5606DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>
>
> nfsd_direct_write() walks a list of write segments and, after each
> vfs_iocb_iter_write(), tries to detect a short write so the loop can
> stop before placing the next segment at a wrong file offset:
>
>     host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
>     if (host_err < 0)
>             return host_err;
>     *cnt += host_err;
>     if (host_err < segments[i].iter.count)
>             break;	/* partial write */
>
> vfs_iocb_iter_write() runs the iter through ->write_iter(), which
> advances the iter by the number of bytes written. By the time the
> check runs, segments[i].iter.count is the residual, not the original
> request length:
>
>     before write_iter: iter.count == original_len
>     after  write_iter: iter.count == original_len - host_err
>
> The condition then reduces to host_err < original_len - host_err, so
> the break fires only when less than half of the segment was written.
> Any short write completing between 50% and 99% of the segment slips
> through; the loop advances to the next segment with kiocb->ki_pos
> only bumped by the short amount, writing the next segment's payload
> at the wrong offset and over-reporting *cnt to the NFS client.
>
> Snapshot the segment's byte count before the write and compare
> host_err against that snapshot so any short write breaks the loop.
>
> Fixes: 06c5c97293e3 ("NFSD: Implement NFSD_IO_DIRECT for NFS WRITE")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/vfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 980217f755b7..619f252af4d1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1380,6 +1380,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct 
> svc_fh *fhp,
>  	struct file *file = nf->nf_file;
>  	unsigned int nsegs, i;
>  	ssize_t host_err;
> +	size_t expected;
> 
>  	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
>  					  kiocb, *cnt, segments);
> @@ -1401,11 +1402,13 @@ nfsd_direct_write(struct svc_rqst *rqstp, 
> struct svc_fh *fhp,
>  				kiocb->ki_flags |= IOCB_DONTCACHE;
>  		}
> 
> +		expected = iov_iter_count(&segments[i].iter);
> +
>  		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
>  		if (host_err < 0)
>  			return host_err;
>  		*cnt += host_err;
> -		if (host_err < segments[i].iter.count)
> +		if (host_err < (ssize_t)expected)
>  			break;	/* partial write */
>  	}
> 
>
> -- 
> 2.54.0

How many filesystems can return a short write in this case?
My impression was that only the NFS client can do that.


-- 
Chuck Lever

