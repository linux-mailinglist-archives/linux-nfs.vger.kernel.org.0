Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B403122311C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 04:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgGQCSl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 22:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQCSl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 22:18:41 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F87CC061755
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jul 2020 19:18:41 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29943876B; Thu, 16 Jul 2020 22:18:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29943876B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594952320;
        bh=FF8xGhXdihJRg/RANv56NOq3A2gOF+667ZZgIQto4Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltSUwneR2/8BGyr9KfdFnBJw4JwFSEDbmqsjghva8eCPTe+Llz40X0uzPwM4UKStu
         u36Zb+kPq6EItPKQnmg+w7WBPVxzSlFHLj+S8oZPp35mrHeLL/TIbgiLl36ZiUwBPU
         XeVSWiI+tF1HzHtkSqjmLLjjp+kOsnNvj9G83g38=
Date:   Thu, 16 Jul 2020 22:18:40 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
Message-ID: <20200717021840.GD18568@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name>
 <20200529220608.GA22758@fieldses.org>
 <87a71n7dek.fsf@notabene.neil.brown.name>
 <20200715185456.GE15543@fieldses.org>
 <20200716171958.GB18568@fieldses.org>
 <87tuy7vxeb.fsf@notabene.neil.brown.name>
 <20200717010301.GC18568@fieldses.org>
 <87r1tbvsey.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1tbvsey.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 17, 2020 at 11:31:17AM +1000, NeilBrown wrote:
> On Thu, Jul 16 2020, J. Bruce Fields wrote:
> 
> > On Fri, Jul 17, 2020 at 09:43:40AM +1000, NeilBrown wrote:
> >> On Thu, Jul 16 2020, J. Bruce Fields wrote:
> >> > --- a/fs/nfsd/nfs4state.c
> >> > +++ b/fs/nfsd/nfs4state.c
> >> > @@ -507,6 +507,16 @@ find_any_file(struct nfs4_file *f)
> >> >  	return ret;
> >> >  }
> >> >  
> >> > +static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
> >> > +{
> >> > +	struct nfsd_file *ret;
> >> > +
> >> > +	spin_lock(&f->fi_lock);
> >> > +	ret = nfsd_file_get(f->fi_deleg_file);
> >> 
> >> A test on f->fi_deleg_file being non-NULL would make this look safer.
> >> It would  also make the subsequent test on the return value appear sane.
> >
> > Yes, thanks!-b.
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c2a2e56c896d..6e8811e7c134 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -509,10 +509,11 @@ find_any_file(struct nfs4_file *f)
> >  
> >  static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
> >  {
> > -	struct nfsd_file *ret;
> > +	struct nfsd_file *ret = NULL;
> >  
> >  	spin_lock(&f->fi_lock);
> > -	ret = nfsd_file_get(f->fi_deleg_file);
> > +	if (f->fi_deleg_file)
> > +		ret = nfsd_file_get(f->fi_deleg_file);
> >  	spin_unlock(&f->fi_lock);
> >  	return ret;
> >  }
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> 
> for the whole patch.

Thanks!--b.
