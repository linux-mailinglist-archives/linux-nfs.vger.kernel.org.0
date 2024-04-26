Return-Path: <linux-nfs+bounces-3019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E78B2F67
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 06:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C441C2144B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 04:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F977F15;
	Fri, 26 Apr 2024 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ie2jcSYF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Wcs+Thu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ADljliS8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zPZLK43I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76A8473
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105360; cv=none; b=ZDg920cAx67BVoGgXXJHESevslJd6O18dCFH1l4jbURWP4nxGKjtnRRFdtp4i10hSQLq4lccT5j5Co/Ut6yBLoCvnmDpbP0+rj64Bl2VsPwFjNdjcFka712jHE23Nit4WLwNT3B4r9yIA2IOq57ai6OiLG2bdaJuDY/CcrqHcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105360; c=relaxed/simple;
	bh=nlCcFwjtzg1XcIZkacBQGfUaYtMbCOCJmUQmVMxBHng=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tw4PuoW5FrY/S+x2BMY1SGv5k76nR8/mnzSo/fwRA0Hgoi9irwGvMJye/lt6SQt9CfJBswpJxt4DBoCfUNeVV1F7GErDoXZmb4FO3WwS/QClUhcZNcBgC5D2a01fvoUMtS8wB8XXHVF2BcN06fvsHg8sawB37e8bCrAGHCAekm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ie2jcSYF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Wcs+Thu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ADljliS8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zPZLK43I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF738348CC;
	Fri, 26 Apr 2024 04:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714105356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WLZVUS92//tmX9JR4qxI9yAyVH+oYG1BeVpyoZOFpA=;
	b=ie2jcSYF3Z9gKD54OGz+AXX7FiWEBBgT6fGBrff6u2BtkiJ8gUzplfDOZ2gk3tFtn/VbXw
	fKWeXXwN3FnONhi/pJX/G4bnm/1oq7O2ffMTHYDBOwUUjssKkS1hnxrI3jbbY72PVYpKVH
	+8CX6PFW4r59yeN2J6K+zBYEOO0Mu/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714105356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WLZVUS92//tmX9JR4qxI9yAyVH+oYG1BeVpyoZOFpA=;
	b=1Wcs+ThuZnaZqYy4Sqfub3eTiYeczN/Xk5qEALeBTs/9h9S3Xz8lH+ADyzinGlqgDQm6KI
	w+o0VcTSFEcXwaBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714105355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WLZVUS92//tmX9JR4qxI9yAyVH+oYG1BeVpyoZOFpA=;
	b=ADljliS8yJWrvTbyVB4wIyJJvLS7ImUqZqqSKUcIfxKzfjxTifX9AOQmEu0J1HgzRVLNY8
	+255gb8TH9kYSDfLEPrDxu0wZANGQbScyvYQh7I1WsiTN7Y3IVjSD8hZF8FSibBdh2idE7
	ovkvEnwsshPf47RxHcU/u6lQ9O2R47M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714105355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WLZVUS92//tmX9JR4qxI9yAyVH+oYG1BeVpyoZOFpA=;
	b=zPZLK43IVci6tbF/TIgo2Wget4R/Tp9UXPJ33ZRiGO77dcWMAV8nkXW8CWjEZRfx30xNfM
	UvdKF56R1ADEugBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 901EA1398B;
	Fri, 26 Apr 2024 04:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vej9DAosK2YiVAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Apr 2024 04:22:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Shelton" <dan.f.shelton@gmail.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: kernel update to 6.8.2 broke idmapd group mapping
In-reply-to:
 <CAAvCNcDahJvPdhFj=WYBHKUVPVz+oCZcXeqVXhT3s8b6B0kiEA@mail.gmail.com>
References:
 <CAAvCNcCDsAcZFoCuCgM_HrooSTjr5T9aQ2s_LC_81XUzVetwqw@mail.gmail.com>,
 <CAAvCNcDahJvPdhFj=WYBHKUVPVz+oCZcXeqVXhT3s8b6B0kiEA@mail.gmail.com>
Date: Fri, 26 Apr 2024 14:22:30 +1000
Message-id: <171410535095.7600.9392086332005098557@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 26 Apr 2024, Dan Shelton wrote:
> On Sat, 30 Mar 2024 at 12:56, Dan Shelton <dan.f.shelton@gmail.com> wrote:
> >
> > Hello!
> >
> > I have updated my Debian 11 with the Linux 6.8.2 kernel, running
> > rpc.nfsd with various NFSV4 clients.

Update to 6.8.2 from ... what?
There are no nfsd changes between 6.8 and 6.8.2.

I assume you only change the server - none of the NFS clients were
changed?

Can you use "tcpdump -s 0 ...." to capture network traffic while this is
happening?  That might provide some hints.

NeilBrown


> > Userland stayed exactly the same, so neither idmapd or nfs-utils were cha=
nged.
> >
> > But I now see lots of weird group names (not usernames, they are
> > normal) from idmapd, but not all group name mappings are affected:
> > Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfsdcb:
> > authbuf=3D*,10.2.66.30 authtype=3Dgroup
> > Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > calling nsswitch->name_to_gid
> > Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > nsswitch->name_to_gid returned -22
> > Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> > return value is -22
> > Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: Server : (group) name
> > "^PM-!M-?M-4q" -> id "65534"
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfsdcb:
> > authbuf=3D*,10.2.66.30 authtype=3Dgroup
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > calling nsswitch->name_to_gid
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > nsswitch->name_to_gid returned -22
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> > return value is -22
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: Server : (group) name
> > "PM-^^M-^OM-4q" -> id "65534"
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfsdcb:
> > authbuf=3D*,10.2.66.30 authtype=3Dgroup
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > calling nsswitch->name_to_gid
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > nsswitch->name_to_gid returned -22
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> > return value is -22
> > Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: Server : (group) name
> > "M-^PM-^]/M-4q" -> id "65534"
> > Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfsdcb:
> > authbuf=3D*,10.2.66.30 authtype=3Dgroup
> > Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > calling nsswitch->name_to_gid
> > Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> > nsswitch->name_to_gid returned -22
> > Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> > return value is -22
> > Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: Server : (group) name
> > "M- M- M-^_M-4q" -> id "65534"
>=20
> Help?
>=20
> Dan
> --=20
> Dan Shelton - Cluster Specialist Win/Lin/Bsd
>=20
>=20


