Return-Path: <linux-nfs+bounces-4614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AA926C7F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 01:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155FE1C213AA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 23:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785217A58E;
	Wed,  3 Jul 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkRJc0Un"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDB1C68D
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049745; cv=none; b=rwGKznj/H/cs+u7cCPiGUxw15ay6GjivWvv/af2zOv8T4zVSWnikuaybRmuKhkKwVfFBeor74uGODWqKAz44ym/GWbVWs0BfpK/CqavAnuETFTrYRmbNNeYkyxXyRqbWkG7SGLIPkgV3HYFNKAQ/FsQPnmNwBcUWsDJNRnCVhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049745; c=relaxed/simple;
	bh=MsislkJi3y70JvxPOOpQCrdgT+yz5SzPKjKAPzb5tb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7WYn/xqNZPt6a92mPKsQn4rjh1Y5+xLBGKCFDRgAoj1Vj600k2HKeitRvQiUejoHxJmo0Nrh5DuwoM8h7dQMO0YEHchs01Vei+x83UN1UiZibuXAH8SpNxLMqUmLLLfdB9RHqJhIx7uKoYdXbOS0Yd9hVmoXvduf9Ua4ZHdBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkRJc0Un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B7CC2BD10;
	Wed,  3 Jul 2024 23:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720049745;
	bh=MsislkJi3y70JvxPOOpQCrdgT+yz5SzPKjKAPzb5tb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tkRJc0Un1X3tzMvzVMh28mqO6s2LVhvYlr9lnYM1iao7YgDp1n+ffMq6gmVcAu64q
	 w+uXB2hR1yv8lnn1S+cOjjJboX8vq9EyTYtzDArRzt44ZKrCthVTq05kW9tfXqC3f+
	 IDiNNEPlEZ2d7XQfIsfV5Dr/rwjDl5QYiB4cIIubKf4q7XmgpM6upkjR5/OaNs17M6
	 WAZQzehIDpVc42o6grTVvWJnuo/noKQC3IaVwoi4RWtAwCyjm2RCzZisSycOGsSPQf
	 wSpW/nW+z2mVxwaQxsAKeeWQcY2JvFwcVE4rIHlDflzZe9IHR9JxCiIoOuarkPFK6A
	 f0d8rmGBB52tQ==
Message-ID: <0e562239157dfb1addd13c7241262d8ef84b4101.camel@kernel.org>
Subject: Re: Security issue in NFS localio
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>, Trond Myklebust
 <trondmy@hammerspace.com>,  Christoph Hellwig <hch@infradead.org>,
 linux-nfs@vger.kernel.org
Date: Wed, 03 Jul 2024 19:35:43 -0400
In-Reply-To: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 08:24 +1000, NeilBrown wrote:
>=20
> I've been pondering security questions with localio - particularly
> wondering what questions I need to ask.=C2=A0 I've found three focal poin=
ts
> which overlap but help me organise my thoughts:
> 1- the LOCALIO RPC protocol
> 2- the 'auth_domain' that nfsd uses to authorise access
> 3- the credential that is used to access the file
>=20
> 1/ It occurs to me that I could find out the UUID reported by a given
> local server (just ask it over the RPC connection), find out the
> filehandle for some file that I don't have write access to (not too
> hard), and create a private NFS server (hacking nfs-ganasha?) which
> reports the same uuid and reports that I have access to a file with
> that filehandle.=C2=A0 If I then mount from that server inside a private
> container on the same host that is running the local server, I would get
> localio access to the target file.
>=20
> I might not be able to write to it because of credential checking, but I
> think that is getting a lot closer to unauthorised access than I would
> like.
>=20
> I would much prefer it if there was no credible way to subvert the
> LOCALIO protocol.
>=20
> My current idea goes like this:
> =C2=A0- NFS client tells nfs_common it is going to probe for localio
> =C2=A0=C2=A0 and gets back a nonce.=C2=A0 nfs_common records that this pr=
obe is happening
> =C2=A0- NFS client sends the nonce to the server over LOCALIO.
> =C2=A0- server tells nfs_common "I just got this nonce - does it mean
> =C2=A0=C2=A0 anything?".=C2=A0 If it does, the server gets connected with=
 the client
