Return-Path: <linux-nfs+bounces-11496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5FFAAC6D5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000971BA7A7E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF401A08DB;
	Tue,  6 May 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCaPk2JW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DB208CA
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539158; cv=none; b=sJ3EcRA5uvl0Zcb0kmjs5Bs5v/COQkcvbf54/15w8M2bMIEqkIonyXE8yk0cuRmlYtFRJkdHyoZbTguAKBaNfqidWvcIQPB8hnMZ6W2kaiuWzCe7VIXEPWIBRJErrySXRS69qryVneTU/mvE74OwNXvA/V7FaOXVvnJ2kNRzqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539158; c=relaxed/simple;
	bh=jX9co9WktYRxRDfgQRvqFBjDWZWxrEEgVI3/t4wV8Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDxTcRwgMP1WReK6vWLk2Tqg5hf9Q+yM7Vqm/QJ2+HQQP2079p4e+ynTJtwoU+AYumPNqELLf+nRvOZwSMiuDV0JPGp2xezoVfUmjH5nq8XAerZ9tUq39AD61kQMsYoJL8KJ88pyu41MGHYSWCDCK+hwycM2LciquWBbPEN7plI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCaPk2JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CA2C4CEE4;
	Tue,  6 May 2025 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539158;
	bh=jX9co9WktYRxRDfgQRvqFBjDWZWxrEEgVI3/t4wV8Pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UCaPk2JW3er1W5rTJ1FGFkWzd5zfyzfC2gtNn0QKyHzytDL9swbwQZ41keZgSdT29
	 vXN/34k9IMmLZY2Ttdtc2A8C9TT+fopp4GN5qzLEFAuSjn73kArtD0GMJVCqhiF2LS
	 nYvkMdZ5sLQlRLMyUUFF0TGs1duIXE6UFaBX47YmdK95qxZF+eVOLXrKVT3FHqyy93
	 iW8hxpzdxGjzKqniHasTYrWKcuiLvoEsXO0P1n5bXBcSoZfJKVNuz2Mu16MYOZt3wb
	 w7Q1JXsWL1l02JIaFlFyywFgnwxP8gdr+FOoSb88QGUaYq1LOFLMx4GReTPN8VVIv6
	 PsHf+Fh9TwDug==
Message-ID: <1fb2ff54-9e49-4697-9485-5323791a0f9b@kernel.org>
Date: Tue, 6 May 2025 09:45:56 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Roland Mainz <roland.mainz@nrubsig.org>
References: <20250427163914.5053-1-cel@kernel.org>
 <aBnD6Wj1yq9MP8ZB@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aBnD6Wj1yq9MP8ZB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 4:10 AM, Christoph Hellwig wrote:
> On Sun, Apr 27, 2025 at 12:39:14PM -0400, cel@kernel.org wrote:
>> NFSD can return 0 here, as at least one client implementation we
>> are aware of (the Linux NFS client) treats 0 as meaning "CLONE has
>> no alignment restrictions".
> 
> Usually clone does have a restriction, though.

Then should this patch extract that block size and report it? Pointer
to sample code would kickstart me to get that done.


>> Meanwhile we need to consult the nfsv4 Working Group to clarify the
>> meaning and use of the value of this attribute.
> 
> Yeah, the attribute seems to be severely underspecified, i.e. it does
> not even provide a unit that the value is in.

Agreed. Everyone is /assuming/ bytes, for now.


> I think the only sane way out is an errate that makes 0 mean
> "not specified" and then provides the byte unit and maybe some
> other quirks.
> 
>> +	/* Linux filesystems have no clone alignment restrictions */
> 
> That is absolutely untrue as said above.

-- 
Chuck Lever

