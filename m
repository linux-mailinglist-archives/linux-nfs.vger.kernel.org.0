Return-Path: <linux-nfs+bounces-8289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847129DF76A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 00:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F05B21308
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Dec 2024 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9271D95A2;
	Sun,  1 Dec 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M0hQ45iS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1B10A3E
	for <linux-nfs@vger.kernel.org>; Sun,  1 Dec 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733094775; cv=none; b=rATGtWAhad68L6mtrvRmHx/dX8J8qOeGYUQJq1KebMUcrMwPjDPlqYb9vKcGTxFGZZkOty9W0grCwglopjxoVaeliTzne1IVizKN19LwEb2kijjyGitchMirj/AUAMLAb8PMPhgoQAAf7pX/dG+QtRUcEE0xjWTOCLPWfJ15bIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733094775; c=relaxed/simple;
	bh=J8VkV+WotHTbc+qzAicULfwz+kWFtfOFEM2EEedBVEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bklAf9B/KzoSVbnYmKfjGqTuAyaPSBaxohFo/etUJNoG/eT2shjwPdOfbcjbGpqgziazaLfqh00XHa2Gg9+Ui3zag/CrP6tcBglLntA5l+QZ/5g3f+3dpoYBGl2qvSTmx2yPP3I0YPk28ahIHqrwJCK7b8Hh+r9hXgCosL4XVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M0hQ45iS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21269c8df64so30500365ad.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Dec 2024 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733094773; x=1733699573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ud96SwjzR69msh47uFT8pcG4a0oGcZjdWqXyciAzX0=;
        b=M0hQ45iSdWpm1DXmRMKFQ/1LEHoqgHcqWTJ8GJSudpfsggHQ45cDLWfUJcehe98ViI
         tjtpguWs6OrXqy+3PjwSMPCPUp14OJbgn2bVyDzG8cCXoZ4TEl/JbSrVaO+tsTniYb1O
         GZv1X8rNmraQyutdF9+7iU48oUXb0PcUb3nkR9slzz0HHT8mLxAb3ITOFPT1Yl98OHPo
         LywM08Wg2IvHyFaQATUwmW3VEDzpdi3GqwvlO1oz92+VVxJbgdaWMJ8XJUk2nYrGJX7r
         O7XTKc2Tvpkn49EPiKYK/Xpma+dLE5In2I11u7uCrfMMlXJlNFF+WvXAmrhggtdRAEw4
         SsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733094773; x=1733699573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ud96SwjzR69msh47uFT8pcG4a0oGcZjdWqXyciAzX0=;
        b=wE071gOYXGXCPTm/N1XuMrwxqHhcw5w1m51EMyYiivYw502xs9hLw46UymTJiYdzRN
         Rcwzd4HWH2jnYTM0WaQnBUPe8JGKLQBSj8VxUsyxomD4zNfjSZu+tbgAi/jrBXdQ/7+Z
         RxJZd2prjiUHVd1zy7+Xkpy694EeRT+q4xMNBACSPlptQXe7ADGoxUDsMkGiEr8aELl8
         h7EpIh5BM0zUvFra9GAkgeoyYowAOzlxu6KUJvbdDYNVGKUDH31dH7X2ApBXLfls/Lb8
         Pz0QcUjTH0lrnKOtO4LdiDbQM/3rs4dMhY/n+sOOM2ETbfFsWO01tBwURdnVmsyThHJL
         Nl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnpIxXCm3wjP6eJuNCKdAvTad8Kifd+rNXtc7zTObnaMtS4yrGsISl54sJRZGfofxEFC/S+iD0dUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1AqJ4lr31W0YMqhUJKDxt64KAZbKJ/KdWx3A0Egm0x3nEVAy
	C57NgBNNp3uy3tNrhftQv3JRMtYr/GAUQQ53NrmO/BgzaywyLVrSBDS50Ozn2V4=
X-Gm-Gg: ASbGncsB43dtEbg0BjRQbJeY31StOYwGL7fhbujD6qckJmiiCw7IBtYQWLeMdrhTDGU
	T9qtc+IYyuqSfxz62YOnHwN4eD8clcQ9Nyl5K9ew2mtwPPHAS5WAt/0nRsd2GLaRzOfTKcHmBnN
	rV3/UgevBctHLvYFuKZyAeyEvXFinPDkWdfKlWJHEYY+C7pVZWp/H0vNDRe5FI8fywf2Wj2Gl9s
	ZYTiDz586C8DZDpghudwZzXaBrnhG/ReleG+WGZ6esnC9joC5hBY3Pcu3qgq0PvS8hqvSx2/D6D
	e7ZzvvC0eK/n+VA=
X-Google-Smtp-Source: AGHT+IEUf9nhYkqjXOeOh/hMs/OkzEv2HFGTg4ODqnBWxYi0eowzsqMTlMTjPtPpo9vv1WTTH6CBiQ==
X-Received: by 2002:a17:902:cf03:b0:215:854c:a71a with SMTP id d9443c01a7336-215854caec5mr43450445ad.34.1733094772815;
        Sun, 01 Dec 2024 15:12:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159d48d97esm1318865ad.239.2024.12.01.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 15:12:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tHt7R-00000005V7I-2Ilj;
	Mon, 02 Dec 2024 10:12:49 +1100
Date: Mon, 2 Dec 2024 10:12:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH 1/4] exportfs: add flag to indicate local file handles
Message-ID: <Z0ztcToKjCY05xq9@dread.disaster.area>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>

On Sun, Dec 01, 2024 at 02:12:25PM +0100, Christian Brauner wrote:
> Some filesystems like kernfs and pidfs support file handles as a
> convenience to use name_to_handle_at(2) and open_by_handle_at(2) but
> don't want to and cannot be reliably exported. Add a flag that allows
> them to mark their export operations accordingly.
> 
> Fixes: aa8188253474 ("kernfs: add exportfs operations")
> Cc: stable <stable@kernel.org> # >= 4.14
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/nfsd/export.c         | 8 +++++++-
>  include/linux/exportfs.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index eacafe46e3b673cb306bd3c7caabd3283a1e54b1..786551595cc1c2043e8c195c00ca72ef93c769d6 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
>  static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  {
>  	struct inode *inode = d_inode(path->dentry);
> +	const struct export_operations *nop;
>  
>  	/*
>  	 * We currently export only dirs, regular files, and (for v4
> @@ -449,11 +450,16 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  
> -	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +	if (!exportfs_can_decode_fh(nop)) {

Where is nop initialised?

>  		dprintk("exp_export: export of invalid fs type.\n");
>  		return -EINVAL;
>  	}
>  
> +	if (nop && nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE) {

Also, please use () around & operations so we can understand that
this is not an accidental typo. i.e:

	if (nop && (nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE)) {

clearly expresses the intent of the code, and now it is obviously
correct at a glance.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

