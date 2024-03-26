Return-Path: <linux-nfs+bounces-2475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF788C05C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD13B24766
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B55134A8;
	Tue, 26 Mar 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Biz92rJO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638C537FF
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451730; cv=none; b=J/XamDk6lEXxkKfeKcvMMrcqXdZ8mJx5kR+j8D/llD7ec2Q3V+DVF/rRuPDwAWQboME9HnOSa0NSa+8D1J7zBvGe0x5yMB4KVJUU+llOjgbf/IpL4bLH5pk07MXlmawc4ocYlyI7/inSw4pfojjp7C5DMI+fCmV4aKhuGxMOcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451730; c=relaxed/simple;
	bh=Uofz0RF1ZsT7pk+lsM50pNT0a5TEzjL9ouSKPcKLoBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvbXc+YibtkKpOXUMUVooqS/Py4hjVe1iCSFgO1t0d7PgvEkUF/hQggfOc6mhsyXrKmNiH6U42ZxUC1rXP+hiyaQlTfWw9LdGXK25ztUvoYe7KoYrbR4JemroOPoH681OuBRbPHWjgUc9cyA63s4Ke6p7PbH4Je1F7MzD+mbR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Biz92rJO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711451727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRPt++S5xK11+wYGewJQ9YRwtXrDqUlhG/4nmVdt/BI=;
	b=Biz92rJOTdO67hn3HqaxiDl32XUNpkoRdFRRLIDC8CcgOWdTYMZSxDYdJtpmSwUOCisEEc
	IYKd6BKOoGD1MOPKVZ+jJAhXMLIwZweKjmiwZ/y+zd0dBgs8tAtI1agCxjZEGd7mN5fIGb
	braphe31TZ3QGyOP6qgT81rpQuwpGVk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-WtZC27OANr2MHfYJhQFQnQ-1; Tue,
 26 Mar 2024 07:15:23 -0400
X-MC-Unique: WtZC27OANr2MHfYJhQFQnQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 652F23C0008C;
	Tue, 26 Mar 2024 11:15:23 +0000 (UTC)
Received: from [100.115.132.116] (unknown [10.22.50.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B677C492BD3;
	Tue, 26 Mar 2024 11:15:21 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jan Schunk <scpcom@gmx.de>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Date: Tue, 26 Mar 2024 07:15:16 -0400
Message-ID: <F594EBB2-5F92-40A9-86FB-CFD58E9CE516@redhat.com>
In-Reply-To: <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 25 Mar 2024, at 16:11, Chuck Lever III wrote:

>> On Mar 25, 2024, at 3:55=E2=80=AFPM, Jan Schunk <scpcom@gmx.de> wrote:=

>>
>> The VM is now running 20 hours with 512MB RAM, no desktop, without the=
 "noatime" mount option and without the "async" export option.
>>
>> Currently there is no issue, but the memory usage is still contantly g=
rowing. It may just take longer before something happens.
>>
>> top - 00:49:49 up 3 min,  1 user,  load average: 0,21, 0,19, 0,09
>> Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
>> %CPU(s):  0,2 us,  0,3 sy,  0,0 ni, 99,5 id,  0,0 wa,  0,0 hi,  0,0 si=
,  0,0 st
>> MiB Spch:    467,0 total,    302,3 free,     89,3 used,     88,1 buff/=
cache
>> MiB Swap:    975,0 total,    975,0 free,      0,0 used.    377,7 avail=
 Spch
>>
>> top - 15:05:39 up 14:19,  1 user,  load average: 1,87, 1,72, 1,65
>> Tasks: 104 total,   1 running, 103 sleeping,   0 stopped,   0 zombie
>> %CPU(s):  0,2 us,  4,9 sy,  0,0 ni, 53,3 id, 39,0 wa,  0,0 hi,  2,6 si=
,  0,0 st
>> MiB Spch:    467,0 total,     21,2 free,    147,1 used,    310,9 buff/=
cache
>> MiB Swap:    975,0 total,    952,9 free,     22,1 used.    319,9 avail=
 Spch
>>
>> top - 20:48:16 up 20:01,  1 user,  load average: 5,02, 2,72, 2,08
>> Tasks: 104 total,   5 running,  99 sleeping,   0 stopped,   0 zombie
>> %CPU(s):  0,2 us, 46,4 sy,  0,0 ni, 11,9 id,  2,3 wa,  0,0 hi, 39,2 si=
,  0,0 st
>> MiB Spch:    467,0 total,     16,9 free,    190,8 used,    271,6 buff/=
cache
>> MiB Swap:    975,0 total,    952,9 free,     22,1 used.    276,2 avail=
 Spch
>
> I don't see anything in your original memory dump that
> might account for this. But I'm at a loss because I'm
> a kernel developer, not a support guy -- I don't have
> any tools or expertise that can troubleshoot a system
> without rebuilding a kernel with instrumentation. My
> first instinct is to tell you to bisect between v6.3
> and v6.4, or at least enable kmemleak, but I'm guessing
> you don't build your own kernels.
>
> My only recourse at this point would be to try to
> reproduce it myself, but unfortunately I've just
> upgraded my whole lab to Fedora 39, and there's a grub
> bug that prevents booting any custom-built kernel
> on my hardware.
>
> So I'm stuck until I can nail that down. Anyone else
> care to help out?

Sure - I can throw some stuff..

Can we dig into which memory slabs might be growing?  Something like:

watch -d "cat /proc/slabinfo | grep nfsd"

=2E. for a bit might show what is growing.

Then use a systemtap script like the one below to trace the allocations -=
 use:

stap -v --all-modules kmem_alloc.stp <slab_name>

Ben


8<---------------------------- save as kmem_alloc.stp -------------------=
---------

# This script displays the number of given slab allocations and the backt=
races leading up to it.

global slab =3D @1
global stats, stacks
probe kernel.function("kmem_cache_alloc") {
        if (kernel_string($s->name) =3D=3D slab) {
                stats[execname()] <<< 1
                stacks[execname(),kernel_string($s->name),backtrace()] <<=
< 1
        }
}
# Exit after 10 seconds
# probe timer.ms(10000) { exit () }
probe end {
        printf("Number of %s slab allocations by process\n", slab)
        foreach ([exec] in stats) {
                printf("%s:\t%d\n",exec,@count(stats[exec]))
        }
        printf("\nBacktrace of processes when allocating\n")
        foreach ([proc,cache,bt] in stacks) {
                printf("Exec: %s Name: %s  Count: %d\n",proc,cache,@count=
(stacks[proc,cache,bt]))
                print_stack(bt)
                printf("\n-----------------------------------------------=
--------\n\n")
        }
}


