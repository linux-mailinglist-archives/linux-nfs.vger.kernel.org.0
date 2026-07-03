Return-Path: <linux-nfs+bounces-22972-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Be2MHVWyR2q3dgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22972-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 15:00:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0616D7029DD
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 15:00:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=elmR7j02;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22972-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22972-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED43030E925F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65233C7DE1;
	Fri,  3 Jul 2026 12:47:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D822D1907
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 12:47:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082826; cv=none; b=AKCvLAjevW2f7hTXOcD5R5DzZDWr/t+ytzKqcwceNSu6vHQJE/4Zb0DbX1AaQSNU1SW9HQp1Y7OMea7QlhzDAsXQUigP4ZdNovLnTrgzo9lq2iCHUjyvs6x5H7uglThoRHHRZsYjHJXiBWJuy32hvD2CRyu6FpMBI6XsHltOf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082826; c=relaxed/simple;
	bh=2jYG6Xf32+cEtSY72Mc1PL+l5rCSf2q04Wdaw1jcsok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H57AcCu3+Lh2gduemsskEh08WgzfttTCvGOuaLTpX1SH+GNyIWIHkCT/E/GwmkYJJ1VMbQINqe94JNehJVHCccS+UXoweWwUHN/fXNfb/iAe717ytXRSpNzZOhWYdhr/BBHw6qYSMHQSCUAD9qEA+VHlbBggrksb5rV824BqZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elmR7j02; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso203855ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jul 2026 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783082825; x=1783687625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I4FlisNClq+WLU9VmGBotriJLcRO/uQKg32SCiTN5SY=;
        b=elmR7j02SHeKdKM4RJKl0H65g3WiBe5szm7u2Xt/xiAcpak9FLO2xBtK2qYaFOCsol
         AEGz+p4RkFNz6m72AejL9gfDf7C58KQqjnrMttURvVJyHyOT0oaw5FXJBQywzy0CldvV
         6C0vQ1CwyKBq1oMzuDIOPJGYEey2tiT73RgIQyetCw5XSICjaNX4raLUkWeqvsHLLcFI
         re2Okv6x6d0U5KLaqD+P5i9NwlxKsSq8IpY2eQ9goLmmXIbKF0fEvUiFZebM+el5EDmD
         Dy+UoZLOrN9udBGe2CVfRvOYwyPO6xQHtEfDp3SSIMaoxLFp9tHgtzo8ug4cYhegv+4r
         TRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082825; x=1783687625;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I4FlisNClq+WLU9VmGBotriJLcRO/uQKg32SCiTN5SY=;
        b=Cpc6pqKC91hFl61+gSU22hC7E6UDnI21dTW15+3yMJ6XeYlhWfJvoruTX2MFb9EN14
         v7OpGIQsHaVaMc3m4EODDr7/dlDa0khWS1logsioUBkYrhrrsZRBmUstBj70DHiKY3lr
         x+J6q81hK0UzP1XSIwITFx0BJ5yxJgeb4xS4bRZFx0X4H+uzywdDl6U1wSj2Q/SKtB9k
         UTVdyc3JL9yHXTiPfHadasbfBg95TLgnEan6vJQFtqT3Npqg7MrsWN4E9LIFMHDSfbIi
         H3WseBofgsHmxW2GoyoQ4uEswUmbs9+nsZoSvxPAJ/elBEaZF07RirQkrs1tc0Xhf7k7
         p20w==
X-Forwarded-Encrypted: i=1; AHgh+RoUyjhTy8qS3JU9XWjTmq7rB2xMmCUphYQK5g7hPQgk+1a55bpPWpu5ZB0vOLE3B5AbuDIK+LPXrfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zI9p435+mxI5WX5KfZ46iwReAg0pp9FWAhhyRYkTOAizpYQI
	+kOFsocffCb596Lg5yDGfmG+fPC1cW2+4DMZMXtWmJ4jLL3MljSjmP7d8I6sOaLeWA==
X-Gm-Gg: AfdE7clI6ZAMYWr/XOuTVf9HU9FZIzZe/Q7J7OsTjmYRYW5ECUkr4m6cylGUct/TOLS
	+firuiiuFMREVhV0Y7z+EKVZBgbknT7d7BPQvWhjaMwhhontHlSprNfcZYyxt482XWdsCR8jjH6
	yzhD42r+hNY7c4BgNjxLQlkqhSTw+udOoOj8gFFvoKViD/CbjKBRHDrxTxJAEwlzxN28udEugx7
	LU4E6pBa6Qzpw+V6kyLMV1vdMQT4LSul7GU91gjZQFfi0wc+sTQEyrH6DR0TdS1H5U6Q7tTGTmA
	s1A0IHzjTcwK3SRvN4EZ17YomnObdzYL03QP2gR5kcNQGIwNzwGKTvK2QnPCxmls7PWPQ5yGkCV
	9qVF+q+WgUcdYuKBo0vX24sagkEiUZkvgOkXw1uqKoIn7B8UIuC1rUonlWKUvFhLqceE4ZR7mcS
	5VYFVu/i+zrolLUk4zb2U4FLh+NelJBqKbgdBx8CfWEYuemIY=
X-Received: by 2002:a17:902:d581:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2caa3942d30mr5410005ad.14.1783082824027;
        Fri, 03 Jul 2026 05:47:04 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f3d74ccsm2728907a12.9.2026.07.03.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:47:03 -0700 (PDT)
Date: Fri, 3 Jul 2026 12:46:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <akevQfFVteCOD6LM@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj4iiD5C_yyLeb3U@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-22972-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:willy@infradead.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0616D7029DD

On Thu, Jun 25, 2026 at 11:56:08PM -0700, Christoph Hellwig wrote:
> [sorry, dropped the ball a bit on this due to overload]
> 
> On Thu, Jun 18, 2026 at 07:20:06PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 18, 2026 at 07:10:45AM -0700, Christoph Hellwig wrote:
> > > On Tue, Jun 16, 2026 at 05:23:48PM +0000, Pranjal Shrivastava wrote:
> > > > AFAIU, the MM subsystem explicitly ensures that every valid struct page
> > > > is part of a folio.
> > > 
> > > It is definitively not what the vision for the folio is, although if
> > > I'm not mistaken it actually is still true right now.
> > 
> > It's not true, eg, for slab.  While there's still a struct page there
> > for slab, there's no refcount and flags like PG_locked have different
> > meanings.  You'll get into a lot of trouble trying to treat slabs as
> > folios (and that will include assertions tripping).
> 
> True.  But also not relevant for direct I/O user pinning.  If we stopped
> having valid folios for anything mapped into userspace,
> iov_iter_extract_bvecs would run into problems, and we had the discussion
> before that at least right now it would be hard to fix.
> 

+1. I see that extract_bvecs also rely on user memory to have valid
folios even if we were to re-use parts of it (get_contig_folio_len) it
still relies on page_folio() as detailed in the other reply.

> Also if iov_iter_extract_bvecs was used on kvec or bvec iters we could
> run into the slab problem.  The block usage currently makes sure bvec
> iters are not handed to iov_iter_extract_bvecs, but there is no such
> thing for kvec vectors, although no one is using them for direct I/O
> right now.  Not that I'd want to rely on that in the long run.
> 

Do we have use-cases for a kernel user for direct I/O ? (Just curious to
know if there's something on the horizon).

Thanks,
Praan

