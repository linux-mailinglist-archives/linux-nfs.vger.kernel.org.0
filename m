Return-Path: <linux-nfs+bounces-3840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE2909092
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DECD1C21DEB
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994C19D8B3;
	Fri, 14 Jun 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ld2peyfJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1316F0EA
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383100; cv=none; b=HkRo6nSMj32WrT7akK6UfMwRz04xCYPZEgAuTCQttlLl0Wq4mh0f2lKbSAIsO7NFLhSEh+vbVaXj8qrYSCx6FIQGS33NOxP53CEDEtLxW4pNAIVSUYQCd+EgSeKA6KDsiM0nEYuLq0m4EJ5Vveul1uze6eISidjtHGRbGMiZJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383100; c=relaxed/simple;
	bh=txfwx4TTHFCNBI3aPmpA/kISvewqK5hY7m5miiFP958=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsP/jwLfKag0mAHEPQA5+c8fFFqkB1FDnnstqp62QogoxYxsOP6X6p5SGxujRLOS4Ev7RS69Jet2Ete9vo+CIb7xDCp2smcmny9Q6a8HLUn4U31gYdVeKtJBBD5cShLvTxncllbywYUd12cZcMUM0qn5quWn5akejqjFtnJfHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ld2peyfJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DvukEEfwhrqamkpwO4nzLJ1nXeiSSJnGuEnMvqfEG30=; b=Ld2peyfJgaCMdo5P0r/iwTILlH
	GEU2BK2Qv6x280YfAZVdzMlwFFqktzbcqbN9D032FccQ0rVEhSneYv0B5brTYImJEhijBm4gVFz0T
	oAqvwGKn5k6UoJxHEvXFnI/+WL5IbB4hQe9zAwCV3FI6riNsZUbQZMjg8hUlLtJ+JtVzEY3FoQeR6
	+G7GqC18eKpL4FBT5uUIi1WhTxI1n8eruWvqXgmb/JweVd5CsbKxy5//903kuwv+whc3aA2CfZi8Y
	uOQofrUJOZoWM3yqAh6gL0VCTxE6YIz8i/Yj4K0qWQhATiQOh/B6VEKby3YjIH1tQM+5OMT7vdy+S
	HFdCH8RQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9wO-00000003TDN-38J5;
	Fri, 14 Jun 2024 16:38:16 +0000
Date: Fri, 14 Jun 2024 09:38:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: reservation errors during fstests on pNFS block
Message-ID: <Zmxx-H2KrT5QpJ-g@infradead.org>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 14, 2024 at 02:46:49PM +0000, Chuck Lever III wrote:
> I've finally gotten kdevops and pNFS block to the point where
> it can run fstests smoothly with an iSCSI target. I'm seeing
> error messages on occasion in the system journal. This set is
> from generic/069:

Reservation means another node has an active reservation on that LU.
Either you did another previous attempt that fail and let the
reservation linger, or something else in the system claimed it.

> But note that generic/069 is recorded as passing without error.

When pNFS layout access fails we fall back to normal access through the
MDS, so this is expected.

Is generic/069 that first test that failed when doing a full xfstests
run?  Do you see LAYOUT* ops in /proc/self/mountstats for the previous
tests?


