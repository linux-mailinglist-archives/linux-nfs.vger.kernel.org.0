Return-Path: <linux-nfs+bounces-13068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A6DB050FF
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 07:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094FA1AA65ED
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 05:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9481A275;
	Tue, 15 Jul 2025 05:31:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237E610D
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557483; cv=none; b=qtaUhCx/vpv9TU6OMh/Xhechcqbw0fokn26Lc7HExKNTHj+z/zhtOqv3EH63OtaHTm0yASrfPXmnDGc2hsmZ7RJbRXrUqnj3qGQlLvWtIb157D7kGR1E0eOtT3T8nOpCu99dShWML1rxRLnk9aNHY+T31QZEBALE24TD7xRYkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557483; c=relaxed/simple;
	bh=go1hAswRXOBT73l0R+kqETfpQsksMbbkOaqargSEJGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwiIn9iRygnKbwHU5/9aUPWHIi0VYI/QE1bLA6rRzgPq6IRstoEDse9giTIYjDURirWYJoVB2eBG5BdCFAFbrEq3bC4uPDOe21nwPSHTPI6z31xluOj1jVix8aBRqtDqiVmGUcW+neJYN4KPyJNLrWItJCsxjaG22+ZU7YujFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BDD1227AAA; Tue, 15 Jul 2025 07:31:15 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:31:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: add a clientid mount option
Message-ID: <20250715053114.GB17897@lst.de>
References: <20250714063053.1487761-1-hch@lst.de> <20250714063053.1487761-3-hch@lst.de> <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com> <20250714133135.GB10090@lst.de> <6b5de853-b283-4b5e-9628-fd0b50d7645c@oracle.com> <7045a21c6fb5c98c6b86754880589ce1fc5ec049.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7045a21c6fb5c98c6b86754880589ce1fc5ec049.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 08:49:51AM -0700, Trond Myklebust wrote:
> There is a lot of potential for tripping over your own shoelaces with
> this mount option.
> 
> I can't think of any circumstances where an ordinary user should need
> to set a different client identifier depending on the server. I too am
> therefore sceptical that anyone will need this functionality other than
> for kernel development purposes. It requires very deep knowledge of the
> NFSv4 protocol both to understand what it does,

I agree so far.

> and to stay out of
> trouble when using it.

But I don't really see the trouble when using it, except for the fact
that no one really should use it.

But hey, I can live with this not getting merged if the use case is
too narrow, at least it can be found now if someone needs it :)


