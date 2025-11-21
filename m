Return-Path: <linux-nfs+bounces-16643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7BC76E30
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 02:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FB294E3D96
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73671A38F9;
	Fri, 21 Nov 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Id5sV4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE513774D;
	Fri, 21 Nov 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689713; cv=none; b=aUl3UFgT6y89JFvGX/BCE3EfcXAkCRft6/dmDo/M0utcMMchgzi3LrrxyjlV+Z4uJ0RzxIcdE7asXtH2KDuxMpMIi4BkLFGkcC2xshq7kvlsoxRR6aCXUl6tSne+z+aRtTwZQpMWQ46+bMkuNJXb7HceEG+/2I9rfiPkou6Zpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689713; c=relaxed/simple;
	bh=YRGxdUVg3YMAZdxNx5V7iXEiJ8SXLhk91mcY9zZWy2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeWIM4IUXjSZz7XeT309QagkCOO6ioa2C54GpIMjE98jyUzXjp10/PJjzQF7T6bupGYjEpGSMHIx3HEE+mwIaFxL8K1tg9okxq/NYlTfWzrebLATlmVAnLzIdkkywXKTYAuyiWknlC3odYNQu9oLNw/Fy8nHeMN9NabdGJzM2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Id5sV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEEDC4CEF1;
	Fri, 21 Nov 2025 01:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763689712;
	bh=YRGxdUVg3YMAZdxNx5V7iXEiJ8SXLhk91mcY9zZWy2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4Id5sV4e/aEHygXHtwDUuJb9K7fo6737hS4A8nkmr2s5pio5jV+y5XEIFiWxx35N
	 01ed5YUwrnT5Wa42QXSe8zV/C+zpIwRZueBhMBy6r9nJhsirvoNJf4mB+yFNELRGjB
	 8K/pYs7UoaQIcF09ztmIJF7GQvbMJIsWtg2yjGrpBRogPd3JZOh2iwWZljbuLJCkJl
	 ZWlOSeTevj2cncGYYnIuXj4fEt8lc2gLejBUvMWXNbOMJ1+Buc+JdP6Ne2pP09fGEQ
	 A58Ge1caOPNqI0sHTOAOIZ+PR+xgCZwqQc4IZNmk+yLgzDSZGmqU2Y3Ex3+efDD6j3
	 jDUF8aw7/D7KQ==
Date: Thu, 20 Nov 2025 17:48:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker
 <anna@kernel.org>, Antonio Quartulli <antonio@openvpn.net>, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>, Arve =?UTF-8?B?SGrDuG5uZXY=?=
 =?UTF-8?B?w6Vn?= <arve@android.com>, Carlos Llamas <cmllamas@google.com>,
 Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>, Daniel Zahka
 <daniel.zahka@gmail.com>, David Ahern <dsahern@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>, Eric Dumazet
 <edumazet@google.com>, Geliang Tang <geliang@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Hannes Reinecke
 <hare@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Jeff Layton
 <jlayton@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Joe Damato
 <jdamato@fastly.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 kernel-tls-handshake@lists.linux.dev, Li Li <dualli@google.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Martijn Coenen
 <maco@android.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>, Mina Almasry <almasrymina@google.com>,
 mptcp@lists.linux.dev, NeilBrown <neil@brown.name>, netdev@vger.kernel.org,
 Olga Kornievskaia <okorniev@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Samiullah Khawaja
 <skhawaja@google.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos
 <tkjos@android.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem
 de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 2/2] tools: ynl-gen: add regeneration comment
Message-ID: <20251120174829.2e9c44a7@kernel.org>
In-Reply-To: <20251120100240.1e80c65f@kernel.org>
References: <20251120174429.390574-1-ast@fiberby.net>
	<20251120174429.390574-3-ast@fiberby.net>
	<20251120100240.1e80c65f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 10:02:40 -0800 Jakub Kicinski wrote:
> On Thu, 20 Nov 2025 17:44:27 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> > Add a comment on regeneration to the generated files.
> >=20
> > The comment is placed after the YNL-GEN line[1], as to not interfere
> > with ynl-regen.sh's detection logic.
> >=20
> > [1] and after the optional YNL-ARG line. =20
>=20
> Let's make this comment also optional? Detect whether it's there=20
> in the bash script and pass appropriate flag to C gen?

Raced responding with Matthieu. Sounds like a strong signal that this
is useful, so let's keep the patch as is. I'll revive it in pw.

