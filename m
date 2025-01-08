Return-Path: <linux-nfs+bounces-8975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F6A06452
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 19:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C91626B7
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60515853B;
	Wed,  8 Jan 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="ndOlKayl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F451FECBD
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360708; cv=none; b=jyCkU4nhNYQ+CqOGBX49fcwRqxzy+wfmZ6AP1ukhUA0nPJK2BdYCHpfU+daVChK/uRBOclNWk1o4dJYqimbnbUYKTSJ9CeHLPSoKRDBqm4AdYyWvby0o3IDBGsOybGOdBDY6MT77COIUWLLumAtNzHuN2Hpuf3YYya43q5YUTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360708; c=relaxed/simple;
	bh=9eEMBaMt8iQZc/KDc16Y7tUJiwNxTKW82Jd9+yq4JKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekWPfbe+9zTe+AIgb4cNszkdUb47VkQUC68qVrTs4wo/qgcPm5mb9A+44mUzGWb+YesaODLGusL7suM50j0oFZ0LEioDk+5ijiF97gQ+JfNNFFYWXCuJk1cTz6Wa+mQ/ty8jkw8765npOEGSVEEqRiFsrzh+X7DE2htA+wOhMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=ndOlKayl; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736355860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xTHuHCBQSghiPL5q1GVjuIv+xfZea3Giu/llucoiew=;
	b=ndOlKayl0Ny5emizSOXMSJ5BPCHWPS+a7fXHmkfScjWf99yP9BOY48+gQZpOqVf0tbESvo
	vaNQ7KAcJxk8bEyaH8SL7OH+dfgOsDMfddVQzwSbbw7mB1JJ0VCvmtwe4glgyjeE63bZB2
	4JEekAGDM2NjezltpwRxiUEEEGXVbBZCP/7JLJYWSJigxTxsZITXFIz82p/SPoCjApDp8k
	EQ2ibllFQjZfCgjWVe+P07NRcroxt7dAARSVpGeP/hXSii2FbWHET9D00zkh6U+gOatIbo
	xqA6jGgVi0RdrxcAWRPgzpBKZtTJDOwTeOjtnKFfb/SPMBwIVhkDtdVIZckfnw==
Message-ID: <2305be45-74e4-4a34-a8d3-1dc6b8cae103@hyub.org>
Date: Wed, 8 Jan 2025 18:25:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Yongcheng Yang <yongcheng.yang@gmail.com>,
 Neil Brown <neilb@suse.de>
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Steve,

I would like to bring into question the reason why the failure case is 
ignored in the current implementation. Whenever a rootdir is set,
realpath would previously fail if the path didn't exist. So ignoring it
indeed made sense, as a blanket solution.

But was pre-exporting really a feature? I find the risks to greatly
outweigh the benefits. Should a non-existant dir be pre-exported,
someone could, maliciously or accidentally, symlink to any arbitrary
directory on the fly without warning, possibly compromising the system.

I think this should be reconsidered as there is no longer functionality
requiring us to ignore the failure of export path resolution via
realpath.

Thank you,
Christopher Bii

Steve Dickson wrote:
> Hello,
> 
> On 12/6/24 5:11 PM, Christopher Bii wrote:
>> Hello,
>>
>> It is hinted in the configuration files that an attacker could gain 
>> access
>> to arbitrary folders by guessing symlink paths that match exported dirs,
>> but this is not the case. They can get access to the root export with
>> certainty by simply symlinking to "../../../../../../../", which will
>> always return "/".
>>
>> This is due to realpath() being called in the main thread which isn't
>> chrooted, concatenating the result with the export root to create the
>> export entry's final absolute path which the kernel then exports.
>>
>> PS: I already sent this patch to the mailing list about the same subject
>> but it was poorly formatted. Changes were merged into a single commit. I
>> have broken it up into smaller commits and made the patch into a single
>> thread. Pardon the mistake, first contribution.
> First of all thank you this contribution... but :-)
> the patch makes an assumption that is incorrect.
> An export directory has to exist when exported.
> 
> The point being... even though the export does not
> exist when exported... it can in the future due
> to mounting races. This is a change NeilBrown
> made a few years back...
> 
> Which means the following fails which does not
> with the original code
> 
> exportfs -ua
> exportfs -vi *:/not_exist
> exportfs: Failed to stat /not_exist: No such file or directory
> (which is a warning, not an error meaning /not_exist is still exported)
> 
> With these patches this valid export fails
> exportfs -vi *:/export_test fails with
> exportfs: nfsd_realpath(): unable to resolve path /not_exist
> 
> because /not_exist is exported (aka in /var/lib/nfs/etab)
> so the failure is not correct because /not_exist could
> exist in the future.
> 
> Thank you Yongcheng Yang for this test which points
> out the problem.
> 
> Here is part of the patch that needs work
> in getexportent:
> 
>       /* resolve symlinks */
> -    if (realpath(ee.e_path, rpath) != NULL) {
> -        rpath[sizeof (rpath) - 1] = '\0';
> -        strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
> -        ee.e_path[sizeof (ee.e_path) - 1] = '\0';
> -    }
> +    if (nfsd_realpath(ee.e_path, rpath) == NULL) {
> +                xlog(L_ERROR, "nfsd_realpath(): unable to resolve path 
> %s", ee.e_path);
> +                goto out;
> +        };
> 
> the current code ignores the realpath() failure... your patch does not.
> 
> 
> I would like to fix the symlink vulnerability you have pointed
> out... but stay with the assumptions of the original code.
> I'll be more than willing to work with you to make this happen!
> 
> steved.
>>
>> Thanks
>>
>> Christopher Bii (5):
>>    nfsd_path.h - nfsd_path.c: - Configured export rootdir must now be an
>>      absolute path - Rootdir is into a global variable what will also be
>>      used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
>>      simplified with nfsd_path_rootdir   which returns the global var
>>      rather than reprobing config for rootdir   entry
>>    nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
>>    nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, const
>>      char*) -> nfsd_path_prepend_root(const char*)
>>    NFS export symlink vulnerability fix - Replaced dangerous use of
>>      realpath within support/nfs/export.c with   nfsd_realpath variant
>>      that is executed within the chrooted thread   rather than main
>>      thread. - Implemented nfsd_path.h methods to work securely within
>>      chrooted thread   using nfsd_run_task() helper
>>    support/nfs/exports.c - Small changes
>>
>>   support/export/export.c     |  17 +-
>>   support/include/nfsd_path.h |   9 +-
>>   support/misc/nfsd_path.c    | 362 ++++++++++++------------------------
>>   support/nfs/exports.c       |  49 ++---
>>   4 files changed, 151 insertions(+), 286 deletions(-)
>>
> 


