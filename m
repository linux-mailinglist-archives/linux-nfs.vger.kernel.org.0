Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3578F4A2
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 23:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjHaVdh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 17:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHaVdh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 17:33:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14511B
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 14:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4D28CE221F
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 21:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEDC433C9;
        Thu, 31 Aug 2023 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693517611;
        bh=VjGI3korpj9jUiyhQ2z87GegPkU8117wBPpDkqSMSZ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VxHWSjieebecS+Hz6xp8LbKTER8w1fQQTwY5KMj2+H4xVP6uKdmSto4RsTuKQ7MrK
         ByWO3cGUzAHMbhMVkq+rBRCyZPiv7sg29rS3InA079viJ+Hq66ok/zCb5l5IwbX33a
         L5MJOb2HmV+nEBmQnKHWU8N4iTTj/R1ybaweUSmWbnPpHvxC4asbJ1mWeFVNhjFB/3
         0Vz1Kll99v5Q09B/5GvGmG5xurXYCPS8TKLpsHFjySR69SwJ241JrVHdilFDOeNUDi
         3dVs4SEQEoBWH5WK8ct6ecKEYQ3AsgICT3Gojfo1HE4LIDH8qovtrcALajPPRXJUBp
         2s1vqJ8RBsrJw==
Message-ID: <ea9504a8ae53acd504d03f6f4cad20b22df737d5.camel@kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Rick Macklem <rick.macklem@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Cedric Blancher <cedric.blancher@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Thu, 31 Aug 2023 17:33:29 -0400
In-Reply-To: <CAM5tNy5DPqEQ5-dYrii4iWcFmHQV8jYDAe6WiYzxL+LmFZpx4A@mail.gmail.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
         <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
         <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
         <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
         <CALXu0UekEaGhj6+CHEeq22K3sTxTxMJn=5fg9J0PjKmzB+WVrg@mail.gmail.com>
         <a596dba822bba0733434fd234d335d01289bd567.camel@kernel.org>
         <CAM5tNy5DPqEQ5-dYrii4iWcFmHQV8jYDAe6WiYzxL+LmFZpx4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-31 at 13:08 -0700, Rick Macklem wrote:
> On Thu, Aug 31, 2023 at 11:53=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > CAUTION: This email originated from outside of the University of Guelph=
. Do not click links or open attachments unless you recognize the sender an=
d know the content is safe. If in doubt, forward suspicious emails to IThel=
p@uoguelph.ca.
> >=20
> >=20
> > On Thu, 2023-08-31 at 20:41 +0200, Cedric Blancher wrote:
> > > On Thu, 31 Aug 2023 at 02:17, Jeff Layton <jlayton@kernel.org> wrote:
> > > >=20
> > > > On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
> > > > > On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
> > > > > > On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> > > > > > > Again we have claimed regressions for walking a directory tre=
e,
> > > > > > > this time
> > > > > > > with the "find" utility which always tries to optimize away a=
sking
> > > > > > > for any
> > > > > > > attributes until it has a complete list of entries.  This beh=
avior
> > > > > > > makes
> > > > > > > the readdir plus heuristic do the wrong thing, which causes a=
 storm
> > > > > > > of
> > > > > > > GETATTRs to determine each entry's type in order to continue =
the
> > > > > > > walk.
> > > > > > >=20
> > > > > > > For v4 add the type attribute to each READDIR request to incl=
ude it
> > > > > > > no
> > > > > > > matter the heuristic.  This allows a simple `find` command to
> > > > > > > proceed
> > > > > > > quickly through a directory tree.
> > > > > > >=20
> > > > > >=20
> > > > > > The important bit here is that with v4, we can fill out d_type =
even
> > > > > > when
> > > > > > "plus" is false, at little cost. The downside is that non-plus
> > > > > > READDIR
> > > > > > replies will now be a bit larger on the wire. I think it's a
> > > > > > worthwhile
> > > > > > tradeoff though.
> > > > >=20
> > > > > The reason why we never did it before is that for many servers, i=
t
> > > > > forces them to go to the inode in order to retrieve the informati=
on.
> > > > >=20
> > > > > IOW: You might as well just do readdirplus.
> > > > >=20
> > > >=20
> > > > That makes total sense, given how this code has evolved.
> > > >=20
> > > > FWIW, the Linux NFS server already calls vfs_getattr for every dent=
ry in
> > > > a v4 READDIR reply regardless of what the client requests. It has t=
o in
> > > > order to detect junctions, so we're bringing in the inode no matter
> > > > what. Fetching the type is trivial, so I don't see this as costing
> > > > anything extra there.
> > > >=20
> > > > Mileage could vary on other servers with more synthetic filesystems=
, but
> > > > one would hope that most of them can also return the type cheaply.
> > >=20
> > > Do you have examples for such synthetic filesystems?
> > >=20
> >=20
> > Synthetic is probably the wrong distinction here, actually.
> >=20
> > If looking up the inode type info is expensive, then you'll feel it her=
e
> > more with this change. That's true regardless of whether this is a
> > "normal" or "synthetic" fs.
> In case you are interested in an outsider's perspective...
> I recently patched the FreeBSD server so that it did not need to
> acquire a vnode to generate a Readdir reply if only the following
> attributes are requested and the entry is not a directory.
> (FreeBSD has a d_type field in its "struct dirent".)
> RDAttr_error, Mounted_on_FileID, FileID, Type
> --> Adding a requirement for Type to nordirplus would not
>      have any negative effect on the FreeBSD server.
>=20
> This patch resulted in about a 5% improvement on Readdir RPC
> response time for Readdirs only asking for the above attributes,
> for some simple measurements I did using the FreeBSD client.


Very nice!

> I still need to acquire the vnode for directories, to check for
> server file system mount points. I do not know if what you
> refer as "junctions" are directory specific?
>=20

The nfsref command looks like it only works on directories, but in the
kernel code, I don't see where it enforces that it be a directory. You
can have a file mountpoint in Linux, after all...

Chuck (cc'ed) would know for sure... ;)

> >=20
> > I wouldn't expect a big performance hit from the Linux NFS server given
> > that we'll almost certainly have that info in-core, but other servers
> > (ganesha? some commercial servers?) could take a hit here.
> > --
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
