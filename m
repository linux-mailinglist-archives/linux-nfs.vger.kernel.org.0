Return-Path: <linux-nfs+bounces-2721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42089CEEB
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 01:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619831C2398F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DCC376E4;
	Mon,  8 Apr 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gh4MLppf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5a2ZI9u9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gh4MLppf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5a2ZI9u9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DE1DA5E
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618527; cv=none; b=DSxAvHO/CHrsCvZl3BU/C5E1BAWnlXjvsKuxLT8vMUzw4Fhuzjs3PwjIUyTn9u5HRRYuCjJ46oCBjqS1LA1tqc/YObP0HKXwXQPW2sH8iokW3P0qEXwpnGv1A34YwlnPjSNz0UjrvZy190qGOWlQPDFgFwFmsiSxrSm0itT5lII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618527; c=relaxed/simple;
	bh=V2BLnGDG+VEZzilg7sbkbebzvS5Q184WyPDWroq1Af8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cz/vqPghUWeUKBpidBZpe98wkqM3UuE5mfJ+BxPMF7+IXMJw/0WTO13Oh0zL+TDwwlUyLdzvjtx45HuwfMx9RfLI/+1f8yAnra5WCo7bO4PTVSNiTwaEgnof1BFTjnB64eRUKCsZqjz9tdVx0tidkDO+5X0jhXfC+BMPxL2pyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gh4MLppf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5a2ZI9u9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gh4MLppf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5a2ZI9u9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A79920630;
	Mon,  8 Apr 2024 23:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712618523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCgKxYDV1WGtJX7A7AeKfiscYrpJ7Qn53HFIRBePbOM=;
	b=gh4MLppfkLuWSR4Omi0/PRXq62/U9JWHsDsTa07iF1LbcDdt/WOK5b3zuZoIfJdJcINW9c
	T4KxAxbel6N9sSXDtEo/fGqI1j9CYHG3F0MXv4b3KySU9YnLkz2kYTfIOoYUNWdKr1NYSc
	KEV/Pvsth9rFCikTXNoy1bkYFDXiSeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712618523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCgKxYDV1WGtJX7A7AeKfiscYrpJ7Qn53HFIRBePbOM=;
	b=5a2ZI9u9OLgkQmTmYCrRVemgWQrUEjRgswUfITiUMhFGQ/XgztiiwjARmVrhbZlb0RWXcj
	qK6oNZyr13s08iDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gh4MLppf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5a2ZI9u9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712618523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCgKxYDV1WGtJX7A7AeKfiscYrpJ7Qn53HFIRBePbOM=;
	b=gh4MLppfkLuWSR4Omi0/PRXq62/U9JWHsDsTa07iF1LbcDdt/WOK5b3zuZoIfJdJcINW9c
	T4KxAxbel6N9sSXDtEo/fGqI1j9CYHG3F0MXv4b3KySU9YnLkz2kYTfIOoYUNWdKr1NYSc
	KEV/Pvsth9rFCikTXNoy1bkYFDXiSeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712618523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCgKxYDV1WGtJX7A7AeKfiscYrpJ7Qn53HFIRBePbOM=;
	b=5a2ZI9u9OLgkQmTmYCrRVemgWQrUEjRgswUfITiUMhFGQ/XgztiiwjARmVrhbZlb0RWXcj
	qK6oNZyr13s08iDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8374B13675;
	Mon,  8 Apr 2024 23:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xpU0CRh8FGagTQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 23:22:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chen Hanxiao" <chenhx.fnst@fujitsu.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
In-reply-to: <20240408150636.417-1-chenhx.fnst@fujitsu.com>
References: <20240408150636.417-1-chenhx.fnst@fujitsu.com>
Date: Tue, 09 Apr 2024 09:21:54 +1000
Message-id: <171261851499.17212.4957589707094499321@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.39 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.88)[85.81%];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,fujitsu.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9A79920630
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.39

On Tue, 09 Apr 2024, Chen Hanxiao wrote:
> trace_nfsd_ctl_filehandle in write_filehandle has
> some similar infos.

Not all that similar.  The dprintk you are removing includes the inode
number and sb->s_id which the trace point don't include.

Why do you think that information isn't needed?

NeilBrown



>=20
> write_filehandle is the only caller of exp_rootfh,
> so just remove the dprintk parts.
>=20
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  fs/nfsd/export.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7b641095a665..e7acd820758d 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1027,9 +1027,6 @@ exp_rootfh(struct net *net, struct auth_domain *clp, =
char *name,
>  	}
>  	inode =3D d_inode(path.dentry);
> =20
> -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> -		 name, path.dentry, clp->name,
> -		 inode->i_sb->s_id, inode->i_ino);
>  	exp =3D exp_parent(cd, clp, &path);
>  	if (IS_ERR(exp)) {
>  		err =3D PTR_ERR(exp);
> --=20
> 2.39.1
>=20
>=20
>=20


