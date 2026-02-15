Return-Path: <linux-nfs+bounces-18942-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH7XLNk6kmnUsAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18942-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 22:30:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1713FC49
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 22:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E4973007495
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237D296BD6;
	Sun, 15 Feb 2026 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB5iRs2e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F97242D88
	for <linux-nfs@vger.kernel.org>; Sun, 15 Feb 2026 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771190998; cv=pass; b=t/IZ8O8w85PLHZzeTtsjhAEXgQyqXhaoZu9M45K4kwTVYCnpxM9xVdO0VvtS2k1rOUtVfLYJ79irQJziF8NLWmEMWE9PeJFnz71TKIBa2XerwJaBN+8bBRp1zKC2exbmZKEwfJBwKA+M07Qf5K6meoPy9r6HWZ5BNPCK/qAuKg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771190998; c=relaxed/simple;
	bh=ih/cRVN7RnHhFku6DkHST33md8mQf5cEn+jxf3dF/gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=S6+KqEjd9+Ad7dSk2oTdkHZC9/OKKIr0ATcYqEvLsMMEvNwK3X4tLOHkeyNvSnuH/2osPc+/wTzPscJev9GxaY0y7TkqFuhGVaUkBad7FvGKD+Vn8EQhbVcsTdqV/k3v6210e6NTLKdpIvKInArgGbeAfeW7VHOb16z7u+R5yMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB5iRs2e; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65a40f3f048so4056878a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 15 Feb 2026 13:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771190994; cv=none;
        d=google.com; s=arc-20240605;
        b=apKAi5dcBfHocdRnTi2w9VDPGISJplSiDxflXGWLK3HOwBJYaTUmtmy5+q5pPx5VU/
         /nG53wykrxHdUZREJSy8TW/VJxVgodCfXqv9gKAESDWOR/Vu1wgj16FJdaiBGBUuDXQH
         pqup287BM5iO7eVIE26a+5kajbovxFPQJWdAMNI3npFhaD+YA2kmEXU5+iCd+nKoFKfq
         4dSWYnaRVVnFKAyEjdJKMTvHcco2IFpgiwPvB1aG1+xaSD6wwO16hcsGSDl5z9t9NydD
         RYie5E/UMTyWPf9bWssRisC2S0okiYQFlK2TYzEuHZ9Enk7nowGXXJQ70hTqZ6ORKydX
         pWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUac4J3PaBYOVgqxb8+P1q3CBbONpKXd195PT0hnmpA=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=A4fsQi1qaxxWd8qPdo66NyZfjBMHIkFuDm+HyNdN9Wno+JoLuh0y9HpizCL9wbNJan
         b58ud2jh/9/yEjGx7s7fePXT1kKfnML0I/VUFgcpltcvcUwf49PuQyCxKBj/SgEtPbsK
         Bo8B39Jg0su+JrquIUNlYzLBt43bRwAeST/QU0KRd2nxGZoxRhvIKjVnHNuJdnfwiRdx
         TNy3ex3fwDaTYL6ntUeucMNHxIMtoENQfxovTTqfNDzqigsYynth4fahg0HTmvgkkgPB
         qqxM3MyfCsqIv2KFfRAN8YhHepPDz4Pd02RIFxixNv5l4EHkDsfjP9PwLqO9t1IGohJW
         2zWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771190994; x=1771795794; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUac4J3PaBYOVgqxb8+P1q3CBbONpKXd195PT0hnmpA=;
        b=mB5iRs2eYMys9dZ1A+GmeY739yBPCzMnzUNSnJ8pqDakhVQSnqgGLYEHJUnSaTADZ8
         6lFBs5/BqJMI8MDPi+ubW3rkd6wOHbo+UISr3tZmvJvljYMipy8RnTCAbIyHNI4gCwXQ
         aSuocufSVpf0VviwmrSmjmSdqAAv8QwRo3flMNoEUf18Bcaq7ZbtTCogjxJ0WpbFOqsT
         ebd9NslbFQLCv3RVqshca3ZHNzuNUYvLIE+BswR0m8JyPveX3nvzKQsBRV2lFhrQ94J1
         ElIjBy1g1U1vDMAjCkciZGoSkFfYnC/t3DSF8Cv7nVjRMqUX91uClUfkm0tUgOZEMcc9
         6yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771190994; x=1771795794;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUac4J3PaBYOVgqxb8+P1q3CBbONpKXd195PT0hnmpA=;
        b=mTTNtawP00eRtVS375il1BdQNxCLH4OVpd4aNsqFJtNfeXzNquKIevuOiGC9JvIAs2
         JaKB9RbzNN/PHmMFm8YvRJrWLfCGraxVQ7Qu6ninoMw/648UIcvuhHLDUBpl9widp/ol
         lPVDBWVx9xkafw6O9kegOccfXPR3ZBedw0sPuuVTruGbikb8ZIowzLXwqf2MolzI2F7m
         EpnW2MDSbAoASBwMt/4wqMXCoAC30Re8inN1MKWuuoxRXTXZ8tqv2/4GbBlBHr24rAYE
         1AQHg03zb+edEiyFeLoN5rav57gd73XcoajsPyiqZdoE5BIjROD4CREvc6swjez8Aeo6
         CrXg==
