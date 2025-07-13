Return-Path: <linux-nfs+bounces-13007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44305B02E4B
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 02:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69295189E4AF
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5119E573;
	Sun, 13 Jul 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KRwahk7B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75042B676;
	Sun, 13 Jul 2025 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752367068; cv=none; b=T8U34rZ2O6mK+2GOzA0FvTy+FZ5+mQaxi5rNhUX9Jhixjd7hAPrpkpB7jYXLtbCTBBEDZs8r5r4z78HRMa1vHP+OgYlR8emyfIqRk9Jmh/t3bCOQwTGfXqjs3zumqdKpwINw2zuXM7n+Q33DrJkUb0SguqUjQx1Tnfi5rp/77tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752367068; c=relaxed/simple;
	bh=KeUBDEaJSUrjs1rP5hrxWaj9uAUG9qfRBdtJf+4d55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkCemmFemnQNS1DdVGGbQahyU39vEZMYZa+4x0XpzBwW7qHyKoxX8wRLi2pq2vSVd2Xd+WF8cXWdKLJRm1IXGu8La9wq15FDNveQ1aH7wYDHLTN+IogD3HeJy8vHQ8YXXQgCsb+G9L9h787eSUbQ6rNWz2xWCI1tvtU7KZwaPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KRwahk7B; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=1Bf+qIMl/aiJs5aksuCTE/QCXcUqHNYmjKTQ2JG+AbI=; b=KRwahk7B8Ba+H5YV
	QJNXWM/c/30jY5JdLOCL8PbDOi6hvZf851b6x+gaq82xGapuh8Sr5u7pYeVUVs6UxlStYDlyFHEdk
	nMqFvRo/59O6Qx6shzzxXInMC+fTjYstWvIORi6U02RZ7dZkItrre+RNd6D9OILfgxEV/paGPXsq3
	U2Y6gCOAfyNMlUUiy6iTlG2WE2VDylMdZCCELeLno5EbAsVAAtLxZzakSjzkGmw+juquxHm3yD+Ix
	jOXS3qKNYGq4Nhejo/xzL2o0Fgl2l13ZfcJ6SDsqrn/vvTY/YYX9NfCKEbKgbyY7TEf/OT2r6ZITm
	90CSRUDl9v3uS6RG+A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uakin-00Fkol-1Z;
	Sun, 13 Jul 2025 00:37:37 +0000
Date: Sun, 13 Jul 2025 00:37:37 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: chuck.lever@oracle.com, anna@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove unused xdr functions
Message-ID: <aHL_0dNwz5BKEH_0@gallifrey>
References: <20250712233006.403226-1-linux@treblig.org>
 <1ae3c2fa194bb7708ad5a98b1fb7156b9efcb8e7.camel@kernel.org>
 <aHL9HY5V95hV_Qau@gallifrey>
 <0211091956f168aa2c26ffa9da83e220b91479b5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0211091956f168aa2c26ffa9da83e220b91479b5.camel@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:37:25 up 76 days,  8:50,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Trond Myklebust (trondmy@kernel.org) wrote:
> On Sun, 2025-07-13 at 00:26 +0000, Dr. David Alan Gilbert wrote:
> > 
> > Any chance you could also look at this old one:
> >  
> > https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250218215250.263709-1-linux%40treblig.org%2F&data=05%7C02%7Ctrondmy%40hammerspace.com%7C9bda97d0c5c34041647e08ddc1a3e7c6%7C0d4fed5c3a7046fe9430ece41741f59e%7C0%7C0%7C638879631926208245%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=uQu4kGGvj5UPPwy%2FwdWL7gLQRahh6DucDGunIOwkvg0%3D&reserved=0
> 
> Ack...

Thanks!

Dave

> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

