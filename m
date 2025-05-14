Return-Path: <linux-nfs+bounces-11726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35638AB7827
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 23:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561C93BC40C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 21:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051720298D;
	Wed, 14 May 2025 21:47:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606F1F09AD
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259234; cv=none; b=sjlRx0OGLdujyBSYnoj61rBj8WtQLFqoRi16lO5xryiENXche8ppiVTU+47uKkGA083ATd90riaSW/5QkoULg7uO476zZPuX/yGVQmI6urjt2v9gE2hJvP2QD3rJhbfkXBldUCL2zlJNjt+aAp8ntOCb4LvRqFvh2bJfZgQtZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259234; c=relaxed/simple;
	bh=IBmhz/ND6sq2JmPOSOVXaJSVZyOMswgFlNjaift9qFw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OY5HdkVxj3J3r99YD9oZ+h4EP8S+4JQsoMQ1TuVTEcP033ls91s8ZoNwv5Wg9bj1VupQYj6xZQow1+wXRC+8uFyHec2GoTQNWjNAk88xEEGbHgQOSNJq4YHlhO+2FXT0euPZXNr0yk9XU/JuxYA/863l2V3ouxGUd0flR33VPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uFJwR-0048n7-Q9;
	Wed, 14 May 2025 21:47:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <9a75be59-fd60-4183-8853-f7fe541c4f14@oracle.com>
References: <>, <9a75be59-fd60-4183-8853-f7fe541c4f14@oracle.com>
Date: Thu, 15 May 2025 07:47:07 +1000
Message-id: <174725922736.62796.10035875212639959992@noble.neil.brown.name>

On Wed, 14 May 2025, Chuck Lever wrote:
> On 5/14/25 7:43 AM, NeilBrown wrote:
> > On Wed, 14 May 2025, Jeff Layton wrote:
> >> On Wed, 2025-05-14 at 12:28 +1000, NeilBrown wrote:
>=20
> >> True. Anyone relying on this "protection" is fooling themselves though.
> >=20
> > As above: in some circumstances with physically secure networks
> > (entirely in a locked room, or entire in a virtualisation host, or a
> > VPN) it makes perfect sense.
>=20
> On a physically secure network where all the hosts are also known to be
> secure, source port checking is wholly superfluous. It makes no sense
> there.

No, that is the only place that it makes sense.

If you have a secure network of secure machines running a secure
configuration of secure software managed by secure administrators, then
you can trust that a low port number comes from secure software and,
in particular, that the UID in the AUTH_SYS credential is reliable.

If you don't have that security, then you cannot trust the port number
or the uid and should not be accepting AUTH_SYS at all.

If you *Do* have that security, then we can discuss if the "secure" or
"insecure" flag is appropriate.  If you know that all processes running
on all nodes in the network are secure, and will only do what the admins
let them do, then there is no need for "secure" with its restrictions,
and "insecure" is perfectly fine.  However if you allow lower-privileged
processes - maybe you have a login server, or you let people upload their
own cgi scripts to the web server - then "secure" is important to ensure
users only access file that their uid has access to.

>=20
>=20
> >>>> I don't see any really motivation for this change.  Could you provide =
it
> >>>> please?
> >>>
> >>> Or to put it another way: who benefits?
> >>>
> >>
> >> Anyone running NFS clients behind NAT?
> >=20
> > Maybe that should have been in the commit message?
>=20
> Agreed, the commit message should have more beef (sorry, vegetarians).
>=20
> The commit message should also mention that NFS clients frequently
> exhaust their privileged source port range, causing new mount
> operations to fail sporadically. This is a well-documented problem
> and the main reason we started moving Kerberized mounts to ephemeral
> ports.
>=20
> Generally that's a situation that is sticky for a couple of minutes
> while TCP sockets proceed through TIME_WAIT until the source port can
> be re-used by another connection.
>=20
>=20
> >> The main discussion came about when we were testing against a
> >> hammerspace deployment. They were using knfsd as their DS's, and had
> >> forgotten to add "insecure" to the export options. When the (NAT'ed)
> >> client tried to talk to the DS's, it got back NFSERR3_PERM because of
> >> this. It took a little while to ascertain the cause.
> >=20
> > "Change default to fix configuration problem"....???
> > The default must always be the more secure.  "fail safe".
>=20
> Sure, but this option, although it's name is "secure", offers very
> little real security. So we are actively promoting a mythological level
> of security here, and that is a Bad Thing (tm).

"very little" is not zero.  "mythological" is unfair.  There is real
security is certain specific situations.


NeilBrown

