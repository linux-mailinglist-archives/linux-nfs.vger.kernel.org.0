Return-Path: <linux-nfs+bounces-16631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F8C75DAE
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 19:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63FA34E0F3A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AF303A3B;
	Thu, 20 Nov 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU1aX7dC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8B23B615;
	Thu, 20 Nov 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661764; cv=none; b=IO8sA4CsqALv9/Q3RISd3mLxCwwbTvZJB5G8zd/y3BGPL7ObvirZuxuUOrKck4jX7spG3pwoh+Fb3aLEEUKiS3Qos8R16ep1AZaf4l2/B7zuK2KcngjlOuDzS+hG2sCKiuUZasTnsaxfvESefP+KExCdtfbb5PV7Q09/Q76t+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661764; c=relaxed/simple;
	bh=tW4GWywFGyxIBvvnTE52KQ0xbnTTxrBJuVsfwIEnrEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd7A3sqdbVvPNMfpYYbjFSjgkr9CksYLfXUAvCMMym9tFf24hFcnkrzoxubM7q4fPaPlLZSUqxehL5sG/6p9p9xzzrfgScXRZfxGEYzZROBx9HLbzmeKAX32C+nXpNNLGdOraVnoymekqq7+eJCD4hkT13+gSWioSQfrFHwabzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU1aX7dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F67AC4CEF1;
	Thu, 20 Nov 2025 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763661763;
	bh=tW4GWywFGyxIBvvnTE52KQ0xbnTTxrBJuVsfwIEnrEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bU1aX7dCdw3jpvhsOS8/fsYpgSWcKVyMRk+L7pljjC+YPutDUc16+nkqLtJus7SQo
	 Iwpd2Slb01j64FnS/raCTlEhfOzlM/xaDtDo3WM8RCpq5vp3vyWfYS9Tv7ct/jSus4
	 NPoDR89HMhyV8IYt3tpqEZKMvJD+2M2W4FaUpqSo1LaY7pDQWbO3GSRh6vCwUEGj2b
	 Lfp94mIRWogUqLMga7ZVuqjgd/gaWn84MRSDN+bTOdNkf8sI6x9aOuTBrBZSl2Gz3t
	 /Tt2Ycbk3TOIuxhitFF0yw3fb87xOUBSD/jHyhcFNiky1W6eolkvkqYX/9nvgNZ8q6
	 W/SThFGBkyBWQ==
Date: Thu, 20 Nov 2025 10:02:40 -0800
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
Message-ID: <20251120100240.1e80c65f@kernel.org>
In-Reply-To: <20251120174429.390574-3-ast@fiberby.net>
References: <20251120174429.390574-1-ast@fiberby.net>
	<20251120174429.390574-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 17:44:27 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Add a comment on regeneration to the generated files.
>=20
> The comment is placed after the YNL-GEN line[1], as to not interfere
> with ynl-regen.sh's detection logic.
>=20
> [1] and after the optional YNL-ARG line.

Let's make this comment also optional? Detect whether it's there=20
in the bash script and pass appropriate flag to C gen?
--=20
pw-bot: cr

