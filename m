Return-Path: <linux-nfs+bounces-8792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F6A9FCC62
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B029162EB8
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20C1304B0;
	Thu, 26 Dec 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiSghDGB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68686252
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735233494; cv=none; b=dr2px/XSepoHRnISxsNODJLNkyoDeT3yNR6Z53fluEfnURFr9uq0ZyLxgq7tT27L+hJ3Fp7IcrNztTObdSi5HM3/DxV4O6mGeFKaa65/+y/C1zXPNHTL8/JJi710+n0+sJuLhOML5CC9VwcC5sAueHJkK1pT7qlVP8qM3sLDCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735233494; c=relaxed/simple;
	bh=nkBHQexJNjkM/Qje3iYDht1KA3gefR7fNETu1qxzOZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZZryQkwfLmblAtkO8z1MHsmTbSSmxak6NDcP7NAlUnbGe6qAZL5oRyAsKKCC+rXCv+ao0sBrH7AtqRpC5QL7eJz3JKb72DBJZ9ie11n7fTr78BOAOgM9PmlNrxa+Yii3pNHwG2WDwp4KmDQ8jhh6opXfSvODuQaFhCRhDoBfCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiSghDGB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so11745552a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735233490; x=1735838290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKF/5EaM78o8E/bKQij3JrhM/RVAd9rL6YqZ3YjGemg=;
        b=WiSghDGBD7bqQFDzyWmeIfqv0Y2KlplAekpWyBN0uUsLQcCYWdg5+Iop7gQ3pcLdbn
         36Q+f2U/jjjcs326DJcbxgfOHUuom7mHDw5Z9NPJhsYPRuYRl8NNrqfR4u6WrW4cO7/F
         K7Y/v5DYyLkxnNDryHkgHGVUzSv4RobuON0KynXMwxFwd2a+i5feIldLr5sKiNdiA0ca
         FO4xpg12ACwFO0gQ4PcZLE/c9lxCUI1igT2BdHjr52yO0FCj0TML8XntoBobHFHNEhdY
         oHjFH4wCujwwgGsa19VfdsrmvD5kutd3xShNVKCnrI15OVovjxaF9IzRVkLyBnYlkwvH
         S3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735233490; x=1735838290;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKF/5EaM78o8E/bKQij3JrhM/RVAd9rL6YqZ3YjGemg=;
        b=mto4NbysooyjRn4GF000VeIMLfHlpzELXJgr9nw2q1VUzFUseIRnjvAPOHXliSGgGn
         jYG89AgHPaQ13B6Grf3vyZwjwVAOdPN9+491xaEKUEIIOk4JuTg1IkIa91LEzWfplhsZ
         pDq61bACTyWx8bgSdqH2ksWumXQaU08ioGRTtIF8A+5omQ0EW9/lcnPfLodnur+kHxAZ
         blnong/ETTiXeZJ7X7FWrgBMVynoy0r5OD7CCjkMvhOMjtT23HaDkK6xpmGFFl6TN+df
         jlKuvBI6dHvKMl9a4WeBW2gRM8o2TGJO65ZuywEF/OuoWq06YyNAyPJ5CL8q3csNu47D
         9BcQ==
X-Gm-Message-State: AOJu0YxUQTLceD2mjcDobF5HtEx9Q4l8RDEiMhiD5EkD9gwAu5Va13EC
	8VDZo26Sg6GYsHWMt7rF/297JfMlJ7Olp7XGYXXYDHodMkbu0sNVTU8y57S0IyyBKAXJRCbtQGi
	nchojBImBhLct9u9LgT3jMBHMTvTEuQ==
X-Gm-Gg: ASbGncs4EZZMtRubXYju4d5HKFJH1thNXbNh6340ovWIG4r3lNNmh59285hph0411kv
	dBRfd2XEGpNVd6g4CRfefb0Tppy8+3HsuSrDBk7A=
X-Google-Smtp-Source: AGHT+IEorZuoWahiifGxVBht1uo8+L7qvVvV91uX8UEC14Qu8Unsn4FXe2b7E2WQZBEzfm4vbwkaYnMvmbaM/BBCG3Q=
X-Received: by 2002:a05:6402:2813:b0:5d3:d7ae:a893 with SMTP id
 4fb4d7f45d1cf-5d81de23133mr21231020a12.25.1735233490249; Thu, 26 Dec 2024
 09:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226162853.8940-1-cel@kernel.org> <20241226162853.8940-2-cel@kernel.org>
In-Reply-To: <20241226162853.8940-2-cel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 26 Dec 2024 18:17:34 +0100
Message-ID: <CALXu0Uek82Nx4Ps2v_BwF9XjiFU2QumKJu9CFoRKKaX9stducw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] NFSD: Encode COMPOUND operation status on page boundaries
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 17:29, <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> J. David reports an odd corruption of a READDIR reply sent to a
> FreeBSD client.
>
> xdr_reserve_space() has to do a special trick when the @nbytes value
> requests more space than there is in the current page of the XDR
> buffer.
>
> In that case, xdr_reserve_space() returns a pointer to the start of
> the next page, and then the next call to xdr_reserve_space() invokes
> __xdr_commit_encode() to copy enough of the data item back into the
> previous page to make that data item contiguous across the page
> boundary.
>
> But we need to be careful in the case where buffer space is reserved
> early for a data item whose value will be inserted into the buffer
> later.
>
> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
> encoding buffer for each COMPOUND operation. However, a READDIR
> result can sometimes encode file names so that there are only 4
> bytes left at the end of the current XDR buffer page (though plenty
> of pages are left to handle the remaining encoding tasks).
>
> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
> then nfsd4_encode_operation() will reserve 8 bytes for the op number
> (9) and the op status (usually NFS4_OK). In this weird case,
> xdr_reserve_space() returns a pointer to byte zero of the next buffer
> page, as it assumes the data item will be copied back into place (in
> the previous page) on the next call to xdr_reserve_space().
>
> nfsd4_encode_operation() writes the op num into the buffer, then
> saves the next 4-byte location for the op's status code. The next
> xdr_reserve_space() call is part of GETATTR encoding, so the op num
> gets copied back into the previous page, but the saved location for
> the op status continues to point to the wrong spot in the current
> XDR buffer page because __xdr_commit_encode() moved that data item.
>
> After GETATTR encoding is complete, nfsd4_encode_operation() writes
> the op status over the first XDR data item in the GETATTR result.
> The NFS4_OK status code (0) makes it look like there are zero items
> in the GETATTR's attribute bitmask.
>
> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
> across page boundaries") [2014] remarks that NFSD "can't handle a
> new operation starting close to the end of a page." This bug appears
> to be one reason for that remark.
>
> Reported-by: J David <j.david.lists@gmail.com>
> Closes: https://lore.kernel.org/linux-nfs/3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com/T/#t
> Tested-by: Rick Macklem <rmacklem@uoguelph.ca>
> Reviewed-by: NeilBrown <neilb@suse.de>
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

We would appreciate it if this patch series (esp the "insulate"
patches) could be backported to (at least) the 6.6 LTS branch, as this
kind of data corruption is haunting NFSv4.x clients since years#

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

