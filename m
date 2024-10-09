Return-Path: <linux-nfs+bounces-6991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF24997640
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4711F2383E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2C1E22E4;
	Wed,  9 Oct 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBZyo6AL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nVrWgzYH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBZyo6AL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nVrWgzYH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4241E1A36;
	Wed,  9 Oct 2024 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504861; cv=none; b=JNKLFjojUJzI9RdeaHD3YQtLngVXagFVE2LYXKQbw8GiciNLN/XLQmULekyI8xkA2axEqZ5ko84QL9rmTxFprjc/BzmCeDfdg4ALF2rGcHhdeX/oADyGLwPhTZqormetf6TiWrDvfrF2UajftjI2BbQrgRQ8hDHcau5hoBNH8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504861; c=relaxed/simple;
	bh=9XjZb9FYKYsx8aI4L1bCQYLfbT8GfcKYTOmxb9rmsAE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=naREaHKCNb0huA1F2Df9vdOMc/EOSaZXlbqIxyjTnE7/Hl83jhtrvFhaS8e96A2LCYvnmXN5sawW5EAMS8ge6DIEBheODNT4/gSErd+6q68/VES6CaSKWrJpcIiRPJoXzsVw0oQC02kFQ9GO+ezEASaI7+b3HaDfRQkHZN8S+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBZyo6AL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nVrWgzYH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBZyo6AL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nVrWgzYH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 392C221CBE;
	Wed,  9 Oct 2024 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728504854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqyPTtQ9qBpo39IBRnaT+GMEDBQbWgRwYGtmM+jFsQ=;
	b=MBZyo6AL7oPAfD92omwA2hmT+pKHqTQpAyK576DIUjQcpwjGcJsXcPojktvqAOaGepx4oT
	LqdvUxUmXcbBUVI8UEAqT5DK69ibaelf8/fe2gpRmfVM/GPxSCQJhgoN36lvV/StYdAnRO
	336eDRmxbATmKG9oCYKS/9pAiYJ+hnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728504854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqyPTtQ9qBpo39IBRnaT+GMEDBQbWgRwYGtmM+jFsQ=;
	b=nVrWgzYH1mfu8L5pJ2IdTtdZB/zPww6RH/vNRTOoXWcTOItdkXjYsH075yLRfnCs/EKV7E
	ftN0A77fjGrd6GCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MBZyo6AL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nVrWgzYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728504854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqyPTtQ9qBpo39IBRnaT+GMEDBQbWgRwYGtmM+jFsQ=;
	b=MBZyo6AL7oPAfD92omwA2hmT+pKHqTQpAyK576DIUjQcpwjGcJsXcPojktvqAOaGepx4oT
	LqdvUxUmXcbBUVI8UEAqT5DK69ibaelf8/fe2gpRmfVM/GPxSCQJhgoN36lvV/StYdAnRO
	336eDRmxbATmKG9oCYKS/9pAiYJ+hnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728504854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqyPTtQ9qBpo39IBRnaT+GMEDBQbWgRwYGtmM+jFsQ=;
	b=nVrWgzYH1mfu8L5pJ2IdTtdZB/zPww6RH/vNRTOoXWcTOItdkXjYsH075yLRfnCs/EKV7E
	ftN0A77fjGrd6GCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 827D813A58;
	Wed,  9 Oct 2024 20:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RRWcDhPkBmfzJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 09 Oct 2024 20:14:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
In-reply-to: <Zwbfmf3L5XphaiGs@tissot.1015granger.net>
References: <>, <Zwbfmf3L5XphaiGs@tissot.1015granger.net>
Date: Thu, 10 Oct 2024 07:14:07 +1100
Message-id: <172850484738.444407.17004521090739639063@noble.neil.brown.name>
X-Rspamd-Queue-Id: 392C221CBE
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 10 Oct 2024, Chuck Lever wrote:
> On Tue, Oct 08, 2024 at 05:47:55PM -0400, NeilBrown wrote:
> > And NFSD_MAY_LOCK should be discarded, and nlm_fopen() should set
> > NFSD_MAY_BYPASS_SEC.
>=20
> 366         /*                                                             =
        =20
> 367          * pseudoflavor restrictions are not enforced on NLM,          =
        =20
>=20
> Wrt the mention of "NLM", nfsd4_lock() also sets NFSD_MAY_LOCK.

True, but it shouldn't.  NFSD_MAY_LOCK is only used to bypass the GSS
requirement.  It must have been copied into nfsd4_lock() without a full
understanding of its purpose.

>=20
> 368          * which clients virtually always use auth_sys for,            =
        =20
> 369          * even while using RPCSEC_GSS for NFS.                        =
        =20
> 370          */                                                            =
        =20
> 371         if (access & NFSD_MAY_LOCK)                                    =
        =20
> 372                 goto skip_pseudoflavor_check;                          =
        =20
> 373         if (access & NFSD_MAY_BYPASS_GSS)                              =
        =20
> 374                 may_bypass_gss =3D true;
> 375         /*                                                             =
        =20
> 376          * Clients may expect to be able to use auth_sys during mount, =
        =20
> 377          * even if they use gss for everything else; see section 2.3.2 =
        =20
> 378          * of rfc 2623.                                                =
        =20
> 379          */                                                            =
        =20
> 380         if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT                       =
        =20
> 381                         && exp->ex_path.dentry =3D=3D dentry)          =
            =20
> 382                 may_bypass_gss =3D true;                               =
          =20
> 383                                                                        =
        =20
> 384         error =3D check_nfsd_access(exp, rqstp, may_bypass_gss);       =
          =20
> 385         if (error)                                                     =
        =20
> 386                 goto out;                                              =
        =20
> 387                                                                        =
        =20
> 388 skip_pseudoflavor_check:                                               =
        =20
> 389         /* Finally, check access permissions. */                       =
        =20
> 390         error =3D nfsd_permission(cred, exp, dentry, access);    =20
>=20
> MAY_LOCK is checked in nfsd_permission() and __fh_verify().
>=20
> But MAY_BYPASS_GSS is set in loads of places that use those two
> functions. How can we be certain that the two flags are equivalent?=20

We can be certain by looking at the effect.  Before a recent patch they
both did "goto skip_pseudoflavor_check" and nothing else.

>=20
> Though I agree, simplifying this hot path would both help
> performance scalability and reduce reader headaches. It might be a
> little nicer to pass the NFSD_MAY flags directly to
> check_nfsd_access(), for example.

Yes, that might be cleaner.

Thanks,
NeilBrown

