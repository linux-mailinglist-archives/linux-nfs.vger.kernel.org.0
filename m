Return-Path: <linux-nfs+bounces-8767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92F9FC2DD
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 00:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FA51883CC9
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4BF3EA76;
	Tue, 24 Dec 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lWkQBUjs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OBl0ruFU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lWkQBUjs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OBl0ruFU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328054782
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735082352; cv=none; b=duuOykSgoZ3xzF7fxwqhcqqV7eAF0PvZFYmgrkdO2ytiYiP7ijJZE04VfjinFuzmsSJT4cVt+Fwnb1hOvVlibXkGoWQhErbgcWPBx6sRrpQZZUAys/Lg4FYhqbiulESZCwcnzkxghAdzkj+GWwgdsFRbmmKxVpl/D7ZJlNk7Zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735082352; c=relaxed/simple;
	bh=ce8olqzDgzCx108moaZx+S60iXd9BgYcXkeT/4d3Aso=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GLY5IyNCzjgjhWuSwj5rh+GNF+Kv96Hnr+pCACjgrkwYRFLHOnWctiGtejxeyM5Sfkr2zcidZqiCVq+b/8b8anxMUO48LfX62zDduRSBiGNI06PQ/bRB/QeakAedBvxL2PIcZwdcOy0Zb1cXbgRfTWlMk+l1IeNGmsHdM4bqSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lWkQBUjs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OBl0ruFU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lWkQBUjs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OBl0ruFU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FDB820B4C;
	Tue, 24 Dec 2024 23:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735082349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOI6roCVt3XOBW/elM0IQ7VA/8GKBPb+beywltrllp8=;
	b=lWkQBUjs8dxaJFkj0qUPJKPxoVKOmJJqisL2/MrIk6BBPadUpXwLost1thiRc67sOYeGey
	DBjT8drr9RYwpsfoMwuoZcz2cAIaGEoXtdIUgd1flneArOthMsZBPFOvTTRmQArTllaTR8
	KWjNvT8z/dP+5CpZ7Z4fyhHHWNFlOzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735082349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOI6roCVt3XOBW/elM0IQ7VA/8GKBPb+beywltrllp8=;
	b=OBl0ruFU+mVwqQcV6k73Pd+2a4s1+ejJDUsImqoX8IXQIevC/MbfxtQNcEG7puX6cWfIDK
	G1dvb4Ssknn4h1Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735082349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOI6roCVt3XOBW/elM0IQ7VA/8GKBPb+beywltrllp8=;
	b=lWkQBUjs8dxaJFkj0qUPJKPxoVKOmJJqisL2/MrIk6BBPadUpXwLost1thiRc67sOYeGey
	DBjT8drr9RYwpsfoMwuoZcz2cAIaGEoXtdIUgd1flneArOthMsZBPFOvTTRmQArTllaTR8
	KWjNvT8z/dP+5CpZ7Z4fyhHHWNFlOzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735082349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOI6roCVt3XOBW/elM0IQ7VA/8GKBPb+beywltrllp8=;
	b=OBl0ruFU+mVwqQcV6k73Pd+2a4s1+ejJDUsImqoX8IXQIevC/MbfxtQNcEG7puX6cWfIDK
	G1dvb4Ssknn4h1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6102313A6D;
	Tue, 24 Dec 2024 23:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ksLBmpBa2cMXAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 24 Dec 2024 23:19:06 +0000
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
 "Rick Macklem" <rick.macklem@gmail.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "J David" <j.david.lists@gmail.com>
Subject:
 Re: [PATCH v2 1/2] NFSD: Encode COMPOUND operation status on page boundaries
In-reply-to: <20241223180724.1804-5-cel@kernel.org>
References: <20241223180724.1804-4-cel@kernel.org>,
 <20241223180724.1804-5-cel@kernel.org>
Date: Wed, 25 Dec 2024 10:19:03 +1100
Message-id: <173508234339.11072.6073436862662738502@noble.neil.brown.name>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 24 Dec 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> J. David reports an odd corruption of a READDIR reply sent to a
> FreeBSD client.
>=20
> xdr_reserve_space() has to do a special trick when the @nbytes value
> requests more space than there is in the current page of the XDR
> buffer.
>=20
> In that case, xdr_reserve_space() returns a pointer to the start of
> the next page, and then the next call to xdr_reserve_space() invokes
> __xdr_commit_encode() to copy enough of the data item back into the
> previous page to make that data item contiguous across the page
> boundary.
>=20
> But we need to be careful in the case where buffer space is reserved
> early for a data item that will be inserted into the buffer later.
>=20
> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
> encoding buffer for each COMPOUND operation. However, a READDIR
> result can sometimes encode file names so that there are only 4
> bytes left at the end of the current XDR buffer page (though plenty
> of pages are left to handle the remaining encoding tasks).
>=20
> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
> then nfsd4_encode_operation() will reserve 8 bytes for the op number
> (9) and the op status (usually NFS4_OK). In this weird case,
> xdr_reserve_space() returns a pointer to byte zero of the next buffer
> page, as it assumes the data item will be copied back into place (in
> the previous page) on the next call to xdr_reserve_space().
>=20
> nfsd4_encode_operation() writes the op num into the buffer, then
> saves the next 4-byte location for the op's status code. The next
> xdr_reserve_space() call is part of GETATTR encoding, so the op num
> gets copied back into the previous page, but the saved location for
> the op status continues to point to the wrong spot in the current
> XDR buffer page because __xdr_commit_encode() moved that data item.
>=20
> After GETATTR encoding is complete, nfsd4_encode_operation() writes
> the op status over the first XDR data item in the GETATTR result.
> The NFS4_OK status code (0) makes it look like there are zero items
> in the GETATTR's attribute bitmask.
>=20
> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
> across page boundaries") [2014] remarks that NFSD "can't handle a
> new operation starting close to the end of a page." This bug appears
> to be one reason for that remark.
>=20
> Reported-by: J David <j.david.lists@gmail.com>
> Closes: https://lore.kernel.org/linux-nfs/3998d739-c042-46b4-8166-dbd6c5f0e=
804@oracle.com/T/#t
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 53fac037611c..15cd716e9d91 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5760,15 +5760,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *re=
sp, struct nfsd4_op *op)
>  	struct nfs4_stateowner *so =3D resp->cstate.replay_owner;
>  	struct svc_rqst *rqstp =3D resp->rqstp;
>  	const struct nfsd4_operation *opdesc =3D op->opdesc;
> -	int post_err_offset;
> +	unsigned int op_status_offset;

As most uses of "op_status_offset" add XDR_UNIT I'd be incline to keep
the "post" offset.

   unsigned int op_status_offset, post_status_offset;

>  	nfsd4_enc encoder;
> -	__be32 *p;
> =20
> -	p =3D xdr_reserve_space(xdr, 8);
> -	if (!p)
> +	if (xdr_stream_encode_u32(xdr, op->opnum) !=3D XDR_UNIT)
> +		goto release;
> +	op_status_offset =3D xdr_stream_pos(xdr);
> +	if (!xdr_reserve_space(xdr, 4))

The underlying message of this bug seems to be that xdr_reserve_space()
is a low-level interface that probably shouldn't be used outside of xdr
code.
So I wonder if we could use
    op_status_offset =3D xdr_stream_pos(xdr);
    if (xdr_stream_encode_u32(xdr, NFS4ERR_SERVERFAULT) < 0) //will be over-w=
ritten
           goto release;
    post_status_offset =3D xdr_stream_pos(xdr);

instead??

But these are minor thoughts - only use them if you like them.
Generally this is a definite improvement.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

