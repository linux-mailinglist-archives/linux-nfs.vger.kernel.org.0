Return-Path: <linux-nfs+bounces-4583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5D9252C6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 07:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DAE2855E3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 05:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC24F207;
	Wed,  3 Jul 2024 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1EnQ3vo2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272C4F1F2
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983331; cv=none; b=XR8pnV8T1Uf6lj/5+YkS/FXz6jR2BF3ekeVrSIT0HQBAcAfiVr40Kxeir+kSmWNjsekpNLANxTklm3RWOtVqSfkoBx01RBh1V1CLCYHokyILXrGlYHL2WyWquxhwxCa0r4TtGeSmSOf2cnngvP6oYtj43E1TbyQEyN66cbUwZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983331; c=relaxed/simple;
	bh=/mjpVaUDJKoPMX1/FI/8quCMjlNgjNPSFU6KFMw9a1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6TpRu0VY4Pms9P8f2EQT6/OqWAPsgJXQSLbHL98RsIsCFtq67pRfbOpK8uzpB4o/5FCefIXYvMMSU8qbp5n/PNmDTaoevzdPoO/tuQPqncHqF5VuiMVjyZu1dStbNgy/qN26+AT/H2aJ4vCi+GmRLB9T30mxFsarpcrhp41YrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1EnQ3vo2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OaqOagK6OJ4jgzoVC8b7w0DuRip3+6zPSPkyZloWg30=; b=1EnQ3vo2GRaLTidxs6qt90uV2T
	b8651rC1cHu1n3QJUfCGdu/znZ/23TNz3Z2UpDR39r0SIJpGtLQJyam5lWfhP1231azV44fHST4UZ
	b7GAdcweN+w4MoVOgi/UG2TyQ5P+jtyqmTi77Y+Ps0QRTP8VA5KI1iWfEpP1ukiYVSe4fy+dnF3AY
	fY5mZ4l/EOAKxck/MqSlquEeK2MNx1U+dH891KvLNn/H9J0ypWnr4WG1tSf1ki0cEgUieOr0uqVmz
	KhheAWSK6xftJvg+PQqB/VSaOw7y0a8SK4obcrRwLh4WyK1zeOuj7qxmIWFIWY0gpqMGSRyNyJwpa
	3iIfTcAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsEZ-000000091CG-3yRP;
	Wed, 03 Jul 2024 05:08:47 +0000
Date: Tue, 2 Jul 2024 22:08:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Wysochanski <dwysocha@redhat.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Dave Wysochanski <wysochanski@pobox.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
Message-ID: <ZoTc3-Bzfr-gY4-o@infradead.org>
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
 <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
 <DA939E32-2E25-4EDE-BC25-2D5E50F4B711@oracle.com>
 <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 05:33:58PM -0400, David Wysochanski wrote:

[annoying full quote snipped]

> Was your test running both reads and truncates on the same file in parallel?
> 
> Once the read completes I believe the page is unlocked.  Then if
> truncates are running in parallel, then I think this can happen
> (folio->mapping = NULL as a result of truncate).

Yes, folio->mapping is only stable when the folio is locked.


