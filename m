Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683AC3A6F25
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhFNTgO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhFNTgN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 15:36:13 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BBC061574
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 12:34:10 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CB1FB6210; Mon, 14 Jun 2021 15:34:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CB1FB6210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623699249;
        bh=No9VxRYI9052kbIk228uZZ117l660NzZsKZ7GmuRCFc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=i2YoLaTmQlzbuil1+xEre2LgiG5S5fEdY7sGDUmEtDqCE2Pl6zrplHwHRgv2F51u7
         sITpQnaK4Hybv/5Z2Fn8Y7W5z6jckG4AW0rX4BihvrLSBMfTKol6KcyITfT6OXhgIf
         ZcslyoEzCOtORNrL12TK9aYNcOJoidiKlGn9SGRw=
Date:   Mon, 14 Jun 2021 15:34:09 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [PATCH 3/3] nfs: don't allow reexport reclaims
Message-ID: <20210614193409.GA16500@fieldses.org>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
 <1623682098-13236-4-git-send-email-bfields@redhat.com>
 <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 14, 2021 at 02:56:55PM +0000, Trond Myklebust wrote:
> On Mon, 2021-06-14 at 10:48 -0400, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > In the reexport case, nfsd is currently passing along locks with the
> > reclaim bit set.  The client sends a new lock request, which is
> > granted
> > if there's currently no conflict--even if it's possible a conflicting
> > lock could have been briefly held in the interim.
> > 
> > We don't currently have any way to safely grant reclaim, so for now
> > let's just deny them all.
> > 
> > I'm doing this by passing the reclaim bit to nfs and letting it fail
> > the
> > call, with the idea that eventually the client might be able to do
> > something more forgiving here.
> > 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  fs/nfs/file.c       | 3 +++
> >  fs/nfsd/nfs4state.c | 3 +++
> >  fs/nfsd/nfsproc.c   | 1 +
> >  include/linux/fs.h  | 1 +
> >  4 files changed, 8 insertions(+)
> > 
> > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > index 1fef107961bc..35a29b440e3e 100644
> > --- a/fs/nfs/file.c
> > +++ b/fs/nfs/file.c
> > @@ -806,6 +806,9 @@ int nfs_lock(struct file *filp, int cmd, struct
> > file_lock *fl)
> >  
> >         nfs_inc_stats(inode, NFSIOS_VFSLOCK);
> >  
> > +       if (fl->fl_flags & FL_RECLAIM)
> > +               return -NFSERR_NO_GRACE;
> 
> NACK. nfs_lock() is required to return a POSIX error. I know that right
> now, nfsd is the only thing setting FL_RECLAIM, but we can't guarantee
> that will always be the case.

Setting FL_RECLAIM tells the filesystem that you're prepared to handle
NFSERR_NO_GRACE.  I'm not seeing the risk.

--b.

> >         /* No mandatory locks over NFS */
> >         if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
> >                 goto out_err;
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 00d98bbab2a6..3ef42c0d5d38 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6903,6 +6903,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >         if (!locks_in_grace(net) && lock->lk_reclaim)
> >                 goto out;
> >  
> > +       if (lock->lk_reclaim)
> > +               fl_flags |= FL_RECLAIM;
> > +
> >         fp = lock_stp->st_stid.sc_file;
> >         switch (lock->lk_type) {
> >                 case NFS4_READW_LT:
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 60d7c59e7935..80c430c37ab7 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -881,6 +881,7 @@ nfserrno (int errno)
> >                 { nfserr_serverfault, -ENFILE },
> >                 { nfserr_io, -EUCLEAN },
> >                 { nfserr_perm, -ENOKEY },
> > +               { nfserr_no_grace, -NFSERR_NO_GRACE},
> >         };
> >         int     i;
> >  
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c3c88fdb9b2a..9be479999109 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -997,6 +997,7 @@ static inline struct file *get_file(struct file
> > *f)
> >  #define FL_UNLOCK_PENDING      512 /* Lease is being broken */
> >  #define FL_OFDLCK      1024    /* lock is "owned" by struct file */
> >  #define FL_LAYOUT      2048    /* outstanding pNFS layout */
> > +#define FL_RECLAIM     4096    /* reclaiming from a reboot server */
> >  
> >  #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> >  
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
