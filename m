Return-Path: <linux-nfs+bounces-8953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F80A04AB5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8079188670C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F81F7084;
	Tue,  7 Jan 2025 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="no0dRafZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251E1F4735
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280521; cv=none; b=H1bdPAx+6RWdpsVO/o4Iyq+DymhFi9c7zjNg2TrfZ+bcF7O98FeV1k7Tv/+8tOus78QAXuyV21Kn/uXbcyDVOpaXpgvI1ATKreu6sTps7iE4orYZqS8811crMIsi63I6nmRrP+F7XdqDp1csOZJemXX2P8PWGmjvNz5uOr3m3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280521; c=relaxed/simple;
	bh=O+C7KPStLgZcUUojB1v7gXrvCHQNSfkLGYlrpyhXs3o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=cceqsdEC5eSETsJE+3GG1+JySvd6yNKf9FUbcpTBx48uEtriBEcClaWHtrUPIU4S/2HbagdJMG6Si/j5jteJGdpEUgyYbVV0RaGFlz7setmXpQYFYKBwJkGbiG3zuPYXFAVgkqoWf2oNQzcKHxe3OZ+rgig1dh6ZzsLPcG7SSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=no0dRafZ; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736275675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oETzHeaUHtPD+L5fMyxTQpEqy9s924+smUnAo2/Ac6g=;
	b=no0dRafZCVGI1AT2r4IZqTipT9njQy65LBYeTv0g9xbbjpevwKsibyPsm5XONXUGtfqcdu
	55SPPzEpmUIBJckEb5/4wzNQMQxIjj1nmtU21huXafrZDJ/KZyMFv8tJROdrX+IWHkE8Vh
	EVa5Y2eQ31oK62Vp3PakJDgyT4ezTRCzqym2YqH6V8J7bqOQFUWY48y5Y5/vbd6DjLbldm
	PRGj59vaXgIFE35uK+RJD7JxDRzUoaksX+rmkWPDV2KzaXXqKtQN0t1CV+wJRd1oBrSppn
	Rf98YAuWQAvcL8cbtVT+wSNolgP35dKHAJiMnv6j4vU0Cc60NQuCTNdk2Pa6IA==
Message-ID: <3e4f1b57-6d68-4209-9c00-d37bb81b5bc1@hyub.org>
Date: Tue, 7 Jan 2025 20:08:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christopher Bii <christopherbii@hyub.org>
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Steve Dickson <steved@redhat.com>
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
Cc: linux-nfs@vger.kernel.org, neilb@suse.de
In-Reply-To: <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steve,

Thank you for the reply. I made sure to separate the patch on this 
version of my submission. Patch 4/5 changes no logic, it is only patch 
5/5 that changes the failure handling. If you guys would like to test 
that patch independently, I believe it will do the trick.

Thanks,
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


