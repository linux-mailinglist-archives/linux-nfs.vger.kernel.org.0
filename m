Return-Path: <linux-nfs+bounces-14936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD5BB5FE9
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF44E30C7
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233E1F4E59;
	Fri,  3 Oct 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NkSVxHrd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E4128819
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473953; cv=none; b=pS7sLkbNahtj/wZpWvqFPuPL8Mos96qQAuI9PfdNQWmeKKWqmP3Qohag0I7hNk3nCrCbo9xpvnb87wsQC4F+sFBLC9EOGDYxKHDdH/tQQz3WQrITgh+XGKYiYNwml7oNKPcoHZoHiR2ugIfCGto6e7W3bw1UlAVtBsINm1QJq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473953; c=relaxed/simple;
	bh=wyjfDWs5ir3+MAuLNl+mgP+V9vMuPv+9fXeyLsTrSHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB5tSV4dE8HDdt76kg9xshBbwk4l/g70XZck2JQczp8Hh7tjbeGllruC+yAVNkBjhtsteY636HuoVQUG3E83AiFnYstK+YVNGfM8Luv4rHn6Xd/3LjPg+Ze1BfQQLoufX51B1O/bSXSQB76BXQVh6Rg6N/vKqUHPSYtmdhNzwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NkSVxHrd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wyjfDWs5ir3+MAuLNl+mgP+V9vMuPv+9fXeyLsTrSHU=; b=NkSVxHrdQZfG+8JhmAu9hELDiK
	bfGOxETG/R86xyezSNBTnDBEiPhNKdJV/p5mFODFY2cIHPsq/wdQt9pJZx00CHWjr72AwBK2Lrwm3
	XOCa4gcpWpKOBTYM/gwikU4OStNXvCjUemTqG71qtpCqF5SEiZolM3Nxvtz8is5TXDsHQVOSBFfYC
	dvdN63IQNtNJTAk8kBgNyUhDEKUcDmFU2qSnTpdbfBqXi/b8t9SzyOfG1JZY6pgW/zaxcG0MFKu1/
	zj+NgtF6b4DgmQmr0uqKtKdKqoLKZI/W7g23EulmoTA7ODtrzG7z5ampZSzO56+pDYe7lv4vhFiyw
	3mRCqSKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZXy-0000000BkpQ-2e6n;
	Fri, 03 Oct 2025 06:45:42 +0000
Date: Thu, 2 Oct 2025 23:45:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
	tom@talpey.com, hch@infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
Message-ID: <aN9xFsouIH6jlqv4@infradead.org>
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 01, 2025 at 10:36:47AM -0700, Dai Ngo wrote:
> Thank you Ben, I'll get the spec from the ANSI webstore.

You can also downloaded the last draft form t10.org, which is always
technical identication, but does not have the official blessing.


