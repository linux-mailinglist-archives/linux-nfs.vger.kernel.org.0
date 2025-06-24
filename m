Return-Path: <linux-nfs+bounces-12726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC21AE69F7
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAB61C261D1
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549CA2D6630;
	Tue, 24 Jun 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ohfbkb+a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B42D8781
	for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776587; cv=none; b=PjKbMbswplgethDVwyRslkLZk87BLeK+l/OOzAEan4ww4yuMrKpxkyX61AMTIqOV2v+TUs8mvh1ME4irVNKoDorR1wMhpegFs39kSZTAZirp04EmzIH6MtUJcwQDAKyTDCKDb0MLUbjbikD5M2XhvMpyI4gjTs24gNsdOcj2LZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776587; c=relaxed/simple;
	bh=3PBHHUZgAT4HpCnmQF7y8YTzpCi6cJ8shRi+Dro0qp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sun72c7nA3rg1d9ze8tfa/eYLKaNKDO/LTxjLPI15+GmNrllOgXWfTCxfTaPDhO1h1lGzRiIQigxztkmOo05wJ/WxIT2BXjIs0ddL1GszL4D282JWFpiA8u1y3hwXgL6Z62tj1qEKhxaSke0Ia2kdh6prD9/+kzk7YojOanvHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ohfbkb+a; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2db9e29d3bcso181763fac.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750776584; x=1751381384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f17suXwGZaWKYHNj2hVCx02g00hUtF+cxL8n4hLFrwM=;
        b=Ohfbkb+aFhK5vUV0D/KEb93IXfquZAtN14F2Ud0xKskKLIGMTtPY9BAm1Wbhig2DlV
         g++f1kStrEZOH0mRu9RhczN62kxc6ARWZ3AuBn16KodYGRNTYlFozSu9Y0cTahhLBZwn
         KBsipaeRw5kcaYL9zpjunCYSsqV5rEduHAZy4VsSrt1nflaFjfx4PeaDjexjvdYslPTc
         xCAXeuwU6oPMoYmEKoCvS0Q5Rr2MsSx++H4IeWnq6xFW56mc8nPoUW1ekDWz9mxRtDxy
         guQaU2BnlsWMtipNUcbvqxAPuLHFYVfQPUYv22bgzaoOl1fLhPRaQMXGSAp26NkDVYtt
         9EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776584; x=1751381384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f17suXwGZaWKYHNj2hVCx02g00hUtF+cxL8n4hLFrwM=;
        b=qnOb0b+/5nrhSRGZLFH428Dlu9x+UQhJgvVTQ4vP3mrtp+77mopEiJz8eoUFdVIHjD
         qSjx6DpVTYy6IpMWFm67k9rEwL0sZZqfrx5k0me3TZlumdZudY229JdpPHiRm5KPyn2T
         cULB4F1jZveqyoEN3W9cY1LH6GsLtqtXSNhSnhnKQv9z/E/m0wLXVl3QfYFC8o5MeM07
         dUugLV673noG1JgCFtzIVRqDNBS5XdGTD9m8nVRtWHGV2HzFeIlDSV+R77m18Zu8NgxA
         MA0IFk5L3oxQNEqRmM42QJQ28va72wE51Wtkl43YITu0UV8jjJA2vBDcYuqBu3doG7am
         5qiA==
X-Forwarded-Encrypted: i=1; AJvYcCVolii79kKbFWJ5RFfzRM6/awoilU5+mDYkJnxkX3c0KFGNgWx2dBvQDNfFfXrM09zUN0ANgn+ttIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjfZzBabsNLKu8y11+8RPDyiDP3tKeNVPO7V213Er1hk3+SYNW
	isDw3XPrlLdLbmaAoaP6wHajLRAMcpczU0+ZQQ6nr8lEO8tf8bCuj0LE2P/sMtKz9O0hURc1PAN
	i1Bl5
