Return-Path: <linux-nfs+bounces-17145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A45CC9BA3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 23:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DBE300795A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250C4313530;
	Wed, 17 Dec 2025 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asmLMQ2r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED030F546
	for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766011406; cv=none; b=GN4FeJSrYQ8m7R3JiYjKlX5oPAMa3c/eb/G+aOM3fhZYrrxZPue7Fm/EAi1jJuQOU5ypi7cXHQlDdT0tibnxz4Ju0F6vOqmOIGQVoGoJnIA1nHQZBb0679mr9QntpuUaNNfOPF1IoiAt7C9xlaX0BsCoQwjnYEG8+O0I3NNQ35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766011406; c=relaxed/simple;
	bh=0vfYonaKaM+6YI3wiMow9/kbLzw4GW31KCSjuc9IfcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HrNAdqLh9cNwZY31gfJZ8jmaBiY4ZStI07QTjmKRlR+4eLR0qM/d+GVgu0mQLJUPCTH63NrLc6FxndfVPuM2l4WzIJPh1kqlYaOTRkRNmT9eHrTJket/fNx365TABtNIH5jqjZwzBaBB/hU/8ZBO9uqN02altUs7cNe9ejM8yM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asmLMQ2r; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7eff205947so595029266b.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 14:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766011402; x=1766616202; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvNsA2OEOYnNOwbEYqOyuTeMl0WiWYVWXhpWaie4lsM=;
        b=asmLMQ2r/Vnv0b/y2qGYA7jfsDt9dfe7yGf9GwhUP3RTxXy26MPy6uxf4TLCLMEA7Y
         YB77plcmUSaIVVymTZjsch0ZnMU7TkyjzdMPbsYataDLHBRTBQn9tA3FDEGCEzO3XMhy
         0Iofr669b/+sSr8KpbdvxhF8/6jgbVoWUWECfOpOxzGhhXeibItfdktW43OQLYiPCCkl
         WpfwbK7Ob3VlQKq/vSG06CJmAorf0skW7Kb5W83r+fM5eUpimoVRVRYPomxTF6OVDPYi
         OOPBweCf8mAPSV/Ymry8UVC0ldcu0hrvIgMvnUgBRigMwpT455PbBVD8y242lZYSPcOj
         3IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766011402; x=1766616202;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvNsA2OEOYnNOwbEYqOyuTeMl0WiWYVWXhpWaie4lsM=;
        b=eGcVu/qxY7cww7UlEQGEGdXgGQ4eIqCYx5cD1QECtvP1VWbSYD//SvpZg4LUMW4mq2
         R4YZZAE7oU11+frzFnEdUZKhpDJDhWCt8++qj/O10b2G9sY/NzUo8Hek8qoc5D4YGsQm
         gozlSYL+D78G10P9NnJqlXRFshVQesoZyPFQkTwlnrWMkzcXQN0vcEufmibUyUsqWn/b
         +ghvGptXBA/uv4b9/eRxQ7XZOUiPJF9xqbSjjNBjhigqiQ6HyAl0jEIZrVWqzqx9GFgf
         bzSGC5AIWWwAxVk/qYM3+QKoSHzxbybdCJZiKwhIaKFYFCk9tyfEoXjIbOjsbMqrKq2u
         PBZA==
X-Gm-Message-State: AOJu0Yx0JqjEgt09wKOjBMeFY6JiuJ45+HNItdTmq4dK2XCEBfgBy7ve
	MHgaKUeAdACzfRVzBKuCzh6TiiI2uOrbMXYu4+mrj85knDfPq9wUDhI3cicQSrXKuDcLp3hFPB9
	pk+J2udlXKh3YptQUnEUEip7NYntchGu2ku21
X-Gm-Gg: AY/fxX6UOo5DahhuZnALK1HWPbQVYg/tMWMrTu8racLOb/J0I/VdiWyKSt2zfGlocGz
	Wl94t7QQz6zK7IteWuAlrSU8vggxj3zFwlhIZAyBogUB/2N+05gMaQ20Q0MosXcG3xBt0GlW0PY
	jPmhOODhVZA9fiO88DMZwmTHnHR9KDQBJGlebxVXcPprVlVQ63pnMK/B0QIuqx5ncNfI8zDzRii
	eMT/fh1C+waAt3RjLnAY7EyysWAp8i67Hs1WR8ReH7GDQFpXDMf2DnFC+NTDRcv/JsvGTIYYqFt
	IwXXYRA=
