Return-Path: <linux-nfs+bounces-22265-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AAJxELEvIWpDAQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22265-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 09:56:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4D63DCAE
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 09:56:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=dKeGZspr;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22265-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22265-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8D60308908F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5E3DF006;
	Thu,  4 Jun 2026 07:51:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27A3DE443
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 07:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559507; cv=none; b=pspUN1m/bwjEb1ftXS/FVoCD1PqCvag+7SAiBuUebmurVmqBkEgbHSA52pg/EHbuxGCSZ6m0qKhrM0grdEX++NEDa4RV5zACGWNcKQNi8nQtrD/jS9ksCIDTFI5ugCjJ8M7Lxae79Maa7cY+yLO32pEkvc4MLE8DY7u/GGbIRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559507; c=relaxed/simple;
	bh=8WhlVEcsH4b/tq9eDNCZXwSzxv7uXGQkdn6QUBxyViw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snidrbfLkE8kYUJTmxy2KypRP0I4wOFffIQeyIj5sqtilO4nY4tbunDT9zZ2qsA75+4SUQbO9xbUjR3eJkUchoDuUrpeCcXzlhGsH9/WkfJw5jBTSJCGG0Fdyaan6pPFRB7BeHQwAC4i/NSoeHh/MLsVV0feJsNCJXjJyTDjP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKeGZspr; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so84985ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2026 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780559506; x=1781164306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNu5LGXo8LJ11L0Yl+CMg+JzQgcqgmRZhwXvn5gnfZM=;
        b=dKeGZspr9Nkniev5POpkqAEb3SHSJ0O2Lgd4ggzSNrSjg92ZR09HN3s6K+bKyD9IsM
         JBToMwSio/4viaaVxHlhHDzm/DstlA27CFsyBwinm9kW9lk2QNVT7GtoAqFriYDGGGAS
         eagk+wP8jpoAQrCINdCUxpefUtMjmtqe8zSMI6qGWGQakw4VGr+bVBEkrGU1yp592/UN
         xw7DV2Zfj+PHUO4TCgo9qAMKdWkOzroOBO1ve15/iu+Uc0v7GbGnw3E/Q9/eSGt/12ED
         R2mPR9XyaD3wXXzs6nqcPoka6ZmokJoFMsHsh1bq+o62S61pPr10ZiqwsGnVkOLDrBbP
         X+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559506; x=1781164306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNu5LGXo8LJ11L0Yl+CMg+JzQgcqgmRZhwXvn5gnfZM=;
        b=NySeWvmqd5ZiStAB8179OtKAJGjiseHE2t8ixlcjr18SdpPMeczYluz0t3dRvSJS7Y
         FtUAgMsZ968vL7+l4eNsi+6CgXFFudpKCKkupDNndp0k7Eoxrfr2ikDGpqXXUwRbBZbZ
         CkenOpjDDvYEYva+9L6OxOGpK2ZRedGJpj0vpAPeb+wng7tDDO+aJz4Xqu4n1kdeNVEX
         nWe741ZJtby/Z0sYLwn09AlbKKGpOhcp08RMO8QG5zPp4RKat/Y835h2VrbXLRzkKIga
         8sN1x6vLh2qEy3bvjvzY47KIG49yyhoBL/Jfrp+QtLexdQB1SqW3jE8HS8d7F4paQh44
         /qgg==
X-Gm-Message-State: AOJu0YyPpRIPNT2ZObZHaC6hzzrIOgQhHTPJ00MjLfctT8c1ES/NLmRH
	uvfphTMjartbYtJ6PT63fu8OKi96EzJPjE2Z+zA8uL7ufyc4R46K6IJa7fBfkuveYg==
X-Gm-Gg: Acq92OGUacAjoyD48zvN0UYCyG3nVQGYghGAXZPY3lAs1XmZSG7uYzTEcNR4OL9zSVy
	uLfQZAh3tcfLzE8xmyY5QDVBYYmSqGOjmV1h3+ll69Fc3LN4oSkJTQPpOm41A6DJLD4ENz4CSxr
	un2vWwfJyswNrMqYoy1Qal8tXCuFTrvZPlkgRt1PsJos9qRHQt+JzSBLUJkJO2RDVAhEm33CrL8
	6BQzgnbEYi6aIQF/HrpIDFbUIfXWLh2Rbk6X1m3jrEL8ImicMuIXK8o5eWGYXEhFWmx1BeeT5J4
	z2SZXaZfG4fvVi9P5mvW++o4deM/PgDf518PmS5LaZbtyKUqSANm6ghy/AZQx0/HFtcY59oJOMf
	UsUYVTGtVDp8IRv5C/TQj3fjtG4Euy7y8kImj2PRRHwPnyUVASHqZe8ts0LJqJWwe6+naj8YiXa
	+z/Xy58HirDWPJSoBKZ8Sv3bKMLTbQcpxIAGU+EzpZIoKKZuJsvrrk/ZVOTn5povOcmYMEkuA=
