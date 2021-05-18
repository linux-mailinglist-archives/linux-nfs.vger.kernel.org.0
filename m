Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27499387E51
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbhERRWY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbhERRWY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:22:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E02C061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:21:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A6A0B6482; Tue, 18 May 2021 13:21:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A6A0B6482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621358465;
        bh=qemZtxHyCqBsslfbd/xHx/5PLnGgVJ/G6KqnpLrL2v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnD+Q76a/mzya7LawviGWAVMjUgd2jYdjmVxFma4fLuVzU2OhXcLga9eRCnXqFKq8
         CNxstftbqUlKNv9Na9fc+LOMlkauQhqNeSz+Aqhgxl6HsUUfQq3vGktCvU1uu/d9NE
         oBkbimH6rpBzgkFXrYHd9++g82cx8rYMpGqSk2aY=
Date:   Tue, 18 May 2021 13:21:05 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org,
        trondmy@hammerspace.com, chuck.lever@oracle.com
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
Message-ID: <20210518172105.GB25205@fieldses.org>
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <20210518170456.GA25205@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518170456.GA25205@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 18, 2021 at 01:04:56PM -0400, J. Bruce Fields wrote:
> On Mon, May 17, 2021 at 06:43:29PM -0400, Dai Ngo wrote:
> > +struct nfsd4_ssc_umount;
> >  
> >  enum {
> >  	/* cache misses due only to checksum comparison failures */
> > @@ -176,6 +177,10 @@ struct nfsd_net {
> >  	unsigned int             longest_chain_cachesize;
> >  
> >  	struct shrinker		nfsd_reply_cache_shrinker;
> > +
> > +	spinlock_t              nfsd_ssc_lock;
> > +	struct nfsd4_ssc_umount	*nfsd_ssc_umount;
> ...
> 
> > +void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
> > +{
> > +	nn->nfsd_ssc_umount = kzalloc(sizeof(struct nfsd4_ssc_umount),
> > +					GFP_KERNEL);
> > +	if (!nn->nfsd_ssc_umount)
> > +		return;
> 
> Is there any reason this needs to be allocated dynamically?  Let's just
> embed it in nfsd_net.
> 
> Actually, I'm not convinced the separate structure definition's really
> that helpful:
> 
> > +struct nfsd4_ssc_umount {
> > +	struct list_head nsu_list;
> > +	unsigned long nsu_expire;

Also: doesn't look like nsu_expire is actually used.  Am I missing
something, or is this a leftover from the conversion to the using the
laundromat thread?

--b.

> > +	wait_queue_head_t nsu_waitq;
> > +};
> 
> How about just:
> 
> 	struct nfsd_net {
> 	...
> 	/* tracking server-to-server copy mounts: */
> 	spinlock_t		nfsd_ssc_lock;
> 	struct list_head	nfsd_ssc_mount_list;
> 	unsigned long		nfsd_ssc_mount_expire;
> 	wait_queeu_head_t	nfsd_ssc_mount_waitq;
> 
> or something along those lines?
> 
> --b.
