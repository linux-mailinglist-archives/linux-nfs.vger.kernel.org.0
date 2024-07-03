Return-Path: <linux-nfs+bounces-4593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1492633A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 16:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283F51C21D74
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F001EA90;
	Wed,  3 Jul 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhSyeIqT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129681854
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016313; cv=none; b=Zb5lo9ahBDSPuV8isbwd+AtYWe+8C7iqiQEc/8+32paE1Jzm7T0qQsawhM0bQyYhvMOKCF1ho9Gmc2Ce5k23XXFwbeblBNrARwTqCBBKF9vbZ9negJ3Ps9MFd9szkY4C9ojEgEL3LDniHlEEIJ8ZJGX43Pd1gr5oWDoNVa8qvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016313; c=relaxed/simple;
	bh=escx+f5NuF6P6tamhyrF1H7hFCblo3MnkBoKRuvY0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck5ugjqGVtSa/2jRaROJ0q7Fsiu538MGxy1UJpakvdvuMYAph4vHYa+SP9gYXetssBISPRjF2N6zMbxe4/7onEs/9682DzkClzjPZiHR4MfDwJ/9eGRkr23Av4WTZRZoinK3NbPpEciuzZr0Sr2tPlC8WJGPFkl5bbor5JJcLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IhSyeIqT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YtVBGUdrGOyGqxfO39TNZhcyFUuqEF/hRJsD/pBSvec=; b=IhSyeIqT2elpolE/7AYlAluZoT
	pUIh9HPHtNsCUCRW1Y/IA7K2c+pfqXd2wCEPc6vHuPMBE+jNTOax4F2vc+aYPWIIbImG+h4mCkyMt
	aCf8mkf1wgDEg8lEE5wFy18wpqt50GICiH0faHcRycc9LA+WwPdqCQ1fPx1nDa9f6c4hs4cM+6rHc
	zICHJg145yXqEWxfpbUoKbPnLSARHLuvqATlQ9gt61Af5CeEAXVX+QOUGTpQ8oYjX7nONefdU6TOq
	Uz1T0s44GqO0IMo4dFWzlbZYswSmq6/xVUOKmAqNm4a3kYlur9RJc2ZLVO7a7aQI7VmNPUWVM09pi
	S0AoZCng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0oZ-0000000ARpF-0N38;
	Wed, 03 Jul 2024 14:18:31 +0000
Date: Wed, 3 Jul 2024 07:18:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: David Wysochanski <dwysocha@redhat.com>,
	Dave Wysochanski <wysochanski@pobox.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
Message-ID: <ZoVdtyBhlaWOVW7M@infradead.org>
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
 <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
 <DA939E32-2E25-4EDE-BC25-2D5E50F4B711@oracle.com>
 <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
 <EEF1CD25-B709-4B8B-BFEA-6A96748EDE85@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEF1CD25-B709-4B8B-BFEA-6A96748EDE85@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 01:40:32PM +0000, Chuck Lever III wrote:
> > Was your test running both reads and truncates on the same file in parallel?
> 
> I didn't record it in my notes, but IIRC I was running fstests.
> I'm pretty sure one or more of the fsx-based tests will do this.

Note that you don't have to truncate as in the truncate system call or
anything changing the file system.  Simply invalidating the page cache
can lead to that, and xfstests exercises that heavily in the tests that
mix buffered and direct I/O.

