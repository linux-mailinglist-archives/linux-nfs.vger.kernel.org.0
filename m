Return-Path: <linux-nfs+bounces-11796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680BABB4BC
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 08:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B656175E8E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D761FFC48;
	Mon, 19 May 2025 06:02:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF51E8322
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634569; cv=none; b=AEbGJ4JQW+yug49530mrbRNh8aHEmgfYsHtl8eh6vDkNAibzduoZyfSsdRyXkZiV9Vd0RczpBLZv+9BXoMHLZhSzNOoDk08mtlnTVlw2cuM0Y5KQOb1VeqZxCerx1ZuOiHTbvG2YAd59IbeRZxR+RxEHumDak0P0/nE3q/ekV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634569; c=relaxed/simple;
	bh=aXrKeCC5XgTdkC6oyLDBsmVy/G2epXNyv/ywFt7pJYw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cfIAw4Xhjltfh7+z7fqnD6L7vUHxY1UAdIfEYaTmjUGuCB12TiMusuit6OBBLPngvrz/5z7JZIZr7X/XzvbcK1aAoYBGlJReT1sBELKrJX5/CrvxQG+rVhInL0X8CRRIvVBFIOyc1YXNdzszXgxZsq/SStID7nIbFOrEfVDrJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uGtaF-0068ig-R7;
	Mon, 19 May 2025 06:02:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 "Tom Haynes" <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
References: <>, <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
Date: Mon, 19 May 2025 16:02:43 +1000
Message-id: <174763456358.62796.11640858259978429069@noble.neil.brown.name>

On Fri, 16 May 2025, Chuck Lever wrote:
> 
> Fair enough. We'll focus on improving the man page text for now.
> 

Has anyone volunteered to do that?

Here are some words that might be useful.  I haven't tried to structure
them to fit well into the man page.
---------------
sec=sys (also known as AUTH_SYS) is only safe to specify for clients
that are connected to the server by a secure network - either physically
secure such as in a locked room, or cryptographically secure such as
with a VPN where the client hardware is also secure (locked cage or
secure-boot etc).

When such physical and/or crypto security is in place sec=sys can
safely be used and there is an extra configuration option available in
a choice between the "secure" and "insecure" export options.  

"insecure" means that all software running in the client node is fully
trusted to only access files on the NFS exports that it is expected to
access.  In this case the server will accept connections from any TCP
port on the client (and messages from any UDP port) - as they can
equally be trusted.

"secure" means that the clients are Unix-like systems and that only
"admin" software such as the kernel and administrative software running
as "root" can be trusted to access files appropriately.  All other
software, which includes all user-space software running with a UID
other than zero, should be treated with caution and not given direct
access to the NFS server.  In this case the server will reject
connections from TCP ports on the client with numbers not less than 1024
(and UDP messages from ports not less than 1024) as such connections an
messages may be from an untrusted process.  Note that on Unix-like
systems only privileged processes can send from ports below 1024.

The "secure" option is enabled by default as it is least likely to give
away undesired access.  Note that the names of the options do not
clearly match the descriptions given.

-------------

I haven't added anything about mtls as I couldn't find out how nfsd
interprets the identity presented in the client-side certificate.  If
the identity is a "machine identity" then sec=sys would make sense on
that connection.  If the identity is for a specific user and can map to
a uid, the all_squash,anon=UID should be imposed on that connection.

Can you point me to any documentation about how the client certificate
is interpreted by nfsd?

Thanks,
NeilBrown

