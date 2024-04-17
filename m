Return-Path: <linux-nfs+bounces-2889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CF8A8BAD
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 20:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B375B25B86
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D21DA53;
	Wed, 17 Apr 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRQbSr6M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587918026
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380099; cv=none; b=OpS5ZwGaWj1PxLG0Vzq+0GFoSH7i58iJMhXDIvI7FxDDoHDWCKAirHi2o0YzK5hw3WPkP+6nzWsTFg+UsDtl1RMfbhWVlfsTqiXSn9w9wQLdNhuA6UkXJ+DKBPPIp14UhkJIjt2qlezcoR5LaxBThdAodxwjEp6AMH4debMO3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380099; c=relaxed/simple;
	bh=hyVdB569zZ5OYDp4VWG/AGhtwgsvsLu3NLnqVVMZmhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpkXKdTEewgqpo8cdaX6tadHshvQYGpew2e6rgprgAj+3hexxDz7e6IvhCf8vMDBX06wwwj00a5fb6G6RJIZ403gJJDjEsaZ9jBy8CbTeC3LAbVPKmC+sQhsC2JPhybOv8nY5/y7kz+lUOlo1zZNZzfDAr7uww8u2GVAowRa/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FRQbSr6M; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a52223e004dso669796566b.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713380096; x=1713984896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNc2oXzhoKzgg9wbULO2OggSgmb8doMtE3Eh6tO8jTE=;
        b=FRQbSr6MzbIE+Xbn+v9FPxtSZjD8No+3dJU75FxTuE3s8lBcAFYQjrQ6UexNkEBIV9
         uU4f5szW4itwnDqzVY72kERbLFZRg2GbUyS/fF7iOKUQbu2guq8mP6QU5psyQfJDUsuY
         jZ5r4Bup3nf+Ua9G2Cc+ned0fp4ywbRJBFfUiY8UXfYjduFHvR+QnMzZJ2OFxDEd+4Dk
         p1zeH/MOR48Ai8JuKC+++R5MK8FqbhMbt6OfNpWX1LnbU9ke6ZNUWTf5sbaT/nPByGxc
         lNgF/i3Z8nStrY7Qw0KL1v0DB0a2tIyizGUKdOciaIRpVZe6U373rL7U6nnTRmkkhmLu
         RQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380096; x=1713984896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNc2oXzhoKzgg9wbULO2OggSgmb8doMtE3Eh6tO8jTE=;
        b=ANRdqx3c63nmzZ4p9kesZFloi7lUiNoXhsNwKx5GqOT9cVNp0pTKztakGS3VwtY45G
         m0IaLAF4GRdncX+krjXFLUIWxKV30vLbNEHQiwjfF8/iqjPIRfJfnqqzpWhLkGVgTsNs
         kjCWP/qH9O3aw0hFIl4RBPvVKnKqBRQ7okwrNmJKgecqMNAM1p7rc0uTwbxZgQtt7B1Y
         S5Z63XsYGEBXCKJih12/Vf50RLpMOnFBOw/cE+tRVyetVHbFa0vQgs1IY4nFYwHlBpCZ
         GOz/4i6m8nApS/7t4Tyu7Ld1ynA31HgbblsZQw7NWIoCvSoTuqEyQXGI/9KTKMDN8vLJ
         Tn5w==
X-Forwarded-Encrypted: i=1; AJvYcCVp2pip6ZIjjNl56ZdLEGII+8qMSOcQlnR4v9UtmcH8U7vM7tjirH+oI0YR5WIkdjppFAGw1bZKuNR2CRPOQ9I6bvPB4ZtlVk1a
X-Gm-Message-State: AOJu0YySSUazKqmvi0LnfyyNs7hryMem4IhF8VEKVgcxbjbx2yCxD5rF
	4l/IoP9LSW6iP6Gjzt1075R7azSU8MHQlzD03mxOQG/vK2IHPyga8p9W4wxrjgI=
X-Google-Smtp-Source: AGHT+IEeSpnE+3j1wpqABZqQVt2r9ctyKoCugplbzwnggClIqICw4Kl3mofosHkREP/AYGRYzb6KzQ==
X-Received: by 2002:a17:906:3913:b0:a52:53f3:af3c with SMTP id f19-20020a170906391300b00a5253f3af3cmr270752eje.10.1713380095940;
        Wed, 17 Apr 2024 11:54:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id la12-20020a170907780c00b00a5561456fa8sm745978ejc.21.2024.04.17.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:54:55 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:54:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@primarydata.com>,
	Anna Schumaker <anna.schumaker@netapp.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: Fixup smatch warning for ambiguous return
Message-ID: <f95044d8-ab87-4bfb-ab65-f900863b9b14@moroto.mountain>
References: <b1577a24c58a9b0605a4540c8be5c411a07cb04c.1713379239.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1577a24c58a9b0605a4540c8be5c411a07cb04c.1713379239.git.bcodding@redhat.com>

On Wed, Apr 17, 2024 at 02:49:29PM -0400, Benjamin Coddington wrote:
> Dan Carpenter reports smatch warning for nfs4_try_migration() when a memory
> allocation failure results in a zero return value.  In this case, a
> transient allocation failure error will likely be retried the next time the
> server responds with NFS4ERR_MOVED.
> 
> We can fixup the smatch warning with a small refactor: attempt all three
> allocations before testing and returning on a failure.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on referral lookup.")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---

This preserves the existing behavior and makes the code more readable.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


