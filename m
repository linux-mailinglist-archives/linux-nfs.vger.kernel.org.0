Return-Path: <linux-nfs+bounces-22640-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w4RTCVBeMWq0iAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22640-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 16:31:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001CC690842
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 16:31:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IiGr9kyl;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22640-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22640-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D543163C1D
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25EC37D107;
	Tue, 16 Jun 2026 14:15:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3E37BE8E
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 14:15:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619324; cv=none; b=tglKZhO4svjrXi5xDH7kMO81Wwe9NONiUcJ77yiaGImnOf8jjhQc5luX9PcxLCUjsG3AAxfkL6Q4j49yj7L+XyeDixeFcaIlRNNvWqv1LLBUOvR3y2XQW40MSGJOqFlpXWkbz/zXkH+qq3YVF3qHJJww139yUkEPhWSKYC6RJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619324; c=relaxed/simple;
	bh=/T9gA1Aoj0Pd3tgvpQywM6kVkfTC5cdV4TYQszPSXt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL1IjTt+k7UtkJisUihqvr7AOhm782roRp8QvxIpb97CMApeOIQHfPSK/1j2hTYc/ATZen/2maokRv9toXDzYasYiQSI7R3Z8QsxIv2D/4DR1OUahUiqk39wYvN0O4Lq3fUN500XxAbB8LSdS58SEDHe8g+zKx16J1YbvPEw398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiGr9kyl; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2d865383so48105ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781619323; x=1782224123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItMFRbLvWzjxJwcjRURBQD+YmZOSPkyn+ogydOCQLjM=;
        b=IiGr9kylUQ1DtYEEKQjYs/OyEasZkSHGlpa3g8CgPt6B+8F+wGEHM94sqYJAbrs+eq
         wsixQ6q3BsXszwrhubVcgVrJo7ulR5c0EXhNyqA15W+EhjT6w4ZAjnM875WYmFxSvFB/
         YmVBanKuMGMPvuMQwPAYvg2XmTm4TtGCaajNgEiKXkuIxg3i+CtoTGlg/nGU8wpNIMhe
         G+QFQFF2yK0+52LRZhEOrAO4YIAh7rg27BchFxXKuTn9GK5FKYiJIPpC/1o+ZvZd5pU7
         +KLOZkQ7NNShiVfLAGHmYkDiN1QMN5LCjSpdXdNrOzHjrdyMoTpGbPU07D+OH6TCDDbK
         tlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619323; x=1782224123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItMFRbLvWzjxJwcjRURBQD+YmZOSPkyn+ogydOCQLjM=;
        b=HFMSNVe58XkHn8id9TXdphwkSuFojFWsd727DttG69Q3Y/Kv06pYCaobM5GlQBIBe2
         tEF7bTyn7qDyCuTye5v2VNm8K+SJ68dlrtEaJMmhw19kBDR0tjBWOFOG02HqRLzVT6KX
         9NSmrWM+KiTe3E7RbgrptVopA/xCmnCqYBhaRAXk1BntUJLpmwPcQ8v6epqhhVG1YmCg
         CXtxTWYN9AXtn4MNBcKo79N/9/m42VGIluxZPOjV3+vj6a8at1pcgqdaD+mS8ZcnuOPS
         lNS6uy8tCYv1Wh0Q3UqYRG+o9WRbQhAUdmJO0e1VkUstAqTSeTfi9PwoRSIiC28aSqE7
         RYfA==
X-Gm-Message-State: AOJu0Yw4as5GrZTW4cRS88sxKLUCdd386bdBWmW6glmHGkrFCTRscLje
	GwqrcgqHdUpcsYltnP2sfymtx34zmHV8i/CeM4C2RsTxD0XNx4ry0AJ4ZyjgMq72J8iJQIivxM5
	ZapxIxQ==
