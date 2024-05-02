Return-Path: <linux-nfs+bounces-3136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A78BA10D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 21:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD85F28348A
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C44174EC1;
	Thu,  2 May 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeQRig7E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656415FA74
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677924; cv=none; b=draFOHJQ0n3n4OcvSLVscGJl67yx4ogPe27sdiqVuCCsaeq2KbjOvjLZT1Ou1AykJKslLdCmrHISgMcC550kF4qgpLhhWuzbmMvNyefvGVlEmf6DetWJRQc3wpHjB2uop6qhI+PmNu3kVweHn9aoaDOgXgL5qQprsHY8iiJGj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677924; c=relaxed/simple;
	bh=6mDD08AFmtRAMDUTiQWF9S7BewU6KjoXxOpeW5K6Zss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNHMW7d6PniWHiapyfHikxIPS8fwFiCAfREnUa1kgZHnCEESEE6w61c8918E4n/BQ+lcPD0sRpphLF5ipPM+KfJ8FZGE8I+GlPqv/pbHqjhevPW+QF+MLIZiCmcUTUn5MoQ+R0tN8dHsYVZwTz9guepTYjApg7v3kdkZI7L7XPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeQRig7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D8AC113CC;
	Thu,  2 May 2024 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714677923;
	bh=6mDD08AFmtRAMDUTiQWF9S7BewU6KjoXxOpeW5K6Zss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QeQRig7EzOAWwc5FwKy8LGbCvVhhq+0h6ihdaRet7uXyNQo2vpV63VtworpDQE+wz
	 S7uE32l1FDrj72TlOha4xGfvLDREdwj2djhOSWocGe9rdtCsbqubeDZXymuwVG6Pz3
	 jXc3SmLMN6Y25nhEIZ+PjDA87kuDv+zO3hN8CmcEM+5gjT+Jf4nH3rsDdQc5ETwiun
	 i1z1+/DkZz5JEtdSd5Rem2XYRLej/7AvSlID+ZtfQajHiNXvLYnWkzk2g3JSMrf6uu
	 s/dITAdEFZBeZF8dt20TzvpPlarcyuMwKRZGUgGRK20V6BEn5yOmNqIs70egPdmlz2
	 SJ79GzkmM/JfA==
Message-ID: <4741788c0ef0425f356c489b03fbee3b9dbadbbe.camel@kernel.org>
Subject: Re: NFSv3 and xprtsec policies
From: Jeffrey Layton <jlayton@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>, Chuck Lever III
 <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Thu, 02 May 2024 15:25:22 -0400
In-Reply-To: <ZjPgq-xA1G6Z2_aQ@aion>
References: <ZjO3Qwf_G87yNXb2@aion>
	 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com> <ZjPPZmBZJZVmBuA6@aion>
	 <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com> <ZjPgq-xA1G6Z2_aQ@aion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 14:51 -0400, Scott Mayhew wrote:
> On Thu, 02 May 2024, Chuck Lever III wrote:
>=20
> >=20
> >=20
> > > On May 2, 2024, at 1:37=E2=80=AFPM, Scott Mayhew <smayhew@redhat.com>=
 wrote:
