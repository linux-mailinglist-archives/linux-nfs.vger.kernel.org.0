Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A550676D9FB
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHBVwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjHBVwk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 17:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD26119;
        Wed,  2 Aug 2023 14:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6817B60F8A;
        Wed,  2 Aug 2023 21:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282E2C433C7;
        Wed,  2 Aug 2023 21:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691013157;
        bh=zVRu4Q6Uqke0KNJnnj+vyyOwzGnFRmFnMN9nEhLGUf8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SfEvFV5ypGkcFQTlrQCgOHX5SpTqK6K77ODeWQmYv4vR631g3GCYYid5skCvSJ4pE
         21shKrebS5EP/hAm3jpweOhqNfZV/tDqx0gbZGXjoqoJZBH7N5jOEr6/8HHZqgFZBS
         CE/J2y6av9YIomVMCrUuvwLUM7l842WNP/hbVR/zKDEKtk2fyRRp8s67ggnBBiKfhE
         UtHkzdQpw/SucFVg5FruQKRG8RZp/obOOW9+CpM845jKmjqQJT5l73VTV5awvh3vrD
         mES/s67lCF4whz5Gp66GpQUrcbaN9ye6Cx9FEwT8GqWaiXYfXJwFpcGNNRwayk/4RS
         gOjKcIuKpMwsQ==
Message-ID: <56557df3aaf3a847a6019e2b27c9721b22145bd1.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Aug 2023 17:52:35 -0400
In-Reply-To: <5296d1a2-e410-c5bd-a8ca-66b8b42f158e@oracle.com>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
         <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
         <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
         <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
         <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
         <26761CA2-923C-43FC-BDC6-14012115EAA0@oracle.com>
         <6801380f-75cb-49b2-4e89-49821193fe32@oracle.com>
         <5296d1a2-e410-c5bd-a8ca-66b8b42f158e@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-08-02 at 14:32 -0700, dai.ngo@oracle.com wrote:
> On 8/2/23 2:22 PM, dai.ngo@oracle.com wrote:
> >=20
> > On 8/2/23 1:57 PM, Chuck Lever III wrote:
> > >=20
> > > > On Aug 2, 2023, at 4:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > >=20
> > > > On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
> > > > > On 8/2/23 11:15 AM, Jeff Layton wrote:
> > > > > > On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
> > > > > > > On 8/1/23 6:33 AM, Jeff Layton wrote:
> > > > > > > > I noticed that xfstests generic/001 was failing against=20
> > > > > > > > linux-next nfsd.
> > > > > > > >=20
> > > > > > > > The client would request a OPEN4_SHARE_ACCESS_WRITE open, a=
nd=20
> > > > > > > > the server
> > > > > > > > would hand out a write delegation. The client would then tr=
y to=20
> > > > > > > > use that
> > > > > > > > write delegation as the source stateid in a COPY
> > > > > > > not sure why the client opens the source file of a COPY opera=
tion=20
> > > > > > > with
> > > > > > > OPEN4_SHARE_ACCESS_WRITE?
> > > > > > >=20
> > > > > > It doesn't. The original open is to write the data for the file=
 being
> > > > > > copied. It then opens the file again for READ, but since it has=
 a=20
