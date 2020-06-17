Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507931FC576
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 06:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgFQE6d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 00:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgFQE6d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jun 2020 00:58:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C2C061573
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2020 21:58:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so814547wrw.8
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2020 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cUp4cMJeqPGJFtnqCsTZ5wffxHSVBXJNuzm2UKzopaQ=;
        b=CyQia/7yEpvDWrMbP+hAnSC2aNJ711MrzpFRQV/R7xdWR0g6Ogmfdze1RYY1uwwr2L
         20WxmMwDhRtouMcXessyqycAozdFVZfJXvxa2myzs0h9wDiD56w4MFLwxp0/WwS+u0hg
         ik6qJIubTlLLQ4/GuXb7uBHOVxhywFY8NGEKCAfn4y0/nzr56BudsrBiGOIcFkymgie6
         i4cXjaPeI3tdePWsP812S/IsELJjTPWbJspYMfQea2cZnDDwQobdJj4R8iG53kFFZ2Yx
         OtuQx64c4fvIkL5CfneKC7d85mh+SZjAiwsCwjOc1lDQOL67uBaqIjX76n2wgLvUOBjX
         913g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUp4cMJeqPGJFtnqCsTZ5wffxHSVBXJNuzm2UKzopaQ=;
        b=nk+3Y2Ut+CsCDQOXitBvjIrGSGs9z71Fqg8pGZpK7JWT1rclSkE6SkiozgkmnRO4vS
         TdwmcEdL4cBVc4LMjP/t0ckqXlAPzzWHoFAc0ZFCoAEngAVxBMRoO52Yn/KZGgdI3K/0
         224owahTP17RMIKAA+0rvysw9Q8BZSdqK6ihpqRlw1GMfKjD4kYI0jI/MHIkokhyJfbW
         yKLM4MwlncBDyW0jheHeIrdCMDy8D9Ix1DK1hQRk9/l3USQB0vsR7td1F6WZakFyakE2
         BRm2MAGqsAW82gS1Z31ueAoPL6PuRHyqB7SkjtmK72ZTdW5zsYdGApjxRJnPSqF6F0oW
         SHvA==
X-Gm-Message-State: AOAM532wZDeVvxxQsRt4B3+MTVbUXq+4blNe2dp+2ZHvx5bOm+5LkxS+
        /6LblnkJ6umapK1KHi7Oyw4=
X-Google-Smtp-Source: ABdhPJz3u25vQbK+4o+XBCM8kpseeQeBw3v4zV7YqVle50TVr9qTodqkUuIh4lV70BYnRAu2GShaMA==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr6636591wrp.426.1592369911071;
        Tue, 16 Jun 2020 21:58:31 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id f16sm6817970wmh.27.2020.06.16.21.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 21:58:29 -0700 (PDT)
Date:   Wed, 17 Jun 2020 06:58:29 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl
Message-ID: <20200617045829.GA26611@lorien.valinor.li>
References: <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
 <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li>
 <20200617005849.GA262660@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617005849.GA262660@pick.fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Tue, Jun 16, 2020 at 08:58:49PM -0400, J. Bruce Fields wrote:
> On Tue, Jun 16, 2020 at 06:16:58PM +0200, Salvatore Bonaccorso wrote:
> > This might be unneeded to test but as additional datapoint which
> > confirms the suspect: I tried check the commit around 47057abde515
> > ("nfsd: add support for the umask attribute") in 4.10-rc1
> > 
> > A kernel built with 47057abde515~1, and mounting from an enough recent
> > client which has at least dff25ddb4808 ("nfs: add support for the
> > umask attribute") does not show the observed behaviour, the server
> > built with 47057abde515 does.
> 
> Thanks for the confirmation!
> 
> I think I'll send the following upstream.
> 
> --b.
> 
> commit 595ccdca9321
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Tue Jun 16 16:43:18 2020 -0400
> 
>     nfsd: apply umask on fs without ACL support
>     
>     The server is failing to apply the umask when creating new objects on
>     filesystems without ACL support.
>     
>     To reproduce this, you need to use NFSv4.2 and a client and server
>     recent enough to support umask, and you need to export a filesystem that
>     lacks ACL support (for example, ext4 with the "noacl" mount option).
>     
>     Filesystems with ACL support are expected to take care of the umask
>     themselves (usually by calling posix_acl_create).
>     
>     For filesystems without ACL support, this is up to the caller of
>     vfs_create(), vfs_mknod(), or vfs_mkdir().
>     
>     Reported-by: Elliott Mitchell <ehem+debian@m5p.com>
>     Reported-by: Salvatore Bonaccorso <carnil@debian.org>
>     Fixes: 47057abde515 ("nfsd: add support for the umask attribute")
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0aa02eb18bd3..8fa3e0ff3671 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1225,6 +1225,9 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		iap->ia_mode = 0;
>  	iap->ia_mode = (iap->ia_mode & S_IALLUGO) | type;
>  
> +	if (!IS_POSIXACL(dirp))
> +		iap->ia_mode &= ~current_umask();
> +
>  	err = 0;
>  	host_err = 0;
>  	switch (type) {
> @@ -1457,6 +1460,9 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		goto out;
>  	}
>  
> +	if (!IS_POSIXACL(dirp))
> +		iap->ia_mode &= ~current_umask();
> +
>  	host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
>  	if (host_err < 0) {
>  		fh_drop_write(fhp);

Thank you, could test this on my test setup and seem to work properly.

Should it also be CC'ed to stable@vger.kernel.org so it is picked up
by the current supported stable series?

Regards,
Salvatore
