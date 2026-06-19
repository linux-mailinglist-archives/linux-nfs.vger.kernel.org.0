Return-Path: <linux-nfs+bounces-22686-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id odo9EQQtNWrDnwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22686-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 13:50:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5706A580C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 13:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZoRiHdPN;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22686-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22686-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 606443001075
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5A380FD7;
	Fri, 19 Jun 2026 11:50:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877593803D2
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 11:50:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869821; cv=none; b=EultXn+N+qFFds3n0zSGSpmRUb9VibA2B/mI8FPnijNIuSER4WuU/WvsIHvaRPCb3U0tenDgBCoRhAvBzkPQJrpd9lMlCV+K2k1qMlQJy24SgLOXtxSNwQn0Hnv+d7C1Ow/SZuMCUIiiI5MK1SMObvbYnC/l0A2hYulhVyWF5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869821; c=relaxed/simple;
	bh=CGgYKgZQvNQ+VGIt4WFVSP/rCPlZ/Tdt8Cwy+BWzBg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU5fUkBLb0SWnbiXAmX7dP6XFVQMffho5u8WFoKV135dG3/SL3STvvpTr2F4vafOm8mGFM3ZniLZ9UPIw7/1wgDpYbOpCQb87nj25Zs9AnSoxwdW8bQXa7mLppZhAbwETgNOTrdEgFD+0KOtCNIoZLuMnc4y0OqqzQGe4Fo2Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoRiHdPN; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso45175ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781869820; x=1782474620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wi5/IAnFRvmM2957wAfYHVgEEe7a4uv0m6a3wgn8qvM=;
        b=ZoRiHdPNY8JpUnuoeDAaujnqInk/fBPxRm1T0AcdZ/pbVWqjKdsX0KiUaZzklKmrKv
         REwkmguRLBKqBJPJD69QM7ib/pX55jVJPi9EIs6d7XbVS2O3wz8nybx4TGvqENn2wbMP
         sDtsZLF55iAb5HwxhzQsNOqlyacijEGrcYbp6lsLEXECUfDhysbWKPnBaIJQeCvV6ej4
         N883oeyJGAIGV3fdgDO4FdnnU9crgGYfmLQlm3RI9OywyMy0YakCylg3hFTgLybxDZKG
         OTZi/YgxE+YvcZUGQftGpT3ezSaTre6BABXy2117QaSUNbhDF2PJjedE+j20g4h/082e
         hvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781869820; x=1782474620;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wi5/IAnFRvmM2957wAfYHVgEEe7a4uv0m6a3wgn8qvM=;
        b=e1HDG8F/FrDh85EQEWqS0w7FiGRhCUgjMptL0O+xx/76dy5/F3jCibTHjClRybTYRA
         eb/BeEE/ECiIE77rtuAR7fZTCnZmCFMSAGjBVqHufXCJRLM3xHOhgS2yUboCaeBcup0Q
         WVE2CNejWR9vhknRYmShxfSFJpt9Go+eRm7K+9b1YSysocSIGtHVBemHag/ooov830EF
         j6dXRS9UM61VyKsWt/Kfc3i5JFWBFHADmEggHZV3ADirr9rgrvdaVWcPMiVeQ7yJrAhV
         nMUGHHgyKfJSmYyNmO0Aft9U8hSwQb0mPBN20nOEVMRuPMsobgX6HO8oVTtKV/YYMtaV
         NzdA==
X-Forwarded-Encrypted: i=1; AFNElJ+jND3LxWwNjFX9SMQfujlzvAoJzwUj1J26IaOZI/cxwRfd4XTDFLXlCfD3tAAtkSgNYuX7XnGzvYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZN9UWLoAJd8057nMegbfreUEtkArr41mZ4mkQCgAmzd8nKfb
	mIA1W8U13yqNL6JWq39l/KGA0RBl0+1Qnd1AqS9ySOSFUcPiWc+weVfTO1TJuPtj1A==
X-Gm-Gg: AfdE7cnID/YbxsHA/tL3pGRnJ2u17Lv7WlWvX3XM4obq+k5AnH6baZ45ATjiwZwOdBV
	m7UW8YTLzfgOcdLCXCSNWvDGKG7PbIPspyXjY8E/F8iWB4+V1I0h+I3FYBQ4zw3QQNvaVGfaHhC
	AjuU1ogh/AhWv/gMVCz4Zma2O6BAe6cr3bPWtOtbcHsMM49bgt5DzGNI1oyJktBhRrlCI14q1hi
	6DupSXfL4zkTB3xeFAlrMV2s0+MBrQa2vg2J8zaiGf3AECLPF6hGG2sxJZPm8eqlcC2J4sipVQJ
	DM3AarXhpN9Dw6bJxLEHnjQYXASwP3DExf3frw2wQV+XU8EMVx2g/f/3a2Ar+O3dNw5UyjPr/3E
	IiGC3QLCWaAUYy4nLv0N9009/7IEx71WRVYT/TfROFnW+ZvVbdtKi24c9DBEAOlrlpnx/AnJVKM
	g9OYQcGGBaoEqdNmHekigjTpihzEn3Bpl3vQJHCOzrU9Ls4IZ1Sg==
X-Received: by 2002:a17:903:2442:b0:2c0:defb:557e with SMTP id d9443c01a7336-2c71ecbfb3dmr1319455ad.1.1781869819247;
        Fri, 19 Jun 2026 04:50:19 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8a8544e2afsm2211920a12.12.2026.06.19.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:50:18 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:50:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Shivaji Kant <shivajikant@google.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] nfs: Modernize Direct I/O path
Message-ID: <ajUs9RVduacffGN4@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <e9000012-ac58-4520-826d-b5734439ab0e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9000012-ac58-4520-826d-b5734439ab0e@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-22686-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D5706A580C

On Thu, Jun 18, 2026 at 09:46:56AM -0400, Chuck Lever wrote:
> Hi Pranjal -
> 
> On Tue, Jun 16, 2026, at 9:39 AM, Pranjal Shrivastava wrote:
> > Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> > Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> > RFC [1], the modernization and architectural changes are split into
> > this standalone series.
> 
> Good idea! Following is a review process note:
> 
> Please add linux-rdma@vger.kernel.org and linux-pci@vger.kernel.org
> when reposting this series for review. The latter is suggested by
> the MAINTAINERS file; you might know of an even more relevant set of
> reviewers to include.
> 

Ack. Apologies for missing these out, I just ran get_maintainers on the
current (part 1) patches and CC'd. I'll include the lists and relevant
people in the next version.

> -- 
> Chuck Lever

Thanks,
Praan

