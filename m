Return-Path: <linux-nfs+bounces-2819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BCE8A5986
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 20:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71061C2255D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255213A895;
	Mon, 15 Apr 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/HnPyWk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31321E877;
	Mon, 15 Apr 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204202; cv=none; b=T+lVWR9cK8vb1xNBej/rGROdLFkWXqax2BlINTs4+FqU3KEk64EKuSamGaGuvRn83aISSa1O7bRbYppttsHlwAxIE9dQDlEBWX2DBXR6e35W8T2+2i2PW+naQrtI/kyUgwc58JE9Hd9cOsaXlrEaVlm8c8OLEnzwzNvPcBpsQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204202; c=relaxed/simple;
	bh=3GqZpk7DoO2fxKbi2ufcnw0GZVZyswnxL6e6C+xYNak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaCOObMLGqpyyEjFx6qWsxk8k32z2BnNZOzcnb8Q6w+F+yxGOyoHQiZKiQoqd/O70wlxRmNEJ5g5JngVZ7eodDJl98FKjqEHUMcnoUuNJR1DKKv8Jl/HlXekI/LtINYpHLObNfjdDzTIiP/zmIIOgMORJ7pxbQXE6b/OpvExIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/HnPyWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2AEC113CC;
	Mon, 15 Apr 2024 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713204201;
	bh=3GqZpk7DoO2fxKbi2ufcnw0GZVZyswnxL6e6C+xYNak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/HnPyWkefDzuZn5kJANBCiahieYSINa5oAs81pVYGglRtgqHUvOsL0OskwcFqq3U
	 MF5i8Lbq61xwnxWhd7zlBQm/MhvNeSny+70bUddW5jijxey+R9SS1VqFKDifYvpmXZ
	 LC54gaapvlVt63LIimJ3IgR7XJPRLX3KceXCCQ74MOBgsudfxjvfQt9QpwZYfNBECB
	 zTTo1D5DUJ1qmEBXwkCs0ogxSulROG8FVrqOtPYwvFjhHBND+bA0i75qPy5HLfkdn5
	 i5bu9u45DQWRCkiGbyRho7LNSKmrU0A0mDIIRnmYrRnF+vC1w8ykO72u1kTIcqmgNm
	 1eCMrJsH9Du5A==
Date: Mon, 15 Apr 2024 11:03:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7 2/5] NFSD: add write_version to netlink command
Message-ID: <20240415110320.0291ac00@kernel.org>
In-Reply-To: <bd85d1a774cb362ab9f70ac6a2af70d9ed7a309e.1712853394.git.lorenzo@kernel.org>
References: <cover.1712853393.git.lorenzo@kernel.org>
	<bd85d1a774cb362ab9f70ac6a2af70d9ed7a309e.1712853394.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 18:47:25 +0200 Lorenzo Bianconi wrote:
> +			attr = nla_nest_start_noflag(skb,
> +					NFSD_A_SERVER_PROTO_VERSION);

The _noflag() version is for legacy code, I think you should let 
the nest be marked appropriately.

