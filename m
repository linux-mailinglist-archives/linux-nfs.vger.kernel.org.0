Return-Path: <linux-nfs+bounces-21294-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBVCKnt/8mnarwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21294-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 00:00:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2DE49AC2B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 00:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A727F300C31B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 22:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7B359A6F;
	Wed, 29 Apr 2026 22:00:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1F26A0D5;
	Wed, 29 Apr 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500017; cv=none; b=TkXSbGTEP3Q96Eem73vwl8DHpgNmrDUJJCIq0al6DYbT/hmhsBm/S7wM6XUBeAppMYVsNBlYM0GFKsqoC+iM2WZ9AjuoyHGXMk0BpStIB5kuMUbpEXBsj1EAogr5+fm683NetL128jBeDYZUJSlKlNCMLOxpZFazaYynVvNiNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500017; c=relaxed/simple;
	bh=Q+hGRNt4Qu8Kg28XQ4VG6Co93Cs9xCHkhw8gVF9vba8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijO6EVkaXfDm4eWzVyAbBhx8hz2A2E7j37JeETC94bIXLQPEH6yHeiQOgnbvVdiaRiXkM9x2jqjdaKsBJky+8+L5ZDhB58F605IgYZa+7CLHGDcs33MxQj2XFqbUlP5gYBdyHkVcnGS18+SAm8yJbH9QcW0sYI/Igp6FDCmDM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id A21F41D459;
	Wed, 29 Apr 2026 22:00:08 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id nLFlEmh/8mm4swUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 29 Apr 2026 22:00:08 +0000
Message-ID: <3d3d6e22-b8a7-4f32-8046-697e45ec6c04@dev.snart.me>
Date: Thu, 30 Apr 2026 07:00:04 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/15] exfat: Implement fileattr_get for case
 sensitivity
To: Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org,
 hansg@kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, Roland Mainz <roland.mainz@nrubsig.org>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
 <20260429-case-sensitivity-v12-4-8057123bebe0@oracle.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260429-case-sensitivity-v12-4-8057123bebe0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EF2DE49AC2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[dev.snart.me : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21294-lists,linux-nfs=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.467];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/30/26 03:07, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Report exFAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> flag. exFAT is always case-insensitive (using an upcase table for
> comparison) and always preserves case at rest.
Not necessarily "always".

Link: https://github.com/exfatprogs/exfatprogs/issues/313

The specs(SD spec part 2 and MS spec) leave it up to the formatter
implementation on how the volume should behave. The observed behaviour
is that it is quite flexible: you can pretty much use any artitrary
up-case table to make an exFAT volume behave completely different and
major implementations including Linux and Windows kernel honour the
table no matter what. So exFAT is not so "binary"(folding vs. not
folding) when it comes to case folding behaviour.

NTFS also has a similar up-case table feature. Although it's usually
unused, if an up-case table exists in the volume, the implementation
probably has to honour it(although this is not written down in any spec,
this should be the expectation).

At the end of the day, it wouldn't matter much because no sane formatter
would produce a volume with some weird version up-case table. But if
that attribute plays a important role in some system that has some level
of impact, I suggest considering another attribute, say "unknown" or "it
depends".

Davo

