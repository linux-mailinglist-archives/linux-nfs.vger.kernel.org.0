Return-Path: <linux-nfs+bounces-10982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D175EA784AA
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 00:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2F1166EA9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 22:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D331E2312;
	Tue,  1 Apr 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ezuJnQOa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ZWDdC14";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1txa47FP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ldYMdpQ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C15103F
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743546260; cv=none; b=TUV/QFei1oR1QdjrHfKAOjGUSM70q/zukGEZPBecnNmAdtyEJmLcqHzojf+Bjb8w9Yc9JpK6374dRlOa803fH7e5OAU8OBIgMCBw1g5T4Fg8zmCUqXaLc5H3tQsQGLBTwC7ZgsqfPvoD1LZFEPkFVBYNwNfnEL97F2Dyfg4uOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743546260; c=relaxed/simple;
	bh=Lw61mGzThkP9QDTTL60mjqPuooCCvmmgf5hyrh/AzWI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hTbsYin2VUrY1F2GoXcl4nkAu65Ip/PFZeSJd2FxCsHN0UXTST/uG8a4RfqcRKXTDByd74OOWdmaYBL09AhrmhAqsFb2JyUkylKExEpzqRJdUG+gvRHTGU5cNhGsMR8zhFnMjux9Ivp9gDUo4r2IAF+G+wtiZE4AWgl+vVhxFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ezuJnQOa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ZWDdC14; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1txa47FP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ldYMdpQ1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8907C2118A;
	Tue,  1 Apr 2025 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743546255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6NpmIdZZ2c1v9jfEf25DTwPRQthaxBi1Xq6PXXtaUY=;
	b=ezuJnQOatTik7gC1w6XFLI19nCWwRfg51R3YyHRn311Xj/FQcqysuR+6aD6FmkapHPzb8j
	RsjUgpcf/OvxaUTC7NtfH+rBl6jUMGkNaNyVihAtt70glYFWCMAXUAM7pBn54PP6RMalIu
	VDYnx3kC1hYotJ2q/AUaS17WcauTbvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743546255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6NpmIdZZ2c1v9jfEf25DTwPRQthaxBi1Xq6PXXtaUY=;
	b=/ZWDdC143YM0iq9hMjSfkw/tBSPDTf6xL6/yWH4eTF/0taUpIwFDieWJtLdTJq6e6Xxrc7
	rmfK7aoL53Ltj+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1txa47FP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ldYMdpQ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743546254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6NpmIdZZ2c1v9jfEf25DTwPRQthaxBi1Xq6PXXtaUY=;
	b=1txa47FPgZflai0C0SJnnZKRHsEQ0LIWO9zA9OvTeO/ZMPzOUTb+XY+YBwThSTIYPJAhBl
	nfqt6jTLKR9UPT3FDUXL01qITlpsxIcdU5QNknVYYLPns53EOrspihZx6P/VgvXsnXShQU
	1fMtZQ5qvFq+vTjPjQWZX80nb3KmRyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743546254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6NpmIdZZ2c1v9jfEf25DTwPRQthaxBi1Xq6PXXtaUY=;
	b=ldYMdpQ1Vq03taNXUuafi49IuRJGmnWTX9Isua5tuPk5vv8/Xe0TvpEa2ymfK6PAM0dNOc
	J85rDei5Qj006wDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 294C6138A5;
	Tue,  1 Apr 2025 22:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HQsSNItn7Gd2bgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 01 Apr 2025 22:24:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <aglo@umich.edu>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject:
 Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
In-reply-to:
 <CACSpFtDd0u3rdePuFYLZVVS0j_arvmox_z9AQTCzQva+iv8rWQ@mail.gmail.com>
References:
 <>, <CACSpFtDd0u3rdePuFYLZVVS0j_arvmox_z9AQTCzQva+iv8rWQ@mail.gmail.com>
Date: Wed, 02 Apr 2025 09:24:08 +1100
Message-id: <174354624811.9342.14750814170089065011@noble.neil.brown.name>
X-Rspamd-Queue-Id: 8907C2118A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,noble.neil.brown.name:mid,suse.de:dkim,oracle.com:email];
	URIBL_BLOCKED(0.00)[oracle.com:email,suse.de:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 01 Apr 2025, Olga Kornievskaia wrote:
> On Mon, Mar 31, 2025 at 10:49=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
> >
> > On 3/30/25 8:10 PM, NeilBrown wrote:
> > > On Mon, 31 Mar 2025, Olga Kornievskaia wrote:
> > >>
> > >> This code would also make the behaviour consistent with prior to
> > >> 4cc9b9f2bf4d. But now I question whether or not the new behaviour is
> > >> what is desired going forward or not?
> > >>
> > >> Here's another thing to consider: the same command done over nfsv4
> > >> returns an error. I guess nobody ever complained that flock over v3
> > >> was successful but failed over v4?
> > >
> > > That is useful.  Given that:
> > >  - exclusive flock without write access over v4 never worked
> > >  - As Tom notes, new man pages document that exclusive flock without wr=
ite access
> > >    isn't expected to work over NFS
> > >  - it is hard to think of a genuine use case for exclusive flock without
> > >    write access
> > >
> > > I'm inclined to leave this code as it is and declare your failing test
> > > to no longer be invalid.
> >
> > For the record, which test exactly is failing? Is there a BugLink?
>=20
> Test is just an flock()?
>=20

But what motivated you to perform that specific test:
  exclusive flock over NFSv3 on a file you didn't have write permission to
??

Is it part of a test suite? Or is it done by some application? or ....

NeilBrown

