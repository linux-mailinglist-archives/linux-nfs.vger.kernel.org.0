Return-Path: <linux-nfs+bounces-2087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542F86742E
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 13:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B642907B4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0AC1CFA7;
	Mon, 26 Feb 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="AHq8Ou68"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpo48.interia.pl (smtpo48.interia.pl [217.74.67.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4235A7BF
	for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948877; cv=none; b=FfCqbYHtb7GDVy4JQ8eiOQlC5pdRmBikUHaLm4+qBhrst4iqT0qXblMHbeVAhc1qsUKFmOlJoxgEvAfrvyU8uqaKZ+WeB7nXuLxdrae6PFAeO6MWr9VT/ymzHqVnjORtsXg1sGE74hqK1B1XQklm85TNBwa1l9IJiUfY/UH5AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948877; c=relaxed/simple;
	bh=VjZnJExnpN3+x5NvUE1XvE98bz63CbvFDvapWusVIXo=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=YO9mDXxK65Mp2qXMoeVp3Z5uAiUQiOcBEmfUT1pCW7VIhWWEadVlMFiIQ/je0Zf3Msa8Zqd3M+Hvtcf6uki0uRw3EBdOZycb3IuZNoINXO37nEx4FzHpGvpCs6oLAtswCKzZ0jNCiJ7S/FGbRDU8THirlf+NGtINl/GXbaWU9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=AHq8Ou68; arc=none smtp.client-ip=217.74.67.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Date: Mon, 26 Feb 2024 12:58:16 +0100
From: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: Re: NFS data corruption on congested network
To: NeilBrown <neilb@suse.de>
Cc: "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <170890314859.24797.16728369357798855399@noble.neil.brown.name>
References: <ujvntmhlfharduyanjob@tgqn>
	<170890314859.24797.16728369357798855399@noble.neil.brown.name>
Message-Id: <flfkkydzpicimncinmba@mlpw>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1708948700; bh=SMQLoDKAU5hL9SyItR53Djx76LAm0U2+ELJ+NJs60AI=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=AHq8Ou68nSOgHJMxHvh0d3nlM+FPHUfv5VNJMI3oedMjMikgyDCXT6biqNCDcgZt0
	 kyc9YeKuYkqdjo+HBX3zyvAEcrJMXB79HkKVh/zSxm2bhZ4ISzP4EbaKkRaoFMBt8M
	 sPsHbjdSj/noYAsOmKb1a35bWFGHpau5F+uDDTss=

Hi NeilBrown,=20

> though if your kernel is older than 6.3, that will be
>          redirty_for_writepage(wbc, page);

Things are looking good. I have ran it on 15 machines for good couple of ho=
urs and i do not see the problem. Usually i would see it after 1-3 iteratio=
ns but now they are reaching 20 iterations without the problem.

Thank you for the fix.
Regards.
Jacek Tomaka

Temat: Re: NFS data corruption on congested network
Data: 2024-02-26 0:19
Nadawca: "NeilBrown" &lt;neilb@suse.de>
Adresat: "Jacek Tomaka" &lt;Jacek.Tomaka@poczta.fm>;=20
DW: trond.myklebust@hammerspace.com; anna.schumaker@netapp.com; linux-nfs@v=
ger.kernel.org;=20

>=20
>> On Mon, 26 Feb 2024, NeilBrown wrote:
>> On Fri, 23 Feb 2024, Jacek Tomaka wrote:
>>> Hello,
>>> I ran into an issue where the NFS file ends up being corrupted on
disk. We started noticing it on certain, quite old hardware after upgrading
OS from Centos 6 to Rocky 9.2. We do see it on Rocky 9.3 but not on 9.1.
>>>=20
>>> After some investigation we have reasons to believe that the
change was introduced by the following commit:=20
>>>
https://github.com/torvalds/linux/commit/6df25e58532be7a4cd6fb15bcd85805947=
402d91
>>=20
>> Thanks for the report.
>> Can you try a change to your kernel?
>>=20
>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>> index bb79d3a886ae..08a787147bd2 100644
>> --- a/fs/nfs/write.c
>> +++ b/fs/nfs/write.c
>> @@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio
*folio,
>>  	int err;
>> =20
>>  	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &amp;&amp;
>> -	    NFS_SERVER(inode)->write_congested)
>> +	    NFS_SERVER(inode)->write_congested) {
>> +		folio_redirty_for_writepage(wbc, folio);
>>  		return AOP_WRITEPAGE_ACTIVATE;
>> +	}
>> =20
>>  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
>>  	nfs_pageio_init_write(&amp;pgio, inode, 0, false,
>=20
> Actually this is only needed before linux 6.8 as only nfs_writepage()
> can call nfs_writepage_locked() with sync_mode of WB_SYNC_NONE.
> So v5.18 through v6.7 might need fixing.
>=20
> NeilBrown
>=20
>=20
>>=20
>>=20
>> though if your kernel is older than 6.3, that will be
>>          redirty_for_writepage(wbc, page);
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>>>=20
>>> We write a number of files on a single thread. Each file is up to
4GB. Before closing we call fdatasync. Sometimes the file ends up being
corrupted. The corruptions is in a form of a number ( more than 3k pages in
one case) of zero filled pages.
>>> When this happens the file cannot be deleted from the client
machine which created the file, even when the process which wrote the file
completed successfully.
>>>=20
>>> The machines have about 128GB of memory, i think and probably
network that leaves to be desired.
>>>=20
>>> My reproducer is currently tied up to our internal software, but i
suspect setting the write_congested flag randomly should allow to reproduce
the issue.
>>>=20
>>> Regards.
>>> Jacek Tomaka
>>>=20
>>=20
>>=20
>>=20
>=20
>=20
>=20

