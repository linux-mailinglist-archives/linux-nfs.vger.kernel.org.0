Return-Path: <linux-nfs+bounces-2888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97E8A8BA0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C58B2261F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BEB1DA3A;
	Wed, 17 Apr 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCPrN9GF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A04E54C
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379947; cv=none; b=e0kcHIuRj2e2eEkT2QsKt5WYPIzxJrCq6CuA+PfEAeMHGYqDhp7LwB8yFmkuajn7HEf6d3D1M0Vq6JdfN/B0EDAh0YSuYShUFWL2y88h0GLstqAxlusKtwQuyflZFPZRWLY0dnvdpIzw8IPugWkseEu4q0wicarpaMyl1JUl/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379947; c=relaxed/simple;
	bh=hCT/luAwSThuNe4zt2eMPb93VO4jgJqQfA6XxMpGLGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT6qXbcD50jQdxqai+YU1OL0Ke4dIYdS8FUpsHlqT6kpNDsf3og6OMASl0bJWE1MQKw6bbSqquXCe0TSyHV/u46dJBY/tfWuJfVXDE0S08+fRFtFKvR1IaDt2EnpDNExWlMEBtlrLsZJdS9TTEdtUw+6dHFx24Qz5d5SwrKwh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCPrN9GF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso1042711fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713379943; x=1713984743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbaAK8fdxcGhup7rupUdiUwKe4jbN/W2xXGlto+vDfE=;
        b=aCPrN9GFGl4LJGaghKeFAg5aNIu0LBpF8bHvC+Q8Y4vzJJ5Uc4W6f3et4+wxNk9Bk0
         jod+Aqoo92PMfTNsb8uoFXp5E/8gHRob2RZR48kq9LWczhBJAttebxL2OpXDfXtAWJAl
         Ez3Dzl5S+/ZngkhW2Q92HQbFRNdI46Gt73d601xdKXAhIU2QKLWzGgYj9HxsC9YnXnaL
         fsj8ME4V8NaunLjNsxhvWACmjFh2Yu8Mk4pSqfyWlrh4lL7a1apHFdJ3gXPbzDmt0iop
         96UNBnlpUeNgje5Aj3oCkBBM9AM7IdqAG0xGNk0t0U8EpJZcptmaoN9VxKVS3gHLpyjF
         AHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379943; x=1713984743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbaAK8fdxcGhup7rupUdiUwKe4jbN/W2xXGlto+vDfE=;
        b=PiyPE7U2GC0C15Zw9xrKvnuOmiAQEYcq/h03kGID6hCIANm3xIYLkhdWePxMn0CKWX
         3iLMs8g9xUQUTtOl5ctYlUa4D3HarSy7ocqQG+QRD1IdupzLXzO6KnH5ZPUk5ALO+xF2
         GymUq+YRdaz39nk/xL35qK2uPmYasalSq/SBzcyKmmEyT/SnAPEavE98f5s6TONWBUkQ
         ET7OznXizEOdeHeITgWBd0xs9MDizJUgqxyM8qrHFEdaYr2l7JsGOvN8dqx/Ja6YbSzP
         1d6jiLzyTdcLaFsOSB1m8aWCxzw8AetL/aKSfJTLLP0lcIK3ph7FVcG+vMIz7wlW7cD5
         Vksw==
X-Gm-Message-State: AOJu0YxZMCZvM2ubBLcbn0BQLYvjVHgzoYJN37En08avjRFkrthbSDWw
	y1RZBbj1eXaqgQ6xTpbdkgZCBPoIbhLTuFTzd+/kuBqXZJAOODhvb4Ic+iIxOFGZHM/072LqbQu
	t
X-Google-Smtp-Source: AGHT+IFAJxM8WdREJTzoHOUMxTIOLTBj7l87wj91gUMxCQ5AZn4kZ7Tb4PVXoCXMH6hMp8/UqyV5jg==
X-Received: by 2002:a2e:8519:0:b0:2d8:180d:a62a with SMTP id j25-20020a2e8519000000b002d8180da62amr106145lji.25.1713379943135;
        Wed, 17 Apr 2024 11:52:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b0056fe8f3eec6sm7315982edb.62.2024.04.17.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:52:22 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:52:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [bug report] NFSv4: Fix free of uninitialized nfs4_label on
 referral lookup.
Message-ID: <4f6f3f08-3d46-42ae-ad8d-175e3ae4b4af@moroto.mountain>
References: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
 <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>
 <7c4df27b-9698-4d49-a35f-9395b75348d3@moroto.mountain>
 <F0002E44-B2E9-4DE3-BF3B-771F814A8EE1@redhat.com>
 <ae7bbc2e-49c6-46df-8876-06b11dd551e5@moroto.mountain>
 <749EE32A-D89E-4F3A-884C-54A788B9D1C2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749EE32A-D89E-4F3A-884C-54A788B9D1C2@redhat.com>

