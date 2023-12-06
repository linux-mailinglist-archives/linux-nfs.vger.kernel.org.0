Return-Path: <linux-nfs+bounces-357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4F8066AD
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C91E1C20901
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1B101C7;
	Wed,  6 Dec 2023 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="guhoCuv+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADC18F
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 21:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iXV4UMaZldrBkuQdUhhDw+67C3gjjFG2Cm6ABxsBhck=; b=guhoCuv+YDpP9cdTVK7YISHdM2
	zv8exdZfydKTErbUtEBgH3mznUdn+NQaRKVgMqfdN/275fQf8zRUgko0WhBSOS3qrft+WbCHiAXXz
	5QCeWJNbhqdEkMm6KjEgDkGGwEOeQBo7fFMeCwi0Hh1EeQ+gZXSkXUynFNZt+prI26ViepgV7KXID
	P8bqJlPEyQVcqNjgGGIBZ2FZtTYdiYo3SXpwYm7mBOyndFRMAsCx0DdwVEoKrMRij43CcW2gAPXO2
	k0r9TyuDgIe8TaIEoprMuLCfNEUNswt8ZaJQOCqtolzT4SQAYkHWIDVKGcac7MzehkHfCal60Ha8S
	DuoLlBOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkje-0097kR-2m;
	Wed, 06 Dec 2023 05:46:14 +0000
Date: Tue, 5 Dec 2023 21:46:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [RESEND PATCH] NFSv4: Always ask for type with READDIR
Message-ID: <ZXAKppunWJ7FTrAS@infradead.org>
References: <badc4f7fbd63c19a9f50a7c5c17968db16bebf5f.1701788866.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badc4f7fbd63c19a9f50a7c5c17968db16bebf5f.1701788866.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> -		FATTR4_WORD0_RDATTR_ERROR,
> +		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,

Missing spaces before and after the |.

>  		FATTR4_WORD1_MOUNTED_ON_FILEID,
>  	};
>  	uint32_t dircount = readdir->count;
> @@ -1612,7 +1612,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
>  	unsigned int i;
>  
>  	if (readdir->plus) {
> -		attrs[0] |= FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
> +		attrs[0] |= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
>  		attrs[1] |= FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWNER|
>  			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|

Here as well, incuding in the existing code.  Please add them and stick
to the 80 character limit to make it somewhat readable (maybe even split
to one flag per line?).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