X-Gm-Message-State: AOJu0YwwrUiPantlJ2if3UWcYTQcWELFwZDfcAR0H91nXj7OtFXE1ZwE
	tlnm9MLm4GGBX+XLrrp/A4s80OsEIqCr1yc66jCR0zqVQ5j66tmXQNTSEHmk2TxDQzZ6/ayB7RB
	Gdhv31gSCHyISPZ9+cwiyfVdlOvHLRT8gbOMT
X-Gm-Gg: AZuq6aIums7gMV8oBd5uA6eeRVQduftVLFRU6xU+fqN/jWPjvGLk82FbKwWw78D+TXP
	yGwGkVF64qYL7ek83Ic6+9J+KMNDqBzfZ1ePGIv4ooQqM1pHBiVUmzRi3u6uF6psjA7QOkPQbPm
	M1l3gH7A7urA3ftnxokQo9ZOuH8VK/b02oFhFV+9JC++0g6UMd8Iz2/StsyRvZbgEeInDSQ+cC7
	DHJUOx/kG+YzdcNP3ArfP5+hAMFc1fgajgwuveUeAWUafkmZXXgt+qhBwFq0K7aTTBWfSTlisjY
	jw5C1aro0baEQYl/
X-Received: by 2002:a05:6402:1ece:b0:659:329a:bc12 with SMTP id
 4fb4d7f45d1cf-65bb13b7f0amr3928061a12.29.1771190994283; Sun, 15 Feb 2026
 13:29:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQm_Z89aaE39Rqp0-o2h9ybsgUMaqReND4y_UvPxhUKsgQ@mail.gmail.com>
In-Reply-To: <CAKAoaQm_Z89aaE39Rqp0-o2h9ybsgUMaqReND4y_UvPxhUKsgQ@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sun, 15 Feb 2026 22:29:18 +0100
X-Gm-Features: AaiRm50MhJe28Z-99TCTGEI8sSWqX4lWh5sQh-CRG4lDawm1mukoqJrwJ_C5vV0
Message-ID: <CANH4o6PdZbvX80JjsH5t-aVX6A5YM6wW_bt+5d1hSFxd3daE_Q@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2026-02-14 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-18942-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinlwege@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.8.1:email,nrubsig.org:url,nrubsig.org:email]
X-Rspamd-Queue-Id: 53A1713FC49
X-Rspamd-Action: no action

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.19+/7.0 would be great.

News:
See announcement below; Windows Alternate Streams (Win32 streams)
support, including winstreamsutil.exe, was added, xcopy.exe/cmd.exe
copy/MS Explorer file copy acceleration via NFS server side copies and
copy-by-block-cloning are IMO the most interesting new features
(cloning now works with FreeBSD 14.3/15.0 nfsd and Linux nfsd
exporting btrfs&xfs filesystems, server side copy with FreeBSD+Linux
with all filesystems), because it's "on" by default for all Windows 11
applications which copy files, followed by wings.exe (Linux users read
man sg(1)) with powershell support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, Feb 14, 2026 at 1:58=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2026-02-14 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #7fb793265ab83889d01b2d5773c2af43f9053fd4, git bundle in tarball),
for testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260214_11h08m_git7fb7932.html
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260214_11h08m_git7fb7932.readme

** Download URL (all architectures+platforms):
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260214_11h08m_git7fb7932.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260214_11h08m_git7fb793=
2.html)=3D
69504bb0c4376df8e5998b96945f57ae0b0834226990fc5da591e378090e3617
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260214_11h08m_git7fb793=
2.readme)=3D
3e4fd46454567d3a16e761ba1a82c29e6f23c69b8136c89cca5422375b2f8f73
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260214_11h08m_git7fb793=
2.tar.bz2)=3D
895405a1e3c274fd978349eb9a5ad7ed7dc824cb0114d89c6cb64b478b1bad21


