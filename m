Return-Path: <linux-nfs+bounces-6963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F3995975
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 23:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47A228419C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89F194A4B;
	Tue,  8 Oct 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVly4ZSc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Rkw95LO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVly4ZSc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Rkw95LO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0214A82
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424476; cv=none; b=I6p9S0MJcLVvne2RVxbxX5dlX5kO6gh/t+eHq4/+Vq2X7t6tO/QlZJCkrbXbYM4uLif8wHJxI5FtgIpknnsXnXu234a9lTFTdjXA5GDbOELrO0046+HDx3Xn8MkXz9RpCJ1gBbDKAj2SjlndHue/yswNnYZnrzuvBiZKaL5SGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424476; c=relaxed/simple;
	bh=JWK05OPh2TmL7PcuNPykr4TNkLP8aci1S64T5/myP7c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uHoJolHjms8muNXy4cqmdpO028rJxMOrOm/73qlI6M4XyY1q1Kw4byGOBwRoGcVIhIyfn0xciGPcR7IhKJ484geMeTnCbMjyb7WYnN0couUY48C1wXtL2kYgGNt8txummRc3MLWAbXZ4M2NHTtm2WYpSlLy1FTYH32SJQnh5CIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVly4ZSc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Rkw95LO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVly4ZSc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Rkw95LO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CDAF21DCE;
	Tue,  8 Oct 2024 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728424472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZdIcGiWynedGUPVLh1IL+D+YTTnxLnQ5CCiZe4dWpc=;
	b=yVly4ZScFmbCYRubEgTi8k96W75lJETKWEpZHCS8rvweqCzG4m9qmuoi/8M8JPNGjWIgN3
	aO/JexRhaaLKufFL00hLMQYrIiJawVlHDVW00igATEm/yBC6xDvVO7I6K+NK0J1m6D2e8J
	6ixI6d4cqm2RjbupL5ms72+S+H8LMN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728424472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZdIcGiWynedGUPVLh1IL+D+YTTnxLnQ5CCiZe4dWpc=;
	b=6Rkw95LOBEEFwg6WQ1alIl1bVL7oITE4TAZmlHpE8bNB3rT1jzjc/TEJMJ1ed4rzb/KS0B
	4XCaXHin3o+zvYBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yVly4ZSc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6Rkw95LO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728424472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZdIcGiWynedGUPVLh1IL+D+YTTnxLnQ5CCiZe4dWpc=;
	b=yVly4ZScFmbCYRubEgTi8k96W75lJETKWEpZHCS8rvweqCzG4m9qmuoi/8M8JPNGjWIgN3
	aO/JexRhaaLKufFL00hLMQYrIiJawVlHDVW00igATEm/yBC6xDvVO7I6K+NK0J1m6D2e8J
	6ixI6d4cqm2RjbupL5ms72+S+H8LMN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728424472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZdIcGiWynedGUPVLh1IL+D+YTTnxLnQ5CCiZe4dWpc=;
	b=6Rkw95LOBEEFwg6WQ1alIl1bVL7oITE4TAZmlHpE8bNB3rT1jzjc/TEJMJ1ed4rzb/KS0B
	4XCaXHin3o+zvYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A03D1340C;
	Tue,  8 Oct 2024 21:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t62ROBWqBWedIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 08 Oct 2024 21:54:29 +0000
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
Subject:
 Re: [RFC PATCH 3/9] NFSD: Handle an NFS4ERR_DELAY response to CB_OFFLOAD
In-reply-to: <20241008134719.116825-14-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>,
 <20241008134719.116825-14-cel@kernel.org>
Date: Wed, 09 Oct 2024 08:54:27 +1100
Message-id: <172842446733.3184596.10111637311114452090@noble.neil.brown.name>
X-Rspamd-Queue-Id: 8CDAF21DCE
X-Spam-Level: 
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
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 09 Oct 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> RFC 7862 permits callback services to respond to CB_OFFLOAD with
> NFS4ERR_DELAY. Currently NFSD drops the CB_OFFLOAD in that case.
>=20
> To improve the reliability of COPY offload, NFSD should rather send
> another CB_OFFLOAD completion notification.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 8 ++++++++
>  fs/nfsd/xdr4.h     | 1 +
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a3c564a9596c..02e73ebbfe5c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1613,6 +1613,13 @@ static int nfsd4_cb_offload_done(struct nfsd4_callba=
ck *cb,
>  		container_of(cb, struct nfsd4_cb_offload, co_cb);
> =20
>  	trace_nfsd_cb_offload_done(&cbo->co_res.cb_stateid, task);
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		if (cbo->co_retries--) {
> +			rpc_delay(task, 1 * HZ);
> +			return 0;

Is 5 tries at 1 second interval really sufficient?
It is common to double the delay on each retry failure, so delays of=20
1,2,4,8,16 would give at total of 30 seconds for the client to get over
whatever congestion is affecting it.  That seems safer.

NeilBrown

> +		}
> +	}
>  	return 1;
>  }
> =20
> @@ -1742,6 +1749,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *=
copy)
>  	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
>  	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
>  	cbo->co_nfserr =3D copy->nfserr;
> +	cbo->co_retries =3D 5;
> =20
>  	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
>  		      NFSPROC4_CLNT_CB_OFFLOAD);
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index dec29afa43f3..cd2bf63651e3 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -675,6 +675,7 @@ struct nfsd4_cb_offload {
>  	struct nfsd4_callback	co_cb;
>  	struct nfsd42_write_res	co_res;
>  	__be32			co_nfserr;
> +	unsigned int		co_retries;
>  	struct knfsd_fh		co_fh;
>  };
> =20
> --=20
> 2.46.2
>=20
>=20
>=20