> > >=20
> > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > >=20
> > > > > On May 2, 2024, at 11:54=E2=80=AFAM, Scott Mayhew <smayhew@redhat=
.com> wrote:
> > > > >=20
> > > > > Red Hat QE identified an "interesting" issue with NFSv3 and TLS, =
in that an
> > > > > NFSv3 client can mount with "xprtsec=3Dnone" a filesystem exporte=
d with
> > > > > "xprtsec=3Dtls:mtls" (in the sense that the client gets the fileh=
andle and adds a
> > > > > mount to its mount table - it can't actually access the mount).
> > > > >=20
> > > > > Here's an example using machines from the recent Bakeathon.
> > > > >=20
> > > > > Mounting a server with TLS enabled:
> > > > >=20
> > > > > # mount -o v4.2,sec=3Dsys,xprtsec=3Dtls oracle-102.chuck.lever.or=
acle.com.nfsv4.dev:/export/tls /mnt
> > > > > # umount /mnt
> > > > >=20
> > > > > Trying to mount without "xprtsec=3Dtls" shows that the filesystem=
 is not exported with "xprtsec=3Dnone":
> > > > >=20
> > > > > # mount -o v4.2,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4=
.dev:/export/tls /mnt
> > > > > mount.nfs: Operation not permitted for oracle-102.chuck.lever.ora=
cle.com.nfsv4.dev:/export/tls on /mnt
> > > > >=20
> > > > > Yet a v3 mount without "xprtsec=3Dtls" works:
> > > > >=20
> > > > > # mount -o v3,sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.d=
ev:/export/tls /mnt
> > > > > # umount /mnt
> > > > >=20
> > > > > and a mount with no explicit version and without "xprtsec=3Dtls" =
falls back to
> > > > > v3 and also "works":
> > > > >=20
> > > > > # mount -o sec=3Dsys oracle-102.chuck.lever.oracle.com.nfsv4.dev:=
/export/tls /mnt
> > > > > # grep ora /proc/mounts
> > > > > oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> > > > > +rw,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,=
hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D100.64.0.49,=
mountvers=3D3,mountport=3D20048,mountproto=3Dudp,local_lock=3Dnone,addr=3D1=
00.64.0.49 0 0
> > > > >=20
> > > > > Even though the filesystem is mounted, the client can't do anythi=
ng with it:
> > > > >=20
> > > > > # ls /mnt
> > > > > ls: cannot open directory '/mnt': Permission denied
> > > > >=20
> > > > > When krb5 is used with NFSv3, the server returns a list of pseudo=
flavors in
> > > > > mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#secti=
on-5.2.1).
> > > > > The client compares that list with its own list of auth flavors p=
arsed from the
> > > > > mount request and returns -EACCES if no match is found (see
> > > > > nfs_verify_authflavors()).
> > > > >=20
> > > > > Perhaps we should be doing something similar with xprtsec policie=
s?
> > > >=20
> > > > The problem might be in how you've set up the exports. With NFSv3,
> > > > the parent export needs the "crossmnt" export option in order for
> > > > NFSv3 to behave like NFSv4 in this regard, although I could have
> > > > missed something.
> > >=20
> > > I was mounting your server though :)
> >=20
> > OK, then not the same bug that Olga found last year.
> >=20
> > We should find out what FreeBSD does in this case.
>=20
> I thought about that.  Rick's servers from the BAT are offline, and I
> don't think he was exporting v3 anyway.
>=20
> >=20
> >=20
> > > > > Should
> > > > > there be an errata to RFC 9289 and a request from IANA for assign=
ed numbers for
> > > > > pseudo-flavors corresponding to xprtsec policies?
> > > >=20
> > > > No. Transport-layer security is not an RPC security flavor or
> > > > pseudo-flavor. These two things are not related.
> > > >=20
> > > > (And in fact, I proposed something like this for NFSv4 SECINFO,
> > > > but it was rejected).
> > >=20
> > > I thought it might be a stretch to try to use mountres3.auth_flavors =
for
> > > this, but since RFC 9289 does refer to AUTH_TLS as an authentication
> > > flavor and https://www.iana.org/assignments/rpc-authentication-number=
s/rpc-authentication-numbers.xhtml
> > > also lists TLS under the Flavor Name column I thought it might make
> > > sense to treat xprtsec policies as if they were pseudo-flavors even
> > > though they're not, if only to give the client a way to determine tha=
t
> > > the mount should fail.
> >=20
> > RPC_AUTH_TLS is used only when a client probes a server to see if
> > it supports RPC-with-TLS. At all other times, the client uses one
> > of the normal, legitimate flavors. It does not represent a security
> > flavor that can be used during regular operation.
> >=20
> > NFSv3 mount failover logic is still open for discussion (ie, incomplete=
).
> >=20
> > Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavors
> > list? I think clients that don't recognize it should ignore it,
> > but I'm not sure. What should a client do if it sees that flavor in
> > the list? It's not one that can be used for any other procedure than
> > a NULL RPC.
>=20
> Maybe?  After the client gets the filehandle it's calling FSINFO and
> PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn't
> checking for a negative return code from the PATHCONF operation.  If it
> did, it could maybe use the -EACCES coupled with the knowledge that the
> server had RPC_AUTH_TLS enabled to emit an error message saying to check
> the xprtsec policies (but I don't think that would be as definitive as
> what I had in mind) and to fail the mount.
>=20

That sounds reasonable if it can be made to work.

One could argue that to properly implement NFSv3 over TLS, that the
sidecar protocols (including mountd) should be TLS-enabled as well. If
that were the case, then we could just make the mount error out when
the TLS handshake doesn't work.

That _is_ a bit draconian though, and I don't see anyone lining up to
do the mountd work anytime soon.

> >=20
> >=20
> > > > > If not, this behavior should at least be documented in the man pa=
ges.
> > > >=20
> > > > "crossmnt", and it's kin "nohide", are explained in exports(5).
> > >=20
> > > rpc.mountd doesn't do any access checking based on xprtsec policies o=
n
> > > the export (or krb5 pseudo-flavors, for that matter), so I don't see =
how
> > > "crossmount" or "nohide" would have any effect here.
> >=20
> > No, they don't, you are correct.
> >=20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
>=20
>=20

--=20
Jeffrey Layton <jlayton@kernel.org>

