Return-Path: <linux-nfs+bounces-7038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DDD9993FA
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536D91C22757
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDB1E104F;
	Thu, 10 Oct 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioi7JaFI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pOzR+17/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioi7JaFI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pOzR+17/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B71CF5C5
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593661; cv=none; b=ma/0m/0bK1kxghFKqqKNqjmkEqQm+u2f+xdot2Drgjeem7gnCu58EKq2NSbVtEJIf9JX8Gfgd7wtYPBcKFluy8mdUJo+mp5wttnpajwYoBt/DQRlNA33QEJd/74m84Z5fHcdQQUKRVB/h6CjRgmjsAX+HwReIgDhEiGfJgOKddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593661; c=relaxed/simple;
	bh=1mE92vWTh9U7lxwvG9Sc8Yj8epR/+UFcdwfrd9CUkNY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Z3VSutkn2+dCda17LPMLzvvDRwXEJxgw2nmwD4gxHa/MSh7zlcaGKmF9qcJ+YFd17GK/TxQHCi9kQpuI3rLptIUAeIeNxpFFUmo8I0Q4gJ5vEZiC36iyaG6qo+WtQC8GKzGFAVyk0vB++EmywBu34mSUS/f6XpIOivWHve2RmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioi7JaFI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pOzR+17/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioi7JaFI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pOzR+17/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FAE71FE32;
	Thu, 10 Oct 2024 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728593657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qh9vDbaKbAMD/Cw6++LBWxYm+31eADhL+y4Pw2pBNc=;
	b=ioi7JaFIRsJwHNp6aNTd5/98R88JegCWpQWzG+2kXcEEdNf7K37Oc4D+DUGOeZMZvcxRrC
	8E0gc4FRt0bCd/72H5yn1GCc6R23ZYWEIYUV/VvaaX859oZRmEQSMNb2yzaPJljPCx6pVZ
	ua7GL6mHIg4CwuHTXj54WKIuzXukjDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728593657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qh9vDbaKbAMD/Cw6++LBWxYm+31eADhL+y4Pw2pBNc=;
	b=pOzR+17/SUlLmNSDBsaUpNAJnLzFjtwx3azBUd+pHZ+SZyNmyOGnLBa7QgRomSiOdp83WA
	a4hXUKVFZw6Lo4DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728593657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qh9vDbaKbAMD/Cw6++LBWxYm+31eADhL+y4Pw2pBNc=;
	b=ioi7JaFIRsJwHNp6aNTd5/98R88JegCWpQWzG+2kXcEEdNf7K37Oc4D+DUGOeZMZvcxRrC
	8E0gc4FRt0bCd/72H5yn1GCc6R23ZYWEIYUV/VvaaX859oZRmEQSMNb2yzaPJljPCx6pVZ
	ua7GL6mHIg4CwuHTXj54WKIuzXukjDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728593657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qh9vDbaKbAMD/Cw6++LBWxYm+31eADhL+y4Pw2pBNc=;
	b=pOzR+17/SUlLmNSDBsaUpNAJnLzFjtwx3azBUd+pHZ+SZyNmyOGnLBa7QgRomSiOdp83WA
	a4hXUKVFZw6Lo4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4588F1370C;
	Thu, 10 Oct 2024 20:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G7joOvY+CGcBWgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 10 Oct 2024 20:54:14 +0000
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
Subject: Re: [RFC PATCH] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
In-reply-to: <20241010153331.143845-2-cel@kernel.org>
References: <20241010153331.143845-2-cel@kernel.org>
Date: Fri, 11 Oct 2024 07:54:12 +1100
Message-id: <172859365233.444407.16539980656364255099@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
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

On Fri, 11 Oct 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> NFSv4 LOCK operations should not avoid the set of authorization
> checks that apply to all other NFSv4 operations. Also, the
> "no_auth_nlm" export option should apply only to NLM LOCK requests.
> It's not necessary or sensible to apply it to NFSv4 LOCK operations.
>=20
> The replacement MAY bit mask,
> "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE", comes from the access
> bits that are set in nfsd_permission() when the caller has set
> NFSD_MAY_LOCK.
>=20
> Reported-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9c2b1d251ab3..3f2c11414390 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7967,11 +7967,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	if (check_lock_length(lock->lk_offset, lock->lk_length))
>  		 return nfserr_inval;
> =20
> -	if ((status =3D fh_verify(rqstp, &cstate->current_fh,
> -				S_IFREG, NFSD_MAY_LOCK))) {
> -		dprintk("NFSD: nfsd4_lock: permission denied!\n");
> +	status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG,
> +			   NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE);
> +	if (status !=3D nfs_ok)
>  		return status;
> -	}

Reviewed-by: NeilBrown <neilb@suse.de>

though I think we want a follow-on patch which uses NFSD_MAY_WRITE for
write locks for consistency with check_fmode_for_setlk().

And I'm wondering about NFSD_MAY_OWNER_OVERRIDE ...  that is really an
NFSv3 thing.  For NFSv4 we should be checking permission at "open" time,
recording that in the state (both of which we do) and then performing
permission checks against the state rather than against the inode.
But that is a whole different can of worms.

Thanks,
NeilBrown


>  	sb =3D cstate->current_fh.fh_dentry->d_sb;
> =20
>  	if (lock->lk_is_new) {
> --=20
> 2.46.2
>=20
>=20


