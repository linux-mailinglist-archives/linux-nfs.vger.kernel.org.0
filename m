Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698EB662A28
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjAIPht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 10:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjAIPhd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 10:37:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631F5688C
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 07:34:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so11559104pjb.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jan 2023 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbwbXqG5dMqZzDuRMtbnbs7dtkS0HbCKJyvmfu5GX+U=;
        b=AZ9XGolvgPSC6b+ka2s5590d9oTDrEcJxhIu4VgIsN2/BWCfZTdDWxR3limiiPhzwG
         UbhbYNeFjXC94whRFp4JGBrpsboIBQhu+7Nw1LBWQlIKAknp0oIx+LZCGpcRgv4DshOz
         OKv7aZVX3qDVZibxc5z8OMNK5triMWlphYckBaLLmX3ZtTZ75Oqfp6xmdjLgCMlgoUUv
         EUZqLp0H01UhY1Ve00lPs1WgwRLLE95RacsTcIOB9nUpJOEZeqYain2J4XF//wxZksiz
         mkM5z2J5A05meHpfQLQeuw4ybD/w24Dfs7Zf0V9XG0yaIlJdRAgOGXDSVFxwv/7Ifwmj
         +L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbwbXqG5dMqZzDuRMtbnbs7dtkS0HbCKJyvmfu5GX+U=;
        b=XJsCnYsnTv6+pEMg7u0Pp9XLxR6KWEMRJF+FJltFgtwH9bd+RIs+UOHubcCOn8LrvJ
         mEgggSmJVXliwbleRuzml39s9X5XRfbPytUz4gTAUqpXmJ0Z/oIjMua0Ske6uuvYYrBS
         0EzUr4/xv/QJ/LgMQyBOXCwqXxgK6b6FAqzF4pZr/pRpbJtRrmznXppJfpUap0G83aU0
         sbi6Sl7wxqw0HHXwYIGf0SCEbh09voBOcqXiMKghqz7D8Bwh+jmqURmS0ZKuXzH9G6NG
         wxdnpEjJcz2iyjx0osO190sdoRcZ/B7U/+y1Nayxa7MoAzGrUBika082mWwecWxyv6Jn
         +WkQ==
X-Gm-Message-State: AFqh2kre4Zo/yjnQjHHhVKI6TEHz3Q8bD+AoX8zu85pCpsfXTH5m4ene
        Vj5fHse2Qu9bMzH8msDTZPnTz+pA+902Ln+IDbS4UEHZ
X-Google-Smtp-Source: AMrXdXt4wUWkl7HlMRlvbCOOn+BBDaRERF/xU7Fo8aYZYC9w9OKAbgXAltcMfZd5f88RXnV1Zr63mEETCMrrPzzuTXE=
X-Received: by 2002:a17:903:2445:b0:189:7f09:13ca with SMTP id
 l5-20020a170903244500b001897f0913camr3494784pls.113.1673278449796; Mon, 09
 Jan 2023 07:34:09 -0800 (PST)
MIME-Version: 1.0
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
 <167279837032.13974.12155714770736077636@noble.neil.brown.name>
 <167295936597.13974.7568769884598065471@noble.neil.brown.name>
 <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org> <167297692611.13974.5805041718280562542@noble.neil.brown.name>
