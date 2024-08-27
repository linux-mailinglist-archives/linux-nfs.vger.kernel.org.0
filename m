Return-Path: <linux-nfs+bounces-5795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB195FFD9
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 05:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615BF282857
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC711B59A;
	Tue, 27 Aug 2024 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnDQ7Grv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83117BD6;
	Tue, 27 Aug 2024 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729607; cv=none; b=Z6m8ISkSnwtcrxHHMyeZ9JEQPW5B38kxYkz9tarsBWbTA1fCmEBXTfwPncOi3ur3n4ZzZi104H4y+XkZGd55hzFmbXGZTrG/Nqngu8WJlSHWkFCj44iOXtrdauYcj+byuv0+xfzyxA6A3wi2C7gEXMAZ4sjNFk4Xj16uywrlJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729607; c=relaxed/simple;
	bh=cijOwHKpKAsGe2raRwTDNWk6X/WEHh5CmaToPYhrWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL4n2rvd5Fgx8bO4IET7ppF1Z0XVBG4ogctqfn1nh4p12rXvZKUIIcROCQ8r6j7aFF91hrokitwiVF+gURGGcq1rJLqXpx9aTDLRua+59X0AxVR/vh44QflCnsNC7vghIhXH6yUqDtz+CeveAnxsN67yUYzzpuqO758UK2zzu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fnDQ7Grv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NU1cB0bm9+5+AnigtBB6FgsC6ItxiV1eaE/bQA93zmk=; b=fnDQ7Grvw+WZwRewFPWS/1Z4Ln
	3US/Lw0slAVAWlbW+48FxNcnQn3wl3fRkzoVxo0kWcajcVMhw4oyKxxjkmAM7yIlNJhtXbwBKBwux
	VJuUw44ZQQs5GSriT3vnM530i/Zs91Y6smbbXFCWjE/IZA97ExYxzXEYLr+5kzNTMB+f82+X/d8c7
	GUkNfufPKEiFrguQJI2j1taL2auDCz27XrdWL7RkJrAj7eTwpfqe8+1sIJ4HH/A20kkC3xB3CsFOQ
	tSdrTHY4HLKyb1spQ3lDIU2/zhKDImTJQzzTR5SHOOtwuFsKYP4vdCzXB99BiRAawtQ3b/ae5tJ5g
	gbI3YM8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1simxN-0000000GKhn-10lI;
	Tue, 27 Aug 2024 03:33:21 +0000
Date: Tue, 27 Aug 2024 04:33:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
	trondmy@kernel.org, anna@kernel.org, gregkh@linuxfoundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH -next v3 3/3] nfs make use of str_false_true helper
Message-ID: <Zs1JAfGWQOZMfHKT@casper.infradead.org>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
 <20240827024517.914100-4-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827024517.914100-4-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 10:45:17AM +0800, Hongbo Li wrote:
> The helper str_false_true is introduced to reback "false/true"
> string literal. We can simplify this format by str_false_true.

This seems unnecessarily verbose & complex.  How about:

	dprintk("%s: link support=%s\n", __func__, strbool(*res != 0));

> -	dprintk("%s: link support=%s\n", __func__, *res == 0 ? "false" : "true");
> +	dprintk("%s: link support=%s\n", __func__, str_false_true(*res == 0));

(do we have a convention for the antonym of kstrtoX?)

