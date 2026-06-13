Return-Path: <linux-nfs+bounces-22540-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EA+vJq2qLGrLUwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22540-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 02:56:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B867D5C1
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 02:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=XXmozKQw;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="N Q3Qmnj";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22540-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22540-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB0EE30B987F
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 00:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C87142E83;
	Sat, 13 Jun 2026 00:55:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204323370F
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2026 00:55:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312159; cv=none; b=LQ53AqmYKXkf673ru6BKtYjTUVD5QBDA0/eQskv4oQTmWOxiBGsi8k01tYqv+x6Wq0Aw3CWugORswxOqqq9Kj/f6UiKeN0LQ3DYbKEemgzAC9vkJq6myfWkVVIoTiKPCVpXFRAQ3C3OzWmtZW/2HW+Pshajj3knpzIe1LYCpR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312159; c=relaxed/simple;
	bh=iDQ555de6RtF7qXgoQB+UMf2HF0WZIW0B4Y6XkOo1/w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oOJfM7O6qWQu8usCLKj/hM8VgluWk4E78zzMKfdMRTInhII7WERf3XFiTtJMee23tB++wfG0FvT579MypIGqhFAKlISUuA5RWAVh1xCUn+MF5HRjsOwzElwKjfnDfWVWkglcMWJXc7JMwnpHw5V2lJt/fC5uKMF4pWsukdniluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XXmozKQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQ3Qmnjx; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EFF8EC0086;
	Fri, 12 Jun 2026 20:55:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 20:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1781312156; x=1781398556; bh=f0kE5gQ7G3vW6L3U6qtWbmCW8BgeF5gG6hQ
	WBkzaaiQ=; b=XXmozKQwcxc33X3OXWZYRCu9O0CvVbFb6+qpRATnF9ZCNhGy6rs
	FS+F8PyIL8AF7RuVDI/doh3H7XAHDEabT9jblFI5NOJHN7VaI3KoKC6e7oDV5NFQ
	fly8z8Q8mWGQr1GnJNcZzO1GDOc7grgr5Ohxj2aqnJMM9eHmlIT4jXVPNMFur5Hu
	O1gmIuhIxc43fOz4nXIyUIvicRxTIi5LWE3ApZvTz/jaKA4VHODXmsdjEJuJ3Kwm
	LXrIWOTSBZ08Grr4seTEWg4upAoja+sYemIMONhxoYUWPKLeZc1alf4Ub2x8D20W
	ZntMZbd7cxRKM1qYFoQo4lr0tv285l0XqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781312156; x=
	1781398556; bh=f0kE5gQ7G3vW6L3U6qtWbmCW8BgeF5gG6hQWBkzaaiQ=; b=N
	Q3Qmnjx1Mq6gkm3PZLdDVXrOFstzRJNK3Laq1PqI0zk1mrB28MtsPorYjgLVQW85
	8UrrkTp09dODyn/6p+i/6OBWzNrk6G+PkRzrC4FLfijITdrs1ST5f5Za06SfJBlU
	ZnOCwqOSshyF/pmEzx10AqsURI4YENUXiowVHkKrgKhPLZPGVJUjJKhq5qgDDyxA
	TRUjTIU8+YkjeEm2t/r7ztiHN53KVdwFuT+Za+NJMuN0beT4YMrm7iyGmop0URbE
	z4URNi8kvvO8ySoleM2eQ8bzm4JwSaBUiSS4+xVN6bzc61Tl/M5DkjcB0yA1DrM/
	0Rs2ylVQFmTpyJJLY4zNg==
X-ME-Sender: <xms:m6osaoI968dD7IGO5C8w86EpxH5MjYKQBT7JktzQ5sR1HTwBVC1OLw>
    <xme:m6osavK8cksgLIaDLuP7VCAMvWDSDjGFzp29JsbPNY31K7NaQ_Yu3zfm7aFZ4wowt
    I41pSzDMuDNso3H0fXDceE8l6BsO1r-vjMMDjJDC7y842bjEg>
