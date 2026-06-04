Return-Path: <linux-nfs+bounces-22267-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IzvEEuMwIWqKAQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22267-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 10:01:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB563DD0A
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 10:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=T5v9Fe0z;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22267-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22267-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9370306DF9B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F993CF04F;
	Thu,  4 Jun 2026 07:59:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261E2E65D
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 07:59:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559963; cv=none; b=jyzFGuYH8QVHUPXaCzkUSmI200hMYRamSU1zDUW7y8s70Zr1vrywm1szgziRz+KA/tWVZucgNf0ymbvL20ShDitmWprI7i/tvMHdCtcS0vcyunEX9+jysRdkXc1IEGETJ00gcP9MWKQNj5dBPdK9JKyMligQxNq/Wt/pybykb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559963; c=relaxed/simple;
	bh=pzTHySCCH2WnvMEzZZ83Y/ll+yKbOg3+v0WOsr73xFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEpju7JtXA29hXDab755EUffBMZsfZat2gFK0Iak3mykdSLVPp2Q1Jm4MOZuWArEvNeES/mUwbSlHrWgZbaACdSLVS+GumLzFG37gN5Sst2UGTzVo9swpMAdStu1Ty3vplupvsn4UrwRtjngqQSySJeKqz30Uxe4a3lKC+FSG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5v9Fe0z; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2d865383so63485ad.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2026 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780559962; x=1781164762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eRaU12XYS/7sUx6CQxhbdLP2E0HdlnbJUQAPJM1JzQ=;
        b=T5v9Fe0zgjMJ//gQuvksrebhK4U2RRJN75GiI7q4ZwjIonSnbuglLwOrx/4gIbeOky
         uRWt93gh30ngq93XeXiROuR56CaJ93DQlmAb39iggqaXv/MFGE7/t28Sv67cRum2CVkJ
         sSyx9imnSlGuuliD6egfCfyrLVH7074VjwBtiFnC1bCvAqIkd9blsdgMbpMj8uwzVxoS
         +6eSEztO2IzRaGDstYc3O0qXAknnBKF78Y4L5U/S1JvwZUK6RcG950am30h+KutdXKS1
         /KB9EIBr1MFGPiUbmNqpwoFdBw4BSvWv1aLExAWMxZsiW9d2KRR4TqWZr7yB4mqo7JV4
         RXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559962; x=1781164762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eRaU12XYS/7sUx6CQxhbdLP2E0HdlnbJUQAPJM1JzQ=;
        b=SN5oSxWT/U1/i7Kqa5V7cAdHj+HHDkirSPO07nYcmxvFA1LTzZgZ5Yj5LPTEaNt/qo
         9Zb28Aal58nG/J1QRvxFEDtHXAwBOsMF4PhiDhh9HIznxZo3cU/8xISP1YcQDmk82IgI
         Bp2i4rX8NG6dcTsTAaXh8jGtA9kHfoklKhA8WHozIkCdjW7dN5w89g4IPBsvSzJgauas
         026fIZV3zeWTjUVbdy3fdmDad/9+e5oPE10IQeYv4fUMTNkBP4Po0SFdCAHqvd2a64eg
         Wk81xzPnYzlOHgR71d34Nsf35r1AL2vQanFv7WGJWib9ufpcmvRHef0k+TEwNytFf0qk
         eJHw==
X-Gm-Message-State: AOJu0YymK9/zLPh0zcbyTS9LwJdqw4ZuQUHAfVHU5AwX+GhMEPpuDEIE
	eDbryoxxfk1p6EjLkVoNxl25WmaMAfebzr7Dg1hUWkbL0evxychiAhXZMGQDDsPvCw==
X-Gm-Gg: Acq92OFuXV+fFusGIrLGUNk51m7RQzcUWDVgQcl1RxQD3KrQvmuRhTonARSzQNAroi0
	IJhuZF5EgrTw+O4mUuJXjaQ6NuV5A3ZCECjWu0kMw4Y7u+u059p05xHgnEElAMFhwm0CQFJipGv
	hLFby1c+j885jmKBWR9IZZtrKWC8Ch1F1Re/O+u5GxoNkyhDsFlM4aIXDPQeKYxyYfolh0ipC1y
	Az8EAK5Gt1+2mB1FYct0VJKwj8I5OLN8eQvbSj+ZbpcGQhcfsMX4F3G5/+IkQWVdXM9KSHHqjRs
	LaS64Iuof5VbzrnhVdn7W7z9pml6zKdLkFLaHzlZ7ZZ7YS/tPs+Bvi88L8rfQ3rD4+r4N8gWeK2
	foY5uIQJFN566wcobxvjKZeD+JTGVBi666LYUDx2Zdu28P5k3aAHlrjKKIQPyIaGwoxqD39rxbz
	hDdXa6QISd7wiBAWz5MbERpNLiup3fFTbf6FLVfCJ7CbqQ1rInuTrF6LRpJYOTyhHRSG27xpk=