In-Reply-To: <167297692611.13974.5805041718280562542@noble.neil.brown.name>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Jan 2023 10:33:58 -0500
Message-ID: <CAN-5tyGRkKB-=9-HFXkDSu+--ghBNEfmfXO8yD7=2bo=aH4fhA@mail.gmail.com>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 5, 2023 at 10:48 PM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 06 Jan 2023, Trond Myklebust wrote:
> > On Fri, 2023-01-06 at 09:56 +1100, NeilBrown wrote:
> > > On Wed, 04 Jan 2023, NeilBrown wrote:
> > > > On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > > > > On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
> > > > > > On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > > > > > >
> > > > > > >
> > > > > > > If the server starts to reply NFS4ERR_STALE to GETATTR
> > > > > > > requests,
> > > > > > > why do
> > > > > > > we care about stateid values? Just mark the inode as stale
> > > > > > > and drop
> > > > > > > it
> > > > > > > on the floor.
> > > > > >
> > > > > > We have a valid state from the server - we really shouldn't
> > > > > > just
> > > > > > ignore
> > > > > > it.
> > > > > >
> > > > > > Maybe it would be OK to mark the inode stale.  I don't know if
> > > > > > various
> > > > > > retry loops abort properly when the inode is stale.
> > > > >
> > > > > Yes, they are all supposed to do that. Otherwise we would end up
> > > > > looping forever in close(), for instance, since the PUTFH,
> > > > > GETATTR and
> > > > > CLOSE can all return NFS4ERR_STALE as well.
> > > >
> > > > To mark the inode as STALE we still need to find the inode, and
> > > > that is
> > > > the key bit missing in the current code.  Once we find the inode,
> > > > we
> > > > could mark it stale, but maybe some other error resulted in the
> > > > missing
> > > > GETATTR...
> > > >
> > > > It might make sense to put the new code in _nfs4_proc_open() after
> > > > the
> > > > explicit nfs4_proc_getattr() fails.  We would need to find the
> > > > inode
> > > > given only the filehandle.  Is there any easy way to do that?
> > > >
> > > > Thanks,
> > > > NeilBrown
> > > >
> > >
> > > I couldn't see a consistent pattern to follow for when to mark an
> > > inode
> > > as stale.  Do this, on top of the previous patch, seem reasonable?
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > >
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index b441b1d14a50..04497cb42154 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -489,6 +489,8 @@ static int nfs4_do_handle_exception(struct
> > > nfs_server *server,
> > >                 case -ESTALE:
> > >                         if (inode != NULL && S_ISREG(inode->i_mode))
> > >                                 pnfs_destroy_layout(NFS_I(inode));
> > > +                       if (inode)
> > > +                               nfs_set_inode_stale(inode);
> >
> > This is normally dealt with in the generic code inside
> > nfs_revalidate_inode(). There should be no need to duplicate it here.
> >
> > >                         break;
> > >                 case -NFS4ERR_DELEG_REVOKED:
> > >                 case -NFS4ERR_ADMIN_REVOKED:
> > > @@ -2713,8 +2715,12 @@ static int _nfs4_proc_open(struct
> > > nfs4_opendata *data,
> > >                         return status;
> > >         }
> > >         if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
> > > +               struct inode *inode = nfs4_get_inode_by_stateid(
> > > +                       &data->o_res.stateid,
> > > +                       data->owner);
> >
> > There shouldn't be a need to go looking for open descriptors here,
> > because they will hit ESTALE at some point later anyway.
>
> The problem is that they don't hit ESTALE later.  Unless we update our
> stored stateid with the result of the OPEN, we can use the old stateid,
> and get the corresponding error.
>
> The only way to avoid the infinite loop is to either mark the inode as
> stale, or update the state-id.  For either of those we need to find the
> inode.  We don't have fileid so we cannot use iget.  We do have file
> handle and state-id.
>
> Maybe you are saying this is a server bug that the client cannot be
> expect to cope with at all, and that an infinite loop is a valid client
> response to this particular server behaviour.  In that case, I guess no
> patch is needed.

I'm not arguing that the server should do something else. But I would
like to talk about it from the spec perspective. When PUTFH+WRITE is
sent to the server (with an incorrect stateid) and it's processing the
WRITE compound (as the spec doesn't require the server to validate a
filehandle on PUTFH. The spec says PUTFH is to "set" the correct
filehandle), the server is dealing with 2 errors that it can possibly
return to the client ERR_STALE and ERR_OLD_STATEID. There is nothing
in the spec that speaks to the orders of errors to be returned. Of
course I'd like to say that the server should prioritize ERR_STALE
over ERR_OLD_STATEID (simply because it's a MUST in the spec and
ERR_OLD_STATEIDs are written as "rules").

>
> NeilBrown
>
>
> >
> > If we're going to change anything, I'd rather see us return -EACCES and
> > -ESTALE from the decode_access() and decode_getfattr() calls in
> > nfs4_xdr_dec_open() (and only those errors from those two calls!) so
> > that we can skip the unnecessary getattr call here.
> >
> > In fact, the only case that this extra getattr should be trying to
> > address is the one where the server returns NFS4ERR_DELAY to either the
> > decode_access() or the decode_getfattr() calls specifically, and where
> > we therefore don't want to replay the entire open call.
> >
> > >                 nfs4_sequence_free_slot(&o_res->seq_res);
> > > -               nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr,
> > > NULL);
> > > +               nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr,
> > > inode);
> > > +               iput(inode);
> > >         }
> > >         return 0;
> > >  }
> > > @@ -4335,6 +4341,7 @@ int nfs4_proc_getattr(struct nfs_server
> > > *server, struct nfs_fh *fhandle,
> > >  {
> > >         struct nfs4_exception exception = {
> > >                 .interruptible = true,
> > > +               .inode = inode,
> > >         };
> > >         int err;
> > >         do {
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
> >
