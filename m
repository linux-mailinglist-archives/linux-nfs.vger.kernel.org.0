Return-Path: <linux-nfs+bounces-21603-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPhMFpOSBGqrLgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21603-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 17:02:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E0E535A78
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4FE6301907C
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94D4657F8;
	Wed, 13 May 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIhYEKx5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA438655A;
	Wed, 13 May 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684361; cv=none; b=iTK1QhfmhcdYbhmyQoPdM4VrW7HzWoI3PtTB101iNjpQXqUEouYHpZk1olqfT4B6LFqCTRT5yRrHRnekBCrOC5b8ONsdLjVCul4tZP9p1DGGaA2oL6sHF3Tyd3Jo/xSZBrkajesE/xWKD5KrbKXeOJJj9bq5NgrI/WxMgGf0Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684361; c=relaxed/simple;
	bh=zbNHyyDRYAeGo6U86F5ea4LHa32zJh59lyteWOe4KGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhMrupf3fZ6ls6FVHJp880rovHBrIpAxXmr8lnULIEhJPSrZiYAzG1/w8BjXXkWF/YlY651QuhNX2j5B0SV0hm4xGTDZ21uo84LwcqRDo7Umyj2OVhM7le6YNRunOLF4FBm+8lkkdyqRsJLIWqZH3UgwwtbbnGAmzRD9RgyiUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIhYEKx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D47CC2BCB3;
	Wed, 13 May 2026 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684360;
	bh=zbNHyyDRYAeGo6U86F5ea4LHa32zJh59lyteWOe4KGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIhYEKx51XcVXCXizSytP4ZvhZtiBJmIPf+6O8Mktq3AJeEzUzkfq9zJFMxWWOQN/
	 aoWFZ5To1myUEqEdw7VallkySu/iGPAldgKZg0gl6xnLSnuloIhSu3lBTLqysfs1I0
	 Skg4f9BktAuE18yvvQRJ70VrpwY5SAV36hi26w0P9GMsQkbf7JD+SNU9HxSde3AnHu
	 bo3a4ZV9/09phwV+AioQvcuqmfuB2eTSN/4uxVBmpiaTeWdd95EFcAzHk3DTbz/8je
	 v+mVMmUJ6OM8tMNlaOTQXwFxTd7uJskcOql+wcSZWQ2REyC0QM0b5EqoBwpRfC7ETk
	 FtuJsAzYKU1jA==
Date: Wed, 13 May 2026 07:59:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 08/12] swap,iomap: simplify iomap_swapfile_iter
Message-ID: <20260513145919.GP9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-9-hch@lst.de>
 <20260512170204.GI9555@frogsfrogsfrogs>
 <20260513065608.GA2250@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513065608.GA2250@lst.de>
X-Rspamd-Queue-Id: 56E0E535A78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21603-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:56:08AM +0200, Christoph Hellwig wrote:
> On Tue, May 12, 2026 at 10:02:04AM -0700, Darrick J. Wong wrote:
> > OH.  Now I remember why -- it's to handle contiguous mixed mappings
> > better.
> > 
> > Let's say that you have a 1k fsblock filesystem and 4k base pages.  You
> > fallocate an 8G swap file and then mkswap it.  The first mapping is a 1k
> > written mapping at offset 0 for the swap header, followed by an 8388607k
> > unwritten mapping at offset 3k.
> > 
> > The PAGE_SIZE rounding code in iomap_swapfile_add_extent will round the
> > end of that first mapping down to zero and ignore it.  The second
> > mapping will be treated as if it were a 8388604k mapping starting at
> > offset 4096.  Now the page counts are wrong and the swapon fails.
> 
> Do we care about this use case?  I guess you did as you implemented
> his, but still?

We do, because mkswap -F uses fallocate nowadays:

$ mkswap -s 4194304 -F a
Setting up swapspace version 1, size = 4 MiB (4190208 bytes)
no label, UUID=bc9746bf-e200-4944-927c-80d83872f1cb
$ filefrag -v a
Filesystem type is: 58465342
File size of a is 4194304 (1024 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:  411383552.. 411383552:      1:            
   1:        1..    1023:  411383553.. 411384575:   1023:             last,unwritten,eof
a: 1 extent found

> > A more generic solution to this would be to change add_swap_extent to
> > take sector_t addr and length values and use them to construct a bitmap
> > representing contiguous physical space on the bdev, accounting of course
> > for PAGE_SIZE alignment.  Except for the swap header page, every other
> > contiguously set page-aligned region in the bitmap gets added to the
> > swap extent map.
> 
> You don't even need a bitmap, just do basically the same checks as
> the iomap code when moving to a new swap extent after moving to use
> the sector_t.  And it really should anyway, as the current abuse of
> sector_t to store a disk offset in PAGE_SIZE units is pretty gross.

Oh, I meant this to handle the particularly gross case where the fsblock
size is smaller than a base page, but there are a very large number of
file mappings that point to a physically contiguous extent but are not
in logical order:

{.offset=0, .length=1k, .addr=7},
{.offset=1, .length=1k, .addr=6},
{.offset=2, .length=1k, .addr=5},
{.offset=3, .length=1k, .addr=4},
{.offset=4, .length=1k, .addr=3},
{.offset=5, .length=1k, .addr=2},
{.offset=6, .length=1k, .addr=1},
{.offset=7, .length=1k, .addr=0},

That's two pages of swapfile, but with the current layout accumulation
code we "cannot" find either.

--D

