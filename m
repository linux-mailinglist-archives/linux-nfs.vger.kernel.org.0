Return-Path: <linux-nfs+bounces-7058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490399A279
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF1E1F237D5
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C0B20C495;
	Fri, 11 Oct 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eFoppcVT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4A1CF291
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645037; cv=none; b=LQhpl+KxcQL0kUTBVL4HOMsoStlUNg7eChre6+rhrBQQk55kxjnZUFkYKtks5lkHA2S1VCIhRjAMx4nH9yDQUTjnX2uXatxx2HHilyLDWYFX8IrleP0i9DywU6i6nditYOJwHlxoGq61bdJwhgpRlSEd7nw098GE1UTtVYikuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645037; c=relaxed/simple;
	bh=qaoTFtDtuKvN3gsXVywkTUkR1MviKQuz8Y2Vpraq7uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blhyQc6SjsgtLe4Q8qkWOXVkAMaNxbWN7d27XPfWMe+FFMIY8aYBCLksYxwA0OoHafb6NNzIda2WzoOrhFk4tyh1JrBxRSjwEh12Zjj/TkNTjThNr2mCgjP5vEyYcfShu/tW6H8EOSrFA4NT1JLvBQ1pqnD+W0NRyFRAjbhNvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eFoppcVT; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ3nh1pq4zvRX;
	Fri, 11 Oct 2024 13:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728645032;
	bh=fLaZhNPzPWt64tLwirmcQQOFzj4xkc6GdwBhQK7+n60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFoppcVTErdptDIhM+WzvnoPQJNLqG3zF3+Kj5diqudUtFsvut7TQSc7KWs8t/TvB
	 CCmR5vnlVbxJl+KpmL4Aj+FNAUycgvJ4aQYkg0qK2Lxb7IX/FVT9SDITiSGymgRKYH
	 wCOYIZ3IPp9m6973K2nZMwiF/vER5QE0FA7k86JY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ3ng4fykzJby;
	Fri, 11 Oct 2024 13:10:31 +0200 (CEST)
Date: Fri, 11 Oct 2024 13:10:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.if2Iech3noos@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
 <a5fb2a24-d109-41fd-b00a-afe5280b6ffc@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5fb2a24-d109-41fd-b00a-afe5280b6ffc@I-love.SAKURA.ne.jp>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 07:54:58PM +0900, Tetsuo Handa wrote:
> On 2024/10/11 19:12, Tetsuo Handa wrote:
> > On 2024/10/11 0:26, Mickaël Salaün wrote:

> >> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> >> whereas the user space's view of an inode number can still be 64 bits.
> > 
> > Currently, ino_t is 32bits on 32-bit architectures, isn't it?
> > Why do you need to use 64bits on 32-bit architectures?
> 
> Changing from 32bits to 64bits for communicating with userspace programs
> breaks userspace programs using "ino_t" (or "unsigned long") for handling
> inode numbers, doesn't it? Attempt to change from %lu to %llu will not be
> acceptable unless the upper 32bits are guaranteed to be 0 on 32-bit
> architectures.
> 
> Since syslogd/auditd are not the only programs that parse kernel logs and
> audit logs, updating only syslogd/auditd is not sufficient. We must not break
> existing userspace programs, and thus we can't change the format string.

This might only break user space that wrongfully uses 32-bit variables
to store 64-bit values.  According to the UAPI, inode numbers should be
64 bits.

