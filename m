Return-Path: <linux-nfs+bounces-4639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659EF928A1E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 15:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E65286F07
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597BD156668;
	Fri,  5 Jul 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vSgcTOs6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A77153801
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187253; cv=none; b=chlYRVOSZLVSmX5yA1LB15ZzTORDnIXPIRB+sgar9fcFXLr5jfNPLxMSa+ku2hYHhJRH2hB3bxguJ9mWD+JU4W6hSOf9SHLW78rS1AUUmjrqBl12vHQDWXzQpMw6ufuP1sOP92b+YZFYkPAz1g/VuVUtiGUWXUbn0sSs2L0P0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187253; c=relaxed/simple;
	bh=xa0QBNikgC7oSnwAzlWD+Bj67Z/v1rDwV3mn8vBd6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leZ5TvUqeokUqrnaYzmcDGwmNmaiFnIIUTH8tw3mUd33b9LV+hzRTSPoC6anQEuNatr6ae9Vvvngpu7Q71p1NxthB/TnvgPVoaAjKfDHZAN3NZahGJ+J6j7xzTtezX9uebOHK61wfICs0twFAxiGOWHucxSXh/aKSWKBS8Ul/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vSgcTOs6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ql04o+pRjIELqm3F5uVbMl5dukU0RLXAZXKk30yfue4=; b=vSgcTOs6Teb//fUGwvDyk8qqhT
	V+W5KtWWDtScDBk2SeCv4HHJILf+y61Yk8jp5ruGL1SqXtV7fNI1h/dUPHrzgKZMrTWX5ufDfq1oZ
	vx42IlvJb+ca+BSN5B0csIQtXskmHeHAWqZf6/JKuK68HGuCif2C+mCum5nngV6ZhUH64W1G1ShT/
	yq8XG4w75+kPf1jZKloegnVWTFFqIjrq+DfNY9uuKsvF4AZ21fzKhTfi+YiGcAlqEs37INCwujLD8
	YuHXi055Hly0Ax2kxCECWwMPcyNFRBk0pWc0huDzgwGWdZgMFKlR1XRJvU5CMzXcA4Ns1XIZ6Eyrd
	4EJ00C9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjHf-0000000G6uO-1Eh8;
	Fri, 05 Jul 2024 13:47:31 +0000
Date: Fri, 5 Jul 2024 06:47:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: David Wysochanski <dwysocha@redhat.com>,
	Dave Wysochanski <wysochanski@pobox.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
Message-ID: <Zof5c_eQE3bRn6PR@infradead.org>
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
 <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
 <DA939E32-2E25-4EDE-BC25-2D5E50F4B711@oracle.com>
 <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
 <ZoTc3-Bzfr-gY4-o@infradead.org>
 <FF24B77F-638E-4F31-ABB6-B07D48AF73B4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF24B77F-638E-4F31-ABB6-B07D48AF73B4@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 05, 2024 at 01:45:11PM +0000, Chuck Lever III wrote:
> So Dave, I haven't tested the patch you posted a couple
> days ago, because there hasn't been a clear answer about
> whether nfs_read_folio() needs to protect itself against
> the ->mapping changing, in which case, that's probably
> a better fix.

->read_folio is called with the folio locked and only unlocks it
on I/O completion, so it doesn't really need any protection.  So the
patch to simply move the trace point to before unlocking the folio
should fix the issue.

Alternatively we could just use the mapping from the inode variable
and pass it in.