X-ME-Received: <xmr:m6osatvsna4CRFV_B797EcZws70avJlREnWO-eW6k54rTdgn-p7f28hyBevdy2ScKFPGMJpdX35iCqTPSER825lBOjvKIM4>
X-ME-Proxy-Cause: dmFkZTF8lje03PSB6463VssdR+yeQyQDCAFSU8CKWn1y0Yrq8hGo+LGLFRQF7jNTRoyPN0
    tFSH0zOYVcrvGCiqqvA2314VLF7LfA3AsaZbF2ZmGf2Z+T6Ay7+9AGzbM8BSxJ5gdWClcr
    66APyXpdGC/MZ2xir499jkW7sPBC11FGs8wAe6raHxQSgbhpERP/BJehEq6VOMxI+TKW0F
    aF9SSvI8mqnmaQnrmRNWsC6UjtZSpf0gVxT579kqrElqeiyD5VolqlAsmHKfKmbybM5a5X
    ZjYPAzEi2gL0WIx3xarIeQ7EwvVKF0WvIXFAK6McfQzFF5sBea6wWdMh1N3K6SAK4IEwqG
    Kc+7XW+Bb6AuqBfC6yAY9sbcGGU2bs6Ix5N8WT6W9e9ZA6lDMmCEHmlYPgEC75T/p99Ktm
    /j1OKY0knGreeAR8vQrAoiM3TyiO7Pljof3a7ybADhfthvXOwSx+60nx4kgE8j2vARXrxc
    KZDJs89ppzujSjkjyXA61LAR2oKiMJBTC1/Fg7zxpKu0/ib6/CuTvucNS0VB1GfsA+1NkJ
    k4W9bls6THn8lV3iv5toSOq4LfT0l4NyEUghdZ2N/RLA3E7Vuwy2enz0tqEWD4IxpeI9F8
    n0Y+ipxkE04o+MoW5sjS+nMuPRtWGybGM+YpqpPPE9nkWs+r85bzwN5rNmXQ
X-ME-Proxy: <xmx:m6osakSpDlkJt7lOeJX_Wr1IRK9WN_iiYDWIGkxyYK-qm_uoyI79lQ>
    <xmx:m6osarNfQscePFLg2xhPzJKbvImkP08waKgIb6_-ndbz-NGckl0NwA>
    <xmx:m6osahbf1zpYzG_edYEdgy3HDV8D-fc2yoPrvxHeRrmyS6q3ieXOvg>
    <xmx:m6osatzTikRf9VPMWLmtk0OJxYJpWAD3MinSAOJoVYnUBZDaLiQFrg>
    <xmx:nKosarrBGAnJKTNZ7NvKPGzksCrGNl5UhSTsPL2MrfNCUEXQyWQCDOSQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 20:55:54 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
In-reply-to: <83C74302-2A2B-48B6-B0F0-D5E8CB487BBC@hammerspace.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
  <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
  <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
  <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
  <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
  <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
  <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
  <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
  <20555E8B-0E49-4328-8B31-0F73C3D286FE@hammerspace.com>
  <178060780940.3392745.3574880233025675236@noble.neil.brown.name>
  <83C74302-2A2B-48B6-B0F0-D5E8CB487BBC@hammerspace.com>
Date: Sat, 13 Jun 2026 10:55:49 +1000
Message-id: <178131214982.3002522.3853010351245262459@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22540-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,noble.neil.brown.name:mid];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC7B867D5C1

On Fri, 05 Jun 2026, Benjamin Coddington wrote:
> On 4 Jun 2026, at 17:16, NeilBrown wrote:
> 
> > On Wed, 03 Jun 2026, Benjamin Coddington wrote:
> >> On 2 Jun 2026, at 23:44, Chuck Lever wrote:
> >>
> >>> On Tue, Jun 2, 2026, at 3:53 PM, NeilBrown wrote:
> >>
> >>>> Idle clients will get pushed back to 1 slot, active client will tend
> >>>> towards a "fair" share based on how comparatively busy they are.
> >>>>
> >>>> This wouldn't help for v3 of course but I don't think we need these
> >>>> advanced features for v3.
> >>>
> >>> Ben’s employer might disagree with that :-)
> >>
> >> Yes - v3 is pretty important to us here.
> >
> > Can you remind me why v3 is important for you?  Is it the lower
> > state-management overhead, or something else?
> 
> Flexfiles uses v3 in its data plane, and..
> 
> > Is there some way would could improve the v4 implementation or protocol
> > to make it comparable to v3 for your use case?
> 
> I don't think so - the stateless nature of v3 gives it distinct advantages
> (and disadvantages) over v4 for some use cases.  That property can't be
> added to v4.

v4 already has the anonymous stateid which seems perfect for a data
plane.
You can read/write with it just like v3 (i.e.  access check on every IO
etc), but there is no state to recover.
You still get client-state and session-state when can be used for flow
control, but these don't need to be recovered so they don't impose the
same costs as open state.

I wonder if flex-files can be updated to allow v4 with anonymous stateid.
We would have to enhance the Linux NFS client to have a "stateless"
mount option, or similar.

> 
> Also, because knfsd doesn't have different resource pools for each version
> we're going to want to continue to balance the pool for all versions
> exported.

But it could if we wanted it to and had a coherent model of how that
would work.  We could parse out the RPC program and version before
queuing for a thread, much like we already parse out the TCP message
size.

We could even do that today: create a separate net-namespace for the
separate pool, and add some iptables rules to redirect select traffic to
that namespace.  iptables cannot switch on RPC version, but it could
switch on source-IP if we knew which clients used v3 and which didn't.

NeilBrown

