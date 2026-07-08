Return-Path: <linux-nfs+bounces-23167-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCepJKg5TmpFJQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23167-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 13:51:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E737772606B
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 13:51:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FVhszoYd;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23167-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23167-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3895D3013AB4
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F92428849;
	Wed,  8 Jul 2026 11:47:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916133C062A
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 11:47:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511255; cv=none; b=D7yn5lDZdzLFBeZR4iS/7FV5vl06ISqVj+DS48iYlvATtHYzD8SSHeWL/vbF6sSudP0BGmgNWq3qK7MUetpU+/EXsCoecNgWZuN4w4H/nBPvc5V2VK8AJSx7QaXG2db6XbklJqfm8QHfObamFXnUfB28gJjM2FD/D4Je9QZER5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511255; c=relaxed/simple;
	bh=dmyezYiM94/XAuJXZ9HTsToNSTAmeUiFhmIQmDV4w3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVfzCt+9wFeAdKjd5/FxH1TsFQP7kGQa7ue8U7lBhRRml6mP61uEa1xowg4yvKu9Yma+zXRfmO0FPSMru8HhgHDSeZ0E+MWcheuY1WSK0IPPUbXhPQmOwnyUbESaq771qyOQOsvOV3sspnolXRv4vbd3AVu1tcj61kBY+5YiXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVhszoYd; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab97c86bdso76705ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783511254; x=1784116054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQthvAmb6mZfzW7rEXSGGNwecmdXpDNmUVxAWD35bFk=;
        b=FVhszoYddlNQ5Dova5wWmhtq7wxg0kzL2UxwHQvr28N0IS3vXiXhyufPPAOOfOrAUs
         zv5sfJdxRFcjkVvgUERn75vR2hboCW850YLxs2h1E7pHT9K/zB9NBmK53OfTXPdPEpB7
         L7mPt+kfUUyuT+pdLomMBfki/McgV6BIzFYtriA+3oyUCp8xpVaTPaJlRXEZyeVXy8yU
         FeUaJvfL1qf5PI/piyWImXGgXGTfDPIMBi2rDaQGaf0mU7gWkc3umnKxBS5QWwwqkRSG
         xJDLQVScOqgEeEjD2L3ATpy7yciKkAAHiZsVgndQGIGCwJS/RAuVJ/TpGMJXkzSzYTHg
         V1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511254; x=1784116054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQthvAmb6mZfzW7rEXSGGNwecmdXpDNmUVxAWD35bFk=;
        b=jumF2ukR/luGCS0cyl47VXwGRiUZAsnpMWqRDpgH2FMpSPDFQrqUx78o5MFoiZlfYe
         3LK+aQCerP9bFv4p8FUHXJY9vfMFMvopsxBWAPV0mj4fx4o24UNMpTVGBKYPdAUw3GYf
         /PUEPS5HQNacGcdu/oF0L0P+rg6ylZLIeD1JKZEs5MPbZhuUEfD7f1AwHQT7AnrkX4Im
         lIwucHLpSvVNzIXarWso7hddKJuDyjyccLx3g8nPCUxXlOj9uP3AvV1dJ7FP6S0CbtpX
         5S2mxZxTahF5aW20Ar4CJUM67JZwFVOOx7tpZIgHLThpoAtU9SEZnn+pinkxfC7ItONB
         xz5g==
X-Forwarded-Encrypted: i=1; AHgh+RrNyRKpMFqCu8dpzH2evlJfWrO9xZJw5Nc4KEIHCPe3lROTKKLWo1IywRrhZWQ3stEC1YqWIkqbPDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9Obk5j6EPIM8BV4qohjBURzuWlR63mGKuXIRF6n0EILhebYn
	ZrqhqmkjtkBukBg1eNyhGQmQQSAT/zDsCSHuHHsZ9xNVEQTkltLQUipZdDyy9wyNdw==
X-Gm-Gg: AfdE7cl5yBYDOXI5lUJNjSVZxWwMcvkf0aTPwcVySU76T2wG/fFbesQYL9LgQz/KLOW
	JUf6nyLAPzKrSdt6354Wweo31e9/lL+5iVxriTvb1NYWIGGG76NgGIkU/wmRtbOYWZZNf8GA2pk
	Ze/0zBO6pkCCS5V7wLrbvDqnjofK0SvhRQP34hBQudrat/rQhUWxSTvn0LmLLezVhJ8C8nFMV0h
	ORSbsqTQCzAnNrg6dZuTWnOIVo65vydiROU9pfK01QvsDQLSSD3s/9I2cOVZHC7FGOw4iFTCX56
	KCB2cxYILkvUhLGyD/D+nM/5Bg2NXOilcUcbd0WQNy2v9IvxYWCWcgRi/H2HDTstxUEU+8aPtDf
	NEHy928lFav+NRHcfEm79TQ0gp453xzpu8m2SLNm8pDjSX2BPUDx4wzJmin46oW4+s+pfw3AKg4
	Q1ixkhcH3fU/Uke5VXhVjQ/v/WMSzYx1la9SMt68wHjqka1GY=
X-Received: by 2002:a17:903:2442:b0:2c7:a13a:7fe6 with SMTP id d9443c01a7336-2ccc9c48162mr6446945ad.10.1783511253251;
        Wed, 08 Jul 2026 04:47:33 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36676easm2656833a91.9.2026.07.08.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:47:32 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:47:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ak44z-X-SKKhkBkg@google.com>
References: <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
 <akevQfFVteCOD6LM@google.com>
 <akfAgy52s_Gch2KG@infradead.org>
 <akzsO_vmYX_7Umjd@google.com>
 <ak4A6IEmWNi27I2d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak4A6IEmWNi27I2d@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23167-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:willy@infradead.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E737772606B

On Wed, Jul 08, 2026 at 12:48:56AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 07, 2026 at 12:08:27PM +0000, Pranjal Shrivastava wrote:
> > Ack. I see! Thanks!
> > 
> > Regarding the page_folio impasse, how do you suggest we proceed? Should
> > I expose and use get_contig_folio_len() from bvec? Or should I move the
> > NFS helper into the iov_iter lib? (or both).
> 
> Sounds like the best way forward for now.

Ack. I'll reuse get_contig_folio len and move the nfs extractor to
iov_iter for v3.

> 
> > Also, do you suggest sending the Folio move as a standalone patch if it
> > is blocking the rest of the series or do we prefer keeping these in a
> > single series?
> 
> Sorry if I'm thick, but I'm not sure what "folio" move means.  In doubt
> if you think you can get a series merged quicker without a later part
> I'd split it.

Apologies for being unclear. I meant I could post a standalone series
that moves NFS Direct I/O to folio, i.e. break out Patches 6 & 7 to
another series, if that makes sense?

Thanks,
Praan

