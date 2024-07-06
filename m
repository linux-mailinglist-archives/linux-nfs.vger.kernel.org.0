Return-Path: <linux-nfs+bounces-4672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00674929133
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 08:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F1282663
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 06:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC5F1BC43;
	Sat,  6 Jul 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gNwxpO/a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CA1B949
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245740; cv=none; b=QCT7w75A4gDD+Yy9TObttHIBO0j/Xl2Jv68wF7DibcesFfwOu0o0Il5gVIheMIgEmynoHZ6zl64Iq8+W2PVWSceX0430YfmkKtdGpIg/iIIl3TaDjSkCbE4c9z0tm1Fj4dFMxJPUFWdJSoGNzvIw8lUAwHrlir/budnBK6Te27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245740; c=relaxed/simple;
	bh=fZQKZ6OHsx8OilDmBNfjxYFiKqy9pzecblcpyH8rgRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz+rz3aUC7fPJNq8ZqlSapAYMWVGA+PVlkpWHQ8MpIxH05gWqTZXcsU8heDv1S0XGiBXHWy+Rcsuwj6U21M+jIJX/hGwnf398kfEyOKtJISxM6RpWPyMub6VaIWBvD00ueAYziLUF74Ne3LWVtGnWiiBwTMd6djumb1HsmOIs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gNwxpO/a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WJkO/OsiCg+4bzFAzZZzecO9p2d5bGmUtjOeO79wcqQ=; b=gNwxpO/aQ0cgjXiJcV6wxs8Y+d
	+vyot1iLi7WkbueJ7SSGgrd4OcsbzYxIpXAZuiNHOxGBj3/NUn0p/yT9UgfiBs6Pp/1XBzlhz00jX
	vfPWhdKPGKp6wrdGaW5RnU4mUTm+S5VDH+h7Kt8sJ2V0HGLlmIuic3U1Xm5pl0GbKJnVZyNb4I/bT
	4HJ7XQbg8q43zcF1CIcJ3r4E1i+MZrQqOVoOcyF/8TW5jFUYqok2AlaCEaTKZAwgzDMjVlOe0jNOW
	fzhZ/WNc/IGG3Y3GDgSCPSOoaA/jO2LkUuF/b7gpvBNp4TIqHEYPAtu1CB3ovjBwvtYWK7MEyvkgY
	q/52EH1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPyUz-0000000HO6V-2ssB;
	Sat, 06 Jul 2024 06:02:17 +0000
Date: Fri, 5 Jul 2024 23:02:17 -0700
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
Message-ID: <Zojd6fVPG5XASErn@infradead.org>
References: <>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <172021728732.11489.12447081357748108934@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172021728732.11489.12447081357748108934@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 06, 2024 at 08:08:07AM +1000, NeilBrown wrote:
> I would like to see a good explanation for why NOT NFSv3.
> I don't think NFSv3 is obsolete.  The first dictionary is "No longer in
> use." which certainly doesn't apply.
> I think "deprecated" is a more relevant term.  I believe that NFSv2 has
> been deprecated.  I believe that NFSv4.0 should be deprecated.  But I
> don't see any reason to consider NFSv3 to be deprecated.

The obvious answer is that NFSv4.1/2 (which is really the same thing)
is the only version of NFS under development and open for new features
at the protocol level.  So from the standardization perspective NFSv3
is obsolete.

But the more important point is that NFSv4 has a built-in way to bypass
the server for I/O namely pNFS.  And bypassing the server by directly
going to a local file system is the text book example for what pNFS
does.  So we'll need a really good argument why we need to reinvented
a different scheme for bypassing the server for I/O.  Maybe there is
a really good killer argument for doing that, but it needs to be clearly
stated and defended instead of assumed.


