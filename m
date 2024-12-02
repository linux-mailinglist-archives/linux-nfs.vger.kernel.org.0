Return-Path: <linux-nfs+bounces-8293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9159E072F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B07617340C
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC692205AD8;
	Mon,  2 Dec 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7NXiyek"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23C208994;
	Mon,  2 Dec 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151565; cv=none; b=Q15qWWu4sRiUM7Wqr0Is4D3m+XXnIRcGrzKuH74+PIHPIoc3rL8i4K/KGLkExiJQ+dwfsWlmUqXzjI01YnIweETXii+VRIKwX+1zLfpDe4PR0NVbQB4JZ+92UhuM/nKQ4jr6/FnmJyVyZMAxP77H6P/tqre/beBvHe9r7Hret84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151565; c=relaxed/simple;
	bh=LiYSSsjPV5oZJjFaqrKAZlCJIqI0wg0L9vhGyObQsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlNSk1EI6hVX4rcM0+4kkAl7Dma1j77lzHDnbhYmwbTVq6EsxUlZCiBE4xac2YrEgPG8fQGQ6ADoFjTa0FuZkMRM/R+urpJuDT9fZXE6zWzxLyKGhXx81GuDqkNQqvKN2IuMvzW5PSEU9msIf5XE4xXmJmsco8ny7WoO6Ql8gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7NXiyek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5845FC4CED1;
	Mon,  2 Dec 2024 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151565;
	bh=LiYSSsjPV5oZJjFaqrKAZlCJIqI0wg0L9vhGyObQsXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7NXiyekRyOghU/6fR2Rbp/68Nv82j4bmaKH8InOG6HH73ZOx+MrqRE0WdBU1mlwV
	 uQf6lZyrnLbghhoNyD18yWGRjcSB9g1iJhzHkcswtOi3rjEBpBJ3jEViSa2tQ0HPpt
	 elQTD0JHUQ7pBkD7fbpt0fvkf0nMAKGBC+HqRd6I=
Date: Mon, 2 Dec 2024 15:59:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 5.4] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
Message-ID: <2024120210-finisher-surprise-fb97@gregkh>
References: <20241120191315.6907-1-cel@kernel.org>
 <20241120191315.6907-2-cel@kernel.org>
 <2024120226-unearned-ragged-ab69@gregkh>
 <E476A582-052A-4455-B53E-729EB8D654C9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E476A582-052A-4455-B53E-729EB8D654C9@oracle.com>

On Mon, Dec 02, 2024 at 02:19:13PM +0000, Chuck Lever III wrote:
> 
> 
> > On Dec 2, 2024, at 4:09 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Wed, Nov 20, 2024 at 02:13:15PM -0500, cel@kernel.org wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> [ Upstream commit 8d915bbf39266bb66082c1e4980e123883f19830 ]
> > 
> > What about kernel versions greater than 5.4?  Like 5.10, 5.15, 6.1, and
> > 6.6 for this change?  Shouldn't it also be needed there?
> 
> Good catch. My rationale is:
> 
> Asynchronous COPY offload is needed to implement NFSv4.2
> server-to-server COPY offload.
> 
> The upstream patches that address the CVE don't apply
> cleanly to linux-5.4.y. However, 5.4 kernels do not have
> NFSv4.2 server-to-server COPY offload, thus this change,
> which simply disables async COPY, has no user-visible
> impact. So I decided the easy, low-impact way to address
> the CVE for v5.4 was applying only this patch.
> 
> The newer LTS kernels do have server-to-server COPY offload,
> thus if this patch is applied, they would see a behavior
> regression whenever CONFIG_NFSD_V4_2_INTER_SSC is enabled.
> The upstream patches that address the CVE apply cleanly to
> these kernels, and I've sent those to stable@ already.
> 
> As these were separate patch series, there wasn't an
> obvious place to add a cover letter that explains this.

Ok, that's fine, we'll just leave this as-is, thanks!

greg k-h

