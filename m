Return-Path: <linux-nfs+bounces-20219-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL+FDV03uGkDagEAu9opvQ
	(envelope-from <linux-nfs+bounces-20219-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 18:01:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC71629DC5B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6BC8318019C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA33CF04D;
	Mon, 16 Mar 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R832Orfs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F263B8BBF;
	Mon, 16 Mar 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680027; cv=none; b=ICIylsjkMUGwURsg0ZTx78iSx8h6qrRqZnAWCEhyjFSDOXtgE0JqEDKoppcxq8gL5rg5wKg53tL/FUfjB8tqVLrry1hhYZwEEX8zFoCkNJUMCyeNkZpaPb0S0frIsxqFHaWJdKlgf2EVBWf4GUwA+BOI+q0XsQ8Y2ecqXsmMT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680027; c=relaxed/simple;
	bh=XGmk+bJYmHJVxnVa2fQvb/Pqvfns2aI1x7zCbX8yktc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8TqJMw0XzElN6nH0zjs513JBDlVCUuE7y6IOLSpOuLh5abCwNAFDPMhm3ij5aDl8/wEw302IJQClCn1uC3op3XUs+bGx+6zeePD3jtr1wPf+LTEl96Pd20Ae/pShTx4Wp+O21YsAiOGEndrSdOgahHzpj4Mx31dR7FLQI1lXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R832Orfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292E7C19421;
	Mon, 16 Mar 2026 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773680026;
	bh=XGmk+bJYmHJVxnVa2fQvb/Pqvfns2aI1x7zCbX8yktc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R832OrfsM9tquLmCOCzbAg5RHBExZBgmcHa+SJSvN7T3/P/Vsa4nvBcb1g7+BmmH9
	 U2DxOMN9f+mlDaX6MrhB6Mj8wj8CnSxmcdiYjLf7+m8xCRGSTcHT4rKpGtU6kV7BRw
	 1f6gXApOrW01lYc4GaKu0tU4D08BeY5uxiwYFSJbUPsplSYAe1eSfcfsvUVkl1Ncwd
	 0KG6UZQ4M9KEL27YkV/V2UsedyUlJSosy5Vhx7/NhC/OK9WEOWGrjK/eKzoj5bZa0X
	 77Cc01pEIrWAUvD0kuC/KeAokOmKF8nIvi/Q/lzEoqnEp6cIr97+rHAOEzkylLgss6
	 zX0Jr1Spvs5vQ==
Message-ID: <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
From: Jeff Layton <jlayton@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 v9fs@lists.linux.dev, 	linux-kselftest@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, 	jack@suse.cz,
 chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 deller@gmx.de, 	davem@davemloft.net, andreas@gaisler.com,
 idryomov@gmail.com, amarkuze@redhat.com, 	slava@dubeyko.com,
 agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 shuah@kernel.org, 	miklos@szeredi.hu, hansg@kernel.org
Date: Mon, 16 Mar 2026 12:53:40 -0400
In-Reply-To: <20260307140726.70219-2-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
	 <20260307140726.70219-2-dorjoychy111@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20219-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uapi-group.org:url]
X-Rspamd-Queue-Id: AC71629DC5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-07 at 20:06 +0600, Dorjoy Chowdhury wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>=20
> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.
>=20
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -EFTYPE is returned.
>=20
> When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> as it doesn't make sense to open a path that is both a directory and a
> regular file.
>=20
> [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
>=20
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/errno.h        |  2 ++
>  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
>  arch/mips/include/uapi/asm/errno.h         |  2 ++
>  arch/parisc/include/uapi/asm/errno.h       |  2 ++
>  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
>  arch/sparc/include/uapi/asm/errno.h        |  2 ++
>  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
>  fs/ceph/file.c                             |  4 ++++
>  fs/gfs2/inode.c                            |  6 ++++++
>  fs/namei.c                                 |  4 ++++
>  fs/nfs/dir.c                               |  4 ++++
>  fs/open.c                                  |  4 +++-
>  fs/smb/client/dir.c                        | 14 +++++++++++++-
>  include/linux/fcntl.h                      |  2 ++
>  include/uapi/asm-generic/errno.h           |  2 ++
>  include/uapi/asm-generic/fcntl.h           |  4 ++++
>  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
>  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
>  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
>  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
>  tools/include/uapi/asm-generic/errno.h     |  2 ++
>  21 files changed, 63 insertions(+), 2 deletions(-)
>=20
>=20

I pointed Claude at this patch and got this back. Both issues that it
found will need to be fixed:

  Analysis Summary

  Commit: 7e7fa2653ca57 - openat2: new OPENAT2_REGULAR flag support

  This patch adds a new OPENAT2_REGULAR flag for openat2() that restricts o=
pens to regular files only, returning a new
  EFTYPE errno for non-regular files. It adds filesystem-specific checks in=
 ceph, gfs2, nfs, and cifs atomic_open paths,
  plus a VFS-level fallback in do_open().

  Issues found:

  1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips open-time=
-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
  but does not strip OPENAT2_REGULAR. When a regular file is successfully o=
pened via openat2() with this flag, the bit
  persists in file->f_flags and will be returned by fcntl(fd, F_GETFL).
  2. BUILD_BUG_ON not updated - The compile-time guard checks upper_32_bits=
(VALID_OPEN_FLAGS) but the code now accepts
  VALID_OPENAT2_FLAGS. The guard should cover the expanded flag set.

  Verified correct:

  - All hex=E2=86=92octal conversions in MIPS and SPARC fcntl.h are numeric=
ally correct
  - Legacy open()/openat() properly strips OPENAT2_REGULAR via build_open_h=
ow() masking with VALID_OPEN_FLAGS
  - All filesystem cleanup paths (ceph, gfs2, nfs, cifs) properly handle re=
sources when returning -EFTYPE
  - O_DIRECTORY + OPENAT2_REGULAR mutual exclusion is correct
  - O_PATH + OPENAT2_REGULAR is properly rejected by O_PATH_FLAGS check

  Ruled out:

  - NFS -ENOTDIR to -EFTYPE conversion: in atomic_open context, parent path=
 is VFS-resolved, server errors relate to
  target
  - CIFS resource leak: out_err label properly closes server handle and cal=
ls iput()
  - OPENAT2_REGULAR + O_TMPFILE: silently accepted but tmpfiles are always =
regular, so harmless

  FINAL REGRESSIONS FOUND: 2
  FINAL TOKENS USED: ~45000
  False positives eliminated: NFS -ENOTDIR conversion, CIFS resource leak, =
O_TMPFILE interaction

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>

