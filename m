Return-Path: <linux-nfs+bounces-4631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D939C92816D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D101F21FAD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 05:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E713AD28;
	Fri,  5 Jul 2024 05:36:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3069D31
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157763; cv=none; b=tZXAj6a1Kx0bqozb45BC9gGJqRyTucW5YyXaK70OeDDz+aa9kep3Cl1ijGdtZaIqXqtaVinfAPyJBjVWe99v08Bk1us0uwwU6AbE5at1jTBqmlhwo4YbZHqD2OBg1k06bOEHrCM7mgYyxdxprEEz6zAj7gkH6wS39l8stFO1Cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157763; c=relaxed/simple;
	bh=AD6Sr4E6brWtYzr9l/Ut30O0D6Q5z2m56oKxo9PAk7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+qbb/OiIq/KFeruuoYNk9WNUU7yH8iSYTAPAgv72gVjkpl0Z/7+9RbOda0C+d0pcRinHB9C3GO9WCGqOPavpCwsrvZeb+icRNR9dK0qx1iJqIvfDOuy9WThov1Yy4tUp8aslPbzYpoiUqMaqDnXgyQxkuUuk7Fe39sjQ5cnR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B304D68AA6; Fri,  5 Jul 2024 07:35:51 +0200 (CEST)
Date: Fri, 5 Jul 2024 07:35:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: NFS buffered write cleanup
Message-ID: <20240705053551.GA11711@lst.de>
References: <20240701052707.1246254-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701052707.1246254-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 01, 2024 at 07:26:47AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the nfs_page handling in the buffer write path.
> 
> The first patch was already sent independently but hasn't been picked up
> and this included here again.
> 
> The last patch fixes a bug where a request could get incorrectly reused.
> It would require the flexfiles layout and odd I/O timings, and without
> a flexfiles server I can't actually hit it.  I'd appreciate a careful
> review of that one.
> 
> The series is against Trond's testing branch.

Looks like Anna is doing this merge window despite the earlier testing
branch from Trond.  That already has the first patch applied, and the
rest applies fine to it as well.


