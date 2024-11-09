Return-Path: <linux-nfs+bounces-7820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7989C2C6C
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 13:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88EA282F02
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF73188704;
	Sat,  9 Nov 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mi83kdju"
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E1171066
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153755; cv=none; b=s4quUbjcInb8WXtE9IClu0JO6AA3+yiwMicSXabIYxXbvBAh9QHgb6ttlsX9sjj7UqpyHPstx0cs2digckcoj4a86Mstiu4floENhtrrVQp7sOuHYM17Tt7cT0+QKDm8Y2M5RVBLWb4PQEQM8zC9pzF6KXhDqffJ1jCjOAG0Ow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153755; c=relaxed/simple;
	bh=+08JvFNeEsK5PmW58qIM7105T4UsvFE17eF7xR1RALw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFcG5NnJSYlwJutnN6QK22GdRkqlYMWVtxzEvF/9We2Y6nEyZEDDKMUDMve7mBjeArK6dPG8YWqKr/4/JtB/mt3Ys3G0q9t8U3a4h4Z3v+JWS1LhrV3oCh2/8ankLaq4aAOdiddSwuEJQYY7pikmTGUD4YVBoUsyQQjLophkcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mi83kdju; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A9C2QTQ021141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 Nov 2024 07:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731153748; bh=JvM0XHBkVVM/umaSi0Ow4veRrWWW9z1pzmC6b2z3ZTM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mi83kdjuChn2EFhOJYsz5QmthqwqR2enQ2St8ukR53APiUt/seyfISfTZleeeXRY3
	 8/oNNFQJ6kGoBh8TpGt7snQF55fAhYZ/awa/WfQ9qeFs7DbOFW2arUkd+MduBKkBEa
	 jvh4bUO5u1Ds48z4KWtHQMFyJksf8YmHU0pA9qrn1jajsW2qpkw2NngvZoDjuSx2ab
	 YXYZbiUA5IliBbFfooI5RfIzPnd6tpbxuS7oeRCgWegT5R5O1S2onZRDH/Tjuq2rig
	 G8dIWK5ZxpBAzP4Xe3X/JcahpjWvAT0AMtn1ImDY2aW73139SG1tl1BCOSMMnEKUCY
	 aQeFk67rbddcQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id C534B340242; Sat, 09 Nov 2024 07:01:18 -0500 (EST)
Date: Sat, 9 Nov 2024 07:01:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Kernel strscpy() should be renamed to kstrscpy() Re: [PATCH]
 nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
Message-ID: <20241109120118.GA1805018@mit.edu>
References: <20241106024952.494718-1-danielyangkang@gmail.com>
 <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com>
 <283409A8-6FD1-461C-8490-0E81B266EF9D@redhat.com>
 <CAHnbEGKRKrw-9_wnrASVHniZ1RggP+b-YzvwPYM7ScsMvmpCGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHnbEGKRKrw-9_wnrASVHniZ1RggP+b-YzvwPYM7ScsMvmpCGA@mail.gmail.com>

On Sat, Nov 09, 2024 at 12:11:02PM +0100, Sebastian Feld wrote:
> > > How should the "bounds checking" work in this case if you only pass
> > > two arguments ?
> >
> > The linux kernel strscpy() checks the sizeof the destination.
> 
> Then the kernel strscpy() should be renamed accordingly, and not
> confuse people. Suggested name would be kstrscpy().
> Otherwise this would disqualify strscpy() ever from being adopted as a
> POSIX standard, as there are two - kernel and glibc - conflicting
> implementations

If POSIX decided that this meant they couldn't adopt strscpy(), that
is ANSI / ISO's problem, not ours.  Note that strscpy() supports the 3
argument version of glibc, and POSIX has always been willing to
standardize a subset of a particullar interface.

Otherwise, any Legacy Unix system which added some one or more flags
to some particular interface could potentially disqualify anything
with the same name of that interface from ever being standardized,
which is (a) stupid, and (b) not what has been done in historical
practice.

					- Ted


