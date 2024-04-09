Return-Path: <linux-nfs+bounces-2723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B464689CFA7
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 03:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D820F1C23B0F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 01:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DDCA938;
	Tue,  9 Apr 2024 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ODeiEUbf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KGBBeAgk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="spc6t0ZC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E8kVTeJ9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC833A936
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625147; cv=none; b=erwMOqSpc8GySGebIAFQdsx6B++1zVhSvzcxhffp8kAMyxZRVUWQp+CvkDEWNWLsQjfTZd0G0uEMqifuan5JcKV3z8+71xO3ExmLxhXeL/o+wbKdCRCw3pN9rLfYPR31C1TMe+D8zmrBMZtkV/LaBIQa8iRWSTYjtHtCyhEBH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625147; c=relaxed/simple;
	bh=XE+cpo1zM3vq/KXM4gcBLY1v6vob6Xt0Y5FWOa3xyqk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=S2TvX7hBpO4F7io5J9oiPVUiSuNNFOPQBcz79Zop10HnWh86SJgxq6sWrQcR6Tmw9NzO5rZC438sVv+kL8S0I8gBHTlYef/RdB7hu3Ps1pBc/JIklW1ygaqynOski3J1qUxItSQvzvQUeSJMtPdjmgRlwljfrnyIu0a0wJq1qWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ODeiEUbf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KGBBeAgk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=spc6t0ZC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E8kVTeJ9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5D6021E75;
	Tue,  9 Apr 2024 01:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712625144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrfrDtyC09VFDR5bArW5mNeH5F16iKmvLLYYqu7bTso=;
	b=ODeiEUbfrWfVEpFvGsj+M83PGcusSXRfJKd47x05jInNSJDyQ1cdpfnL9gyODKa0igVZKQ
	hi9x+KCQEf/pmfb5uTHRTn7lcgr7hXsq0xSH0spjDsq1A1f3CLmkVqs1M4Jt1+ga0l1+HD
	b+0s0jcBjKpq5DztHOdAue5VL6a7srQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712625144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrfrDtyC09VFDR5bArW5mNeH5F16iKmvLLYYqu7bTso=;
	b=KGBBeAgkTyZ/zDYt2wmGh5WXiHi8r5IWu4Wx61wz72Qzij5ST++O6ZR6MgN5uIC2774emD
	wpogBQLrqZh4PQDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=spc6t0ZC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E8kVTeJ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712625143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrfrDtyC09VFDR5bArW5mNeH5F16iKmvLLYYqu7bTso=;
	b=spc6t0ZCdyIflR3UTRu3c2iEEsSE5XfLpKIxf4tVP9MrcMjWtgAKeMo7HB+HvyK9GgYn1y
	ja6S2RlPTJUCwWMVEv1tsacPAg6zTFmDMbaxc/tWChJ2/rAS4eWQdqEUaWj7Gy1Xf56ACH
	0QyjHJkCLgistaUUhZjbIpCRTBa7/HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712625143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrfrDtyC09VFDR5bArW5mNeH5F16iKmvLLYYqu7bTso=;
	b=E8kVTeJ9GXB28YQ8poRPAdFvbRNxxVldUExkuh6gbckDArRuRuw0S2Dv4Qqp49/mZf+gx+
	LYAzalSJWzOU42Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD88913675;
	Tue,  9 Apr 2024 01:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bdfqH/SVFGaFZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 09 Apr 2024 01:12:20 +0000
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
Cc: "Chen Hanxiao" <chenhx.fnst@fujitsu.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
In-reply-to: <ZhSPRTPtGCm4InJ8@tissot.1015granger.net>
References: <>, <ZhSPRTPtGCm4InJ8@tissot.1015granger.net>
Date: Tue, 09 Apr 2024 11:12:12 +1000
Message-id: <171262513282.17212.15154633882557010394@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D5D6021E75
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,fujitsu.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, 09 Apr 2024, Chuck Lever wrote:
> On Tue, Apr 09, 2024 at 09:21:54AM +1000, NeilBrown wrote:
> > On Tue, 09 Apr 2024, Chen Hanxiao wrote:
> > > trace_nfsd_ctl_filehandle in write_filehandle has
> > > some similar infos.
> >=20
> > Not all that similar.  The dprintk you are removing includes the inode
> > number and sb->s_id which the trace point don't include.
> >=20
> > Why do you think that information isn't needed?
>=20
> I asked him to remove that dprintk.
>=20
> Can you say why you think that information is useful to provide
> via a dprintk? It doesn't seem useful to system administrators,
> IMO.

I'm not saying it is useful, but I don't think the onus is on me.

When removing tracing information, the commit message should at least
acknowledge what is being removed and make some attempt to justify it.
In this case the commit message claimed that nothing was being removed,
which is clearly false.  Maybe just the commit message needs to be
fixed.

I don't think these tracepoints are just for system administrators.
They are also for tech support when they are trying to remotely diagnose
a customer problem.  It is really hard to know what will actually be
useful.  Many times I have found that the particular information that I
want isn't available in any tracing.  I expect this is inevitable.  We
cannot trace EVERYTHING so there will always be gaps.  But removing some
information that was previously generated seems like a regression that
should at least be justified.

In the case of write_filehandle() we are now tracing the request, but
not the result.  Is this generally sensible?  Would it not make sense to
trace both after the core of the function (exp_rootfh) has completed?
At lease the knfsd_fh_hash() of the generated filehandle could be
reported.

NeilBrown


>=20
>=20
> > > write_filehandle is the only caller of exp_rootfh,
> > > so just remove the dprintk parts.
> > >=20
> > > Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> > > ---
> > >  fs/nfsd/export.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > index 7b641095a665..e7acd820758d 100644
> > > --- a/fs/nfsd/export.c
> > > +++ b/fs/nfsd/export.c
> > > @@ -1027,9 +1027,6 @@ exp_rootfh(struct net *net, struct auth_domain *c=
lp, char *name,
> > >  	}
> > >  	inode =3D d_inode(path.dentry);
> > > =20
> > > -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> > > -		 name, path.dentry, clp->name,
> > > -		 inode->i_sb->s_id, inode->i_ino);
> > >  	exp =3D exp_parent(cd, clp, &path);
> > >  	if (IS_ERR(exp)) {
> > >  		err =3D PTR_ERR(exp);
> > > --=20
> > > 2.39.1
> > >=20
> > >=20
> > >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20


