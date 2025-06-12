Return-Path: <linux-nfs+bounces-12377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB654AD7760
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCE41882B96
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C724B26E717;
	Thu, 12 Jun 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi+YKDV6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541B1A8F79;
	Thu, 12 Jun 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743844; cv=none; b=YRisZLaTtWNuUUl0IhIYF3RHgHCW8J4cl4d20xpKaKpGEe/5pEA2uZnRn8DodP8O4Tmy5eHrqM0f6F4xTZio+YeGrMoWaquxcitdLZJnrTv+Nu8kmLa0jCtefAXaZrexvaQU+qqPNqh1L76mqXTm9zvZhSGYCw3mWVtAmOIAxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743844; c=relaxed/simple;
	bh=evcvXqww3OzUJzsgDgW8nVIYByuR/3CzVFzRK8zBncM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phtms5E6VGFX43SS2y4tf5Y5Fjsh7GKom+f35bKOSppyvM4BKTbQo14ERMKnGRY34A24Gv46lCsQdr8ECsvhyhWjvA9FnR2PCKiSrHB8ck5SzEtl9FL0bduvB8+rzmVBEGMmuum6rqzaXxXbkbGSNEriI88nDGBOV0PsbtI6/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi+YKDV6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55394ee39dfso1166413e87.1;
        Thu, 12 Jun 2025 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749743841; x=1750348641; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9179uFVoT3EW7ZHfseKQ7sHz/HhsAa08rUdpavyALIQ=;
        b=Fi+YKDV63MV1lYH6Jrhic5JwWmjZZASn7ki6sUt/nK6rh25WPHqWa6u0WJIgx2Zwzx
         Nmm9CgunGR9XqmnTB7/hNUDpjT9dEWpf20FsJKnFU8yhnO3FSTZO/21E3O/prJZDjVZ1
         GuGHekRnykeQ2x2VqibXH9EhGntpZ4pthZqEn8DtQIZ/11tr9p1o1O3s4DOhWk0BKXqU
         AA0Ypf8C4+TMkAtJ0x5CdJ7hIObednTxH4lmHx2yCsFg6CmfKfm1/A1DIjMRJljS3uTr
         cI8fWDjaaRuIOHwlS7zbuIuCZXgGRuqbp/XUsBYcIqQ5aNuodc7Ns0+gsbZjHDnLnIfQ
         jsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749743841; x=1750348641;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9179uFVoT3EW7ZHfseKQ7sHz/HhsAa08rUdpavyALIQ=;
        b=Hnw0t4NqJ39M6QC8R0be6aKdlrpQdUeoxB/YNHDZxpUQnlJb1CQdn1Wq1aRvU4EQYZ
         XtVKdwEsN+iPCrhYknh5xIWOi81lTexbKgUnybiQH44Frwr4h5/UcSwdZR/r7XRJFR24
         dHM4w2ds8xjH3JRA/xywveaxR7KnEMKeGDIK36r5Bq5Z8WoLEs5bCk0Xvw2UU8DxerI5
         8ju2WjYWwsa2lue7y9/C2NnuSwoYTPdBHzbyYKZLg2O2pF6R3InO4eWm2/A/7/Au/9yD
         u7dKr1EvuJ0a79Gece2Qbpg7yDRS819ww0gEcGwqBG/CHfPPs6+bG7yNKveTKATR8of7
         utSw==
X-Forwarded-Encrypted: i=1; AJvYcCWgrzHSF6f+rQrNbT7y4j13brzMMUp83EO9KcTiTyKCmznvAUYWxShOqRJQB1Bir5u56VWdo792Swh37oM=@vger.kernel.org, AJvYcCXN9kGjBYzBfmwoFznG7CVqg7MYmTzAKPizzCZ0hsDwPV2lz+AR1pE19dNAMhCLH+vKeOl43H1zQdz2@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPUxMghH05jTwUPwZ9TjwVwou+Fb6iKJ1ZSdSypo6jyZQMkFF
	SNegnZI7+ykJaGjY2HfNmWNEYfVZai2vGZweLb7JgKtcXI0jLTkOnPP2
X-Gm-Gg: ASbGncvLB6d8p87UhAjGTwVzcbvYegTYPnq+8br/KX+JdcwZLxEFer9kZU7QLhxianw
	rhVObcHdOgVRzW0HvL/lPSytv/EzNeV4ZKkM4UrqbkP/efkVP7U846kaTbx0eOoZk4m0wVaFtUw
	HndjH1CmkQt+gZO+fjFqAwYLBGmxVuY9BWuk/11kczjQvECxVBH5hxcIMJFscltyTpTr10ZgKjA
	y7iT9rVCtt1dE179d66AKYJ5m264p5RVXk4MQkmRV5zCZnFhoPVKjWxmkSQBb7gvhZSo12QVJXQ
	v3IqnmIfv3+yvtN3Zvb0bua7fNYoeVcn1X2bXPTvmevRRh1kpgQOle/qmPHywBUGmCR28PcqKA4
	9ex6FgiAvfNBPZpGJ1HKPblo=
X-Google-Smtp-Source: AGHT+IFFBAnZphSpay7uT97FtpVQuu9LlHxtRNVKszGcz//pBOhulNNZ/P57ZJmOEBGALEIMLq44QA==
X-Received: by 2002:a05:6512:3a85:b0:553:2884:5fb3 with SMTP id 2adb3069b0e04-553a5442279mr1338988e87.12.1749743840851;
        Thu, 12 Jun 2025 08:57:20 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.250.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f7c19sm148313e87.233.2025.06.12.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:57:20 -0700 (PDT)
Date: Thu, 12 Jun 2025 18:57:18 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2] nfsd: Use correct error code when decoding extents
Message-ID: <lqssee7hdp5bkty34idm6s6xz2hfxpbkthzgqgopc72vbyzrdx@egvanmm3llrg>
References: <20250611205504.19276-1-sergeybashirov@gmail.com>
 <aEp6-T8Oqe2dI7of@infradead.org>
 <1951a618-a35d-4515-b4b7-131880a780c6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1951a618-a35d-4515-b4b7-131880a780c6@oracle.com>
User-Agent: NeoMutt/20231103

On Thu, Jun 12, 2025 at 09:10:11AM -0400, Chuck Lever wrote:
> On 6/12/25 3:00 AM, Christoph Hellwig wrote:
> > On Wed, Jun 11, 2025 at 11:55:02PM +0300, Sergey Bashirov wrote:
> >>  	if (nr_iomaps < 0)
> >> -		return nfserrno(nr_iomaps);
> >> +		return cpu_to_be32(-nr_iomaps);
> >
> > This still feels like an odd calling convention.  Maybe we should just
> > change the calling convention to return the __be32 encoded nfs errno
> > and have a separate output argument for the number of iomaps?
> >
> > Chuck, any preference?
> >
>
> I thought of using an output argument. This calling convention is not
> uncommon in NFS code, and I recall that Linus might prefer avoiding
> output arguments?
>
> If I were writing fresh code, I think I would use an output argument
> instead of folding results of two different types into a function's
> return value.

In general, I am ok with either of these two approaches. But I agree
with Christoph that the solution with a separate output argument seems
more natural to me. Should I submit the v3 patch with a separate output
argument?

--
Sergey Bashirov

