Return-Path: <linux-nfs+bounces-15441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EEBF50AD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8145C4FABF0
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CCF284896;
	Tue, 21 Oct 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SbYLDsBC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB85284672;
	Tue, 21 Oct 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032646; cv=none; b=GwnlEzUtTGNBxoNRbaO+Z43h5detWszpqwzJCwpDfSzhvNh6chCD4urbhNwm8yM52ZioCIj1f7ekwmtSIZKxl9kpV9cCf0gFhgwZjkpGb9tTpCVM80+jTLrM5gUd0j0wZywv+84BM68cK8F4DJ/eqdszROcHkMwvM6q5M45wWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032646; c=relaxed/simple;
	bh=VMczXjHiMMFNXVkIShw8MPqNOsA6McDHZHBD6eVjJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSwWjuusj+c7T5o5EI2Lojf4eZiHK8s2ABBz+NH5UBj6kh9YaZmeQmrMf2068Gqh2DADSVMMEcRGYbdkshlgEg4Ion/Fe6kAMx6OwWh6KJGkKnBHjQeTsjZg1apoCy9n0CFKrJMnWI+HhxgSvqg+lpPiM40WHh0I1CEwOBGy3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SbYLDsBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0AFC4CEF1;
	Tue, 21 Oct 2025 07:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761032645;
	bh=VMczXjHiMMFNXVkIShw8MPqNOsA6McDHZHBD6eVjJ38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbYLDsBCBxsgUOUSyOPz/19YEgyKAEWJEhKLS8zz7V8RujDKoQ1fbU/eYkXT2qoKd
	 snPOb3GiGXtM3//fVhez2HesiI7yRXP+/zPpdvKhwVZKpTOQIBblWnE5lcTMQvcSIv
	 sKm81tO8YLRs+1kjZ7J+IWfPX+KquM808y2vyexE=
Date: Tue, 21 Oct 2025 09:43:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Nagy Adam <mngyadam@amazon.de>
Cc: stable@vger.kernel.org, nagy@khwaternagy.com,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.1 0/8] Backporting CVE-2025-38073 fix patch
Message-ID: <2025102111-stoppage-clergyman-f425@gregkh>
References: <20251021070353.96705-2-mngyadam@amazon.de>
 <2025102128-agent-handheld-30a6@gregkh>
 <lrkyqms5klnri.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqms5klnri.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>

On Tue, Oct 21, 2025 at 09:25:37AM +0200, Mahmoud Nagy Adam wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> >
> >
> > On Tue, Oct 21, 2025 at 09:03:35AM +0200, Mahmoud Adam wrote:
> >> This series aims to fix the CVE-2025-38073 for 6.1 LTS.
> >
> > That's not going to work until there is a fix in the 6.6.y tree first.
> > You all know this quite well :(
> >
> > Please work on that tree first, and then move to older ones.
> >
> 
> Yup, I've already sent a series for 6.6 yesterday:
> https://lore.kernel.org/stable/20251020122541.7227-1-mngyadam@amazon.de/

Ah, totally missed that as it was "just" a single backport, my fault.

Thanks for this, I'll review this when I get a chance.  How was this
tested?

greg k-h

