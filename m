Return-Path: <linux-nfs+bounces-5601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9595C2A6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 03:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18CA2851E7
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B6BE47;
	Fri, 23 Aug 2024 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n9xo0YWN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CivrA48p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n9xo0YWN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CivrA48p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43EA94C
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724374908; cv=none; b=Kap0syiDeAERvMRftQWMe2pLn+YqxFaWazYVjZFe3MI+yPL+PBjDM5vDwUrsHnj/H+PgOBQab3viD/ot6pAK6MNJCWzDMgLMdmFY0RCbOqEGSkckJ16f0Llt4K6QGJl587kgRWEYv2usiyJOAlodAXo5NDfBwLG+ityPt0MEJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724374908; c=relaxed/simple;
	bh=raOiIjHa+1RP54tHSInAo+ITzXHtkyF/GMYBXfsvf8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJBZzS/KhtglHqUGdg6hBJBcC1njSMG1Gamt46YoxEcvRI2xqKP5a2hM/+qZXwFlmV6D4csI2P8L+zslThzx7IvNGB+iWNGrcs31oOH9jgo1MxyWXwfSPzH66MEfjKpdIqmgyr0yBNjo7rbxZCOsgrRf5wKC6zmyhkLQeJELs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n9xo0YWN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CivrA48p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n9xo0YWN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CivrA48p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88A522027D;
	Fri, 23 Aug 2024 01:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724374904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq36V1prKNbqB36M01/xCt56xx8B0to3mUmJn14cfRc=;
	b=n9xo0YWNNXDlydCZfCUiSmc+2jlocqnMFcWEoEOd7kLDFp63Huw39M5ZrGm68R4voiUqOO
	aMmJVx6rfRMt6me/Nph/Mcd3B+6ASz4e8RKFRY57SqrC1pkuqVXKu8KOWEBx3o98OYDOKD
	ybc9Kn56KetPmWfiYuNYUD5i6KuPS+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724374904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq36V1prKNbqB36M01/xCt56xx8B0to3mUmJn14cfRc=;
	b=CivrA48pm+qIky8j6z6lRX0pTnpzH8oEpCFp9LiRw8r4djnwG+olWBTsZF+k5J6j9oLJb2
	wMzpIe+MAx3tqyAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724374904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq36V1prKNbqB36M01/xCt56xx8B0to3mUmJn14cfRc=;
	b=n9xo0YWNNXDlydCZfCUiSmc+2jlocqnMFcWEoEOd7kLDFp63Huw39M5ZrGm68R4voiUqOO
	aMmJVx6rfRMt6me/Nph/Mcd3B+6ASz4e8RKFRY57SqrC1pkuqVXKu8KOWEBx3o98OYDOKD
	ybc9Kn56KetPmWfiYuNYUD5i6KuPS+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724374904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq36V1prKNbqB36M01/xCt56xx8B0to3mUmJn14cfRc=;
	b=CivrA48pm+qIky8j6z6lRX0pTnpzH8oEpCFp9LiRw8r4djnwG+olWBTsZF+k5J6j9oLJb2
	wMzpIe+MAx3tqyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A1BF1333E;
	Fri, 23 Aug 2024 01:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BUwSFXjfx2YuFAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 01:01:44 +0000
Date: Fri, 23 Aug 2024 03:01:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, Steve Dickson <SteveD@redhat.com>,
	Josue Ortega <josue@debian.org>, NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>,
	Steve Langasek <steve.langasek@canonical.com>
Subject: Re: [RFC][PATCH rpcbind 4/4] systemd/rpcbind.service.in: Want/After
 systemd-tmpfiles-setup
Message-ID: <20240823010143.GA1206597@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240823002322.1203466-1-pvorel@suse.cz>
 <20240823002322.1203466-5-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823002322.1203466-5-pvorel@suse.cz>
X-Spam-Score: -3.47
X-Spamd-Result: default: False [-3.47 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.17)[-0.865];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.com:url];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Steve,

> Add Want/After systemd-tmpfiles-setup.service. This is taken from Fedora
> rpcbind-0.2.4-5.fc25 patch [1] which tried to handle bug #1401561 [2]
> where /var/run/rpcbind.lock cannot be created due missing /var/run/
> directory. But the suggestion to add RequiresMountFor=... was
> implemented in ee569be ("Fix boot dependency in systemd service file").

> But even with RequiresMountsFor=/run/rpcbind in rpcbind.service and
> /run/rpcbind.lock there is error on openSUSE Tumbleweed with rpcbind
> 1.2.6:

> rpcbind.service: Failed at step NAMESPACE spawning /usr/sbin/rpcbind: Read-only file system

> Adding systemd-tmpfiles-setup.service fixes it.

> NOTE: Debian uses for this purpose remote-fs-pre.target (also works, but
> systemd-tmpfiles-setup.service looks to me more specific).
> openSUSE uses only After=sysinit.target as a result of #1117217 [3]
> (also works).

Reading RH #1117217 once more I wonder if old Fedora patch [4], which places
rpcbind.lock into /var/run/rpcbind/ would be a better solution:

configure.ac
-  --with-statedir=ARG     use ARG as state dir [default=/var/run/rpcbind]
+  --with-statedir=ARG     use ARG as state dir [default=/run/rpcbind]
...
-  with_statedir=/var/run/rpcbind
+  with_statedir=/run/rpcbind

src/rpcbind.c
-#define RPCBINDDLOCK "/var/run/rpcbind.lock"
+#define RPCBINDDLOCK RPCBIND_STATEDIR "/rpcbind.lock"

But I suppose other out-of-tree patch [5] is not a dependency for it, right?

Debian [6] and openSUSE [7] use more simpler version to move to /run. Maybe time
to upstream Fedora patch and distros will adopt it?

Kind regards,
Petr

> [1] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-service.patch
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1401561
> [3] https://bugzilla.suse.com/show_bug.cgi?id=1117217

[4] https://src.fedoraproject.org/rpms/rpcbind/blob/f41/f/rpcbind-0.2.4-runstatdir.patch
[5] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-rundir.patch
[6] https://salsa.debian.org/debian/rpcbind/-/blob/master/debian/patches/run-migration?ref_type=heads
[7] https://build.opensuse.org/projects/openSUSE:Factory/packages/rpcbind/files/0001-change-lockingdir-to-run.patch?expand=1

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  systemd/rpcbind.service.in | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
> index 272e55a..771b944 100644
> --- a/systemd/rpcbind.service.in
> +++ b/systemd/rpcbind.service.in
> @@ -7,7 +7,8 @@ RequiresMountsFor=@statedir@
>  # Make sure we use the IP addresses listed for
>  # rpcbind.socket, no matter how this unit is started.
>  Requires=rpcbind.socket
> -Wants=rpcbind.target
> +Wants=rpcbind.target systemd-tmpfiles-setup.service
> +After=systemd-tmpfiles-setup.service

>  [Service]
>  ProtectSystem=full

