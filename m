Return-Path: <linux-nfs+bounces-10702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9B8A69B2A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C0E7AFD63
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27571E1C3F;
	Wed, 19 Mar 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bTf6YIxf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcfO+HzP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bTf6YIxf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcfO+HzP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5214AD29
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420774; cv=none; b=V7gnsaR0Yh9Cp5XityvPg5s2iZpD8gkZhhr8z5paEoF16eANYBi9fhwY4NCTBJMNKYws26pMR1FXm0ZAhDblCDnlOjLrCyFFqk4qOawUMDh/uV3532hyiSaZsFa8JxwckJTVvrseH4IpK/wHUJCO2wD2bCQ6FyoRW9WYIiD2i9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420774; c=relaxed/simple;
	bh=pE9iRes7c/cYk+8DrCITMmAezO2LHbN94oqjGOPQGDA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PLYXlh4ThaLfK4Q2bRvKbMibE2RNes6YPOcKCEXgJCF7NX8GDzqx1YxkRQap5CPKXw7w2ANeB5VA356qRi9b4Cq1e/jvL/nVYBzZIdHsdJnodfMpU9rqxUcpWGSRMxyUTl4fTqzhVadCTGYEeBP7VH3YVeGGc0cZYbTU8z2S43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bTf6YIxf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcfO+HzP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bTf6YIxf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcfO+HzP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFCFD2170C;
	Wed, 19 Mar 2025 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742420770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOgCf2mg+yhi/H19hxmK0gtYDoGJ2Ec1iCddbJmpNRM=;
	b=bTf6YIxfenlf/vAob8+4zMDnkQ7trN8DVrXPhl3GokmWHdqviVy6Jhe1qYhnuBDMhcgCsw
	oAyqd49ZmZ2fg4QFXzXGeTDLccVWCMYH9G6WvfxluhpaoCyAh+fWfBT7OlKPsOEa1DXKrt
	rQpgC91fDeO3jFF2cqflo1x+Kpm7LPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742420770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOgCf2mg+yhi/H19hxmK0gtYDoGJ2Ec1iCddbJmpNRM=;
	b=wcfO+HzPH3uqO7loBbLwBr55YCLMJC1llHdGQ/Ji+PV6iUHjJg96MYqeRnFu6+lVAKd0SR
	dAXEIk2Jnr8GTsAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742420770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOgCf2mg+yhi/H19hxmK0gtYDoGJ2Ec1iCddbJmpNRM=;
	b=bTf6YIxfenlf/vAob8+4zMDnkQ7trN8DVrXPhl3GokmWHdqviVy6Jhe1qYhnuBDMhcgCsw
	oAyqd49ZmZ2fg4QFXzXGeTDLccVWCMYH9G6WvfxluhpaoCyAh+fWfBT7OlKPsOEa1DXKrt
	rQpgC91fDeO3jFF2cqflo1x+Kpm7LPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742420770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOgCf2mg+yhi/H19hxmK0gtYDoGJ2Ec1iCddbJmpNRM=;
	b=wcfO+HzPH3uqO7loBbLwBr55YCLMJC1llHdGQ/Ji+PV6iUHjJg96MYqeRnFu6+lVAKd0SR
	dAXEIk2Jnr8GTsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8CA813726;
	Wed, 19 Mar 2025 21:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QOsFFyA722dJOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Mar 2025 21:46:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
In-reply-to: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
Date: Thu, 20 Mar 2025 08:46:00 +1100
Message-id: <174242076022.9342.12166225816627715170@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 20 Mar 2025, Dai Ngo wrote:
> Hi,
>=20
> Currently when the local file system needs to be unmounted for maintenance
> the admin needs to make sure all the NFS clients have stopped using any fil=
es
> on the NFS shares before the umount(8) can succeed.

This is easily achieved with
  echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem

Do this after unexporting and before unmounting.

All state for NFSv4 exports, and all NLM locks for NFSv2/3 exports, will
be invalidated and files closed.  NFSv4 clients will get
NFS4ERR_ADMIN_REVOKED when they attempt to use any state that was on
that filesystem.

(I don't think this flushes the NFSv3 file cache, so a short delay might
 be needed before the unmount when v3 is used.  That should be fixed)

NeilBrown


>=20
> In an environment where there are thousands of clients this manual process
> seems almost impossible or impractical. The only option available now is to
> restart the NFS server which would works since the NFS client can recover i=
ts
> state but it seems like this is a big hammer approach.
>=20
> Ideally, when the umount command is run there is a callback from the VFS la=
yer
> to notify the upper protocols; NFS and SMB, to release its states on this f=
ile
> system for the umount to complete.
>=20
> Is there any existing mechanism to allow NFSD to release its states automat=
ically
> on unmount?
>=20
> Unmount is not a frequent operation. Is it justifiable to add a bunch of co=
mplex
> code for something is not frequently needed?
>=20
> I appreciate any opinions on this issue.
>=20
> Thanks,
> -Dai
>=20
>=20
>=20
>=20
>   =20
>=20
>=20


