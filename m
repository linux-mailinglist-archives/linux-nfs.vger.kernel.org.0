Return-Path: <linux-nfs+bounces-6425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37AB97744C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2667D1F23738
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DC1C2DC8;
	Thu, 12 Sep 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g+DGzlab";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YmH7APkT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ziYsZbo2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HI/jfDLi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7081C2437;
	Thu, 12 Sep 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179974; cv=none; b=UE6mRR1YGuiQGcRm+PGQPGPCzJWI4Vzv/G6bWi5tJnJuKL/hsL9nQ8IO+QUIMCcekXi0DFBXAhxZXfF5GfTgYoymk6InDUjOLvQKB2CNm52G0QAQuYEEuyEdrGxtjGyeAGYtY3aNuLKVxigPc4YJSEmdtImHzVn78D19BbmG/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179974; c=relaxed/simple;
	bh=ctItJRVpw82jXmQuDbKx6+6962Ka9QmWJ+Es9knwK/4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=eeGpZVfX9n8loHopw8LiIJe+HIO8JzNM6lvM+cuHlKIzYxYKX9o6E4an+nH3yqAiZJiAcaCDm6V/0VEdIguCzJoNe0vk8uWiLIaBL/8JQ9rhrRMLatOiYhb+dogERh7fTark/sVfHwyzsVerJd2bkgkpOqm0S4SjR9nLcspYGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g+DGzlab; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YmH7APkT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ziYsZbo2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HI/jfDLi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 372A51F7A9;
	Thu, 12 Sep 2024 22:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726179970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl+cjXWbhkIbqfDOxo3tas/VXwicE3s/17bB24vRjKk=;
	b=g+DGzlabXqd6KWY1Dt91L7hQYs01OaNVoUx6oFYSQiZLT38tPaVd9iGGa4JAOzn0WJCLOg
	lVSODa1oeRTMjMeRmqE3sG4yjzSPpsuYmCUKxmEJaRh4b5BAfWpZinZxw0UYNq3afMIgLu
	7ml1HG0dKGTuTLJDWLwswqV73K3DaTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726179970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl+cjXWbhkIbqfDOxo3tas/VXwicE3s/17bB24vRjKk=;
	b=YmH7APkTbkErtqTlXU/5WZBTc3FH7hklDzh1zabTihzph8mi81Tgph4J0QutpCpnTZON6o
	IZ0vE6s2vJ8edjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726179969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl+cjXWbhkIbqfDOxo3tas/VXwicE3s/17bB24vRjKk=;
	b=ziYsZbo2rQ4wh5JA4+cKJPA4FnvmkxMVE6DfOQXpKUcpzDp6V7+4PxsK7A8QBmJ1nZw71N
	1YCXvRzmWxAxWRQY4ulw0cnNlWShcZwUcHMaGftCswoUQjKe71mQrSHwX0i1+m0u4cagni
	2uxabQAJAmdxVtlP5wqk/u6eT8mxkB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726179969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl+cjXWbhkIbqfDOxo3tas/VXwicE3s/17bB24vRjKk=;
	b=HI/jfDLi4OeXSAGV1dwXa1aOD9G8c9lQec/WA1XoELzFJjGKqSR/Q8ZVVw8QWbBDzM9Phf
	47TruksacWfhnbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8553413A73;
	Thu, 12 Sep 2024 22:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RAfwDn5q42bHEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 12 Sep 2024 22:26:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix nfs4_disable_idmapping option
In-reply-to: <20240912220659.23336-1-pali@kernel.org>
References: <20240912220659.23336-1-pali@kernel.org>
Date: Fri, 13 Sep 2024 08:26:02 +1000
Message-id: <172617996236.17050.1069184645717662362@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> NFSv4 server option nfs4_disable_idmapping says that it turn off server's
> NFSv4 idmapping when using 'sec=3Dsys'. But it also turns idmapping off also
> for 'sec=3Dnone'.
>=20
> NFSv4 client option nfs4_disable_idmapping says same thing and really it
> turns the NFSv4 idmapping only for 'sec=3Dsys'.
>=20
> Fix the NFSv4 server option nfs4_disable_idmapping to turn off idmapping
> only for 'sec=3Dsys'. This aligns the server nfs4_disable_idmapping option
> with its description and also aligns behavior with the client option.

Why do you think this is the right approach?
If the documentation says "turn off when sec=3Dsys" and the implementation
does "turn off when sec=3Dsys or sec=3Dnone" then I agree that something
needs to be fixed.  I would suggest that the documentation should be
fixed.

From the perspective of id mapping, sec=3Dnone is similar to sec=3Dsys.

NeilBrown


>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  fs/nfsd/nfs4idmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 7a806ac13e31..641293711f53 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -620,7 +620,7 @@ numeric_name_to_id(struct svc_rqst *rqstp, int type, co=
nst char *name, u32 namel
>  static __be32
>  do_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 name=
len, u32 *id)
>  {
> -	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor < RPC_AUTH_GSS)
> +	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UN=
IX)
>  		if (numeric_name_to_id(rqstp, type, name, namelen, id))
>  			return 0;
>  		/*
> @@ -633,7 +633,7 @@ do_name_to_id(struct svc_rqst *rqstp, int type, const c=
har *name, u32 namelen, u
>  static __be32 encode_name_from_id(struct xdr_stream *xdr,
>  				  struct svc_rqst *rqstp, int type, u32 id)
>  {
> -	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor < RPC_AUTH_GSS)
> +	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UN=
IX)
>  		return encode_ascii_id(xdr, id);
>  	return idmap_id_to_name(xdr, rqstp, type, id);
>  }
> --=20
> 2.20.1
>=20
>=20


