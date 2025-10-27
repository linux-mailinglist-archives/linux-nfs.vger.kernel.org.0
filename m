Return-Path: <linux-nfs+bounces-15647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E01C0C3BD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67443A3477
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA32571DA;
	Mon, 27 Oct 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yY2ghr/9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F362E54B3
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552508; cv=none; b=a8W++15J6WUhMTtuFHwtHnjFJpZKsLb917Tje/pqNa3BwnplqRRNXDb0xjuWUT14FR8SCpUOAyHD5HNSCEIY6SIL1YulYcsHF0l2XTwV1xTc0VDzbN3CBYVrPnSrKHLyE3QlqgmUfa5WwOWTirr3bmTG2jrfx+4Noy2rQQS0L3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552508; c=relaxed/simple;
	bh=/xQa6iBSKQy/4SJC8AzD9jSYeiDRKziVEz8bPu29tJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr60Y+wWgtBKvHgla9jU5W8fGfecldkqs4lEu7vqLH25fSjnNENWb8k9nHoJyjD44ovPCiRXSfYxX6flppa+WtYP1bsvnleMgrtQMspFMfHimnoBoRS5umGIVgmzDGEFTz+KQn/CYdKEou90Def68seLcABDNjaeI4IKNL90f/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yY2ghr/9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gfrPgEIQJoN050YFNZ6VApPraS8qkCiV7Hv5GSTBJes=; b=yY2ghr/9U2gSCYHo3H/XAqjTzf
	67QhIdXXaOj1tzit4CIqJP7KendjNWdaNa8pShhdbiNELqheEE4z+fE5IrKXuxN47EHcWfcKrhwGp
	XVWS1r1wLhRrmgR1py3KwC7Ty8WM6ShiiCFEderwEaYVIcPeq8Z+FE7QsF0rJzp5OnJv2GsP0KxHL
	pzB90ZEfOthdCT9ypG5ffpWMp9f6mHBrYbqMEIKKnOvLLd9Mj9DiXvcsXeJcL01YUIq5BKpb/AkSv
	nUGN9edeQOnWzK4oyCMxBvUZmtyD90x4VAf14FbSzM2eXLPH55+kVJ3c4TyTA0p1OlDI7tEM7XLX+
	81RRpZKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIHA-0000000DKDX-2ctI;
	Mon, 27 Oct 2025 08:08:24 +0000
Date: Mon, 27 Oct 2025 01:08:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 06/14] NFSD: Always set IOCB_SYNC in direct write path
Message-ID: <aP8oeGDzWIDgWra2@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-7-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-7-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 10:42:58AM -0400, Chuck Lever wrote:
> +	/*
> +	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
> +	 * both written data and dirty time stamps.
> +	 *
> +	 * When falling back to buffered I/O or handling the unaligned
> +	 * first and last segments, the data and time stamps must be
> +	 * durable before nfsd_vfs_write() returns to its caller, matching
> +	 * the behavior of direct I/O.

I still haven't understood why we need for for sync writes with direct
I/O.  The comments suggest it has something to do with the buffered write
fallback, but even for that I don't really understand it. But for pure
direct I/O writes that are properly aligned there definitively should be
no need.  If there is a need for the fallback we really need to explain
it, as it's non-obvious and a performance issue.


