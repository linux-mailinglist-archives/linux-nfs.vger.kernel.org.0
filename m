Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2B5D3EB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2019 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBQLN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jul 2019 12:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBQLN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 12:11:13 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F287A206A3;
        Tue,  2 Jul 2019 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562083872;
        bh=B7TU3KpnJp6N2CWZAHKYxNh4/caQ3a1ROtEaQlXizKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9pL4EhyJhHsgxlBa9qldWZSzPJDISXNWuB8ks9WXr3YvniwSKflmtKYrA4JCtPT3
         Q6VTtVBRHUXxMed+CA0q/5J4+OVtbsKa2uX7K56Z8Rr5QrponWnVwGxeJmduKuHfim
         rLKJcFjlEHgxu/5He4eUrDnacirOMB995rwWeOIk=
Date:   Tue, 2 Jul 2019 09:11:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     syzbot <syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com>,
        anna.schumaker@netapp.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Subject: Re: memory leak in nfs_get_client
Message-ID: <20190702161110.GD895@sol.localdomain>
References: <000000000000f8a345058b046657@google.com>
 <223AB0C9-D93E-4D3C-BBBB-4AF40D8EA436@redhat.com>
 <20190702063140.GE3054@sol.localdomain>
 <13A4AF36-1649-41C0-A789-DC35853D2FB1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13A4AF36-1649-41C0-A789-DC35853D2FB1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 02, 2019 at 07:23:32AM -0400, Benjamin Coddington wrote:
> On 2 Jul 2019, at 2:31, Eric Biggers wrote:
> 
> > On Tue, Jun 11, 2019 at 12:23:12PM -0400, Benjamin Coddington wrote:
> > > Ugh.. Now that you can cancel the wait, you have to also handle if
> > > "new" was
> > > allocated.  I think this needs:
> > > 
> > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > index d7e4f0848e28..4d90f5bf0b0a 100644
> > > --- a/fs/nfs/client.c
> > > +++ b/fs/nfs/client.c
> > > @@ -406,10 +406,10 @@ struct nfs_client *nfs_get_client(const struct
> > > nfs_client_initdata *cl_init)
> > >                 clp = nfs_match_client(cl_init);
> > >                 if (clp) {
> > >                         spin_unlock(&nn->nfs_client_lock);
> > > -                       if (IS_ERR(clp))
> > > -                               return clp;
> > >                         if (new)
> > >                                 new->rpc_ops->free_client(new);
> > > +                       if (IS_ERR(clp))
> > > +                               return clp;
> > >                         return nfs_found_client(cl_init, clp);
> > >                 }
> > >                 if (new) {
> > > 
> > > I'll patch/test and send it along.
> > > 
> > > Ben
> > 
> > Hi Ben, what happened to this patch?
> 
> I sent it along:
> 
> https://lore.kernel.org/linux-nfs/65b675cec79d140df64bc30def88b1def32bf87e.1560272160.git.bcodding@redhat.com/
> 
> I don't think it will go in 5.2.. it's not a huge problem.
> 
> Ben

Okay, great.  I didn't see it in linux-next and there was no further reply to
this thread, which usually (having seen it happen on lots of syzbot bugs) means
the person forgot about it.

Tip: you can use the '--in-reply-to=<MESSAGE_ID>' option to 'git send-email' or
'git format-patch' to send the patch in response to the original thread, which
makes it very easy to see that a patch was actually sent out.

- Eric
