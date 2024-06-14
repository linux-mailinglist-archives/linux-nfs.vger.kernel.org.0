Return-Path: <linux-nfs+bounces-3844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8B90923F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 20:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E6B285EC1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401292CCD0;
	Fri, 14 Jun 2024 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GJ1HHDDo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11B179BC
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389582; cv=none; b=jQXQf7AzW0rsjPj+QhXD5teI8A7ItKF4FnrAK08k+Yxzx4S1FI+WTtcfRyclCF6EQcthwVt578R27OpgHobAcltgPWaV2gSACEwOuoCvqRhio3q9Hv0Hv5Z/F4SDa37kd2IqnqQLAotlIHEJEiJIQFf7c1g9EduQuR+GklCzOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389582; c=relaxed/simple;
	bh=mkTw+pK21LyKR97AtgQuQ4sSStQmgJxBzl3/+A6LIr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbYgwqGO+6obWLfZSLRVzuqVDfBNMJd46bV/Pdgs1nZ0aNQgBa+Og+DkEr5Mg9ONgzmQ708jm0yAXCp9KYA9hrOkSjSJDJ0acAo3ukot7T0HBh09edGUZV4ZUBkeMuwKJ9c8IWT9T0RVAq/qJevvTXqMyw+7LVzcQva0SK7ZwmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GJ1HHDDo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h4smxTCld5MaKVlDYTfGS+gqgPSEdmpgUixLpJkTulU=; b=GJ1HHDDoHhfSlDCaGrIDHAMg3x
	nbnAltLhe8/TXMYtdPpSQJ6Cd4JrQMTixAf0gOnN+FEGCiummyJGW2ISc/9MSve3dMYOugx4QdhTZ
	2vazXM8eYA1LlghFQWsd0DeK5bhKD50RKy05+bEd/nALd96bQnuftixhMELfw+nKRV+lEbX/kZ9Ce
	VVbwtDna13/M4akPzD3MYDKoXIwTYY7OIIAE6/t8v/kPtT/dXZ6VQ7bH3Tq59lPkl02LTWjdlDdlO
	aGbykiLiElx4nz2WgxOl9NMNpfoLhyjR4g+S6ZIe1mMfDFYG4mbpH6c5iGt+4FPtWzB0ajDZUJdqF
	xym1jq/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIBcv-00000003krf-2YsH;
	Fri, 14 Jun 2024 18:26:17 +0000
Date: Fri, 14 Jun 2024 11:26:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: reservation errors during fstests on pNFS block
Message-ID: <ZmyLSZGWDeaIXdx4@infradead.org>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
 <Zmxx-H2KrT5QpJ-g@infradead.org>
 <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 14, 2024 at 05:46:21PM +0000, Chuck Lever III wrote:
> > Reservation means another node has an active reservation on that LU.
> 
> There are only two accessors of the LUN: the NFS server and
> the NFS client running the test. That's why these errors are
> a little surprising to me.

You can create registrations from userspace, and some cluster managers
do that.  But none of that should happen for a default setup.

> > When pNFS layout access fails we fall back to normal access through the
> > MDS, so this is expected.
> 
> Expected, OK. From a usability standpoint, error messages like
> this would probably be alarming to administrators. I plan to
> convert the printk's and dprintk's in the NFSD layout code into
> trace points, but that doesn't help the messages emitted by the
> block and SCSI drivers. Ideally this should be less noisy.

Well, they really should be alarming because the admin configured
a block layout setup and it did not work as expected.  So it should
ring alarm bells.

> > Is generic/069 that first test that failed when doing a full xfstests
> > run?
> 
> Yes, it's a full run. generic/069 is the first test where there
> are remarkable system journal messages (ie, PR errors), though
> there are a few subsequent tests that are also whinging.

Interesting.  Normally only the server actually reserves the LU,
the clients just register.  And something went wrong here and only
for these tests.

> > Do you see LAYOUT* ops in /proc/self/mountstats for the previous
> > tests?
> 
> generic/013 is known to generate layout recalls, for example,
> so there is layout activity during the test run.

Ok.  The other thing would be to run blktrace on the client and
see that it shows I/O.  But all this sounds like the tests in
general work, but something is up with generic/069.

generic/069 just does O_APPEND writes, so I can't see what
would be so special about it.

> 
> I can go back and try reproducing with just generic/069 and
> tcpdump as a first step. Is there a way I can tell that the
> PR errors are not reporting a possible data corruption?

xfstests in general does data verifycation to check for data integrity,
so we should not rely on kernel messages.

I'm a bit busy right now, but I'll try to reproduce this locally next
week.


