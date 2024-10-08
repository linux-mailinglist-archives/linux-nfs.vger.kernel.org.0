Return-Path: <linux-nfs+bounces-6966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2D9959DB
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 00:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505531F22F3D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64DA21503D;
	Tue,  8 Oct 2024 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SX3Q6rby";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OBBqZSOK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ijZGrUEh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EPbzYn3k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AD213EE2
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425458; cv=none; b=tJygHgqAvQ3JaaR0z+H1gVKGOKc46LIKGGNQgTuOe+1RWgDCrLOzcRvmR4X6ORAA36OYKRUe9IJSBE3UhqqGI1BXktRg34ySxxNW/C6WcleUcpgInRVFmusAHpuyzfaRNhJmpaSKRJUyUSvYZEXBt8cgy0Ig+xUhI6l7Ou0jgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425458; c=relaxed/simple;
	bh=A3dfjI7ec7wG61coGgjLL2mr1iOZnDjRYtucgWNKgtg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JjliVWAISodkzP5pjVrxzTp4dPZnmHHpOZzFkbsyc/8iLq/iTC93+l9B5z9IsOCPr5oDFkLLvZP5ZXQX3k06mBYKQLanBWl0v28Zd3T3IjE+1ysalRPIYg+VqD8ri9W4Uh/Zdunt0XUGSh3m0hwVnAIv7UrCKM8UG4QMdGGC2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SX3Q6rby; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OBBqZSOK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ijZGrUEh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EPbzYn3k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E35E621DD9;
	Tue,  8 Oct 2024 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728425455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHjmDxAdSJCtCGVHCDB1HU87PBe3fYSOX6ZhJn5DbWQ=;
	b=SX3Q6rbyemjHxsd9/iXfaYekZ/OlRgadrmO+Y4Jnr3vP7EKYEd4WuOB54CuqTyiggEVWXb
	xnE4q3qSbZUyXJsDQAbeyk2y8uZlz/6t2Ycz6p/UmJfSUBoDunigKx+DeU3WpTqQMEN66q
	u1xi9r77BTZ45SjvGFjB8lIrcUWdvZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728425455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHjmDxAdSJCtCGVHCDB1HU87PBe3fYSOX6ZhJn5DbWQ=;
	b=OBBqZSOKIm7FdFDyNtDqRq0YAqHJut1bnEE/d/M0ZawGclkMkVPY7q9vPgH90TgPM/GgB/
	GObmUibRJAdmMdDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ijZGrUEh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EPbzYn3k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728425453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHjmDxAdSJCtCGVHCDB1HU87PBe3fYSOX6ZhJn5DbWQ=;
	b=ijZGrUEhTKoyKS5ANuxSXsEOhiIpM0vyOB2DI8lHOcX9WG/ow4A+xLMqF95uUNt3be9EjP
	1hWlCoPc+yVtLrzbpOzo5wkzLjwL7ajJHMO42OzahkMFT/LMtCdN1lN80CYfpWlFW1dUtR
	rX1vfNj26b+nFPDasBkdlwsPZHToaKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728425453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHjmDxAdSJCtCGVHCDB1HU87PBe3fYSOX6ZhJn5DbWQ=;
	b=EPbzYn3kTkGI4ea47dUC1fC7lkusq2ViaBTVlH2rva8h034CwVtxsinxKm/C0zXvh9ZBJM
	EZojVKBnhE9paIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46FD11340C;
	Tue,  8 Oct 2024 22:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OqUHAOutBWflJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 08 Oct 2024 22:10:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>
Subject: Re: [RFC PATCH 8/9] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
In-reply-to: <20241008134719.116825-19-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>,
 <20241008134719.116825-19-cel@kernel.org>
