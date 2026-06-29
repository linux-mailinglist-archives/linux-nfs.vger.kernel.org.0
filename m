Return-Path: <linux-nfs+bounces-22875-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HVIwIvk7Qmqk2QkAu9opvQ
	(envelope-from <linux-nfs+bounces-22875-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 11:33:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAB6D8433
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 11:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DlT8vxH5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22875-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22875-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 311E13029784
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CAF363087;
	Mon, 29 Jun 2026 09:19:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F51253B42;
	Mon, 29 Jun 2026 09:19:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724766; cv=none; b=FQb8vHP4WbwuGzMR/+jYmm5jXMoe21RvhQ8gTIqXjhaOzium6ANjKGfZD5/jeK0tJ/IqIXAhHZzRHGGUGYNPnQeJQGJZnhn/yb9M7ggJCIlWcFeSyq+3AH91xFg15OacA2Z8j5A5opaYUoDikd3gzdlujVBUCvrUTjn2vwavxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724766; c=relaxed/simple;
	bh=uR8HO3H1zUPtr8G0Zp6+Ktn5lJGREnqvWcuZOYXRlPU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dgXfhKyZBgG/lYd0fSU8v5+PvGUsWMCyF28zNFmFI1JhNe6NsecIXPv6GEP49Q2X3WEu5LkXzIXf2usMhFQhkWKkbRlW9aovqr8CgBv/zF6FPmy7tcQNB7ZnsbgtEwQcPBtQ4ZrBnmglAkSkyHtBsEhLAzCep9p4jGZnJy6WNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlT8vxH5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A001F000E9;
	Mon, 29 Jun 2026 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724765;
	bh=VQkmJ6O0KdU+araY9cEcdEV3lY4ZmztKgNlix5k27sE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DlT8vxH5utORFwzr7vxs+1ZC5b8cxQsTqXOya1AQqsce5YpoKelp2QpHlKA+nkhWr
	 7GteQ5CCSkyd6M4WMmbss+2aU0e7CTZBjtyjalrXpN7xoqYsfmQ4YcjkOkkrNlMZsj
	 aHUPmsQMrOP8L+mvilChS1rcJupw+08A7A2GMjHi2QbXp6JKC0fXQrr8wk/Li1RPLm
	 qWhJpFAPQbPJJdW7ennikm1IF8S60n6fbWDjGGlLwbeFdllm4IkkixKHY3cBn4AA+O
	 KULJr9DbVfZhjJfd4kLHKCccrfrrIri+zo1kBioSQjDpj9A9QKvwf6ng4eIjLmo07F
	 wZjGFw8eu9+4w==
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 2/3] fs: support tasks with a null root or cwd
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Li Chen <me@linux.beauty>, 
 Cong Wang <cwang@multikernel.io>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-arch <linux-arch@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-api <linux-api@vger.kernel.org>, netfs <netfs@lists.linux.dev>, 
 linux-nfs <linux-nfs@vger.kernel.org>, John Ericson <mail@JohnEricson.me>
In-Reply-To: <20260629065934.1425479-3-John.Ericson@Obsidian.Systems>
References: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
 <20260629065934.1425479-3-John.Ericson@Obsidian.Systems>
Date: Mon, 29 Jun 2026 11:19:15 +0200
Message-Id: <20260629-defizit-typisch-maulkorb-53953a5a8510@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=671; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uR8HO3H1zUPtr8G0Zp6+Ktn5lJGREnqvWcuZOYXRlPU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5WUwXTTaTvvSu4GfWn46fsm+2i02PPX5V3fPyPSuXV
 Um/VI4t7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIHgsjw9vuM9WOryfL1B8p
 EdhZaip++9T67xH3L3D9DL2+57k1iwkjw6I6jRv3djYmpZ9h/3HlgfilKdZNPNODDkZzHUh5lL3
 +KhMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@Obsidian.Systems,m:luto@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:cel@kernel.org,m:jlayton@kernel.org,m:skhan@linuxfoundation.org,m:david.laight.linux@gmail.com,m:hpa@zytor.com,m:me@linux.beauty,m:cwang@multikernel.io,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:corbet@lwn.net,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:netfs@lists.linux.dev,m:linux-nfs@vger.kernel.org,m:mail@JohnEricson.me,m:davidlaightlinux@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22875-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,redhat.com,linuxfoundation.org,gmail.com,zytor.com,linux.beauty,multikernel.io,arndb.de,alien8.de,linux.intel.com,lwn.net,zimmerman.foo,vger.kernel.org,lists.linux.dev,JohnEricson.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,brauner:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40BAB6D8433

> A task's root directory (`fs->root`) and current working directory
> (`fs->pwd`) are normally established by `chroot(2)`/`pivot_root(2)` and
> `chdir(2)`/`fchdir(2)` (or inherited across `fork(2)`). Allow either to
> instead be the null path, as documented in `struct fs_struct`. The two
> are independent: a task may opt out of one, the other, or both.

No, absolutely we're not going to have tasks with struct path's in their
struct fs_struct that have NULL members in them. struct path is used
insanely widely in the kernel this is just an an open invitation for a
slew of security bugs. Not going to happen.

-- 
Christian Brauner <brauner@kernel.org>

