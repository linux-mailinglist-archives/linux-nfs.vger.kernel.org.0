Return-Path: <linux-nfs+bounces-8795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB919FCE83
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 23:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D4F3A02F5
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F00156880;
	Thu, 26 Dec 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aVu4Khbg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VVeZZltJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aVu4Khbg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VVeZZltJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6F33E1
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735252604; cv=none; b=KwWNccRPNjWTz3ZsF8naV+1tJrzArTmOWzIskcqMOCptMtU7ndmYlByuqrYVDQgBrqZDpWkZr5LwxwdsawVAd81ox1gLI3X8o91rTz0n7oEdBle+enlqjhpS51CRBHbgMYNUX63I9gLdiLINQcYZvZ3djmH0cOQbuUfoaMk4gP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735252604; c=relaxed/simple;
	bh=ozNFQKTz/3kT6kU/yVRIBiGb6r57SaX1wSl8JCcgBq8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b3f81fbehxdGBJBjKFzwd7P1cNgKllgi0aKCH9Ky4AUMtiSA6NbO/twYhxxKUT+RgxD4c/LEZ+eg7NIqtqlksJH87wF/6MIgIdEFtA4t5VOnFa+fnwRf2Ws5UPt2m1nwb0Tg8a0i0U0B2hzFBNs+lIbMBPIT3DxwkhGU0Lt/ZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aVu4Khbg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VVeZZltJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aVu4Khbg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VVeZZltJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5B020B4C;
	Thu, 26 Dec 2024 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735252594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvwiILjWKxAkytQki+qTicxo7DTXeEaYrIdvD+loO+c=;
	b=aVu4Khbg2pvD7XWK4y636vNHzAGrYOOH0D4ODOUE7FPEoJ7ndoOl7sXOWASKjudkaeFAgL
	dBwttuX16PcrO4xIpZZJ6Zoi2BBIRkVfLH77IUrazgc2ez1GPrTD7YUHKpcoEORNZYR9Kd
	iuZdusJIqi/Ra9lHTF2uSp1EaG8Ok2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735252594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvwiILjWKxAkytQki+qTicxo7DTXeEaYrIdvD+loO+c=;
	b=VVeZZltJGxzuqzKvW0Hp+TSbH9I5+tbQ28sRsupG+MY67wsaZX0jrEVlDt5lUMWzmvlDgd
	PkM4yiJQTB+bldDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aVu4Khbg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VVeZZltJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735252594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvwiILjWKxAkytQki+qTicxo7DTXeEaYrIdvD+loO+c=;
	b=aVu4Khbg2pvD7XWK4y636vNHzAGrYOOH0D4ODOUE7FPEoJ7ndoOl7sXOWASKjudkaeFAgL
	dBwttuX16PcrO4xIpZZJ6Zoi2BBIRkVfLH77IUrazgc2ez1GPrTD7YUHKpcoEORNZYR9Kd
	iuZdusJIqi/Ra9lHTF2uSp1EaG8Ok2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735252594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvwiILjWKxAkytQki+qTicxo7DTXeEaYrIdvD+loO+c=;
	b=VVeZZltJGxzuqzKvW0Hp+TSbH9I5+tbQ28sRsupG+MY67wsaZX0jrEVlDt5lUMWzmvlDgd
	PkM4yiJQTB+bldDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 251D613999;
	Thu, 26 Dec 2024 22:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1BQ8Mm7abWesNQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 26 Dec 2024 22:36:30 +0000
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
 "Rick Macklem" <rick.macklem@gmail.com>, j.david.lists@gmail.com,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 6/6] SUNRPC: Document validity guarantees of the
 pointer returned by reserve_space
In-reply-to: <20241226162853.8940-7-cel@kernel.org>
References: <20241226162853.8940-1-cel@kernel.org>,
 <20241226162853.8940-7-cel@kernel.org>
Date: Fri, 27 Dec 2024 09:36:28 +1100
Message-id: <173525258802.11072.15894870883388643692@noble.neil.brown.name>
X-Rspamd-Queue-Id: 3E5B020B4C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Fri, 27 Dec 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> A subtlety of this API is that if the @nbytes region traverses a
> page boundary, the next __xdr_commit_encode will shift the data item
> in the XDR encode buffer. This makes the returned pointer point to
> something else, leading to unexpected behavior.
>=20
> There are a few cases where the caller saves the returned pointer
> and then later uses it to insert a computed value into an earlier
> part of the stream. This can be safe only if either:
>=20
>  - the data item is guaranteed to be in the XDR buffer's head, and
>    thus is not ever going to be near a page boundary, or
>  - the data item is no larger than 4 octets, since XDR alignment
>    rules require all data items to start on 4-octet boundaries
>=20
> But that safety is only an artifact of the current implementation.
> It would be less brittle if these "safe" uses were eventually
> replaced.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xdr.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 62e07c330a66..f198bb043e2f 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1097,6 +1097,9 @@ static noinline __be32 *xdr_get_next_encode_buffer(st=
ruct xdr_stream *xdr,
>   * Checks that we have enough buffer space to encode 'nbytes' more
>   * bytes of data. If so, update the total xdr_buf length, and
>   * adjust the length of the current kvec.
> + *
> + * The returned pointer is valid only until the next call to
> + * xdr_reserve_space() or xdr_commit_encode() on this stream.

There are still several places where the return value of
xdr_reserver_space is stored for longer than advised here.

- there are several in nfs/callback_xdr.c
  e.g. encode_compound_hdr
- there is attrlen_p in nfsd4_encode_fattr4
- maxcount_p in nfsd4_encode_readlink
- flavors_p in nfsd4_do_encode_secinfo
- rqstp->rq_accept_statp which is initialied in svcxdr_set_accept_stat
  and updated in many places.
- segcount in rpcrdma_encode_write_list
- segcount in rpcrdma_encode_reply_chunk

These are all safe because of the "4 octets" rule.  Should we include
that in the documenting comment, or would you rather all of these
be change to use an offset rather than a pointer?

Thanks,
NeilBrown

