Return-Path: <linux-nfs+bounces-15499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F4BFA975
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94CC34F9BAD
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6A2F83C4;
	Wed, 22 Oct 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzij3IWx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4382F8BF7
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118504; cv=none; b=kRDsjg/HwyA8IfMpFjBy63w3c7oP1zBW32+eYux+SzSn39am32rrfHTcoBMssX04geBXJWpHL1Fa38GpWSsUaDt4AM5oB0BACgE6fP43Mm6kZISt7OSxZYbvPGIrSeZH+LlYdFCieQ0SFWdejTPDC5a1KYi0Rbf7aF6+tgMipOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118504; c=relaxed/simple;
	bh=SlcFPlyQIZqcDfdEv0M940luyabCGCNmZmiXFsHVTQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqBmjmUoaB7sbgkKItQUyGuM1PyvfKogefSKHylW51RBww8O9YTgnW7y4uUPy0rEcqOPVCWYqOZe/a1wBNGzNjptPOCqqTdMJY+7GpcGiN51pCziCK23PcSuBNptSq9rvx7RhM3Hs8gkY25AiuFYYf6KDHZ8VVH6RxpGsaTh4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pzij3IWx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42421b1514fso4041072f8f.2
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761118501; x=1761723301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uP02OIrJH+GYWmHdxnfvCH1j0VnGSf6v21IKCVsSCEg=;
        b=Pzij3IWxRhA24XBSi9m5gesmByMHLg3V6qiOGxj+mSDogGAWUFiVGlwa4QCVM6zQmz
         SIAsAl6CplGS9mqhr1cYlL6Ztaw3RqRMBPWEIp+yrcCbZjUo4qv6qiBEXwQr/NxkJU/X
         9EHg8BkYNFiBnsQD0/N42a7UCQrBWCLZ90ZX5DYGMI1+lp5s0Ui7+s9R0A+NOT2vBd+/
         Ka4Wmn6u271QlVnISsZSQ9JtbUBEWlH9mh3GQySk77BNnJK7nN0OCKuye/Svxar8blVX
         O+w6sfhw792w+c8oBIyHyJQ3Blm56pW8aXNkMcTkyeFf33VC7za+bjcnqeJsoJVHWkuT
         6LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118501; x=1761723301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP02OIrJH+GYWmHdxnfvCH1j0VnGSf6v21IKCVsSCEg=;
        b=lHn8tIPzbn5sx6T8YmPZ5Pyg+BlfahYagZbMbv/XGnEQFK2E0mHXv/8IlRMimYCz0V
         ftUcTJ3RowsldCrOput7KZOdur8ZhyPqTyiOO+4BnIXGzTGrdHnG0jQ+rVpIVSERTfY+
         FTpIZ4cEmGa3WTy4UILxj5kGjws2+J5f8UiXNu3RwJORU9JgODXfmjOGFUIFZQf12+B2
         Fy1KdvxFl015xhEsRZaPwXxghEKzpNw4aNqwgZV0EdrKGhy1BQUSNjDXt2ZBFu3ya9r/
         I6PHpRllhIs1Hvzb6TKmfALzFpB0rHk1wPz9/zkXA2aCfPgi4XTdTwn30UARbN/fphKZ
         YUBA==
X-Forwarded-Encrypted: i=1; AJvYcCWJVI/M+oE3Ruq0zchQlhcYW1HMncy4qk8UgArBgLPa86eTEJZLQmxTXFhMBLiokMtG26CCmwxNVX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7RKi8bpl7FdD69UIreZSock+UfytiUMn2qjmLVqq+lefLuOQ
	m4v913d0ca7eqZLPl4L61HnAMZGIExuWkI60mfuTYbG/mb4GTShuIlTRKIKtLGtITI4=
X-Gm-Gg: ASbGncsUH7JP9wdOSkgwDMxlUBk+mDsXJmTTYEM4NbjPqUUWHJ7HEP1MY1pjNs016vn
	Y082XEXyaTuE3WU/L1vF8FohOnU4dfiljEiqVU0Q5VOM8VT3LPxoNL+q1kh2MwmY9lPgQErkBaz
	3osJ7ixkjdZehe9c6y+ypFhYwN9B0SXgG/fQxVvlrmqXz9/rVneB51yg5lYazqRUPdK/S7xQOzI
	4EDOIBXbsJRmF7yMf2c6tnd/ZHq5kYcW+eiqgU2+K38UXjC3PtTh3yTZC2Ctr3T/tpGj/2IDhYq
	/iXYTdFFWNd8bpmA/nDqyIg9J2qH6QppkDre2Fmet0PGAQ5qR7VnvWjOEGZxznhbE050kFZaRpZ
	JiI2kmVWAZq3aIEw04TXQxavk+ruuiS3XtbFA2BLcMhfVl9gscUBxfErQgDGJauk1kAUUJpliKM
	+gDR1qnHCC2SFk0evi
