Return-Path: <linux-nfs+bounces-14694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B13B9B91F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D788F3278EE
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C423957D;
	Wed, 24 Sep 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWcp2zHV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5920E6
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740181; cv=none; b=jzORe03hNao/QCuUcW1lJTDSreTV1j0QfO0n+26j+XwMnE+16BivHrXf24znyDqZcm/ysqFPZ+/3by+gMXudYYRiFPYmpK8YAcDFy7bG7b/WgaN2m3gwyiCxcZ0Nydb4yRadiBGwbzky5oGcsqs1Z2M2QO51UBdbDfaa3kRpqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740181; c=relaxed/simple;
	bh=lMhTvkO8dGwUlVTNt8o0UJUKsJg3OHuZKJtY8n9AoXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhLaqlkhI9+3ValgQSAwnEFKPRn8Dc8HwopyPCONnyAbJnjj8sp5983131jRLBi0x+x2Oc7cZHSNN74ZE32ekhUi5MNncttA1HUfQZo1R92NVXyvg/59m7ITYToDAch8+/wAamEAiI155vh10jiyLDja2pOEJEZGO39u8GF8aHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWcp2zHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2225EC4CEE7;
	Wed, 24 Sep 2025 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758740181;
	bh=lMhTvkO8dGwUlVTNt8o0UJUKsJg3OHuZKJtY8n9AoXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWcp2zHVA49YvKjBiYDh7CurGNsBBLosajpWVZmK+W0BNvpBbtI2AwxBpYkRG4xiF
	 Z8F4vKa4No1RtzxrhbB7U8gng+GpZYbiWYzS4CQQT5yke+rg9kOjACXq77CHLEa9bX
	 Ns+zQcN00em/Ye12X4uzwZUVVVmC/yfSBx8X8jwkdzCRnoTMBgxs+FX8ghNbHizSrQ
	 M5jGkREPRExwiPKO7oXk7yEFtD7sXk5rcGsmw+BZjkgKV/4lQve98SGXVQAcE4fM93
	 LW1gfToisAkZ7vhxfhnO3c1nqT+fLJz7EPNotFag7IQYAfOy2rPnh+AlHBl8qdkQUd
	 /iW2ZYsi8GyeQ==
Date: Wed, 24 Sep 2025 14:56:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>, Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ (v3
 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS
 READ"]
Message-ID: <aNQ-1OSG9Ti5XbUm@kernel.org>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org>
 <aNMei7Ax5CbsR_Qz@kernel.org>
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
 <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
 <aNP8U48TjSFmRhbD@kernel.org>
 <aNQL3fFzFZIL3I4u@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNQL3fFzFZIL3I4u@kernel.org>

On Wed, Sep 24, 2025 at 11:18:53AM -0400, Mike Snitzer wrote:
> 
> FYI, I've been testing with NFSv3.  So nfsd_read -> nfsd_iter_read
> 
> The last time I tested NFSv4 was with my DIO READ code that checked
> the memory alignment with precision (albeit adding more work per IO,
> which Chuck would like to avoid).

We could just enable NFSD_IO_DIRECT for NFS v3 and older. And work
out adding support for NFSv4 as follow-on work for next cycle?

This could be folded into Patch 3/3, and its header updated to be
clear that NFS v4+ isn't supported yet:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 96792f8a8fc5a..459a29f377c2c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1182,10 +1182,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case NFSD_IO_BUFFERED:
 		break;
 	case NFSD_IO_DIRECT:
-		if (nf->nf_dio_read_offset_align &&
-		    !rqstp->rq_res.page_len && !base)
-			return nfsd_direct_read(rqstp, fhp, nf, offset,
-						count, eof);
 		fallthrough;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
@@ -1622,8 +1618,14 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	file = nf->nf_file;
 	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
-	else
+	else {
+		/* Use vectored reads, for NFS v3 and older */
+		if (nfsd_io_cache_read == NFSD_IO_DIRECT &&
+		    nf->nf_dio_read_offset_align &&
+		    !rqstp->rq_res.page_len && !base)
+			return nfsd_direct_read(rqstp, fhp, nf, offset, count, eof);
 		err = nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
+	}
 
 	nfsd_file_put(nf);
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);

