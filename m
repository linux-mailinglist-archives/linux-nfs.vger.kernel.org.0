Return-Path: <linux-nfs+bounces-19976-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ll4BSAssGlHgwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19976-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:35:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C720A2521A8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8219F31AA63E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449133B27DC;
	Tue, 10 Mar 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADQQpd+b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLhvlaPb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E643B0AD5
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148931; cv=none; b=dUGUjvIBS3ylCs3wACaTC/Lnf6RGNOUzmxpk29bN+Ox5QrUkpih5ut4QBnegX3rBX50oy6BBg6DuD7o/PgxRUNrdph5sVCe35ZQ9wBV0zP+ogzsUkj1oRjeZL63JsIGnrYcjxFOPdIji+X8/8Fm//NZ+Zxp9EaB/YCHqcgT7bMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148931; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYGeDBxiQMINTbp3VS/3n5Bd4x0IR+4khISO1vIOEw8y98wzPWBcIktk3iuzCASsswBMyzd5/NtfmuJinp4QkIRsZbAz/+A0X6wtR+DYc3j3e9Gg0YhY+WkPf73YL45p6aP97OrxC3f/H4WQIUuhxHv97ZA8oGptFoRkx9STDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADQQpd+b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLhvlaPb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=ADQQpd+bpcMvyiI6BuK6I/AtlFPVjRaT1jbvm8x0bcg2sn4Mv+l/q+wGsOaa7zGZavpvJL
	HOw6n0NTrJxN8BVrJlzy+3Oyq/AicE10gafpjzfnHFVMImjvlOy3qRSEO7jpexZVWETsUQ
	RoRPrXnJkd5ZbUZ0X+x9wM3CIJYSD9c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-wzwMnxGcP-K6_wXLQyjo_g-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: wzwMnxGcP-K6_wXLQyjo_g-1
X-Mimecast-MFC-AGG-ID: wzwMnxGcP-K6_wXLQyjo_g_1773148925
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7ea0bb20so1450837485a.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773148925; x=1773753725; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=DLhvlaPbwaSFQKg/FmxemLJJZifDd7cIIhpxvIrZaWROKjgqKnQK81zS2r/WSu9mvZ
         1x4TVLhhO06glvOYJXTBYTQHe1C/lCEECiyKmpprEGkSpnbhT/+Xy+wfN5x6paEUKxsd
         eleVUcWebznHZRscghpqRSurxi7A6fJyr8+SC/oFm4tth2mVEOc19JKZit9S00HY03E/
         XNzQnAGkguTRFL3rrkTJWt1Ev4Xq7DVoDTHr6r9kNjeVPxV8v11X5FGr4E58NddnvLYv
         QUA4HTbgZjVMx4thX/P6FGMyY+HUc/G2+EnczacjtLqtmfpojjqt59bZxWNPmXy2pn5x
         ulpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=ghjXDKOlMGhV+jAyMzbOFDToFIYsZ8xIq74HF3pzC7zF61PEu9cUs2CZLcLCxrjzJa
         anAcIjOsFrExz6rx/Lw9ouhIKZ0GeeunZ4BJkuePjdNArFrWDfeO4o4Yi/putg5A5JSr
         3tQOfPcQ3H51sl3zuXcgHRhgVixKUQTdpeDMKroGaFwf7SUme40DbknAyb15b5fNJpR7
         2URSMoVYbHZAyKEGVP4Odo2lNRYGCERTGSOAbL1XYk3GKGE3TgSIQTHBYDZ/MjG9P6SO
         ltio+XWvlExJHNCuGpNgVV+pQZ+V3mFz2xcvlxchsGYrc4k7rhHDzv7g5L2KzwNYRf3l
         PdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4BOmXFLyro3KsMdCqQ6hmKwwdzA/R0PRCwWhHFOGcbesRwy/fl4wcfhqBN07d7phyNZECgY6e8vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDGHNTboNiUshaJ8Jta7cxl/fvjRvulEiN88ldK/AncLPymH9
	EjQMGH5Mm+G18YGxiFGCfrJRm0Quvl4HHqgMmiOnvMkvWyLDWJajgu/n/AVQW8Nr5iK9v106202
	Fn9Up+mKzpGmkDQt5/mP83dCpfYJU+YX1OJbWsL53eFxY1gO3h2FZCb4fwLMDDQ==
X-Gm-Gg: ATEYQzxgsdbnexI82xZ/pJzpHRXGTQXK768RGhauUQjg5CIBAkkR3ZLyBbwXuYeyOf+
	l1rKVrcsu5LZ3I9Bti3xA8hdy7xVGDctV5BNXL3O/3c8LN9sd1pRJ3ti2N5XXLln9jW/i4osymO
	N+yqXesOYJAyNhJoOiY5wDlokOMynOtQ1EJB/NtGzosUuj+dAjWN8wq06d21df2UUv9nSOsWctl
	0G9B8VGSo3AwOWrAX4tBdXIBRPhwDbpJrMjpBtpr86BS6qEEa7J3gfdtZQnKqBizwyjoc9f+Bmd
	I+2hDmSqs50rp/x3MMKbCMVsx6xI0wi4YILhOpl4o5gbnIqlFDnEGS+ZQGKzWDy762fx1pnRnqf
	2rH+sHueE8hRUxDwcUlGolN08PH1/kSX9HUAHES2m2552CFaiYz1krksp
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830786785a.45.1773148924720;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Rspamd-Queue-Id: C720A2521A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19976-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:email,baylibre.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>


