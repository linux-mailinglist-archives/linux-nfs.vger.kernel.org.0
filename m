Return-Path: <linux-nfs+bounces-21977-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHoLH/69FWrYZgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21977-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:36:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3F65D8D91
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C24B3023BB2
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF334CFC5;
	Tue, 26 May 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qXBek+WP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06203451AB
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809161; cv=none; b=CCpYfrXJoyvp8X7KKM5tZgL000+xd3hj7xpcYIcDCKg0mpHpvZoxdVk/V9jhgYESsbH9GYOVJFRmvF+ZS/O3MWrv+jxLAcn3/BflobWBTYjaPSptugD0Dwmp4k30ZWmHtbSZtYNPq0CQmg81lI8SufSgqRwpeUSSum7zHV7X7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809161; c=relaxed/simple;
	bh=I0HaQDHIGp7peeqzmNtqtZVp+thYSCegR9dtL5eChOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3E7lVQS9rH9uQUFTpjRf51ZurF0hnWm+DfOhOHy3sdIm67mFQveojxl8otqJvrkHbAOwPhKkda1KT07Y9Z1mxuKbH2yY7tL+oJnaIghGYSiJCNL+GCNkXWyEzd6ZTPRTy7kw1hT4kt7YfOZ/tF5zUhPQWJ83qzXtnPm9K3mIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qXBek+WP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso165857356d6.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1779809159; x=1780413959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVjcG15pNpaOurZH1fYL0bMY7EmAo4rTVh29axQ41G8=;
        b=qXBek+WP0vdrOjvSWgirkal+Fqek8zE6nvPDGRAAFjEXPrqkW8C7dUrR2E3p1Fw9zK
         JUHRqRKdsf61jvWvyP28w1RMvAv2HXt+ZOazqvfTRdfUi0WSbpzUv+GzSYCAhWLu6Tlz
         IqNUjOzv69Tl+FbycrZzxCCJ3/5OSWz5DzjxiauYodOQCPGMcY86B+h21+2sDPDIsw6Z
         LqWE7RExnIa0lU15/Gw/NtXB8aqdPrS/OzErECJK7Vt+qqA5LheRu52ncRLp9ud6eAyT
         ybjxHPy4WUVJeeMWDaDf7n3foyIUyjSNw6F39fEtya+bX7iJ5NdszkciDPSBIz5WJsXo
         tyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809159; x=1780413959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVjcG15pNpaOurZH1fYL0bMY7EmAo4rTVh29axQ41G8=;
        b=K12nafF0HueccQLzNRW7vJGaKtAZgiWLzswvRE93foDac1ZdnKAK/d5Ls5Mmfx+GON
         8STvIOjdIRchZHWD9q/A4NApX127e5d98VXiGkIEJHE4XVQKyHZHxqR+mhPNtjNxMFHl
         J6AOTiAhYTdVV4jHOPLphxRpJaIxkz1eWmE0MDLIVTpOUA8fH03gemjkFVMNvgDUpdOc
         /+jIOEbm/tSZ+3AciYvvchtbHDLfKOjhlcNszZRozcCUEjY9WK7Wa1imo3evQ3gzsFbM
         TneZM7dNMfZdx/h3TdBwwJO4d+TH+4W/QPo0kZQF2vuRb9qsm8LLayQDMLaWEqd6zEKS
         APpA==
X-Forwarded-Encrypted: i=1; AFNElJ+N3mzfAPf9WAAb3jZBhzi2IispI5mXvDVeCfYU4djVtVlQQGUY1WEx9+8c+8BubOG3Wzfk2os9h9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJ2CTvX4DMRrGXP/gPkzQoCbXVTATZx5gbjQO+9VBlgc8YWVT
	ZuDNFJb1qlBXNNEHEyvOQFqk4vOBTEDKfLk6l+dMatm6uOPpvn5j4CydNMcg4q2LsGc=
X-Gm-Gg: Acq92OHDWpejUvrUdnnql8HK1X/fMBDjufabtMbNJFqzbMgkUU7nL1fq8srUSZukxPP
	9paeTETFWoNSpDdLqIs+GT7gnry1mqsO8bALWwePqdLpSIjqru+YuagLXLvo590157F38tpzhnX
	CMS4GmzbT6Ct/fwlIbR+2FTI8o5Gnow7fMD+aB4Ip3z8b+ADcAT3aGsMlXVinkPCf+qHUF0zqkF
	HNfNkVvlvtKaEpmrdJQqe/75fiWfhwra6XCc6wU8M2sPR4bQt7pKjQ9TiYDConn2ev2UtU74eCx
	pIjwmJKEc2txEhw0EZBn+k85xrC4LOWKXYG7nTfpRn8IMG9z4mZ0CtF44zpSR8ZSoK4UrKY7Nfg
	69giz0X3a070dZ+eq7uo+hWOx0OSo5Z5OlBqSWccMzMLF1H7MtY4oHcmeiD+laDow6UmFxPc4x1
	9KAiviLjxqDKAGD0HDyi7gC1UcEJAPVwprrnvD+7o0LalSQvD+qRf06E3wJAPPp5g8k06rtozVz
	ja+eUPw/oGm
