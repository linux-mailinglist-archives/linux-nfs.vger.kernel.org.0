Return-Path: <linux-nfs+bounces-22780-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uv/uOM5qOmpd8gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22780-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:15:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D038B6B69C9
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K1oiXfI8;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22780-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22780-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C2F03093036
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E23D1CCA;
	Tue, 23 Jun 2026 11:04:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6B3D3008;
	Tue, 23 Jun 2026 11:04:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212691; cv=none; b=TC1JIFYm5qDD0TGslUB+nZ63sx4mXf6daoLKIS3hJQa/nV9lVlQQDJm28QCzn0485Hc2pm+WkO08OEhXU0H2NNWkVlIltusJeAP5BfBHefvbYU6C0C7ZpgoSx4UaYawNpdKjyyvMgPMPEqR+fevluh3eXYuYB9kfe5TTEbh3WpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212691; c=relaxed/simple;
	bh=RTanCUpvtUBMF4CUzqkZamxQOh9M+hWnwErkCQfsBMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xm+DqgsfpYbjgl8upR4qcZ0JvoHDG8j3aKNsLG/CcyKzH07Ahq/EYoprc0UYdAnAmqkqKWTvKMolL7Rtm5UNeBv+Btp5GTZXVzGA+VVvdHC0uM8p/RkOxj3b8AHGeeqe8NZnA74wdkJ0myOypDQ+QdXPAhsMfn+IKK3eYJBl63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1oiXfI8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F4E1F000E9;
	Tue, 23 Jun 2026 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782212689;
	bh=lClbhszTMPfKdNN1SBGGeBJpPSg3DMW+kbrXaZkEA6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K1oiXfI8teb2/PO3sQlsYRiCzZl3I9H4vXLTXuNrw945WytGRbVOKOR+kYewCq5Os
	 GNb03NAThlsFDYdolvNFdUmY+3CkxpCN5F5FrIoKno+mg9WJ0WYZMJnLQlMYuyOZ62
	 KO/FsXykpyX7YMJys+0uazCHSVMgu5/y2/dWg7dOfUyphRkzaEJOLQIWEzZt7W9vuK
	 cSCoCZc+0xI6r8+le5Y+6hW/0EGw+sjtCKGXqqKTwIVdzX/NbBGgKdMOrjJ4HOa2v2
	 C2mFeDWxD2sUcPQ9AYpGLrNit1alEQoRdAwFeU4nfAj2BBeePk29Y7pIEd8JcIQhgc
	 gcQhZoKG2mRtQ==
Message-ID: <e5ebc36c9a7e356c8d1b98ce3a9d1f3420177334.camel@kernel.org>
Subject: Re: [PATCH 1/4] nfs: store the full NFS fileid in inode->i_ino
From: Jeff Layton <jlayton@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Tue, 23 Jun 2026 07:04:47 -0400
In-Reply-To: <655d0d2a5f8203c52c78d37462328449e49b7feb.camel@kernel.org>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
		 <20260512-nfsino-v1-1-284720522f4c@kernel.org>
		 <0750912a-f8dc-4714-ae11-4592d2e8eca7@sirena.org.uk>
	 <655d0d2a5f8203c52c78d37462328449e49b7feb.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22780-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D038B6B69C9

On Mon, 2026-06-22 at 18:38 -0400, Jeff Layton wrote:
> On Mon, 2026-06-22 at 22:05 +0100, Mark Brown wrote:
> > On Tue, May 12, 2026 at 12:12:42PM -0400, Jeff Layton wrote:
> > > Now that inode->i_ino is a 64-bit value, store the full NFS fileid in
> > > it directly instead of an XOR-folded hash. This makes NFS_FILEID() an=
d
> > > set_nfs_fileid() operate on inode->i_ino rather than the separate
> > > nfsi->fileid field.
> >=20
> > This patch is in -next now and is triggering a failure for in the LTP
> > ioctl10.c test for me on arm:
> >=20
> > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > tst_test.c:2047: TINFO: LTP version: 20260130
> > tst_test.c:2050: TINFO: Tested kernel: 7.1.0-next-20260622 #1 SMP @1782=
128788 armv7l
> >=20
> > ...
> >=20
> > ioctl10.c:111: TFAIL: q->inode (11493907226) !=3D entry.vm_inode (42949=
67295)
> >=20
>=20
> Note that the vm_inode value is arm32's ULONG_MAX.
>=20
> > arm64 seems unaffected, I didn't really investigate but I'll note that
> > unsigned long is 32 bit on arm.
> >=20
> > Full log:
> >=20
> >    https://lava.sirena.org.uk/scheduler/job/2904745#L3852
> >=20
> > bisect log with more test job links:
> >=20
>=20
>=20
> The testcase does this:
>=20
> static void parse_maps_file(const char *filename, const char *keyword, st=
ruct map_entry *entry)
> {
>         FILE *fp =3D SAFE_FOPEN(filename, "r");
>=20
>         char line[1024];
>=20
>         while (fgets(line, sizeof(line), fp) !=3D NULL) {
>                 if (fnmatch(keyword, line, 0) =3D=3D 0) {
>                         if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
>                                                 &entry->vm_start, &entry-=
>vm_end, entry->vm_flags_str,
>                                                 &entry->vm_pgoff, &entry-=
>vm_major, &entry->vm_minor,
>                                                 &entry->vm_inode, entry->=
vm_name) < 7)
>                                 tst_brk(TFAIL, "parse maps file /proc/sel=
f/maps failed");
>=20
>                         entry->vm_flags =3D parse_vm_flags(entry->vm_flag=
s_str);
>=20
>                         SAFE_FCLOSE(fp);
>                         return;
>                 }
>         }
>=20
>         SAFE_FCLOSE(fp);
>         tst_brk(TFAIL, "parse maps file /proc/self/maps failed");
> }
>=20
> Note that it's trying to stuff the inode number field into an unsigned
> long. Before this patch, the maps file would have printed the old
> (hashed) inode number on 32-bit. Now, it prints the full 64-bit inode
> number.
>=20
> I asked The Big Pickle and it says:
>=20
> "In glibc (userspace): The C standard says this is undefined behavior.
> In practice, glibc's scanf internally uses strtoul/strtoull, which on
> overflow store ULONG_MAX/ULLONG_MAX and set errno =3D ERANGE. However,
> scanf itself does not propagate ERANGE to the caller =E2=80=94 it still r=
eturns
> 1 (success). So you'd silently get ULONG_MAX stored."
>=20
> We could argue that this is a bug in the testcase. It assumes that the
> maps file will never print a value larger than ULONG_MAX in that field,
> and I don't see why it would make that assumption in this day and age.
>=20
> Are there actual programs in the field that scrape the maps file that
> might be affected by this change?

This testcase patch should fix it. I'll plan to send this to the LTP
list, but it would be nice if someone could confirm the fix on arm32:

-----------------------8<---------------------

[PATCH LTP] ioctl10: fix the sscanf() call to handle 64-bit inode on 32-bit=
 arch

This test started failing recently on arm32, when we switched the
kernel to displaying the full 64-bit inode number in the maps file.
Change the testcase to allow for a full 64-bit inode number on all
arches. The value it's compared to is already 64-bits so widening this
field is all that is necessary.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 testcases/kernel/syscalls/ioctl/ioctl10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/s=
yscalls/ioctl/ioctl10.c
index b668c9e93889..d7e40f3c8643 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl10.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -35,7 +35,7 @@ struct map_entry {
 	unsigned long vm_pgoff;
 	unsigned int vm_major;
 	unsigned int vm_minor;
-	unsigned long vm_inode;
+	uint64_t vm_inode;
 	char vm_name[256];
 	unsigned int vm_flags;
 };
@@ -68,7 +68,7 @@ static void parse_maps_file(const char *filename, const c=
har *keyword, struct ma
=20
 	while (fgets(line, sizeof(line), fp) !=3D NULL) {
 		if (fnmatch(keyword, line, 0) =3D=3D 0) {
-			if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
+			if (sscanf(line, "%lx-%lx %s %lx %x:%x %llu %s",
 						&entry->vm_start, &entry->vm_end, entry->vm_flags_str,
 						&entry->vm_pgoff, &entry->vm_major, &entry->vm_minor,
 						&entry->vm_inode, entry->vm_name) < 7)
--=20
2.54.0


