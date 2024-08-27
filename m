Return-Path: <linux-nfs+bounces-5820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E1E9618FF
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AA02849ED
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3A1D2F5C;
	Tue, 27 Aug 2024 21:09:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FF156661;
	Tue, 27 Aug 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792969; cv=none; b=eNTtZH5opOXME8w36WNvSkRd1FEhgy4MiLq8BVh67FRD1v5oRDex4vErEPG3FzQHN+b4c+P/mHNIQydviWv3QoIeG+3SaA8taXIAVVro2e7u2mJ3r64Bv7F/m0NO0G0A+mWWHjiJiZ0LljOq5LrKDypcCtSbqDyIhcUvjTCNCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792969; c=relaxed/simple;
	bh=p7X4TZtVQiaufNzl4DiSXu792a5puBx3htrLv1R3PcQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lncypi6VV9/FMI0n632DjD8RTg6XT1chG6baLdwSYA7VGMMGqyUXVsjVzEv3fP+mOjLQQYomKfpKbX1LMmX0oa+eIZv4y3c6rSi5qLQ+ZnM/RiYmGCBhkI5enricJD5s9pJk5TkSTxKT1sHQx2jIgvzn/DJy515xfHINcEoNDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C2841FB91;
	Tue, 27 Aug 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A126313724;
	Tue, 27 Aug 2024 21:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BladFYNAzmZKDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Aug 2024 21:09:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Martin Doucha" <mdoucha@suse.cz>
Cc: "Petr Vorel" <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>, stable@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, ltp@lists.linux.it
Subject:
 Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
In-reply-to: <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
References: <>, <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
Date: Wed, 28 Aug 2024 07:09:14 +1000
Message-id: <172479295459.11014.9802161915427616319@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 0C2841FB91
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, 27 Aug 2024, Martin Doucha wrote:
> On 23. 08. 24 23:59, NeilBrown wrote:
> > On Fri, 23 Aug 2024, Petr Vorel wrote:
> >> We discussed in v1 how to fix tests.  Neil suggested to fix the test the=
 way so
> >> that it works on all kernels. As I note [1]
> >>
> >> 1) either we give up on checking the new functionality still works (if we
> >> fallback to old behavior)
> >=20
> > I don't understand.  What exactly do you mean by "the new
> > functionality".
> > As I understand it there is no new functionality.  All there was was and
> > information leak between network namespaces, and we stopped the leak.
> > Do you consider that to be new functionality?
>=20
> The new functionality is that the patches add a new file to network=20
> namespaces: /proc/net/rpc/nfs. This file did not exist outside the root=20
> network namespace at least on some of the kernels where we still need to=20
> run this test. So the question is: How aggressively do we want to=20
> enforce backporting of these NFS patches into distros with older kernels?

Thanks for explaining that.  I had assumed that the the file was always
visible from all name spaces, but before the fix every namespace saw the
same file.  Clearly I was wrong.

>=20
> We have 3 options how to fix the test depending on the answer:
> 1) Don't enforce at all. We'll check whether /proc/net/rpc/nfs exists in=20
> the client namespace and read it only if it does. Otherwise we'll fall=20
> back on the global file.
> 2) Enforce aggressively. We'll hardcode a minimal kernel version into=20
> the test (e.g. v5.4) and if the procfile doesn't exist on any newer=20
> kernel, it's a bug.
> 3) Enforce on new kernels only. We'll set a hard requirement for kernel=20
> v6.9+ as in option 2) and check for existence of the procfile on any=20
> older kernels as in option 1).

I think there are two totally separate questions here.
1/ How to fix the existing test to work on new and old kernels.  The
  existing test checked that the rpc count increased when NFS traffic
  happened.  I think 1 is the correct fix.  I don't think the test
  should check kernel version.

2/ We have discovered a bug and want to add a test to guard against
  regression.  This should be a new test.  That test can simply check if
  the given file exist in a non-init namespace.  I have no particular
  opinion about testing kernel versions.  A credible approach would be
  to choose the oldest kernel which it still maintained at the time that
  that bug was discovered.  Or maybe create a list of kernel versions
  where were maintained at that time and only run the test on versions
  in that list, or after the last in the list.

I really think there is value in having two different tests because we
are testing two different things.

Thanks,
NeilBrown


>=20
> --=20
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>=20
>=20


