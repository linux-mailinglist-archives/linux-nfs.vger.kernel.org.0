Return-Path: <linux-nfs+bounces-4050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E290E2CD
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F041C2195E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BFC24B2A;
	Wed, 19 Jun 2024 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPjBxvsH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i49jEO9H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPjBxvsH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i49jEO9H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AA224D2
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776035; cv=none; b=NybQvwuGAXFM62LABpZba+hnrLRPmI3LXmoEyrhW3ui9MH3LcarUoiin97f2amjeD3bv1+I2eIT0F71Q5uYK70rQTygRxp4KYxTiL0BOluaG1PkAGEOWdcegJBIVIBF9NN0DAIYcR1xEYoSPCHAKRLQPm9XwKhkzWh/PQkn968o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776035; c=relaxed/simple;
	bh=nhXTbgDZrZ1E25D+mr6EkoXr83Koro4kOljxp/03yBU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MCb7BzuwZ8gg7Qs+0D8PcyrguaOWlFOn/NeIKNqFyYw07GUGjE31Afk4PU9HwUJxxqLgRZ/6QKpqA3E6KLSqppi5e1PDtob++scUMFZz8XX0Ipy/YN/zT8FR40CZDqz5Z2cjiV0WlC4WGZ0NLQBoEVMlWY7NyrxpnKNhbr/M0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPjBxvsH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i49jEO9H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPjBxvsH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i49jEO9H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08A5E21A37;
	Wed, 19 Jun 2024 05:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718776032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FG4ieVdLhewBK/XR8ug85Jbpk8n+W2Ny0BJrAIQHBo=;
	b=DPjBxvsHXZhlj+kc1eD46zznuiRXdo9z4P36WkUyQ6j/4z3a1YKsr2lp8lWykuljLwpgsr
	jW9P2zYZ9nUpeY4SBQ3KZ38AHzkq/hkHWwRvj1eMgEnlX2x5xfxpQM/dhuW48dWHmE7B2r
	0Kc5HFY6uMTMINehJlCyM/DKT3xuwg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718776032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FG4ieVdLhewBK/XR8ug85Jbpk8n+W2Ny0BJrAIQHBo=;
	b=i49jEO9HUgTbxUEc6/wBvUU+y7KmA94lnqiXW1F6bjMXETEb8eYLIO8Aiq9NvvOA/0RPz1
	/y8idnMc/8sd+IAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DPjBxvsH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i49jEO9H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718776032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FG4ieVdLhewBK/XR8ug85Jbpk8n+W2Ny0BJrAIQHBo=;
	b=DPjBxvsHXZhlj+kc1eD46zznuiRXdo9z4P36WkUyQ6j/4z3a1YKsr2lp8lWykuljLwpgsr
	jW9P2zYZ9nUpeY4SBQ3KZ38AHzkq/hkHWwRvj1eMgEnlX2x5xfxpQM/dhuW48dWHmE7B2r
	0Kc5HFY6uMTMINehJlCyM/DKT3xuwg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718776032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FG4ieVdLhewBK/XR8ug85Jbpk8n+W2Ny0BJrAIQHBo=;
	b=i49jEO9HUgTbxUEc6/wBvUU+y7KmA94lnqiXW1F6bjMXETEb8eYLIO8Aiq9NvvOA/0RPz1
	/y8idnMc/8sd+IAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F5E13AAF;
	Wed, 19 Jun 2024 05:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1FimAt1wcmZvbAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 05:47:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject:
 Re: [PATCH v5 19/19] nfs: add Documentation/filesystems/nfs/localio.rst
In-reply-to: <ZnIAMJ0wqjcTBszm@tissot.1015granger.net>
References: <>, <ZnIAMJ0wqjcTBszm@tissot.1015granger.net>
Date: Wed, 19 Jun 2024 15:47:05 +1000
Message-id: <171877602532.14261.15898737346476163897@noble.neil.brown.name>
X-Rspamd-Queue-Id: 08A5E21A37
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 19 Jun 2024, Chuck Lever wrote:
> On Tue, Jun 18, 2024 at 04:19:49PM -0400, Mike Snitzer wrote:
> > This document gives an overview of the LOCALIO protocol extension
> > added to the Linux NFS client and server (both v3 and v4) to allow a
> > client and server to reliably handshake to determine if they are on
> > the same host.  The LOCALIO protocol extension follows the well-worn
> > pattern established by the ACL protocol extension.
> >=20
> > The robust handshake between local client and server is just the
> > beginning, the ultimate use-case this locality makes possible is the
> > client is able to issue reads, writes and commits directly to the
> > server without having to go over the network.
> >=20
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  Documentation/filesystems/nfs/localio.rst | 101 ++++++++++++++++++++++
> >  include/linux/nfslocalio.h                |   2 +
> >  2 files changed, 103 insertions(+)
> >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> >=20
> > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/fi=
lesystems/nfs/localio.rst
> > new file mode 100644
> > index 000000000000..4b4595037a7f
> > --- /dev/null
> > +++ b/Documentation/filesystems/nfs/localio.rst
> > @@ -0,0 +1,101 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +NFS localio
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document gives an overview of the LOCALIO protocol extension added
> > +to the Linux NFS client and server (both v3 and v4) to allow a client
> > +and server to reliably handshake to determine if they are on the same
> > +host.  The LOCALIO protocol extension follows the well-worn pattern
> > +established by the ACL protocol extension.
> > +
> > +The LOCALIO protocol extension is needed to allow robust discovery of
> > +clients local to their servers.  Prior to this extension a fragile
> > +sockaddr network address based match against all local network
> > +interfaces was attempted.  But unlike the LOCALIO protocol extension,
> > +the sockaddr-based matching didn't handle use of iptables or containers.
> > +
> > +The robust handshake between local client and server is just the
> > +beginning, the ultimate use-case this locality makes possible is the
> > +client is able to issue reads, writes and commits directly to the server
> > +without having to go over the network.  This is particularly useful for
> > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > +job local to the server.
> > +
> > +The performance advantage realized from localio's ability to bypass
> > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > +-  With localio:
> > +  read: IOPS=3D691k, BW=3D42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > +-  Without localio:
> > +  read: IOPS=3D15.7k, BW=3D984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > +
> > +RPC
> > +---
> > +
> > +The LOCALIO RPC protocol consists of a single "GETUUID" RPC that allows
> > +the client to retrieve a server's uuid.  LOCALIOPROC_GETUUID encodes the
> > +server's uuid_t in terms of the fixed UUID_SIZE (16 bytes).  The fixed
> > +size opaque encode and decode XDR methods are used instead of the less
> > +efficient variable sized methods.
>=20
> I'm reading between the lines ("well-worn pattern established by
> the [NFS]ACL protocol"). I'm guessing that the client and server
> will exchange this protocol on the same connection as NFS traffic?
>=20
> The use of the term "extension" in this Document might be atypical.
> An /extension/ means that the base RPC program (NFS in this case)
> is somehow modified. However, if LOCALIO is a distinct RPC program
> then this isn't an extension of the NFS protocol, per se.
>=20
> A protocol spec needs to include:
>=20
> o The RPC program and version number
>=20
> o A description of each its procedures, along with an XDR definition
>   of its arguments and results
>=20
> o Any related constants or bit mask values

Note that providing this information in the format of a ".x" file as
understood by rpcgen is a good approach.

It isn't clear to me why you implement both v3 and v4 of the LOCALIO
program.  I don't see how they relate to the NFS protocol version.  Just
implement v1 which simply returns the UUID.

Thanks,
NeilBrown