X-Received: by 2002:ad4:5ba2:0:b0:8cc:3546:2625 with SMTP id 6a1803df08f44-8cc7be71b20mr263886306d6.9.1779809158646;
        Tue, 26 May 2026 08:25:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80decd31sm141907226d6.13.2026.05.26.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:25:57 -0700 (PDT)
Date: Tue, 26 May 2026 11:25:55 -0400
From: Gregory Price <gourry@gourry.net>
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Rientjes <rientjes@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>,
	Frank van der Linden <fvdl@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Raghavendra K T <rkodsara@amd.com>,
	"Rao, Bharata Bhasker" <bharata@amd.com>,
	SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>,
	Xuezheng Chu <xuezhengchu@huawei.com>,
	Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alirad Malek <alirad.malek@zptcorp.com>
Subject: Re: [PATCH RFC 3/3] mm: use non-temporal stores for demotion
Message-ID: <ahW7gwgaF0zIPTAz@gourry-fedora-PF4VCD3F>
References: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
 <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21977-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,linux-foundation.org,oracle.com,google.com,suse.com,nvidia.com,intel.com,gmail.com,sk.com,linux.alibaba.com,goodmis.org,efficios.com,cmpxchg.org,stgolabs.net,amd.com,huawei.com,zptcorp.com,palyvos.net,arm.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gourry.net:dkim,zptcorp.com:email]
X-Rspamd-Queue-Id: 1D3F65D8D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:37:04PM +0200, Yiannis Nikolakopoulos wrote:
> From: Alirad Malek <alirad.malek@zptcorp.com>
> 
> Memory demoted to a lower tier is assumed to be cold and most likely out of
> the CPU's last level cache. Additionally, in certain demotion targets (e.g.
> CXL devices with compressed memory) the bandwidth can be negatively
> impacted by the eviction patterns of the last level cache when standard
> memcpy is used. When the feature is enabled, use the
> MIGRATE_ASYNC_NON_TEMPORAL_STORES flag in demotions to trigger the folio
> copy path using non-temporal stores.
> 
> Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
> Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> ---
>  mm/Kconfig   | 8 ++++++++
>  mm/migrate.c | 9 ++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ebd8ea353687..4b7a75b57f6e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -645,6 +645,14 @@ config MIGRATION
>  	  pages as migration can relocate pages to satisfy a huge page
>  	  allocation instead of reclaiming.
>  
> +config DEMOTION_WITH_NON_TEMPORAL_STORES
> +	bool "Use non-temporal stores for demotion"
> +	default n
> +	depends on MIGRATION
> +	help
> +	  Enable non-temporal stores when migrating pages due to demotion.
> +	  If disabled, demotion uses regular migration copy paths.
> +

Do we actually need this config flag or should we just default to this
(if the arch supports NT stores)?

>  config DEVICE_MIGRATION
>  	def_bool MIGRATION && ZONE_DEVICE
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ff6cf50e7b0b..368d40dc8772 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -862,7 +862,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -	rc = folio_mc_copy(dst, src);
> +	if (mode == MIGRATE_ASYNC_NON_TEMPORAL_STORES)
> +		rc = folio_mc_copy_nt(dst, src);
> +	else
> +		rc = folio_mc_copy(dst, src);
>  	if (unlikely(rc))
>  		return rc;
>  
> @@ -2081,6 +2084,10 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
>  	LIST_HEAD(split_folios);
>  	struct migrate_pages_stats stats;
>  
> +	if (IS_ENABLED(CONFIG_DEMOTION_WITH_NON_TEMPORAL_STORES) &&
> +		reason == MR_DEMOTION && mode == MIGRATE_ASYNC)
> +		mode = MIGRATE_ASYNC_NON_TEMPORAL_STORES;
> +
>  	trace_mm_migrate_pages_start(mode, reason);
>  
>  	memset(&stats, 0, sizeof(stats));
> 
> -- 
> 2.43.0
> 

