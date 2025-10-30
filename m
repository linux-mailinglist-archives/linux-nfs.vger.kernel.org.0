Return-Path: <linux-nfs+bounces-15798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E2C20F31
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C34EC8CB
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55EF21CC64;
	Thu, 30 Oct 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYi97nlH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119672639
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838382; cv=none; b=bdGRZFglaBKNXHBt7Te3ngHToPLAVvYZUChREdSq865px0XcGrxoOU89cd6CCGSOr/XHG6hHVwUZahjWzP84iYW3/eTBg6UnU9XVLU9Jt3Fp/T25ZVHtRbWmp8MK3JvtYTgTR17o40vcGld573XA95mx3REaXc0bEZ/LByA5230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838382; c=relaxed/simple;
	bh=XGX2HG4oeOPvIIt+bhMPA4vAK4QhetNxefXvx6tBm8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIwC/e4Z3Pg7aeoYMp9v7vz3EG69D3PvdK1JhphbMhY99zc3eOXcSbzghzDghEFRVn2ovepw1d/eU8tMbj57uLF6SHUYgaPFpRbTEbrWHtwfQNHv7V4iRcWcQ4qQkoLmIAUXBJYRMGHVfE++jkgJ0RARf9qGv98735rVInGoiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYi97nlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1CC4CEF8;
	Thu, 30 Oct 2025 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761838382;
	bh=XGX2HG4oeOPvIIt+bhMPA4vAK4QhetNxefXvx6tBm8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYi97nlHo2wFhEmBIIN2YNRGRFw7/qaehYbDYScmZ1NLb6t5zqtyFuoWcLowMHZOO
	 tX6qfV5TLXGuBLWp4A3YzDLTRQUHFyUxaFCC+5rkYV46sB4bGDKfPm3BFBpZOupDZz
	 klqhaKFXaCQchCwKiRZ7awq+9nmDmSoHdpUXHRdreHfz9Ye9DTlBIf/+dblaG7FmnJ
	 ExmLQKA2D1VQvzxF+NM3xyxFDSt6E7A8Oud2Ke62WgbHXg7d6cB5g1Qa+NvGKH6IG7
	 rkuYNRVhG7EZ9dBMO5VBK93eZW5Q9MTLSKL64gE7D1EVQxRb6r0ZdA4Sl3Q1rTtksM
	 c+nCI6D1ISsXw==
Date: Thu, 30 Oct 2025 11:33:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
Message-ID: <aQOFLMJzUZuwj_K7@kernel.org>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQN0Er33HIVmhBWh@infradead.org>

On Thu, Oct 30, 2025 at 07:20:02AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 30, 2025 at 08:56:38AM -0400, Chuck Lever wrote:
> >    Either the underlying persistent storage is faster than most any
> >    network fabric (eg, NVMe); or the network connection to the
> >    client is very high latency (eg, a WAN link).
> 
> NVMe really is an interface and not a description of performance
> characteristics.  Nevertheless none of the NVMe implementations I
> know have lower roundtrip latency than modern local networks.

Sure, but not all modern networks have the same level of performance
either.  When the NVMe is faster than the network we don't see nearly
as much MM pressure.  But that implies the network is the bottleneck, so
reducing network operations (like COMMIT) should reduce network
traffic (even if marginally).

Once the network is as fast or faster than the NVMe devices, that's
when we've seen VM writeback/reclaim with buffered IO become
detrimental (when the working set exceeds system memory by a factor of
3:1).  And that's where NFSD_IO_DIRECT mode has proven best.

> > This patch is a year old, so won't apply to current kernels. But
> > the idea is similar to Mike's suggestion that NFSD_IO_DIRECT
> > should promote all NFS WRITEs to durable writes, but is much
> > simpler in execution. Any interest in revisiting this approach?
> 
> This is a much better approach than overloading direct I/O with
> these semantics.  I'd still love to see actual use cases for which
> we see benefits before merging it.

Yes.  Also thinking that a "data_sync" export option would be
appropriate too (that way to have the ability to try all stable_how
variants).  Chuck?  If something like that sounds OK in theory I can
rebase your patch (still attributed to you) and then create a separate
to add "data_sync" and then work to get the permutations tested.

Or the export option could be stable_how=[unstable,data_sync,file_sync] ?
(knowing that this export option would just set the stable_how floor,
NFSD cannot downgrade NFS client specified stable_how as per the spec
Chuck pointed to before).
(but that ushers in collision with async and stable_how=, so maybe
best to just go with discrete export options? or confine stable_how=
to being able to set data_sync or file_sync?)

Christoph, if you have canned benchmarks that do a solid job of
showcasing overwrites (which you expect to really benefit from _not_
having DSYNC or DSYNC|SYNC set) please let me know.

Thanks,
Mike

