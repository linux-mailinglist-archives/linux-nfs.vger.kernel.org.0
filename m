Return-Path: <linux-nfs+bounces-22792-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0TjNmO0OmqhEQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22792-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 18:29:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B76B8B6A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 18:29:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eCc+SDLp;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22792-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22792-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A49B9301B73D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B1030BF69;
	Tue, 23 Jun 2026 16:29:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4D306757
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 16:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232157; cv=none; b=NpPh997+QQUdzfjKZlR79k07oolTlLs5IuM9wnLIru9P0dXsFbHbk3wAtdWA18CQ7tW76xFqjOlu6wByjWWRfhVIaFh3Sca24zrxqmY17uSAfULi/4HK2z4auaWqkSYdhNeWreG7s4XbBeLdvZwyJwbrW7bYnAjse8zTnR+lVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232157; c=relaxed/simple;
	bh=rRq05R5+ZxwxtgSXNIyu0FuVwAV77cFRgAvPdacijuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mel6CJk8KQXacKQnd3DyjnzdU/h68qP6pWRAjE3sKb3jJ6+dLoPtIcXnxK6MPWW/EDYYoGBHDg9H7NHYW+gLRZe2yB/7qQKbKfuksooKLxr5n6IzWVuG5fOGz50eTZduDXZVThgqIeH/X8lAUvt30n+jUiZxt5TsDYS920MnO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCc+SDLp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD421F000E9;
	Tue, 23 Jun 2026 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782232156;
	bh=rRq05R5+ZxwxtgSXNIyu0FuVwAV77cFRgAvPdacijuE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eCc+SDLpboC7WGwLpuc4it+sl5I1J62ROapz5AQLG9/V9622CTE62Jc57fB9qDSI1
	 SdIBQs0xzk4UthwmGshbHtEOLcIGTQNBkGsjgbI8PbZ75I6stBO60ineNNXnZLXvTx
	 plnN0FW+6sUp2VnFvR4CYtlmCYZl0zknawQJTA1AcWoGrZrOXfh9IdHm0PkhatYNWq
	 OUwfDnLqzsrkAiQKkzdWI3Lk2EMCBztV19wyV6coWMihmSXGVjIoYTWdOELhdcZYnc
	 x+La+EWg+pFEv6LYFHy5WYyn1bdmuGcSLM7u0Qw6hJk0qBLp7dNxbeqMJ4g4AQ4xmH
	 MpFPcFeVxKpdA==
Message-ID: <3aab8cd1b42edbd1cbfc3981fd3624ab8e988993.camel@kernel.org>
Subject: Re: NFS delegations behavior analysis
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Mkrtchyan, Tigran"	
 <tigran.mkrtchyan@desy.de>, Piyush Sachdeva <s.piyush1024@gmail.com>,
 linux-nfs	 <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
 sfrench@samba.org, 	sprasad@microsoft.com, vaibsharma@microsoft.com
Date: Tue, 23 Jun 2026 12:29:14 -0400
In-Reply-To: <E86DDFB0-6E5E-40CC-8DFA-7233793D25E1@hammerspace.com>
References: <m2qzlx7eye.fsf@gmail.com>
	 <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
	 <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
	 <227140ce94ebe4186d02b081489a58f32b878ec4.camel@kernel.org>
	 <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
	 <E86DDFB0-6E5E-40CC-8DFA-7233793D25E1@hammerspace.com>
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
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22792-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:tigran.mkrtchyan@desy.de,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,desy.de,gmail.com,vger.kernel.org,samba.org,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hammerspace.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 307B76B8B6A

On Tue, 2026-06-23 at 09:32 -0400, Benjamin Coddington wrote:
> On 23 Jun 2026, at 9:11, Benjamin Coddington wrote:
>=20
> > .... er - so with directory delegations, can we simply re-hydrate
> > the dentry
> > cache from the directory page mappings if the delegation is still
> > valid?
> > Does the directory delegation pin the mapping?=C2=A0 Clearly I need to
> > look at
> > the code..
>=20
> .. right - we don't keep the file attributes in the mappings today.=C2=A0
> And,
> more to the point - the directory delegation doesn't protect those
> file
> attributes either.=C2=A0 We'd need NOTIFY4_CHANGE_CHILD_ATTRIBUTES
> implemented.
>=20
> Ben

Unlike delegations, notifications are asynchronous by design. Upon
reception of a notification, you may deduce that you should revalidate
the attributes on a file. However the absence of that notification is
insufficient to deduce that it is safe not to revalidate those
attributes.

So when it comes to informing the client whether to use READDIR or
READDIRPLUS, I'm sceptical concerning the value of throwing
NOTIFY4_CHANGE_CHILD_ATTRS at the problem.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

