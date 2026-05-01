Return-Path: <linux-nfs+bounces-21332-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCXqCUug9GnhCwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21332-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 14:44:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880FB4AC79C
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB843024C90
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E93A542F;
	Fri,  1 May 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBPygiff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE53A542A;
	Fri,  1 May 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639463; cv=none; b=j3GNJ+mx7Vc20G1arhDuK7f4gf1+XZ80zv3Q7Z5QjdntLJZhdACPJPdhhMWxUFCD4WBhSgZDZErTBW7XAjGTnZgo1SRHSKnior3fbLbhAUgo6iXCSnG5zCzBkwB52Vm+xOMYYCvu7nFIe0ieg/tfPl3o6IizBhnUvhFlNY3Ea9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639463; c=relaxed/simple;
	bh=tOQURC2lOBxx2B37R+W14tFAK4b6ua+v1BIBDO25iGY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MDdpwZB1z8PCIow5afXAss73f+SusOdJfJ7HJNXTS3oTUulZC2BS+W/+OEB76a9bE1qhNuUX0AOlyW1e/Ug+RLsHzNyDN0oCRygwyMFFJhFGX5oaHvgOeLei92nfTb/Mllnf2qMOTuS1pMtXkJ5TH3Z5h/SqL9sNcajaEHoiQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBPygiff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F400C2BCB7;
	Fri,  1 May 2026 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777639463;
	bh=tOQURC2lOBxx2B37R+W14tFAK4b6ua+v1BIBDO25iGY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LBPygiffx0JtHpCrM7wj7xR3bXkb7oJzWnSiONJHFvDtsXFeuKu6AeJtS6/bAsxFl
	 Ijx465GWMs8sVlmOVatb++6ZEpw3R8RKPpTAhSCsm608dnf+dLm+P6bu+44LmRifBj
	 qSs6vUAC991+/ilaCCgEZRFfgUemE70qsiRgsuSh91z85yXBS7Klz5YEDMwutgNGZ6
	 Urn2uDW/X6v/x3VkcjYO4xfGmKmOd23ladCqxES8o8Xtk3NgcuqSYzuwhPLjbi9L1s
	 kFgfyDvVj0YGbigk8RUf9WXeDNo0wKdhwJB/GcEBeZZf3y3FfIIV2Muipl87r1g73Y
	 DRSKBEZKIVjpA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 262F8F4006D;
	Fri,  1 May 2026 08:44:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 01 May 2026 08:44:22 -0400
X-ME-Sender: <xms:JqD0af-dsW1UXIKGFbOiCBlshGCGBxMKKb8ZI1eFeMCLu8-KIhW2mA>
    <xme:JqD0aWgzNu3SCDqvf3k8TeYQ0VFCxA_vAaYloCaVB9vT4R_v6GpW0O3MgV0xQd1OG
    hyMiZim3ssy4qSwox82eF9xw3VNMB-CqtH7cZNOkRcAYxb3mz4q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgeehudeiieevveehleehleeugefhhfdttdehlefhuddttdehieelteekleevtdejnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpe
    epkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhhishgrnhhjuhhmsehlihhnuhigrdhisghmrdgtohhm
    pdhrtghpthhtohepvhgvnhhkrghtkeeksehlihhnuhigrdhisghmrdgtohhmpdhrtghpth
    htoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgt
    phhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhnvgigthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JqD0aZ-eFMMT6v1KtExUvT6w0MVa-AGRyUautOMYlbZSFZ0vq-U--Q>
    <xmx:JqD0aaRKqirODqnZgL7zXQSn6YLEL_7TT0RNqFCBqv0tkomx4eub6g>
    <xmx:JqD0abdYZ6RoWS_8dTiAOa_bbY3m5TEekj0vAk_5nCGaxIaN29ghQg>
    <xmx:JqD0aUQx3oRrUvGvAwS3Q2FbkCtlv152yBi0Idd0V3HWPH92UpL-LQ>
    <xmx:JqD0afLpq_HMJjX5wXeWl1zdOxy6ewWTpmc6m8NihfDAjXM2FdbzBk2u>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3F34780070; Fri,  1 May 2026 08:44:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 May 2026 08:44:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Misbah Anjum N" <misanjum@linux.ibm.com>,
 "Linux Kernel" <linux-kernel@vger.kernel.org>,
 "Linux Nfs" <linux-nfs@vger.kernel.org>
Cc: "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, venkat88@linux.ibm.com,
 "Linux Next" <linux-next@vger.kernel.org>
Message-Id: <8e8847fb-0eff-46b0-97dc-fe683c706db3@app.fastmail.com>
In-Reply-To: <d6701b40b8b7c143f87ecec0afb08af8a2867358.camel@kernel.org>
References: <dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com>
 <8cf80f450085ac17164e8fa1391e9635@linux.ibm.com>
 <d6701b40b8b7c143f87ecec0afb08af8a2867358.camel@kernel.org>
Subject: Re: [BUG] [powerpc] [next-20260216/17] nfsd: use-after-free in
 cache_check_rcu() triggered by sosreport on ppc64le
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 880FB4AC79C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21332-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On Fri, May 1, 2026, at 3:06 AM, Jeff Layton wrote:
> On Fri, 2026-05-01 at 02:15 +0530, Misbah Anjum N wrote:
>> Hi,
>>=20
>> Following up on my bug report, I have completed a git bisect and have=20
>> critical new findings to report.
>> Ref:=20
>> https://lore.kernel.org/linux-next/dcd371d3a95815a84ba7de52cef447b8@l=
inux.ibm.com/T/#u
>>=20
>> Current Status: Bug Has Propagated from linux-next to Mainline.
>> First Bad commit identified: da6b5aae84beb0917ecb0c9fbc71169d145397ff
>>=20
>> The use-after-free bug in cache_check_rcu() that I originally reporte=
d=20
>> in linux-next (6.19.0-next-20260216/17) has now propagated into mainl=
ine=20
>> and is confirmed present in:
>> - mainline (Tested on Latest kernel as of 2026-04-30 - commit=20
>> 08d0d3466664)
>> - linux-next (Tested on Latest kernel as of 2026-04-30)
>>=20
>> This bug is causing failures on ppc64le systems:
>> 1. Kernel panics: 100% reproducible crashes when sosreport runs
>> 2. CI/Testing failures: All automated Avocado-vt KVM testing on ppc64=
le=20
>> is failing
>> 3. Use-after-free corruption: Memory corruption with corrupted pointe=
rs=20
>> containing
>>     ASCII strings ("libz.so.", "export_cap") or poison patterns=20
>> (0xcccccccccccccccc)
>>=20
>
> Thanks for the bug report. I must have missed your earlier email.

You didn=E2=80=99t miss it. We responded to that report in February with
a fix that you and Neil both reviewed and it is in v7.0 now.

That fix addressed one instance of this problem; there are actually
several more, all in the same UAF class. I have a patch series nearly
complete to address these issues.

The issue Misbah reports here is not the same as the February issue,
though it is very similar.


> The commit you landed on is a merge commit and is not likely to be the
> cause, particularly since that merge was for x86 drivers and you're
> seeing this on PPC. Is this reproducible on other architectures?

We have an internal bug reporting the same stack trace on ARM64. Now
that we have both a reproducer and a platform that is easily accessible
it will be straightforward to confirm these issues are fully addressed
before we merge the new fixes.


--=20
Chuck Lever

