Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD967246D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjARRGa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjARRG3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:06:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772701716E
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E14618FF
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66A5C433F1;
        Wed, 18 Jan 2023 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674061586;
        bh=zQm+vgsOJ+AXgcyLum4Egz1zuumWDJSdIGJAqvkYP6s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Zq4BRMKSViHJZOrtGSDsfjTWOYAas4RrApGlKf6Bvo97JdkrDWgVXfycwbsHn+OaY
         ZXs9FyFyj84q59Q1z1crGTp2uJO2oXaKIm7VGz2LgyrEt1tDumpn+nzO+uI0XIWpJk
         GsKHSebPX3xP1fDjEe2uqiV2mpiQubim5IBdi9ZJCH1CO8aXuzzaAe6yJ7d2QiRwZ6
         rvunIEVu1ZUac7zzMiEyUeQdXikworb7TqY4Z/mlmuyDeOQc1U5Bv0Ttw43rSlolU8
         GOHNE+QAy5/Dem9y3kjb6/U+rTAv4ho2bakYjojLOzjwaLDqcMzW/36Mu/Q3X2Ojjm
         LxOPZfbncsg2Q==
Message-ID: <0fbcbdc37e7e3f070b491848a74be348843074c2.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks
 in COPY codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Date:   Wed, 18 Jan 2023 12:06:24 -0500
In-Reply-To: <12C5F3B3-6DB1-4483-8160-A691EB464464@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
         <20230117193831.75201-3-jlayton@kernel.org>
         <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
         <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
         <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
         <12C5F3B3-6DB1-4483-8160-A691EB464464@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-18 at 16:39 +0000, Chuck Lever III wrote:
>=20
> > On Jan 18, 2023, at 11:29 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >=20
> > On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote=
:
> > >=20
> > > On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> > > > On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wr=
ote:
> > > > >=20
> > > > > There are two different flavors of the nfsd4_copy struct. One is
> > > > > embedded in the compound and is used directly in synchronous copi=
es. The
> > > > > other is dynamically allocated, refcounted and tracked in the cli=
ent
> > > > > struture. For the embedded one, the cleanup just involves releasi=
ng any
> > > > > nfsd_files held on its behalf. For the async one, the cleanup is =
a bit
> > > > > more involved, and we need to dequeue it from lists, unhash it, e=
tc.
> > > > >=20
> > > > > There is at least one potential refcount leak in this code now. I=
f the
> > > > > kthread_create call fails, then both the src and dst nfsd_files i=
n the
> > > > > original nfsd4_copy object are leaked.
> > > >=20
> > > > I don't believe that's true. If kthread_create thread fails we call
> > > > cleanup_async_copy() that does a put on the file descriptors.
> > > >=20
> > >=20
> > > You mean this?
> > >=20
> > > out_err:
> > >        if (async_copy)
> > >                cleanup_async_copy(async_copy);
> > >=20
> > > That puts the references that were taken in dup_copy_fields, but the
> > > original (embedded) nfsd4_copy also holds references and those are no=
t
> > > being put in this codepath.
> >=20
> > Can you please point out where do we take a reference on the original c=
opy?
> >=20
> > > > > The cleanup in this codepath is also sort of weird. In the async =
copy
> > > > > case, we'll have up to four nfsd_file references (src and dst for=
 both
> > > > > flavors of copy structure).
> > > >=20
> > > > That's not true. There is a careful distinction between intra -- wh=
ich
> > > > had 2 valid file pointers and does a get on both as they both point=
 to
> > > > something that's opened on this server--- but inter -- only does a =
get
> > > > on the dst file descriptor, the src doesn't exit. And yes I realize
> > > > the code checks for nfs_src being null which it should be but it ma=
kes
> > > > the code less clear and at some point somebody might want to decide=
 to
> > > > really do a put on it.
> > > >=20
> > >=20
> > > This is part of the problem here. We have a nfsd4_copy structure, and
> > > depending on what has been done to it, you need to call different
> > > methods to clean it up. That seems like a real antipattern to me.
> >=20
> > But they call different methods because different things need to be
> > done there and it makes it clear what needs to be for what type of
> > copy.
>=20
> In cases like this, it makes sense to consider using types to
> ensure the code can't do the wrong thing. So you might want to
> have a struct nfs4_copy_A for the inter code to use, and a struct
> nfs4_copy_B for the intra code to use. Sharing the same struct
> for both use cases is probably what's confusing to human readers.
>=20
> I've never been a stickler for removing every last ounce of code
> duplication. Here, it might help to have a little duplication
> just to make it easier to reason about the reference counting in
> the two use cases.
>=20
> That's my view from the mountain top, worth every penny you paid
> for it.
>=20

+1

The nfsd4_copy structure has a lot of fields in it that only matter for
the async copy case. ISTM that nfsd4_copy (the function) should
dynamically allocate a struct nfsd4_async_copy that contains a
nfsd4_copy and whatever other fields are needed.

Then, we could trim down struct nfsd4_copy to just the info needed.

For instance, the nf_src and nf_dst fields really don't need to be in
nfsd4_copy. For the synchronous copy case, we can just keep those
pointers on the stack, and for the async case they would be inside the
larger structure.

That would allow us to trim down the footprint of the compound union
too.

--=20
Jeff Layton <jlayton@kernel.org>
