Return-Path: <linux-nfs+bounces-15644-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701CC0C381
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4AEF3489E7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140692264A7;
	Mon, 27 Oct 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qs1D0oHV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9A21ADC5
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552233; cv=none; b=XZpjBW5xO/+/lD0R/C+qxaFfjNE5fuNsA+tEqxs3S3RUraXC5o+7EXcWFpij4pfKFkSVRi+G2nFZEw99vFeKXfscIwlNYx1iEQSWfgnmy8adEkO2WJYQ8SPJH+vForPVN7hpGFTDoW2eCNSyQz8hp1PI+ViDjkNZtkftTkN0vHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552233; c=relaxed/simple;
	bh=SM3qqTHznJkCBzuFWQjO58wvLUxYHbjUeXOZ8OaXA/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGRUKwVDLrYlQ4mm5Q5WkbNEVsDloErPlvrXIfX3E9jUWJnviKqNh4Lhs1+3Z42E3Jat525dmvlLwoS30160t5lpqFSCN9+OWVFKFl1YzSfC8CzyMYhnOohsp6bKvkEKtCScthUM8lSoVdeoe6OL4ZN57o8YnUb6oIDHq1JJFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qs1D0oHV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NWiMEA0mUB1oysUO5oiHkyfsZal0KZT/6zmDq9S7bzE=; b=qs1D0oHV8cbfvEu68AjgHCoczw
	3SqVvr4Mtr9MUa9l5XCNM4Kb5nEOjnqs4SreHCUUk2KV+nQp48IX2GcjbHjgsSsxudbwV6eW5hIOb
	R4wM0EBiG+wYL6ndV8SWQokxwMZ4ZbS8IFevD8sGGR+eL2NRHUmGWo829RXuWw9XfMQOcg+e+XJE8
	NXvnkJXG4MEMFX1mC3f0gfkAdzS4H2hN0jhXYbOkoNVjt8+tutNVZL3KD1MJg+5cgxFcSyAta1CC/
	7sxzUMN+U7WspCsQF7VU6g+gQtNjlx0Y2OsRRyL8WbEbYVAV2PMlEdFRUhNRcT+F9wQIOMMWpdK39
	QDjLSUng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDICj-0000000DJzO-2dDT;
	Mon, 27 Oct 2025 08:03:49 +0000
Date: Mon, 27 Oct 2025 01:03:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 02/14] NFSD: Enable return of an updated stable_how to
 NFS clients
Message-ID: <aP8nZR8kUNjsk7uS@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 10:42:54AM -0400, Chuck Lever wrote:
> This patch prepares for that change by enabling the modified
> stable_how value to be passed along to NFSD's WRITE reply encoder.
> No behavior change is expected.
> 

Thanks for the detailed commit message!

Reviewed-by: Christoph Hellwig <hch@lst.de>