X-Received: by 2002:a17:902:ea10:b0:2c0:b19c:2e10 with SMTP id d9443c01a7336-2c198ab2908mr2389815ad.0.1780559505080;
        Thu, 04 Jun 2026 00:51:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm48697275ad.51.2026.06.04.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:51:44 -0700 (PDT)
Date: Thu, 4 Jun 2026 07:51:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v1 1/7] nfs: make nfs_page pin-aware
Message-ID: <aiEui-aLhGUAa0MR@google.com>
References: <20260603053033.3300318-1-praan@google.com>
 <20260603053033.3300318-2-praan@google.com>
 <9cd182d7-8f31-499d-aeec-33bf86271fa6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd182d7-8f31-499d-aeec-33bf86271fa6@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-22265-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4B4D63DCAE

On Wed, Jun 03, 2026 at 12:39:47PM -0400, Anna Schumaker wrote:
> Hi Pranjal,
> 
> On Wed, Jun 3, 2026, at 1:30 AM, Pranjal Shrivastava wrote:
> > Modernizing the NFS Direct I/O path to use iov_iter_extract_pages()
> > introduces page pinning (GUP) instead of standard page referencing.
> > To handle this correctly, nfs_page must track whether it holds a
> > pin or a standard reference.
> >
> > Introduce a new flag, PG_PINNED, to struct nfs_page. Update the creation
> > path (nfs_page_create_from_page and nfs_page_create_from_folio) to
> > accept a pinned bool and set the flag accordingly. If the page is pinned,
> > we skip the existing reference increment (get_page/folio_get) as the pin
> > itself acts as a reference.
> >
> > Update nfs_clear_request() & nfs_direct_release_pages() to use
> > unpin_user_page() or unpin_user_folio() instead of only refcount
> > decrement (put_page) when PG_PINNED flag is set. Finally, ensure
> > subrequests inherit the pinning status from their parent request.
> >
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  fs/nfs/direct.c          | 22 +++++++++++++++-------
> >  fs/nfs/pagelist.c        | 36 ++++++++++++++++++++++++++----------
> >  fs/nfs/read.c            |  2 +-
> >  fs/nfs/write.c           |  2 +-
> >  include/linux/nfs_page.h |  3 +++
> >  5 files changed, 46 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> > index 48d89716193a..80319c5eeed4 100644
> > --- a/fs/nfs/direct.c
> > +++ b/fs/nfs/direct.c

Hi Anna,

[...]

> > 
> > @@ -435,6 +441,7 @@ static void nfs_page_assign_page(struct nfs_page 
> > *req, struct page *page)
> >   */
> >  struct nfs_page *nfs_page_create_from_page(struct nfs_open_context 
> > *ctx,
> >  					   struct page *page,
> > +					   bool pinned,
> 
> Can you add a description for "pinned" to the kernel doc comment right
> above this function? I'm seeing:
> 
> Warning: fs/nfs/pagelist.c:446 function parameter 'pinned' not described in 'nfs_page_create_from_page'

Ack. I'll add a description in v2.

> 
> 
> >  					   unsigned int pgbase, loff_t offset,
> >  					   unsigned int count)
> >  {
> > @@ -446,7 +453,7 @@ struct nfs_page *nfs_page_create_from_page(struct 
> > nfs_open_context *ctx,
> >  	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
> >  			      offset_in_page(offset), count);
> >  	if (!IS_ERR(ret)) {
> > -		nfs_page_assign_page(ret, page);
> > +		nfs_page_assign_page(ret, page, pinned);
> >  		nfs_page_group_init(ret, NULL);
> >  	}
> >  	nfs_put_lock_context(l_ctx);
> > @@ -466,6 +473,7 @@ struct nfs_page *nfs_page_create_from_page(struct 
> > nfs_open_context *ctx,
> >   */
> >  struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context 
> > *ctx,
> >  					    struct folio *folio,
> > +					    bool pinned,
> 
> Same here:
> 
> Warning: fs/nfs/pagelist.c:478 function parameter 'pinned' not described in 'nfs_page_create_from_folio'

Ack. I'll add a description in v2.

[...]

Thanks,
Praan