** Major changes since the last release:
- Support for Win32 named streams/Alternate Data Streams (ADS), if the
NFSv4.x server support NFS named attributes (e.g. Solaris >=3D 11.4,
Illumos, FreeBSD >=3D 15.0, ...), including NTFS-style renaming support.
This also includes new utilities (e.g. winstreamsutil.exe) to find,
list, create, rename, delete etc. Win32 named streams
- Support for Windows "SRVOpen collapsing", which enables file handles
with the access/permission/etc attributes to share one NFS file handle
(saving open/close round trips to the NFS server)
- Symlinks are now using the group defined by Win32 PrimaryGroup
(which can be set via Cygwin newgrp(1)/|setgid()| or winsg(1))
- Added a new standalone tool called catdbgprint.exe which can be used
to listen to Windows kernel |DbgPrint()| debug messages (DbgView.exe
from Windows Internals still works, but this avoids installing an
extra tool)
- Added support for Windows "Extended Create Parameters" |ECP
QUERY_ON_CREATE| |QoCFileStatInformation| and |QoCFileLxInformation|
- Added support for setting a file's ACL at file creation time
- Bugfixes for FreeBSD NFS server
- Fixed issues probing sparse files when using the nfs-ganesha NFS server
- Disk and CDROM/DVD images can now be mounted via
https://github.com/gisburn/filedisk-sparse/
- UNC path format changed to <hostname>@<protocol>@<port>, e.g.
ournfsserver@NFS@2049, to support future transport+mount options (e.g.
RDMA , TLS/SSL etc.)
- Window 11/ARM64 is now supported (native aarch64 kernel module and
nfs*.exe userland utilities)
- /sbin/nfs_globalmount, a new tool for Administrators to manage
global/machine-wide mounts which are available to all Windows
users/services/logons
- New "nfsclientdctl" utility to change the NFS client daemon
parameters at runtime
- support for case-insensitive filesystems (e.g. Windows Server NTFS)
- NFS referrals now work with custom (non-TCP/2049) port numbers
- Implemented |FSCTL_OFFLOAD_READ|+|FSCTL_OFFLOAD_WRITE| (e.g. used by
Windows 10 xcopy, Windows Explorer etc) for server-side NFSv4.2 COPY
- Better FreeBSD 14.x/15.0 nfsd compatibility
- More software tested for compatibility: MariaDB, Microsoft Office
2016, Visual Studio 2022 work with msnfs41client
- Volume label is now the nfs://-URL to the server (up to 31
characters for Windows Explorer compatibility)
- Support for user and group names with non-ASCII (e.g. Unicode) names
(like German umlauts) in ms-nfs41-client, winsg.exe etc.
- winsg.exe now has a /P option to run powershell.exe with the requested gr=
oup
- nfs_mount.exe now enforces that normal mounts need nfs://-URLs with
absolute paths, and "public NFS" mounts need relative paths in a
nfs://-URL
- sec=3Dnone support
- Improved /sbin/cygwinaccount2nfs4account script to better handle
creation of Windows Domain accounts on the NFS server side
- *.(exe|dll) executables are now signed with a WDK test signature,
helping with *rare* cases that Windows Defender with paranoid settings
wrongly recognising the binaries as potential threads. A *.cer
certificate file is supplied which can be imported into the Windows
Defender to whitelist the binaries if this happens.
- Support for |FSCTL_DUPLICATE_EXTENTS_TO_FILE|, which allows Windows
11 applications which use |CopyFile2()| (like cmd.exe  copy, xcopy.exe
etc) to copy files via block cloning. Requires NFSv4.2 NFS server with
{ CLONE, SEEK, DEALLOCATE } support, exporting a filesystem which
supports block cloning (e.g. btrfs, xfs). This includes correct
cloning of sparse files.
- Sparse file support (requires NFSv4.2 server { SEEK, ALLOCATE,
DEALLOCATE } and the |FATTR4_WORD1_SPACE_USED| attr), including
hole/data range enumeration, punching holes etc., e.g. $ fsutil sparse
queryrange mysparsefile # and Win32 named stream support
- Improved Windows Extended Attribute (EA) support (requires NFS named
attributes support in the NFS server (e.g. Solaris >=3D 11.4, Illumos,
FreeBSD >=3D 15.0, ...)), including create/read/write/delete
- Support for Storage32-API (e.g. enables use of *.msi installer files
on NFS filesystems)
- Cygwin /usr/bin/svn and Windows '/cygdrive/c/Program
Files/Git/cmd/git' now work
- Illumos NFSv4.2 server is now supported
- Solaris 11.4 NFSv4.1 server is now supported
- Windows Server 2022 NFSv4.1 server is now supported (compared to
WS2019 this NFS server version has ACL support)

** Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

----

Bye,
Roland
--
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)


_______________________________________________
Ms-nfs41-client-devel mailing list
Ms-nfs41-client-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ms-nfs41-client-devel

