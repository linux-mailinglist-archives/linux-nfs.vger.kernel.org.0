Return-Path: <linux-nfs+bounces-16768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F826C8FDAD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 19:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA94E324A
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD352F659F;
	Thu, 27 Nov 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muuaQkT+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5C2F7446;
	Thu, 27 Nov 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266591; cv=none; b=F7tu3kLt/Ug0Lz+MQqxDaJpdy2fs6aVMOouTrUo2/U916RC2BfMfG64HK+zXJtP39ecsYAk6VDBxnVDrr/QbBiyjB55sAU5LeKiVCGOpk7Ddy6k6CkeqG0YCbDqA/coByKyhqYrwHE37rEdLOinpdR8oWaalMmteoJhdW7Rwkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266591; c=relaxed/simple;
	bh=jr+sar5T/+6hulJrsWce23uDbzalLgb+DGFiRtA+CIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6iNXiXHitzyg1reyMbZj0C8WKtnZhfIqtHw32DdjVGLqB7/sdy50RuFHONdwqsCIRmSOM8CsJ7DeTJBmoXzgaDoXumAot0aAiERj4jF2ioRsntrC3Hfi6k/NeSftHWTpboMP9lmQxTBj9Cuthw132utIrApeLP0i0emdW+Jthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muuaQkT+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764266590; x=1795802590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jr+sar5T/+6hulJrsWce23uDbzalLgb+DGFiRtA+CIk=;
  b=muuaQkT+6fPz55yZEpq5HMP6HibKsfg3v0FwrIundOBvm0dO4mkRW+UQ
   tor11i22SrfeFFEvE4FdEPoX/DTt5G9bpVnsmWifqTzt9CQR1khyAlMeC
   o4TmgcEK9x+cd4wZ/4RyTSEIAmcwFI8EG2trhLnISi/7P47OwVaM/Zfbz
   Qjz7b++Q66tl+s1QQsA1Feb6SAt5fVqWLxxU++vKISbMQf0nTdJKrJDS3
   E54zk/1QQrPXpNQnoxwTt4TUT1jFO/SqDQs7kgISYRjW4PjvuoLco5JLy
   cZxPFonrt92UzlmBa6iTsgy70GHHridssPUVPxDwLJrxFjqES6qt4zVSi
   Q==;
X-CSE-ConnectionGUID: iX+uXLcdS6eEU57gB0XaTw==
X-CSE-MsgGUID: uvffyBZASnSgKptXAGd/0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="53883642"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="53883642"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:03:08 -0800
X-CSE-ConnectionGUID: zpGF1I0AQLON/Z81+MDeiQ==
X-CSE-MsgGUID: FKQWafcdRV6ii16yoaZUvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193179100"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:03:05 -0800
Date: Thu, 27 Nov 2025 20:03:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] nfsd: Mark variable __maybe_unused to avoid W=1
 build break
Message-ID: <aSiSV9SKClTZAVjy@smile.fi.intel.com>
References: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
 <176338731878.4204.10224670039692915729.b4-ty@oracle.com>
 <aSgCyqR72Zu6TSSI@black.igk.intel.com>
 <087f6258-a605-4e8c-9fa7-420ec12bef6f@kernel.org>
 <aSiCg0i4wMXk6QxV@smile.fi.intel.com>
 <52260b53-9ed8-400a-aaed-b1dc9e7910e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52260b53-9ed8-400a-aaed-b1dc9e7910e9@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 12:08:09PM -0500, Chuck Lever wrote:
> On 11/27/25 11:55 AM, Andy Shevchenko wrote:
> > On Thu, Nov 27, 2025 at 11:20:16AM -0500, Chuck Lever wrote:
> >> On 11/27/25 2:50 AM, Andy Shevchenko wrote:
> >>> On Mon, Nov 17, 2025 at 08:49:29AM -0500, Chuck Lever wrote:
> >>>> On Thu, 13 Nov 2025 09:31:31 +0100, Andy Shevchenko wrote:
> >>>>> Clang is not happy about set but (in some cases) unused variable:
> >>>>>
> >>>>> fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
> >>>>>
> >>>>> since it's used as a parameter to dprintk() which might be configured
> >>>>> a no-op. To avoid uglifying code with the specific ifdeffery just mark
> >>>>> the variable __maybe_unused.

[...]

> >>>> Applied to nfsd-testing, thanks!
> >>>>
> >>>> [1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
> >>>>       commit: 56e9f88b25abf08de6f2b1bfbbb2ddc4e6622d1e
> >>>
> >>> Thanks, but still no appearance in Linux Next and problem seems to be present.
> >>>
> >>
> >> The usual practice is to keep patches in nfsd-testing for four
> >> weeks to allow NFSD and community CI processes to work, and to
> >> enable extended review before it is merged. Both the community
> >> CI processes (eg, zero-day bots) and the availability of
> >> reviewers are not something I have control over.
> >>
> >> It will be available for upstream merge after December 11. You
> >> seem to be suggesting there is a sense of urgency so I will
> >> direct it towards v6.20-rc as soon as it is merge-ready.
> 
> Oops:
> 
> s/v6.20-rc/v6.19-rc/
> 
> 
> > Since it's (not so critical TBH, but still) a build breakage I supposed this to
> > go via the respective -fixes path.
> 
> Yes, what I meant above was I will submit it just after the
> v6.19 merge window closes in a few weeks.

Ah, that's wonderful, thanks!

> > But okay, your call.
> 
> It's just a build warning, but I know such issues affect the
> Fedora and Red Hat kernel build pipelines, as they enable the
> "warning => error" compile option.
> 
> However, those distributions enable SunRPC debugging, which
> means they won't see it. So I think this problem is not likely
> to be pervasive.

-- 
With Best Regards,
Andy Shevchenko



