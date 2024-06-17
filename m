Return-Path: <linux-nfs+bounces-3883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14690A35E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 07:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37351C21078
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 05:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB83DDA6;
	Mon, 17 Jun 2024 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4e2X56Hf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3317F5
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602530; cv=none; b=MGXpDJy9bsaOtt1hWIG0ldiJxYada57+3iDp0Lobvb6fjgTCRJDg9EapUuwhKxdCygGBtvs0GAZqPJBnmSnkn0j6pwdYVugaScPogtC+h2mFgm+l2PiYrtPJ/k1uFWzoSAKwW+D9lEeSzwgDHuzhEhe+HHuMYiyqdG13frNlYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602530; c=relaxed/simple;
	bh=5PLvEiypD81Q5uBd1MYSdJLfdoD2tlAAvp9fVH48Heg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPOuL8LuIidaC1ORfcDMx6jUtsZRfeZvHANOU3B6P1A53Cki9pNc0/Qs+TapSa5XQmcHWHOKhUOkEI5UwD4oTPTXXeM4gTEHvv2p3ON8NdbQFWbzgNCwaxWE0YWOiMrSNU1VLnN4kwuH/dRVwcreM6TqxdlFIamV429I3QNAN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4e2X56Hf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5PLvEiypD81Q5uBd1MYSdJLfdoD2tlAAvp9fVH48Heg=; b=4e2X56HfIMJFMQQOenbC901uz2
	50dyx5Xe2FqzK/iBGHNnWRkPj01LnwMijw4HynBUf4m16DwVD8gJpPdDmFdcl/WI2WPWFqVU7SyUc
	GsgGN6PK5eLRcdwXTvb4KXsFG574bjtN8vAvFdznWsj4M/yetITn6/wKfybJj5Lh5DoshS+NOp4Ep
	SRpkif/9gEaIV8SwsIdQnaQOxdTm57/p/jLQgy8SenQbWrxFvL6bbaOPhL2x+RordvPvi1RvAn8dJ
	SEpN2mivw5iAgkfxoC9hq2skzVjHyZr98M5rKun7VXBag6hF4S+Hl5As4nPpz+ba1bzf8rRAwQQJm
	3DeHKrHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ51a-00000009Ecd-1XkY;
	Mon, 17 Jun 2024 05:35:26 +0000
Date: Sun, 16 Jun 2024 22:35:26 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
Message-ID: <Zm_LHvJG5UX665lB@infradead.org>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <b9f5ae349c6ff90b90aff43b86bc3de8b8a9f863.camel@kernel.org>
 <Zm00O4JN7rY2BiiI@infradead.org>
 <cf0f94ff9259d2bd97d51291e420aa368a2e3d6f.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0f94ff9259d2bd97d51291e420aa368a2e3d6f.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 17, 2024 at 01:39:06AM +0000, Trond Myklebust wrote:
> We have been going through the IETF process to ensure there is an
> agreed upon protocol for this that can be used to test the client code
> and validate its correctness. That spec can also be used by others to
> contribute the missing knfsd code.

I still think it is a bad idea to merge Linux code we can't easily
test on pure Linux setups.

(saying that as someone touching code only exercised by the flexfiles
layout right now, which is a rather annoying)


