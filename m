Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC092F3233
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhALNvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbhALNvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 08:51:32 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1FC061575
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jan 2021 05:50:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EF2BB6E9F; Tue, 12 Jan 2021 08:50:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EF2BB6E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610459450;
        bh=RQfDpDvEmhL2tyyGtyX4ECa4voBz+GNiPsPxJ99buS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zfa4fM+JIhlbr7UfU5MuV+I0sNlEbUJ41P7LbuG+18xpWyYyC+SidNHnUynAy8TNe
         z23b7UZbEogzEvqwnA6jG+DAnDenoNoYgfzruMIJLf+RWgAYH6npLe9/9OErhjQJhv
         u+dgT2YLKVh76cvbye6O9btOm831l9UYUT41AQ4o=
Date:   Tue, 12 Jan 2021 08:50:50 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     =?utf-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd4: readdirplus shouldn't return parent of export
Message-ID: <20210112135050.GA9248@fieldses.org>
References: <20210108152017.GA4183@fieldses.org>
 <CAHxDmpSp1LHzKD5uqbfi+jcnb+nFaAZbc5++E0oOvLsYvyYDpw@mail.gmail.com>
 <20210108164433.GB8699@fieldses.org>
 <CAHxDmpSjwrcr_fqLJa5=Zo=xmbt2Eo9dcy6TQuoU8+F3yVVNhw@mail.gmail.com>
 <20210110201740.GA8789@fieldses.org>
 <20210110202815.GB8789@fieldses.org>
 <CAHxDmpR8S7NR8OU2nWJmWBdFU9a7wDuDnxviQ2E9RDOeW9fExg@mail.gmail.com>
 <20210111192507.GB2600@fieldses.org>
 <20210111210129.GA11652@fieldses.org>
 <BF0A932D-82D7-4698-9BA6-2B5B709E7AE3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF0A932D-82D7-4698-9BA6-2B5B709E7AE3@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 12, 2021 at 08:31:59AM -0500, Chuck Lever wrote:
> 
> 
> > On Jan 11, 2021, at 4:01 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > If you export a subdirectory of a filesystem, a READDIRPLUS on the root
> > of that export will return the filehandle of the parent with the ".."
> > entry.
> > 
> > The filehandle is optional, so let's just not return the filehandle for
> > ".." if we're at the root of an export.
> > 
> > Note that once the client learns one filehandle outside of the export,
> > they can trivially access the rest of the export using further lookups.
> > 
> > However, it is also not very difficult to guess filehandles outside of
> > the export.  So exporting a subdirectory of a filesystem should
> > considered equivalent to providing access to the entire filesystem.  To
> > avoid confusion, we recommend only exporting entire filesystems.
> > 
> > Reported-by: 吴异 <wangzhibei1999@gmail.com>
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/nfsd/nfs3xdr.c | 7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> > index 821db21ba072..34b880211e5e 100644
> > --- a/fs/nfsd/nfs3xdr.c
> > +++ b/fs/nfsd/nfs3xdr.c
> > @@ -865,9 +865,14 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
> > 	if (isdotent(name, namlen)) {
> > 		if (namlen == 2) {
> > 			dchild = dget_parent(dparent);
> > -			/* filesystem root - cannot return filehandle for ".." */
> > +			/*
> > +			 * Don't return filehandle for ".." if we're at
> > OA+			 * the filesystem or export root:
> > +			 */
> > 			if (dchild == dparent)
> > 				goto out;
> > +			if (dparent == exp->ex_path.dentry)
> > +				goto out;
> > 		} else
> > 			dchild = dget(dparent);
> > 	} else
> > -- 
> > 2.29.2
> 
> Thanks for the fix!
> 
> I've replaced the Reported-by: tag and pushed this to my
> cel-next topic branch, and intend to submit it with the
> next 5.11 -rc pull request. See:
> 
> https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/cel-next
> 
> Is there additional context that should be added? A Link:
> tag that points to the discussion on security@ perhaps?

I don't think so.

I guess it should get a stable cc: too.

> Note there was some damage in the patch body: there's a
> spurious "OA" in the hunk that had to be removed before
> the patch would apply.

Whoops, apologies, I'm not sure how that happened....

--b.
