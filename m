Return-Path: <linux-nfs+bounces-11678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AAAB5443
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C1C1890DC4
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD93246773;
	Tue, 13 May 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3+3tAM7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171B2376FC;
	Tue, 13 May 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137928; cv=none; b=rfOg6CBxqjlIirHb+jY7Y5m0N+7OJLuS+K3NAL8QCAZRC8H5/tOc852FJ+Bwi2U7ETMAfljXcKHD+fW3cF5ZPEJcA3T8Eb9QU9glRym3M8Pa6xOSIIil5+moZLL0uQ6r/LDpV9dTFcmZSyiANaka19o8Iyi5qW+sEVZ6UWlKNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137928; c=relaxed/simple;
	bh=F72S156QU5M+rltDthu0xlwgjIND3s2ZVkwWU1Og3hA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4RwzJgCG6aJPn6xOYPyuNfDDFNZ0ZlxXRJcFOz2KQfIdlhAiOr4XMpdyAetvGfs+BQ9/4EuBAgI9Rl11mpw+vSpPFTIye0AJlHC+bzXaWg0wc5cA6hbsENIssi++mGE8Yj4YbfDVYN3rJ7DkdtuxkIgi7rsFHKh3MahJ56OHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3+3tAM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E4C4CEE4;
	Tue, 13 May 2025 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747137927;
	bh=F72S156QU5M+rltDthu0xlwgjIND3s2ZVkwWU1Og3hA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X3+3tAM7uX7Y6MWatHCMUpAs/6sXbzpOS8V6oC9tp/Id4BkqZysZ8scYwx3mv+sHz
	 hIhxHUEBq14Y0xMqmYRdbL/omOvQ0jAhimhigeF2X/Cc1MJGYISF1Ug02Axokqbwu8
	 sgl6RByMloRYvNGm2AgMUeJAfC8JXshJH1HKqRhic8hgv9o6wdUT+2eX+u51RHhjY/
	 POnPMVsYvFDuoSlBk44Pv92RjQvGNHpODJAik5+pdBkXzM1warvolV/yPXfRbSBN8R
	 AklvkPt0LeuC6N8XqS0cRNfEEhYO4NhlCpW8HnvAHHo2ZW7DW5NY3vmD27Y1i58/xS
	 KOl/X0WoPainw==
Message-ID: <38a43a63e9b1b9bce998184693d1c31130178127.camel@kernel.org>
Subject: Re: [PATCH v5 00/19] Allocate payload arrays dynamically
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Tue, 13 May 2025 07:05:26 -0500
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 15:03 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
> need to do something clever with the payload arrays embedded in
> struct svc_rqst and elsewhere.
>=20
> My preference is to keep these arrays allocated all the time because
> allocating them on demand increases the risk of a memory allocation
> failure during a large I/O. This is a quick-and-dirty approach that
> might be replaced once NFSD is converted to use large folios.
>=20
> The downside of this design choice is that it pins a few pages per
> NFSD thread (and that's the current situation already). But note
> that because RPCSVC_MAXPAGES is 259, each array is just over a page
> in size, making the allocation waste quite a bit of memory beyond
> the end of the array due to power-of-2 allocator round up. This gets
> worse as the MAXPAGES value is doubled or quadrupled.
>=20
> This series also addresses similar issues in the socket and RDMA
> transports.
>=20
> Changes since v4:
> * Replace the use of rq_vec instead of allocating it dynamically
>=20
> Changes since v3:
> * Improved the rdma_rw context count estimate
> * Dropped "NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize"
> * Cleaned up the max size macros a bit
> * Completed the implementation of adjustable max_block_size
>=20
> Changes since v2:
> * Address Jeff's review comments
> * Address Neil's review comments
> * Start removing a few uses of NFSSVC_MAXBLKSIZE
>=20
> Chuck Lever (19):
>   svcrdma: Reduce the number of rdma_rw contexts per-QP
>   sunrpc: Add a helper to derive maxpages from sv_max_mesg
>   sunrpc: Remove backchannel check in svc_init_buffer()
>   sunrpc: Replace the rq_pages array with dynamically-allocated memory
>   sunrpc: Replace the rq_bvec array with dynamically-allocated memory
>   NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
>   NFSD: De-duplicate the svc_fill_write_vector() call sites
>   SUNRPC: Export xdr_buf_to_bvec()
>   NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
>   SUNRPC: Remove svc_fill_write_vector()
>   SUNRPC: Remove svc_rqst :: rq_vec
>   sunrpc: Adjust size of socket's receive page array dynamically
>   svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
>   svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
>   sunrpc: Remove the RPCSVC_MAXPAGES macro
>   NFSD: Remove NFSD_BUFSIZE
>   NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
>   NFSD: Add a "default" block size
>   SUNRPC: Bump the maximum payload size for the server
>=20
>  fs/nfsd/nfs3proc.c                       |  5 +-
>  fs/nfsd/nfs4proc.c                       | 10 +--
>  fs/nfsd/nfs4state.c                      |  2 +-
>  fs/nfsd/nfs4xdr.c                        |  2 +-
>  fs/nfsd/nfsd.h                           | 24 +++----
>  fs/nfsd/nfsproc.c                        | 13 ++--
>  fs/nfsd/nfssvc.c                         |  2 +-
>  fs/nfsd/nfsxdr.c                         |  4 +-
>  fs/nfsd/vfs.c                            | 67 ++++++++++++++------
>  fs/nfsd/vfs.h                            | 10 +--
>  include/linux/sunrpc/svc.h               | 46 ++++++++------
>  include/linux/sunrpc/svc_rdma.h          |  6 +-
>  include/linux/sunrpc/svcsock.h           |  4 +-
>  net/sunrpc/svc.c                         | 80 +++++++-----------------
>  net/sunrpc/svc_xprt.c                    | 10 +--
>  net/sunrpc/svcsock.c                     | 15 +++--
>  net/sunrpc/xdr.c                         |  1 +
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 ++-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++-
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 +++--
>  21 files changed, 170 insertions(+), 171 deletions(-)

This all looks good to me. You can add this to 8-10 and 18:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

