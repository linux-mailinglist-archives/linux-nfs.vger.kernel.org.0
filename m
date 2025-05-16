Return-Path: <linux-nfs+bounces-11782-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B0ABA18A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68904167B5E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F081F872A;
	Fri, 16 May 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faVJ3v4t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324C1BEF7E;
	Fri, 16 May 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415020; cv=none; b=YV9boeRn78QQ3SPTqYaoROKjMbduChq2UjqQpeq5w3Bugbq70Q55DA2vKYFxv3k1/HwhrTxAsTEkt5KsSpO9BVqzEkkZin+dvuZMhAiWvXMEWnDFDHkotLANIPq5DsSI2OGEN0/JwP0aySX9rUylA61mcqoOOU2rrEAlKF1oqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415020; c=relaxed/simple;
	bh=azSGgnad2OfisrsviQQ8UkYRkH2oKecz78Sx1g2PXl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyFmtVusE1nGJW8bp1MSFy8OGaTt/f2SuRzOVFY+ZeRw0YvJ16likabxAAKk4guimDmfNFflMQ/p3X9CZSqnQlhlptFwa999hm0cMDR6R8WuedCB+wIEp5fzYgzBHp9nN7JesNBNpV5FyP7E9pQg+einhHwXTtZeAZdCZNq5GXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faVJ3v4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E45C4CEF0;
	Fri, 16 May 2025 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747415019;
	bh=azSGgnad2OfisrsviQQ8UkYRkH2oKecz78Sx1g2PXl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faVJ3v4tdxF2uB3w3Bwlod0Ui6Cv2uJ7xeL25eXNmy+8EzUAdNSFkZmcMnRXvoh/U
	 GghbLZDFqTLOA0voLvPgScpSCNFTt3BQKTt1hPxo9JEGqFbI7BSJXG3d+I1FfHAKOR
	 8KNx8n0lS2NLlI47I+F4wze/AdRCHQQolaYRKWSUbbh2ao4TnqGC8mZAt+6nJo7hyw
	 DPS/4S6aQPHNs8T04SmoPJykQvvIJ6S/HJVlCMuJKT5P47X9bfTXVb2nvhxV+rSJTo
	 d40N+IVavoTp99PBSd/0eqy9kCT1kN3TNzDbrC4z47Cd3UctlISoZNKj6fHr1cZtEA
	 DWzUn8FOp2jlQ==
Date: Fri, 16 May 2025 20:03:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <aCdv56ZcYEINRR0N@kernel.org>
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-3-hch@lst.de>
 <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>

On Fri, May 16, 2025 at 02:47:18PM +0300, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Based on?

BR, Jarkko

