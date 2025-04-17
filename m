Return-Path: <linux-nfs+bounces-11160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0B1A91FBF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714CC7A13C4
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762742505A6;
	Thu, 17 Apr 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpm/3+E/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506C24E4D4
	for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900396; cv=none; b=A7U+nn2KFB+BJhBSsbneLnJ99zqTW3gpmHNRvzVf3E3fuRst3FZ9D2WfLgpnpwxS3a1I9t5cuhLRH/lGLGPvYIyVu4ZjZyn4985trWyh1OdG8eZRmkEMXWrvsbTW//4VqsWUFpKCxynXl096229hhx2xyRM/mx3IYbG5yeHW3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900396; c=relaxed/simple;
	bh=60s4VG2YGjmPd6a2cRVXyHIaC74XFtD/tILp7Uj1mAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBcMwb+Gdi0jJRQ+INq90NJBaWlbGruk2UUSXfINX0TzPcsNvzhAkJwRbQv1HToBAefSZR7ooV6szwW8Bskav9rLmqPsLTyXOY6LXFaFovEZL9Kx8/XGSAdC5Pko0IfnvDDo2t8yFHUqYTtmKzFtvZ7C4bZvJPG0aifnHM5txGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gpm/3+E/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744900393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5SyqVSW7mQ0+m66/f9vlqr7TNBkZHO1u13I9yrERdA=;
	b=Gpm/3+E/C/dv2UWTA4BkGH+y33se2LszgTQjk+q7jZfzxe9Mfsf4BhyHe6bMNUZTnR6T6q
	AKMKHwkmvyhN89m02XaqajBCMYJItDNdCjrn6vu2dC0KWe1wDFDSn7L32KQHfbV4VOdkaO
	D8Bsf/72/Glx3DMSadjNv2rj7o0hkcs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-mJXoYDoUPOynhcWfZlYz2g-1; Thu,
 17 Apr 2025 10:33:10 -0400
X-MC-Unique: mJXoYDoUPOynhcWfZlYz2g-1
X-Mimecast-MFC-AGG-ID: mJXoYDoUPOynhcWfZlYz2g_1744900389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB3A2180056F;
	Thu, 17 Apr 2025 14:33:08 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E80DF19560A3;
	Thu, 17 Apr 2025 14:33:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Wanted: more fixups for client delegations test/free walk
Date: Thu, 17 Apr 2025 10:33:05 -0400
Message-ID: <2CD51D9C-D481-463B-851D-195B10C1F1CD@redhat.com>
In-Reply-To: <387a5701d884538aa36a35d186d03f3e4123ffbc.camel@kernel.org>
References: <9146009C-5726-400D-8571-504F5B36C651@redhat.com>
 <387a5701d884538aa36a35d186d03f3e4123ffbc.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 17 Apr 2025, at 9:59, Trond Myklebust wrote:

> On Thu, 2025-04-17 at 09:28 -0400, Benjamin Coddington wrote:
>> Hey Trond, Anna, et al.
>>
>> I'm looking at working on nfs_server_reap_expired_delegations() because
>> the work to walk that list is order n(n+1)/2  and the list can grow very
>> large due to some servers doing SEQ4_STATUS_ADMIN_STATE_REVOKED these
>> days.  It can currently grow unlimited by 5k delegation watermark.
>
> Why would we be seeing an increase of SEQ4_STATUS_ADMIN_STATE_REVOKED
> cases? That should normally just be seen on network outages that last
> longer than a full lease period.

No idea - but its happening.  Maybe I've been too hasty to blame
ADMIN_STATE_REVOKED, but we do see in the results many
NFS_DELEGATION_REVOKED states. Perhaps the linux server's admin revocation
interfaces are gaining popular use for some reason.

>> First observation is that we don't remove revoked states from the list
>> even after doing FREE_STATEID, so we're still doing walks across
>> delegation state we'll never use again.  I think we can fix this by
>> plumbing in the error result from FREE_STATEID.. so that's a potential
>> bit of work.
>>
>> I'm tempted to just do:
>>
>> @@ -1342,7 +1346,7 @@ nfs_delegation_test_free_expired(struct inode
>> *inode,
>>                 return;
>>         status = ops->test_and_free_expired(server, stateid, cred);
>>         if (status == -NFS4ERR_EXPIRED || status == -
>> NFS4ERR_BAD_STATEID)
>> -               nfs_remove_bad_delegation(inode, stateid);
>> +               nfs_delegation_mark_returned(inode, stateid);
>>  }
>>
>> .. but I think that gets us up to not tracking state the server might
>> still be tracking.
>
> Just marking the delegation as being returned isn't helpful. That
> doesn't trigger any action to recover the state.

That's the only path to removing the delegation from the nfs_server's
delegations list, and seems to do all the right steps for this case.. but
calling it here can't currently account for cases where FREE_STATEID wasn't
successful.

>>
>> Other approaches might be to walk the list once moving the work to a
>> temporary list and then operate on that linearly.
>>
>> Advice, thoughts, or direction welcomed..  I'll probably work on
>> splitting out nfs41_free_stateid() from test_and_free_expired(), so the
>> delegation code can know for sure that we're done with that state.
>
> Setting up a separate list for state that needs recovery of some sort
> might be useful. However that doesn't solve the problem that you have
> to scan the entire list of stateids every time the server sets
> SEQ4_STATUS_ADMIN_STATE_REVOKED. The latter is a protocol requirement,
> which is why if we're seeing a lot of it happening, then we need to
> solve that problem first.

Well, we did have some misbehaving servers that are getting fixed, but its
still entirely possible to end up with client systems that keep old revoked
state on that list (that it has already done FREE_STATEID for), and once we
have to walk and test it things get hot.  We're seeing this on clients that
are /not/ on misbehaving servers, we've seen some clients with ~500k entries
on that list.

I'd really like a way to trim the list, thus the desire to remove state
after a successful FREE_STATEID.

Thanks very much for your look and discussion.

Ben


