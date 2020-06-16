Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C11FA84B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 07:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFPFc2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jun 2020 01:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPFc1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jun 2020 01:32:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20182C05BD43
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 22:32:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so19322353wrv.4
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 22:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Knu4ideZRMRcliP1JPWy3sAJKLBQOzlQocufK0a3F/k=;
        b=H8mElah10jUn7qUcEb3rJ7KD/0+W+lZ8iaESXnO5RzTO96gcGc4BJtmtzdtI6pWFvW
         uWCFsELcHBnP9qMKUOMjj3lluSn4cEWPj2CH9F1ut7gW4ZQk3ZhNjq37ndG4qA+/5WN3
         Uhwz9yaxRgcBciR3SfCrzuUNAk1gNq9lHWUxjoxjKNnnkVxrmiE3dfGtoiuwaUt2Sot4
         KwScTM7vpUTgZDM9N1l/SJu8KiYweCavYGF7Hj1AyEgLRJwmJFH/rX6gOZONw9dqpcI+
         VFa9dMQEkIDL/kbfashMmlZ1rkY5NhmGMZSmaY7mLHqgfqqIndfP/E6MyP4CIulrsMod
         dReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Knu4ideZRMRcliP1JPWy3sAJKLBQOzlQocufK0a3F/k=;
        b=nm9mkMyYaWenCHoPdTugviudtJ959UmtCUknYq4elXyBg4w0/jssarutGeQmtbTTdG
         +us+g7DHEJQhGW667KdHuuW7NgSx1KEv7DtkDNSAP3DAnOJ7DPNBqBO1QIzwC/mBzD65
         /cBdtRm/5dtZHGpzlQ0oOMXTZ4PitKrp/I7IWNeSihb0U8fkX2RWJs1xDwrm6zxVKlCy
         JgNa9PB8y6Ufx/RogPQt18lpkLx+9CrNh5J4U2GHIV0KnIm4CYZqLOEFhIlu6NzBLERP
         JFmXRfCdXVKmrAdViPcZLlgSQNCweH9intNbs9VoCNYxMU2nKfLo2BUKZyIKjTe5xEaQ
         xFcw==
X-Gm-Message-State: AOAM531g7vOl7gJKfInmCwlDfLp1JufcJBjYNA8BuU0tHzEyMnxrLL2R
        gfKG/IW0N+B+mUl4yqYDido=
X-Google-Smtp-Source: ABdhPJwkrD5YSk7sld6dN+hscf9jBFnp/qbFb2asZ5BLLR9CPt6LU/yIKuzs2BIGNdjgjmk/RQmN/A==
X-Received: by 2002:adf:f790:: with SMTP id q16mr1095545wrp.399.1592285545844;
        Mon, 15 Jun 2020 22:32:25 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id h15sm25803739wrt.73.2020.06.15.22.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 22:32:24 -0700 (PDT)
Date:   Tue, 16 Jun 2020 07:32:24 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200616053224.GB19246@lorien.valinor.li>
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

Yes agreed and can confirm: The other cases in
fs/nfsd/vfs.c:nfsd_create_locked() seem to have the problem as well.

Regards,
Salvatore
