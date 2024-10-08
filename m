Return-Path: <linux-nfs+bounces-6964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF899598D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A1B1C21D8C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F74215025;
	Tue,  8 Oct 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xToHYUXt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o1z0nvS0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xToHYUXt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o1z0nvS0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF344208AD
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424822; cv=none; b=tW+eIM1ugh+fBf+n2PRhFniqkiGSYEIY7OQ7Qc4iZ1BB9dYvFKQMwNUrFVhUe1aogSwppdQvlS68I7lZ14JXY198cBQBbVrpvOfA7ywep/AAHmwqj2sofjRDtblUl+tKuZHNA/gXZ5ERFQNElFpw2D6MH7JccGFJmwwRNnPmTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424822; c=relaxed/simple;
	bh=PV1mn9KGYd1o23+5fZ2NGioMItpntVwDXKgkaOOmkII=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FqDFzTXTZo5nNKQUiEyVVK0a0hY0LNkmxKObxWuQoxt5TSBlnnPnDtTLh6LxZRFzDWgwQokWtPBrZhtvheUnmA6miUTOjDpX/6VM3Zo9U2TBMSwmcGSb9J/V2IySVs1EdGibeQgTMoy6ElKO3ql8lhenpZdHfeby1MN68TZvF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xToHYUXt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o1z0nvS0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xToHYUXt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o1z0nvS0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22C601FE17;
	Tue,  8 Oct 2024 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728424819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2gDtuaWtZh5FhfVxXir7rr6vQBzOsc6TOHY7dgMIEY=;
	b=xToHYUXtlRZuBYoViz9FG4VxSAdAHpvfqbPIJ1KR6/l6fyMsQrci9vcxxj9GFVacjIMeOq
	pplfy52yV9gPq2gbi5Eg7OnhScKBMmSJY9fKd9I7G/rF7wuYISH998/wxHoOEFeHvJhZrC
	yxeiiQtaeCqO38LCY/e7rP0O/dBwOLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728424819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2gDtuaWtZh5FhfVxXir7rr6vQBzOsc6TOHY7dgMIEY=;
	b=o1z0nvS0Ena4nFJ2x5Y4RvEMan5LASAo145SHM9PknKxHu0iX9+cO9DBaEwKz95LdeLKrk
	lxJGV3GaAR0jDzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728424819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2gDtuaWtZh5FhfVxXir7rr6vQBzOsc6TOHY7dgMIEY=;
	b=xToHYUXtlRZuBYoViz9FG4VxSAdAHpvfqbPIJ1KR6/l6fyMsQrci9vcxxj9GFVacjIMeOq
	pplfy52yV9gPq2gbi5Eg7OnhScKBMmSJY9fKd9I7G/rF7wuYISH998/wxHoOEFeHvJhZrC
	yxeiiQtaeCqO38LCY/e7rP0O/dBwOLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728424819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2gDtuaWtZh5FhfVxXir7rr6vQBzOsc6TOHY7dgMIEY=;
	b=o1z0nvS0Ena4nFJ2x5Y4RvEMan5LASAo145SHM9PknKxHu0iX9+cO9DBaEwKz95LdeLKrk
	lxJGV3GaAR0jDzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC2391340C;
	Tue,  8 Oct 2024 22:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZnE4HHCrBWc0IgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 08 Oct 2024 22:00:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Subject: Re: [RFC PATCH 5/9] NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
In-reply-to: <20241008134719.116825-16-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>,
 <20241008134719.116825-16-cel@kernel.org>
Date: Wed, 09 Oct 2024 09:00:13 +1100
Message-id: <172842481387.3184596.8515982457756011965@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 09 Oct 2024, cel@kernel.org wrote:
>  
> +static int decode_offload_status(struct xdr_stream *xdr,
> +				 struct nfs42_offload_status_res *res)
> +{
> +	ssize_t result;
> +	int status;
> +
> +	status = decode_op_hdr(xdr, OP_OFFLOAD_STATUS);
> +	if (status)
> +		return status;
> +	/* osr_count */
> +	if (xdr_stream_decode_u64(xdr, &res->osr_count) < 0)
> +		return -EIO;
> +	/* osr_complete<1> */
> +	result = xdr_stream_decode_uint32_array(xdr, res->osr_complete, 1);

nfsd4_decode_getdeviceinfo() handles a singleton array be having a
simple u32, and passing its address.  Here you actually define a
singleton array

I'd probably lean to the former style, but if you really like the
latter, maybe we should change nfsd4_decode_getdeviceinfo() ??

Thanks,
NeilBrown

>  struct nfs42_offload_status_res {
>  	struct nfs4_sequence_res	osr_seq_res;
> -	uint64_t			osr_count;
> -	int				osr_status;
> +	u64				osr_count;
> +	int				complete_count;
> +	u32				osr_complete[1];
>  };
>  
>  struct nfs42_copy_notify_args {
> -- 
> 2.46.2
> 
> 
> 