> > > > > > write
> > > > > > delegation, it doesn't need to talk to the server at all -- it =
can=20
> > > > > > just
> > > > > > use that stateid for later operations.
> > > > > >=20
> > > > > > > > =A0=A0 or CLONE operation, and
> > > > > > > > the server would respond with NFS4ERR_STALE.
> > > > > > > If the server does not allow client to use write delegation f=
or the
> > > > > > > READ, should the correct error return be NFS4ERR_OPENMODE?
> > > > > > >=20
> > > > > > The server must allow the client to use a write delegation for =
read
> > > > > > operations. It's required by the spec, AFAIU.
> > > > > >=20
> > > > > > The error in this case was just bogus. The vfs copy routine wou=
ld=20
> > > > > > return
> > > > > > -EBADF since the file didn't have FMODE_READ, and the nfs serve=
r=20
> > > > > > would
> > > > > > translate that into NFS4ERR_STALE.
> > > > > >=20
> > > > > > Probably there is a better v4 error code that we could translat=
e=20
> > > > > > EBADF
> > > > > > to, but with this patch it shouldn't be a problem any longer.
> > > > > >=20
> > > > > > > > The problem is that the struct file associated with the=20
> > > > > > > > delegation does
> > > > > > > > not necessarily have read permissions. It's handing out a w=
rite
> > > > > > > > delegation on what is effectively an O_WRONLY open. RFC 888=
1=20
> > > > > > > > states:
> > > > > > > >=20
> > > > > > > > =A0=A0 "An OPEN_DELEGATE_WRITE delegation allows the client=
 to=20