> =C2=A0=C2=A0 through nfs_common.=C2=A0 The server reports success over LO=
CALIO.
> =C2=A0=C2=A0 If it doesn't the server reports failure of LOCALIO.
> =C2=A0- NFS client gets the reply and tells nfs_common that it has a repl=
y
> =C2=A0=C2=A0 so the nonce is invalidated.=C2=A0 If the reply was success =
and nfs_local
> =C2=A0=C2=A0 confirms there is a connection, then the two stay connected.
>=20
> I think that having a nonce (single-use uuid) is better than using the
> same uuid for the life of the server, and I think that sending it
> proactively by client rather than reactively by the server is also
> safer.
>=20

I like this idea. That does sound much safer.

> 2/ The localio access should use exactly the same auth_domain as the
> =C2=A0=C2=A0 network access uses.=C2=A0 This ensure the credentials impli=
ed by
> =C2=A0=C2=A0 rootsquash and allsquash are used correctly.=C2=A0 I think t=
he current
> =C2=A0=C2=A0 code has the client guessing what IP address the server will=
 see and
> =C2=A0=C2=A0 finding an auth_domain based on that.=C2=A0 I'm not comforta=
ble with that.
> =C2=A0=C2=A0=20
> =C2=A0=C2=A0 In the new LOCALIO protocol I suggest above, the server regi=
sters
> =C2=A0=C2=A0 with nfs_common at the moment it receives an RPC request.=C2=
=A0 At that
> =C2=A0=C2=A0 moment it knows the characteristics of the connection - remo=
te IP?
> =C2=A0=C2=A0 krb5?=C2=A0 tls?=C2=A0 - and can determine an auth_domain an=
d give it to
> =C2=A0=C2=A0 nfs_common and so make it available to the client.
>=20

The current localio code does this:

+	/* Note: we're connecting to ourself, so source addr =3D=3D peer addr */
+	rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
+			(struct sockaddr *)&rqstp->rq_addr,
+			sizeof(rqstp->rq_addr));

...which I guess means that we're setting this to the server's address?
=C2=A0
That does seem like it might allow a client in another namespace to
bypass export permissions.

I think your idea about associating an auth_domain should fix that.

> =C2=A0=C2=A0 Jeff wondered about an export option to explicitly enable LO=
CALIO.=C2=A0 I
> =C2=A0=C2=A0 had wondered about that too.=C2=A0 But I think that if we fi=
rmly tie the
> =C2=A0=C2=A0 localio auth_domain to the connection as above, that shouldn=
't be needed.
>
> 3/ The current code uses the 'struct cred' of the application to look up
> =C2=A0=C2=A0 the file in the server code.=C2=A0 When a request goes over =
the wire the
> =C2=A0=C2=A0 credential is translated to uid/gid (or krb identity) and th=
is is
> =C2=A0=C2=A0 mapped back to a credential on the server which might be in =
a
> =C2=A0=C2=A0 different uid name space (might it?=C2=A0 Does that even wor=
k for nfsd?)
>=20
> =C2=A0=C2=A0 I think that if rootsquash or allsquash is in effect the cor=
rect
> =C2=A0=C2=A0 server-side credential is used but otherwise the client-side
> =C2=A0=C2=A0 credential is used.=C2=A0 That is likely correct in many cas=
es but I'd
> =C2=A0=C2=A0 like to be convinced that it is correct in all case.=C2=A0 M=
aybe it is
> =C2=A0=C2=A0 time to get a deeper understanding of uid name spaces.
>=20


I'll have to consider this #3 over some July 4th libations!
--=20
Jeff Layton <jlayton@kernel.org>

