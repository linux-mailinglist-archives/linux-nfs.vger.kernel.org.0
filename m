Return-Path: <linux-nfs+bounces-6965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4039959D5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110C4286623
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C220A5F9;
	Tue,  8 Oct 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kjZNl190";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GOhcgQry";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kjZNl190";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GOhcgQry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334021503D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425363; cv=none; b=QKcyDzWA0e/8OlkkaDszvoXNiqfbc2wKAwBSlOzjo1vzrzaSvcwV9Jo9nWr2S+EffFl58bPAb5C0kBSHzh5vvIeqqPiSG6UMwLmC2B8Zd3E+ErdA913I6vrdjVvJUcAlilvv4o2W2LIjO1pHV/RpgUa7Di/NHe8rjXECHkA4JnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425363; c=relaxed/simple;
	bh=/rqvJ52A0itFqehiZJdf67vnk5A1FIavFj8PaN1giAI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hAzws+0tUgh5knhFVU2AxTWh1TBbBvAIrOZYXvN74yfEgYf6E1mtdIO2+HBPjwfa/sNytgXSMEVPDM72loPcMMhSpMocLTwSMl86Wh0m1G9P+7QQgeqrr1uDbvG65ritsJAn0a8eYMpxR/3M2AVtxv6UTO3pq4Lq7zmw8YAzOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kjZNl190; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GOhcgQry; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kjZNl190; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GOhcgQry; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0856221DB4;
	Tue,  8 Oct 2024 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728425359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkotE+TPRJnYQBiJydH8wrU/4LuRdbLUO6oE83aNUMU=;
	b=kjZNl1908RECwtP+49/wwN7X1uB0oaD69/0azuR0afZE9CYgfjnXwKF5lDyU/chMK264dW
	MPEJ9lBr51JqEIjV9jW2i0U63OtlwlXLldsm2Ip2S+WrF4j90raSCMiM8IvnX6xxTjxXBe
	OOskCgA8qxtFUzxB4VeeEApKkA3lFYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728425359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkotE+TPRJnYQBiJydH8wrU/4LuRdbLUO6oE83aNUMU=;
	b=GOhcgQryqDg1imirl3H17z9T/ea54f1oL1ZKDVw/RLEfl8HPwtPN6j6SFdzSz899dxq6v8
	5mEsv0WDNyj3xQCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kjZNl190;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GOhcgQry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728425359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkotE+TPRJnYQBiJydH8wrU/4LuRdbLUO6oE83aNUMU=;
	b=kjZNl1908RECwtP+49/wwN7X1uB0oaD69/0azuR0afZE9CYgfjnXwKF5lDyU/chMK264dW
	MPEJ9lBr51JqEIjV9jW2i0U63OtlwlXLldsm2Ip2S+WrF4j90raSCMiM8IvnX6xxTjxXBe
	OOskCgA8qxtFUzxB4VeeEApKkA3lFYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728425359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkotE+TPRJnYQBiJydH8wrU/4LuRdbLUO6oE83aNUMU=;
	b=GOhcgQryqDg1imirl3H17z9T/ea54f1oL1ZKDVw/RLEfl8HPwtPN6j6SFdzSz899dxq6v8
	5mEsv0WDNyj3xQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A361340C;
	Tue,  8 Oct 2024 22:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YfDIFoytBWd3JAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 08 Oct 2024 22:09:16 +0000
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
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 7/9] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
In-reply-to: <20241008134719.116825-18-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>,
 <20241008134719.116825-18-cel@kernel.org>
