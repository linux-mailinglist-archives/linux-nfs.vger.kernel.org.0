Return-Path: <linux-nfs+bounces-6291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C196E662
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 01:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF921F23533
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 23:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A092B1A727D;
	Thu,  5 Sep 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tU1QrnwV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MJoSVTgt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tU1QrnwV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MJoSVTgt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65F5381B
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579548; cv=none; b=Rx2TlQL4956/OydfOUAdTJcIN2cFronsSkA/PJz0tKT7WO+OW/b00ux+sm7qXKwLgqkEm1g7SsHmeSH7zJvpHk7xDmv6f90wEJKpdYHl/hhTqsoJV2bmCcYMSbNfe9jfp8H3wI5tHZIwWgGa0zuEOd6CrIJhVl0C8qmzYSCwqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579548; c=relaxed/simple;
	bh=7TGUXNl5ocxe1CmO4vMNBdycJ2RY2Ga8vA9ThNTKgfs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mZnD8IOZWCdmEkKVT0Yq1SkAvGqYW17bU1PRq9ktPO+P8CiZkX9dAeEqn5frCnbhq7mqlojnIFPddKg47lhmHacmwI96LN7yBOHCERYktd5kfxlBjm0oNQjYK12SNEvX/vj73w4CqDIES9KVjOCpotWRtqdU0w50Ryi5OfyK4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tU1QrnwV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MJoSVTgt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tU1QrnwV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MJoSVTgt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96DD21F844;
	Thu,  5 Sep 2024 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725579544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TpNyxKo+hwSp00e6SNsMpWfPwilCEIxEXyF1Ktmmos=;
	b=tU1QrnwVUmP5GHAtdFwPztpz5biM/qDKuPG1xoLih9ChrpFdd6jnvTmLSRXUVL2aA5oH1d
	dirvG6b5tzQhcfGNEBHdQj9YG7airBWDaUGyxY4vXSmBbNWcbqrfNxm98KqJDfiWIjay6k
	j4F6yUVN3LCpF+F4Oyd9EBHbzG+YxO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725579544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TpNyxKo+hwSp00e6SNsMpWfPwilCEIxEXyF1Ktmmos=;
	b=MJoSVTgtrM1P1YTS2X+IOZhe8SOzsDQD02LWjoeFl82fiTmtfKoU+Z2cms2r7T5e9/Svp8
	Wyv37ot8NthAq3DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tU1QrnwV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MJoSVTgt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725579544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TpNyxKo+hwSp00e6SNsMpWfPwilCEIxEXyF1Ktmmos=;
	b=tU1QrnwVUmP5GHAtdFwPztpz5biM/qDKuPG1xoLih9ChrpFdd6jnvTmLSRXUVL2aA5oH1d
	dirvG6b5tzQhcfGNEBHdQj9YG7airBWDaUGyxY4vXSmBbNWcbqrfNxm98KqJDfiWIjay6k
	j4F6yUVN3LCpF+F4Oyd9EBHbzG+YxO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725579544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TpNyxKo+hwSp00e6SNsMpWfPwilCEIxEXyF1Ktmmos=;
	b=MJoSVTgtrM1P1YTS2X+IOZhe8SOzsDQD02LWjoeFl82fiTmtfKoU+Z2cms2r7T5e9/Svp8
	Wyv37ot8NthAq3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7408813419;
	Thu,  5 Sep 2024 23:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AHv+CRZB2mZ7LgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 05 Sep 2024 23:39:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH v16 26/26] nfs: add "NFS Client and Server Interlock"
 section to localio.rst
In-reply-to: <20240905191011.41650-27-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>,
 <20240905191011.41650-27-snitzer@kernel.org>
