Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D391FA67F
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 04:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFPCmS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 22:42:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgFPCmS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 22:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592275337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuL3S3uOf3SoFRqVHBGN1+EkozcHXriR0GzHlci2TC8=;
        b=J6f5Lz+Ud6sI9mFoM9x6J0LQEHAfKPNAvumsgChKziP3wEL4TT/B/D1w1+Hm8v1p6GEWTZ
        5iN4/3qGUfR1z6G/C1/d6/DL4kt9YZIdmX1oRrx8JqPkU2G6YT9fM3uMlqaZ3+MCu5bJPx
        PyFua5I36BIvGS8nZ0etDjaGbe0nnDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-yQgfCwFbM-mTgCByinuOGQ-1; Mon, 15 Jun 2020 22:42:15 -0400
X-MC-Unique: yQgfCwFbM-mTgCByinuOGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4401F106B247;
        Tue, 16 Jun 2020 02:42:14 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-200.rdu2.redhat.com [10.10.118.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B1F10013D6;
        Tue, 16 Jun 2020 02:42:14 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id DD405120476; Mon, 15 Jun 2020 22:42:12 -0400 (EDT)
Date:   Mon, 15 Jun 2020 22:42:12 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200616024212.GC214986@pick.fieldses.org>
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
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

But, that's unsatisfying: why isn't vfs_mkdir() taking care of this
itself?  And what about that security_path_mkdir() call?  And are the
other cases of that switch in fs/nfsd/vfs.c:nfsd_create_locked()
correct?  I think there may be some more cleanup here called for, I'll
poke around tomorrow.

--b.

