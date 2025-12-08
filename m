Return-Path: <linux-nfs+bounces-17000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC22CAE3EA
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 22:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749C4300EE5D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 21:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20002222AA;
	Mon,  8 Dec 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nHGD8tWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmJZQUwF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04A1DB95E
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229739; cv=none; b=IIFatcqSGY57yrsUY0aDvO5gEEHc8ktjs/hIRQuz3Q8rW2NNG8MiYx1GWdGc6DrQ2y204hLP0CI51O2E0Rg/hpK37mKyZCsSBbpzDgxS+suss46NVzdVT1joXYGxwa3k9cT0Ig1mkvNCMHhT7fpYF5iyvpS+s3+ctjvLZ3EvTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229739; c=relaxed/simple;
	bh=OgUcKETTKFAYxjOanyWtHLKU9RVOu+Ij9IS0/ySaMJw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ced2SLFwYTvlr36U4vJdXjBKMZ48Dke/Dl4JHWesOpJj7V5m/NvCL9RDUtS6AODyDfT5QAf2QLoKcvva4b9Zev/MJaWb3u6gmeSELzVaZWwVWCi3HWrSJ3DGI4QHmstiuRBJY74OB5mmGHmOooFRnIfb3oLFvCeAkfGiAgXnlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nHGD8tWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmJZQUwF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B38D1D0011A;
	Mon,  8 Dec 2025 16:35:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 16:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765229736; x=1765316136; bh=ibO+QYKSgRpMl+XeWIkV8m7Y43g8nK1oUmF
	dFZc1Xe4=; b=nHGD8tWccr5ipfOzlbZ4OKD6gyGtgzvTTq9J13FU2Yfp3hwyZxk
	kXPnZ7I4qEGjRKVpRdfWiEPGZt0OmdjRk/eWBHOKjPTE4gTuOyq0EImUn/ftxOpf
	fmHP8yXi30KuseiG/QGGHxL/0Y0TxkTHQ+cigwqPpz82o9Zo0Td+rSJrgH7q/0dl
	5b0Y2FMHqQJNEunS1Ypqd0kTmKM/WGmNNpyZtE+FEEWiVVPeSAfP5YWJ8lYfmSnh
	ezL1AhKrksBxTdGu8utanZg6ix46CsTTbL5t3w1BsiFY/UajuuekToix4A5jCJvH
	RZZZablZ7T6IU+axUMGKfh4UVnDsYJbx1zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765229736; x=
	1765316136; bh=ibO+QYKSgRpMl+XeWIkV8m7Y43g8nK1oUmFdFZc1Xe4=; b=f
	mJZQUwFMP4oAt5WN4Fh0f8Gk1qkEsrwpi8q3EuyQ2gLc/6tUeFWMeZN0OCuba9gg
	JgfQAR9aT63Gg9mO+ibauvQiP2KMIlsXa43+PnHAiGlCeKy00dgRLf5RKSqiloE/
	iXxERiR1S2s97pSYmVZ2jGcRWP5bS1kF6VVCFRwJDq/dD0DoFvORGXfXDkIEmm45
	gUFMCuhMBRzp2Ps4s3Log4ndDs03lrPEyXFuhuYFOfxoNPCyhRpIv7XHBuzJCnSS
	UP0fIbCI3kZdN9UPPj2ILKXsgFbK6yheY7mJFsIuDdeTrOIiJoxuOKcYL9m4V5W3
	tEGxHhUX5sV0RGqZRMqJg==
X-ME-Sender: <xms:qEQ3aXwAayrviuCxOcgnw854hTgYs9OYk8xdMN3IBDkk-RqRa0rVnw>
    <xme:qEQ3aeWXt7ptUEDtDrb-xLlLWOoymo8q9UdRuVPOFF4qlGkkWKi61CEzl_CyRLb7t
    2ne0mOxoo5JNtSUt0A_j-Tkynkf2w3WyGJDM2AGDrDxzCj_zQ8>
X-ME-Received: <xmr:qEQ3aXgoTKNbImtxZk1B0O4HQ1gwmCFaDJCSqOE1epDehTnZJno76ln8vJ4hLuDKzddAl0HOSoCuGvxOnxe2Yghoai3FfsmUmGesAEXwcY55>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhghhihrheshhgrmhhmvghrshhp
    rggtvgdrtghomh
X-ME-Proxy: <xmx:qEQ3aeAoUsftExg5qLxU207vCMciTsf9ji64xm4rKKWNEZ6G9T7Mag>
    <xmx:qEQ3ads1c8U3-2ssPTAsR-xn7il64dj85MNZprTDpuhM-KQGYGRh0g>
    <xmx:qEQ3aSeuDAUDCVOEd1jlp4s1WzDjq5ipExDfGLXvscBRxU1ShOPW0g>
    <xmx:qEQ3aS-BlGv27j2MQuQJlHoVtGJczY1M_9HqccHMFE0hbcnp21lXFQ>
    <xmx:qEQ3aZcs-LahE_MXgDcbzRXakhrFkCtgSVBlmacF856NLm2_5nu8UrVQ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 16:35:34 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
In-reply-to: <20251208194428.174229-1-cel@kernel.org>
References: <20251208194428.174229-1-cel@kernel.org>
Date: Tue, 09 Dec 2025 08:35:32 +1100
Message-id: <176522973244.16766.13514511634601889702@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 09 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In NFSD's pNFS flexfile layout implementation, struct pnfs_ff_layout
> defines a struct nfs_fh field. This comes from <linux/nfs.h> :
> 
> > /*
> >  * This is the kernel NFS client file handle representation
> >  */
> > #define NFS_MAXFHSIZE           128
> > struct nfs_fh {
> >         unsigned short          size;
> >         unsigned char           data[NFS_MAXFHSIZE];
> > };
> 
> But NFSD has an equivalent struct, knfsd_fh.
> 
> To reduce cross-subsystem header dependencies, avoid using a struct
> defined by the kernel's NFS client implementation in NFSD's flexfile
> layout implementation.

linux/nfs.h appears to be mostly generic-nfs stuff, rather than being
client specific.
If this change allowed us to remove "#include <linux/nfs.h>" from nfsd
code, then it would be a good change, but I don't see that it does.

Now that "struct knfsd_fh" doesn't encode info about the fh format that
knfsd uses, would it instead make sense to discard it and use "struct
nfs_fh" throughout NFSD?

Thanks,
NeilBrown

