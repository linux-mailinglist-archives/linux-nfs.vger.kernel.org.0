Return-Path: <linux-nfs+bounces-11225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5638A9845D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95094188DA20
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26361E376E;
	Wed, 23 Apr 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Uzz7GPoi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out.smtpout.orange.fr (out-65.smtpout.orange.fr [193.252.22.65])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0961B393C
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398538; cv=none; b=Cq56AM56qKwS8sG+rCCDnmrXmtEwdsLm7IY0LsQ5SAAVVxxY5w9RdRj1+ebyFA//z4u/Dxq5jXM0ZjO0IcQKRl7z7cMfdbnQ+sHUe2uMgnuL3B+mRjAH0OFDJhaHGN1fqZmRConljkhjzHxdj5Yhd9SNTThc82HJ3VopOtcmtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398538; c=relaxed/simple;
	bh=NZY2HCK+b0RAMqe/GJeLihh4UUMTMP/Mif3ulA7/+Qg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GFi8URHOc9ZGQZecJtjCZEHk9HcNyMDgq6C04ZwidNuz/RssQ2JCCt7I1GsOOa34H7hBx02UrygFNTgOmkIERFGY3HnB2pyQMv6ndpse+kMEgdehAQBwl1fCk+Ug8gcQq5AMy8kQIMsJ2UsarkdhUhSyZhJuBm9Zw//c+do1w6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Uzz7GPoi; arc=none smtp.client-ip=193.252.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7VjtuyLmf3t2y7Vk3uFq7f; Wed, 23 Apr 2025 10:46:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745397987;
	bh=LJMK1T0tHKtcaB9cVlvcBu+F2zSDgZdRSZtdzAWfjU4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=Uzz7GPoizMpBRbWiPXV12DpGwpp6sB37ZNSH5Iz7gwj5N/W995Fw7X4B37MwpuMgt
	 4KnfHJ/0uOdA3PaDlj2YobZmBK4Ab7BwcjwYi00xGsrpTled/ItHedbRfBnpxWwo8o
	 qskeAe5/FPzTb4VTIhZY1Kv/qOQIclUDFqz/h6wb61/AWaVvYKTIoWk10ECjUZ2IIo
	 4WEwOZKt4434luB3vJqYosoAQ+MDIDASaGLfzv7eHuWV8eElhu+4iVmVUECjFJQnBz
	 RaFhP6RU19ryGBTOc1LWWYoE+KyjblfJzJdDJTOgOM2AAqcVu5xcxoypjo0smjgpoP
	 AC7m8777qmVXg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Apr 2025 10:46:27 +0200
X-ME-IP: 124.33.176.97
Message-ID: <8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr>
Date: Wed, 23 Apr 2025 17:45:52 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: NeilBrown <neilb@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <> <20250422220200.otabh5q7efh63rjh@pali>
 <174536837419.500591.6789771877874461689@noble.neil.brown.name>
Content-Language: en-US
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <174536837419.500591.6789771877874461689@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2025 at 09:32, NeilBrown wrote:
> On Wed, 23 Apr 2025, Pali Rohár wrote:
>> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
>>> On Wed, 23 Apr 2025, Pali Rohár wrote:

(...)

>>> Actually I do object to this fix (though I've been busy and hadn't had
>>> much change to look at it properly).
>>> The fix is ugly.  At the very least it should be wrapping in an 
>>>    #if  GCC_VERSION  < whatever

I acknowledge that the fix is a bit ugly, but Mike is the only one who
has proposed a solution so far.

One other solution would be to directly modify the rcupdate helpers. I
am not sure of rcupdate's internals, but as far as I understand, in C,
attributes or qualifier can be either before or after the type. For
example,

  const char *

is the same as

  char const *

The only thing which matters is to have the qualifier or the attribute
before the * (otherwise, it will apply to the pointed value and not to
the pointer itself).

Below patch solves the build problem:

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -522,29 +522,29 @@ static inline bool lockdep_assert_rcu_helper(bool c)

#define __rcu_access_pointer(p, local, space) \
({ \
-       typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
+       typeof(p) local = (__force typeof(p))READ_ONCE(p); \
        rcu_check_sparse(p, space); \
-       ((typeof(*p) __force __kernel *)(local)); \
+       (__force __kernel typeof(p))(local); \
})
#define __rcu_dereference_check(p, local, c, space) \
({ \
        /* Dependency order vs. p above. */ \
-       typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
+       typeof(p) local = (__force typeof(p))READ_ONCE(p); \
        RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
        rcu_check_sparse(p, space); \
-       ((typeof(*p) __force __kernel *)(local)); \
+       (__force __kernel typeof(p))(local);    \
})
#define __rcu_dereference_protected(p, local, c, space) \
({ \
        RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
        rcu_check_sparse(p, space); \
-       ((typeof(*p) __force __kernel *)(p)); \
+       (__force __kernel typeof(p))(p); \
})
#define __rcu_dereference_raw(p, local) \
({ \
        /* Dependency order vs. p above. */ \
        typeof(p) local = READ_ONCE(p); \
-       ((typeof(*p) __force __kernel *)(local)); \
+       (__force __kernel typeof(p))(local); \
})
#define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))

---

Does the above make more sense? If so, I can formalize it and submit
it.


Yours sincerely,
Vincent Mailhol

