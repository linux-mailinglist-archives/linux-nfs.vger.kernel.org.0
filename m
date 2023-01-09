Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0B662ADA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjAIQIW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 11:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjAIQIL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 11:08:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865DB39FBE
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 08:08:09 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so6193182pgc.2
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jan 2023 08:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcON4O9E6PHypx0iVlw8WuvyRrExp7EcgtZi4MxnN0Q=;
        b=BHm/LSVUkNqh/mqH5NGWMcLik0JbfLhLIDN5sT3GvP4MNq+kG5vCgQIh3NewBD7ACT
         42BF1Vgy8Rys2xcHz4JtTF7HF3jKaya/319CeYf5khZ5dVhhJrqYq97sFcOcSLUgrQBm
         /Z48ppfrPFN/qyuLoF4/4CPswqqqsijR2bUxAuybSOcqt/nJQ79j7pg9mJ1kIFy3Odob
         VsKzCyZLSRrwt0eLwV4UzS4VW5/gGMBvf0vbVgszv0M+pBwZRUI8dK0SXSfXYMLlaYrj
         D5J25WtvsUzNwd63MZTNer5DSgB9J9ugiBtk5esVbTq7bbvTsDgThUAPh3Huv5LF3oIQ
         p2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcON4O9E6PHypx0iVlw8WuvyRrExp7EcgtZi4MxnN0Q=;
        b=G6CSGSD1hfMZXgQOjpcwEz4L8VqIpekFJydIxHXdH70qTO8qqYEYJ/ks0PEM72xyaJ
         8ds/9rbltj42Babpasjf6B7gtKKBlb4HI0jdPhJnjn6IshLIQ+p9SWW3oU1uFrnjf99e
         GB8GcWgr/NCzYCG4BOPpUMj1MVHJR6TtsiV2rtNyhs7MKE/7BEDFy2XgkDWRTZlc8Wc6
         zN0rEyoktiLxTjYBIZExqbki5B4EXzgJwSGgkG5YKoEqYNvW4vOXqYuk+45bY+Q427Ne
         KnraWo2x1TQbFGS3bkrWZY4x7996ClFw+QEQBrbEW+PeISg76sg9epDRE1A5zzv4apss
         odRg==
X-Gm-Message-State: AFqh2koWNq/tjYutdkq5OUjq6rX1IcH3cLq+ZLn+UBFBuAr62T2EfGpk
        3xBOK6HxOelzN0NnALxZc9Y/UIhgZJ9By74Vhvc=
X-Google-Smtp-Source: AMrXdXvw/ztakPJSZzrFSvdaz5Ls0/9yZf7E6w6c0KRdQyNg1gej/xTfqhai7eyC9gtx7y5+a/wD0TRcro20sLywNS4=
X-Received: by 2002:a05:6a00:1d95:b0:583:2058:e4 with SMTP id
 z21-20020a056a001d9500b00583205800e4mr1208295pfw.42.1673280488939; Mon, 09
 Jan 2023 08:08:08 -0800 (PST)
MIME-Version: 1.0
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
 <167279837032.13974.12155714770736077636@noble.neil.brown.name>
 <167295936597.13974.7568769884598065471@noble.neil.brown.name>
 <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org>
 <167297692611.13974.5805041718280562542@noble.neil.brown.name>
 <CAN-5tyGRkKB-=9-HFXkDSu+--ghBNEfmfXO8yD7=2bo=aH4fhA@mail.gmail.com> <F3FEC918-730E-415A-AE9B-A713B0718015@hammerspace.com>
