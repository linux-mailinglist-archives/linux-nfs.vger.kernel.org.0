Return-Path: <linux-nfs+bounces-12228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F392AD2AEF
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 02:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0949C188F517
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 00:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D25433A8;
	Tue, 10 Jun 2025 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTubOKtP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151F7D098
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 00:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749515815; cv=none; b=RmeCG1k3/Sb8/PuXt0U1epSr08/7AlPaeBXz3IcNRCgLxFgn2V86T2k9tothqoDP/WvG4ybSydP5dXnuZknWleq29y1LgziWNWkqC95GqOc9uPvDH6sVXRYOpiJwj723t/F818ABMrBO77kbxQ7lpVR8cNRkVLIIiHJ3ziBMV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749515815; c=relaxed/simple;
	bh=HH5wq+8wOvwXsuoOYSaDiXZx7FEt/SAejcNg8aEix7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbBgusizWONTfYFKmNWkQ9vSRosa37G7qLnQR82HnYrR1Q58hd1nlg3CNc2j/TAkGnrjsjdrQgj1JQ6C/2UdipIg8Q2Zim+1TJV8sUl94bP3aUM/unr1YuM1unom5/JMJt2t6sWdMQP0OX553te7zYeGPBeZR4oJUC1NAX1ocPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTubOKtP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5533a86a134so4648528e87.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jun 2025 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749515812; x=1750120612; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqKkI3UBVz5Wo4hGDKaUO9derx2/XfYnAv9GgTihVL4=;
        b=OTubOKtPv7iY35tp31SjfHrvXoxFs+6cF8hYJ5pbXTRxo2pDyDygODloN+Ear5kGOZ
         eCQUG/WvjkRQd+R7Myl4hltv0CvIi7NlaTAIkiCJs9RYFvLRLe3o9d2UwemHrRKL7tIe
         ugVjQsSEhM8lS+FIloq9z9Qe09hpWE+ndC1UzVLwkY1aoKg5J3DEHvj9NDYnJf2dQMAG
         CD3enbkPqlHaAB49PjiEkNmDP01H5pMTxNeEkck/xVvq2FF1x75S1cxK05tIdITGjvBj
         +2bZnjgp8TVkiOVJprTCyL8JyhnyQjRhHVzYP7x1GrrNIefaPezeNdy1QTASLqjsUrpL
         NS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749515812; x=1750120612;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqKkI3UBVz5Wo4hGDKaUO9derx2/XfYnAv9GgTihVL4=;
        b=JalrOTRfxhN8mHTk7ddADKQDb5AXhOX2Z2dXUsuaoaeuwh9OEpSW2xVhOINTmyG5W6
         iwTfQeBR1fCxBk6cTB0ZqNjpCgUt8UJLTnbehpz1nqVRw078QgCyzRZKPZpvnFm1nNxL
         1ymbwD37qimYIWzi3FE+pvTyAtleCPvmK1e21/4SAEc96n5OC0tPGO+EMebTQ7IP8GUv
         OnYB38E0agzkJw8LKgXi1YLcrJdcfyHyssWzSPJRMzTwkQQZP3ETL//LAck8daWnSJdD
         2cRX9AB2YBSyW+3biPURaQjO4Zg2/mFItZeB9MoQGvfYaGrwyYEpdy/4i119KmAy9Dab
         3w3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOnxUmWZZ8hggHJwiqdLeVCV5tECcx1v9s95n6kuC5bIK03PftAUgV3YKAde8PLT5pd3lzgOwULTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjE27/geRSG9nkUWbyt14ujWNoMSdziediFOM9E/1SUIgo3m4
	kXhhB8qoSxA5d3+ZkUUZVXsCXjVhJz8QwBh4/MzzuJ2FZuRXmvi2cDo+
X-Gm-Gg: ASbGnctT8QidztkeT9R8frU99kxogavAF1s1cuCRC12s0WFEV3xdVuPcZchR4R4IlWa
	vm++X4ACGvlAb8/Xg39TUHP9vQzfXR33M9x3fmZF9Kw+x8ZJQFqrcbzQ/EB+9ZUF6snHyHRADKN
	Bp3iTdQycAoSQSAniyiRYdkrW68RYEmQO/8hWm7GEe+3PS7y6oyKzqEl6LTE8Kx3WjICR1NllqG
	2UfX11FYHnTV6KBI9MUlply0s1pk0fIH+OP/5cp6goXCaN+nd1tjafkSH0D0lTIzoX9BpsO+ejN
	oA2/gwOcEDgsGxyPYhAZ1gR/ZsL1tesiZbA2a1+j7yKvNYNzlIbmijG0GAITzN+yv2uLCnH8IrQ
	0GjSiZDJvi1/xykwcOJhMpMVd