X-Received: by 2002:a17:902:e5c3:b0:2bd:63cb:c5be with SMTP id d9443c01a7336-2c1a1709205mr1628775ad.5.1780559961216;
        Thu, 04 Jun 2026 00:59:21 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm5075307b3a.33.2026.06.04.00.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:59:20 -0700 (PDT)
Date: Thu, 4 Jun 2026 07:59:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v1 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <aiEwUnZFZwwDPaQK@google.com>
References: <20260603053033.3300318-1-praan@google.com>
 <20260603053033.3300318-7-praan@google.com>
 <29a0511d-5216-46f2-a7e4-9c04ae9b1890@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a0511d-5216-46f2-a7e4-9c04ae9b1890@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22267-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linux-nfs.org:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-nfs.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBEB563DD0A

On Wed, Jun 03, 2026 at 03:14:35PM -0400, Anna Schumaker wrote:
> Hi Pranjal,
> 
> On Wed, Jun 3, 2026, at 1:30 AM, Pranjal Shrivastava wrote:
> > Optimize nfs_direct_extract_pages() to group contiguous pages from the
> > same folio into single nfs_page structures. This effectively migrates
> > NFS Direct I/O from being page-based to being folio-based.
> >
> > Reduce the number of nfs_page allocations and subsequent iterations
> > by utilizing nfs_page_create_from_folio() to create aggregated
> > requests.
> 
> I am seeing a LOT of failing xfstests after applying this patch (testing
> against various NFS versions over TCP with AUTH_SYS):
> 
> +-------------+-----------+-------------+-------------+-------------+
> |    testcase | tcp-sys-3 | tcp-sys-4.0 | tcp-sys-4.1 | tcp-sys-4.2 |
> +-------------+-----------+-------------+-------------+-------------+
> | generic/091 | failure   | failure     | failure     | failure     |
> | generic/130 | failure   | failure     | failure     | failure     |
> | generic/139 | skipped   | skipped     | skipped     | failure     |
> | generic/143 | skipped   | skipped     | skipped     | failure     |
> | generic/154 | skipped   | skipped     | skipped     | failure     |
> | generic/155 | skipped   | skipped     | skipped     | failure     |
> | generic/183 | skipped   | skipped     | skipped     | failure     |
> | generic/188 | skipped   | skipped     | skipped     | failure     |
> | generic/190 | skipped   | skipped     | skipped     | failure     |
> | generic/196 | skipped   | skipped     | skipped     | failure     |
> | generic/198 | failure   | failure     | failure     | failure     |
> | generic/203 | skipped   | skipped     | skipped     | failure     |
> | generic/214 | skipped   | skipped     | skipped     | failure     |
> | generic/240 | failure   | failure     | failure     | failure     |
> | generic/263 | failure   | failure     | failure     | failure     |
> | generic/287 | skipped   | skipped     | skipped     | failure     |
> | generic/290 | skipped   | skipped     | skipped     | failure     |
> | generic/292 | skipped   | skipped     | skipped     | failure     |
> | generic/330 | skipped   | skipped     | skipped     | failure     |
> | generic/444 | failure   | skipped     | skipped     | skipped     |
> | generic/450 | failure   | failure     | failure     | failure     |
> | generic/451 | failure   | failure     | failure     | failure     |
> | generic/586 | skipped   | skipped     | skipped     | failure     |
> | generic/647 | failure   | failure     | failure     | failure     |
> | generic/708 | failure   | failure     | failure     | failure     |
> | generic/729 | failure   | failure     | failure     | failure     |
> | generic/760 | failure   | failure     | failure     | failure     |
> +-------------+-----------+-------------+-------------+-------------+
> 
> I'm curious if you've run xfstests against your changes, and if you
> see the same failures?
> 

Hi Anna,

I've just run fio and haven't run xfstests (sorry wasn't aware of them)
I suppose it's this one [1] ? I will set up the environment.

Given that generic/091 (fsx) is failing across the board, I suspect there
is an error in the contiguous grouping logic in Patch 6, likely the
offset calculation or handles partial page boundaries.

I'll run xfstest with this patch and confirm.

Would you suggest breaking out the move to folio in a separate series if
patches 1-5 work fine?

> Thanks,
> Anna
> 

[...]

Thanks,
Praan

[1] https://wiki.linux-nfs.org/wiki/index.php/Xfstests

