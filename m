Return-Path: <linux-nfs+bounces-3634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D829026CC
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8BE1F22A8C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B2143746;
	Mon, 10 Jun 2024 16:33:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F91422CF
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037203; cv=none; b=SY0VlOs18palRBJL/onUvEFh70/s/oQzo23wJZ14yLY/+PHJH+rhTf2jKF8jXRNHyi1z4Zzp3Wi1Xt0MNGN0fXWAydnk3awIeqXj7gEtSLbRiOjv69Y3voD8xy/poQbUwZuFXmPgm7gTc1DbbEFt8tGM+EtX3wKC7KBvsMs50KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037203; c=relaxed/simple;
	bh=MTBT7DbdhQwNdQiHH36nnznpEVlezW8v+HJvsKdHZNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxLWubZ083y3kpWxDogAD+LgPI9NXZDHklXc21UlrYjWVylcmk7pNcpcY4KBxIAzYRFfnxeJttN+iJVfkRPTOhFdIBw3ldGqNJLM6D1+lEtnTVfgaACBqfiNuQE5HXIxI2gjvHLSUg+CeimCyp8ptT+pRQTb473EM7eJ6Fkw12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7955841fddaso148416385a.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 09:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037201; x=1718642001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOAPuP3xz/q9AttXIWvL4NHOSSNTzfU3syIBPPxnFh8=;
        b=m/sOKRLTS2vtVFiG1h8jeBMacgalVE0RniyE56FnKLrijcqjsk3jFA6HlWavfg9ZnT
         UIhCaRBrH7mjhhSNxDzDEcOdp3X37yEFZtoVhCOAARhosxbLvyK1/YoOS14jg+gAMYFL
         tDg6hTHB/xNw7JAy4uxol/nhURo584IY1McmXkKm2AnkyrahRW0ruRZRUs18NNJKRvZE
         9w0EeVU5FllXx8GEoZ80pzVAao64iOXyekVlJ2lOxHf+vUeq0QfLygomma/DB0DHVQnu
         JOx2AznMPFHhFTI1Q4iAg3ugBG4ZSQ5S0V7Oe+TJ9v3+OCNBDrnHZVwSyWFUcS00WgOL
         cCRg==
X-Gm-Message-State: AOJu0YyD/w6RuqNiGUIK4GC4IHguepvt0rahmOB2UlDq6W8+xJnzdbv7
	f8JHHP5qale93VQwDa4IZmLw/FvDPWG27zVN4zib7LE2oLjrykSQpD/7NFtc5fQ=
X-Google-Smtp-Source: AGHT+IHSw9gfAyRFrozCJRO3eJn0bkEAnvS63Gl//SLXI2vTiBRwTFJlXPbp1P4hwHRR0jJpeG220A==
X-Received: by 2002:a05:620a:414a:b0:795:4d37:82a8 with SMTP id af79cd13be357-797c2d93fa1mr28707785a.22.1718037200535;
        Mon, 10 Jun 2024 09:33:20 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955d5b1277sm167230585a.58.2024.06.10.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:33:19 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:33:18 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 07/29] sunrpc: add and export
 rpc_ntop6_addr_noscopeid
Message-ID: <Zmcqzkzn_gzshrwy@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
 <20240607142646.20924-8-snitzer@kernel.org>
 <cde6e8571c835d571f2462d54dd00415c048c7d7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde6e8571c835d571f2462d54dd00415c048c7d7.camel@kernel.org>

On Sun, Jun 09, 2024 at 08:36:40AM -0400, Jeff Layton wrote:
> On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> > From: Peng Tao <tao.peng@primarydata.com>
> > 
> 
> Still looking over the set, but this could use some justification.

OK, note that it gets reverted by patch 20.  It was introduced for the
benefit of sockadd based matching of "local" network interfaces.

