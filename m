Return-Path: <linux-nfs+bounces-14643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06442B9A34D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8A71702EF
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C130304BCD;
	Wed, 24 Sep 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5ViSTdL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6D2D6619
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723684; cv=none; b=dPDeQh5tpthqf1u35CouJTNkVAK8Ut3SdOebOQzkXWfreI3ERtulHabzeO3K8Cqjum3tQwtUxNIirtqHQqE4VIwwglgmwTv5N2m4bEKCRCz/ou3KPXglMiNn1uKCXGDNKNKZVmvY277DX7ZUTjPHoutUy9Y2E9uovMDpHvA4RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723684; c=relaxed/simple;
	bh=UcEoZmBfIuZXcdWGHz3ppW4e8BnrvgzBW3TRiyNSUXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ8tvcIr2xyvlVOxbSITquht48VsDXBgbb5gbtFdlC8D7m97RCb81+gU+d1SVtlQknMhxEMoTA6Xs0VQNsf4qVvKCkB8BQHYSCXcLrGaj6/w3RrXRolER/QuCu2TCR4CwdEaW+wL7ZC0GHnNrclVyS4GT5w7pkZoDnrvQQn4SM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5ViSTdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB1EC4CEE7;
	Wed, 24 Sep 2025 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758723683;
	bh=UcEoZmBfIuZXcdWGHz3ppW4e8BnrvgzBW3TRiyNSUXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H5ViSTdLtUv9N12C5MXk5xevou+ikrmGM5YCW9c+SPcJuBxA2CfpQQr15/H97h3Cj
	 5LPh84wNI3t2nXdafc3WlFwRaOUhrxfqOFdPqwCL7wyR4jWOe7+hdTF3G7KAYwEA9S
	 44dYb6gdMjyczfqddrQH97YmV+ygdBg9ootuwWW80r9oUSesUvAij18VFA2MsYfHeZ
	 2R07VmZWKo/IjqhyY0sT5/34jwSr16MFC/9L4Nz1walFhlmN/G/VMD1ky7fmMXNG7L
	 Fgh8V96Af5UJO2xuhnB6bmT6FWLCabDtEU/MgHoc5C96N2yRKT1gs3BYmR/yXaIMZh
	 LSF5P+Ae+fiOg==
Message-ID: <f3f6a197-26ee-409a-b7ed-84d7daeb3bfb@kernel.org>
Date: Wed, 24 Sep 2025 10:21:21 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>
 <cde46e50575ba2e7578d3cb25d77bb7bb3405405.camel@kernel.org>
 <499430de-c15a-480c-a946-84cbf21d4682@kernel.org>
 <20250924004450.GK8117@frogsfrogsfrogs>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20250924004450.GK8117@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 5:44 PM, Darrick J. Wong wrote:
>> (And above, snipped out, the "Key Cycle Dates" section title comes
>> from Documentation/maintainer/maintainer-entry-profile.rst. I'll
>> think of a more accurate section title).

> <shrug> Or you could define some key cycle dates.  Do you want to
> require that new feature patchsets must be in the review pipeline before
> -rc2 so that you can put whatever passes review into for-next just after
> -rc4?  Or specify that bugfixes completing review after -rc6 will just
> get rolled into the next merge window?

Hi Darrick, thanks for the comments.

For the past couple of years I've tried nailing patch submission to
the -rc cadence, but I've found it confusing and full of exception
processing. So I'm trying this out now:

nfsd-testing is always open. Patches are applied when we get "enough"
reviews and discussion. ("Then a miracle occurs.") Patches are dropped
if we find breakage or other problems.

After a patch has soaked for some period (right now, 3-4 weeks) it is
moved to nfsd-next.

Whatever is in nfsd-next gets sent to Linus during a merge window.

When the merge window closes, nfsd-next is renamed nfsd-fixes and a
new nfsd-next is created, based on -rc1. I think this is the only bit
that depends on a release candidate.

Any -rc fixes go through nfsd-testing, get applied to nfsd-fixes, and
then go to Linus. But I limit those, typically, to dire situations
and fixes for stuff that broke during the most recent upstream merge.

(Looks like I forgot to add the nfsd-fixes part to the document).


-- 
Chuck Lever

