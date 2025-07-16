Return-Path: <linux-nfs+bounces-13103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD0B07477
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E81C228D1
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E020110B;
	Wed, 16 Jul 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/yW9oRv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802682F2375;
	Wed, 16 Jul 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664586; cv=none; b=Ig7KCAavA8Mbmjt+vW/UvLriMl0kHasnLC0XBf9wJqBLvlqNv5Dgmi9qZ2+Wm89vxO6NsyWgOBD71HyTe2xP4xCNrEdCQUP8tC3qkITcjbiSCMuuM15prYDikGvfFCUHATwaplGDj8YERSfvU79dQAs6UX0Y2mMfXe/ZCQ45daY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664586; c=relaxed/simple;
	bh=4EA8LcV/PNdhLRaJOQnhh/fhowvl5u7sYYahdk32Cws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNlyZ79J1FBMK4R2fktSY/kfthrnDc9lE7Tpi50pBD+G5b6O/HK5NOptQur7Hacy/ZCXYDC2kD0MvPWNxvqA+NxTO9FtVcEJagzL2GqBZdALQVwSXpBhfD3xfFzpE01nqgyQxcqN+Z54zJoP07IQOwLpyr8X/N5r2XTwQy8Tyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t/yW9oRv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4EA8LcV/PNdhLRaJOQnhh/fhowvl5u7sYYahdk32Cws=; b=t/yW9oRvD6+AjbAem5K1CHApHt
	2xa0R0BEbhtHX9cfNRk8qk8ztwFilIed1G+xhL0cWwMQB1Xw57Mbx8tYxGwGxvvA0gKgvwXoAtpLV
	TFpKgvtCtzXEcs2Y5K8y9rENRxDV2KeY9XmwTa4oR9zIgdrX9TIaygddVQH5GXTAlX8m1cH2wj2IQ
	waD7/edG4bbW4+bDf74Hfz7rlCOcC+uvswp0MYAzkWvWt8t9CYzqTKUCN+GLWkXkpjr/miFvgLUNL
	EBCGDbyBP7ead6KMbxKeROEMPPYa8WKBIYoABG0EDCMkiA8Jraiec81/lkC1QynS+yfhOfRhFdXJP
	8QFXQMug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc07b-00000007XFM-371o;
	Wed, 16 Jul 2025 11:16:23 +0000
Date: Wed, 16 Jul 2025 04:16:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2 3/3] NFSD: Minor cleanup in layoutcommit decoding
Message-ID: <aHeKB3drKSuMk24G@infradead.org>
References: <20250715153319.37428-1-sergeybashirov@gmail.com>
 <20250715153319.37428-4-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715153319.37428-4-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 15, 2025 at 06:32:20PM +0300, Sergey Bashirov wrote:
> Use the appropriate xdr function to decode the lc_newoffset field,
> which is a boolean value. See RFC 8881, section 18.42.1.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


