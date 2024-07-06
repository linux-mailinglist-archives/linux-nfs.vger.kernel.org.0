Return-Path: <linux-nfs+bounces-4676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80E929159
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D22830FB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78D1B285;
	Sat,  6 Jul 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dDuok2VG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009C17C68
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248152; cv=none; b=FefeRyTJbEzqoR9H5zDXsy0kzHwLHsSCvZ1NtY+ISPMjFsC05mvZ/L/VmkjJRs5987HcB17emhHItwzPdSRf2DQ8K/cO9W8H27+cTqkr+O8N7sRlC78022WLuwCgSgXRR8AeaVML3IcE0Sb3iP4duUOO0SlFqXWhV1vFkdDWmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248152; c=relaxed/simple;
	bh=pbRHl0ZA6GoE99YYTQAj6lyXLTKhJUgYvqTyMDh3TD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr2lvduyOfCMgaU8QtJeyCZOsx3HgBLUOKxXre7K3l1EKrq9N2JxGKYcpYBAfOj/pBk/dQkLfLu7QleEuVTF0zMmd8X1ehd63cltSYyw5Pd0C/ocJtf3U6WOSAsFfINMWyurMHaEm8OB3/MofWu7nVCZDAVV9q5va/3C+TkbXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dDuok2VG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zUZt5tObI5Xb1kCTAv2Q8zq8Y7pJw8jQQnC1nGNPzAE=; b=dDuok2VGTWcpnSRC9rPjwmXOWp
	y/lctArFfM4XZkf7y3eoNB/3kC6kHsZqjxvFlbG3DQQWCsKSZfIZ5R8BvyG/1r3Sg07Tnzag9gh4L
	2EePYWaBeqqipxWFumrZGO/hCPXUhFjBqTZTQ35mi/8Kbqi4Jy1Dt0xSI2/bV7LnZlcCw+gK5B91f
	7Vg3lYd30VosExH9sYoIseR2GFu3XP9MUIpWu98IefEBrARHQI2vFbRP5mFMVJUMvZ5ovfmMPvd8m
	WAH8sHpUmrlCmEHV9FtR/TsyADNCLRpOEQzhUKXo4dmSAihHMw6QaIWhDWa8pCp2CjgYrfbNHV+Is
	3pejvFQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPz7t-0000000HQgv-3xgF;
	Sat, 06 Jul 2024 06:42:29 +0000
Date: Fri, 5 Jul 2024 23:42:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZojnVdrEtmbvNXd-@infradead.org>
References: <>
 <Zojd6fVPG5XASErn@infradead.org>
 <172024784245.11489.13308466638278184214@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172024784245.11489.13308466638278184214@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 06, 2024 at 04:37:22PM +1000, NeilBrown wrote:
> > a different scheme for bypassing the server for I/O.  Maybe there is
> > a really good killer argument for doing that, but it needs to be clearly
> > stated and defended instead of assumed.
> 
> Could you provide a reference to the text book - or RFC - that describes
> a pNFS DS protocol that completely bypasses the network, allowing the
> client and MDS to determine if they are the same host and to potentially
> do zero-copy IO.

I did not say that we have the exact same functionality available and
there is no work to do at all, just that it is the standard way to bypass
the server.

RFC 5662, RFC 5663 and RFC 8154 specify layouts that completely bypass
the network and require the client and server to find out that they talk
to the same storage devuce, and directly perform zero copy I/O.
They do not require to be on the same host, though.

> If not, I will find it hard to understand your claim that it is "the
> text book example".

pNFS is all about handing out grants to bypass the server for I/O.
That is exactly what localio is doing.


