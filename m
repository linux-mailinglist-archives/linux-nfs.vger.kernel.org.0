Return-Path: <linux-nfs+bounces-22687-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M+OhFtg2NWoRpAYAu9opvQ
	(envelope-from <linux-nfs+bounces-22687-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 14:32:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F826A5CBC
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 14:32:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=a+TsZ8cP;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22687-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22687-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE38301990E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440037C0E6;
	Fri, 19 Jun 2026 12:32:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03015384223
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 12:32:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872334; cv=none; b=uDwR8SDZWEQ/7/Zk+QMSuMRBUr8imxMaNnp+UKzk3f80wRCBzcR+81KzWNjKc+SKOeiLKF5Kpk6brmPYMcAiEg3gyoFwEUOm42LHvqx4xjf0MV1rfNUF/CkzUHop6dHP2g+urWUetr9P7gVgdggZ3iqFzdOYM8q/uhW7UFm6n5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872334; c=relaxed/simple;
	bh=j7paI+dBkaIDU/IeX574vRzwUw7u87K/qklOPHPQ9xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofqoU7AahN0eiq6IfElOc08S09TDuTPEERmHm6PTd1JBzQ86Tx5DdP8w2O8xtY5oH0XLaiIwOcJi66D3PWcvSoeIHZgLdgsejA2D5is2mv2iP6BabcWJ44KOv1kCwWEVFCHUZ05litfgCMwcDM6B16s87wY/hsEVRuAgwMXb7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+TsZ8cP; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso46935ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781872331; x=1782477131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zAgRJPG/x/HKYBdMFy6t9gS0SW7lI2ALodBm8Z0F2FM=;
        b=a+TsZ8cPo9DlfKpk1KZbrFHdabGUKtN/sYEFbYnjwMHxj0nEUq/L1FxhMf9eOv0s0x
         GtdoOyJ5Cqjn4gA56d2jFnmlGT09bzJQY2QEOSc06SUwWQH5SVz7yGotsWAn7PiAKj9o
         JmaVXG3nqW0dp1BFYEuad84MtD+md8KtGJ0OzQk8fqJMFyIbD97Eh/uk0zV4Tqn1Rrhs
         zg3/yz385ljiS0Q6JtgzQ4qHvvldv29B1EfXS1wvwt2vXHQ2sLGB9KXsKkz3f1KKDNzO
         g9mzBLILFGwNv+BhB6whmqNyOknYVnZOwRym0ORt/iz23ekVyGbaLobkNSNU6fWrPeOI
         dc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781872331; x=1782477131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAgRJPG/x/HKYBdMFy6t9gS0SW7lI2ALodBm8Z0F2FM=;
        b=oHJGsOcAKOdfqgLhpeHF0xibZZgm37/E6DzF7Qqzym8H18pY6ahWheA+TypzCB2fG2
         V1ul+EItUXi8JosCOrp7ziZT9LOMDS2y9HIvGV8jxmzj2Z34eXYlDg4+eGzDr0RFIyDe
         o5lVzmjUglDb07sDFwCZ2B7tIckJrnNA1jx4Psg/TqzOJG7nzfTk1iqxiH44YpyGFRen
         ufFJyH8CWTZUl9VC8aPMy52MBaz0gQqfwaRCyugFMsa8a9ZZKdnaKnNB6XdJ4J+8Oxpw
         MbgU2UUZtftubMbXzKxg0SPPjDgWd2vmOzSP9P+Bo5KLa08+F/w8Nd38N0blgLhbTxOe
         rGPg==
X-Forwarded-Encrypted: i=1; AFNElJ8R3FYnLHcoBVxBV5cwlMuwtXKjrc/TerhLCp8LRx1GlWtSJuc3nHB2OqTgeLZ2XUVaA/jY1w0938c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0niTlLTr9o2baK1s5iiQJpOBf8ni5aNBTo7Yh6i1LBRPgZYg
	/HqcMJtaHigHRVyo6QcBkytNH3u5HraBjD09Ssm3ayVGUfcdwnXB6AIdZ8vaxwHDGg==
X-Gm-Gg: AfdE7cm8uUvJG85c4Jl6bT2TVCzWEhYeuhslOBu7zZ5hZ3iFgvxCSQm5HIarvrWayzs
	dJb7a/pIgGUJ51obrhsVmvymcjy+RGGW3wFp79lOOjOO6uX0q0F2NiWehKLmoQdID3RiQAsl+qD
	g6mxUeMBQxlcI3leJx6I54eX93LWn7asvWZGarO4Kh3dG+hlrcuSrETTwO7sXthSFET/JjWaQi7
	HnpfhWmVtpVvsL6WJesTU9QK/ZWEKMS61JsxGChyU3Sa/LMVJbNnqRFF2d57/vo0nWCd2O1PWT1
	bRyf3uBQTmmM80jiLoL3YpPFTv14YckSfoJ/0fgRuw85gRktjJks3FLtpgkgT/xeiioEwEMoFUb
	+Zc49jJq2zzJaqNlHMPscIoZ55E14yDMvoTlBkEkK9fdTEnIiBBNChe785jI7+FcXhCRKOdBi64
	wM9kR1SWpd3L6/ikUo3wphxtFeIvpb7Nr38LEvlyi3QU9VSFwx2g==
X-Received: by 2002:a17:903:1a45:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2c718f8d692mr1926525ad.2.1781872330656;
        Fri, 19 Jun 2026 05:32:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845534d42b0sm2382315b3a.0.2026.06.19.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:32:10 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:32:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ajU2xJ1BAqqtog8T@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQ21kH1ZVajS2Y7@casper.infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22687-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:hch@infradead.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1F826A5CBC

On Thu, Jun 18, 2026 at 07:20:06PM +0100, Matthew Wilcox wrote:

Hi Matthew, Christoph, Trond,

> On Thu, Jun 18, 2026 at 07:10:45AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 16, 2026 at 05:23:48PM +0000, Pranjal Shrivastava wrote:
> > > AFAIU, the MM subsystem explicitly ensures that every valid struct page
> > > is part of a folio.
> > 
> > It is definitively not what the vision for the folio is, although if
> > I'm not mistaken it actually is still true right now.
> 
> It's not true, eg, for slab.  While there's still a struct page there
> for slab, there's no refcount and flags like PG_locked have different
> meanings.  You'll get into a lot of trouble trying to treat slabs as
> folios (and that will include assertions tripping).
> 
> > This whole
> > area is a minefield unfortunately, and we also ran into it with
> > iov_iter_extract_bvecs and the earlier block code it was extracted
> > from.  Adding the relevant people and lists, but for now your best
> > bet is to stick to what the block code does or even better reuse
> > as much as possible of that code.
> 
> Yes.  Fundamentally, it is no business of the filesystem what the iov_iter
> refers to.  We can do direct io to slab memory, vmalloc memory, memory
> that doesn't have a struct page (eg iomem), or whatever we choose.
> 

Thanks for the clarification. I understand the larger vision of keeping
filesystems agnostic to the underlying memory represented by the iov_iter

The documentation for page_folio() [1] mentions that "Every page is part
of a folio," but it appears there are important nuances regarding slab
and other memory types that I was not aware of.

However, I am a bit confused on one point:
Looking at iov_iter_extract_bvecs() [1] it relies on 
get_contig_folio_len() [2], which calls page_folio() on the pages 
extracted (via iov_iter_extract_pages()) without additional checks for
slab or vmalloc memory. 

I am happy to refactor the NFS Direct I/O path to reuse the same helper
(get_contig_folio_len()) from the bvec extractor, but I'm a little 
confused as the bvec extractor seems to suffer from the same risk?

Is the recommendation to keep these details abstracted by the iov_iter
lib and eventually hide things like iov_iter_extract_pages() and manual
folio conversions from filesystems entirely?

If that's the case, would it help to export get_contig_folio_len() (or 
introduce new helpers) in the iov_iter lib for NFS and other fs to use?

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/page-flags.h#L291
[2] https://elixir.bootlin.com/linux/v7.1/source/lib/iov_iter.c#L1849



