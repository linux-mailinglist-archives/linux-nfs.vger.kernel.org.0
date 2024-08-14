Return-Path: <linux-nfs+bounces-5352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA79518C7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F631C21152
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B41AE04A;
	Wed, 14 Aug 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKsDS5dD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="csqgW91B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKsDS5dD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="csqgW91B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037713635F;
	Wed, 14 Aug 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631328; cv=none; b=Pnf9FTCsX5fme1iO5AU1TIlkISLoOx9HOspcd9c1H9oOmVlW6thGvtE9ezZCzi28nzFhVXkW1K00vfFe/HlNyc2+papGc23gPdnTot2o+koXBSGUloq8JjQpwvTW5fKmDthgHbdkMCQrE4jiJlQnrQbSLuW40vhWqGGo5y3AnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631328; c=relaxed/simple;
	bh=IhehC/m3ET+Njr7CyOTbwSeI65VBnzy+/iEVyCTefWQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=M4gyExTFrJUkRzOTrz8nveF2GFsm23zaS+x5eKpQ6/EMCMhOKkKSG79HDYtL47sF8FUC2Jp5urN0Cy2l2uW/j6YD/Zo+gPjJWRBIEkPite47ljgbbRmBxqEr5cPUySv2GFfTZW1ULA87tv+a65zt5h02TnEBDBeL//+RuQcK/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKsDS5dD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=csqgW91B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKsDS5dD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=csqgW91B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 350B71FBF1;
	Wed, 14 Aug 2024 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723631325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3SZTtbe4bVgebO2AFHOr1hr9qtp9UGF8qY/wS1mhXQ=;
	b=CKsDS5dDGKzfUU27tFWr0EkiYF/saFUiX+T2mfAb5bvFbguo2ji8p5ew9zzEMymJRVDBEA
	zs8gKbCCTjoKzK12SCXXG/48PWXZQdRc6QTC5PZSPP1VDASINRWJWsz5bu8ku9OhPVmKRZ
	DfzUTmcmrF2ZgOPaPJ2g6B94KkFG5Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723631325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3SZTtbe4bVgebO2AFHOr1hr9qtp9UGF8qY/wS1mhXQ=;
	b=csqgW91BMi9Q/Zm7cGw6lF1WUOi/tHlVWQo3W+hMQtvB1gsiCLszkGqsFQwmKdtbuFof3A
	HZ6lKSVDRnyhM6Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723631325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3SZTtbe4bVgebO2AFHOr1hr9qtp9UGF8qY/wS1mhXQ=;
	b=CKsDS5dDGKzfUU27tFWr0EkiYF/saFUiX+T2mfAb5bvFbguo2ji8p5ew9zzEMymJRVDBEA
	zs8gKbCCTjoKzK12SCXXG/48PWXZQdRc6QTC5PZSPP1VDASINRWJWsz5bu8ku9OhPVmKRZ
	DfzUTmcmrF2ZgOPaPJ2g6B94KkFG5Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723631325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3SZTtbe4bVgebO2AFHOr1hr9qtp9UGF8qY/wS1mhXQ=;
	b=csqgW91BMi9Q/Zm7cGw6lF1WUOi/tHlVWQo3W+hMQtvB1gsiCLszkGqsFQwmKdtbuFof3A
	HZ6lKSVDRnyhM6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2580A139B9;
	Wed, 14 Aug 2024 10:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vHwNM9eGvGabCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 14 Aug 2024 10:28:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: kunwu.chan@linux.dev
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Kunwu Chan" <chentao@kylinos.cn>
Subject: Re: [PATCH] SUNRPC: Fix -Wformat-truncation warning
In-reply-to: <20240814093853.48657-1-kunwu.chan@linux.dev>
References: <20240814093853.48657-1-kunwu.chan@linux.dev>
Date: Wed, 14 Aug 2024 20:28:31 +1000
Message-id: <172363131189.6062.4199842989565550209@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, 14 Aug 2024, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
>=20
> Increase size of the servername array to avoid truncated output warning.
>=20
> net/sunrpc/clnt.c:582:75: error=EF=BC=9A=E2=80=98%s=E2=80=99 directive outp=
ut may be truncated
> writing up to 107 bytes into a region of size 48
> [-Werror=3Dformat-truncation=3D]
>   582 |                   snprintf(servername, sizeof(servername), "%s",
>       |                                                             ^~
>=20
> net/sunrpc/clnt.c:582:33: note:=E2=80=98snprintf=E2=80=99 output
> between 1 and 108 bytes into a destination of size 48
>   582 |                     snprintf(servername, sizeof(servername), "%s",
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   583 |                                          sun->sun_path);
>=20
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/sunrpc/clnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 09f29a95f2bc..874085f3ed50 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *arg=
s)
>  		.connect_timeout =3D args->connect_timeout,
>  		.reconnect_timeout =3D args->reconnect_timeout,
>  	};
> -	char servername[48];
> +	char servername[108];

If we choose this approach to removing the warning, then we should use
UNIX_PATH_MAX rather than 108.

However the longest server name copied in here will in practice be
   /var/run/rpcbind.sock

so the extra 60 bytes on the stack is wasted ...  maybe that doesn't
matter.

The string is only used by xprt_create_transport() which requires it to
be less than RPC_MAXNETNAMELEN - which is 256.
So maybe that would be a better value to use for the array size ....  if
we assume that stack space isn't a problem.

What ever number we use, I'd rather it was a defined constant, and not
an apparently arbitrary number.

Thanks,
NeilBrown


>  	struct rpc_clnt *clnt;
>  	int i;
> =20
> --=20
> 2.40.1
>=20
>=20


