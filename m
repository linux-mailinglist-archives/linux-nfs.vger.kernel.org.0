Return-Path: <linux-nfs+bounces-4290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3C9166C3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED3828CDCF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68814A0BD;
	Tue, 25 Jun 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os458h8Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682115442A
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316774; cv=none; b=nTZhuHveGHlwFQcKApVGnDzeiopFR7Sfy2PnptZT2lWZbhHIGdR7T2KFRVKz/OKik1eUfrOcFN3J8FZkeJkTzMatr7yydNHkNuPO6ScqSkPt6skuo6s6cu+nCQU4pKV3z6n81PYlvkhfSnC5VTAtVpdjSuENCqys5jOT1z7yCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316774; c=relaxed/simple;
	bh=6SQE3nvFulCf9WcXk5BrcJnY8OyQMrIoRacyOdQKjhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qhx27HQO8Sm/6xML2SFbPLPP4d/JJsh4DBhU/pIiVf5HgW0xjTsy1JWG4PPDQQiGwNLnYOIjZ5ZpTTbi0qrZiTrvn75RRrxTHU2z9B8iYGWdp/ADdtcpFjS8MRaJBAT6Eaj0Uw6szDwsAFghc/pnh2cwqlQY6MZ34JuEadfMNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os458h8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C43DC32789;
	Tue, 25 Jun 2024 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719316774;
	bh=6SQE3nvFulCf9WcXk5BrcJnY8OyQMrIoRacyOdQKjhw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Os458h8ZRxDO29ybMptHlYhdKCAbL92UA0qn7ECruyFPzQ/LfmNQvMlVyM/XjL02a
	 UOfpEhITAuOFjAr/1U5KWTyT/zgJom5HDHp2ynv6S0CYloCjT8Ohq2G5t9eZn6cgjq
	 7wOKQrNy/ttMqqZfgk9MLQiRKS1qbVY9GoskU2PCMYRizj4k+MRe1rH7xiFg+9RzOA
	 lQ5JEvuSyx4vpA+zj5gY9k35Myhyv6+dZIY0LZcx4MyC/3ZDGToFnoh/ApTfn0YjvT
	 o32jxEIp1xFAUfMhlkYoDAZd0NocGUMhBwPqrrVlo92NuTjeT0506uiLdS8DE54wpT
	 HlguAUyKqxK3Q==
Message-ID: <2dfb2b239031ac4fd34996fdb3d404d1160f2158.camel@kernel.org>
Subject: Re: [PATCH v7 19/20] nfs: add
 Documentation/filesystems/nfs/localio.rst
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Tue, 25 Jun 2024 07:59:31 -0400
In-Reply-To: <20240624162741.68216-20-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
	 <20240624162741.68216-20-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 12:27 -0400, Mike Snitzer wrote:
> This document gives an overview of the LOCALIO auxiliary RPC protocol
> added to the Linux NFS client and server (both v3 and v4) to allow a
> client and server to reliably handshake to determine if they are on the
> same host.=C2=A0 The LOCALIO auxiliary protocol's implementation, which u=
ses
> the same connection as NFS traffic, follows the pattern established by
> the NFS ACL protocol extension.
>=20
> The robust handshake between local client and server is just the
> beginning, the ultimate usecase this locality makes possible is the
> client is able to issue reads, writes and commits directly to the server
> without having to go over the network.=C2=A0 This is particularly useful =
for
> container usecases (e.g. kubernetes) where it is possible to run an IO
> job local to the server.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0Documentation/filesystems/nfs/localio.rst | 134 +++++++++++++++++++=
+++
> =C2=A0include/linux/nfslocalio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A02 files changed, 136 insertions(+)
> =C2=A0create mode 100644 Documentation/filesystems/nfs/localio.rst
>=20
> diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/fi=
lesystems/nfs/localio.rst
> new file mode 100644
> index 000000000000..e856b6273e78
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/localio.rst
> @@ -0,0 +1,134 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +NFS localio
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document gives an overview of the LOCALIO auxiliary RPC protocol
> +added to the Linux NFS client and server (both v3 and v4) to allow a
> +client and server to reliably handshake to determine if they are on the
> +same host.=C2=A0 The LOCALIO auxiliary protocol's implementation, which =
uses
> +the same connection as NFS traffic, follows the pattern established by
> +the NFS ACL protocol extension.
> +
> +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> +clients local to their servers.=C2=A0 Prior to this LOCALIO protocol a
> +fragile sockaddr network address based match against all local network
> +interfaces was attempted.=C2=A0 But unlike the LOCALIO protocol, the
> +sockaddr-based matching didn't handle use of iptables or containers.
> +

The above paragraph sounds like there was an earlier implementation in
mainline kernels that used address matching. It might be good to point
out that that was a private implementation.

> +The robust handshake between local client and server is just the
> +beginning, the ultimate usecase this locality makes possible is the
> +client is able to issue reads, writes and commits directly to the server
> +without having to go over the network.=C2=A0 This is particularly useful=
 for