Date: Wed, 09 Oct 2024 09:09:13 +1100
Message-id: <172842535375.3184596.4875014047079014162@noble.neil.brown.name>
X-Rspamd-Queue-Id: 0856221DB4
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 09 Oct 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Enable the Linux NFS client to observe the progress of an offloaded
> asynchronous COPY operation. This new operation will be put to use
> in a subsequent patch.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c        | 122 ++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfs4proc.c         |   3 +-
>  include/linux/nfs_fs_sb.h |   1 +
>  3 files changed, 125 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 869605a0a9d5..175330843558 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -21,6 +21,8 @@
> =20
>  #define NFSDBG_FACILITY NFSDBG_PROC
>  static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *s=
td);
> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stat=
eid,
> +				     u64 *copied);
> =20
>  static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *na=
ddr)
>  {
> @@ -582,6 +584,126 @@ static int nfs42_do_offload_cancel_async(struct file =
*dst,
>  	return status;
>  }
> =20
> +static void nfs42_offload_status_done(struct rpc_task *task, void *calldat=
a)
> +{
> +	struct nfs42_offload_data *data =3D calldata;
> +
> +	if (!nfs4_sequence_done(task, &data->res.osr_seq_res))
> +		return;
> +
> +	switch (task->tk_status) {
> +	case 0:
> +		return;
> +	case -NFS4ERR_DELAY:
> +		if (nfs4_async_handle_error(task, data->seq_server,
> +					    NULL, NULL) =3D=3D -EAGAIN)
> +			rpc_restart_call_prepare(task);
> +		else
> +			task->tk_status =3D -EIO;
> +		break;
> +	case -NFS4ERR_GRACE:
> +	case -NFS4ERR_ADMIN_REVOKED:
> +	case -NFS4ERR_BAD_STATEID:
> +	case -NFS4ERR_OLD_STATEID:
> +		/*
> +		 * Server does not recognize the COPY stateid. CB_OFFLOAD
> +		 * could have purged it, or server might have rebooted.
> +		 * Since COPY stateids don't have an associated inode,
> +		 * avoid triggering state recovery.
> +		 */
> +		task->tk_status =3D -EBADF;
> +		break;
> +	case -NFS4ERR_NOTSUPP:
> +	case -ENOTSUPP:
> +	case -EOPNOTSUPP:
> +		data->seq_server->caps &=3D ~NFS_CAP_OFFLOAD_STATUS;
> +		task->tk_status =3D -EOPNOTSUPP;
> +		break;
> +	default:
> +		task->tk_status =3D -EIO;
> +	}
> +}
> +
> +static const struct rpc_call_ops nfs42_offload_status_ops =3D {
> +	.rpc_call_prepare =3D nfs42_offload_prepare,
> +	.rpc_call_done =3D nfs42_offload_status_done,
> +	.rpc_release =3D nfs42_offload_release
> +};
> +
> +/**
> + * nfs42_proc_offload_status - Poll completion status of an async copy ope=
ration
> + * @file: handle of file being copied
> + * @stateid: copy stateid (from async COPY result)
> + * @copied: OUT: number of bytes copied so far
> + *
> + * Return values:
> + *   %0: Server returned an NFS4_OK completion status
> + *   %-EINPROGRESS: Server returned no completion status
> + *   %-EREMOTEIO: Server returned an error completion status
> + *   %-EBADF: Server did not recognize the copy stateid
> + *   %-EOPNOTSUPP: Server does not support OFFLOAD_STATUS

 * %-ERESTARTSYS: a signal was received.

I'm wondering why this request is RPC_TASK_ASYNC rather than
rpc_call_sync().

NeilBrown


> + *
> + * Other negative errnos indicate the client could not complete the
> + * request.
> + */
> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stat=
eid,
> +				     u64 *copied)
> +{
> +	struct nfs_open_context *ctx =3D nfs_file_open_context(file);
> +	struct nfs_server *server =3D NFS_SERVER(file_inode(file));
> +	struct nfs42_offload_data *data =3D NULL;
> +	struct rpc_message msg =3D {
> +		.rpc_proc	=3D &nfs4_procedures[NFSPROC4_CLNT_OFFLOAD_STATUS],
> +		.rpc_cred	=3D ctx->cred,
> +	};
> +	struct rpc_task_setup task_setup_data =3D {
> +		.rpc_client	=3D server->client,
> +		.rpc_message	=3D &msg,
> +		.callback_ops	=3D &nfs42_offload_status_ops,
> +		.workqueue	=3D nfsiod_workqueue,
> +		.flags		=3D RPC_TASK_ASYNC | RPC_TASK_SOFTCONN,
> +	};
> +	struct rpc_task *task;
> +	int status;
> +
> +	if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
> +		return -EOPNOTSUPP;
> +
> +	data =3D kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	data->seq_server =3D server;
> +	data->args.osa_src_fh =3D NFS_FH(file_inode(file));
> +	memcpy(&data->args.osa_stateid, stateid,
> +		sizeof(data->args.osa_stateid));
> +	msg.rpc_argp =3D &data->args;
> +	msg.rpc_resp =3D &data->res;
> +	task_setup_data.callback_data =3D data;
> +	nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_res,
> +			   1, 0);
> +	task =3D rpc_run_task(&task_setup_data);
> +	if (IS_ERR(task)) {
> +		nfs42_offload_release(data);
> +		return PTR_ERR(task);
> +	}
> +	status =3D rpc_wait_for_completion_task(task);
> +	if (status)
> +		goto out;
> +
> +	*copied =3D data->res.osr_count;
> +	if (task->tk_status)
> +		status =3D task->tk_status;
> +	else if (!data->res.complete_count)
> +		status =3D -EINPROGRESS;
> +	else if (data->res.osr_complete[0] !=3D NFS_OK)
> +		status =3D -EREMOTEIO;
> +
> +out:
> +	rpc_put_task(task);
> +	return status;
> +}
> +
>  static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
>  				   struct nfs42_copy_notify_args *args,
>  				   struct nfs42_copy_notify_res *res)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index cd2fbde2e6d7..324e38b70b9f 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10763,7 +10763,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2=
_minor_ops =3D {
>  		| NFS_CAP_CLONE
>  		| NFS_CAP_LAYOUTERROR
>  		| NFS_CAP_READ_PLUS
> -		| NFS_CAP_MOVEABLE,
> +		| NFS_CAP_MOVEABLE
> +		| NFS_CAP_OFFLOAD_STATUS,
>  	.init_client =3D nfs41_init_client,
>  	.shutdown_client =3D nfs41_shutdown_client,
>  	.match_stateid =3D nfs41_match_stateid,
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 853df3fcd4c2..05b8deadd3b1 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -289,6 +289,7 @@ struct nfs_server {
>  #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
>  #define NFS_CAP_CASE_PRESERVING	(1U << 7)
>  #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
> +#define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
>  #define NFS_CAP_OPEN_XOR	(1U << 12)
>  #define NFS_CAP_DELEGTIME	(1U << 13)
>  #define NFS_CAP_POSIX_LOCK	(1U << 14)
> --=20
> 2.46.2
>=20
>=20
>=20


