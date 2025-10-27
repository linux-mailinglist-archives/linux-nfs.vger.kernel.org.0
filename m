Return-Path: <linux-nfs+bounces-15706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80483C0F473
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4844213FC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6209C305943;
	Mon, 27 Oct 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNzYL6hu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E190311966
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581912; cv=none; b=rL/4De0dzdcPLTykvTsdd9BZ/DU2X3PjtN94laNg5GX9c/b9Gj/m+vRo+wTce2SFvVCkTp9AVZBCT8q+zlNHipJSu16VBw4WeqTQAHDMr60jCVw00gO4nIz+qi9WQ49Kr0LBTtI/xhDzBOEheRtpuRT+2+2oiI5Cl7qnl0+VgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581912; c=relaxed/simple;
	bh=GV+S0fHej1dGQOGMFiUwq5i3SFkg6q1Zu3o4FZ+yjAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGwTOBlSdg8N7Uc+9JP5h+6K+9r6tCs/uVql/Vye1YKALfmTb7pTysvuFIgsGtXj/CWFgaGIHFHzFqqPHJwCqEgDJlG9F2m6Z5IyfADJqUnIG/0fntGFJWoMTNTSi3nZUB+F7KP70H2jKcOxi+eL3CmAmzzQM5T5gyG4jH7mFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNzYL6hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C29C4CEF1;
	Mon, 27 Oct 2025 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581911;
	bh=GV+S0fHej1dGQOGMFiUwq5i3SFkg6q1Zu3o4FZ+yjAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNzYL6husLUXJgMxRNaCBkjWTVD8gHwCiPpCdGOpQjVREF2IZNi8MZuq6aqmt1gVi
	 X2uOmu/TGp/buQ80xfWGFqjSdqicrqxn+zZcJJuVfnG14pXS0HnWZQmAiNlTn+v5Vm
	 +ED/eVfh4m75ySvUCd5VSMqaXGL7qhKtUp9G6b8cFztnjJVGrZxaAmvW5MpdkPR/km
	 SycquEku0oVQB4SJk1DyyiFwaofdQrD9x5u/g6QB+E4oUQwHNcGFglu9dhZ7YUL43f
	 PMoK2qY3h7X5SKkuFN03DOZ+JBun5phMR0YDNN3dMlhzYyk7CqgkEo7U+WmHmgU+FG
	 I4ZRFMMRK6Vyw==
Date: Mon, 27 Oct 2025 12:18:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP-bVnJ-teH1x5eK@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>

On Mon, Oct 27, 2025 at 09:48:23AM -0400, Chuck Lever wrote:
> On 10/27/25 6:50 AM, Jeff Layton wrote:
> > On Mon, 2025-10-27 at 01:15 -0700, Christoph Hellwig wrote:
> >> On Fri, Oct 24, 2025 at 07:56:59PM -0400, Mike Snitzer wrote:
> >>> Really, even ignoring all the quirkiness of this: that O_DIRECT can
> >>> fallback to buffered, and we need IOCB_DSYNC|IOCB_SYNC for our use of
> >>> buffered IO when NFSD_IO_DIRECT configured to ensure data has hit
> >>> stable storage -- that's enough justification.  Bit circular but
> >>> compelling to prove the need.. albeit wordy and a lot to unpack.
> >> You always need IOCB_DSYNC for data to hit stable storage, both for
> >> buffered and direct I/O.  You need IOCB_SYNC in addition to also sync
> >> out the timestamps, which I think we now agree we need.  I still don't
> >> understand why using direct I/O implies that we want NFS stable writes
> >> and not two-stage writes, though.
> > That's certainly a possibility too. Consider the case where we have a
> > WRITE with unaligned parts at both ends. This set so far just does the
> > ends as synchronous I/Os.
> > 
> > We could do the end bits as non-synchronous writes, and follow up with
> > a vfs_fsync_range() call before returning NFS_FILE_SYNC.
> 
> What concerns me a bit is that the code that handles unaligned ends
> is careful to issue the vfs_iocb_iter_writes in file offset order. Are
> we OK to use IOCB_DSYNC for the unaligned parts but IOCB_DIRECT +
> subsequent COMMIT for the direct I/O middle segment?

LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
middle (via AIO completion of that aligned middle).  So out of order
relative to file offset.

That has been working well with LOCALIO.. though I did just post a
patchset today that fixes some quirks of the implementation that got
flagged for KASAN use-after-free.

(But now that I look at LOCALIO misaligned DIO code, it actually isn't
even setting IOCB_DSYNC for the misaligned head/tail... needs fixing.)

