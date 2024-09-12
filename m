Return-Path: <linux-nfs+bounces-6432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD79774A8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 01:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F3A1F24960
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B436819C54B;
	Thu, 12 Sep 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YGW9RYlQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jiJ7SP9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YGW9RYlQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jiJ7SP9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19E49654;
	Thu, 12 Sep 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182197; cv=none; b=g11YpcZRxE4kTTgt6R//+aoLw3Hy2ro6LsgnmONYiw95rOM+6Jf6edCnFH86Ksj/QwG5inxvSk0PvJcld7k3Qb9Iyr5/nYpOzkQefuKHymf9mYHTQYkOcchMeXC9yTyGfLvBnvKmpDTn1OSIjzcdrG5rcIHtqzGX5nRL+bmlBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182197; c=relaxed/simple;
	bh=yiguOJdUYp3yFma5ZEt8wrGVvP4CXoNNCbs9JMzVYWk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=V1l4OWrcvKK7IMucX9drFI0dcNPMEFCpnSpNAx0MbfyTjwZjlJ23N9IcasI5x63wubHqXq/otHtLDoPE9nflbYTI804qd9cu/i4q3Kfb5i4RqF/zaEbi0M9N97D1Hi8kxrCA0qglV2CC2ruYSmaTPzjHMhi5JyXvI45JtaXLins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YGW9RYlQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jiJ7SP9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YGW9RYlQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jiJ7SP9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DDC621B10;
	Thu, 12 Sep 2024 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726182194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGDYlmAhXS7z47tNMqUGPEz61zrdgRgJdVTv3ABm+ZQ=;
	b=YGW9RYlQ3qrGIzTaNu/3NC4xDP2EK0I3rylAL2/xvISLe7NFYoZYdT85f5Ky6wB71srylh
	kA25nlUH/Cea1DK5ZdwnM28KyE3UZ0NuD4ZcN8cFjARg6OUnXMfWdFpaF0RFRapqKu9t31
	hE4rmroLMd013twOwJA52lYkn2vKkic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726182194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGDYlmAhXS7z47tNMqUGPEz61zrdgRgJdVTv3ABm+ZQ=;
	b=0jiJ7SP9xwI1RP7DEGw6nH9fQT+ZixZ/UIaG/xi4LCZuaP0JVj0ohEIU1qdRZ+7YQC4wBe
	ra/Kh80yrcRN0cDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YGW9RYlQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0jiJ7SP9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726182194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGDYlmAhXS7z47tNMqUGPEz61zrdgRgJdVTv3ABm+ZQ=;
	b=YGW9RYlQ3qrGIzTaNu/3NC4xDP2EK0I3rylAL2/xvISLe7NFYoZYdT85f5Ky6wB71srylh
	kA25nlUH/Cea1DK5ZdwnM28KyE3UZ0NuD4ZcN8cFjARg6OUnXMfWdFpaF0RFRapqKu9t31
	hE4rmroLMd013twOwJA52lYkn2vKkic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726182194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGDYlmAhXS7z47tNMqUGPEz61zrdgRgJdVTv3ABm+ZQ=;
	b=0jiJ7SP9xwI1RP7DEGw6nH9fQT+ZixZ/UIaG/xi4LCZuaP0JVj0ohEIU1qdRZ+7YQC4wBe
	ra/Kh80yrcRN0cDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7086213A73;
	Thu, 12 Sep 2024 23:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kvABCi9z42afHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 12 Sep 2024 23:03:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix nfs4_disable_idmapping option
In-reply-to: <20240912223858.22qibyh3xwk2pqw5@pali>
References: <>, <20240912223858.22qibyh3xwk2pqw5@pali>
Date: Fri, 13 Sep 2024 09:03:00 +1000
Message-id: <172618218021.17050.8500126114376063163@noble.neil.brown.name>
X-Rspamd-Queue-Id: 1DDC621B10
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> On Friday 13 September 2024 08:26:02 NeilBrown wrote:
> > On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> > > NFSv4 server option nfs4_disable_idmapping says that it turn off server=
's
> > > NFSv4 idmapping when using 'sec=3Dsys'. But it also turns idmapping off=
 also
> > > for 'sec=3Dnone'.
> > >=20
> > > NFSv4 client option nfs4_disable_idmapping says same thing and really it
> > > turns the NFSv4 idmapping only for 'sec=3Dsys'.
> > >=20
> > > Fix the NFSv4 server option nfs4_disable_idmapping to turn off idmapping
> > > only for 'sec=3Dsys'. This aligns the server nfs4_disable_idmapping opt=
ion
> > > with its description and also aligns behavior with the client option.
> >=20
> > Why do you think this is the right approach?
>=20
> I thought it because client has same configuration option, client is
> already doing it, client documentation says it and also server
> documentation says it. I just saw too many pieces which agreed on it and
> just server implementation did not follow it.
>=20
> And to make mapping usable, both sides (client and server) have to agree
> on the configuration.
>=20
> So instead of changing also client and client's documentation it is
> easier to just fix the server.
>=20
> > If the documentation says "turn off when sec=3Dsys" and the implementation
> > does "turn off when sec=3Dsys or sec=3Dnone" then I agree that something
> > needs to be fixed.  I would suggest that the documentation should be
> > fixed.
> >=20
> > From the perspective of id mapping, sec=3Dnone is similar to sec=3Dsys.
>=20
> It is similar, but quite different. With sec=3Dsys client sends its uid
> and list of gids in every (RPC) packet and server authenticate client
> (and do mapping) based on it. With sec=3Dnone client does not send any uid
> or gid. So mostly uid/gid form is tight to sec=3Dsys.
>=20

With sec=3Dnone I don't think that any mapping makes sense except to map
all uids and gids to "none" or similar.

The documented purpose of nfs4_disable_idmapping is to "ease migration
from NFSv2/v3".  That suggests that where relevant it should behave
mostly like v2/v3.

I don't feel strongly about this.  You appear to be actually using
AUTH_NONE authentication.  What behaviour would work best for your
use-case, and why?

NeilBrown