X-Gm-Gg: ASbGncs/aX2jufKC3Y7hFAwCpMgjLvmq7P54aJC/XMYo2WHZJcaDZSrz+M8Lv+tg1d2
	TMVDhQli+3IJ/4mKV9K0XBN2ZEZXTJHNUDIPO35bhRNwfeoLS0xt583lizIV80xz5Kiel8RVTxn
	5APL72ZrkuhDfRsAhFX0shxXV6SA4L3HIL+Udh2BMLpJdE3/ip+8NbOli/RZI2w3np4c6Q8quNG
	UPcco/Hwq8QcMl2mEyOgOosSFu2PrpjROgYm7r23f7wyVwRs/UPjjUbrTybLEL3jdfS2dra08xx
	+KciF5/vIH4mvZ6CsNYyoVGHDqSq7m4jD+OnmizyYcbDmLy9awEH0YLJJ3pxsQb6KiTP4pV1UkO
	82wcz
X-Google-Smtp-Source: AGHT+IFGsh98Xn7lqzpPwci6Ut5otRF4a95USgj4aytGS8PcOkey/dgiqyyjB95CmPN/YGSny0xhIg==
X-Received: by 2002:a05:6870:a44d:b0:2d8:957a:5178 with SMTP id 586e51a60fabf-2eeee4db0d6mr11360058fac.21.1750776584495;
        Tue, 24 Jun 2025 07:49:44 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:22c9:dcd3:f442:dd1d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee8a8e5eb3sm2149846fac.32.2025.06.24.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:49:43 -0700 (PDT)
Date: Tue, 24 Jun 2025 17:49:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Message-ID: <7a156b03-c522-4e18-85ec-2c7ebfd97a42@suswa.mountain>
References: <148c69b4-4cf7-4112-97e8-6a5c23505638@suswa.mountain>
 <7975be21-045e-4b2b-9c73-79aba5b683db@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7975be21-045e-4b2b-9c73-79aba5b683db@nfschina.com>

On Tue, Jun 24, 2025 at 09:45:27AM +0800, Su Hui wrote:
> On 2025/6/23 23:47, Dan Carpenter wrote:
> > On Mon, Jun 23, 2025 at 08:22:27PM +0800, Su Hui wrote:
> > > Using guard() to replace *unlock* label. guard() makes lock/unlock code
> > > more clear. Change the order of the code to let all lock code in the
> > > same scope. No functional changes.
> > > 
> > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > ---
> > >   fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
> > >   1 file changed, 48 insertions(+), 51 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> > > index ba9d326b3de6..2d92adf3e6b0 100644
> > > --- a/fs/nfsd/nfscache.c
> > > +++ b/fs/nfsd/nfscache.c
> > > @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
> > >   	if (type == RC_NOCACHE) {
> > >   		nfsd_stats_rc_nocache_inc(nn);
> > > -		goto out;
> > > +		return rtn;
> > >   	}
> > >   	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
> > > @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
> > >   	 */
> > >   	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
> > >   	if (!rp)
> > > -		goto out;
> > > +		return rtn;
> > >   	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
> > > -	spin_lock(&b->cache_lock);
> > > -	found = nfsd_cache_insert(b, rp, nn);
> > > -	if (found != rp)
> > > -		goto found_entry;
> > > -	*cacherep = rp;
> > > -	rp->c_state = RC_INPROG;
> > > -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> > > -	spin_unlock(&b->cache_lock);
> > > +	scoped_guard(spinlock, &b->cache_lock) {
> > > +		found = nfsd_cache_insert(b, rp, nn);
> > > +		if (found == rp) {
> > > +			*cacherep = rp;
> > > +			rp->c_state = RC_INPROG;
> > > +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> > > +			goto out;
> > It took me a while to figure out why we've added a goto here.  In the
> > original code this "goto out;" was a "spin_unlock(&b->cache_lock);".
> > The spin_unlock() is more readable because you can immediately see that
> > it's trying to drop the lock where a "goto out;" is less obvious about
> > the intention.
> 
> Does "break;" be better in this place?  Meaning Break this lock guard scope.
> 

Yeah, probably break is better.

regards,
dan carpenter


