Return-Path: <linux-nfs+bounces-6736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D036398AD24
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FEC281089
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E8199FBB;
	Mon, 30 Sep 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KO+OVRqz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w9vogcV/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCD199951;
	Mon, 30 Sep 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725432; cv=none; b=Z/0gk4H2fxvUZH9Ar7oJ6GgJW7YGhXShuOss65X3K8hXORteFFLCbpbi8gTOmJdOAhycMzKfFiK8mPnII9sNjDZ+8B9OskXBpWn2nVCwRXPng7a8ZA+hn8wcQ8oq2rdNiUVvSsffmQDivUWrBc4/7eUf9+s0VF0wxiQDkF3qGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725432; c=relaxed/simple;
	bh=t4hG0izCL3zEWhqKbQiOsx+nnX4mkqKUqIc2WWPZvc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XC8TGs7wPlhuqSfgHPLKqpu48Cei6VJkHG/XCtDgFUBtxE3W56ifet3hVY3YS/NcrR/o6xRwrkCyzutdCsXC8THhFTHjhk29NfvY9WIeYJYTNzZzRnRj+iDxGkqR/e10UfBhqCeugR73lID+tsIAiSsikGObwEJpHJHNJuTd1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KO+OVRqz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w9vogcV/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727725429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpO/Uf31chhDoKlO5eskAbUukIkZXG2KIl9wBiuvDPA=;
	b=KO+OVRqzVi6sUV/fyu63klu3oJiUuf9/VfwRXew8W1SVc54Wbo8HfflBVekilLpl8a/HGj
	S3maiancfOsZY9D78Aqsnk70D5yQHyImRjTj/A077kmgV28jWnuLibn+0hLTfPoo6nSEjA
	gu4ocMdykcgQiF+RvnAAxg2WB36cixVIHw5Zk6hXtfx6yk+4kSy3u0vxgPKMEwhKUUvwNi
	L4B8sKPVwSrZvQs6G94vKzPXjoMNY3FXgOHVbwi5SV3QUdilY4MAXTNoskokiCWwbHpuJs
	R5VLiGpP5y1J3/3e0dDh8M4RGrHVwnpLKpFJlSEURbH/w+18fDg4T/Rry8Dwsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727725429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpO/Uf31chhDoKlO5eskAbUukIkZXG2KIl9wBiuvDPA=;
	b=w9vogcV/yej7LJh+X7wME7l3i6splvsGWVj1rfDXK4lp/s4jDlR8KWvMmvf/qb//0jKyET
	FFo7SK4M7cJpeZDA==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
In-Reply-To: <d771ea4d44f3c9da8470d0aa9d58ee1d96f5fb30.camel@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87a5g79aag.ffs@tglx>
 <d771ea4d44f3c9da8470d0aa9d58ee1d96f5fb30.camel@kernel.org>
Date: Mon, 30 Sep 2024 21:43:49 +0200
Message-ID: <874j5x0vwq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 19 2024 at 18:50, Jeff Layton wrote:
> The fix for this is to establish a floor value for the coarse-grained
> clock. When stamping a file with a fine-grained timestamp, we update
> the floor value with the current monotonic time (using cmpxchg). Then
> later, when a coarse-grained timestamp is requested, check whether the
> floor is later than the current coarse-grained time. If it is, then the
> kernel will return the floor value (converted to realtime) instead of
> the current coarse-grained clock. That allows us to maintain the
> ordering guarantees.
>
> My original implementation of this tracked the floor value in
> fs/inode.c (also using cmpxchg), but that caused a performance
> regression, mostly due to multiple calls into the timekeeper functions
> with seqcount loops. By adding the floor to the timekeeper we can get
> that back down to 1 seqcount loop.
>
> Let me know if you have more questions about this, or suggestions about
> how to do this better. The timekeeping code is not my area of expertise
> (obviously) so I'm open to doing this a better way if there is one.

The comments I made about races and the clock_settime() inconsistency
vs. the change log aside, I don't see room for improvement there.

What worries me is the atomic_cmpxchg() under contention on large
machines, but as it is not a cmpxchg() loop it might be not completely
horrible.

Thanks,

        tglx

