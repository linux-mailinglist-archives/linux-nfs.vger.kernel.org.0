Return-Path: <linux-nfs+bounces-13915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FBB38948
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 20:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAC01C20DB5
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC72D0612;
	Wed, 27 Aug 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSeMR7II"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAB2D5A14;
	Wed, 27 Aug 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318078; cv=none; b=e4C0NMAhEI4xpe1poYvpKoivgRcibbZLaXIsx7Wr14SAl1O0Bcnp7jJmLF9FybMlx/Dow7obJoTKt0eyWqEK1uzwwbwDXdR4y+/5r5infKldBUt/+eCWup7TAr8XtgvjZHD30B6EaVCxr3YbnGiMLPr2Y3kk61MEBcii8zbbHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318078; c=relaxed/simple;
	bh=/WdGTRKu/uP6MLjm6SOTm91vY1PdpeieaEytTE+Y2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj0OfKOIsD0C8M7z9Bz9P6n09Qj6yiaE8MXrhbmLtYSISS4bovAApz85jcBkefU4dIpBATdmRZoH4ZNz4MOTY8BnpseHGBycx3oxOWZdRlpYY7vkJT6wZdQASTqDWnaCqJtZISGBLnJmh/xej8Xfu8etML0MNNxJkBkHuzqP9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSeMR7II; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f46ec2e00so87252e87.3;
        Wed, 27 Aug 2025 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756318074; x=1756922874; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WdGTRKu/uP6MLjm6SOTm91vY1PdpeieaEytTE+Y2Gg=;
        b=OSeMR7II1fGsvJ+tOxnEu4LsPas9I83sF4gDjNbMgQ2rAUFci4uxITi1TGB/BLUX2l
         6bJncxNYZFKHYO5BD8Y06J2B2Qw7pvk7EG+iutvkWnqlBVOgOVp4dAMTzqMuB9X4F1AJ
         1mJoAhuc08YKpTcTCBiMDTaqTkuRBUKc8pauT0HiDnq8w6hlI+j6Cq/6DHwe0PFWiNBt
         jjloItMwdArHvF/xzuqhZOxeP/6ukzl0uzXZGxjPhCnaG1B7AuwZC9pOtH5x5S0Dxcyl
         gDx31ek4PUq1Cdqyyv3NnznCYwQcGqeXk6eKgHuri/sh69zM1FDsgL4J9dj55btOh3+W
         CcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756318074; x=1756922874;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WdGTRKu/uP6MLjm6SOTm91vY1PdpeieaEytTE+Y2Gg=;
        b=c/NzUUfmzC+lZRaaNP5YuwemsOn0SAaW2r6WC0IAVf/O5pU1UcrFDF2B78AZKSOEJ/
         N3YRPiYijfPGbx5XVgTb6X5U4imaen5N/6bqmYX3TV7Ayf/U6nOybRCdg2hKdlRosZIQ
         jztGUpGgnWx9pkT5IZnRkzpORk6EeUpTikLXChdA2sxVQIufz+AUXIc2Jb7xAvhEOutp
         OO8CeZ6UZNQodJWyiIRMJwxXGGMjy0xRdE3wZ/RQF0C24YgDD8KyeCqNhA0zAxbyUrAD
         9D4iP38ySVfF+4CMR3/kTZVUZjxPU+DUXpmPVzz2CW4QbZc4rzGuvrb0m2Q9ENdJ34KN
         c5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPRyA0fgBR6lxhQFu2E7moFGxZSpV/2ascoQZMsQvIP93BW5ULq4P1zZ1wItDYtam5CuLqCjeID98VO/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdz2aPT0eTRp6ngTAxhw2wyYibYJP4G02/3chKOP7ZThVFQNhV
	PYbL8DC0BSTetGSmhPtRWu8A4fkwTGRvkrY5sjJCZiwTejrdTifFYKnl
X-Gm-Gg: ASbGncvgHmWHFrhyITmYQtn827NA+PgQU4oMvd+IyyADsWjf3NSuQEZL0HbtI1kqCx2
	SasdF+06OSf9RJK0bVpYo4xjtDy4AjSctCkLuj50szHpBgiCuJWBDhYIQp2ihrFzPrOp1WR/HqM
	xBSt2jZVm98m91zSrUjNYfnzkoykIDvrH30sllQgZumVN0iJqt1pQmZSslJY9DAO9h0CXOkxp77
	dAcM306h9xQWI1WnMTKXUghasvWJqMa4ZrxMf50K8PW7vF4AgQMeBDNRTyB3TqL6xuDe8aDf9Jg
	zOkltij+nW7ho83d1KtzrI6lsZOdVZ8KvAcY2kfySqsTlYQoUcphir6s+ci9cbUePh6KiJRW4Ow
	Pnd6NoXdjuloa2cZRVx4xMvbxwdjS6R0NNglxTcFBk7y0YFHu/nTq
X-Google-Smtp-Source: AGHT+IF3nDKCNH/VGBdJIOnvJMgsc7so58iZHTtkkTL4914QNqndPNJjDY2mNADdhvhLNN58clRckg==
X-Received: by 2002:a05:6512:1408:b0:55f:4bf6:eff1 with SMTP id 2adb3069b0e04-55f4bf6f56emr2272046e87.39.1756318074092;
        Wed, 27 Aug 2025 11:07:54 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([95.220.211.111])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35ca7437sm2899756e87.146.2025.08.27.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:07:53 -0700 (PDT)
Date: Wed, 27 Aug 2025 21:07:52 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konstantin Evtushenko <koevtushenko@yandex.com>, Sergey Bashirov <sergeybashirov@gmail.com>
Subject: Re: [PATCH] NFSD: Disallow layoutget during grace period
Message-ID: <7h5p5ktyptyt37u6jhpbjfd5u6tg44lriqkdc7iz7czeeabrvo@ijgxz27dw4sg>
References: <20250825131122.98410-1-sergeybashirov@gmail.com>
 <f2f09b651a30333e0c9fce311c848c8803c2f7ca.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2f09b651a30333e0c9fce311c848c8803c2f7ca.camel@kernel.org>
User-Agent: NeoMutt/20231103

Hi Jeff,

On Mon, Aug 25, 2025 at 12:33:46PM -0400, Jeff Layton wrote:
> This seems like a reasonable thing to do, but I wonder if it makes
> sense across all different pNFS layout types? This restriction is
> definitely not needed for the (trivial) in-kernel flexfiles server, for
> instance.
>
> Maybe it'd be best to push this down into the individual layout drivers
> and let them make the decision?

Good point. The spec says: "If the metadata server is in a grace period,
and does not persist layouts and device ID to device address mappings,
then it MUST return NFS4ERR_GRACE". As far as I understand, this is a
requirement for a specific implementation option. So moving this logic
to the layout driver level seems reasonable to me. Will submit new patch.

--
Sergey Bashirov