X-Google-Smtp-Source: AGHT+IEHwTsBFDKsfSwd5bxbAEf6Qjsha/dQgED+Y4q/n+uoHlXFnxYg2+rrsEN0OO/cJF0KxZmZoQ==
X-Received: by 2002:a05:6512:4002:b0:553:2bf7:77be with SMTP id 2adb3069b0e04-55366be2d0fmr3429290e87.22.1749515811540;
        Mon, 09 Jun 2025 17:36:51 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1cab60bsm12805181fa.71.2025.06.09.17.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:36:51 -0700 (PDT)
Date: Tue, 10 Jun 2025 03:36:49 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Cc: "J . Bruce Fields" <bfields@fieldses.org>, 
	Konstantin Evtushenko <koevtushenko@yandex.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <aEBeJ2FoSmLvZlSc@infradead.org>
User-Agent: NeoMutt/20231103

On Wed, Jun 04, 2025 at 10:10:15AM -0400, Chuck Lever wrote:
> Can you repost your patch with the current reviewers and maintainers
> copied as appropriate?

Sorry for the newbie mistake, this is the first patch I'm sending
upstream. Yes, I will send patch v2 with the right reviewers and
maintainers.

On Wed, Jun 04, 2025 at 07:54:31AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 04, 2025 at 04:07:08PM +0300, Sergey Bashirov wrote:
> > When pNFS client in block layout mode sends layoutcommit RPC to MDS,
> > a variable length array of modified extents is supplied within request.
> > This patch allows NFS server to accept such extent arrays if they do not
> > fit within single memory page.
>
> How did you manage to trigger such a workload?

Together with Konstantin we spent a lot of time enabling the pNFS block
volume setup. We have SDS that can attach virtual block devices via
vhost-user-blk to virtual machines. And we researched the way to create
parallel or distributed file system on top of this SDS. From this point
of view, pNFS block volume layout architecture looks quite suitable. So,
we created several VMs, configured pNFS and started testing. In fact,
during our extensive testing, we encountered a variety of issues including
deadlocks, livelocks, and corrupted files, which we eventually fixed.
Now we have a working setup and we would like to clean up the code and
contribute it.

> Also you patch doesn't apply to current mainline.

We will use the git repository link for NFSD from the MAINTAINERS file and
"nfsd-next" branch to work on top of it. Please let me know if this is the
wrong repository or branch in our case.

> > +++ b/fs/nfsd/blocklayoutxdr.c
> > @@ -103,11 +103,13 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
> >  }
> >
> >  int
> > -nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> > -		u32 block_size)
> > +nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, u32 len,
> > +				struct iomap **iomapp, u32 block_size)
> >  {
>
> So if you pass the xdr_buf that already has the length, can't we drop
> the len argument?

Thanks for the suggestions! I will rework it in patch v2 to get rid of
the len argument and the lc_up_len field.

> > +	struct xdr_stream xdr;
>
> Also I'm not the expert on the xdr_stream API, but instead of setting
> up a sub-buffer here shouldn't we reuse that from the actual XDR
> decoding stage, and if that can't work (Chuck is probably a better
> source for know how on that then me), at least initialize it in the
> main nfsd layoutcommit handler rather than in the layout drivers.
> me we'd probably want that initialized in the core nfsd code and not
> the layout driver.

As for the sub-buffer, the xdr_buf structure is initialized in the core
nfsd code to point only to the "opaque" field of the "layoutupdate4"
structure. Since this field is specific to each layout driver, its
xdr_stream is created on demand inside the field handler. For example,
the "opaque" field is not used in the file layouts. Do we really need to
expose the xdr_stream outside the field handler? Probably not. I also
checked how this is implemented in the nfs client code and found that
xdr_stream is created in a similar way inside the layout driver. Below
I have outlined some thoughts on why implemented it this way. Please
correct me if I missed anything.

Let's say we have a layout commit with 1000 extents (in practice we
observed much more). The size of each block extent structure is 44 bytes,
and we have another 4 bytes for the total number of extents. So, the
"opaque" field of the "layoutupdate4" structure has a size of 44004 bytes.
In this case, we cannot simply borrow a pointer to the xdr internal page
or the scratch buffer using xdr_inline_decode(). What options do we have?

1. Allocate a large enough memory buffer and copy the "opaque" field into
    it. But I think an extra copy of a large field is not what we prefer.

2. When RPC is received, nfsd_dispatch() first decodes the entire compound
    request and only then processes each operation. Yes, we can create a new
    callback in the layout driver interface to decode the "opaque" field
    during the decoding phase and use the actual xdr stream of the request.
    What I don't like here is that the layout driver is forced to parse a
    large data buffer before general checks are done (sequence ID, file
    handler, state ID, range, grace period, etc.). This opens up
    opportunities to abuse the server by sending invalid layout commits with
    the maximum possible number of extents (RPC can be up to 1MB).

3. It is also possible to store only the position of the "opaque" field in
    the actual xdr stream of the request during the decoding phase and defer
    large data buffer parsing until the processing phase. This is what the
    original code does, and this patch takes it in the same direction.

--
Sergey Bashirov

