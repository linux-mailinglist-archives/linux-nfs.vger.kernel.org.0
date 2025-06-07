Return-Path: <linux-nfs+bounces-12180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E846BAD105D
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jun 2025 00:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12DA16D123
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jun 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA91F4CB8;
	Sat,  7 Jun 2025 22:42:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEA1D5CEA
	for <linux-nfs@vger.kernel.org>; Sat,  7 Jun 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749336135; cv=none; b=CNopXvUkEwsVfo3z0nG+y97ZlYPcvcze7yePnVuSZfVkwalPjjSE9K3UlFDU74Tdr3Kpmnnw2M0ZJFj9NVVLJk587QcKB5hZ3I33VQvfrUK5sszYVhdpWtSH8EDyHlfv2yqXbdo3Fm3e/2jZaTrBGRWZoeIg4nCGvxP7FJRVYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749336135; c=relaxed/simple;
	bh=UICUz5YX72r/XkIsMj4aX1ErXA7hv+ZrwCsoAHGsB8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFsHgrZ9pFXjLgzGdr1CqCqRrc1L2zq63T+NM++eWkKczOnqRPXTrwz8H71ygQMN2Y4ddSuYeVuwf7nIRDI1Kmxp5XoiS7rZecMaF0KpfVD0DzRbiRFg5gMQUd8qfga2sg/LAv9RbYZzdXjQ9rViYyv8rPKjI7ylnNfwX7ZAgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-37-19-198-134.datapacket.com [37.19.198.134] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 557MdraD014364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 7 Jun 2025 18:39:55 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7B116346B89; Sat, 07 Jun 2025 18:39:51 -0400 (EDT)
Date: Sat, 7 Jun 2025 22:39:51 +0000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
Message-ID: <20250607223951.GB784455@mit.edu>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>

On Sat, Jun 07, 2025 at 02:30:37PM -0400, Chuck Lever wrote:
> 
> My impression is that real case-insensitivity has been added to the
> dentry cache in support of FAT on Android devices (or something like
> that). That clears the path a bit for NFSD, but it needs to be
> researched to see if that new support is adequate for NFS to use.

Case insensitivty was added in Linux in 2019, with the primary coding
work being done by Gabriel Krisman Bertazi of Collabora, and design
work being done being done by Gabriel, Michael Halcrow, and myself.
(Michael Halcrow in particular was responsible for devising how to
make case-insensitivity work with filename encryption and indexed
directories.)

The initial file systems that had case-insensitivty implemented was
ext4 and f2fs.  The initial use cases was Android devices (which had
used this horible wrapfs stacking file system thing which was trivial
to deadlock under stress, and its original reason for existing was
bug-for-bug compatibility with FAT), and for Steam so that Windows
games could have their expected case insensitivity.  (Collabora's work
was underwritten by Steam.)

There is an interesting write-up about NFS and case-insensitivity in a
relatively recent Internet-Draft[1], dated 2025-May-16.  In this I-D,
it points out that one of the primary concerns is that if the client
caches negative lookups under one case (say, MaDNeSS), and then the
file is created using a different case (say "madness"), then the
negative dentry cache indicating that MaDNeSS does not exist needs to
be removed when "madness" is created.  I'm not sure how Linux's NFS
client handles negative dentries, since even without
case-insensitivity, a file name that previously didn't exist could
have subsequently been created by another client on a different host.
So does Linux's NFS client simply does not use negative dentries, or
does it have some kind of cache invalidation scheme when the directory
has a new mtime, or some such?

[1] https://www.ietf.org/id/draft-ietf-nfsv4-internationalization-12.html#name-handling-of-string-equivale

Anyway, case sensitivity is one of those "interesting" problems which
has caused many headaches, including a potential security issue, and a
botched attempt to fix that security issue interacting poorly with
some of the more subtle design requirements so that file systems can
use tree-indexed directory lookups, even with case-insensitivty file
names and encrypted directory entries.  So in general, unless you have
strong financial backing where someone is willing to pay $$$ to
address a business-critical use case, my personal advice is to stay
far, far, away.  And I say this as a someone (with apologies to Linus)
who was partially responsible for Linux having case insensitivty
lookups in the first place.  :-)

Cheers,

						- Ted