In-Reply-To: <F3FEC918-730E-415A-AE9B-A713B0718015@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Jan 2023 11:07:57 -0500
Message-ID: <CAN-5tyGFE0C-Y4k25oEwyeeNyzri+J7CnCHRTDkChSZdhV3pvw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 9, 2023 at 10:47 AM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
>
>
> > On Jan 9, 2023, at 10:33, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Thu, Jan 5, 2023 at 10:48 PM NeilBrown <neilb@suse.de> wrote:
> >>
> >> On Fri, 06 Jan 2023, Trond Myklebust wrote:
> >>> On Fri, 2023-01-06 at 09:56 +1100, NeilBrown wrote:
> >>>> On Wed, 04 Jan 2023, NeilBrown wrote:
> >>>>> On Wed, 04 Jan 2023, Trond Myklebust wrote:
> >>>>>> On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
> >>>>>>> On Wed, 04 Jan 2023, Trond Myklebust wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> If the server starts to reply NFS4ERR_STALE to GETATTR
> >>>>>>>> requests,
> >>>>>>>> why do
> >>>>>>>> we care about stateid values? Just mark the inode as stale
> >>>>>>>> and drop
> >>>>>>>> it
> >>>>>>>> on the floor.
> >>>>>>>
> >>>>>>> We have a valid state from the server - we really shouldn't
> >>>>>>> just
> >>>>>>> ignore
> >>>>>>> it.
> >>>>>>>
> >>>>>>> Maybe it would be OK to mark the inode stale.  I don't know if
> >>>>>>> various
> >>>>>>> retry loops abort properly when the inode is stale.
> >>>>>>
> >>>>>> Yes, they are all supposed to do that. Otherwise we would end up
> >>>>>> looping forever in close(), for instance, since the PUTFH,
> >>>>>> GETATTR and
> >>>>>> CLOSE can all return NFS4ERR_STALE as well.
> >>>>>
> >>>>> To mark the inode as STALE we still need to find the inode, and
> >>>>> that is
> >>>>> the key bit missing in the current code.  Once we find the inode,
> >>>>> we
> >>>>> could mark it stale, but maybe some other error resulted in the
> >>>>> missing
> >>>>> GETATTR...
> >>>>>
> >>>>> It might make sense to put the new code in _nfs4_proc_open() after
> >>>>> the
> >>>>> explicit nfs4_proc_getattr() fails.  We would need to find the
> >>>>> inode
> >>>>> given only the filehandle.  Is there any easy way to do that?
> >>>>>
> >>>>> Thanks,
> >>>>> NeilBrown
> >>>>>
> >>>>
> >>>> I couldn't see a consistent pattern to follow for when to mark an
> >>>> inode
> >>>> as stale.  Do this, on top of the previous patch, seem reasonable?
> >>>>
> >>>> Thanks,
> >>>> NeilBrown
> >>>>
> >>>>
> >>>>
> >>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>>> index b441b1d14a50..04497cb42154 100644
> >>>> --- a/fs/nfs/nfs4proc.c
> >>>> +++ b/fs/nfs/nfs4proc.c
> >>>> @@ -489,6 +489,8 @@ static int nfs4_do_handle_exception(struct
> >>>> nfs_server *server,
> >>>>                case -ESTALE:
> >>>>                        if (inode !=3D NULL && S_ISREG(inode->i_mode)=
)
> >>>>                                pnfs_destroy_layout(NFS_I(inode));
> >>>> +                       if (inode)
> >>>> +                               nfs_set_inode_stale(inode);
> >>>
> >>> This is normally dealt with in the generic code inside
> >>> nfs_revalidate_inode(). There should be no need to duplicate it here.
> >>>
> >>>>                        break;
> >>>>                case -NFS4ERR_DELEG_REVOKED:
> >>>>                case -NFS4ERR_ADMIN_REVOKED:
> >>>> @@ -2713,8 +2715,12 @@ static int _nfs4_proc_open(struct
> >>>> nfs4_opendata *data,
> >>>>                        return status;
> >>>>        }
> >>>>        if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
> >>>> +               struct inode *inode =3D nfs4_get_inode_by_stateid(
> >>>> +                       &data->o_res.stateid,
> >>>> +                       data->owner);
> >>>
> >>> There shouldn't be a need to go looking for open descriptors here,
> >>> because they will hit ESTALE at some point later anyway.
> >>
> >> The problem is that they don't hit ESTALE later.  Unless we update our
> >> stored stateid with the result of the OPEN, we can use the old stateid=
,
> >> and get the corresponding error.
> >>
> >> The only way to avoid the infinite loop is to either mark the inode as
> >> stale, or update the state-id.  For either of those we need to find th=
e
> >> inode.  We don't have fileid so we cannot use iget.  We do have file
> >> handle and state-id.
> >>
> >> Maybe you are saying this is a server bug that the client cannot be
> >> expect to cope with at all, and that an infinite loop is a valid clien=
t
> >> response to this particular server behaviour.  In that case, I guess n=
o
> >> patch is needed.
> >
> > I'm not arguing that the server should do something else. But I would
> > like to talk about it from the spec perspective. When PUTFH+WRITE is
> > sent to the server (with an incorrect stateid) and it's processing the
> > WRITE compound (as the spec doesn't require the server to validate a
> > filehandle on PUTFH. The spec says PUTFH is to "set" the correct
> > filehandle), the server is dealing with 2 errors that it can possibly
> > return to the client ERR_STALE and ERR_OLD_STATEID. There is nothing
> > in the spec that speaks to the orders of errors to be returned. Of
> > course I'd like to say that the server should prioritize ERR_STALE
> > over ERR_OLD_STATEID (simply because it's a MUST in the spec and
> > ERR_OLD_STATEIDs are written as "rules").
> >
>
> I disagree for the reason already pointed to in the spec. There is nothin=
g in the spec that appears to allow the PUTFH to return anything other than=
 NFS4ERR_STALE after the file has been deleted (and yes, RFC5661, Section 1=
5.2 does list NFS4ERR_STALE as an error for PUTFH). PUTFH is definitely req=
uired to validate the file handle, since it is the ONLY operation that can =
return NFS4ERR_BADHANDLE.

We are talking about 4.0 and not 4.1. In 4.0 all operations that use
PUTFH can return ERR_BADHANDLE.

>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
