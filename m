Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2991FA834
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 07:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgFPF2l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jun 2020 01:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPF2k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jun 2020 01:28:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DEBC05BD43
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 22:28:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so19336293wru.6
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5Ft4YKwmFFHj/dkFKUTixtm4GlWlXsPWfokZGp8Nhw=;
        b=Z4VeE005/5N+csCEUTl4qD1uVxTVejR2qaACnRkpIzrU9gNSlri1EnEBSyIXgG/cW6
         QMqw4GuFPWNa5c/ynH6IC35MMHvTZfFNwm7bPmGMPFNWuQ4NU2nJ1VelX8i5qHpQwbL9
         3c9zfvjG481iIRP+cSsNDtgJgV2gK+taX830CBgWXSNG/y67xyLhPL6Y9GIjDz0rjhdb
         IU9T2z8HDV6XFTb/68Q7sMPKn1UiFnKggXk/67K2PZXxZR3vSv251X4+yzdOWajJgdBS
         nEg8wiN732Bo/4w+IEqhLEBechXmb1QQnzmkd9qV9T1ce8pfGHab+65gcAdPeskkI31W
         ZkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5Ft4YKwmFFHj/dkFKUTixtm4GlWlXsPWfokZGp8Nhw=;
        b=dC+oWdkGfK2FZ1V7rptMNESGAcEdt4aCH9sL7aDHHnErrhSDAlzniPf/4Phh4Y1R48
         21owCz2Z0iL0gfXRVbtBOTc/bHrv7CEZUW5EJDnnz7lXhbOzu6ebjS2R2IFYZtXbERqL
         8dQm5AfELCoBxsusZd0UersyY362qBYc8WirAip/2RQbEd1belxKCZD/FgrxSqmS5r7k
         3r515HY37yF8LFgG9w4zeucUrOhYYafoibs/Kcb5Qk9LiuLOZk1TlVPCOniSbEBBwcL1
         IjWtPhsdvWVAoap5XC2zPJ4mC8xik5hZqeqEgqlEsnzaLWz1yxlRlIXQvW/cHLOJz3je
         38DQ==
X-Gm-Message-State: AOAM533sMJn+rlS22hg/hWROugL9WC6A6XOc/suhhe0Oewjc7gRH5DXe
        drXUgtlKgnfqO9VquVQvAvU=
X-Google-Smtp-Source: ABdhPJywpGJitIXfspLPuGonklOvpa1jChr5oJM26D4Fh3OLW4/Gfk6Gx20QaUn95Iz8lUx+6LWG8g==
X-Received: by 2002:adf:82f8:: with SMTP id 111mr1045378wrc.257.1592285317897;
        Mon, 15 Jun 2020 22:28:37 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id c65sm2291877wme.8.2020.06.15.22.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 22:28:36 -0700 (PDT)
Date:   Tue, 16 Jun 2020 07:28:35 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200616052835.GA19246@lorien.valinor.li>
References: <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616023820.GB214986@pick.fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On Mon, Jun 15, 2020 at 10:38:20PM -0400, J. Bruce Fields wrote:
> Thanks for the detailed reproducer.
> 
> It's weird, as the server is basically just setting the transmitted
> umask and then calling into the vfs to handle the rest, so it's not much
> different from any other user.  But the same reproducer run just on the
> ext4 filesystem does give the right permissions....
> 
> Oh, but looking at the system call, fs_namei.c:do_mkdirat(), it does:
> 
> 	if (!IS_POSIXACL(path.dentry->d_inode))
> 		mode &= ~current_umask();
> 	error = security_path_mkdir(&path, dentry, mode);
> 	if (!error)
> 		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
> 
> whereas nfsd just calls into vfs_mkdir().
> 
> And that IS_POSIXACL() check is exactly a check whether the filesystem
> supports ACLs.  So I guess it's the responsibility of the caller of
> vfs_mkdir() to handle that case.
> 
> So the obvious fix is something like (untested!)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0aa02eb18bd3..dabdcca58969 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1234,6 +1234,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			nfsd_check_ignore_resizing(iap);
>  		break;
>  	case S_IFDIR:
> +		if (!IS_POSIXACL(dirp))
> +			iap->ia_mode &= ~current_umask();
>  		host_err = vfs_mkdir(dirp, dchild, iap->ia_mode);
>  		if (!host_err && unlikely(d_unhashed(dchild))) {
>  			struct dentry *d;

Thank you!

Tested your patch on top, and it would solve the directory case, but
the underlying problem is more general (and as you said proably needs
further checking in other places):

root@nfs-test:~# mount -t nfs 192.168.122.150:/srv/data /mnt
root@nfs-test:~# mkdir /mnt/foo && ls -ld /mnt/foo && rmdir /mnt/foo
drwxr-xr-x 2 root root 4096 Jun 16 07:24 /mnt/foo
root@nfs-test:~# touch /mnt/foo && ls -ld /mnt/foo && rm /mnt/foo
-rw-rw-rw- 1 root root 0 Jun 16 07:25 /mnt/foo
root@nfs-test:~# umount /mnt
root@nfs-test:~#

So when creating files the umask is still ignored in the noacl mounted
case.

Regards,
Salvatore
