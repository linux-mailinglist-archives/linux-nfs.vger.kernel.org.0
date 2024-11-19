Return-Path: <linux-nfs+bounces-8136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B29D3070
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C50283C49
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9E1C1741;
	Tue, 19 Nov 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C/ylglJT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DWfyITix";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C/ylglJT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DWfyITix"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56211B21A0
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055104; cv=none; b=WKW8IKyA9BN4zjrNyKVB4TmD3EufE27TCaBsgmpGP8pbNI9ycP+hF2nCJF7FQnanKfK3UNMUE8aYqJI/L25F1x+WeeqJgHwsXP8cu4G2dvnNzlxqFZrfgP+wwc/tfxZGGAcKFkm2/7LP+QTl7irVWqVtL8XuPf2nvr47Tpes9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055104; c=relaxed/simple;
	bh=ibVkQKZv75ElItMI9ZRjjNeVUh3mVlr9EpAyGjd+wLQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=enCX3P8dq3zJMtapGcoXeCBxLXCskbndPkBFSy4MrFxyMcqnKNu7sHTrDIS1SUoNnGJBTohVUg43daA7WESzalBepZL+f/PKGlDtoI9oK4vqEyQLE5SFu4l34BGaJnIM9MuxNUEeqaLoyEJGka40tpMPfIdX3js0zYH5wqjFink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C/ylglJT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DWfyITix; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C/ylglJT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DWfyITix; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 017D11F395;
	Tue, 19 Nov 2024 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732055101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyiJD+/7k/XnEE8uXLtyZbUsPLGjfMd4wiNigahgbAA=;
	b=C/ylglJTUq1Qx4u73XAeSodoKXU6JBJ9rlFkMoLg/2wHzp8FBhQs9zFey70YABxhmgn7Li
	TdAkgXRCtwdaDn2witNRa8ABebOQDtqwdgGR+a0jjEcd/t+JRaI8B+dtjfEJFvpvpO/IOE
	kOalFexZP2filIzPgf0bog0466X9Y/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732055101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyiJD+/7k/XnEE8uXLtyZbUsPLGjfMd4wiNigahgbAA=;
	b=DWfyITix19aisqVxXff5CtO792SVeeJSPxASGdO5Bz87nPMSNVlVRjl7qoMlRAfM0hfJAf
	6qs0iuN8GXvdz8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732055101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyiJD+/7k/XnEE8uXLtyZbUsPLGjfMd4wiNigahgbAA=;
	b=C/ylglJTUq1Qx4u73XAeSodoKXU6JBJ9rlFkMoLg/2wHzp8FBhQs9zFey70YABxhmgn7Li
	TdAkgXRCtwdaDn2witNRa8ABebOQDtqwdgGR+a0jjEcd/t+JRaI8B+dtjfEJFvpvpO/IOE
	kOalFexZP2filIzPgf0bog0466X9Y/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732055101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyiJD+/7k/XnEE8uXLtyZbUsPLGjfMd4wiNigahgbAA=;
	b=DWfyITix19aisqVxXff5CtO792SVeeJSPxASGdO5Bz87nPMSNVlVRjl7qoMlRAfM0hfJAf
	6qs0iuN8GXvdz8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE6CB13736;
	Tue, 19 Nov 2024 22:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hlylKDoQPWeAHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:24:58 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
In-reply-to: <ZzzlMXO1mteXdtWj@tissot.1015granger.net>
References: <>, <ZzzlMXO1mteXdtWj@tissot.1015granger.net>
Date: Wed, 20 Nov 2024 09:24:52 +1100
Message-id: <173205509210.1734440.10921571462363976751@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> > Each client now reports the number of slots allocated in each session.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 3889ba1c653f..31ff9f92a895 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2642,6 +2642,7 @@ static const char *cb_state2str(int state)
> >  static int client_info_show(struct seq_file *m, void *v)
> >  {
> >  	struct inode *inode =3D file_inode(m->file);
> > +	struct nfsd4_session *ses;
> >  	struct nfs4_client *clp;
> >  	u64 clid;
> > =20
> > @@ -2678,6 +2679,13 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> >  	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb_add=
r);
> >  	seq_printf(m, "admin-revoked states: %d\n",
> >  		   atomic_read(&clp->cl_admin_revoked));
> > +	seq_printf(m, "session slots:");
> > +	spin_lock(&clp->cl_lock);
> > +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> > +		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> > +	spin_unlock(&clp->cl_lock);
> > +	seq_puts(m, "\n");
> > +
>=20
> Also, I wonder if information about the backchannel session can be
> surfaced in this way?
>=20

Probably make sense.  Maybe we should invent a syntax for reporting
arbitrary info about each session.

   session %d slots: %d
   session %d cb-slots: %d
   ...

???

NeilBrown

