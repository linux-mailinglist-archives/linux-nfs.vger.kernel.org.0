Return-Path: <linux-nfs+bounces-10584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C4A5EFA6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14E73A7EF7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9025FA0D;
	Thu, 13 Mar 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="IZFKLLTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E2261398
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858641; cv=none; b=W4p2x0NFKBTDNl3W9KPiqfaUmWQqGXeFdm4j28WlgPnbbSKbvuxsKFW4HqqPKIwf5lOCm2htVu9VqL0f0zTRxVNIv0IAj6ti1FdsKVNmUIKWdI6MqdDaMqWIYmG6Tswr63o6ByBQITdCvDVZu1noJH6iwYpkPy/lb1WYIsw6Ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858641; c=relaxed/simple;
	bh=Z13DCO38+QX43QF2WPXnMbPBpetoaFwAWSdVXTEkLMc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ppwvu+UOEYE6I0JtLhlXU37dKuHA7NO5CFWsGNKPs3OLj+I+lDN9VjOvL7r8qkLh0kbW2pIJ6ye0bYDO15xiyYI8epAl+CEM7NXgf66+s7MimfMVZb32HSeZBx4HfKvwTYzyT68IGu3Tpn8L7Vk5Q1EfiEy1Bzab8rlkOJQuO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=IZFKLLTE; arc=none smtp.client-ip=62.201.172.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout01.mail.de (Postfix) with ESMTP id C6EE2241006;
	Thu, 13 Mar 2025 10:37:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1741858637;
	bh=Z13DCO38+QX43QF2WPXnMbPBpetoaFwAWSdVXTEkLMc=;
	h=Message-ID:Date:From:Subject:To:From:To:CC:Subject:Reply-To;
	b=IZFKLLTEzV6G5EC+gmeB22t8qE1kxuxZ27r67atNy0HhAjRGkzpXPLqACBydVrorL
	 tw9K5mxro7Lq/cry1puSaViQGC+/fp1Mzx8N60eZRzNSuc7uUiTzOrnJy4tKURJOMn
	 xXjSGHQ3hFU4QBz8oaZpliySpOq/OyiOeUkEu0KOiXZWP7okC4827XjtHpKdLIbH/4
	 H8yyjlM59SSyKpq+zSzycpL9QxjeGWw6xUReBW1T15n7RYWZpM61aO3Lr1MPJFXI9w
	 K0I7oIN7gGAggQjpQarnMQSQifg1OjkgE69zq+3SpSmjU+Pjvjv0n66MLCoMCbZc/g
	 eZ7j/JUjerh0g==
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
	by postfix01.mail.de (Postfix) with ESMTP id 91351240582;
	Thu, 13 Mar 2025 10:37:17 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 02370242247;
	Thu, 13 Mar 2025 10:37:15 +0100 (CET)
Message-ID: <eec1d594-7340-4f11-8ed8-844035e4cc3d@mail.de>
Date: Thu, 13 Mar 2025 10:37:14 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tycho Kirchner <tychokirchner@mail.de>
Subject: Re: Parallel shared to exclusive flock conversion blocks forever on
 single NFS client
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <d27d885e-568c-42b8-a204-2f4a3e949d64@mail.de>
 <05ce8da1909fd21c2511abf1d21536a872077324.camel@hammerspace.com>
Content-Language: en-US, de-DE
In-Reply-To: <05ce8da1909fd21c2511abf1d21536a872077324.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3798
X-purgate-ID: 154282::1741858637-667702C4-061CBC75/0/0



On 12.03.25 23:57, Trond Myklebust wrote:
> On Wed, 2025-03-12 at 22:57 +0100, Tycho Kirchner wrote:
>> Dear NFS kernel developers,
>> In `man 2 flock` it is documented, that an existing lock can be
>> converted to a new lock mode. Multiple processes on the *same* client
>> converting their LOCK_SH to LOCK_EX quickly results in a deadlock of
>> the
>> client processes. This can already be reproduced on a single physical
>> machine, with for instance the NFS server running in a VM and the
>> host
>> machine connecting to it as a client.
>>
>> Steps to reproduce:
>> - Setup a virtual machine with Virtualbox and install NFS-server
>> - Create an /etc/export: /home/VMUSER/nfs  10.0.2.2(rw,async)
>> - Create a NAT firewall rule forwarding NFS port 2049 to the VM
>> - Mount the export on the host, chdir it and create an empty file:
>>     $ sudo mount -t nfs 127.0.0.1:/home/VMUSER/nfs  /somedir
>>     $ cd /somedir
>>     $ touch foo
>> - Execute below attached ~/locktest.py in parallel on the client:
>>     $ for i in {1..10}; do ~/locktest.py foo & done; wait
>> - Wait half a minute. The command does not terminate. Ever.
>> - Abort execution with Ctrl+C and kill leftovers: pkill -f
>> locktest.py
>>
>> Notes:
>> - According to my tests, from three concurrent client-processes
>> onwards,
>> the block quickly occurs.
>> - Placing a `fcntl.flock(a, fcntl.LOCK_UN)` before fcntl.LOCK_EX is
>> enough, so the deadlock never occurs.
>> - OR'ing `| fcntl.LOCK_NB` quickly results in endless
>> »BlockingIOError«
>> exceptions with no client process making any progress. See the also
>> attached ~/locktest_NB.py.
>> - Multiple distributions, Kernelversions and combinations tested,
>> e.g.
>> NFS-client KVER 6.6.67 on Debian12 and KVER 6.12.17-amd64 on
>> DebianTesting, or KVER 6.4.0-150600.23.38-default on openSUSE Leap
>> 15.6.
>> The error was always and quickly reproducible.
>>
> 
> The same manpage also states:
> 
>         Converting a lock (shared to exclusive, or vice versa) is not guaranteed
>         to be atomic: the existing lock is first removed, and then a new lock is
>         established.  Between these two steps, a pending lock request by another
>         process may be granted, with  the  result  that  the  conversion  either
>         blocks,  or  fails  if LOCK_NB was specified.  (This is the original BSD
>         behavior, and occurs on many other implementations.)
> 
> so there is no harm in adding the LOCK_UN because you cannot expect
> atomicity.

Thanks for the response, Trond. I also read this part of the manpage, 
but fail to understand, why that would justify a deadlock-scenario using 
the commands I described. On the contrary, in my understanding, the lack 
of atomicity actually makes it feasible for an implementation, to avoid 
the deadlock. Here's how:

   Process A          Process B      comment
LOCK_SH granted   _not_started_
…                 LOCK_SH granted
LOCK_EX blocking  …                A removes SH-lock and waits for B
…                 LOCK_EX granted  granted since A removed SH-lock
…                 LOCK_UN
LOCK_EX granted


However, I think the NFS-implementation incorrectly does _not_ remove 
the initial shared lock of A. As a result, the processes deadlock in the 
following way:

   Process A          Process B      comment
LOCK_SH granted   _not_started_
…                 LOCK_SH granted
LOCK_EX blocking  …                 A keeps SH-lock and waits for B
…                 LOCK_EX blocking  B keeps SH-lock and waits for A
DEADLOCK          DEADLOCK


This deadlock is unnecessary and I think the NFS implementation of flock 
conversions(or fcntl.F_SETLK) should be fixed.
Thanks, Tycho

