Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4212FABF
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgACQrM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:47:12 -0500
Received: from fieldses.org ([173.255.197.46]:50554 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACQrM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Jan 2020 11:47:12 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id B7D8D1CB4; Fri,  3 Jan 2020 11:47:11 -0500 (EST)
Date:   Fri, 3 Jan 2020 11:47:11 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: CPU lockup in or near new filecache code
Message-ID: <20200103164711.GB24306@fieldses.org>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
 <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
 <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
 <A7C348BD-2543-492A-B768-7E3666734A57@oracle.com>
 <aa7857e4a9ac535e78353db53448efb1b58a57f9.camel@hammerspace.com>
 <980CB8E4-0E7F-4F1D-B223-81176BE15A39@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980CB8E4-0E7F-4F1D-B223-81176BE15A39@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 06:20:56PM -0500, Chuck Lever wrote:
> > On Dec 13, 2019, at 3:12 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > Does something like the following help?
> > 
> > 8<---------------------------------------------------
> > From caf515c82ed572e4f92ac8293e5da4818da0c6ce Mon Sep 17 00:00:00 2001
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Date: Fri, 13 Dec 2019 15:07:33 -0500
> > Subject: [PATCH] nfsd: Fix a soft lockup race in
> > nfsd_file_mark_find_or_create()
> > 
> > If nfsd_file_mark_find_or_create() keeps winning the race for the
> > nfsd_file_fsnotify_group->mark_mutex against nfsd_file_mark_put()
> > then it can soft lock up, since fsnotify_add_inode_mark() ends
> > up always finding an existing entry.
> > 
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > fs/nfsd/filecache.c | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 9c2b29e07975..f275c11c4e28 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -132,9 +132,13 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
> > 						 struct nfsd_file_mark,
> > 						 nfm_mark));
> > 			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
> > -			fsnotify_put_mark(mark);
> > -			if (likely(nfm))
> > +			if (nfm) {
> > +				fsnotify_put_mark(mark);
> > 				break;
> > +			}
> > +			/* Avoid soft lockup race with nfsd_file_mark_put() */
> > +			fsnotify_destroy_mark(mark, nfsd_file_fsnotify_group);
> > +			fsnotify_put_mark(mark);
> > 		} else
> > 			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
> > 
> 
> I've tried to reproduce the lockup for three days with this patch
> applied to my server. No lockup.
> 
> Tested-by: Chuck Lever <chuck.lever@oracle.com>

I'm applying this for 5.5 with Chuck's tested-by and:

    Fixes: 65294c1f2c5e "nfsd: add a new struct file caching facility to nfsd"

--b.
