Return-Path: <linux-nfs+bounces-3681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B88904A0F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C62818B7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F727269;
	Wed, 12 Jun 2024 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sy87YVRX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wjdVdm6x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sy87YVRX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wjdVdm6x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA7168A8
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166988; cv=none; b=mKqR9FUpi/nrYYn+BJ+jkr1eJeE5OK6lpOg7Cq3vlDmSY971vZ4K23v8EEAhtYhzJOsxCsNk9l0cvX5CY9bVswsc5PoKRmep69Tuh/LzsOAs9QufNY6E9GZJRCbzUwl9esRheQn7csTk5DV/rocUUWXD+OVwoge04Vl/YPwNvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166988; c=relaxed/simple;
	bh=MC2pjFo2NC/GwMExe2oMYdBobpSAAcldwFZStd+dNng=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IOXMAEgY9Tqu6HLc5Yw5Qk1by9Bz6RNv+PaiW8xko5O/acWaT3ypfcQlakI3vV2jfssWBoidQUf2PJDbmRymz3F3wadKVB0Aab/VNG42IaRj7bp/WfHXv3tP9pc+vb9cCIe1I6GbThEMijY5nbz4n5IVgdbh0CA1Q/RUQUiDfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sy87YVRX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wjdVdm6x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sy87YVRX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wjdVdm6x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9869F33E79;
	Wed, 12 Jun 2024 04:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718166984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c3RtoHf55+58YuKwrBc3X1iV+3DcoiCVXo64saq3Kk=;
	b=Sy87YVRXzaw/o1VTtKrf73q3kJfXT/Fn0+ts9OiS7nEElU+mxWcrj8/cDkUuiVGaGu/qmQ
	guBTpU19aVqO1hi1L1w7pwxVVqod4LJsTfV+Dnn+v3YcN25jBK42Zxw17QJKJNN6T4lyvq
	wG3NV9qdZWbzGO2suQspzynxtf226Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718166984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c3RtoHf55+58YuKwrBc3X1iV+3DcoiCVXo64saq3Kk=;
	b=wjdVdm6xL7jnPRZiFqcHwAwRG0mtUXmdYr5XeZWbnC49JlmEgWSwPRdlo52WXJgckb+iIL
	xB++SsZSC2F/kUCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718166984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c3RtoHf55+58YuKwrBc3X1iV+3DcoiCVXo64saq3Kk=;
	b=Sy87YVRXzaw/o1VTtKrf73q3kJfXT/Fn0+ts9OiS7nEElU+mxWcrj8/cDkUuiVGaGu/qmQ
	guBTpU19aVqO1hi1L1w7pwxVVqod4LJsTfV+Dnn+v3YcN25jBK42Zxw17QJKJNN6T4lyvq
	wG3NV9qdZWbzGO2suQspzynxtf226Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718166984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c3RtoHf55+58YuKwrBc3X1iV+3DcoiCVXo64saq3Kk=;
	b=wjdVdm6xL7jnPRZiFqcHwAwRG0mtUXmdYr5XeZWbnC49JlmEgWSwPRdlo52WXJgckb+iIL
	xB++SsZSC2F/kUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07CF013AA4;
	Wed, 12 Jun 2024 04:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FhMJ8UlaWYaIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 04:36:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 07/15] nfs/nfsd: add "localio" support
In-reply-to: <20240612030752.31754-8-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>,
 <20240612030752.31754-8-snitzer@kernel.org>
Date: Wed, 12 Jun 2024 14:36:18 +1000
Message-id: <171816697836.14261.17806813255162604456@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add client support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when the client and the server are
> running on the same host.
>=20
> nfs_local_probe() is stubbed out, later commits will enable client and
> server handshake via a LOCALIO protocol extension.
>=20
> This has dynamic binding with the nfsd module. Localio will only work
> if nfsd is already loaded.
>=20
> The "localio_enabled" nfs kernel module parameter can be used to
> disable and enable the ability to use localio support.
>=20
> Also, tracepoints were added for nfs_local_open_fh, nfs_local_enable
> and nfs_local_disable.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/Makefile           |   2 +
>  fs/nfs/client.c           |   7 +
>  fs/nfs/inode.c            |   5 +
>  fs/nfs/internal.h         |  55 +++
>  fs/nfs/localio.c          | 798 ++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfstrace.h         |  61 +++
>  fs/nfs/pagelist.c         |   3 +
>  fs/nfs/write.c            |   3 +
>  fs/nfsd/Makefile          |   2 +
>  fs/nfsd/filecache.c       |   2 +-
>  fs/nfsd/localio.c         | 184 +++++++++
>  fs/nfsd/trace.h           |   3 +-
>  fs/nfsd/vfs.h             |   8 +
>  include/linux/nfs.h       |   6 +
>  include/linux/nfs_fs.h    |   2 +
>  include/linux/nfs_fs_sb.h |   5 +
>  include/linux/nfs_xdr.h   |   1 +
>  17 files changed, 1145 insertions(+), 2 deletions(-)
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfsd/localio.c
>=20
> diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> index 5f6db37f461e..ad9923fb0f03 100644
> --- a/fs/nfs/Makefile
> +++ b/fs/nfs/Makefile
> @@ -13,6 +13,8 @@ nfs-y 			:=3D client.o dir.o file.o getroot.o inode.o sup=
er.o \
>  nfs-$(CONFIG_ROOT_NFS)	+=3D nfsroot.o
>  nfs-$(CONFIG_SYSCTL)	+=3D sysctl.o
>  nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o
> +nfs-$(CONFIG_NFS_V3_LOCALIO) +=3D localio.o
> +nfs-$(CONFIG_NFS_V4_LOCALIO) +=3D localio.o

Should be just

   nfs-$(CONFIG_NFS_LOCALIO_SUPPORT) +=3D localio.o

> =20
>  obj-$(CONFIG_NFS_V2) +=3D nfsv2.o
>  nfsv2-y :=3D nfs2super.o proc.o nfs2xdr.o
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index de77848ae654..c123ad22ac79 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -178,6 +178,10 @@ struct nfs_client *nfs_alloc_client(const struct nfs_c=
lient_initdata *cl_init)
>  	clp->cl_max_connect =3D cl_init->max_connect ? cl_init->max_connect : 1;
>  	clp->cl_net =3D get_net(cl_init->net);
> =20
> +#if defined(CONFIG_NFS_V3_LOCALIO) || defined(CONFIG_NFS_V4_LOCALIO)

Maybe CONFIG_NFS_LOCALIO_SUPPORT here too?  And one more place below.

NeilBrown

