Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1478F3C0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHaUI5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHaUI4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 16:08:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFC5E5C
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 13:08:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26d5970cd28so926196a91.2
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693512532; x=1694117332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOxiQHnQn4KrtUcHRiuQl9E5adLkrnqfMUgTMKPa4vg=;
        b=CKkDLkFJDT1oMqtsiMYSvyujTM0eq9PKkPZbkK2d3z6alC0eAIidZgUoRikiepR3dK
         0DfoWOsnOirWcgBmbPO7lU5x9CcmBV6XTlTeni0vFluT+0NoVZbbB2nKaCBJa/HXmuP4
         jWBqrZO1ogLuHYVNjXHpOXo6S++27fgGsvf66++X/NtfmE0OHUjTBl4hY6Fo2rByx7zU
         /st1c82qlKyS6G/ipXSOPgUgExTrzYBMB1l5PiS+XWWAtgyLHp2pXyIIMQl6kkH+PIpe
         rEghYgYQuoMNwoFWgZ0bqUndhVoXwHweZQfWA6xO8jDzmnQO1RmeceUDONBDrAx4swz9
         tfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693512532; x=1694117332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOxiQHnQn4KrtUcHRiuQl9E5adLkrnqfMUgTMKPa4vg=;
        b=PjhAW5lgTsdoncehJ3Z/dIRmB5P2TrI2vLKP34bu0E7KyRoNYIsutqfRRnU7RWF0eS
         hdnAZtqrGQLb4RMRLW4fqhrH4ccaMnQU9H7YII4ZqC2YrkhqHTyWisBMTnTuIKvv+Id6
         Q6nFRToE85Hf/86MDS90m7nzdrHVb0+Rgh/dyLqwEr51F1rK8kP3dNd02/a4A7IReyd0
         DZsRYi65as2v4gBwtYfc9jYbI12Z4plCHCQEqkmo+bebuE71W+R5vsh1+M+1l+6PINhJ
         N5YZ0+6jMQka5xVjALi8fuGhpPhzTl+9hH2iv/utQMjEj15uDFDo7qS6B1SYjowgBuGX
         KUyA==
X-Gm-Message-State: AOJu0YzCvXbT4g0B2UnqpvvPLBdCycNo8iG7Yq9lMxIsrPJscMF3YY0E
        G/485AYePEchYLpXRd8EURtoPfTSt3d8quChqdmvIAxlhw==
X-Google-Smtp-Source: AGHT+IEapPdUnY6qHD0EQdSuMHjC8HuSkkX4l3RzNVnDvNoAewjK9C0BQ4Iq3mAlsdj+RtFUe4oPaoOe0paD/Lm2PQw=
X-Received: by 2002:a17:90a:9ab:b0:273:4b39:e5b9 with SMTP id
 40-20020a17090a09ab00b002734b39e5b9mr421785pjo.4.1693512532313; Thu, 31 Aug
 2023 13:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
 <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
 <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
 <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
 <CALXu0UekEaGhj6+CHEeq22K3sTxTxMJn=5fg9J0PjKmzB+WVrg@mail.gmail.com> <a596dba822bba0733434fd234d335d01289bd567.camel@kernel.org>
In-Reply-To: <a596dba822bba0733434fd234d335d01289bd567.camel@kernel.org>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Thu, 31 Aug 2023 13:08:41 -0700
Message-ID: <CAM5tNy5DPqEQ5-dYrii4iWcFmHQV8jYDAe6WiYzxL+LmFZpx4A@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Cedric Blancher <cedric.blancher@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 31, 2023 at 11:53=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Thu, 2023-08-31 at 20:41 +0200, Cedric Blancher wrote:
> > On Thu, 31 Aug 2023 at 02:17, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
> > > > On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
> > > > > On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> > > > > > Again we have claimed regressions for walking a directory tree,
> > > > > > this time
> > > > > > with the "find" utility which always tries to optimize away ask=
ing
> > > > > > for any
> > > > > > attributes until it has a complete list of entries.  This behav=
ior
> > > > > > makes
> > > > > > the readdir plus heuristic do the wrong thing, which causes a s=
torm
> > > > > > of
> > > > > > GETATTRs to determine each entry's type in order to continue th=
e
> > > > > > walk.
> > > > > >
> > > > > > For v4 add the type attribute to each READDIR request to includ=
e it
> > > > > > no
> > > > > > matter the heuristic.  This allows a simple `find` command to
> > > > > > proceed
> > > > > > quickly through a directory tree.
> > > > > >
> > > > >
> > > > > The important bit here is that with v4, we can fill out d_type ev=
en
> > > > > when
> > > > > "plus" is false, at little cost. The downside is that non-plus
> > > > > READDIR
> > > > > replies will now be a bit larger on the wire. I think it's a
> > > > > worthwhile
> > > > > tradeoff though.
> > > >
> > > > The reason why we never did it before is that for many servers, it
> > > > forces them to go to the inode in order to retrieve the information=
.
> > > >
> > > > IOW: You might as well just do readdirplus.
> > > >
> > >
> > > That makes total sense, given how this code has evolved.
> > >
> > > FWIW, the Linux NFS server already calls vfs_getattr for every dentry=
 in
> > > a v4 READDIR reply regardless of what the client requests. It has to =
in
> > > order to detect junctions, so we're bringing in the inode no matter
> > > what. Fetching the type is trivial, so I don't see this as costing
> > > anything extra there.
> > >
> > > Mileage could vary on other servers with more synthetic filesystems, =
but
> > > one would hope that most of them can also return the type cheaply.
> >
> > Do you have examples for such synthetic filesystems?
> >
>
> Synthetic is probably the wrong distinction here, actually.
>
> If looking up the inode type info is expensive, then you'll feel it here
> more with this change. That's true regardless of whether this is a
> "normal" or "synthetic" fs.
In case you are interested in an outsider's perspective...
I recently patched the FreeBSD server so that it did not need to
acquire a vnode to generate a Readdir reply if only the following
attributes are requested and the entry is not a directory.
(FreeBSD has a d_type field in its "struct dirent".)
RDAttr_error, Mounted_on_FileID, FileID, Type
--> Adding a requirement for Type to nordirplus would not
     have any negative effect on the FreeBSD server.

This patch resulted in about a 5% improvement on Readdir RPC
response time for Readdirs only asking for the above attributes,
for some simple measurements I did using the FreeBSD client.

I still need to acquire the vnode for directories, to check for
server file system mount points. I do not know if what you
refer as "junctions" are directory specific?

rick

>
> I wouldn't expect a big performance hit from the Linux NFS server given
> that we'll almost certainly have that info in-core, but other servers
> (ganesha? some commercial servers?) could take a hit here.
> --
> Jeff Layton <jlayton@kernel.org>
>
