Return-Path: <linux-nfs+bounces-8141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F969D30B2
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90450B22D62
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7031C3319;
	Tue, 19 Nov 2024 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a3wEhyc7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZNLKcJ2A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a3wEhyc7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZNLKcJ2A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465701D1E65
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732056746; cv=none; b=X/Jy/2Q/K+Px8llofeUJ6X1cqFEtTMO/t0REgzmnk+yOpOMTMXW61SU6jVE6qqB6oNzw8EDtYZvp3KAMU2LglHKhlUX+j2ZJOFOVRT+NP99Sp+4ng0xGp+GycAqQ/MkGEEXi27q3wx1UQceGVT4IjBKsCdll2QoE6SwwItIhNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732056746; c=relaxed/simple;
	bh=I4/jeh+S8dh2VBmV1iDz70oA9u/rkTUzgQ/yStzPIuA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jXzJNCrwh6xMZ93UhjNGtM01hfuSIP3J1Iu4l95rdOSLJJrbgjaxzCQrt9mG5/9H7z5fgI3IowQd8RwKHICnMZQyWdg4skrbDwxm5SJlAr94oBRYppNKaRbVgshzoP04YY3Oi/AgadllxTAD1Jli9qbqX/1I7zZvYzuEVAREZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a3wEhyc7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZNLKcJ2A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a3wEhyc7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZNLKcJ2A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6277D1F395;
	Tue, 19 Nov 2024 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732056743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0eNw7cJ/h6iRTKBfOs1u/PTP3o/FI39ltIu/LCPZM=;
	b=a3wEhyc7pc/f6JD25y5mUpMUQ9ROioXCe01VRdJ4kHubAVh0FajdA07aomtlrKbcpd+wcu
	SOimAkAzxxmREFdzL8a77gwOqml3ojsWkgoHrYm3ZDIaUXj99lZTZMOdVLNH5EMfQPR/Bm
	9zIP/2iUN1QGXX+wuHqHqy0a47KPd+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732056743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0eNw7cJ/h6iRTKBfOs1u/PTP3o/FI39ltIu/LCPZM=;
	b=ZNLKcJ2AIRHHKXv1AFW5vrFCeKrEoO/oXMbIwBgKJA4eEnisgLZiQMI4yiX8ENpIAh83Qe
	a94XiIQL/gY7ezCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a3wEhyc7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZNLKcJ2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732056743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0eNw7cJ/h6iRTKBfOs1u/PTP3o/FI39ltIu/LCPZM=;
	b=a3wEhyc7pc/f6JD25y5mUpMUQ9ROioXCe01VRdJ4kHubAVh0FajdA07aomtlrKbcpd+wcu
	SOimAkAzxxmREFdzL8a77gwOqml3ojsWkgoHrYm3ZDIaUXj99lZTZMOdVLNH5EMfQPR/Bm
	9zIP/2iUN1QGXX+wuHqHqy0a47KPd+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732056743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA0eNw7cJ/h6iRTKBfOs1u/PTP3o/FI39ltIu/LCPZM=;
	b=ZNLKcJ2AIRHHKXv1AFW5vrFCeKrEoO/oXMbIwBgKJA4eEnisgLZiQMI4yiX8ENpIAh83Qe
	a94XiIQL/gY7ezCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C9841376E;
	Tue, 19 Nov 2024 22:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LLBTBaUWPWd0JAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:52:21 +0000
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
Subject:
 Re: [PATCH 0/6 RFC v2] nfsd: allocate/free session-based DRC slots on demand
In-reply-to: <2424176e3b8463abbfd532e05101329b2301f287.camel@kernel.org>
References: <20241119004928.3245873-1-neilb@suse.de>,
 <2424176e3b8463abbfd532e05101329b2301f287.camel@kernel.org>
Date: Wed, 20 Nov 2024 09:52:10 +1100
Message-id: <173205673051.1734440.4290662845931024709@noble.neil.brown.name>
X-Rspamd-Queue-Id: 6277D1F395
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,noble.neil.brown.name:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 20 Nov 2024, Jeff Layton wrote:
> On Tue, 2024-11-19 at 11:41 +1100, NeilBrown wrote:
> > Here is v2 of my series for on-demand allocation and freeing of session D=
RC slots.
> >=20
> > - Now uses an xarray to store slots, and the limit is raised to 2048
> > - delays retiring a slot until the client has confirmed that it isn't
> >   using it as described in RFC:
> >=20
> >       The replier SHOULD retain the slots it wants to retire until the
> >       requester sends a request with a highest_slotid less than or equal
> >       to the replier's new enforced highest_slotid.
> >=20
> > - When a retired slot is used, allow the seqid to be the next in sequence
> >   as required by the RFC:
> >=20
> >          Each time a slot is reused, the request MUST specify a sequence
> >          ID that is one greater than that of the previous request on the
> >          slot.
> >
> >   or "1" as (arguably) allowed by the RFC:
> >=20
> >          The first time a slot is used, the requester MUST specify a
> >          sequence ID of one
> >=20
>=20
> I thought that the conclusion of the IETF discussion was that we should
> reset this to 1. It'd be ideal to just do that, as then we wouldn't
> need NFSD4_SLOT_REUSED.

I thought the conclusion was:

  I'm convinced.=C2=A0 The next draft of rfc5661bis will address this issue.

Until the issue is addressed I don't think it would be wise to preempt
the result.

>=20
> Are there any clients that expect to reuse the old seqid in this
> situation? I know the Linux client doesn't. Do Solaris or FreeBSD?

I don't know.  But I tend to code the the spec, not to other clients.
I still think the specs says

         Each time a slot is reused, the request MUST specify a sequence
         ID that is one greater than that of the previous request on the
         slot.

and I don't see any good reason not to treat what we are doing here as
"reuse".=20

So I'm making a concession to the linux client and to you by allowing
'1'.  I'm still not convinced that it is a good idea.  At best I'm
convinced that the spec can be read to suggest that might be an option.

Thanks,
NeilBrown