Date: Fri, 06 Sep 2024 09:38:55 +1000
Message-id: <172557953536.4433.10240425539464458018@noble.neil.brown.name>
X-Rspamd-Queue-Id: 96DD21F844
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Sep 2024, Mike Snitzer wrote:
> This section answers a new FAQ entry:
>=20
> 9. How does LOCALIO make certain that object lifetimes are managed
>    properly given NFSD and NFS operate in different contexts?
>=20
>    See the detailed "NFS Client and Server Interlock" section below.
>=20
> The first half of the section details NeilBrown's elegant design
> for LOCALIO's nfs_uuid_t based interlock and is heavily based on
> Neil's "net namespace refcounting" description here:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172498546024767&w=3D2
>=20
> The second half of the section details the per-cpu-refcount introduced
> to ensure NFSD's nfsd_serv isn't destroyed while in use by a LOCALIO
> client.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/nfs/localio.rst | 68 +++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>=20
> diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/file=
systems/nfs/localio.rst
> index ef3851d48133..4637c0b34753 100644
> --- a/Documentation/filesystems/nfs/localio.rst
> +++ b/Documentation/filesystems/nfs/localio.rst
> @@ -150,6 +150,11 @@ FAQ
>     __fh_verify().  So they get handled exactly the same way for LOCALIO
>     as they do for non-LOCALIO.
> =20
> +9. How does LOCALIO make certain that object lifetimes are managed
> +   properly given NFSD and NFS operate in different contexts?
> +
> +   See the detailed "NFS Client and Server Interlock" section below.
> +
>  RPC
>  =3D=3D=3D
> =20
> @@ -209,6 +214,69 @@ objects to span from the host kernel's nfsd to per-con=
tainer knfsd
>  instances that are connected to nfs client's running on the same local
>  host.
> =20
> +NFS Client and Server Interlock
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +LOCALIO provides the nfs_uuid_t object and associated interfaces to
> +allow proper network namespace (net-ns) and NFSD object refcounting:
> +
> +    We don't want to keep a long-term counted reference on each NFSD's
> +    net-ns in the client because that prevents a server container from
> +    completely shutting down.
> +
> +    So we avoid taking a reference at all and rely on the per-cpu
> +    reference to the server (detailed below) being sufficient to keep
> +    the net-ns active. This involves allowing the NFSD's net-ns exit
> +    code to iterate all active clients and clear their ->net pointers
> +    (which are needed to find the per-cpu-refcount for the nfsd_serv).
> +
> +    Details:
> +
> +     - Embed nfs_uuid_t in nfs_client. nfs_uuid_t provides a list_head
> +       that can be used to find the client. It does add the 16-byte
> +       uuid_t to nfs_client so it is bigger than needed (given that
> +       uuid_t is only used during the initial NFS client and server
> +       LOCALIO handshake to determine if they are local to each other).
> +       If that is really a problem we can find a fix.
> +
> +     - When the nfs server confirms that the uuid_t is local, it moves
> +       the nfs_uuid_t onto a per-net-ns list in NFSD's nfsd_net.
> +
> +     - When each server's net-ns is shutting down - in a "pre_exit"
> +       handler, all these nfs_uuid_t have their ->net cleared. There is
> +       an rcu_synchronize() call between pre_exit() handlers and exit()
> +       handlers so any caller that sees nfs_uuid_t ->net as not NULL can
> +       safely manage the per-cpu-refcount for nfsd_serv.
> +
> +     - The client's nfs_uuid_t is passed to nfsd_open_local_fh() so it
> +       can safely dereference ->net in a private rcu_read_lock() section
> +       to allow safe access to the associated nfsd_net and nfsd_serv.
> +

Can we add to the list of "things to clean up after the code lands" a
note that this documentation isn't quite up-to-date and needs to be
revisited?

NeilBrown


> +So LOCALIO required the introduction and use of NFSD's percpu_ref to
> +interlock nfsd_destroy_serv() and nfsd_open_local_fh(), to ensure each
> +nn->nfsd_serv is not destroyed while in use by nfsd_open_local_fh(), and
> +warrants a more detailed explanation:
> +
> +    nfsd_open_local_fh() uses nfsd_serv_try_get() before opening its
> +    nfsd_file handle and then the caller (NFS client) must drop the
> +    reference for the nfsd_file and associated nn->nfsd_serv using
> +    nfs_file_put_local() once it has completed its IO.
> +
> +    This interlock working relies heavily on nfsd_open_local_fh() being
> +    afforded the ability to safely deal with the possibility that the
> +    NFSD's net-ns (and nfsd_net by association) may have been destroyed
> +    by nfsd_destroy_serv() via nfsd_shutdown_net() -- which is only
> +    possible given the nfs_uuid_t ->net pointer managemenet detailed
> +    above.
> +
> +All told, this elaborate interlock of the NFS client and server has been
> +verified to fix an easy to hit crash that would occur if an NFSD
> +instance running in a container, with a LOCALIO client mounted, is
> +shutdown. Upon restart of the container and associated NFSD the client
> +would go on to crash due to NULL pointer dereference that occurred due
> +to the LOCALIO client's attempting to nfsd_open_local_fh(), using
> +nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
> +
>  NFS Client issues IO instead of Server
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> --=20
> 2.44.0
>=20
>=20


