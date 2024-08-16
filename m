Return-Path: <linux-nfs+bounces-5423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613B9553A1
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 01:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2811F2238D
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 23:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A58145A15;
	Fri, 16 Aug 2024 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UIidhMck";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Ajf3XGQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UIidhMck";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Ajf3XGQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1E43AD7;
	Fri, 16 Aug 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849649; cv=none; b=OZR/ZAlah73sZ7+lkrY2HsXoNkLpOv96F4c+T8dwC2B0EVdLVQwMMJQFueLUCbgoDjGjG39Vh/im4hWNKxB+PRMJ6w2LBEABVdj452PAuIWl+azLgjlMDkoCiLeizQHOS7eXPcCjQAhYzC1Pq8yjFx80XZO21QwI6kE0WsNC8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849649; c=relaxed/simple;
	bh=018n8H5LGj1B7wbo64q/X+TJutuDxCzou0fSB4GDd8A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sS9hiYBLWinj1gr5VPrxO458LafJ9wwszDTrauAjluvRf1et9Xyz43IE4CAGNUt0l0G4MNLfq3/stb4Rx3uofJOBby9X5i2mttNpPyMv66x06BiLT32EH5fiQwWdYyiLuLcFAFbRyJazsc+O4ghSjHgXysx1y6A9X3Rfw76gw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UIidhMck; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Ajf3XGQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UIidhMck; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Ajf3XGQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0CF820128;
	Fri, 16 Aug 2024 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723849643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4ZHXKj3lrO8o4VZAqxfiVbA/4WLD9i++ayGHka+ORM=;
	b=UIidhMckD/RpxeBDyc8kQwvLa4UddzuvoLB5rmYbAYaae0i42uXlBMaVG4BUBf928X95IZ
	hE1rExOBBi8QkN0/UZ5H0zJL6merjRfTN6ujWClIRc9z01B/9Ew4q49mTgKND4l6SRdzQ8
	3qZsrOwGN2ltXp9bECzM2+4oyK5ZGxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723849643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4ZHXKj3lrO8o4VZAqxfiVbA/4WLD9i++ayGHka+ORM=;
	b=+Ajf3XGQ7u59gExJJmr+q4JJnq3i+zcnZSrsMM/J9BfrRMs2xyHn1QlPcMqJx4wxhkmlKK
	dNa9trCPs86+5fBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UIidhMck;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+Ajf3XGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723849643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4ZHXKj3lrO8o4VZAqxfiVbA/4WLD9i++ayGHka+ORM=;
	b=UIidhMckD/RpxeBDyc8kQwvLa4UddzuvoLB5rmYbAYaae0i42uXlBMaVG4BUBf928X95IZ
	hE1rExOBBi8QkN0/UZ5H0zJL6merjRfTN6ujWClIRc9z01B/9Ew4q49mTgKND4l6SRdzQ8
	3qZsrOwGN2ltXp9bECzM2+4oyK5ZGxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723849643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4ZHXKj3lrO8o4VZAqxfiVbA/4WLD9i++ayGHka+ORM=;
	b=+Ajf3XGQ7u59gExJJmr+q4JJnq3i+zcnZSrsMM/J9BfrRMs2xyHn1QlPcMqJx4wxhkmlKK
	dNa9trCPs86+5fBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 538F01379A;
	Fri, 16 Aug 2024 23:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QxzuAqbbv2aEDAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 16 Aug 2024 23:07:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: kunwu.chan@linux.dev, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Kunwu Chan" <chentao@kylinos.cn>
Subject: Re: [PATCH] SUNRPC: Fix -Wformat-truncation warning
In-reply-to: <a957b7bb-e5c2-480f-8f5c-2fa40637d8ba@lunn.ch>
References: <20240814093853.48657-1-kunwu.chan@linux.dev>,
 <a957b7bb-e5c2-480f-8f5c-2fa40637d8ba@lunn.ch>
Date: Sat, 17 Aug 2024 09:07:11 +1000
Message-id: <172384963142.6062.15815263849399206433@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A0CF820128
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -6.51

On Sat, 17 Aug 2024, Andrew Lunn wrote:
> On Wed, Aug 14, 2024 at 05:38:53PM +0800, kunwu.chan@linux.dev wrote:
> > From: Kunwu Chan <chentao@kylinos.cn>
> >=20
> > Increase size of the servername array to avoid truncated output warning.
> >=20
> > net/sunrpc/clnt.c:582:75: error=EF=BC=9A=E2=80=98%s=E2=80=99 directive ou=
tput may be truncated
> > writing up to 107 bytes into a region of size 48
> > [-Werror=3Dformat-truncation=3D]
> >   582 |                   snprintf(servername, sizeof(servername), "%s",
> >       |                                                             ^~
> >=20
> > net/sunrpc/clnt.c:582:33: note:=E2=80=98snprintf=E2=80=99 output
> > between 1 and 108 bytes into a destination of size 48
> >   582 |                     snprintf(servername, sizeof(servername), "%s",
> >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   583 |                                          sun->sun_path);
>=20
> I think this has come up before, but i could be mis-remembering.
> Please could you do a search for the discussion. The fact it is not
> solved suggests to me it is not so simple to fix. Maybe there is some
> protocol implications here.
>=20
>        Andrew
>=20

All I could find was=20

 https://lore.kernel.org/all/1648103566-15528-1-git-send-email-baihaowen@meiz=
u.com/

which essentially followed the same path as this conversation.  The
patch was resubmitted using UNIX_PATH_MAX but never responded to by the
relevant maintainers.

There are no protocol implications.  This string is only used for
informational messages.

NeilBrown

