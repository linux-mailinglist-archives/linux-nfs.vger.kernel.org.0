Return-Path: <linux-nfs+bounces-15559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D49BFF3FB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 07:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837723A9741
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 05:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6726E179;
	Thu, 23 Oct 2025 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RkpG0v6/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA021B9DE
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197268; cv=none; b=bmwJwu9aTXS3ObSLwXWQ5K6fnLHCYohw4oovDPrBiGgORHPp8Mi7xAoFBg0XuwddSibJGhswyQ5ILjxTbAfau3/g+auSV9VSCGCM9IJOhtBzSV0e7WhgfmBGmK5MsLbxrKNc5zYFOHIh76CKJSNZSQWvheZ18ahckoHMj4Q/xqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197268; c=relaxed/simple;
	bh=jtelKjAT/9dw5DuJxi/7cWfptPH8Ew6i1p+OrVmL+/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVdVtzy2WweyyW5pCxQ5JPO/ZALmyFl+o8tBEUNAknze5rDwlIcmDMMu0DtMWhC+q9GigcupWU41X7WjRfz6W0mM/V9S3vxumJ0XPgxRXa3FUUM85bUXhzlPSZfAq4uZt7DwClGa8iVgpycmfzW7JDPR81hYgyOsl1jVYjrYx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RkpG0v6/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BuiFNO77xhKc4Iw652lwiCkIL0GCK4NrL7MASGRtMIA=; b=RkpG0v6/tfj3xsR/I7IM551q2r
	Ndvr8E/RLXthzvMd01riTzJi0dj3gb31FMyXRQafRTt30WlICxjkzedmnvgx952hjooDteAWyVBd1
	4OsnNPB2U7j9B2FCWCf9R3VODBv0J0KTsdyarAYFd5GbKanaSwBaTHPCVidPn+UEekoND9GnSxGjC
	TcAC2zPtPt8U0B53uCZLm8zjHOvJnW+G5oRrOlqnOnotOEu6GPhIkr4MnZVciD2GjDoGmAefoWpR+
	NNzriAxwXT4KIIeZgGrmlPWpACMfFfI90ooVdAvmRxvs0saBCicsLPXx7XVCySkp1/gftMXZhUCzf
	CeQFVUdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBnrR-000000058gx-2WrZ;
	Thu, 23 Oct 2025 05:27:41 +0000
Date: Wed, 22 Oct 2025 22:27:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPm8zSuZQTlwU_6y@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <a5f3911ae6b65c70e1fd897bdd4f3e651decb196.camel@kernel.org>
 <aPhoow9Z-r94b5AL@infradead.org>
 <63a440d869e3f8a9ecf13537e2da6c6439933ed1.camel@kernel.org>
 <aPi9ZE96CYQFk5qC@infradead.org>
 <98ecbd75-0a34-4358-843f-58f8e6afedb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ecbd75-0a34-4358-843f-58f8e6afedb9@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 09:31:53AM -0400, Chuck Lever wrote:
> On 10/22/25 7:17 AM, Christoph Hellwig wrote:
> > On Wed, Oct 22, 2025 at 06:15:44AM -0400, Jeff Layton wrote:
> >> Cache coherency. If the timestamps roll back, some clients may not
> >> notice that data has changed after a write.
> >>
> >> It's not the end of the world -- non-evident timestamp changes were
> >> typical prior to the multigrain timestamp patches going in, but it's
> >> not ideal.
> > 
> > Well, in that case nfsd_vfs_write needs to use IOCB_SYNC as well.
> > And both that and this code need a big fat comment about it.
> NFSD's historical behavior doesn't match the spec, so yes, I'd like a
> comment or two that calls this out if we agree that's something we
> do not want to change.
> 
> Otherwise, I'm not opposed to bringing NFSD into compliance. But that
> might need patches that can be backported. Not technically difficult,
> but some planning is necessary.

It's basically just adding IOCB_SYNC in nfsd_vfs_write.  If you do
that before this series it should be fairly easily backportable.


