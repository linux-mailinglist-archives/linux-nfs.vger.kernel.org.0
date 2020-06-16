Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2B1FA679
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 04:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFPCic (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 22:38:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgFPCic (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 22:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592275110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ahc0HMFIsAXaH53POcrbOHsyTruwRBsvXfgTCXkp9yg=;
        b=hDOPsl5AnTZjQTZFeZ9GQg7p/yc8tV8KDGfCI4lQ/aGSu7/U84BruZBLovcMnZIUImso91
        rbv2Po0iuyAJ39dc0C5yE+rsfW5FHp8KI/tO/bs1QKPOl+f0FeHhTJa/ZBLea1Y7Vm2eTW
        h0wEVm0dD9pkkmz2tB0SPpdkU+kvchM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-_vvftDzYN46ZDItgaY5PkQ-1; Mon, 15 Jun 2020 22:38:24 -0400
X-MC-Unique: _vvftDzYN46ZDItgaY5PkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E3FD108597C;
        Tue, 16 Jun 2020 02:38:22 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-200.rdu2.redhat.com [10.10.118.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B1C47B91C;
        Tue, 16 Jun 2020 02:38:22 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id D8E00120476; Mon, 15 Jun 2020 22:38:20 -0400 (EDT)
Date:   Mon, 15 Jun 2020 22:38:20 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200616023820.GB214986@pick.fieldses.org>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615185311.GA702681@eldamar.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the detailed reproducer.

It's weird, as the server is basically just setting the transmitted
umask and then calling into the vfs to handle the rest, so it's not much
different from any other user.  But the same reproducer run just on the
ext4 filesystem does give the right permissions....

Oh, but looking at the system call, fs_namei.c:do_mkdirat(), it does:

	if (!IS_POSIXACL(path.dentry->d_inode))
		mode &= ~current_umask();
	error = security_path_mkdir(&path, dentry, mode);
	if (!error)
		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);

whereas nfsd just calls into vfs_mkdir().

And that IS_POSIXACL() check is exactly a check whether the filesystem
supports ACLs.  So I guess it's the responsibility of the caller of
vfs_mkdir() to handle that case.

So the obvious fix is something like (untested!)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0aa02eb18bd3..dabdcca58969 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1234,6 +1234,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
+		if (!IS_POSIXACL(dirp))
+			iap->ia_mode &= ~current_umask();
 		host_err = vfs_mkdir(dirp, dchild, iap->ia_mode);
 		if (!host_err && unlikely(d_unhashed(dchild))) {
 			struct dentry *d;

--b.

