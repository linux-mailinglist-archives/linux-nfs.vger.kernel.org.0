Return-Path: <linux-nfs+bounces-13067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2554B050FD
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 07:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D45A178F77
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 05:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB92620F1;
	Tue, 15 Jul 2025 05:30:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97849251791
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557412; cv=none; b=Vrbuu7wLPhn5UptCCBhxOMNffWRy/mFy3RVOBAZCn7rG1u3uurs417hspPg4YMwC+sMucL/p9hEU5vY9xfa584WtdMmAkyHBhu1dFIipcMmdW63dOK5/HyaKSl1AbSV25nDvlaND5hc6E1pRxGxcv9YtWEiz+3gn/E0UAyC603k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557412; c=relaxed/simple;
	bh=Pq9httspaCJYqSYW9eVnrFG/Q9TJVF34IPEpWX6eY58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6a0SNdRN/l6GPNm/F/BynISTbpwsyxAntpUbyyEDUZohBTrZhOv4vYggt/F+n6c842/E0napA0TiOA5/zMOwMclB+MhqVuOfzilbPV18N1o3Kj7R8sARphMcoXEQiVZuL0GIqAkh0cDhYnfAwFUW5A6r2AIV4me8uVdHsRlI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F393C227A8E; Tue, 15 Jul 2025 07:30:01 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:30:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: add a clientid mount option
Message-ID: <20250715053000.GA17897@lst.de>
References: <20250714063053.1487761-1-hch@lst.de> <20250714063053.1487761-3-hch@lst.de> <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com> <20250714133135.GB10090@lst.de> <6b5de853-b283-4b5e-9628-fd0b50d7645c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b5de853-b283-4b5e-9628-fd0b50d7645c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 10:47:54AM -0400, Chuck Lever wrote:
> It would be helpful to explain exactly what test you are trying to do or
> what bug you are trying to explore. I can't think of a way that the
> current client code base would ever need to behave this way. So I assume
> you are trying to test some kind of server behavior. If that's the case,
> why not craft one or more pynfs test cases? (Or, maybe pynfs already
> handles this case).

In this case I test the performance of delegation recalls on the client,
for which I need another client to trigger the recall.  See the
"use a hash for looking up delegation" series for the result.

> Since this is for development testing (?) I am hesitant to endorse
> adding it as part of the everyday administrative interface. Especially
> since this will break things (on purpose, of course). I don't relish
> having to support administrators coming to us complaining that some
> unimagined future use case is not working with the clientid= mount
> option.

What use case would this break?  It basically means that if you mount
the same export multiple times, where at least one of the mounts has
this option specified you don't share the connection and sb, but get
a new one with a different client id.  I don't see any good use case
for that outside of testing, but I also don't see how it could create
problems.

> If clientid= does get merged, though, what is your plan for an nfs(5)
> update?

Add it and discourage the use.  Which reminds me that the man page also
needs an update for the tls key changes.


