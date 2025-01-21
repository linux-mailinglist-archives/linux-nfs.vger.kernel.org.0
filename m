Return-Path: <linux-nfs+bounces-9426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7CA17EF0
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC9F7A4180
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829761F2C3A;
	Tue, 21 Jan 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHvXPRUh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BB1E4113;
	Tue, 21 Jan 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466526; cv=none; b=mK2BSokq8qLkC9TxIHtGbo2vmUHRcNz/t1d31uxFbLQ5Fq2ZCGETWboxYTjsQvbB4wAl8KP5ZUVau0cFCZTtvvLfHGGeW74ZHLSEzTkBva3EeSnIbnizFM7IXVHISOQ6TQdW/bktDmluQcXwmjeDZti7MB3QqolLja7cjyw9VSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466526; c=relaxed/simple;
	bh=sGMsd5lafhvVCnBirtNKS692lGmtI31T57k55imAlOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZUXghymq5+P9zjZXjw9hLMrjGly57CTTc3NkeP5qJiVlp9Gt/HuzMkOTXLgVUOtMftsO/3Rekeh+t/kbbxtfwcfj7d4602srvFPnDScUpO2AbBqp4nDDzvuqBDKa/dH8OxtpJE8dkU7c9+Crc3Iw/TK8zVTxdBwSwjxPGUNp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHvXPRUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666DDC4CEDF;
	Tue, 21 Jan 2025 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737466525;
	bh=sGMsd5lafhvVCnBirtNKS692lGmtI31T57k55imAlOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHvXPRUhYL2IKx+d+y5hjDgPJRIrQXIEvv9vjETajYjIri3TtkArLTfL2inBABMK0
	 FtYnD/J5kJ9jIi7WqNdZxyEWTdk3AQV3NBCkvDC3morA+6kBXUN6PanA5obFCGFSdh
	 uEudYnffSthxM556KNlbR6eGBlSkVdhDtBe9DhN4=
Date: Tue, 21 Jan 2025 14:35:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Youzhong Yang <youzhong@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: Fwd: [PATCH] nfsd: add list_head nf_gc to struct nfsd_file
Message-ID: <2025012110-quaintly-refinance-9835@gregkh>
References: <20240710144122.61685-1-youzhong@gmail.com>
 <26e833aa-a4f5-4ce6-80d2-0081458b5e9d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e833aa-a4f5-4ce6-80d2-0081458b5e9d@oracle.com>

On Wed, Jan 15, 2025 at 02:48:17PM -0500, Chuck Lever wrote:
> Hi Sasha, Greg -
> 
> This is upstream commit 8e6e2ffa6569a205f1805cbaeca143b556581da6. I've
> received a request for it to be applied specifically to v5.15.y. Can you
> apply it to all LTS kernels back to v5.10 ?

Now queued up, thanks.

greg k-h

