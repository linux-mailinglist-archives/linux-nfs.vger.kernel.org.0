Return-Path: <linux-nfs+bounces-14027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108BB43190
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 07:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DF11B24A6B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD123BCFD;
	Thu,  4 Sep 2025 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qzTsrK7W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68F22C355;
	Thu,  4 Sep 2025 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963578; cv=none; b=O1vHdLYwhpep76qvXwlmV+APlfWD/FKuyfW8rGxYFSbzaIA/gSReb4A+Mjh/q5KlDTUYLFLx3gw1VvMtPlAdApNKqixvmJTN9NARZKZyIGPYhfTCfQ+m1bf2vb3JboHc6g/tJKxaF/WEAHSWdAGZQ+uHfhdy8/8di1x48YQ6edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963578; c=relaxed/simple;
	bh=qfKXCKBrgFrfhU+4Sn7ylp43ko1arUbp8AaFFRraewo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjrEZ16HFnVzLBu+TbSAMNMbjcSrFprJQUTkrUaXPSuxQrwqK73Lpk3ByS1YAYVOO42dv8rx0dADdXhKOHrnN0zbBoHidQGDalM/zJd6CTl7KhGQS+jjd3Xg4Bjap+wkNkXNTrMqwle8tmPYktZyGBLlOqJqnXW1f2lGLXbP6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qzTsrK7W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7W5siyRKoR2QHdVBSGezPzMySkx5Ka2AqWH9wwpUgBs=; b=qzTsrK7WxY6l4A5nMIigpADMpy
	jq0FrxSZs8T8YJtZ/vUTeLseL6s0qBlcTLWB65Mx9Rggsq5WdiE8p86wooknlfTTk8JQg1G8EsAec
	avNWBfP74hQ4REcB5SErgoV83ZAquWTh+jAb/rE7SFltd+IiabYKYG0F7E9ySkG8WnSBfJJ/nboKm
	3y/DT9dctMzA9Ck+x2ix9WP4vQKR6VxqgsSCsjQGi4IdHA8INA4ZTvsFKUWlHe8TicHhYoZlCK++V
	3Hun6dR4wDa5H3Jyi+oloZgMMXOPqisiPH0NCrauToJ8Ee6wj/pLfvAsIvgiiLjmCWPoIBj7qui+N
	oKt2OZ8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu2UA-00000009Ebb-09CC;
	Thu, 04 Sep 2025 05:26:14 +0000
Date: Wed, 3 Sep 2025 22:26:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2] NFSD: Disallow layoutget during grace period
Message-ID: <aLki9rH7p13PPiRy@infradead.org>
References: <20250903193438.62613-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903193438.62613-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 03, 2025 at 10:34:24PM +0300, Sergey Bashirov wrote:
> When the block/scsi layout server is recovering from a reboot and is in a
> grace period, any operation that may result in deletion or reallocation of
> block extents should not be allowed. See RFC 8881, section 18.43.3.
> 
> If multiple clients write data to the same file, rebooting the server
> during writing can result in the file corruption. Observed this behavior
> while testing pNFS block volume setup.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