> > > > > > > > handle, on its
> > > > > > > > =A0=A0=A0 own, all opens."
> > > > > > > >=20
> > > > > > > > Given that the client didn't request any read permissions, =
and=20
> > > > > > > > that nfsd
> > > > > > > > didn't check for any, it seems wrong to give out a write=
=20
> > > > > > > > delegation.
> > > > > > > >=20
> > > > > > > > Only hand out a write delegation if we have a O_RDWR descri=
ptor
> > > > > > > > available. If it fails to find an appropriate write descrip=
tor, go
> > > > > > > > ahead and try for a read delegation if NFS4_SHARE_ACCESS_RE=
AD was
> > > > > > > > requested.
> > > > > > > >=20
> > > > > > > > This fixes xfstest generic/001.
> > > > > > > >=20
> > > > > > > > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D41=
2
> > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > ---
> > > > > > > > Changes in v2:
> > > > > > > > - Rework the logic when finding struct file for the delegat=
ion. The
> > > > > > > > =A0=A0=A0 earlier patch might still have attached a O_WRONL=
Y file to=20
> > > > > > > > the deleg
> > > > > > > > =A0=A0=A0 in some cases, and could still have handed out a =
write=20
> > > > > > > > delegation on
> > > > > > > > =A0=A0=A0 an O_WRONLY OPEN request in some cases.
> > > > > > > > ---
> > > > > > > > =A0=A0 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++---------=
--
> > > > > > > > =A0=A0 1 file changed, 18 insertions(+), 11 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > index ef7118ebee00..e79d82fd05e7 100644
> > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open=
=20
> > > > > > > > *open, struct nfs4_ol_stateid *stp,
> > > > > > > > =A0=A0=A0 struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > > > > > > > =A0=A0=A0 struct nfs4_clnt_odstate *odstate =3D stp->st_cln=
t_odstate;
> > > > > > > > =A0=A0=A0 struct nfs4_delegation *dp;
> > > > > > > > - struct nfsd_file *nf;
> > > > > > > > + struct nfsd_file *nf =3D NULL;
> > > > > > > > =A0=A0=A0 struct file_lock *fl;
> > > > > > > > =A0=A0=A0 u32 dl_type;
> > > > > > > >=20
> > > > > > > > @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_op=
en=20
> > > > > > > > *open, struct nfs4_ol_stateid *stp,
> > > > > > > > =A0=A0=A0 if (fp->fi_had_conflict)
> > > > > > > > =A0=A0=A0 return ERR_PTR(-EAGAIN);
> > > > > > > >=20
> > > > > > > > - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > > > > > > > - nf =3D find_writeable_file(fp);
> > > > > > > > + /*
> > > > > > > > + * Try for a write delegation first. We need an O_RDWR fil=
e
> > > > > > > > + * since a write delegation allows the client to perform a=
ny open
> > > > > > > > + * from its cache.
> > > > > > > > + */
> > > > > > > > + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=
=3D=20
> > > > > > > > NFS4_SHARE_ACCESS_BOTH) {
> > > > > > > > + nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);
> > > > > > > > =A0=A0=A0 dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > > > > > > - } else {
> > > > > > > Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write=
=20
> > > > > > > delegation?
> > > > > > > It does not seem right.
> > > > > > >=20
> > > > > > > -Dai
> > > > > > >=20
> > > > > > Why? Per RFC 8881:
> > > > > >=20
> > > > > > "An OPEN_DELEGATE_WRITE delegation allows the client to handle,=
 on=20
> > > > > > its
> > > > > > own, all opens."
> > > > > >=20
> > > > > > All opens. That includes read opens.
> > > > > >=20
> > > > > > An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to whic=
h the
> > > > > > user has no read permissions. Therefore, we can't grant a write
> > > > > > delegation since can't guarantee that the user is allowed to do=
 that.
> > > > > If the server grants the write delegation on an OPEN with
> > > > > OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode the=
n
> > > > > why can't the server checks and denies the subsequent READ?
> > > > >=20
> > > > > Per RFC 8881, section 9.1.2:
> > > > >=20
> > > > > =A0=A0=A0=A0 For delegation stateids, the access mode is based on=
 the type of
> > > > > =A0=A0=A0=A0 delegation.
> > > > >=20
> > > > > =A0=A0=A0=A0 When a READ, WRITE, or SETATTR (that specifies the s=
ize=20
> > > > > attribute)
> > > > > =A0=A0=A0=A0 operation is done, the operation is subject to check=
ing=20
> > > > > against the
> > > > > =A0=A0=A0=A0 access mode to verify that the operation is appropri=
ate given the
> > > > > =A0=A0=A0=A0 stateid with which the operation is associated.
> > > > >=20
> > > > > =A0=A0=A0=A0 In the case of WRITE-type operations (i.e., WRITEs a=
nd=20
> > > > > SETATTRs that
> > > > > =A0=A0=A0=A0 set size), the server MUST verify that the access mo=
de allows=20
> > > > > writing
> > > > > =A0=A0=A0=A0 and MUST return an NFS4ERR_OPENMODE error if it does=
 not. In=20
> > > > > the case
> > > > > =A0=A0=A0=A0 of READ, the server may perform the corresponding ch=
eck on the=20
> > > > > access
> > > > > =A0=A0=A0=A0 mode, or it may choose to allow READ on OPENs for=
=20
> > > > > OPEN4_SHARE_ACCESS_WRITE,
> > > > > =A0=A0=A0=A0 to accommodate clients whose WRITE implementation ma=
y=20
> > > > > unavoidably do
> > > > > =A0=A0=A0=A0 reads (e.g., due to buffer cache constraints). Howev=
er, even=20
> > > > > if READs
> > > > > =A0=A0=A0=A0 are allowed in these circumstances, the server MUST =
still=20
> > > > > check for
> > > > > =A0=A0=A0=A0 locks that conflict with the READ (e.g., another OPE=
N specified
> > > > > =A0=A0=A0=A0 OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Not=
e that a=20
> > > > > server
> > > > > =A0=A0=A0=A0 that does enforce the access mode check on READs nee=
d not=20
> > > > > explicitly
> > > > > =A0=A0=A0=A0 check for conflicting share reservations since the e=
xistence=20
> > > > > of OPEN
> > > > > =A0=A0=A0=A0 for OPEN4_SHARE_ACCESS_READ guarantees that no confl=
icting share
> > > > > =A0=A0=A0=A0 reservation can exist.
> > > > >=20
> > > > > FWIW, The Solaris server grants write delegation on OPEN with
> > > > > OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
> > > > > WR-only. Maybe this is a bug? or the spec is not clear?
> > > > >=20
> > > > I don't think that's necessarily a bug.
> > > >=20
> > > > It's not that the spec demands that we only hand out delegations on=
=20
> > > > BOTH
> > > > opens.=A0 This is more of a quirk of the Linux implementation. Linu=
x'
> > > > write delegations require an open O_RDWR file descriptor because we=
 may
> > > > be called upon to do a read on its behalf.
> > > >=20
> > > > Technically, we could probably just have it check for
> > > > OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set=
,
> > > > then you're unlikely to get a delegation. Either the O_RDWR descrip=
tor
> > > > will be NULL, or there are other, conflicting opens already present=
.
> > > >=20
> > > > Solaris may have a completely different design that doesn't require
> > > > this. I haven't looked at its code to know.
> > > I'm comfortable for now with not handing out write delegations for
> > > SHARE_ACCESS_WRITE opens. I prefer that to permission checking on
> > > every READ operation.
> >=20
> > I'm fine with just handling out write delegation for SHARE_ACCESS_BOTH
> > only.
> >=20
> > Just a concern about not checking for access at the time of READ=20
> > operation.
> or not checking file permission at the time WRITE.
> > If the file was opened with SHARE_ACCESS_WRITE (no write delegation=20
> > granted)
> > and the file access mode was changed to read-only, is it a correct=20
> > behavior
> > for the server to allow the READ to go through?
> I meant for the WRITE to go through.

Yes:

POSIX permissions enforcement is done at open time, not when doing
actual reads and writes. If you open a file on (e.g.) xfs and start
streaming writes to it, then you don't expect that you will lose the
ability to write to that fd if the permissions change.

In the old v2/3 days of stateless NFS, we had to check permissions on
every READ or WRITE operation, but we generally did an open on every RPC
too, so it just worked out that we checked permissions on each
operation.

With v4 we can better approximate POSIX semantics by just associating a
stateid with an open file to allow the client to keep writing in this
case.


> >=20
> > -Dai
> >=20
> > >=20
> > > If we find that it's a significant performance issue, we can revisit.
> > >=20
> > >=20
> > > > > It'd would be interesting to know how ONTAP server behaves in
> > > > > this scenario.
> > > > >=20
> > > > Indeed. Most likely it behaves more like Solaris does, but it'd nic=
e to
> > > > know.
> > > >=20
> > > > > >=20
> > > > > > > > + }
> > > > > > > > +
> > > > > > > > + /*
> > > > > > > > + * If the file is being opened O_RDONLY or we couldn't get=
 a=20
> > > > > > > > O_RDWR
> > > > > > > > + * file for some reason, then try for a read deleg instead=
.
> > > > > > > > + */
> > > > > > > > + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_REA=
D)) {
> > > > > > > > =A0=A0=A0 nf =3D find_readable_file(fp);
> > > > > > > > =A0=A0=A0 dl_type =3D NFS4_OPEN_DELEGATE_READ;
> > > > > > > > =A0=A0=A0 }
> > > > > > > > - if (!nf) {
> > > > > > > > - /*
> > > > > > > > - * We probably could attempt another open and get a read
> > > > > > > > - * delegation, but for now, don't bother until the
> > > > > > > > - * client actually sends us one.
> > > > > > > > - */
> > > > > > > > +
> > > > > > > > + if (!nf)
> > > > > > > > =A0=A0=A0 return ERR_PTR(-EAGAIN);
> > > > > > > > - }
> > > > > > > > +
> > > > > > > > =A0=A0=A0 spin_lock(&state_lock);
> > > > > > > > =A0=A0=A0 spin_lock(&fp->fi_lock);
> > > > > > > > =A0=A0=A0 if (nfs4_delegation_exists(clp, fp))
> > > > > > > >=20
> > > > > > > > ---
> > > > > > > > base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> > > > > > > > change-id: 20230731-wdeleg-bbdb6b25a3c6
> > > > > > > >=20
> > > > > > > > Best regards,
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
> > > --=20
> > > Chuck Lever
> > >=20
> > >=20

--=20
Jeff Layton <jlayton@kernel.org>