On Wed, Apr 17, 2024 at 02:30:23PM -0400, Benjamin Coddington wrote:
> On 17 Apr 2024, at 11:08, Dan Carpenter wrote:
> 
> > On Wed, Apr 17, 2024 at 09:51:48AM -0400, Benjamin Coddington wrote:
> >> On 17 Apr 2024, at 8:40, Dan Carpenter wrote:
> >>
> >>> On Wed, Apr 17, 2024 at 08:00:04AM -0400, Benjamin Coddington wrote:
> >>>> On 15 Apr 2024, at 4:08, Dan Carpenter wrote:
> >>>>
> >>>>> [ Why is Smatch only complaining now, 2 years later??? It is a mystery.
> >>>>>   -dan ]
> >>>>>
> >>>>> Hello Benjamin Coddington,
> >>>>
> >>>> Hi Dan!
> >>>>
> >>>>> Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on
> >>>>> referral lookup.") from May 14, 2022 (linux-next), leads to the
> >>>>> following Smatch static checker warning:
> >>>>>
> >>>>> 	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
> >>>>> 	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result' = '0'
> >>>>>
> >>>>> fs/nfs/nfs4state.c
> >>>>>     2115 static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred)
> >>>>>     2116 {
> >>>>>     2117         struct nfs_client *clp = server->nfs_client;
> >>>>>     2118         struct nfs4_fs_locations *locations = NULL;
> >>>>>     2119         struct inode *inode;
> >>>>>     2120         struct page *page;
> >>>>>     2121         int status, result;
> >>>>>     2122
> >>>>>     2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __func__,
> >>>>>     2124                         (unsigned long long)server->fsid.major,
> >>>>>     2125                         (unsigned long long)server->fsid.minor,
> >>>>>     2126                         clp->cl_hostname);
> >>>>>     2127
> >>>>>     2128         result = 0;
> >>>>>                  ^^^^^^^^^^^
> >>>>>
> >>>>>     2129         page = alloc_page(GFP_KERNEL);
> >>>>>     2130         locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
> >>>>>     2131         if (page == NULL || locations == NULL) {
> >>>>>     2132                 dprintk("<-- %s: no memory\n", __func__);
> >>>>>     2133                 goto out;
> >>>>>                          ^^^^^^^^
> >>>>> Success.
> >>>>>
> >>>>>     2134         }
> >>>>>     2135         locations->fattr = nfs_alloc_fattr();
> >>>>>     2136         if (locations->fattr == NULL) {
> >>>>>     2137                 dprintk("<-- %s: no memory\n", __func__);
> >>>>> --> 2138                 goto out;
> >>>>>                          ^^^^^^^^^
> >>>>> Here too.
> >>>>
> >>>> My patch was following the precedent set by c9fdeb280b8cc.  I believe the
> >>>> idea is that the function can fail without an error and the client will
> >>>> retry the next time the server says -NFS4ERR_MOVED.
> >>>>
> >>>> Is there a way to appease smatch here?  I don't have a lot of smatch
> >>>> smarts.
> >>>
> >>> Generally, I tell people to just ignore it.  Anyone with questions can
> >>> look up this email thread.
> >>>
> >>> But if you really wanted to silence it, Smatch counts it as intentional
> >>> if the "result = 0;" is within five lines of the goto out.
> >>
> >> Good to know!  In this case, I think the maintainers would show annoyance
> >> with that sort of patch.  A comment here about the successful return code on
> >> an allocation failure would have avoided this, and I probably should have
> >> recognized this patch might create an issue and inserted one.  Thanks for
> >> the report.
> >
> > To me ignoring it is fine or adding a comment is even better, but I also
> > think adding a bunch of "ret = 0;" assignments should not be as
> > controversial as people make it out to be.
> >
> > It's just a style debate, right?  The compiler knows that ret is already
> > zero and it's going to optimize them away.  So it doesn't affect the
> > compiled code.
> >
> > You could add a comment /* ret is zero intentionally */ or you could
> > just add a "ret = 0;".  Neither affects the compile code.  But to me, I
> > would prefer the code, because when I see the comment, then I
> > immediately start scrolling back to see if ret is really zero.  I like
> > when the code looks deliberate.  When you see a "ret = 0;" there isn't
> > any question about the author's intent.
> >
> > But again, I don't feel strongly about this.
> 
> I think we could refactor to try the allocation into a local variable, that
> should make smatch happier.  Something like:
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 662e86ea3a2d..5b452411e8fd 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2116,6 +2116,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
>  {
>         struct nfs_client *clp = server->nfs_client;
>         struct nfs4_fs_locations *locations = NULL;
> +       struct nfs_fattr *fattr;
>         struct inode *inode;
>         struct page *page;
>         int status, result;
> @@ -2125,19 +2126,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
>                         (unsigned long long)server->fsid.minor,
>                         clp->cl_hostname);
> 
> -       result = 0;
>         page = alloc_page(GFP_KERNEL);
>         locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
> -       if (page == NULL || locations == NULL) {
> -               dprintk("<-- %s: no memory\n", __func__);
> -               goto out;
> -       }
> -       locations->fattr = nfs_alloc_fattr();
> -       if (locations->fattr == NULL) {
> +       fattr = nfs_alloc_fattr();
> +       if (page == NULL || locations == NULL || fattr == NULL) {
>                 dprintk("<-- %s: no memory\n", __func__);
> +               result = 0;
>                 goto out;
>         }
> 
> +       locations->fattr = fattr;
>         inode = d_inode(server->super->s_root);
>         result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
>                                          page, cred);
> 
> I don't have a great way to test this code, though.  Seems mechanically
> sane.

It looks good to me.  I think it does make the code more obvious, but
again, I really try not to make static checker warnings a big burden for
people to deal with.  These are a one time email, and since the code is
correct, if you want to leave it as-is that's also fine.

regards,
dan carpenter


