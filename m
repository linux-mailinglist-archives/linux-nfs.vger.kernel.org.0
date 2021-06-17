Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A583AA990
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 05:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFQD1M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 23:27:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFQD0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 23:26:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDE8521A9E;
        Thu, 17 Jun 2021 03:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623900263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/u+npGHGdMykAyB5FariH9LFC+E8SZzfyRXvtrdqrA=;
        b=zLz1USMOEP2zCuuMwN7qubRP7iwOKuHk1X7TCUCCUDaIFlF5NtlObV62P+zuAhs5rgAonQ
        ziqEVSn3SPNCDGzm2Q5XCflz+pZzNZMT6lSlU16NQlMibaLWZwwOnf+R04o1CijDJTX7Mo
        alDfPGHG2utH3uVitYsvAdLEK9YBXJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623900263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/u+npGHGdMykAyB5FariH9LFC+E8SZzfyRXvtrdqrA=;
        b=XrSmFgQ4jfeT4FKzWpnXIUf3LYKu81QzFDABEYhgQWexryZvgKr5OpUDeo/oRXRMD+bK2W
        JpyBnEFtobatrGAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 91668118DD;
        Thu, 17 Jun 2021 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623900263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/u+npGHGdMykAyB5FariH9LFC+E8SZzfyRXvtrdqrA=;
        b=zLz1USMOEP2zCuuMwN7qubRP7iwOKuHk1X7TCUCCUDaIFlF5NtlObV62P+zuAhs5rgAonQ
        ziqEVSn3SPNCDGzm2Q5XCflz+pZzNZMT6lSlU16NQlMibaLWZwwOnf+R04o1CijDJTX7Mo
        alDfPGHG2utH3uVitYsvAdLEK9YBXJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623900263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/u+npGHGdMykAyB5FariH9LFC+E8SZzfyRXvtrdqrA=;
        b=XrSmFgQ4jfeT4FKzWpnXIUf3LYKu81QzFDABEYhgQWexryZvgKr5OpUDeo/oRXRMD+bK2W
        JpyBnEFtobatrGAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id R5GQEGbAymCsJAAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 17 Jun 2021 03:24:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: prevent port reuse on transports which don't request it.
In-reply-to: <162371991856.23575.16102887900102220450@noble.neil.brown.name>
References: <162371991856.23575.16102887900102220450@noble.neil.brown.name>
Date:   Thu, 17 Jun 2021 13:24:19 +1000
Message-id: <162390025921.29912.9620777152373832527@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 15 Jun 2021, someone wrote:
> If an RPC client is created without RPC_CLNT_CREATE_REUSEPORT, it should
> not reuse the source port when a TCP connection is re-established.
> This is currently implemented by preventing the source port being
> recorded after a successful connection (the call to xs_set_srcport()).
>=20
> However the source port is also recorded after a successful bind in xs_bind=
().
> This may not be needed at all and certainly is not wanted when
> RPC_CLNT_CREATE_REUSEPORT wasn't requested.
>=20
> So avoid that assignment when xprt.reuseport is not set.
>=20
> With this change, NFSv4.1 and later mounts use a different port number on
> each connection.  This is helpful with some firewalls which don't cope
> well with port reuse.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

I guess this should have

Fixes: e6237b6feb37 ("NFSv4.1: Don't rebind to the same source port when reco=
nnecting to the server")

NeilBrown

> ---
>  net/sunrpc/xprtsock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 316d04945587..3228b7a1836a 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1689,7 +1689,8 @@ static int xs_bind(struct sock_xprt *transport, struc=
t socket *sock)
>  		err =3D kernel_bind(sock, (struct sockaddr *)&myaddr,
>  				transport->xprt.addrlen);
>  		if (err =3D=3D 0) {
> -			transport->srcport =3D port;
> +			if (transport->xprt.reuseport)
> +				transport->srcport =3D port;
>  			break;
>  		}
>  		last =3D port;
> --=20
> 2.31.1
>=20
>=20
