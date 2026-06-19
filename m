Return-Path: <linux-nfs+bounces-22685-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZxWHD6QsNWqrnwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22685-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 13:48:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FDF6A57E5
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 13:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="efzLK/Sr";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22685-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22685-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBA67300F5E3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C313822BB;
	Fri, 19 Jun 2026 11:48:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AD371067
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 11:48:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869726; cv=none; b=b1xahXCXd9KKhPgVWSYOjbrH18gLJoMY6nHis9m3SHgCOOF4J9fxXhd4QsgIf+FZpyaFzmENCwvVyqqV5lLuQCxWDVLIqDtPMOoq79o+3EBpvHQCcsAZDV+cbdzvz2JL7LtDdSPgWcaz4peJ7+rlvQWgdhUD9OXt7pUVeCWRvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869726; c=relaxed/simple;
	bh=+Rhr6/BaG2INCFGd1yTpM9kmQYK0tCW8WSpUhYNEdnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjZZiKx5NAYaaqeP/hndj58m5NttJaW/JjOQqjAH0qplmsZ94h4ucROiMV71l8HMMDcSKBt9Eyp5J/dnWyqiIg/lXTnLX9Ie6/p/XR1Nz8NFydbgaA3xZ6KA9OLGb558lGe/Hp9s6vrSl5OkAzWn/vX7qa6em09U6kS+dgPXyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efzLK/Sr; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6a4eccab1so36295ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781869724; x=1782474524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JWEs8HGgnLBgYpHdzPZ/AqQwvxEx33KajFnBVSqfRLE=;
        b=efzLK/Sryoj8a5faGSaz9/3iGUPjBf4TyKOdTuAmLSeRHDANDTeVMbxidMM0Y4W0si
         22HdmXeoZCZz4q7bek6UFheO7LScE7vWUFjOKsrLLILCV62TzehLJVVN102mQi2lc0Ng
         fpexP/ZglIVgYIuhwXO+nGA1FlyWeOOd80V6ggwwVJzV7gPeJmb3GRN39Bbvy9sYiMXD
         +iBMA7Z7geN7wHAL/vTLNKs9jHOZ1Tu1Fu6l8I4y79G724stlgm2wIDKSpzZwVPAjGtx
         fVXJkZTa6ZA6p5QZdrYzz0Zs2xXT5N22//lO6H2nSkpgTM2TKSAfqFe1r3ezqNTiJ1wJ
         MckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781869724; x=1782474524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWEs8HGgnLBgYpHdzPZ/AqQwvxEx33KajFnBVSqfRLE=;
        b=QozLTfGZZd+UVvXTzZ8I/5T24FuEUSLi+TI7vDMqc+imVq1SNdRxolldtPXmMKGsxG
         JYQvjBuUbFutp28+pu/w/fm4gbgjCdKURxivNeXXdBAL1r/rxcC35eYUY0xzBanXFvH/
         K4iM0XM0ZGA7blzBhO61h5n/XxeoMNvEwI0Hc4rxgVoqpusVBd/EfmMP9F+zM0ck9Ev1
         15fFl8wxSYjUbAt8Hh+WBl1MoWfpbrom3eTkCtqsjiqxvTLTaoCuFKf+i4M0Gev9Kehd
         pnuPF01WZ4r7DFAtbyT6y4Rkb9tpD5iRuppFFO6uW5aVglQR6xdE0TNlGwZKj7mNTaI6
         DngA==
X-Gm-Message-State: AOJu0YxmwUTkb1uE7j6wcWIQ3lewlwLCLYE3wP6o7d/jW2wL+IY2yk/y
	08LDdJY6tIH5VC6LWWDw51/TEjmmy4sgL0bv8aknIV/M3126Oftzl72inSLbZVcX2Q==
X-Gm-Gg: AfdE7cmCGw3PD4wiB4im3B2mjFuUPKA+3L4SZRZXYfRT8j1UvGGmaxmXUFV2nW+jgTX
	ze7YoV876zTPedTMfanjVlIfGmfrheoWalLOqqJTPnJUsg85Ea95d47KtMAxvsPrfuoaGHzcjOE
	W6frFIMmgTT/VP4d5gxghaF924qPcedcTx2XG9/n7TB+VaM+3auw+DrW8jq9ZQY1lWnMiZVmZlQ
	Of3BHsKTzeQpvY0gF0fYdM8xPKy2ruLqsXbWtlcZ4iZQxPzC1DqQzAghMmBYH9awdiE3DhHyD46
	VqOFrqqht1zqH/cErfosQpYybUTKa6Pc5VqoUnyo/sAt8GSRxE4kz/RFcNsDvMlB+MoaC89GTYv
	tFn9qOHHdwQA0t73McsjqvgcqfsHzGqazT8UGzo1jPuIDultmYZk+o7+DgpHEDtp3BiDi7qTI/d
	UyS7ofcnKiKF6eElnj8RjxMAi1dHe1fG1Uxpbtgc71hyHzJFXFmRvH/O6YLi/v
X-Received: by 2002:a17:903:38cc:b0:2bf:749:55c with SMTP id d9443c01a7336-2c7201a695bmr1246475ad.21.1781869723706;
        Fri, 19 Jun 2026 04:48:43 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c720c23b8bsm21277375ad.80.2026.06.19.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:48:43 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:48:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v2 0/7] nfs: Modernize Direct I/O path
Message-ID: <ajUslaUwTClnFve_@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <ajP8oV7Ho3db_09N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajP8oV7Ho3db_09N@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-22685-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:shivajikant@google.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2FDF6A57E5

On Thu, Jun 18, 2026 at 07:11:45AM -0700, Christoph Hellwig wrote:

Hi Christoph,

> On Tue, Jun 16, 2026 at 01:39:53PM +0000, Pranjal Shrivastava wrote:
> > =======
> > This series has been tested with xfstests [2] on RDMA & TCP transports:
> > 
> >  ./check generic/091 generic/130 generic/139 generic/143 generic/154 \
> >          generic/155 generic/183 generic/188 generic/190 generic/196 \
> >          generic/198 generic/203 generic/214 generic/240 generic/263 \
> >          generic/287 generic/290 generic/292 generic/330 generic/444 \
> >          generic/450 generic/451 generic/586 generic/647 generic/708 \
> >          generic/729 generic/760
> 
> Did you only run these tests that previously failed for Anna or all
> of xfstests, which should give you much better coverage?

I highlighted those specific tests in the cover letter as they were
reported as failures for the NFS direct I/O path.

I've also run the full xfstests quick group on both the unpatched and
patched kernels (7.1-rc7) across RDMA and TCP transports. I did not see
any regressions between the two runs, the results were identical across
the quick suite.

I could report the entire run for a patched and unpatched kernel in the
v3 cover letter if you'd like?

Thanks,
Praan

