Return-Path: <linux-nfs+bounces-10958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9232A75D6F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B31A188A6A7
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6562E3391;
	Mon, 31 Mar 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iTemLj1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vag9BFGN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uostnFAZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="enIp6U5c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311310E3
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743379824; cv=none; b=pv8SmnTS9F0Z2ZxDAN63U4U25TJU9+lrpOzfnHXeaojWuFy43KrWdAuGQK8d7SzjujUf2wACPQfoTUKqbyOdmgrq98E4WaOSOuCIUAlkc/oETBRbzFBGzaaDNbqmC2dQsRk8czlHFFo6NhmYCVRk9/drJ1MHW8kSsNEcMnVoy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743379824; c=relaxed/simple;
	bh=s+u7I5pesD2a4RU+++VpkUXmmVAQG012AakO/sAOB/o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p1L2JXkDpb4Fkbe8gd2EyubPKpfs23bTxQKW5wUTxYn1heYS4ku83hrg1RcpIZ3O9rI33qZC/kJq1BDisD6UJt5A7HVy8A9x8aZSenK1a83H28S5SeQZZqCJ7D3h0vg0jAkWp/2gInAKig7JGGMHNj0+1UzxliiARl87YtYWg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iTemLj1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vag9BFGN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uostnFAZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=enIp6U5c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1E7B211AB;
	Mon, 31 Mar 2025 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743379821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+qKcyXsxlmGs/aQulxGCOpfhG2KE5JPU54PryctD3Y=;
	b=iTemLj1fgzLbt0mSSGzD4lzM0pMxT8jpc0lQcubloWjr1ATpsZFPRQuxRyZlgVdbq0cVRV
	LlT0BEjYwq+3LW0XcdOIW5DY69EECNEcvkFNIEXoQJ7sX0wKbHj370ofC4pUacS47dXIE/
	y0Hkj6gHc822A9bj2yQuRw0cSpWhtnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743379821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+qKcyXsxlmGs/aQulxGCOpfhG2KE5JPU54PryctD3Y=;
	b=Vag9BFGNp9SvJYrKAyJTe1/PfkcOZWorWOlBdzvDXAWdQzT+USeLjkj8AeMvesIRKaEGib
	h1hUEoL+TLXd+GDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uostnFAZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=enIp6U5c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743379819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+qKcyXsxlmGs/aQulxGCOpfhG2KE5JPU54PryctD3Y=;
	b=uostnFAZf+NjLOBz8d6+FapThF/6x7FUMJoPqqoXyQaoPQGAQUcZ0jiG+1tyrvDcbYdkF+
	vpCD0bmXEinq+JtEbLa7Alj3vRWVPHlYzsSqPgwqzA8b1ikeZZRD9kSQShA/dF5kC28UZx
	SQvXzk/fe6pKeWnpmNU0YleZAINivXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743379819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+qKcyXsxlmGs/aQulxGCOpfhG2KE5JPU54PryctD3Y=;
	b=enIp6U5c7zridMgEN8lqGs9FW3QmHxscIBHhfJh7iD+gxk/YPBynOFZkoUJlZewoPpW/ID
	+deeEaMaZwwm3EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78C91139A1;
	Mon, 31 Mar 2025 00:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xp8IDGnd6WeGOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 31 Mar 2025 00:10:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject:
 Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
In-reply-to:
 <CAN-5tyHWB9+Q9ONmWfF2LGe6wO1hZXvx2vEHb441Q3XkjzOFmQ@mail.gmail.com>
References:
 <>, <CAN-5tyHWB9+Q9ONmWfF2LGe6wO1hZXvx2vEHb441Q3XkjzOFmQ@mail.gmail.com>
Date: Mon, 31 Mar 2025 11:10:14 +1100
Message-id: <174337981427.9342.10894606812592381794@noble.neil.brown.name>
X-Rspamd-Queue-Id: D1E7B211AB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,noble.neil.brown.name:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Mon, 31 Mar 2025, Olga Kornievskaia wrote:
>=20
> This code would also make the behaviour consistent with prior to
> 4cc9b9f2bf4d. But now I question whether or not the new behaviour is
> what is desired going forward or not?
>=20
> Here's another thing to consider: the same command done over nfsv4
> returns an error. I guess nobody ever complained that flock over v3
> was successful but failed over v4?

That is useful.  Given that:
 - exclusive flock without write access over v4 never worked
 - As Tom notes, new man pages document that exclusive flock without write ac=
cess
   isn't expected to work over NFS
 - it is hard to think of a genuine use case for exclusive flock without
   write access

I'm inclined to leave this code as it is and declare your failing test
to no longer be invalid.  That is technically a regression, but
regressions only matter if people notice them (and complain to Linus).
No harm - no fowl.

Thanks,
NeilBrown

