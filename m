Return-Path: <linux-nfs+bounces-15537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E63BFE059
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F33B189497A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FED2749C4;
	Wed, 22 Oct 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV0xjOAn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA62F1FCF
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161224; cv=none; b=R2A/8kuTd/V/0GaL/wMD6fJjbroSSlRCT/D8avBl4QiATfUp8SUVz4HIXsbdg0w9EV89aCt36hTtCdkGQINJ2Sq5N1ELPR3evSUFe1Wa5XUx5GORW6yBJOdkwGBBttF7EnKTPTrVLVSsArUm/2KZbnSLEB+RTv9+qr8nj6IGMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161224; c=relaxed/simple;
	bh=ZMtm6twxeF2js/LMxUy8oWSvoiLIzGO6Js1WmlSl7XU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RzZUNU5Tm0vTyY7Z0T8TBLrgthwXmY4NkeFDw/1vlLianXDQSHLHUlmWrp2PvJor5hsVMjO0tI7V0wtWAbIO8HaDbu0REf30kYzQVMvLu+Bv+6KMbw8+/VHchWiwUOgxLc9SrGvD7deVQu9O6uMeZSIU0K33nopb9a20vkllRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV0xjOAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E6DC4CEE7;
	Wed, 22 Oct 2025 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761161224;
	bh=ZMtm6twxeF2js/LMxUy8oWSvoiLIzGO6Js1WmlSl7XU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SV0xjOAnVx/oaJIrblcwjMErH5lrVH0PCQLvg80DGU8eCWfcZkN9sefOWa/OEWXUi
	 1R2+ZeYMuyEzBN91QLRWVHyQ5mGCAKdLvjsOYwT4rE87KLX45c7h1MOsgitU55wkW4
	 Vl00tUMIFkoD6/NNVH5DapOGasQhnK7A6oqWe0DO4/Ho7yVGYp3XPBZO87WfoGJKkk
	 O5jp1pvh7yCsZ8v0hmJ2dQJgSFXi4Zi1sutNCJqU1PM60OeKR1w5/0M3MhCWIQEIyU
	 kvPCg8NFi8UR26Rd9ULHHTTT8ONaoSuA3RWTyTSktUYZ93gpzO5bB+MgcmiZhd24rr
	 L5PgkwfCgreAQ==
Message-ID: <47c1ef78-4864-49bf-99c3-7a0112bca01e@kernel.org>
Date: Wed, 22 Oct 2025 15:27:02 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251022192208.1682-5-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 3:22 PM, Chuck Lever wrote:
> @@ -1311,6 +1484,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (sb->s_export_op)
>  		exp_op_flags = sb->s_export_op->flags;
>  
> +	/* cel: UNSTABLE buffered WRITEs might want some form of throttling
> +	 *	as well to prevent clients from pushing writes to us faster
> +	 *	than they can be flushed onto durable storage */
>  	if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
>  	    !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
>  		/*

Note: the above is an open question. I don't intend to merge this patch
with the above comment included.

-- 
Chuck Lever


