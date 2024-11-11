Return-Path: <linux-nfs+bounces-7837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E969C35CD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFD31C20AB7
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C26749A;
	Mon, 11 Nov 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ztS4Fuhy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zXy9wlmt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ztS4Fuhy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zXy9wlmt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DA8468
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287380; cv=none; b=N6YLuEEVRqoheOawc3Rjddg+iSADu9NGtMsuO8FmIvr4qlNI9PLqml5F9uNaj4muD/8ThBPPE7TPK6osMAsohgABjLqpFdp1WX+zqxzXTfnyF1bdLPN/ANQLR8hUhWfRdR+0PFHH8dK+Cmj2lc6UeNlxG5iRyfg4+XrduNtwCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287380; c=relaxed/simple;
	bh=0eP2jvr56srMht+auMUU9NLZ+taYlmNkunuvGxuwPGc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ctAArqd5NlWL3Vmxb+vChDW5gssDGzMwW5KVBQJR14ujQsnFGhLOzwr8J/tieinnzsqYFh66DAa1bEcxnZWfGcGlaLPRd1v0w0hk7AUjwpNRdrtoamDllTlP1e8U0TUxzME9VYjoAoX6zcAsrrUIeixcuhdehN+zgZgcoQxEDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ztS4Fuhy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zXy9wlmt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ztS4Fuhy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zXy9wlmt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CD521F38E;
	Mon, 11 Nov 2024 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731287377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxMQj3qAqCam0QAxTyY08xzeuDYoGmao/lSr/ZNLsa8=;
	b=ztS4FuhyYeaVoiovtJzRv7qz5NOHZoSWf+2bqEhKTA3q0Irjt91GQLRu3rB9w4mDhnQGT3
	Ko04I1XQgF7JuPGplufOonTP1GAxFHT1YxOnKXWBhdQHtY5U9Ks7OlEuOJZJ72acuyCyXh
	H41nFmSqtCzQxuh/WHtwDA5T7IBsSsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731287377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxMQj3qAqCam0QAxTyY08xzeuDYoGmao/lSr/ZNLsa8=;
	b=zXy9wlmt5NSwU7sl2InpzpEVq4EQz3aBBAY+Af3BFKgFhSgCb5z8VgxlGUNkGmALSOo201
	SzZhae8q8KIfmdAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ztS4Fuhy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zXy9wlmt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731287377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxMQj3qAqCam0QAxTyY08xzeuDYoGmao/lSr/ZNLsa8=;
	b=ztS4FuhyYeaVoiovtJzRv7qz5NOHZoSWf+2bqEhKTA3q0Irjt91GQLRu3rB9w4mDhnQGT3
	Ko04I1XQgF7JuPGplufOonTP1GAxFHT1YxOnKXWBhdQHtY5U9Ks7OlEuOJZJ72acuyCyXh
	H41nFmSqtCzQxuh/WHtwDA5T7IBsSsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731287377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxMQj3qAqCam0QAxTyY08xzeuDYoGmao/lSr/ZNLsa8=;
	b=zXy9wlmt5NSwU7sl2InpzpEVq4EQz3aBBAY+Af3BFKgFhSgCb5z8VgxlGUNkGmALSOo201
	SzZhae8q8KIfmdAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EC07137FB;
	Mon, 11 Nov 2024 01:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7mvxLU5ZMWc2dwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:09:34 +0000
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
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [for-6.13 PATCH 03/19] nfs/localio: remove redundant suid/sgid handling
In-reply-to: <20241108234002.16392-4-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-4-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:09:31 +1100
Message-id: <173128737184.1734440.5770202798702410278@noble.neil.brown.name>
X-Rspamd-Queue-Id: 1CD521F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> From: Mike Snitzer <snitzer@hammerspace.com>
>=20
> nfs_writeback_done() will take care of suid/sgid corner case.

The code removed is from nfs_local_write_done().
That is called only in nfs_local_call_write() and nfs_local_pgio_release
is called shortly afterwards.  That calls nfs_local_hdr_release() which
calls ->rpc_call_done which will be nfs_pgio_result (or something that
eventually calls nfs_pgio_result via some other ->rpc_call_done)
nfs_pgio_result calls ->rw_done which will be nfs_writeback_done which,
as you say, already contains that code.

So it looks good.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 637528e6368e..4b24933093b6 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -527,12 +527,7 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, lon=
g status)
>  	}
>  	if (status < 0)
>  		nfs_reset_boot_verifier(inode);
> -	else if (nfs_should_remove_suid(inode)) {
> -		/* Deal with the suid/sgid bit corner case */
> -		spin_lock(&inode->i_lock);
> -		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
> -		spin_unlock(&inode->i_lock);
> -	}
> +
>  	nfs_local_pgio_done(hdr, status);
>  }
> =20
> --=20
> 2.44.0
>=20
>=20