X-Google-Smtp-Source: AGHT+IFlRJQ7CFoaHZ6ejvAQmuYFo8vtMU3eZjD+AcR+Ibh/nZBtyF/qnFWelktfu7f+C5MsEFGdZlt4Y2jOD+2ctRU=
X-Received: by 2002:a17:907:3f92:b0:b70:ac7a:2a93 with SMTP id
 a640c23a62f3a-b7d23a351cbmr2159574466b.43.1766011401914; Wed, 17 Dec 2025
 14:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmzGBiuuJPyDJDDxiH6LaueEjc+FArvsyghxdJ8vwEk6g@mail.gmail.com>
In-Reply-To: <CAKAoaQmzGBiuuJPyDJDDxiH6LaueEjc+FArvsyghxdJ8vwEk6g@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 17 Dec 2025 23:42:45 +0100
X-Gm-Features: AQt7F2osw6SzlZfFOsgpkHXf86vSsLtCjY4oZpwDcUvbGgKD7JSHzYTlR0hY9-M
Message-ID: <CANH4o6Nm_1nt1ENG0H7m-iY4gSk+v8uGcJLxsbToJsEe8WYN5g@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2025-12-17 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.17+ would be great.

News:
See announcement below; ARM64/aarch64+Windows Server 2025 platform
support was added, xcopy.exe/cmd.exe copy/MS Explorer file copy
acceleration via NFS server side copies and copy-by-block-cloning are
IMO the most interesting new features (cloning now works with Linux
nfsd exporting btrfs or xfs filesystems, server side copy with all
filesystems), because it's "on" by default for all Windows 11
applications which copy files, followed by wings.exe (Linux users read
man sg(1)) with powershell support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, Dec 17, 2025 at 8:50=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2025-12-17 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #6b11d381c68c0fae5a777b9980e71058abdc1d61, git bundle in tarball),
for testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251217_18h32m_git6b11d38.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251217_18h32m_git6b11d38.html

** Download URL (all architectures+platforms):
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251217_18h32m_git6b11d38.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251217_18h32m_git6b11d3=
8.html)=3D
c45c7fb36bffb9ff8a1dfa51b95c6c551655b858e6336e7a6002d3837507ba99
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251217_18h32m_git6b11d3=
8.readme)=3D
369d1e3850f4b9279415924607cd1c2c31a09ca663dba3b30263da200cac77f9
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251217_18h32m_git6b11d3=
8.tar.bz2)=3D
531606d4aed8f817da646a71970cf7b5dd56b11aee733ba3fa7ccac9aa546746


** Major changes since the last release:
- Support for Windows "SRVOpen collapsing", which enables file handles
with the access/permission/etc attributes to share one NFS file handle
(saving open/close round trips to the NFS server)
- Added support for Windows Server 2025
- Symlinks are now using the group defined by Win32 PrimaryGroup
(which can be set via Cygwin newgrp(1)/|setgid()| or winsg(1))
- Added a new standalone tool called catdbgprint.exe which can be used
to listen to Windows kernel |DbgPrint()| debug messages (DbgView.exe
from Windows Internals still works, but this avoids installing an
extra tool)
- Added support for Windows "Extended Create Parameters" ECP
QUERY_ON_CREATE |QoCFileStatInformation| and |QoCFileLxInformation|
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
- Better FreeBSD 14 nfsd compatibility
- DFS service no longer needs to be disabled
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
- Support for FSCTL_DUPLICATE_EXTENTS_TO_FILE, which allows Windows 11
applications which use |CopyFile2()| (like cmd.exe  copy, xcopy.exe
etc) to copy files via block cloning. Requires NFSv4.2 NFS server with
{ CLONE, SEEK, DEALLOCATE } support, exporting a filesystem which
supports block cloning (e.g. btrfs, xfs). This includes correct
cloning of sparse files.
- Sparse file support (requires NFSv4.2 server { SEEK, ALLOCATE,
DEALLOCATE } and the |FATTR4_WORD1_SPACE_USED| attr), including
hole/data range enumeration, punching holes etc., e.g. $ fsutil sparse
queryrange mysparsefile #
- Improved Windows Extended Attribute (EA) support (requires NFS >=3D
v4.1 server with "Named Attribute" support ("OPENATTR")), including
create/read/write/delete
- Improved WSL support
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

