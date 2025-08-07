Return-Path: <linux-nfs+bounces-13473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C450CB1DB06
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D8F726FD3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BE25A352;
	Thu,  7 Aug 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoZt5hKr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B31C5D72
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581809; cv=none; b=qTiAPBMxVJh0VXMJQKCGS2gNKnhzSHyF4IRaCxmhACUf0odJDQM0ToaDzTb1sGBh5Ty98CDhB5rFvi0ortKnGCmEl9unX4tEYKNiGgAFDceGItRJmeeLjgjyVzA1fU2SR5McgoQjpq4d5hdBD56J8BvUbGOLDNSDcBZGV3ARygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581809; c=relaxed/simple;
	bh=RWgrfjRxliNtbmV9T/ZSo6KgsZjVoQUGYD1R5gzsk5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgoq+L5QMN+7IEC7aP3Uv018XavNz+J+ShmWZh4Rgp4/TMr/xZLZCAmPf0ICCJCD5AkmPCIqF55O5NbmwWPIU+AXJLduwTmfnDJ6UzcizELDud2rNucR3dcRtd4QHb18gBOGVIFOE2ctGV2kntimzyo81Mn8ysAXgHDTUp0ZZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoZt5hKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F73BC4CEEB;
	Thu,  7 Aug 2025 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754581808;
	bh=RWgrfjRxliNtbmV9T/ZSo6KgsZjVoQUGYD1R5gzsk5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoZt5hKrHYnlsI0OyzpLWhTSzS1QQCAWLU/sQxdgtnzjEpqRGg+weo9NmVOPO/ZVB
	 qwzELDLkKgzPut79UeA+Xp3CuRxMZz437RZYAzTe7CzczSb1XWNjNAoHO+W9gALVaO
	 LXwfK6l5y0cA41iUHFbVTSnYhgjJOkO8dAW4xIOe+0lCAtmSubpuw8JZB6qpadwfgV
	 bX+k8HJAnHvCNXemTSfxLbgIeixR66lTH5Zs7Yhh8jss5fG5SxC/gkbebkDjm1wETB
	 dUfND93bdwEbCDsoUUJvmP7ur779aKmDiCoJCsViKcZcEM+2KEUlTtzefL89b2s+Q+
	 qCWykKErCSZew==
Date: Thu, 7 Aug 2025 11:50:07 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: sparse warnings with nfsd-testing [was: Re: [PATCH v4 1/4] NFSD:
 avoid using iov_iter_is_aligned() in nfsd_iter_read()]
Message-ID: <aJTLL6z0OVZ1k_XC@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-2-snitzer@kernel.org>
 <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>
 <aJN7dr37mo1LXkQx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJN7dr37mo1LXkQx@kernel.org>

On Wed, Aug 06, 2025 at 11:57:42AM -0400, Mike Snitzer wrote:
> On Wed, Aug 06, 2025 at 09:18:51AM -0400, Chuck Lever wrote:
>  
> > Before reposting, please do run checkpatch.pl on the series.
> 
> Will do, will also ensure bisect safe and that sparse is happy.

FYI, I'm preparing my next patchset and sparse is happy with it, but I
wanted to share these warnings seen with nfsd-testing through commit
ae83299cc048e ("NFSD: Fix last write offset handling in
layoutcommit"):

fs/nfsd/nfs4state.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h):
./include/linux/list.h:229:25: warning: context imbalance in 'put_clnt_odstate' - unexpected unlock
fs/nfsd/nfs4state.c:1188:9: warning: context imbalance in 'nfs4_put_stid' - unexpected unlock

I haven't looked at them closer. Could be you're well aware of them?

Mike

ps. but full disclosure, my baseline kernel is 6.12.24, I haven't
tried sparse against the nfsd-testing branch itself (which is based on
your nfsd-6.17); but my 6.12.24 kernel does have all NFS/NFSD/SUNRPC
changes through nfsd-6.17 + nfsd-testing commit ae83299cc048e).

