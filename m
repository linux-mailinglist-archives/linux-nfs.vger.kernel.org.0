Return-Path: <linux-nfs+bounces-5339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27AC94FA3B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58131F22117
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 23:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB4198858;
	Mon, 12 Aug 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTBCMR3/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFE175D59;
	Mon, 12 Aug 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505012; cv=none; b=kH7awCgoP9RbSv0DghAsVjBBtScoK8BohJ0DeP+kuNb5ji218tIMDXkaa5YYFWfFqWgi2Gs4nSXNIdOB0ViygWEI0vcJQxw+5xCst+FexKB8sFIiYWmnDCWVxSig67LPVcNJG6qYMbNQ2SKWC0jde4midqszMkSMxzKfVaY2VFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505012; c=relaxed/simple;
	bh=5ewRKoMVxsN885I2VkloOsrGqHKI0p6ygfp3g2u4lgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hvvd25sd1gPCZgkmwFRgKXe3sS1PloADJhKI2wEsIeYk03s8bGDS1cB7/3znqho68jL6Rk1QZzoagXS9efGAvvoL8gpZcdtwneZ2zwsDJcH4qTxVffVBmYrXwQkGTb0LdhcdT+dg2rq10Ue8dVu2lkxqkHCPyBAs2zqMCxPTB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTBCMR3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB8CC4AF0D;
	Mon, 12 Aug 2024 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723505011;
	bh=5ewRKoMVxsN885I2VkloOsrGqHKI0p6ygfp3g2u4lgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTBCMR3/vR522Q6cV8aElPlbxUBn6rVU9tYgFjwL/Y+g9raT7fYQVGNrcNPf1Eh7/
	 7zT0eB9YS+bMCnDNVCHGzEm3PCWG/xW3cxHV7oCo0rLw/dEfLgLL5qK2T6mpMCdudr
	 zKK0Ct7NtqpxT1V0IbDyatIHUn2yrpfWmrhOkCLo2uIxayDvbwr7CzWi131Bq80GFj
	 iu1/rQJsAFk5KVETKERe7uyp5HRjuyyMAZ1/uUvG3Kw3M4j33gBUFLJNQPz1fq5uJy
	 TAIb1GBByREciANG+Z8wD/YvFHQOz6Nqw13ymfL1uJ16sv/Y8mpaiR48Atqrc2Jf4M
	 Rx6AtzGWs280w==
Date: Mon, 12 Aug 2024 16:23:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Tariq Toukan <ttoukan.linux@gmail.com>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>, Trond Myklebust
 <trondmy@kernel.org>, linux-nfs@vger.kernel.org, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Maxim
 Mikityanskiy <maxtram95@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Networking <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
Message-ID: <20240812162329.7224eb26@kernel.org>
In-Reply-To: <06a66824-cc2e-4f6d-8776-c2bd415c06f9@grimberg.me>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
	<77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
	<4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com>
	<3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me>
	<8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
	<20240812090215.GA5497@lst.de>
	<06a66824-cc2e-4f6d-8776-c2bd415c06f9@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 12:13:51 +0300 Sagi Grimberg wrote:
> On 12/08/2024 12:02, Christoph Hellwig wrote:
> > On Tue, Aug 06, 2024 at 01:07:47PM +0300, Tariq Toukan wrote:  
> >> Adding Maxim Mikityanskiy, he might have some insights.  
> > I think the important part to find out is if the in-kernel TLS API
> > has a limitation to PAGE_SIZE buffer segments, or not.  
> 
> I don't see why it should. Also note that sw tls does not suffer from
> this. Maybe Jakub can add more light here in case something was missed?

I don't recall anything special. For SW crypto the splice is kinda moot,
because we encrypt and use the ciphertext so the plaintext pages are
likely to be freed before sendmsg() returns. For offload we wait until
the data is acked (not just sent) so any potential race window is
significantly longer. There's also the use of pfrag in the offload path.
Dunno..

