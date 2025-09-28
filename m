Return-Path: <linux-nfs+bounces-14753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74204BA76D6
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328CB7A7B78
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75C25B2E7;
	Sun, 28 Sep 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaouvISi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA225A659;
	Sun, 28 Sep 2025 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759087346; cv=none; b=p4VGY5DlL6g7TtSOeEcuJC/z3zlbQIrt2YErCndvlrzbyFKh1I1+jIYzhdd6gG0JkxGaPrT+MLVbJkxm5kbPX22o5za0Kg8EPD2RTmoyfucpqzQzWf21B5LdF8qiiXDuEZl4xoMHyEuXTNb7JE+4Os9YHXLpWp6e4OPINc2wauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759087346; c=relaxed/simple;
	bh=w4uDIN3OpWowRivVqJ+VVouVHwHl4QndnXeVVuGTcLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avzBt7EYHF4dsUhx5dczH0b+f0c4Y33JLwoigQBDv2JfecpFv+9e7E/RfTfr/ddrtzOw2xQiZx+lxYNCGYSurATVcN9F7AEnjacTQc5NCJTbCDOSj0c/SkrD5tatFY6ep7bZ/3eQcdEbDP7D1ZdxIYVDt8DbZRx0Eqf85pBUOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaouvISi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DF9C4CEF0;
	Sun, 28 Sep 2025 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759087345;
	bh=w4uDIN3OpWowRivVqJ+VVouVHwHl4QndnXeVVuGTcLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaouvISi7hEQTc+h3Ka05EXLY8ZXl1C1MmOotFc5W/6BMyZEclPIOrLSXnXdlHneN
	 EgQzkYrj5GLdXplOkr2MAWsGe0TzhWNxOkmQZYOJa22W6F5rWd4cIdmF7MIGmaYvOq
	 BCAohhGuBVAI9eieqjQPAPOYufkdrbxq5fQZUGXjB5N6dB2F2jPgPgZVgvcBcrVq27
	 GaAQ2dmLIu6zADhRRBDk0pawhWaUW6ThTEU58AxWfTtYIPe2ha30JkvVtfu06MCoyU
	 KtRjfydueANvleE74q500KaC+l+TbqaTkGD6ew7NG1FVHfqxnMUqpsHxmU3BbdudS7
	 5HgVM7pJkYBRg==
Date: Sun, 28 Sep 2025 15:22:20 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
	patches@lists.linux.dev, Anna Schumaker <anna.schumaker@oracle.com>
Subject: Re: [PATCH] nfsd: Move strlen declaration in
 nfsd4_encode_components_esc()
Message-ID: <20250928192220.GA808426@ax162>
References: <20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org>
 <6669bd1e-ba37-433a-8f8c-5cd9787b846f@oracle.com>
 <27d0b9176a444dcf87ecd40c17b6ed1865c1b789.camel@kernel.org>
 <20250925203233.GB491548@ax162>
 <327de9a1-175f-4a8c-a163-6ea53c64a602@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327de9a1-175f-4a8c-a163-6ea53c64a602@oracle.com>

On Fri, Sep 26, 2025 at 09:13:59AM -0400, Chuck Lever wrote:
> I was hoping that the modifications I requested would be
> straightforward enough that it would take you only a few minutes
> to resend. If it's going to be more difficult than that, I can take
> it from here.

Yeah, it was no problem at all, it was more about finding those few
minutes :) I have sent an updated patch that will hopefully be
acceptable:

  https://lore.kernel.org/20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org/

Cheers,
Nathan

