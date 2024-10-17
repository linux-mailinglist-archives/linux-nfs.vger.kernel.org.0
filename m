Return-Path: <linux-nfs+bounces-7257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99EA9A2FBB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1721C2011E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862E1991C3;
	Thu, 17 Oct 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qo0o/aWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SlfnoQHo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qo0o/aWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SlfnoQHo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC6176FA7
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200170; cv=none; b=d7OxyHsD3N9zw6jUkgOxYT//cKqEDjfIkI/2gl45ZVPIJmHpEhJrWH17V9GjvN7Z75DxsArriWtUSzQRj6je9tJKe8t6ZXTW0Xqh3IndB+dyQ8PwxdeieaVCUODSy4VdMVKBnv+vX0ZyMIxDy8m5CvLz1T70C94I/xW/URUTCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200170; c=relaxed/simple;
	bh=g4dWm3noT94a3mTJielX3Z7Cc1mn4ur19Mp/StgwrT8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DUvyWRfggQ3RgZThvlVd+f10/JMhe1nAIqXtDJiEIeyfEgjmJ9lps0qTQAdYD25Sxiq29ASQ/Sc1v9PBKOLbheKuFCUbb1zjaSV7W+81Q6a/yNNw+1LsKHSiVelB4l1MIXsaDGNhHaLK9jlyNq5hIIXZLMPuoEpqaDDBGwNHTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qo0o/aWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SlfnoQHo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qo0o/aWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SlfnoQHo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E6561FD51;
	Thu, 17 Oct 2024 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729200163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYBYKGAoiNeG+Clya012dr55ixE+bDbAqybf/JNBwZ4=;
	b=Qo0o/aWtXvibuQvkNHyJuHpOOc7VT3Dha0JKSqTO/wuJd+jRQWFobgRARjIqSUscpuOHIW
	vgWX7MZNYI//rnCDt4NdZbpLbV2iaVfxd5RvNDrfPsYrpPE7WCDuIMLE41oI2XRuhE+LWs
	ZK4ipnZlxJQEDy104InGJpof2xJyAQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729200163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYBYKGAoiNeG+Clya012dr55ixE+bDbAqybf/JNBwZ4=;
	b=SlfnoQHo505iVQkvtoZPBOL2Aqrkiw5SjRj5n57so2WaMhVhyycTpKxkssFmrhsZm818Fu
	bKQJwQ1X6wVeiSBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Qo0o/aWt";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SlfnoQHo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729200163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYBYKGAoiNeG+Clya012dr55ixE+bDbAqybf/JNBwZ4=;
	b=Qo0o/aWtXvibuQvkNHyJuHpOOc7VT3Dha0JKSqTO/wuJd+jRQWFobgRARjIqSUscpuOHIW
	vgWX7MZNYI//rnCDt4NdZbpLbV2iaVfxd5RvNDrfPsYrpPE7WCDuIMLE41oI2XRuhE+LWs
	ZK4ipnZlxJQEDy104InGJpof2xJyAQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729200163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYBYKGAoiNeG+Clya012dr55ixE+bDbAqybf/JNBwZ4=;
	b=SlfnoQHo505iVQkvtoZPBOL2Aqrkiw5SjRj5n57so2WaMhVhyycTpKxkssFmrhsZm818Fu
	bKQJwQ1X6wVeiSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3F813A42;
	Thu, 17 Oct 2024 21:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uvqUMCCAEWfTGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 17 Oct 2024 21:22:40 +0000
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
Cc: "Chuck Lever III" <chuck.lever@oracle.com>, "Chuck Lever" <cel@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/5] lockd: Remove unneeded initialization of
 file_lock::c.flc_flags
