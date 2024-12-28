Return-Path: <linux-nfs+bounces-8812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1A9FD93F
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E6016173D
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F183595F;
	Sat, 28 Dec 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug9cOtF4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C933EA
	for <linux-nfs@vger.kernel.org>; Sat, 28 Dec 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735368844; cv=none; b=Vgc2+MRfgTWea03WpnxxmMokhqzMww5g8ziBhCOrG611aS90isWNnALjRbC1sdft/x6xjbYc3pl5ndZAfQAvD6cONHaSnQJnPmXKol/eDlQtsZgwqG8po+Jh2uRb4WRjC9pdk4q0YSkBQmoqeT+ruZ/eK1ZQWQc4ZizyHm9XfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735368844; c=relaxed/simple;
	bh=/YLbJYvn3OXWaykehFU5PWDVcjwb8EmGk7qtLTKuKeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkpLnrPQ/B1wvP6Djg1jX8h8Gnri4DEg38mtu1sdQG+xqqAg6dr307ebHLF/mtjPmDb/SSmES9bx+BqtyVwxP9nmyLWM38ENTdcwIwADY8JXN0sDY/R1ovSjC9ltmZZ6SpwNgNMLEl1JNwBcKGmbRRBXbS3ceHjMvXv0HhF1MZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug9cOtF4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67ac42819so1101243966b.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 22:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735368840; x=1735973640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCjtknNAZ8RcZFrQ9OGZ69E6KqdnbRomfTkItLmd6EY=;
        b=Ug9cOtF4Eqh01e/6bReOkPZjN2oN06T02TYCC7JwCeO/0Ym+PfJf3AxyzyrhC+43ye
         sigU9zaiJ102x3bNmdDmhN1F9QLNLD1+N37XMADTGUekJ9MF3U0yamfo5B6hGHRHbiQw
         H2gO+hzUakuRDnGMaoZCRTwvmf9DAd+MAw/TbaiUJPGll+9Bs6S8GmcVpen2T+n7nwPE
         d+cjM/RZgpD0/mQbrNgrZHf5qo7gQITJPAU3XHPHckz/+E4cPNmDcHfeBAHfdEPYjp0Z
         9/rkhMRzfKrP907YCO2mlirtxZwOdlhwv4Y+m57+ZmxxG7kwseNcZ3sVGI3zehiSQwFY
         TZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735368840; x=1735973640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCjtknNAZ8RcZFrQ9OGZ69E6KqdnbRomfTkItLmd6EY=;
        b=QB/f+CDv/CyCPFkhgxAkerEgxTCneyfhbteDnerhM3//84HIMBc6GqNgrTozWuiFbc
         wGHjJwbXNhyBO4ijgXAhDLnPK0RHHNGndZiVTPGAFRiTx/6xzMiBbvDyZ29t+DActYDT
         +IdWkNx1JbW4QpFuDbQmydzLzpRdeX2p+C3xNFnkWwN8lRAPRw9x8CS83h4d0+A7IwwB
         UiPC+X/dL1t4T85ZY4MEqaaqdv8GU2xAgMCqmxyqx9nNCJfRIEeyhiSJGDj46PBUWaaf
         q02h036Kh0aw/RkbXV3xwrWvYvPnHX56COhXArFL3v88B9bwBXvRQWOqG6uYny98dvkx
         CC7A==
X-Forwarded-Encrypted: i=1; AJvYcCURNTxR0rtIbzA8/ow9IYskjboZ9gkdYqZTt+uv13kVzeA5Kl6biGFzxIrH6duO1Eh4R7WtX/L1kIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsDgJBn63k369U8dAIbz8UjouvdbeBUWwpnvSQBNIgUCctcKI
	7NXFiQp2Ilb2LiRh2CSJT27MUdHqrQLbmfkHVLMp6dMSZw+mEEM92If6VqUr
X-Gm-Gg: ASbGncuk3FD8kvjlsa+j9pij/o30ZBF/oMpOfCbezo3mrJcXt76TD6ZzJgyvh0+k5vt
	qo9+c8sYnpeYxpEvWWTREHlxo4YE9HYA/MbtMTvV+zSj12vtQ88txwpImk0ZNyiNY0Y4vUI1S3P
	cpAl7m7/Bx0HPa3a+sp/LvWlq2GwyUUTeC0+WugvdYhAoQg62+sQ2eDHXsna5MPJciS7eWuE1lK
	/Kim1gttTtUOk65OWYRU1PA3ZxUdAYL+rSfUhnvqpSWYIS6bWttSe6G0TjWNfW16AcZ0yt+dht7
	m9rlu7qGTF5MFEG5
X-Google-Smtp-Source: AGHT+IHjWKC0EUmYv5QHROPxLIQ+7s2/u+AtW2tnFSjJ/z81cB2ihNP62ZscO/+iMwyLDk/OUI52Aw==
X-Received: by 2002:a17:907:9686:b0:aa6:96ad:f8ff with SMTP id a640c23a62f3a-aac348c45ebmr2131200266b.52.1735368840110;
        Fri, 27 Dec 2024 22:54:00 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8301bdsm1207055366b.31.2024.12.27.22.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 22:53:59 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id ADFD2BE2EE7; Sat, 28 Dec 2024 07:53:57 +0100 (CET)
Date: Sat, 28 Dec 2024 07:53:57 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, jur@avtware.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix legacy client tracking initialization
Message-ID: <Z2-ghcWgo1DT3ymc@eldamar.lan>
References: <20241210122554.133412-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210122554.133412-1-smayhew@redhat.com>

Hi,

On Tue, Dec 10, 2024 at 07:25:54AM -0500, Scott Mayhew wrote:
> Get rid of the nfsd4_legacy_tracking_ops->init() call in
> check_for_legacy_methods().  That will be handled in the caller
> (nfsd4_client_tracking_init()).  Otherwise, we'll wind up calling
> nfsd4_legacy_tracking_ops->init() twice, and the second time we'll
> trigger the BUG_ON() in nfsd4_init_recdir().
> 
> Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> Reported-by: Jur van der Burg <jur@avtware.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219580
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/nfs4recover.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 4a765555bf84..1c8fcb04b3cd 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -2052,7 +2052,6 @@ static inline int check_for_legacy_methods(int status, struct net *net)
>  		path_put(&path);
>  		if (status)
>  			return -ENOTDIR;
> -		status = nn->client_tracking_ops->init(net);
>  	}
>  	return status;

With a kernel with CONFIG_NFSD_LEGACY_CLIENT_TRACKING=y and this
change applied, successfully tested against the issue reported in
https://bugs.debian.org/1087900
https://bugs.debian.org/1091439

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore

