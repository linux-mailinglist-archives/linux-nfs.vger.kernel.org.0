Return-Path: <linux-nfs+bounces-15004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E818BBF8D3
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF9514E3385
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14221D3CC;
	Mon,  6 Oct 2025 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fi96hxBz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F7A932;
	Mon,  6 Oct 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785637; cv=none; b=q6CdqfLw307f9FgDjAuQ9CeyYy6HlMG3PbApjykmjRmOBwevjkmRMlVEwf56Y6e8JXBp+Ea95/kja8hdOKPxxrqt2ruNhc7SC0smP/VnYbD8WYcVUgw7iTTOr1nlbnj+HXTaj3q0XeNPu+iPhaQ4CkONPE8MebSH2JcirrGQWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785637; c=relaxed/simple;
	bh=QSU51UR2uxGDchOxUtvHA7aYpraXeHJ+Rj6M2J3AWh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDcFKjF0Xx4LE/3kgTzW4abkBoawzmzthMLoigW8UopNjRxw/yNukpP0M5ArwMz/dPkybPSqd4adhTCMsj6O3tEuqjiJfTb1Ax3luMYCQWD0GubavreVG4v4NmKN6rMUNnOQLFEoowF7cJvsIFKkm82ZToixVDMQUSY8p2YEyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fi96hxBz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HngUC5vHdPaFRM0doaJ26IbGvDNryzKgSLJa3D2TBu4=;
	t=1759785636; x=1760995236; b=Fi96hxBzxTdlHodKMwi2zON8RCG6VWcAAmxpSjkzmI/0gxm
	TBoyY0Xpe+HWrh0f3qtYrIc3avWXTbU5/AB38rfIj9jJLPhB1Y7UTQuUGQOJsFAoYrSrY3Nh1pfJd
	hOO1l/qTLLmiaG5yLSVZnp6bs8DS03lnY3m/j6cO89axTWT21TD4MHBdTsNeakGo5mQUDVD7lq/GP
	jFqVmn6RJ1MSO71Qcs7dR64I+MC8MEa3xKsyFKaE4KjCln8aBWSJ9dsVPqOwKB9x/BOneap9RY3fH
	7Sqfo9z0DDjEr6BHxzdl8JMFayxtRYjXnHsNjKXLjCGhspFhhVXPdbGK+xkckJoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v5sdF-0000000FDDk-36FK;
	Mon, 06 Oct 2025 23:20:33 +0200
Message-ID: <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
Subject: Re: [GIT PULL] NFSD changes for v6.18
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>, Chuck Lever
 <cel@kernel.org>,  Christian Brauner	 <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton
	 <jlayton@kernel.org>, linux-um@lists.infradead.org
Date: Mon, 06 Oct 2025 23:20:32 +0200
In-Reply-To: <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com> (sfid-20251006_225217_891954_03B128C7)
References: <20251006135010.2165-1-cel@kernel.org>
	 <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
	 (sfid-20251006_225217_891954_03B128C7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-10-06 at 13:51 -0700, Linus Torvalds wrote:
> Danger Will Robinson: hostfs has odd duplicate copies of all these, inclu=
ding a
>=20
>    #define HOSTFS_ATTR_ATTR_FLAG   1024
>=20
> of that no-longer existing flag.
>=20
> But hostfs doesn't use ATTR_FORCE (aka HOSTFS_ATTR_FORCE), so
> switching those two bits around wouldn't affect it either, even if you
> were to have a version mismatch between the client and host when doing
> UML (which I don't know
>=20
> Adding Christian to the participants list, because I did *not* do that
> cleanup thing myself, because I'm slightly worried that I'm missing
> something. But it would seem to be a good thing to do just to have the
> numbering make more sense, and Christian is probably the right person.

That indeed looks messy in hostfs; I'm not really all _that_ familiar
with all the details of it, but the stated reason is that it needs to
have the defines in kernel and user code.

That doesn't mean it's between the host and guest kernels, it's just
between code built for "userspace" and code built for "kernel", both of
which go into the UML linux "guest" binary. IOW, it's just for
communication between hostfs_kern.c and hostfs_user.c, which nobody else
needs to care about.

And as long as hostfs doesn't propagate CTIME_SET from the host to the
guest, it doesn't need a HOSTFS_ATTR_CTIME_SET. No idea why
HOSTFS_ATTR_ATTR_FLAG was even defined, it's ancient anyway.

However ... it looks like hostfs_kern.c is using ATTR_* in some places,
and hostfs_user.c is using HOSTFS_ATTR_*, so it looks like right now
these *do* need to match. Given that, we should just generate them via
asm-offsets.h, like we do for other constants with the property of being
needed on both sides but defined in places that cannot be included into
user-side code, like this:


From: Johannes Berg <johannes.berg@intel.com>
Date: Mon, 6 Oct 2025 23:14:36 +0200
Subject: [PATCH] um/hostfs: define HOSTFS_ATTR_* via asm-offsets

The HOSTFS_ATTR_* values were meant to be standalone for
communication between hostfs's kernel and user code parts.
However, it's easy to forget that HOSTFS_ATTR_* should be
used even on the kernel side, and that wasn't consistently
done. As a result, the values need to match ATTR_* values,
which is not useful to maintain by hand. Instead, generate
them via asm-offsets like other constants that UML needs
in user-side code that aren't otherwise available in any
header files that can be included there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/common-offsets.h    | 10 +++++++
 arch/x86/um/shared/sysdep/kernel-offsets.h |  1 +
 fs/hostfs/hostfs.h                         | 34 +---------------------
 3 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shar=
ed/common-offsets.h
index 8ca66a1918c3..fcec75a93e0c 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -18,3 +18,13 @@ DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
 DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
=20
 DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
+
+DEFINE(HOSTFS_ATTR_MODE, ATTR_MODE);
+DEFINE(HOSTFS_ATTR_UID, ATTR_UID);
+DEFINE(HOSTFS_ATTR_GID, ATTR_GID);
+DEFINE(HOSTFS_ATTR_SIZE, ATTR_SIZE);
+DEFINE(HOSTFS_ATTR_ATIME, ATTR_ATIME);
+DEFINE(HOSTFS_ATTR_MTIME, ATTR_MTIME);
+DEFINE(HOSTFS_ATTR_CTIME, ATTR_CTIME);
+DEFINE(HOSTFS_ATTR_ATIME_SET, ATTR_ATIME_SET);
+DEFINE(HOSTFS_ATTR_MTIME_SET, ATTR_MTIME_SET);
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/share=
d/sysdep/kernel-offsets.h
index 6fd1ed400399..ee6b44ef2217 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -5,6 +5,7 @@
 #include <linux/crypto.h>
 #include <linux/kbuild.h>
 #include <linux/audit.h>
+#include <linux/fs.h>
 #include <asm/mman.h>
 #include <asm/seccomp.h>
=20
diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 15b2f094d36e..aa02599b770f 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -3,40 +3,8 @@
 #define __UM_FS_HOSTFS
=20
 #include <os.h>
+#include <generated/asm-offsets.h>
=20
-/*
- * These are exactly the same definitions as in fs.h, but the names are
- * changed so that this file can be included in both kernel and user files=
.
- */
-
-#define HOSTFS_ATTR_MODE	1
-#define HOSTFS_ATTR_UID 	2
-#define HOSTFS_ATTR_GID 	4
-#define HOSTFS_ATTR_SIZE	8
-#define HOSTFS_ATTR_ATIME	16
-#define HOSTFS_ATTR_MTIME	32
-#define HOSTFS_ATTR_CTIME	64
-#define HOSTFS_ATTR_ATIME_SET	128
-#define HOSTFS_ATTR_MTIME_SET	256
-
-/* This one is unused by hostfs. */
-#define HOSTFS_ATTR_FORCE	512	/* Not a change, but a change it */
-#define HOSTFS_ATTR_ATTR_FLAG	1024
-
-/*
- * If you are very careful, you'll notice that these two are missing:
- *
- * #define ATTR_KILL_SUID	2048
- * #define ATTR_KILL_SGID	4096
- *
- * and this is because they were added in 2.5 development.
- * Actually, they are not needed by most ->setattr() methods - they are se=
t by
- * callers of notify_change() to notify that the setuid/setgid bits must b=
e
- * dropped.
- * notify_change() will delete those flags, make sure attr->ia_valid & ATT=
R_MODE
- * is on, and remove the appropriate bits from attr->ia_mode (attr is a
- * "struct iattr *"). -BlaisorBlade
- */
 struct hostfs_timespec {
 	long long tv_sec;
 	long long tv_nsec;
--=20
2.51.0



(that passes my usual tests, if you want you can apply it as is, or I
can resend it as a real patch, or I can also put it into uml-next for
later...)

johannes

