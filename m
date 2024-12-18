Return-Path: <linux-nfs+bounces-8661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6A9F6FE2
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 23:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9813616CFDD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE66A1FCFE4;
	Wed, 18 Dec 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P4UPa765";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+i9OS3px";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1orWHmHL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QpFyC1BC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE81FCF66
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559856; cv=none; b=qZWl+gUi2a+80z3SDl13tvdPo87RWP2cnP+EzT+zLr/MZqPtXHMmZqjUUwTqvIz8FEYf5s8vaBKvJqTQ6v6b9XfMyGkrKdz15yCgCUVLkvWQRm3M5amxhJdbgGcWvph6ak6F2MdRBpJfJkNWyPpWWS20ru8RfrqbtyqBAnFZFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559856; c=relaxed/simple;
	bh=loZIB8p1VVp/S+7DRIOeTiKmrmfDIMcRU9xIHQ4vkaM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jQeLm2tHSkIy3DIC8mc5gV/xBRWSfn33GjPzbvpU3kOTCvDj9zXSSULpDAoJUOWGQaWXg9TsCQhoB+R0xSU9bn4yq6awGl18QXlMCyb/eQXcNWg1t04RehW1JPcEd2XF510OgvSOgAI+LN5dDTqh6VEvomsYBEoDEE80v8c7+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P4UPa765; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+i9OS3px; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1orWHmHL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QpFyC1BC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E89852115C;
	Wed, 18 Dec 2024 22:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734559853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=595+am7nS0CcEJTMCMaW4cgBrso3Yn/hjjpJc/AmLHo=;
	b=P4UPa765d/TDqzY524371xCpHzy95ZpZfcTDfnByC3YtMrXnIE95wIcmuEFqWR7MGfVIBc
	OsjotGyXTMavYYuuQ1fs4rN8XK/LyKWjKlnIWGmWikc2V2K7YdfgNBkRl8V3TPsb5q2Lqo
	VA3VmzCv48UY64L30duu3lF+3me3kZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734559853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=595+am7nS0CcEJTMCMaW4cgBrso3Yn/hjjpJc/AmLHo=;
	b=+i9OS3pxfVcNoXd51yUWQ/IHd5684n+cbDUABlUcO7DQs1VCGoCAvupAIxRNfJadoPPpVV
	R2SJ/ZJNYXtFTgCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734559852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=595+am7nS0CcEJTMCMaW4cgBrso3Yn/hjjpJc/AmLHo=;
	b=1orWHmHLzS2jWdzwaa5UJLtmE59qX0nu7izZACIMgX4mWV/QBqegRm7TM1co0tA2Lz0XMq
	RFcuPJzXfHuqtGdipAGU81xHCU99beZIiJL9WjBzcV3WFM212fw8lZcme307qDjPbypscR
	lj2zLG5K4X9/EyduMXPM3QVbiZTj9/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734559852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=595+am7nS0CcEJTMCMaW4cgBrso3Yn/hjjpJc/AmLHo=;
	b=QpFyC1BCUlykn26o6zdcI8ij8KKnVynfqj0hd0COja5NTj/Oul5scT3AQE0g9ZYSFXhCp7
	3W9CyNr/auzNXvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24F9D132EA;
	Wed, 18 Dec 2024 22:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2calMmpIY2dGKAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 18 Dec 2024 22:10:50 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 linux-nfs@vger.kernel.org
Subject: Re: does nfsd reset the callback client too hastily?
In-reply-to: <eaecc0e5-ff04-40ca-94c1-997cf6ab116e@oracle.com>
References: <173449067508.1734440.12408545842217309424@noble.neil.brown.name>,
 <eaecc0e5-ff04-40ca-94c1-997cf6ab116e@oracle.com>
Date: Thu, 19 Dec 2024 09:10:44 +1100
Message-id: <173455984414.1734440.2852424631193788379@noble.neil.brown.name>
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 19 Dec 2024, Chuck Lever wrote:
> On 12/17/24 9:57 PM, NeilBrown wrote:
> >=20
> > Hi,
> >   I've been pondering the messages
> >=20
> >   receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt XXXXX=
XX xid XXXXXX
> >=20
> > that turn up occasionally.  Google reports a variety of hits and I've
> > seen them in a logs from a customer though I don't think they were
> > directly related to the customer's problem.
>=20
> That message isn't actionable by administrators, and risks filling the
> server's system journal with noise. I suggest that it be removed or
> turned into a trace point.

As Olga notes it has already been removed.  But the point was not about
the message but the behaviour that leads to it.  Does is really make
sense to reset the client when there is no evidence of failure?

Maybe I'll send a patch.


>=20
>=20
> > These messages suggest a callback reply from the client which the server
> > was not expecting.  I think the most likely cause that the server called
> >    rpc_shutdown_client(clp->cl_cb_client);
> > while there were outstanding callbacks.
> > This causes rpc_killall_tasks() to be called so that the tasks stop
> > waiting for a reply and are discarded.
> >=20
> > The rpc_shutdown_client() call can come from nfsd4_process_cb_update()
> > which gets runs whenever nfsd4_probe_callback() is called.  This happens
> > in quite a few places including when a new connection is bound to a
> > session.
> >=20
> > So if a new connection is bound, the current callback channel is aborted
> > even though it is working perfectly well.  That is particularly
> > problematic as callback request are not currently retransmitted.
> >=20
> > So I'm wondering if nfsd4_process_cb_update() should only shutdown the
> > current cb client if there is evidence that it isn't work.
> >=20
> > I'm not certain how best to do that.  One option might be to do a search
> > similar to that in __nfsd4_find_backchannel() and see if the current
> > session and xprt are still valid.  There might be a better way.
> >=20
> > Thoughts?
>=20
> Operating from memory, so this might be crazy talk:
>=20
> The fundamental problem is lack of ability to retransmit a callback
> after a reconnect. The rpc_shutdown_clnt() tosses all pending RPC
> tasks, making it impossible to retransmit them.
>=20
> I'd rather see the rpc_clnt be owned by the session instead of the
> nfs_client. Then the rpc_clnt could be destroyed only when the session
> is actually destroyed, at which point we know it is sensible and safe
> to discard pending callback operations.
>=20
> But the callback code is designed to handle both NFSv4.0 and NFSv4.1
> callbacks, even though these are somewhat different beasts.
>=20
> NFSv4.0 operates:
> - on a real transport that can reestablish a connection on demand
> - without a session
>=20
> NFSv4.1 operates:
> - on a virtual transport, and has to wait for the client to reestablish
>    a connection
> - within a session context that is supposed to survive multiple
>    transport instances
>=20
> Some reorganization is needed to successfully re-anchor the rpc_clnt.

That's helpful - thanks.
I wonder if the xprtmultipath infrastructure could be used to attach all
the bound xprts to the rpc_clnt.

I'll see what I can come up with.

NeilBrown


>=20
> --=20
> Chuck Lever
>=20


