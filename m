Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE81FC31B
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFQA64 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jun 2020 20:58:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59165 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgFQA6z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jun 2020 20:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592355533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4FjgOY3V+tddBLTu/Nzckw0IlXGTmy1Bh2P8pPdHyY=;
        b=Sh3uMdR5E9NlWIUc1FkdRoZqbeN2W9H4D23JY6/BPPNKlKW0SiI9DvTSuYRIWGkObu/nrn
        h5Ct9HLkEvoNxxOjPBHQfKcl/rVNclJj7IHo/k6+LY4SjLYGRay+ODLKhawlG3zwh8Qnk9
        IwxgwLIV/5GFjVWV+bdNUJaycugRn34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-snoLt-6RPFKBzZPoznwNUA-1; Tue, 16 Jun 2020 20:58:52 -0400
X-MC-Unique: snoLt-6RPFKBzZPoznwNUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 024CB188361D;
        Wed, 17 Jun 2020 00:58:51 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-139.rdu2.redhat.com [10.10.118.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7363D7BA1A;
        Wed, 17 Jun 2020 00:58:50 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 8CDC5120476; Tue, 16 Jun 2020 20:58:49 -0400 (EDT)
Date:   Tue, 16 Jun 2020 20:58:49 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200617005849.GA262660@pick.fieldses.org>
References: <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
 <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616161658.GA17251@lorien.valinor.li>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 16, 2020 at 06:16:58PM +0200, Salvatore Bonaccorso wrote:
> This might be unneeded to test but as additional datapoint which
> confirms the suspect: I tried check the commit around 47057abde515
> ("nfsd: add support for the umask attribute") in 4.10-rc1
> 
> A kernel built with 47057abde515~1, and mounting from an enough recent
> client which has at least dff25ddb4808 ("nfs: add support for the
> umask attribute") does not show the observed behaviour, the server
> built with 47057abde515 does.

Thanks for the confirmation!

I think I'll send the following upstream.

--b.

commit 595ccdca9321
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue Jun 16 16:43:18 2020 -0400

    nfsd: apply umask on fs without ACL support
    
    The server is failing to apply the umask when creating new objects on
    filesystems without ACL support.
    
    To reproduce this, you need to use NFSv4.2 and a client and server
    recent enough to support umask, and you need to export a filesystem that
    lacks ACL support (for example, ext4 with the "noacl" mount option).
    
    Filesystems with ACL support are expected to take care of the umask
    themselves (usually by calling posix_acl_create).
    
    For filesystems without ACL support, this is up to the caller of
    vfs_create(), vfs_mknod(), or vfs_mkdir().
    
    Reported-by: Elliott Mitchell <ehem+debian@m5p.com>
    Reported-by: Salvatore Bonaccorso <carnil@debian.org>
    Fixes: 47057abde515 ("nfsd: add support for the umask attribute")
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0aa02eb18bd3..8fa3e0ff3671 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1225,6 +1225,9 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_mode = 0;
 	iap->ia_mode = (iap->ia_mode & S_IALLUGO) | type;
 
+	if (!IS_POSIXACL(dirp))
+		iap->ia_mode &= ~current_umask();
+
 	err = 0;
 	host_err = 0;
 	switch (type) {
@@ -1457,6 +1460,9 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
+	if (!IS_POSIXACL(dirp))
+		iap->ia_mode &= ~current_umask();
+
 	host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
 	if (host_err < 0) {
 		fh_drop_write(fhp);