X-Gm-Gg: Acq92OGXXTI5jtwzjhhRz/t25z7djCDdZgmt1QTUgEvMZaJZaKoGjhGfR1yXnOW5dzC
	5HbgUTFYlH9lY7A8wkhGrLd8nDDqHUJi94Uav1+Xrl2dzpBJC9fPHsK408kdYW2QGMNGySqZ50m
	XS2u/x+ndeuIzs02iqQK2+zTZ/n563y4nv8qpVOW/BLZFTLeVPzWf90NjaygcE2/1b6QNjqf7yv
	JV81WKYeflJdy1LWzH2nRqMKXZxnpZjPCmHIhvYBIq0e03Fea8ehLYDVnnIkkb0SWXwcjfUCgah
	k4mJxuMlrJ3iBo4KC+jcY3rOMVrlgmRW0J1xGTeHYUBYTSzFwHTOvOWdVfjlCTffEkIvMd0upIU
	YN+ioN5WvaX3UP+POxsxm9lg3mPRPSDldl5wljqFR3V7FsEN03QMLtzm6/8GTum02tX6J8ZxBRP
	UtOUBGT/rosaVwaXCkNQfoBCa+qVCGuNK7k3pjSxEu9f2Kq5volpYB8EIBEDt1
X-Received: by 2002:a17:903:fb0:b0:2c1:ee6e:be20 with SMTP id d9443c01a7336-2c69a357a81mr2535505ad.30.1781619321992;
        Tue, 16 Jun 2026 07:15:21 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379c3240b5esm8718527a91.0.2026.06.16.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:15:21 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:15:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v2 0/7] nfs: Modernize Direct I/O path
Message-ID: <ajFac-4ZYDabeTYY@google.com>
References: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-22640-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 001CC690842

On Tue, Jun 16, 2026 at 01:39:53PM +0000, Pranjal Shrivastava wrote:
> Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> RFC [1], the modernization and architectural changes are split into
> this standalone series.
> 
> Currently, NFS O_DIRECT relies on the legacy iov_iter_get_pages_alloc2()
> API which does not support the pinning requirements for P2P memory.
> The implementation moves NFS to the modern iov_iter_extract_pages() API
> and migrates NFS direct I/O away from pages to use folios.
> 
> Design
> ======
> 
> 1. Pin-Awareness
> Standard NFS requests use get_page() and put_page() for memory
> management. However, memory extracted via iov_iter_extract_pages()
> requires explicit pinning.
> 
> Introduce a PG_PINNED flag and a wb_nr_pinned count to struct nfs_page.
> This allows the request lifecycle to track ownership of physical pins
> and ensure that unpinning is performed only when the I/O is complete.
> 
> 2. API Migration
> Migrate the Direct I/O path to the modern iov_iter_extract_pages()
> API. This aligns NFS with the modern extraction model and serves as
> the foundation for passing ITER_ALLOW_P2PDMA in a follow-up series.
> 
> 3. Extraction Helper and Folio Support
> Introduce a new extraction helper in direct.c to group contiguous
> pages from the same folio into a single struct nfs_page. This
> effectively migrates the Direct I/O path from being page-based to being
> folio-based.
> 
> Note: zone_device_pages_have_same_pgmap() checks are intentionally
> omitted in the extraction helper since P2PDMA enablement will be
> introduced in a follow-up series.
> 
> Bisectability
> =============
> The series attempts to remain bisectable. 
> 
> [Patches 1-2] Introduce pin-aware infrastructure and accounting.
> [Patch 3] Adds a centralized request release helper.
> [Patch 4] Migrates the Direct I/O path to iov_iter_extract_pages().
> [Patches 5-6] Implement the extraction helper and folio-based grouping.
> [Patch 7] Removes orphaned page-based helpers.
> 
> Testing
> =======
> This series has been tested with xfstests [2] on RDMA & TCP transports:
> 
>  ./check generic/091 generic/130 generic/139 generic/143 generic/154 \
>          generic/155 generic/183 generic/188 generic/190 generic/196 \
>          generic/198 generic/203 generic/214 generic/240 generic/263 \
>          generic/287 generic/290 generic/292 generic/330 generic/444 \
>          generic/450 generic/451 generic/586 generic/647 generic/708 \
>          generic/729 generic/760
> 
> The following summary was tabulated via a custom script [3] (on github).
> 

[...]

> 
> [1] https://lore.kernel.org/all/20260401194501.2269200-1-praan@google.com/
> [2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

Missed [3] https://github.com/pran005/tools/blob/main/display.py

> 
> 
> [v2] 
>  - Fix data corruption in nfs_direct_extract_pages() by correctly
>    calculating intra-page offsets using offset_in_page().
>  - Fix requested_bytes accounting in direct read/write paths to only
>    increment after successful RPC scheduling.
>  - Add missing kernel-doc descriptions for the @pinned parameter in
>    nfs_page_create_from_page() and nfs_page_create_from_folio().
>  - Rebase on fs-next/

Thanks,
Praan

