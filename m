Return-Path: <linux-nfs+bounces-11760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61612AB91E9
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 23:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C70A007AE
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757911922C4;
	Thu, 15 May 2025 21:44:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E9288C8C
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345484; cv=none; b=ruT5l5PBPkG3gBpMd6W9JNY0q7k7dc9IbYwcPO8eZ2jY3gPePrEpXUkDIjZNlmaaftsbKh7JJwiFdlgvfViFLc85RRSgosGiyYIib93RaR0glHzxlIKZzsGtPbijcyRIsKHPeq8ivojvNCxeCRP94eFojieKoXfJFdaD6Hl0tyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345484; c=relaxed/simple;
	bh=ROmVPdyXoOo+3T38DfFQOJ/oaVuUqBFy66n4MIlhBNM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=m+zjgo5KOI7tOPpDqLD/1AGZKqVRTsPWTkn7JG0GB+pmoNFMi6HBeAe45Bc7O0hn6s7XQUClrWmbRNLRbDlerShkPvkcbhoIGkbIMRhtn75htp6hryormrPFMl9LZlQVrCLNS7jznrTVNdwvp969P0csdDDjNi6rxzOq8O/Rs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uFgNU-004vgK-9z;
	Thu, 15 May 2025 21:44:32 +0000
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
In-reply-to: <500d0c27-c332-41b3-803d-488b8f5ca92c@oracle.com>
References: <>, <500d0c27-c332-41b3-803d-488b8f5ca92c@oracle.com>
Date: Fri, 16 May 2025 07:44:32 +1000
Message-id: <174734547202.62796.2038898324999110968@noble.neil.brown.name>

On Thu, 15 May 2025, Chuck Lever wrote:
> On 5/14/25 5:47 PM, NeilBrown wrote:
> > On Wed, 14 May 2025, Chuck Lever wrote:
> >>
> >> Sure, but this option, although it's name is "secure", offers very
> >> little real security. So we are actively promoting a mythological level
> >> of security here, and that is a Bad Thing (tm).
> > 
> > "very little" is not zero.  "mythological" is unfair.  There is real
> > security is certain specific situations.
> 
> We can argue about "mythological", but it is totally fair to say that
> calling this mechanism "secure", and its inverse "insecure" is an
> overreach and a gross misrepresentation. It is relevant only for
> AUTH_UNIX and only then when there are other active forms of security
> in place.
> 
> So I think our fundamental point is that the balance has changed. These
> days, in most situations, source port checking is not relevant and is
> actively inconvenient for many common usage scenarios.
> 
> Before changing the default behavior of NFSD, we can survey other common
> network storage protocol implementations (iSCSI, NVMe, SMB) to see if
> those protocols also use this form of authorizing access.

I don't think it is relevant what other protocols do.  If we were adding
a new feature, then examining the state of the art would make sense, but
that is not what is happening here.

It might make sense to remove AUTH_SYS support in the same way that
rlogin and rsh have effectively been removed and replaced by ssh.  It
would never have made sense to change rlogind to stop checking the
source port of the TCP connection (and would never have made sense for
sshd to check it).

I cannot ever see any justification for changing defaults to make a
service less secure.

> 
> In the meantime, do you object to moving forward with the other two
> suggestions I made:
> 
>  - Updating the description of the "secure" export option in exports(5)
> 
>  - Adding a warning to exportfs when an export has neither "secure" or
>    "insecure" set and allows access via sec=sys ?

Those two sound like very sensible changes.

Thanks,
NeilBrown