In-reply-to: <03d89ad174357456abf2053e22bfd61ce59b5658.camel@kernel.org>
References: <>, <03d89ad174357456abf2053e22bfd61ce59b5658.camel@kernel.org>
Date: Fri, 18 Oct 2024 08:22:38 +1100
Message-id: <172920015817.81717.7256529679417338308@noble.neil.brown.name>
X-Rspamd-Queue-Id: 7E6561FD51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 18 Oct 2024, Jeff Layton wrote:
> On Thu, 2024-10-17 at 19:16 +0000, Chuck Lever III wrote:
> >=20
> > > On Oct 17, 2024, at 3:13=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > >=20
> > > On Thu, 2024-10-17 at 09:36 -0400, cel@kernel.org wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > >=20
> > > > Since commit 75c7940d2a86 ("lockd: set missing fl_flags field when
> > > > retrieving args"), nlmsvc_retrieve_args() initializes the flc_flags
> > > > field. svcxdr_decode_lock() no longer needs to do this.
> > > >=20
> > > > This clean up removes one dependency on the nlm_lock:fl field. No
> > > > behavior change is expected.
> > > >=20
> > > > Analysis:
> > > >=20
> > > > svcxdr_decode_lock() is called by:
> > > >=20
> > > > nlm4svc_decode_testargs()
> > > > nlm4svc_decode_lockargs()
> > > > nlm4svc_decode_cancargs()
> > > > nlm4svc_decode_unlockargs()
> > > >=20
> > > > nlm4svc_decode_testargs() is used by:
> > > > - NLMPROC4_TEST and NLMPROC4_TEST_MSG, which call nlmsvc_retrieve_arg=
s()
> > > > - NLMPROC4_GRANTED and NLMPROC4_GRANTED_MSG, which don't pass the
> > > >  lock's file_lock to the generic lock API
> > > >=20
> > > > nlm4svc_decode_lockargs() is used by:
> > > > - NLMPROC4_LOCK and NLM4PROC4_LOCK_MSG, which call nlmsvc_retrieve_ar=
gs()
> > > > - NLMPROC4_UNLOCK and NLM4PROC4_UNLOCK_MSG, which call nlmsvc_retriev=
e_args()
> > > > - NLMPROC4_NM_LOCK, which calls nlmsvc_retrieve_args()
> > > >=20
> > > > nlm4svc_decode_cancargs() is used by:
> > > > - NLMPROC4_CANCEL and NLMPROC4_CANCEL_MSG, which call nlmsvc_retrieve=
_args()
> > > >=20
> > > > nlm4svc_decode_unlockargs() is used by:
> > > > - NLMPROC4_UNLOCK and NLMPROC4_UNLOCK_MSG, which call nlmsvc_retrieve=
_args()
> > > >=20
> > > > All callers except GRANTED/GRANTED_MSG eventually call
> > > > nlmsvc_retrieve_args() before using nlm_lock::fl.c.flc_flags. Thus
> > > > this change is safe.
> > > >=20
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > > fs/lockd/svc4proc.c | 5 +++--
> > > > fs/lockd/xdr4.c     | 1 -
> > > > 2 files changed, 3 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > index 2cb603013111..109e5caae8c7 100644
> > > > --- a/fs/lockd/svc4proc.c
> > > > +++ b/fs/lockd/svc4proc.c
> > > > @@ -46,14 +46,15 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, str=
uct nlm_args *argp,
> > > > if (filp !=3D NULL) {
> > > > int mode =3D lock_to_openmode(&lock->fl);
> > > >=20
> > > > + lock->fl.c.flc_flags =3D FL_POSIX;
> > > > +
> > > > error =3D nlm_lookup_file(rqstp, &file, lock);
> > > > if (error)
> > > > goto no_locks;
> > > > *filp =3D file;
> > > >=20
> > > > /* Set up the missing parts of the file_lock structure */
> > > > - lock->fl.c.flc_flags =3D FL_POSIX;
> > > > - lock->fl.c.flc_file  =3D file->f_file[mode];
> > > > + lock->fl.c.flc_file =3D file->f_file[mode];
> > > > lock->fl.c.flc_pid =3D current->tgid;
> > > > lock->fl.fl_start =3D (loff_t)lock->lock_start;
> > > > lock->fl.fl_end =3D lock->lock_len ?
> > > > diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> > > > index 60466b8bac58..e343c820301f 100644
> > > > --- a/fs/lockd/xdr4.c
> > > > +++ b/fs/lockd/xdr4.c
> > > > @@ -89,7 +89,6 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct n=
lm_lock *lock)
> > > > return false;
> > > >=20
> > > > locks_init_lock(fl);
> > > > - fl->c.flc_flags =3D FL_POSIX;
> > > > fl->c.flc_type  =3D F_RDLCK;
> > > > nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
> > > > return true;
> > >=20
> > > 1-4 look fine. You can add my R-b to those.
> >=20
> > Thanks!
> >=20
> >=20
> > > For this one, I think I'd rather see this go the other way, and just
> > > eliminate the setting of flc_flags in nlm4svc_retrieve_args. We only
> > > deal with FL_POSIX locks in svc lockd, and that does it right after
> > > locks_init_lock, so I think that means it'll be done earlier, no?
> >=20
> > Have a look at the nlm4 branch in my kernel.org <http://kernel.org/> repo=
 to see where
> > this is headed.
> >=20
>=20
> (For everyone following along: It's actually in Chuck's xdrgen branch)
>=20
> Oh ok, I see. This is an interim step toward moving all of the lock
> initialization into nlm4svc_retrieve_args(). That probably is better. I
> withdraw my objection.

Adding that observation to the commit message would help with review.
I agree that moving the initialisation to nlm4svc_retrieve_args() seems
sensible.  The half-way version in this patch looks really odd without
that explanation.

But the whole series
 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown



>=20
> >=20
> > > Also, I think the same duplication is in nlmsvc_retrieve_args and the
> > > nlmv3 version of svcxdr_decode_lock.
> >=20
> > Which is going away when NFSv2 is removed. I'm not too concerned
> > about that duplication.
> >=20
>=20
> Fair enough. I'm fine with leaving that to wither for now:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20


