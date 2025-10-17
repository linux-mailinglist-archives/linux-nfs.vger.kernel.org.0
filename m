Return-Path: <linux-nfs+bounces-15338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D663BE8FA3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C34E40B5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F42F6920;
	Fri, 17 Oct 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWingXjm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054182F6916
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708632; cv=none; b=XKrOLsxHu1K6hIUTiiseWpWgrByAl1fwT9UXqmWX9DiCASTIjzDVcG6HfTl7QhsN5j3CUnwD9BHw46uUjpQpusX/bHdGqW0xR59clzsZ3FMsrmTq+gA24OPF6aq8tvzM3iaj6Itk5cxZAQp7x3wBQcAgVks2mxd2B/G2wknjXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708632; c=relaxed/simple;
	bh=920k+W/pUKpkkBjPZSHBXo9NYGmseNTlKJY3bC5OLWY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CMn7jgFriUiYDIUTJRtQ37DYmSkhvQlzXhrgJW5nrBRbzqZep+4GD2IqNfAlBRr4RROJ/4gS0sts/b2WeACHKNSrsmnTVxDNWYtLJptG7+bkCExffBAWbHupp+BFMzqdRjuv/h9OZ8tVUhGRQn4evCNzCAVgGawiZMjafyrSJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWingXjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46FCC4CEE7;
	Fri, 17 Oct 2025 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760708631;
	bh=920k+W/pUKpkkBjPZSHBXo9NYGmseNTlKJY3bC5OLWY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=uWingXjmBHUfq/9CBLHnUuaUGip1DbUYusSHANaALjBeh9OX+qATP/o6yZlGrEcgY
	 fcc74W8vTgdTEX/6G1GubGFLmZa8ARFgQu0wstds9aIiiHOdJ0ihXd9Eo/SQMhwFSk
	 RLVMJXjCu4T5P1uGazbtw7xWyxH267YKyLfgATyQclC3QlknEG2udr30EGZe6n7VMN
	 mEt3wc3ZlL0/qdrHD0yTUmS9K51+lJzHUzC/zcPGsVijYtjLla7O11urrW2boai+Ao
	 e6RgoUbS8t8uC8ZnPaPzVMDxaOO1di9QTjUTEwOwOKazyVyjFQA7Dnej1d/6cm/1J3
	 1L2FMs6nW+Wkw==
Message-ID: <cbc86905-47ac-4f8e-b008-9120ba62a413@kernel.org>
Date: Fri, 17 Oct 2025 09:43:49 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251013190113.252097-1-cel@kernel.org>
 <aO_RmCNR8rg9EtlP@kernel.org>
 <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>
 <138caf9b98325952919d37119c1d2938a8f4f950.camel@kernel.org>
 <176068215301.1793333.15890172978403788855@noble.neil.brown.name>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <176068215301.1793333.15890172978403788855@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 2:22 AM, NeilBrown wrote:
> On Thu, 16 Oct 2025, Jeff Layton wrote:
>>
>> Somewhat related question:
>>
>> Since we're on track to deprecate NFSv2 support soon, should we be
>> looking at deprecating the "async" export option too? v2 was the main
>> reason for it in the first place, after all.
> 
> Are we?  Is that justified?
> 
> We at SUSE had a customer who had some old but still perfectly
> functional industrial equipment which wrote logs using NFSv2.
> So we had to revert the nfs-utils changes which disabled NFSv2.
> It would be nice if we/they didn't have to do that to the kernel was
> well.

It's difficult to make deprecation decisions like this because such
customers are rare and are unrepresented to upstream developers. But
it's clear that there are at least two interesting alternatives
for such customers:

- Stick with older releases of Linux
- Switch to a user space client implementation


> What is the down-side of continuing v2 support?  The test matrix isn't
> that big.  Of course we need to revert the nfs-utils changes to continue
> testing.  I'd be in favour of that anyway.

IMO changes to remove NFSv2 support from nfs-utils were premature. NFSv2
can still be enabled in the kernel, so nfs-utils should continue to have
full support for it.


> And async can still have a place for the hobbyist.  If a human is
> overseeing a process and is prepared to deal with a server crash if it
> happens, but doesn't want to be slowed down by the cost of being careful
> just-in-case, then async is a perfectly rational choice.

async is not a hobbyist-only setting. I am aware of production
deployments that use the setting.

As much as I hate async, it's not something the user community will
permit us to remove, so it's going to remain for a while. But as I
mentioned before, it seems to have less and less purpose as persistent
storage speeds continue to improve.


-- 
Chuck Lever

