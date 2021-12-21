Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81F47C778
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhLUTaZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 14:30:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52856 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhLUTaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 14:30:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BLJUHFP013270;
        Tue, 21 Dec 2021 13:30:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640115017;
        bh=B4Yj4yn4A62JZcWRlSdyKAE4ZT+8oK27mXNOKhX1i8Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QNESs7oq6lGgVceddojrbxS+b5nc99pmB82fqKDc1WsAsw1ZWdq0KTTr/Vk8nld/K
         21kL3yWaWkVTdKe0WSh3F7rdikTj5K+Fyh0md/Zb90hawY+G2qbfXFtRaR9vK6qejW
         VcnghCmkAud5Dvi2jbQHndGSTJ1RGsduyMCMzaGU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BLJUHsn106077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 13:30:17 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 13:30:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 13:30:17 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BLJUGr5050821;
        Tue, 21 Dec 2021 13:30:17 -0600
Date:   Wed, 22 Dec 2021 01:00:16 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Vasily Averin <vvs@virtuozzo.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] nfs: block notification on fs with its own ->lock
Message-ID: <20211221193014.jhevqtqcptzwcsnh@ti.com>
References: <20211216172013.GA13418@fieldses.org>
 <bb7b5a71-6ddf-5e22-e555-8ae22e5930fe@virtuozzo.com>
 <0C441CAE-06B6-4CC0-8A52-88957DCF76EF@oracle.com>
 <20211221113139.6to2hact5qfa2sbd@ti.com>
 <DB085542-1ADB-470D-A76F-980C595AC393@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DB085542-1ADB-470D-A76F-980C595AC393@oracle.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21/12/21 03:13PM, Chuck Lever III wrote:
> 
> 
> > On Dec 21, 2021, at 6:31 AM, Pratyush Yadav <p.yadav@ti.com> wrote:
> > 
> > Hi,
> > 
> > On 17/12/21 04:11PM, Chuck Lever III wrote:
> >> 
> >>> On Dec 17, 2021, at 1:41 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
> >>> 
> >>> On 16.12.2021 20:20, J. Bruce Fields wrote:
> >>>> From: "J. Bruce Fields" <bfields@redhat.com>
> >>>> 
> >>>> NFSv4.1 supports an optional lock notification feature which notifies
> >>>> the client when a lock comes available.  (Normally NFSv4 clients just
> >>>> poll for locks if necessary.)  To make that work, we need to request a
> >>>> blocking lock from the filesystem.
> >>>> 
> >>>> We turned that off for NFS in f657f8eef3ff "nfs: don't atempt blocking
> >>>> locks on nfs reexports" because it actually blocks the nfsd thread while
> >>>> waiting for the lock.
> >>>> 
> >>>> Thanks to Vasily Averin for pointing out that NFS isn't the only
> >>>> filesystem with that problem.
> >>>> 
> >>>> Any filesystem that leaves ->lock NULL will use posix_lock_file(), which
> >>>> does the right thing.  Simplest is just to assume that any filesystem
> >>>> that defines its own ->lock is not safe to request a blocking lock from.
> >>>> 
> >>>> So, this patch mostly reverts f657f8eef3ff and b840be2f00c0, and instead
> >>>> uses a check of ->lock (Vasily's suggestion) to decide whether to
> >>>> support blocking lock notifications on a given filesystem.  Also add a
> >>>> little documentation.
> >>>> 
> >>>> Perhaps someday we could add back an export flag later to allow
> >>>> filesystems with "good" ->lock methods to support blocking lock
> >>>> notifications.
> >>>> 
> >>>> Reported-by: Vasily Averin <vvs@virtuozzo.com>
> >>>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >>> 
> >>> Reviewed-by: Vasily  Averin <vvs@virtuozzo.com>
> >> 
> >> I've applied this with Vasily's R-b to for-next at
> >> 
> >> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >> 
> >> I also cleaned up some checkpatch nits in the patch description.
> >> 
> >> It might be good for subsequent work in this area to be based
> >> on the for-next branch so we can track what is done and what
> >> is left to do.
> > 
> > This patch breaks LLVM build on linux-next for me:
> > 
> > fs/lockd/svclock.c:474:17: error: unused variable 'inode' [-Werror,-Wunused-variable]
> >        struct inode            *inode = nlmsvc_file_inode(file);
> > 
> > This is because now the only user of inode is the dprintk() call, and 
> > this is probably a noop when debug is disabled. I think you should wrap 
> > the declaration of inode under the same debug symbol used to select 
> > dprintk(). My LSP (ccls) is getting confused and can't point out where 
> > exactly this macro is declared, so I am not sure which symbol controls 
> > it (CONFIG_DEBUG? CONFIG_NFS_DEBUG?).
> 
> I updated this patch in my for-next tree yesterday to take care of
> the issue. The change has been merged into today's linux-next.

Thanks. I updated to today's linux-next and I no longer see this error. 
The build still fails though, this time on some firmware driver. I'll go 
bother their maintainers about it now ;-)

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
