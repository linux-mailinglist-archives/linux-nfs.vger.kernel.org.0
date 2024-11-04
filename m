Return-Path: <linux-nfs+bounces-7637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F370D9BAC3F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 06:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7B0281A4B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98017D341;
	Mon,  4 Nov 2024 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nWq9D+r1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNFYOZ7c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gk3m8sJV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JuQnbuES"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AE14E2FD
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699512; cv=none; b=l1mHmy/X1Rc/fsRTgYJ6LH2K24jfa/jARnkI7sPr1dXxsAzgNsDG7IvaH0WSTBnjE2t9l0Iwd+JOBt20laZe14/KMeHL4RsOnsUlu/vIoik+monhOqC7SOI/JRAS9jujoJ6gFS4S1yWFGO0TMqXmdRfkPnwRqReCbxrlln8EcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699512; c=relaxed/simple;
	bh=gskBtadH3UOZpHm5NyeNWCyDrcyrX6o1cQiMX8hdMKA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LeIG2wMvuisJN1WjBI+mv8hYV/Y9a8oox0a9JBHoDDNX3NHnaPFOfZxFXUPpK9eLL5xeCwqaJYt3UBEpkM1a+x5v05AlrkkfitvvSPFXWgBgwDg3M1wn1Wx4dvOvUVH4CRn1hU1euygxQ1IlldGijX4VKacq4cU9ELPouHrCQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nWq9D+r1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNFYOZ7c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gk3m8sJV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JuQnbuES; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C40B31F7B3;
	Mon,  4 Nov 2024 05:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730699509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+JmAdL9uVQLoqu/d3C/lLBPe0bC+/TXuMuElibE0MM=;
	b=nWq9D+r1Qq+Z3SIwUMkBw7BSpuVIDDwGG8D5BOjUgwM7k4wwXhq+Cmr7AJV0jHKmpQTNyI
	QEbzG5aVyVrIe3RD0A1S4QjZunZItRkrK1b/YTMjPe2LkJZ4J+6oCn1En8csHnYbzdFa9R
	wynhobmF+hwYGr7NuV70cMHhVFAFHD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730699509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+JmAdL9uVQLoqu/d3C/lLBPe0bC+/TXuMuElibE0MM=;
	b=LNFYOZ7cJ05ahO8MqdNAR61S2wUghTlH3L5G3zXYzGDyEG5JC15bzUYru67wJ8+IlDjoIb
	TZYvQat5eSAcR5Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gk3m8sJV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JuQnbuES
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730699508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+JmAdL9uVQLoqu/d3C/lLBPe0bC+/TXuMuElibE0MM=;
	b=gk3m8sJVxXENW4COWeNV+M1WSlmjO0O4z5iuj4QvMKSUkmoicrXT/gCkB3cAH7ItF+7r2m
	1pMSguTk3yAZuVhmS9vWHp07UcrROVHQ96JMkdmRGS+vCGBIZB4wyeBpVRT7p8fvCG1EZi
	1EOKDaMnYOFE6Y2WxOtTZM61IMo3UXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730699508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+JmAdL9uVQLoqu/d3C/lLBPe0bC+/TXuMuElibE0MM=;
	b=JuQnbuESMJ/jO/CiJTzBr+1/Zj6r94KDCnQ/yxiYhVkirEPe4sLijERaleOp8AroX80XrR
	AVWTnIsiWgWNkmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 460CE136D9;
	Mon,  4 Nov 2024 05:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RBXBOvJgKGcrXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Nov 2024 05:51:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Benjamin Coddington" <bcodding@redhat.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
In-reply-to: <CB9F2E14-F4E8-46B7-9AE1-669C1DCC605A@redhat.com>
References: <172845168634.444407.8582369591049332159@noble.neil.brown.name>,
 <CB9F2E14-F4E8-46B7-9AE1-669C1DCC605A@redhat.com>
Date: Mon, 04 Nov 2024 16:51:44 +1100
Message-id: <173069950400.81717.12745863761363405487@noble.neil.brown.name>
X-Rspamd-Queue-Id: C40B31F7B3
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 09 Oct 2024, Benjamin Coddington wrote:
> On 9 Oct 2024, at 1:28, NeilBrown wrote:
>=20
> > xs_tcp_finish_connecting() can return -ENOTCONN but the switch statement
> > in xs_tcp_setup_socket() treats that as an unhandled error.
> >
> > If we treat it as a known error it would propagate back to
> > call_connect_status() which does handle that error code.  This appears
> > to be the intention of the commit (given below) which added -ENOTCONN as
> > a return status for xs_tcp_finish_connecting().
> >
> > So add -ENOTCONN to the switch statement as an error to pass through to
> > the caller.
> >
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1231050
> > Link: https://access.redhat.com/discussions/3434091
> > Fixes: 01d37c428ae0 ("SUNRPC: xprt_connect() don't abort the task if the =
transport isn't bound")
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> Thanks!  We should have chased this down ages ago..
>=20
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Thanks Ben.

Trond, Anna: have you had a chance to look at this yet?

Thanks,
NeilBrown