> +container usecases (e.g. kubernetes) where it is possible to run an IO
> +job local to the server.
> +
> +The performance advantage realized from localio's ability to bypass
> +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> +-=C2=A0 With localio:
> +=C2=A0 read: IOPS=3D691k, BW=3D42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> +-=C2=A0 Without localio:
> +=C2=A0 read: IOPS=3D15.7k, BW=3D984MiB/s (1032MB/s)(19.2GiB/20013msec)
> +
> +RPC
> +---
> +
> +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> +method that allows the Linux NFS client to retrieve a Linux NFS server's
> +uuid.=C2=A0 This protocol isn't part of an IETF standard, nor does it ne=
ed to
> +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> +to an implementation detail.
> +
> +The GETUUID method encodes the server's uuid_t in terms of the fixed
> +UUID_SIZE (16 bytes).=C2=A0 The fixed size opaque encode and decode XDR
> +methods are used instead of the less efficient variable sized methods.
> +
> +The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigne=
d
> +by IANA, see https://www.iana.org/assignments/rpc-program-numbers/=C2=A0=
):
> +Linux Kernel Organization=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 400122=C2=
=A0 nfslocalio
> +

Nice! Glad this got officially registered fast.

> +The LOCALIO protocol spec in rpcgen syntax is:
> +
> +/* raw RFC 9562 UUID */
> +#define UUID_SIZE 16
> +typedef u8 uuid_t<UUID_SIZE>;
> +
> +program NFS_LOCALIO_PROGRAM {
> +=C2=A0=C2=A0=C2=A0 version LOCALIO_V1 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL(=
void) =3D 0;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid_t
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GETUU=
ID(void) =3D 1;
> +=C2=A0=C2=A0=C2=A0 } =3D 1;
> +} =3D 400122;
> +
> +LOCALIO uses the same transport connection as NFS traffic.=C2=A0 As such=
,
> +LOCALIO is not registered with rpcbind.
> +
> +Once an NFS client and server handshake as "local", the client will
> +bypass the network RPC protocol for read, write and commit operations.
> +Due to this XDR and RPC bypass, these operations will operate faster.
> +
> +NFS Common and Server
> +---------------------
> +
> +First use is in nfsd, to add access to a global nfsd_uuids list in
> +nfs_common that is used to register and then identify local nfsd
> +instances.
> +

First use of what? This sentence doesn't parse well.

> +nfsd_uuids is protected by the nfsd_mutex or RCU read lock and is
> +composed of nfsd_uuid_t instances that are managed as nfsd creates them
> +(per network namespace).
> +
> +nfsd_uuid_is_local() and nfsd_uuid_lookup() are used to search all local
> +nfsd for the client specified nfsd uuid.
> +
> +The nfsd_uuids list is the basis for localio enablement, as such it has
> +members that point to nfsd memory for direct use by the client
> +(e.g. 'net' is the server's network namespace, through it the client can
> +access nn->nfsd_serv with proper rcu read access).=C2=A0 It is this clie=
nt
> +and server synchronization that enables advanced usage and lifetime of
> +objects to span from the host kernel's nfsd to per-container knfsd
> +instances that are connected to nfs client's running on the same local
> +host.
> +
> +NFS Client
> +----------
> +
> +fs/nfs/localio.c:nfs_local_probe() will retrieve a server's uuid via
> +LOCALIO protocol and check if the server with that uuid is known to be
> +local.=C2=A0 This ensures client and server 1: support localio 2: are lo=
cal
> +to each other.
> +
> +See fs/nfs/localio.c:nfs_local_open_fh() and
> +fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
> +focused use of nfsd_uuid_t struct to allow a client local to a server to
> +open a file pointer without needing to go over the network.
> +
> +The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
> +server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
> +both the nfsd network namespace and the associated nn->nfsd_serv in
> +terms of RCU.=C2=A0 If nfsd_open_local_fh() finds that client no longer =
sees
> +valid nfsd objects (be it struct net or nn->nfsd_serv) it returns ENXIO
> +to nfs_local_open_fh() and the client will try to reestablish the
> +LOCALIO resources needed by calling nfs_local_probe() again.=C2=A0 This
> +recovery is needed if/when an nfsd instance running in a container were
> +to reboot while a localio client is connected to it.
> +
> +Testing
> +-------
> +
> +The LOCALIO auxiliary protocol and associated NFS localio read, write
> +and commit access have proven stable against various test scenarios but
> +these have not yet been formalized in any testsuite:
> +
> +-=C2=A0 Client and server both on localhost (for both v3 and v4.2).
> +
> +-=C2=A0 Various permutations of client and server support enablement for
> +=C2=A0=C2=A0 both local and remote client and server.=C2=A0 Testing agai=
nst NFS storage
> +=C2=A0=C2=A0 products that don't support the LOCALIO protocol was also p=
erformed.
> +
> +-=C2=A0 Client on host, server within a container (for both v3 and v4.2)
> +=C2=A0=C2=A0 The container testing was in terms of podman managed contai=
ners and
> +=C2=A0=C2=A0 includes container stop/restart scenario.
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index c9592ad0afe2..a9722e18b527 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -20,6 +20,8 @@ extern struct list_head nfsd_uuids;
> =C2=A0 * Each nfsd instance has an nfsd_uuid_t that is accessible through=
 the
> =C2=A0 * global nfsd_uuids list. Useful to allow a client to negotiate if=
 localio
> =C2=A0 * possible with its server.
> + *
> + * See Documentation/filesystems/nfs/localio.rst for more detail.
> =C2=A0 */
> =C2=A0typedef struct {
> =C2=A0	uuid_t uuid;

--=20
Jeff Layton <jlayton@kernel.org>

