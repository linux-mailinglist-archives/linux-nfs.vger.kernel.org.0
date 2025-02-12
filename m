Return-Path: <linux-nfs+bounces-10064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5FA33151
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17F31882C3E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB7202C51;
	Wed, 12 Feb 2025 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zmy49Fzg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVdNe2Bc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zmy49Fzg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVdNe2Bc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A88200B95;
	Wed, 12 Feb 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394812; cv=none; b=pP2hGVj9E6jpme0NXpZb8QhHjq958S+8mnGhWqHPUnHNoLTgy4DBCOjl2r7a/OY88k4Met67WWisSInolshlVEjZ/oIU1eGNglgHa7zueGajX2hkYfOtUnLBTiY4ru4d7k00q2i0C429vq/MrUcLEW/4zdE+heEUSNk4nvUr7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394812; c=relaxed/simple;
	bh=5VKrW0LTf0NyUdyU/YBbpCwS7UtHhXGmwfKBGVR0NbU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cR3B8ZoHbVDB/uk5XEl9UIFB5RL1JeN6pfsD9pOzo6TEEGY/oz0luJvNT+onieIno2PcMEqD48OwwdHdXWxDgx2oBXx5g/MD7WBA0wLyUExfx74UBRHyDBe2Im4mUVkfl4i93Y0LqH18gR23oe2iQNnNnkOqThng02JdykZqNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zmy49Fzg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVdNe2Bc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zmy49Fzg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVdNe2Bc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21C7F337B1;
	Wed, 12 Feb 2025 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739394808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYE4/MKpIJGNFpjPVzpVcoZZ+uRyGZs06Or74T5dZ5U=;
	b=Zmy49FzgUVm4dxuiEdyN91Tjly0NEBzu62phMQAe2IHR0UDNNygcShb2NxKdcTUiq696XQ
	grclxkbfAAD7javWR6L78ykNwUNs4K2BuF4Z7D986odXCjJ3WYSp99/8qUq50GI/135unT
	6CPD0fux+R10LgsalEwAprVMXfiPAe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739394808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYE4/MKpIJGNFpjPVzpVcoZZ+uRyGZs06Or74T5dZ5U=;
	b=ZVdNe2BckdPnIklk8JVSFs6d7iCQaLimEJoGcbW47U+YOD2U015Xd+FfW+IS9Ugq1eVcBC
	hU7y9rnIkFXYmDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739394808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYE4/MKpIJGNFpjPVzpVcoZZ+uRyGZs06Or74T5dZ5U=;
	b=Zmy49FzgUVm4dxuiEdyN91Tjly0NEBzu62phMQAe2IHR0UDNNygcShb2NxKdcTUiq696XQ
	grclxkbfAAD7javWR6L78ykNwUNs4K2BuF4Z7D986odXCjJ3WYSp99/8qUq50GI/135unT
	6CPD0fux+R10LgsalEwAprVMXfiPAe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739394808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYE4/MKpIJGNFpjPVzpVcoZZ+uRyGZs06Or74T5dZ5U=;
	b=ZVdNe2BckdPnIklk8JVSFs6d7iCQaLimEJoGcbW47U+YOD2U015Xd+FfW+IS9Ugq1eVcBC
	hU7y9rnIkFXYmDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF3E813874;
	Wed, 12 Feb 2025 21:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KV9pHfUOrWe/NQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 21:13:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: allow SC_STATUS_FREEABLE when searching via
 nfs4_lookup_stateid()
In-reply-to: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
References: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
Date: Thu, 13 Feb 2025 08:13:13 +1100
Message-id: <173939479366.22054.8896171620747680077@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 13 Feb 2025, Jeff Layton wrote:
> When a delegation is revoked, it's initially marked with
> SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
> with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
> s FREE_STATEID call.
>=20
> nfs4_lookup_stateid() accepts a statusmask that includes the status
> flags that a found stateid is allowed to have. Currently, that mask
> never includes SC_STATUS_FREEABLE, which means that revoked delegations
> are (almost) never found.
>=20
> Add SC_STATUS_FREEABLE to the always-allowed status flags.

There are 4 calls to nfsd4_lookup_stateid().  One already has
SC_STATUS_FREEABLE passed.  Which of the others need it?
If all of them, then this patch is sensible but should also remove the
flag in the one place it is already passed.
If only one other call needs it, then maybe we should just pass it
there?

Could you at least include in the description some detail of what
request is failing and which particular nfsd4_lookup_stateid() call is
relevant in that case?

Thanks,
NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This fixes the pynfs DELEG8 test.
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 153eeea2c7c999d003cd1f36cecb0dd4f6e049b8..56bf07d623d085589823f3fba18=
afa62c0b3dbd2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7051,7 +7051,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cst=
ate,
>  		 */
>  		statusmask |=3D SC_STATUS_REVOKED;
> =20
> -	statusmask |=3D SC_STATUS_ADMIN_REVOKED;
> +	statusmask |=3D SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
> =20
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
>=20
> ---
> base-commit: 4990d098433db18c854e75fb0f90d941eb7d479e
> change-id: 20250212-nfsd-fixes-fa8047082335
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


