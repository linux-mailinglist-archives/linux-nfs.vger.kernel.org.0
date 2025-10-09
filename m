Return-Path: <linux-nfs+bounces-15102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64CABCA6AE
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC93E480EFE
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA32367CF;
	Thu,  9 Oct 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHIVEewt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD092227BB5
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031996; cv=none; b=GRAZGUMbAxLY9ubP3k08Q/e3Jieawht5uXYNLeF3/Rgo60PNJNkOeh2LmYikRIDjfcAjl8OgAhLZEBs1WwNMklVq03eYfJXTIRBZU8b96dpVu6g+qaXMruBhWR8HtKCjOBVGq0ksSYXumGE6r4f5ilLlybQ4y8byZezc2XrKXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031996; c=relaxed/simple;
	bh=NDjGZzVJklLAvxR2AvMGLoSW+BQEZcXv8fGDGk6MPXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxopXaBXTRnGtjZckCb46VIVEPf+C/KwRH7PiGjYoegw2Yy/TAsefbs9diiHZA+H6wIA9o0JklPtT5PX7fIDhJtGDBUuwQFQYpJB1dYs2w44eb8HqsydloRoBQUrA4Lia53nyGEihnDRCeKsOD3DDQ7hRCKw6bB6KYO8iS2p2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHIVEewt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6984FC4CEE7;
	Thu,  9 Oct 2025 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760031996;
	bh=NDjGZzVJklLAvxR2AvMGLoSW+BQEZcXv8fGDGk6MPXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vHIVEewtUnDqTG1q7UjFZUZ0cztJJjKA7ekgDzmDi5ulDB2cZbfbCQseQ53FZlllJ
	 nVbIU+kb/ubCL2Xb/eYfvySjroMtk3Ko96QijqWSt2MLEusaPjcb4x5TP9ipk5NIZ/
	 wcKwCTteaoGACVcBWzbSMAD8JlWdSPDt/YLiGCoTRs2t4c/XEPsWsw/vQfPiX6lpAM
	 FGw1cr2A+kgdSGT5Ru7sQzDgU1bMzXjymZt7aQUJ25UiopQpKuVHaPMaiRG1tmNUde
	 P2k212IBEu1pNn9j7LTlkmmMj0MHaav7pxpt152WZJMSdesKXxVJYCdsp9TWyJMRAa
	 vLKFmGWEDYZlQ==
Message-ID: <338ffe90-19ee-4185-9668-41e3a79d8851@kernel.org>
Date: Thu, 9 Oct 2025 13:46:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <aOa0ijW1h-1tynWD@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aOa0ijW1h-1tynWD@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 2:59 PM, Mike Snitzer wrote:
> +
> +static noinline_for_stack int
> +nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  struct nfsd_file *nf, loff_t offset, unsigned int nvecs,
> +		  unsigned long *cnt, struct kiocb *kiocb)
> +{
> +	struct nfsd_write_dio write_dio;
> +
> +	/* Any buffered IO issued here will be misaligned, use
> +	 * IOCB_SYNC to ensure it has completed before returning.
> +	 */
> +	kiocb->ki_flags |= IOCB_SYNC;
> +	/* Check if IOCB_DONTCACHE should be used when issuing buffered IO;
> +	 * if so, it will be ignored for any DIO issued here.
> +	 */
> +	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +		kiocb->ki_flags |= IOCB_DONTCACHE;
> +
> +	if (nfsd_is_write_dio_possible(offset, *cnt, nf, &write_dio)) {
> +		trace_nfsd_write_direct(rqstp, fhp, offset, *cnt);
> +		return nfsd_issue_write_dio(rqstp, fhp, nf, offset, nvecs,
> +					    cnt, kiocb, &write_dio);
> +	}
> +
> +	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
> +}

Handful of initial comments:

The current NFSv3 code path, and perhaps NFSv4 too, doesn't support
changing a WRITE marked as UNSTABLE to FILE_SYNC. I'm not seeing that
rectified in this patch. I have a patch that enables changing the
"stable_how" setting, but it's on a system at home. I'll post it in
a couple of days and we can build on that.

In nfsd_direct_write we're setting IOCB_SYNC early. When falling back to
BUFFERED_IO, that setting is preserved, and the fallback buffered path
is now always FILE_SYNC. We should discuss whether the fallback in this
case should be always FILE_SYNC or should allow UNSTABLE.

Nit: I'd rather use the normal kernel comment style here, where an
initial "/*" appears on a line by itself.


-- 
Chuck Lever

