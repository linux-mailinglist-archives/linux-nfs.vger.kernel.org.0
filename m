Return-Path: <linux-nfs+bounces-8907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C2EA01160
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 01:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE417A041D
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585914C9F;
	Sat,  4 Jan 2025 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZYPGsfX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cIKu/K25";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZYPGsfX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cIKu/K25"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027E3C3C
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735951470; cv=none; b=mU9dLbZW1B8vWT6S0sS9YB4Spw24fBP1TrkqEWDNLf22WfFE2B2jlk+Bz0rxfF1bnhmjs9DcjG4Ut7AJaMcmqxYdv+Q5IlS2qvcy3k1rmg5tqSBqKPeQs2EInoK6xFGs8oGuLqhmgt4Nn3eXf90PDwdaS7RYHOEEhK7kbtnws9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735951470; c=relaxed/simple;
	bh=4TiTQvBVZ3E1TKBI0/7SVVnOnMIQLeb7SAB/e8o3QUs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=h+n9HvM8XMVkpz15Ik6u2pF/z/g8Qz8uxbRh+U0Iaut7yKxZEICA+tWP9IZ/ZnHa44oLPhd3za0z98QxJihgM9X5kRmKgxyUqklP+g+Q5mPCHdd6CswHCXcu5ZlQ1/fAxu+RvW/3mv+glbt8dSpzD2JQX/8gxlTb3r4mySdtHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZYPGsfX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cIKu/K25; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZYPGsfX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cIKu/K25; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EE461F37C;
	Sat,  4 Jan 2025 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735951466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b74hMfNqw/aUSRlNAyPOLiWB4R6+jH1c/koN2AvmI48=;
	b=ZYPGsfX69MbRNNlvB1GEbU6TkQLdTEtVvFGoqDQGhNnw0t0MFQ8iY23YGMUb3ZJoUPWgFL
	4DbD3s/0N4wpB9Jimaf0sX9XV6ERDBOwnZT35tYTbomtnVIx83HAZUHDPQsRRdW0Fy08mj
	Y1KQsm5mLIsGljaouEfuCL+AZjtyuB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735951466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b74hMfNqw/aUSRlNAyPOLiWB4R6+jH1c/koN2AvmI48=;
	b=cIKu/K25jgRCS2uRFVK+Nl3FjHJtET/mC1MzXhpYkLsuKLQvzL6GuyMLqBRE4NnFZ2ROfI
	CMwR0pXYolyjRqAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735951466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b74hMfNqw/aUSRlNAyPOLiWB4R6+jH1c/koN2AvmI48=;
	b=ZYPGsfX69MbRNNlvB1GEbU6TkQLdTEtVvFGoqDQGhNnw0t0MFQ8iY23YGMUb3ZJoUPWgFL
	4DbD3s/0N4wpB9Jimaf0sX9XV6ERDBOwnZT35tYTbomtnVIx83HAZUHDPQsRRdW0Fy08mj
	Y1KQsm5mLIsGljaouEfuCL+AZjtyuB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735951466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b74hMfNqw/aUSRlNAyPOLiWB4R6+jH1c/koN2AvmI48=;
	b=cIKu/K25jgRCS2uRFVK+Nl3FjHJtET/mC1MzXhpYkLsuKLQvzL6GuyMLqBRE4NnFZ2ROfI
	CMwR0pXYolyjRqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE011134E4;
	Sat,  4 Jan 2025 00:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xM43JGeEeGfvbAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 04 Jan 2025 00:44:23 +0000
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
Cc: cel@kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jakub Kicinski" <kuba@kernel.org>
Subject: Re: [PATCH v1 1/2] Revert "SUNRPC: Reduce thread wake-up rate when
 receiving large RPC messages"
In-reply-to: <3d467e813614d8314d4defe94b3409635974b06c.camel@kernel.org>
References: <20250103010002.619062-1-cel@kernel.org>,
 <3d467e813614d8314d4defe94b3409635974b06c.camel@kernel.org>
Date: Sat, 04 Jan 2025 11:44:16 +1100
Message-id: <173595145653.22054.7944992237426867395@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 04 Jan 2025, Jeff Layton wrote:
> On Thu, 2025-01-02 at 20:00 -0500, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >=20
> > I noticed that a handful of NFSv3 fstests were taking an
> > unexpectedly long time to run. Troubleshooting showed that the
> > server's TCP window closed and never re-opened, which caused the
> > client to trigger an RPC retransmit timeout after 180 seconds.
> >=20
> > The client's recovery action was to establish a fresh connection
> > and retransmit the timed-out requests. This worked, but it adds a
> > long delay.
> >=20
> > I tracked the problem to the commit that attempted to reduce the
> > rate at which the network layer delivers TCP socket data_ready
> > callbacks. Under most circumstances this change worked as expected,
> > but for NFSv3, which has no session or other type of throttling, it
> > can overwhelm the receiver on occasion.
> >=20
> > I'm sure I could tweak the lowat settings, but the small benefit
> > doesn't seem worth the bother. Just revert it.
> >=20
> > Fixes: 2b877fc53e97 ("SUNRPC: Reduce thread wake-up rate when receiving l=
arge RPC messages")
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/svcsock.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >=20
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 95397677673b..cb3bd12f5818 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -1083,9 +1083,6 @@ static void svc_tcp_fragment_received(struct svc_so=
ck *svsk)
> >  	/* If we have more data, signal svc_xprt_enqueue() to try again */
> >  	svsk->sk_tcplen =3D 0;
> >  	svsk->sk_marker =3D xdr_zero;
> > -
> > -	smp_wmb();
> > -	tcp_set_rcvlowat(svsk->sk_sk, 1);
> >  }
> > =20
> >  /**
> > @@ -1175,17 +1172,10 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqst=
p)
> >  		goto err_delete;
> >  	if (len =3D=3D want)
> >  		svc_tcp_fragment_received(svsk);
> > -	else {
> > -		/* Avoid more ->sk_data_ready() calls until the rest
> > -		 * of the message has arrived. This reduces service
> > -		 * thread wake-ups on large incoming messages. */
> > -		tcp_set_rcvlowat(svsk->sk_sk,
> > -				 svc_sock_reclen(svsk) - svsk->sk_tcplen);
>=20
> Could we instead clamp this to the window size so that we at least only
> do a wakeup for each window-size chunk?

tcp_set_rcvlowat() already imposes and upper limit - based on configured
queue space.  So I don't think we need to clamp.

I note that the calculation is wrong. sk_tcplen includes the size of the
4byte length header, but svc_sock_reclen() does not.  Other places there
these two numbers are compared, sizeof(rpc_fraghdr) is subtracted from
sk_tcplen.
So there is a corner case where the size passed to tcp_set_rcvlowat() is
negative.  The two numbers in the subtraction are u32 and the function
expects "int".
I didn't dig enough to understand how an negative would be handled.

>=20
> > -
> > +	else
> >  		trace_svcsock_tcp_recv_short(&svsk->sk_xprt,
> >  				svc_sock_reclen(svsk),
> >  				svsk->sk_tcplen - sizeof(rpc_fraghdr));
> > -	}
> >  	goto err_noclose;
> >  error:
> >  	if (len !=3D -EAGAIN)
>=20
> Reverting for now is fine though.

Agreed.  I would expect modern network cards to deliver fairly large
packets to the application already.  Still, it would be nice to
understand what is really happening.  Setting rcvlowat shouldn't be able
to cause the window size to go to zero.

NeilBrown


>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20


