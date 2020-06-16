Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0804E1FBB27
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgFPQRF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jun 2020 12:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgFPQRD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jun 2020 12:17:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455AC061573
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2020 09:17:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so3452684wmj.0
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2020 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RcbSMXhODqJvViCJeZ05GHO33u0xVBh7EIAnE2robwo=;
        b=qZmrMWoF4kZI83ycROC722mWeg+mBC3HXlQhdBpIhoLW9zLbzCEF52ecykLGxvfQxs
         +kR82lQTLUMcNBnMxBRtMW9El1teYfAPr7Nh4exfthcdl78m3WlbMsRby+UTfSHGP/xx
         lL04T7ENHjg9gvjDaPoSPGJWpwRF18wCSoqT6675sdsqEqqcXnphHHFbXnEynew53kja
         X4Ye8Zqgep+KlClyH96JZjky4GG5Vh3lOG47DtxUGg08mHDXQddbSffsSEF7l0e4LErj
         o7kc0sGufJn9qewDtlyiu9OOMcs8UQraj9fOW/KJ/xyV+4Uhp0D8p/35O2PZFp8qCLE4
         UC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RcbSMXhODqJvViCJeZ05GHO33u0xVBh7EIAnE2robwo=;
        b=cMnf/pUu0fEz55BNebzWkqTp6SMeBKpwmwAi3iZH1gekhH92+kR9muJHSvxgrRv3mC
         hTFFyJUdFiJsvTRRAHAtelbBq6wpIQwYpuQEnxc0LJ3SoK8xyvq5zJNs6ee9FGfJNOzc
         nNbJVXyReHyQ/4qjwhXHwCJcWPzeofI75SlG3EwuUghKwdbRde7DHCDstuc3ullgZlQg
         7EOW0KMWIeHeIx+/YBnEe8ViyPXf7EwYvV4AGBLFlHh93vjQehMYXah8YOeEFntR88Sm
         Vg/abI1y5WIl5Iu3YClz8O5r4cMif/HLCiFFR+5oYVLPJuLh0HOefC8IlW0H3Z5rRQi1
         wlDg==
X-Gm-Message-State: AOAM533ml0SGhWKdwOwtOXD/aOpYX+vU6Xf582temee4jaOZw+jQ0l+Q
        tg+F4L/MkH36Oj6FNfPlf9I=
X-Google-Smtp-Source: ABdhPJwfwh+8Ih4JjGYaYrOeqbmbEyu2HyOoQG+TUUvCPNkOnlnUe0GIPorJtVuUAf5BtQaDuo0adg==
X-Received: by 2002:a05:600c:29a:: with SMTP id 26mr3838817wmk.76.1592324221467;
        Tue, 16 Jun 2020 09:17:01 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id t188sm4660005wmt.27.2020.06.16.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:16:58 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:16:58 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200616161658.GA17251@lorien.valinor.li>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
 <20200616024212.GC214986@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616024212.GC214986@pick.fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On Mon, Jun 15, 2020 at 10:42:12PM -0400, J. Bruce Fields wrote:
> On Mon, Jun 15, 2020 at 10:38:20PM -0400, J. Bruce Fields wrote:
> > Thanks for the detailed reproducer.
> > 
> > It's weird, as the server is basically just setting the transmitted
> > umask and then calling into the vfs to handle the rest, so it's not much
> > different from any other user.  But the same reproducer run just on the
> > ext4 filesystem does give the right permissions....
> > 
> > Oh, but looking at the system call, fs_namei.c:do_mkdirat(), it does:
> > 
> > 	if (!IS_POSIXACL(path.dentry->d_inode))
> > 		mode &= ~current_umask();
> > 	error = security_path_mkdir(&path, dentry, mode);
> > 	if (!error)
> > 		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
> > 
> > whereas nfsd just calls into vfs_mkdir().
> > 
> > And that IS_POSIXACL() check is exactly a check whether the filesystem
> > supports ACLs.  So I guess it's the responsibility of the caller of
> > vfs_mkdir() to handle that case.
> 
> But, that's unsatisfying: why isn't vfs_mkdir() taking care of this
> itself?  And what about that security_path_mkdir() call?  And are the
> other cases of that switch in fs/nfsd/vfs.c:nfsd_create_locked()
> correct?  I think there may be some more cleanup here called for, I'll
> poke around tomorrow.

This might be unneeded to test but as additional datapoint which
confirms the suspect: I tried check the commit around 47057abde515
("nfsd: add support for the umask attribute") in 4.10-rc1

A kernel built with 47057abde515~1, and mounting from an enough recent
client which has at least dff25ddb4808 ("nfs: add support for the
umask attribute") does not show the observed behaviour, the server
built with 47057abde515 does.

Regards,
Salvatore