X-Google-Smtp-Source: AGHT+IH83IpMhv1bnH3yQPXC59KdR/tClyfPU3iIa804OIH9TrWa56iWXz5kfq2XOFx8/cvVKF4gdA==
X-Received: by 2002:a05:6000:220c:b0:3de:b99d:d43 with SMTP id ffacd0b85a97d-42704da613emr12551093f8f.19.1761118500607;
        Wed, 22 Oct 2025 00:35:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3d4csm23271367f8f.19.2025.10.22.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:35:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:34:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: liubaolin <liubaolin12138@163.com>, anna@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
Message-ID: <aPiJIBTsQit5jyUg@stanley.mountain>
References: <20251012083957.532330-1-liubaolin12138@163.com>
 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
 <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
 <b928fe1b-77ba-4189-8f75-56106e9fac19@163.com>
 <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>

On Tue, Oct 21, 2025 at 11:15:21PM -0400, Trond Myklebust wrote:
> On Wed, 2025-10-22 at 10:44 +0800, liubaolin wrote:
> > > Sorry, I didn’t actually see any case where req->wb_head == NULL. 
> > > I found this through a smatch warning that pointed out a potential
> > > null pointer dereference. 
> > > Instead of removing the NULL folio check, I prefer to keep it to
> > > prevent this potential issue. Checking pointer validity before use
> > > is a good practice. 
> > > From a maintenance perspective, we can’t rule out the possibility
> > > that future changes might introduce a req->wb_head == NULL case, so
> > > I suggest keeping the NULL folio check.
> > 
> 
> I think you need to look at how smatch works in these situations. It is
> not looking at the call chain, but is rather looking at how the
> function is structured.
> Specifically, as I understand it, smatch looks at whether a test for a
> NULL pointer exists, and whether it is placed before or after the
> pointer is dereferenced. So it has nothing to say about whether the
> check is needed; all it says is that *if* the check is needed, then it
> should be placed differently.
> Dan Carpenter, please correct me if my information above is outdated...

Yes.  That's the gist of it.

However Smatch can tell that the check is not needed then the warning
won't be printed.  In this case, Smatch breaks the return values from
nfs_page_to_folio() down like this, and it thinks folio can be NULL.

fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|        INTERNAL | -1 |                  175 | struct folio*(*)(struct nfs_page*) |
fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|     PARAM_LIMIT |  0 |                    $ |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|   PARAM_COMPARE | -1 |                    $ |      == $0->wb_folio |
fs/nfs/write.c | nfs_page_to_folio | 340 |      0-u64max|        STMT_CNT | -1 |                      |                   22 |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|        INTERNAL | -1 |                  175 | struct folio*(*)(struct nfs_page*) |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|     PARAM_LIMIT |  0 |                    $ |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|     PARAM_LIMIT |  0 |          $->wb_folio |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|   PARAM_COMPARE | -1 |                    $ |      == $0->wb_folio |
fs/nfs/write.c | nfs_page_to_folio | 341 |  4096-ptr_max|        STMT_CNT | -1 |                      |                   22 |
fs/nfs/write.c | nfs_page_to_folio | 342 |             0|        INTERNAL | -1 |                  176 | struct folio*(*)(struct nfs_page*) |
fs/nfs/write.c | nfs_page_to_folio | 342 |             0|     PARAM_LIMIT |  0 |                    $ |         4096-ptr_max |
fs/nfs/write.c | nfs_page_to_folio | 342 |             0|        STMT_CNT | -1 |                      |                   22 |

But Smatch is taking short cuts in its analysis and it doesn't track
bit tests so it's going to be wrong sometimes.

> 
> So in this case, since we've never seen a case where the NULL check is
> violated, and an analysis of the call chain doesn't show up any
> (remaining) cases where that NULL pointer test is needed, my
> recommendation is that we just remove the test going forward.

Removing the check is probably the correct response to these warnings
more often than not.

regards,
dan carpenter


