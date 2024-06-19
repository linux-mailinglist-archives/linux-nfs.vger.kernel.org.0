Return-Path: <linux-nfs+bounces-4051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B990E2CF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD9B21178
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188124B2A;
	Wed, 19 Jun 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxXwy+61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125F224D2
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776042; cv=none; b=fVlf8qvMEvq9w3POBwnp67wS5o7EPxcxGlVwaC2lVpCk8HggVuunlerLUsrx+YYLFV5lTkJxbpq0srF8rin/WQ0vgvX3cH3pDQYjv9/CP1kpuY+kafvEZaPcffK8EXqeNlrk6c1mBIo3qw8P9ofVMayo9IFA/gwCfXMlt1IWw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776042; c=relaxed/simple;
	bh=6Q0qJ8ch1Oj5qedAXjpa2I1jdAu0oNhWsstpG7fKkcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShthYED2TVmEXjz7wTOqZYnM/GzduK0jJX+1LIoievCBN5oxMwrus3UbwLdmvMxrIRv67W21dNPIzr/Bp7nT9Mv6INcWZ4zww7Z0cbPO7ymC4m0ww5QEZfg315aLWO4I5n9r2ZkxRJJ+SmWbf/11NyoelEXk9IIJjGWFMRm5D50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WxXwy+61; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0SR19NFt0sVPpUOfRK2EGM3kzayEYhg64Y6stt5Y6eI=; b=WxXwy+61C7XS1k+ptGEh2GC7Wh
	O8A1onbIc9iTPVwryQ+5UHeRPmSyH/0pQMdvt/tssLYoRxMR5aEXOARaetJXzJi9H2G0oAY0kihjP
	UUzCMySoQ6A2Kqvv6T1CpPkOJ9PT9tJIgvRrpXqqGrhhh5IHUiLoaOssk30Pfwy9eHhaniTAPn4zQ
	9cRpqZFhMLNVvhN80I/uh82lsy0SnJDYSiO+Tl+WShNsIBm3rmOJ9g/2rIurlU7jJTfkTXrVRViSh
	dgPjoirFICxIqVVORqvn8iDtwF2nFGGx0rKMqDgkXLwTb51LDsRPxS8qJ6F9sONW6X2zyifcmeAim
	3f4s9Ocg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJoA8-0000000HYIG-44P3;
	Wed, 19 Jun 2024 05:47:16 +0000
Date: Tue, 18 Jun 2024 22:47:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
Message-ID: <ZnJw5HAK0N3q5LvS@infradead.org>
References: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
 <171875264902.14261.9558408320953444532@noble.neil.brown.name>
 <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
 <ZnJI7Em5clnyWDU6@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnJI7Em5clnyWDU6@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 12:56:44PM +1000, Dave Chinner wrote:
> I'm not sure that the NFS server needs to reinvent the wheel here...
> 
> > Network devices (and storage devices) are affined to one
> > NUMA node.
> 
> NVMe storage devices don't need to be affine to the node. They just
> need to have a hardware queue assigned to each node so that
> node-local IO always hits the same hardware queue and gets
> completion interrupts returned to that same node.
> 
> And, yes, this is something that still has to be configured
> manually, too.

For NVMe no manual configuration is required.  It uses the
blk_mq_pci_map_queues helper to spread the queues around
optimally.  If enough queues are available every core gets
one, else they are spread so that close cores share queues.


