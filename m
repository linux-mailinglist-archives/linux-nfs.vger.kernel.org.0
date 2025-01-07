Return-Path: <linux-nfs+bounces-8952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E5A04A98
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218B5166706
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 20:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530B1F63E0;
	Tue,  7 Jan 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="cbmOiw+H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A281E25EB
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279999; cv=none; b=fCXGA7LmqtAK0Up7c7/PgvWVPo1m3rrN4+BXpx7NMS/LlvBU/BPNHvFsFT0TFLG55TxzwWk10Uy01SGENSBkTYZpoVs0Kyqh1aGnFg76XKAjKg9wpncfmz4pj9JDegeFjERzcPCkBWlyP0aIlz3kiQFIXmWxhT0xNFnE9UEMhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279999; c=relaxed/simple;
	bh=n3wuWypK4pQJBrXJJuzZ5krhu0WePqTeGjCiv1KkcHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=DyPhtQ3NUStcCI80ob96SfTKoLS5urK4TqLuQJgahgIGwl3RRYT3Mcw5DDcbVNAtc5EML8xre/3n1FItk97lJJtaSsONnyTOEMJE36XOMlUqnHUSBerDOn+C9me5zY+mOHtMVOSNwarmEGGon1L3Xjmd0QvTTGHShwIgf4a0Reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=cbmOiw+H; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736274812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts7YeApAox58mZ/+dmSAUw1X+R9BDzKOCWbBQnl7LgI=;
	b=cbmOiw+HmXADWgOnNQO0RkqFUZJSKC7Yn9mHpeIHny+4u7zq1Oyw0hU3JgYfi+vWkrlwDZ
	uau5jdmRJEodNhg82tB/FjFlJyJIm+WROSL5QupV1ULiRRibw/cxVquDyUjmi+PbZ7X/7o
	7BG7UiHvePJolRSdb4eDq7xr66JtN0yoQwdMk3QZpQen6NPNFCqdMnyqPCKapjrIVA3xEo
	kOa3WbxCq5lodfm9KSkFJnbEmkTCETGOrqC3XET5hrUbmU8zEk7G9mlgVUyoDOEoUhOsgS
	2yBt1Q5vpGetHQHJ95AwFi3rV4sBk8S2VFKITjRIUCTOUkSENVL6xucf+oBkiA==
Message-ID: <1395c749-90a1-4491-8f7b-7460e896e3c5@hyub.org>
Date: Tue, 7 Jan 2025 19:54:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: NeilBrown <neilb@suse.de>
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <173611535570.22054.9859231141116397821@noble.neil.brown.name>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <173611535570.22054.9859231141116397821@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

You are correct, it would be a configuration error. But the issue is 
that when a rootdir is set, export entries are assumed to be relative to 
the rootdir path, but this isn't the case. So my rootdir can have a 
restrictive set of permissions, but the export entry path relative to 
the system* rootdir may have an entirely different set of permissions. 
Or even with restrictive permissions it could be accidentally or 
maliciously symlinked.

Christopher Bii

NeilBrown wrote:
> On Sat, 07 Dec 2024, Christopher Bii wrote:
>> Hello,
>>
>> It is hinted in the configuration files that an attacker could gain access
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
> 
> I'm still not convinced there is a vulnerability here, but I might have
> missed part of the conversation...
> 
> Could you please spell out in detail the threat scenario that we are
> trying to defend against?
> 
>  From my perspective: if you export a path that a non-privileged user can
> modify, then that is a configuration error.  We should not try to make
> it "safe".  We could possibly try to detect that situation and fail the
> export when it happens.
> 
> Why is that perspective not correct?  If this has already been
> discussed, please point me to the relevant email.
> 
> Thanks,
> NeilBrown


