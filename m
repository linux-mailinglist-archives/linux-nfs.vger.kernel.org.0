Return-Path: <linux-nfs+bounces-16463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80920C65B41
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 19:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 541774E7C9F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 18:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC431355E;
	Mon, 17 Nov 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9UIsivh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D289277007;
	Mon, 17 Nov 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403897; cv=none; b=WmwyaQGr6Kq3U0kHiyfjN26xnZD8JWnF7x0CvNau+QEs00PN2LR9xmu16/Ot1snFjfI4tQkNRy2BhxTVBHWfW3TIMpdEzvrdtbqY7SREWbN+dJpGmKv/OzN+rUynm7zdjH7aRnzp9Nl4nLsC5SNEldRKmh7kCTnDGB+vrygTI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403897; c=relaxed/simple;
	bh=sGdb5Ph6gYj0wOONNOMfKIzqQuKqMH+cIsCHJyi9HjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DMNzT03wQbvC7NqcgQ2eXxNb/uHvuisO97OPvvYPbqcQlRac0nCXlGbGbPAXzjkrtXNRvZZDkJSAZAF1y+BwwkU58dONa8y/WQJUOp4cySAnofnfDcC4bpBYPsa8K0lE26xlTU271LR/61Jjl224uH/jJvzxzYe78qGPDOOD54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9UIsivh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B338C19424;
	Mon, 17 Nov 2025 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763403897;
	bh=sGdb5Ph6gYj0wOONNOMfKIzqQuKqMH+cIsCHJyi9HjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H9UIsivh5GFYr3OcajAk01NkBUFtVjurcC+H6F6mc9olIq4wy6shuBpY6G/CJzG2q
	 sHBZcZvE+rF/6KErT9/Mrv7dsgTz5EpaNvkxfg6Oiy5ctcI9sM33CSWikjbpRTjSaU
	 7pUwT4Us1MTIPDGQlBAMBlQCkXcuO51BD8tzFYTY/32QGiRorH8oZuAn7mVA5mLCoC
	 6GMmRP8RTvIovTI6No7w16Ve4u6rJt9sxD5vPFOfA8FAwZw/tPJefge4/ysqHfBwxS
	 ni292r1hr4x7Tgx9iP/JOKPu/b8qr3jphpqAcQop+rbP0Sth1kowMoSk/fjhLU72uP
	 buk+DQl9JqVYQ==
Message-ID: <3fa28515be621f91f237d323ff4b97430e73b032.camel@kernel.org>
Subject: Re: [PATCH] NFS: ensure nfs_safe_remove() atomic nlink drop
From: Trond Myklebust <trondmy@kernel.org>
To: Aiden Lambert <alambert48@gatech.edu>, anna@kernel.org, 
	chuck.lever@oracle.org, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 13:24:54 -0500
In-Reply-To: <qqu6ndrq6ytkt7rfe7hw62iu34fkt6eckixjgx7bkhqgvzvcm6@h4tj3bkvvidi>
References: 
	<qqu6ndrq6ytkt7rfe7hw62iu34fkt6eckixjgx7bkhqgvzvcm6@h4tj3bkvvidi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 13:03 -0500, Aiden Lambert wrote:
> A race condition occurs when both unlink() and link() are running
> concurrently on the same inode, and the nlink count from the nfs
> server
> received in link()->nfs_do_access() clobbers the nlink count of the
> inode in nfs_safe_remove() after the "remove" RPC is made to the
> server
> but before we decrement the link count. If the nlink value from
> nfs_do_access() reflects the decremented nlink of the "remove" RPC, a
> double decrement occurs, which can lead to the dropping of the client
> side inode, causing the link call to return ENOENT. To fix this, we
> record an expected nlink value before the "remove" RPC and compare it
> with the value afterwards---if these two are the same, the drop is
> performed. Note that this does not take into account nlink values
> that
> are a result of multi-client (un)link operations as these are not
> guaranteed to be atomic by the NFS spec.


Why do we end up running nfs_do_access() at all in the above test? That
sounds like a bug. We shouldn't ever need to validate if we can create
or delete things using ACCESS. That just ends up producing an
unnecessary TOCTOU race.


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

