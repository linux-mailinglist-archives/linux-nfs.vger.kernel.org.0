Return-Path: <linux-nfs+bounces-8140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C709D30A6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796E91F22756
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3ED1C1F0B;
	Tue, 19 Nov 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1epNy/ke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lxxIMofW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1epNy/ke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lxxIMofW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D7198833
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732056449; cv=none; b=E/PFqUpblIjGoqc2/TGkkBH8oipTPreuvNRrd3dQDzjoPIn8WP6NngfTAZWSiN4YB48wcaEZ4U1QnKQ8Mi3Z5QHUGl3kVPe1Y/QoMNg9bdl8Sq6ov5jGrbDEwkGZuf53Dgpdms/4LYwlbfEhHbziTk7UrGLTp/MGQ+2EDTsdFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732056449; c=relaxed/simple;
	bh=zz2oxTxEnXZbbmTcOjih7PULg7Km5VRb739MGcIX8r8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W/5ae+gDct1p4ioae9dCTnl8MrezR86zFuvxyZt5+ufo/bb9936eJfnWRPk4QUtuwIRCiyquIbohTs5PBZH/wFy7Bb3OiqOqccyNfypt6V2OyGz9Z/qglosSSO+fIMwYQkk9jZayxmNHv/aSpar69DtgRP39ItKgU9dGnl9qN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1epNy/ke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lxxIMofW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1epNy/ke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lxxIMofW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01478219F9;
	Tue, 19 Nov 2024 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732056445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBBHgG6QHmpyDhDaCwchejkyTLq53m0cM93WF0USoMQ=;
	b=1epNy/kebgA4QyIQJuM3I2QVe3EnC/Sourf1yaJTQEB3yRS0/NNajWQ5NMEwdi4HMLnofh
	9fWEuDdG6wXIX3U6pcpIphXQ4UZg+LdnEbUU43guqu2lJBwESK2u28kURzCNOKG2GsNO8V
	Vk5Wbl4TZJY6ycUC5pyFQY/qXoSYcDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732056445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBBHgG6QHmpyDhDaCwchejkyTLq53m0cM93WF0USoMQ=;
	b=lxxIMofWBCCAyR/c+7f99ggPS9OBJZoRoRko1oVmAtYsBb4jCnXtOoHu3GxZ1P4EGq7bKW
	OjhUV9oKNO5o4JDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1epNy/ke";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lxxIMofW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732056445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBBHgG6QHmpyDhDaCwchejkyTLq53m0cM93WF0USoMQ=;
	b=1epNy/kebgA4QyIQJuM3I2QVe3EnC/Sourf1yaJTQEB3yRS0/NNajWQ5NMEwdi4HMLnofh
	9fWEuDdG6wXIX3U6pcpIphXQ4UZg+LdnEbUU43guqu2lJBwESK2u28kURzCNOKG2GsNO8V
	Vk5Wbl4TZJY6ycUC5pyFQY/qXoSYcDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732056445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBBHgG6QHmpyDhDaCwchejkyTLq53m0cM93WF0USoMQ=;
	b=lxxIMofWBCCAyR/c+7f99ggPS9OBJZoRoRko1oVmAtYsBb4jCnXtOoHu3GxZ1P4EGq7bKW
	OjhUV9oKNO5o4JDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F25301376E;
	Tue, 19 Nov 2024 22:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bgRVKnoVPWcWIwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:47:22 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
In-reply-to: <468675e119863804dfe585c08cd87c9510af5afa.camel@kernel.org>
References: <>, <468675e119863804dfe585c08cd87c9510af5afa.camel@kernel.org>
Date: Wed, 20 Nov 2024 09:47:20 +1100
Message-id: <173205644012.1734440.6972021180706116835@noble.neil.brown.name>
X-Rspamd-Queue-Id: 01478219F9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,noble.neil.brown.name:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 20 Nov 2024, Jeff Layton wrote:
> On Tue, 2024-11-19 at 11:41 +1100, NeilBrown wrote:
> > Add a shrinker which frees unused slots and may ask the clients to use
> > fewer slots on each session.
> >=20
> > Each session now tracks se_client_maxreqs which is the most recent
> > max-requests-in-use reported by the client, and se_target_maxreqs which
> > is a target number of requests which is reduced by the shrinker.
> >=20
> > The shrinker iterates over all sessions on all client in all
> > net-namespaces and reduces the target by 1 for each.  The shrinker may
> > get called multiple times to reduce by more than 1 each.
> >=20
> > If se_target_maxreqs is above se_client_maxreqs, those slots can be
> > freed immediately.  If not the client will be ask to reduce its usage
> > and as the usage goes down slots will be freed.
> >=20
> > Once the usage has dropped to match the target, the target can be
> > increased if the client uses all available slots and if a GFP_NOWAIT
> > allocation succeeds.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 72 ++++++++++++++++++++++++++++++++++++++++++---
> >  fs/nfsd/state.h     |  1 +
> >  2 files changed, 69 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 0625b0aec6b8..ac49c3bd0dcb 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1909,6 +1909,16 @@ gen_sessionid(struct nfsd4_session *ses)
> >   */
> >  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> > =20
> > +static struct shrinker *nfsd_slot_shrinker;
> > +static DEFINE_SPINLOCK(nfsd_session_list_lock);
> > +static LIST_HEAD(nfsd_session_list);
> > +/* The sum of "target_slots-1" on every session.  The shrinker can push =
this
> > + * down, though it can take a little while for the memory to actually
> > + * be freed.  The "-1" is because we can never free slot 0 while the
> > + * session is active.
> > + */
> > +static atomic_t nfsd_total_target_slots =3D ATOMIC_INIT(0);
> > +
> >  static void
> >  free_session_slots(struct nfsd4_session *ses, int from)
> >  {
> > @@ -1931,11 +1941,14 @@ free_session_slots(struct nfsd4_session *ses, int=
 from)
> >  		kfree(slot);
> >  	}
> >  	ses->se_fchannel.maxreqs =3D from;
> > -	if (ses->se_target_maxslots > from)
> > -		ses->se_target_maxslots =3D from;
> > +	if (ses->se_target_maxslots > from) {
> > +		int new_target =3D from ?: 1;
>=20
> Let's make that "from ? from : 1". The above is a non-standard gcc-ism
> (AIUI).

Let's not.  There are currently 1926 lines in .c and .h files in the
Linux kernel which contain "?:" and another 848 which contain "? :".
I think it is an established part of the kernel style.

This is admittedly dominated by bcachefs, but there is a long tail with
tools, net, crypto, drivers all contributing.  Outside of bcachefs, fs/
contributes only 102 in 29 different filesystems.

Thanks,
NeilBrown

