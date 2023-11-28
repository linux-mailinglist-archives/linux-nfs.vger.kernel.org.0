Return-Path: <linux-nfs+bounces-154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09B7FC9D1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C022822A9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F684C77;
	Tue, 28 Nov 2023 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Ra8xRVo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ieoRLPUP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAAF1998
	for <linux-nfs@vger.kernel.org>; Tue, 28 Nov 2023 14:45:44 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0E5E1F898;
	Tue, 28 Nov 2023 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701211542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz4ew+BdvytCRckRn7GY912KIqwXO3KQLplRSQ7MU8o=;
	b=1Ra8xRVocXX+OAZfoTuxnDkgkEA3krqv6Uhybovnzu8v6UfcZcK1PCEoyNULwWYc9xirf5
	/wLsn5lRfSpcNrM9VOFADoO9PPYHdo6ik0UVojDYfjnv8eB1pZw2i72dAMyoIe969cpTY+
	bVjwuwiJKXE6fkQMwdQuh4qf7YIT1gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701211542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz4ew+BdvytCRckRn7GY912KIqwXO3KQLplRSQ7MU8o=;
	b=ieoRLPUPze1MVXPDvNaOiPqe07+AvqRWVh3xyUziabcA1ixZ6xd/AsUO+V5VNFC0c4QP/R
	k/IFKMhZbtAUIJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF8413763;
	Tue, 28 Nov 2023 22:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m7cpFJNtZmU2TgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 Nov 2023 22:45:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "thfeathers" <thfeathers@sina.cn>
Cc: "Olga Kornievskaia" <aglo@umich.edu>,
 "Trond Myklebust" <trondmy@hammerspace.com>, jlayton@kernel.org,
 chuck.lever@oracle.com, tom@talpey.com, Dai.Ngo@oracle.com, kolga@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: _xprt_switch_find_current_entry return xprt with
 condition find_active
In-reply-to: <609DC0E2-4262-43A3-A9CF-54AEC3FD5383@sina.cn>
References:
 <CAN-5tyHKddhV4OKL+ZhKKTXwoPiSug6rzRtv=Fq9KsY2wH0iPw@mail.gmail.com>,
 <609DC0E2-4262-43A3-A9CF-54AEC3FD5383@sina.cn>
Date: Wed, 29 Nov 2023 09:45:36 +1100
Message-id: <170121153646.7109.4907528705695653693@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.65 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FREEMAIL_TO(0.00)[sina.cn];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.35)[76.39%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.cn];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.65

On Tue, 28 Nov 2023, thfeathers wrote:
>=20
> > =E5=9C=A8 2023=E5=B9=B411=E6=9C=8828=E6=97=A5=EF=BC=8C06:26=EF=BC=8COlga =
Kornievskaia <aglo@umich.edu> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > =EF=BB=BFOn Mon, Nov 27, 2023 at 11:31=E2=80=AFAM NeilBrown <neilb@suse.d=
e> wrote:
> >>=20
> >>> On Tue, 28 Nov 2023, Trond Myklebust wrote:
> >>> On Mon, 2023-11-27 at 23:39 +0800, jsq wrote:
> >>>> [You don't often get email from thfeathers@sina.cn. Learn why this is
> >>>> important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>>=20
> >>>> current function always return a active xprt or NULL no matter what
> >>>> find_active
> >>>=20
> >>>=20
> >>> This patch clearly breaks xprt_switch_find_current_entry_offline().
> >>=20
> >> I think it actually fixes xprt_switch_find_current_entry_offline().
> >>=20
> >> Looking closely at _xprt_switch_find_current_entry:
> >>=20
> >>                if (found && ((find_active && xprt_is_active(pos)) ||
> >>                              (!find_active && xprt_is_active(pos))))
> >>=20
> >> and comparing with similar code in xprt_switch_find_next_entry:
> >>=20
> >>                if (found && ((check_active && xprt_is_active(pos)) ||
> >>                              (!check_active && !xprt_is_active(pos))))
> >>=20
> >> There is a difference in the number of '!'.  I suspect the former is
> >> wrong.
> >> If the former is correct, then "find_active" is irrelevant.
> >=20
> > Thanks Neil for pointing it out. We need the "find_active", otherwise
> > as Trond pointed out it breaks the offline function. But I do believe
> > I missed the "!" in the logic. I believe the reason this hasn't caused
> > problems is because for the offline transports we never use the
> > xprt_iter_xprt(). We only iterate thru the get_next when we iterate
> > offline transports. But I should fix the function that adds the "!".
> >=20
> return a xprt active state EQUAL find_active
> maybe =E2=80=9C&&=E2=80=9D =E2=80=9C||=E2=80=9D =E2=80=9C!=E2=80=9Dlogic no=
t need

True - and equality test of the boolean values is perfectly correct.
Maybe it is simpler.  Maybe it is a bit less common so the meaning may
not be as immediately obvious to some readers.
I see benefits in both directions, so the choice would be up to the
people who work with the code most.

Thanks for reporting this error by the way.

NeilBrown


> >>=20
> >> NeilBrown
> >>=20
> >>> Furthermore, we do not accept patches without a real name on a Signed-
> >>> off-by: line.
> >>>=20
> >>> So NACK on two accounts.
> >>>=20
> >>> --
> >>> Trond Myklebust
> >>> Linux NFS client maintainer, Hammerspace
> >>> trond.myklebust@hammerspace.com
> >>>=20
> >>>=20
> >>>=20
> >>=20
> >>=20
>=20
>=20


