Return-Path: <linux-nfs+bounces-9833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4613A2563B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9495A18835E4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E021FF7C8;
	Mon,  3 Feb 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsr2jO6y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566D1C3BEE;
	Mon,  3 Feb 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576035; cv=none; b=YrBFTp1zzvUaWEVot47D4QcFOUeudta2P8kmQQ8SOHKzhMnyaHYYne0oYiVhqjbxN1oGiqKqstBkuja4C6eJcc+q7s9u8B6JP4dSvavjJNwBI4zT+x9wR+I03KioWWsrILVg2V9sTnsiTLcPXTF5BRU9zPkgCgkPQuocO7nzGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576035; c=relaxed/simple;
	bh=preOyL5kHdyL7tBNTFgKwAqHkKBczlLmjwWmwEW6PuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRodNZMk3OLpxKXvwjh/fqZt/LJuykA2QXhKQhkMyhXay9zZSPLPvbm9wfnzyIkgvHTDktp7OM1rAxApQizFCME6llv0JZnnySqsMFCe4aXTe3tRxSZ9iWy2002wnJ54DvB+XceAxJbBJxPNfDoDvIS3W+LLvc2ojZlizVurMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsr2jO6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C244C4CED2;
	Mon,  3 Feb 2025 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738576034;
	bh=preOyL5kHdyL7tBNTFgKwAqHkKBczlLmjwWmwEW6PuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lsr2jO6y2tpBx+WTk6VZaoCZqZl9EiHuKnCeedS6Q/RJrLleQMwSf86IChjqNVCHS
	 EktuaRLfY+OqH60IlA5x52J804a5ufv0ayUPb3CDOAKHQ7NxuUnm5FW5nACk5yzi2X
	 2S3w/th/ICjQbJQDQcc4fOLkw4+uf71udY7pokeBj99lpqE5Ix9yzBJl/ysysb/4K9
	 Yv13Sl2Np5BEqL3TM44yoW/rLFWskFqxewFVCqBA1Xcy3E44nLQJPcUeIOHIRr0GFb
	 7wTYua7M+6RGR1WS4oIaZa81iS3ee7iRFGn1nFO/OkHMLgwcRHifSHnkdC2fNHQL5G
	 Nkr2osGUg8oAQ==
Date: Mon, 3 Feb 2025 09:47:08 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove unused make_checksum
Message-ID: <20250203094708.GA234677@kernel.org>
References: <20250203020743.280722-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203020743.280722-1-linux@treblig.org>

On Mon, Feb 03, 2025 at 02:07:43AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Commit ec596aaf9b48 ("SUNRPC: Remove code behind
> CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED") was the last user of the
> make_checksum() function.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


