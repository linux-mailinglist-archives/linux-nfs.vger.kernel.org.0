Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E60221893
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGOXne (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 19:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgGOXnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 19:43:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA36FC061755
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 16:43:33 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B07E8877C; Wed, 15 Jul 2020 19:43:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B07E8877C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594856612;
        bh=ZHdP5JKkCgNet/O0weEugsbSOJBdgobTos2ial8jbKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwdH/j/4X7yBpdYLJ8XThNRczWTepv782aJteF+uBjPc9dL4hZniumLJp05poWNob
         SOTOkmdoD+IFJz1zcmfJxVDYTBlUfv8wfE48TB5m/b3OXURPREHG9/CC1dPB9hMWbT
         f0olHYegMau1GhFLS8gweK2Pf+IrzrBe9eLXFTUo=
Date:   Wed, 15 Jul 2020 19:43:32 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
Message-ID: <20200715234332.GG15543@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name>
 <20200529220608.GA22758@fieldses.org>
 <87a71n7dek.fsf@notabene.neil.brown.name>
 <20200715185456.GE15543@fieldses.org>
 <87k0z4xtto.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0z4xtto.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 16, 2020 at 09:05:39AM +1000, NeilBrown wrote:
> On Wed, Jul 15 2020, J. Bruce Fields wrote:
> 
> > On Mon, Jun 01, 2020 at 12:01:07PM +1000, NeilBrown wrote:
> >> On Fri, May 29 2020, J. Bruce Fields wrote:
> >> 
> >> > On Fri, May 29, 2020 at 10:53:15AM +1000, NeilBrown wrote:
> >> >>  I've received a report of a 5.3 kernel crashing in
> >> >>  nfs4_show_superblock().
> >> >>  I was part way through preparing a patch when I concluded that
> >> >>  the problem wasn't as straight forward as I thought.
> >> >>
> >> >>  In the crash, the 'struct file *' passed to nfs4_show_superblock()
> >> >>  was NULL.
> >> >>  This file was acquired from find_any_file(), and every other caller
> >> >>  of find_any_file() checks that the returned value is not NULL (though
> >> >>  one BUGs if it is NULL - another WARNs).
> >> >>  But nfs4_show_open() and nfs4_show_lock() don't.
> >> >>  Maybe they should.  I didn't double check, but I suspect they don't
> >> >>  hold enough locks to ensure that the files don't get removed.
> >> >
> >> > I think the only lock held is cl_lock, acquired in states_start.
> >> >
> >> > We're starting here with an nfs4_stid that was found in the cl_stateids
> >> > idr.
> >> >
> >> > A struct nfs4_stid is freed by nfs4_put_stid(), which removes it from
> >> > that idr under cl_lock before freeing the nfs4_stid and anything it
> >> > points to.
> >> >
> >> > I think that was the theory....
> >> >
> >> > One possible problem is downgrades, like nfs4_stateid_downgrade.
> >> >
> >> > I'll keep mulling it over, thanks.
> >> 
> >
> > Oops, I neglected this a while....
> >
> >> I had another look at code and maybe move_to_close_lru() is the problem.
> >> It can clear remove the files and clear sc_file without taking
> >> cl_lock.  So some protection is needed against that.
> >> 
> >> I think that only applies to nfs4_show_open() - not show_lock etc.
> >> But I wonder it is might be best to include some extra protection
> >> for each different case, just in case some future code change
> >> allow sc_file to become NULL before the state is detached.
> >> 
> >> I'd feel more comforatable about nfs4_show_superblock() if it ignored
> >> nf_inode and just used nf_file - it is isn't NULL.  It looks like it
> >> can never be set from non-NULL to NULL.
> >
> > But then that means we've always got a reference on the inode, doesn't
> > it?  So I still don't understand the nf_inode comment.
> 
> My main problem with nf_inode is the comment
> 
> /*
>  * A representation of a file that has been opened by knfsd. These are hashed
>  * in the hashtable by inode pointer value. Note that this object doesn't
>  * hold a reference to the inode by itself, so the nf_inode pointer should
>  * never be dereferenced, only used for comparison.
>  */
> 
> That comment is incompatible with the code in
> nfsd_file_mark_find_or_create() and with the code in
> nfs4_show_superblock().

Yeah, understood.  I'm inclined to think the comment's just wrong, but
not sure enough to be comfortable deleting it yet....

--b.

> 
> >
> > So maybe the NULL checks are mainly all we need.
> >
> > Also it looks to me like ls_file lasts as long as the layout stateid, so
> > maybe it's OK.
> >
> > --b.
> >
> > commit 4eef57aa4fc0
> > Author: J. Bruce Fields <bfields@redhat.com>
> > Date:   Wed Jul 15 13:31:36 2020 -0400
> >
> >     nfsd4: fix NULL dereference in nfsd/clients display code
> >     
> >     Reported-by: NeilBrown <neilb@suse.de>
> >     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ab5c8857ae5a..08b8376c74d7 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -507,6 +507,16 @@ find_any_file(struct nfs4_file *f)
> >  	return ret;
> >  }
> >  
> > +static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
> > +{
> > +	struct nfsd_file *ret;
> > +
> > +	spin_lock(&f->fi_lock);
> > +	ret = nfsd_file_get(f->fi_deleg_file);
> > +	spin_unlock(&f->fi_lock);
> > +	return ret;
> > +}
> > +
> >  static atomic_long_t num_delegations;
> >  unsigned long max_delegations;
> >  
> > @@ -2444,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
> >  	oo = ols->st_stateowner;
> >  	nf = st->sc_file;
> >  	file = find_any_file(nf);
> > +	if (!file)
> > +		return 0;
> >  
> >  	seq_printf(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> > @@ -2481,6 +2493,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
> >  	oo = ols->st_stateowner;
> >  	nf = st->sc_file;
> >  	file = find_any_file(nf);
> > +	if (!file)
> > +		return 0;
> >  
> >  	seq_printf(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> > @@ -2513,7 +2527,9 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
> >  
> >  	ds = delegstateid(st);
> >  	nf = st->sc_file;
> > -	file = nf->fi_deleg_file;
> > +	file = find_deleg_file(nf);
> > +	if (!file)
> > +		return 0;
> >  
> >  	seq_printf(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> 
> You'll need to add nfsd_file_put(file) toward the end of this function.
> Otherwise, I think this patch is a step in the right direction.
> 
> Thanks,
> NeilBrown