Date: Wed, 09 Oct 2024 09:10:44 +1100
Message-id: <172842544436.3184596.6687790135549454861@noble.neil.brown.name>
X-Rspamd-Queue-Id: E35E621DD9
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,netapp.com:email,oracle.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 09 Oct 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> We've found that there are cases where a transport disconnection
> results in the loss of callback RPCs. NFS servers typically do not
> retransmit callback operations after a disconnect.
>=20
> This can be a problem for the Linux NFS client's current
> implementation of asynchronous COPY, which waits indefinitely for a
> CB_OFFLOAD callback. If a transport disconnect occurs while an async
> COPY is running, there's a good chance the client will never get the
> completing CB_OFFLOAD.
>=20
> Fix this by implementing the OFFLOAD_STATUS operation so that the
> Linux NFS client can probe the NFS server if it doesn't see a
> CB_OFFLOAD in a reasonable amount of time.
>=20
> This patch implements a simplistic check. As future work, the client
> might also be able to detect whether there is no forward progress on
> the request asynchronous COPY operation, and CANCEL it.
>=20
> Suggested-by: Olga Kornievskaia <kolga@netapp.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218735
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c | 56 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 175330843558..fc4f64750dc5 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -175,6 +175,11 @@ int nfs42_proc_deallocate(struct file *filep, loff_t o=
ffset, loff_t len)
>  	return err;
>  }
> =20
> +/* Wait this long before checking progress on a COPY operation */
> +enum {
> +	NFS42_COPY_TIMEOUT	=3D 3 * HZ,
> +};
> +
>  static int handle_async_copy(struct nfs42_copy_res *res,
>  			     struct nfs_server *dst_server,
>  			     struct nfs_server *src_server,
> @@ -184,9 +189,10 @@ static int handle_async_copy(struct nfs42_copy_res *re=
s,
>  			     bool *restart)
>  {
>  	struct nfs4_copy_state *copy, *tmp_copy =3D NULL, *iter;
> -	int status =3D NFS4_OK;
>  	struct nfs_open_context *dst_ctx =3D nfs_file_open_context(dst);
>  	struct nfs_open_context *src_ctx =3D nfs_file_open_context(src);
> +	int status =3D NFS4_OK;
> +	u64 copied;
> =20
>  	copy =3D kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
>  	if (!copy)
> @@ -224,7 +230,9 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>  		spin_unlock(&src_server->nfs_client->cl_lock);
>  	}
> =20
> -	status =3D wait_for_completion_interruptible(&copy->completion);
> +wait:
> +	status =3D wait_for_completion_interruptible_timeout(&copy->completion,
> +							   NFS42_COPY_TIMEOUT);
>  	spin_lock(&dst_server->nfs_client->cl_lock);
>  	list_del_init(&copy->copies);
>  	spin_unlock(&dst_server->nfs_client->cl_lock);
> @@ -233,15 +241,21 @@ static int handle_async_copy(struct nfs42_copy_res *r=
es,
>  		list_del_init(&copy->src_copies);
>  		spin_unlock(&src_server->nfs_client->cl_lock);
>  	}
> -	if (status =3D=3D -ERESTARTSYS) {
> -		goto out_cancel;
> -	} else if (copy->flags || copy->error =3D=3D NFS4ERR_PARTNER_NO_AUTH) {
> -		status =3D -EAGAIN;
> -		*restart =3D true;
> +	switch (status) {
> +	case 0:
> +		goto timeout;
> +	case -ERESTARTSYS:
>  		goto out_cancel;
> +	default:
> +		if (copy->flags || copy->error =3D=3D NFS4ERR_PARTNER_NO_AUTH) {
> +			status =3D -EAGAIN;
> +			*restart =3D true;
> +			goto out_cancel;
> +		}
>  	}
>  out:
>  	res->write_res.count =3D copy->count;
> +	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
>  	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
>  	status =3D -copy->error;
> =20
> @@ -253,6 +267,34 @@ static int handle_async_copy(struct nfs42_copy_res *re=
s,
>  	if (!nfs42_files_from_same_server(src, dst))
>  		nfs42_do_offload_cancel_async(src, src_stateid);
>  	goto out_free;
> +timeout:
> +	status =3D nfs42_proc_offload_status(src, &copy->stateid, &copied);
> +	switch (status) {
> +	case 0:
> +	case -EREMOTEIO:
> +		/* The server recognized the copy stateid, so it hasn't
> +		 * rebooted. Don't overwrite the verifier returned in the
> +		 * COPY result. */
> +		res->write_res.count =3D copied;
> +		goto out_free;
> +	case -EINPROGRESS:
> +		goto wait;
> +	case -EBADF:
> +		/* Server did not recognize the copy stateid. It has
> +		 * probably restarted and lost the plot. State recovery
> +		 * might redrive the COPY from the beginning, in this
> +		 * case? */
> +		res->write_res.count =3D 0;
> +		status =3D -EREMOTEIO;
> +		break;
> +	case -EOPNOTSUPP:
> +		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
> +		 * it has signed up for an async COPY, so server is not
> +		 * spec-compliant. */
> +		res->write_res.count =3D 0;
> +		status =3D -EREMOTEIO;

Should -ERESTARTSYS be handled here?

NeilBrown


> +	}
> +	goto out;
>  }
> =20
>  static int process_copy_commit(struct file *dst, loff_t pos_dst,
> --=20
> 2.46.2
>=20
>=20
>=20


