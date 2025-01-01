Return-Path: <linux-nfs+bounces-8863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B19FF509
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 22:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3EA1881B80
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAB38382;
	Wed,  1 Jan 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UR+yKyKh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mng+BVCL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UR+yKyKh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mng+BVCL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CA18AFC
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735768162; cv=none; b=SqsjzdRKmR7iFiLDggvp/c0PCYwRNr78qEMCscxmrWjMT3eTvdIqwcZgyCziMTudGP6Je2s/ZkxOk72IBoGzeU9slC5+rct31bcaAcG8QfJTe5cVpzyo8pGqEHFo912FiXPNRHIqX/fImWgkIhdnT882F4G/3kXwv+pwGHqkC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735768162; c=relaxed/simple;
	bh=X2q+8juDKMtw7slhbyqmXkulSM5+bCjiRBmp2HZTKOQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=d6ypfHOA04+6gRM8j6X+yAFMxtkAN9RPZ+5oIA8wwnfB6a/7UVQ0qsMRWryxQ2pZsrpn1l7VC6Vid4pRvrIqNZOpDdCzFhbcXqadvr3+MLVDLY3OMdiIyXvR8PVmanjevmRLgqs6H44De8JJlHOUhuPvO8do8jrf2wlY0PwXbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UR+yKyKh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mng+BVCL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UR+yKyKh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mng+BVCL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 386F921106;
	Wed,  1 Jan 2025 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735768158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQRBW+GvVuLeneRC5BBH3f79WY1mjiu+QzKVvt2H7Do=;
	b=UR+yKyKh7sXxQqp59s6Us8VhmFRP1wXo58Pm8S2gvS4Q0Z/mr3V8+AKj8ajSZMJMg0AUDS
	pVvKdcZbKvd3KefgUvrZ2jluhcnDJ8pRtIG2erkqBw35zaqWY0lsWK38bc2Ta5oWmqwF6K
	p3oLarxUezkNa3xPznknP5Po3mdNah8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735768158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQRBW+GvVuLeneRC5BBH3f79WY1mjiu+QzKVvt2H7Do=;
	b=Mng+BVCL39FezMuhypsM+/rNs3Bk5WlaUXE14nLHRtKnA0MKZKg0CszXO6VvpgrP0hFM5Q
	Z1BIR49KDBmBavAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UR+yKyKh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mng+BVCL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735768158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQRBW+GvVuLeneRC5BBH3f79WY1mjiu+QzKVvt2H7Do=;
	b=UR+yKyKh7sXxQqp59s6Us8VhmFRP1wXo58Pm8S2gvS4Q0Z/mr3V8+AKj8ajSZMJMg0AUDS
	pVvKdcZbKvd3KefgUvrZ2jluhcnDJ8pRtIG2erkqBw35zaqWY0lsWK38bc2Ta5oWmqwF6K
	p3oLarxUezkNa3xPznknP5Po3mdNah8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735768158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQRBW+GvVuLeneRC5BBH3f79WY1mjiu+QzKVvt2H7Do=;
	b=Mng+BVCL39FezMuhypsM+/rNs3Bk5WlaUXE14nLHRtKnA0MKZKg0CszXO6VvpgrP0hFM5Q
	Z1BIR49KDBmBavAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A14713A30;
	Wed,  1 Jan 2025 21:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ARNVM1q4dWflNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 01 Jan 2025 21:49:14 +0000
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
Subject: Re: [PATCH v4 9/9] SUNRPC: Document validity guarantees of the
 pointer returned by reserve_space
In-reply-to: <20241231002901.12725-10-cel@kernel.org>
References: <20241231002901.12725-1-cel@kernel.org>,
 <20241231002901.12725-10-cel@kernel.org>
Date: Thu, 02 Jan 2025 08:49:12 +1100
Message-id: <173576815212.22054.16464131258444633667@noble.neil.brown.name>
X-Rspamd-Queue-Id: 386F921106
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 31 Dec 2024, cel@kernel.org wrote:
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
>  net/sunrpc/xdr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 62e07c330a66..4e003cb516fe 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1097,6 +1097,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(s=
truct xdr_stream *xdr,
>   * Checks that we have enough buffer space to encode 'nbytes' more
>   * bytes of data. If so, update the total xdr_buf length, and
>   * adjust the length of the current kvec.
> + *
> + * The returned pointer is valid only until the next call to
> + * xdr_reserve_space() or xdr_commit_encode() on @xdr. The current
> + * implementation of this API guarantees that space reserved for a
> + * four-byte data item remains valid until @xdr is destroyed, but
> + * that might not always be true in the future.
>   */
>  __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
>  {
> --=20

This series all looks good to me
Reviewed-by: NeilBrown <neilb@suse.de>

though I do wonder if it would be better make the "four-byte" behaviour
a guaranteed part of the API rather than working around a problem that
doesn't currently exist and quite possibly never will.

Thanks,
NeilBrown

