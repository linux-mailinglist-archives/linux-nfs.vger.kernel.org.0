Return-Path: <linux-nfs+bounces-9614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C797DA1C629
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 03:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C193A877A
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103713B5A0;
	Sun, 26 Jan 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0SZzvM3W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tIaox188";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TXjauzDd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SEGJ6X40"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2544A08;
	Sun, 26 Jan 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737859200; cv=none; b=fIXL8Cwhq1e5qmYzBVCD4+/TbzhuLwniUtzVL0OHjfFdN5pR4PBAEzdM2Acoy3xbkgi9/xaIYBo2Elx3gR6YHV1KLmK/RnbRHkij1y89AH9iH6LlKBAtlDlmwAKzDnmj3usmtWj0A2zqcYxBMvsrnR234TjRebZOOlQ05JkpCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737859200; c=relaxed/simple;
	bh=QFMBjsoLWWWoWOgJHwEHdUEwl0VsQK1oKZnKsFVOxIw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ao9fXqqlxHOvy6vQXxtNynje9zW1ZFFApLXnw1FtbFo/qFLjZQdFxHW7k69YLV+WpUjS1kpptlnNX+t6yyjU5FvKtb6371jhuUgL/emS1/M91QVPzH1hcQqKhuCB/wCOBiwVojb6juVqQxXEWjMx44iGazgkgjRuVsVgoX6x810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0SZzvM3W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tIaox188; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TXjauzDd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SEGJ6X40; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48F061F38F;
	Sun, 26 Jan 2025 02:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737859190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCQJUUBiO3dOGrsJphYrnfke3LHTbRseA+TVYS2+6Kg=;
	b=0SZzvM3W437wmXQKrP70A1Mk0PNkNnfgXmaPs7HfoXAAfitBkF6K87aHXL+ntzGdSoVjtM
	eX9EFwKXDGQdeOMVfZfVKZl4p7RB9mO/XWJ3idwwr3mQjvyn6Jz4+XvHRisRfpW939jeD4
	px56e/8lf4zm5gQg+rcRo3y/q41/Qj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737859190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCQJUUBiO3dOGrsJphYrnfke3LHTbRseA+TVYS2+6Kg=;
	b=tIaox188X/KitKsEVFJGDGtJOAQwzeTsfEm5M1aOL2N8NX6ruNxkmJRKKCQxsr2YUjJiYF
	9Hipfz29phBQTHBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737859189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCQJUUBiO3dOGrsJphYrnfke3LHTbRseA+TVYS2+6Kg=;
	b=TXjauzDdmVMPTLR6OzAS0jcEgT5W7V7Id5tL2EL/18791G/uGk/Zyyr9dbB6/ge1iUEmBr
	CGMzfHh/LzqPzhf5ULvqpSc+sW+D2IiHdtZ9q8r7qba0n+XEwqZKkSOD5jYdXpgaDeJ0Hx
	i5jwcCtEVRDUPDLC8ibibP5hJfPh4qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737859189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCQJUUBiO3dOGrsJphYrnfke3LHTbRseA+TVYS2+6Kg=;
	b=SEGJ6X40A46Pi2lhhJEOAR2V/SL1j8IY+xVnEkALWKI1Ri0oWO21YK/GdCu+UsPDAUIZUM
	+HkMsKGHLkl8aoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FB4913782;
	Sun, 26 Jan 2025 02:39:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +pnuDHKglWc0LgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 26 Jan 2025 02:39:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Salvatore Bonaccorso" <carnil@debian.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
In-reply-to: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
References: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
Date: Sun, 26 Jan 2025 13:39:38 +1100
Message-id: <173785917824.22054.15604701394410740651@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 26 Jan 2025, Jeff Layton wrote:
> nfsd_file_dispose_list_delayed can be called from the filecache
> laundrette, which is shut down after the nfsd threads are shut down and
> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
> are no threads to wake.
>=20
> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
> svc_serv is not freed until after the filecache laundrette is cancelled.
>=20
> Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work que=
ue")
> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9935a47e1d4056432=
20d7946.camel@kernel.org/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is only lightly tested, but I think it will fix the bug that
> Salvatore reported.
> ---
>  fs/nfsd/filecache.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd750f43=
239b4af6d37b0 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_head *disp=
ose)
>  						struct nfsd_file, nf_gc);
>  		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
>  		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +		struct svc_serv *serv;
> =20
>  		spin_lock(&l->lock);
>  		list_move_tail(&nf->nf_gc, &l->freeme);
>  		spin_unlock(&l->lock);
> -		svc_wake_up(nn->nfsd_serv);
> +
> +		/*
> +		 * The filecache laundrette is shut down after the
> +		 * nn->nfsd_serv pointer is cleared, but before the
> +		 * svc_serv is freed.
> +		 */
> +		serv =3D nn->nfsd_serv;

I wonder if this should be READ_ONCE() to tell the compiler that we
could race with clearing nn->nfsd_serv.  Would the comment still be
needed?

Otherwise:

 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> +		if (serv)
> +			svc_wake_up(serv);
>  	}
>  }
> =20
>=20
> ---
> base-commit: 7541a5b8073cf0d9e2d288cac581f1aa6c11671d
> change-id: 20250125-kdevops-0989825ae8db
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


