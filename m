Return-Path: <linux-nfs+bounces-10742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF72A6BDF9
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB74318915C3
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056E5CDF1;
	Fri, 21 Mar 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVkBsEXa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBD42A94
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569700; cv=none; b=uVTBYWL6x285H9KoPU+TI94IIg1uADVTm21kh5p5ORLeU/GCHoOuxDCDzz6x9iVZ7Tp1lEZJBELi5/VWCv5i4QgN+SPkX3SEGEqVCx5HufAMW2brV3RD4Qz7hqHciKV55T/teRlpe8SuC7UfFJ89mQM075coQDFBv7e+gFm4tyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569700; c=relaxed/simple;
	bh=7f/OcM8plze+EQBWh6CRYHbgMmaK6vNbTbljSn/GU/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLH2KPFwu5hnIJCESnQYD6qXsoS6xyfSW6Jr88yg7ck1UQEcYArd48Xev0TnYlL61T+nB6OHUZxzr6LyDvZFwreI6iRgmWFKJIadn/okW8npvDV6ssOkwA/dUUFMIms5MujjdYt8HMsNSkJ+XHu5pPFveidfDBVSYAJcEuJXDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVkBsEXa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742569698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a2Hv4fZozHUx2NbIujGdTCdxB+sKjK+Lx8tNUbo+fk0=;
	b=AVkBsEXafA566h3VV1tgfu8oTm+sA5xn5dxLFDY6POFFJFTEnK0Jrt5V/8ESmAlcOMCQBe
	tGPIpdZghUO/erMr5rMQ4K8sbwl6/uODVj2iDzi7CWshD+vLJmJteZXyGvCNz7yf0w3Wir
	TAns5iSYV6rtEUa/LrczcjIUm5Yav+I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-E7dFF67rOLCc8hFgYk2tXA-1; Fri,
 21 Mar 2025 11:08:14 -0400
X-MC-Unique: E7dFF67rOLCc8hFgYk2tXA-1
X-Mimecast-MFC-AGG-ID: E7dFF67rOLCc8hFgYk2tXA_1742569693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D29C180AF68;
	Fri, 21 Mar 2025 15:08:13 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE434195609D;
	Fri, 21 Mar 2025 15:08:11 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>,
 Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
 Tom Talpey <tom@talpey.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
Date: Fri, 21 Mar 2025 11:07:26 -0400
Message-ID: <5ACD599A-44FA-41B0-AFDB-B8D352044387@redhat.com>
In-Reply-To: <4afafdfd5f7148cf8c9e0c9a65946726f29719e5.camel@kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
 <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
 <0895A981-76C0-41A0-B474-62659480B31F@redhat.com>
 <4afafdfd5f7148cf8c9e0c9a65946726f29719e5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 21 Mar 2025, at 10:43, Jeff Layton wrote:

> On Fri, 2025-03-21 at 10:36 -0400, Benjamin Coddington wrote:
>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
>>
>>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>>> Hi,
>>>>>
>>>>> Currently when the local file system needs to be unmounted for maintenance
>>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>>> on the NFS shares before the umount(8) can succeed.
>>>>
>>>> This is easily achieved with
>>>>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>>
>>>> Do this after unexporting and before unmounting.
>>>
>>> Seems like administrators would expect that a filesystem can be
>>> unmounted immediately after unexporting it. Should "exportfs" be changed
>>> to handle this extra step under the covers? Doesn't seem like it would
>>> be hard to do, and I can't think of a use case where it would be
>>> harmful.
>>
>> No. I think that admins don't expect to lose all their NFS client's state if
>> they're managing the exports.  That would be a really big and invisible change
>> to existing behavior.
>>
>
> If we're unexporting the filesystem though, then ISTM like we ought to
> cancel any state that was held on it. Are you concerned the admin
> inadvertently unexporting something or is there another use-case you're
> worried about?

I'm worried about changing existing behavior and the fallout, today I can
un-export and re-export all day long, and as long as I re-export the
filesystem the applications on those clients are unaffected.

I'm an old sysadmin that knows that I can un-export and re-export stuff and
not have to worry about state loss.  There have to be existing systems and
people that also have that knowledge built in by now.  If we change this, we
break things.

Ben


