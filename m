Return-Path: <linux-nfs+bounces-14509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70684B7FF78
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BD7722AE1
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F542D77EA;
	Wed, 17 Sep 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qx3lqok8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5212D7D2A
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118738; cv=none; b=PUeSQD5wj3ccauonjpxHr1OOQGCdfxQ467yxR35gYVTxowQ+NOIK1+gjIPZyrI60S632uQWVBH54al+re/lCgEYNHoVgttUzSn+TgV6BCycYsSZ+wq+dm4T08qM8vzO9VOtkYJPlCIkS6vJpqC37VRRcCl7KTyZlgkR9gNH6XhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118738; c=relaxed/simple;
	bh=qvPmqnT0GuwUtOmZwK9Z04OkVVWN3ZAbCb5Yyg9H46U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DuF8HOG/NRW62hkVHQM6Qo9G1+qKl6oETXtfTTNsxzNbLcizBRzp98IGJcyJxEzzXMOxBwbLEajQn+0VSi0FeQAu1kZ9SwylRyfRTMxvGn00iqW3spSfzffynKdpBHQaCKsgq6ASZDpKNUta5HIAdREpncsnPiAE7soZWLihr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qx3lqok8; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-889b60cc6feso504474439f.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118735; x=1758723535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DA3VMHiGzzibDL6pUIUYW3tloC3K1AfAFuDtTzpA7b0=;
        b=Qx3lqok8daad6D7UmMoXWjGnWkEJe+mZgMbbvxDGdJVHHzrv372rY58P5XP3mZrp6M
         mNT4ruARxZsCJdCSHvf/Pz0jaQVnHf44AAaCrIvv9R+dRBIgpzKGePvZT+Ya5UJBJKDZ
         oyrvd+Iyfee+XEuXETjiRULFNiZzLvVoXekpGke9jYqjmxOi4sh9M5lnCp6GllDPw7nZ
         2iq1jg9W3tUPYz1XhLGIh4UDfWA0ENbgkwQnmCzElkNw4CBDEu7nRYTWP/0hAszi91AI
         9KNqv1XXSxdo1axzyfOFGr+CuetDBgnoL39Vv9uhDrfWe05AePHG1ziqSr9OCw1X/ZGl
         TOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118735; x=1758723535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA3VMHiGzzibDL6pUIUYW3tloC3K1AfAFuDtTzpA7b0=;
        b=PsOkiYcbLfy1TLJ8ZXRJHzhh4yjr9wGVZVj5FoG867H8tKU6eXE4DorCIzS8A/Z16h
         HPs+ie7X82EFtoxs2n+JbboY/1c+iqIOlWaIDq5vTHL0uNQpB03A/WY2S67Jc2gwYbvK
         5t8r5lQSwTbpnSwVd4Up3IS7WRA+cVyrzHrhoNgG01MxZsPg95N9mB7gVjYrREpdcTyE
         d0W7CU+Uf/sycbf4LRmAuX+Vt2cny5nGY3r8F+aVUaDKMs5jX6hLDmv5q8drc3W2PEiu
         NWQtV1NeHfXRBrxpZUV+S8umNxYUZjcxb4N5TpyJVVYum0bNU9dXLLwiBmSYa9/m146Y
         WnUA==
X-Forwarded-Encrypted: i=1; AJvYcCXyU6XLHHc+6zz39HQpevmbclVI6CUWY9m0oZEPTQPe7e/HpNwE3x2elLZUqOJkLS5A8i/OGv73/J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0rgY42Qb4f4yakofMm3rzT6j8lLzmsTrC0xSaXxW7sW5NudM
	TxsW+Q7z9VafMAxcX9dzdTy+3/yyyLZUrOT4ye9DNphgyJVBpOIfqte2+rmqlgwA7h4=
X-Gm-Gg: ASbGncvxes9nBZFu4E1Wip96/kzckTZjZcphocZ3uInI9fZqwW38fHjYyZ91WLPUWIt
	prWzFuiKK1vQR4MsdDPVRr7FNcA9wWLv+0+NbzK4n/J8u9afDyanNtTrbzi77dykIPfxKSBCFLv
	tMe5kezO/w4XfVbdHVOgVXNQ7LvBx530UybyPckJNR1kV14KHGGaPfLYRDGG71LBg3F8+yKdgiY
	iOwUh/Aw00J2zrxXQ6Q9MignzS+4Olk7LfAK3XzaZtaIBy5OpOL02rUEFXmEZbmmp4doXLkPilf
	M5m4sMrlmopfwJvz3dkK0M7q6Sf/FAR6CqHdfZxatYAVfnBj4Mry9MkDOvqLtJgNKWzeJvDmV/2
	34C1z9Jj0njzanphosqQ=
X-Google-Smtp-Source: AGHT+IETaw7JxR4yD/B5BU++ndtz6o4tEdapBtyWCAqX6xlI0Emapaz/9BDEIacwy+P0KtLmhs7TOw==
X-Received: by 2002:a05:6602:2b14:b0:887:1b58:4e69 with SMTP id ca18e2360f4ac-89d1d4b1c12mr380124439f.8.1758118734932;
        Wed, 17 Sep 2025 07:18:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfed6sm657283239f.2.2025.09.17.07.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:18:54 -0700 (PDT)
Message-ID: <c69b070f-2177-4b8d-80d0-721221fe0c49@kernel.dk>
Date: Wed, 17 Sep 2025 08:18:53 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] io_uring: add __io_open_prep() helper
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, cem@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, amir73il@gmail.com
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
 <20250912152855.689917-9-tahbertschinger@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250912152855.689917-9-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 9:28 AM, Thomas Bertschinger wrote:
> This adds a helper, __io_open_prep(), which does the part of preparing
> for an open that is shared between openat*() and open_by_handle_at().
> 
> It excludes reading in the user path or file handle--this will be done
> by functions specific to the kind of open().

Looks fine to me.

-- 
Jens Axboe

