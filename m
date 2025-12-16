Return-Path: <linux-nfs+bounces-17121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B06CC557B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 23:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A934E3000B5E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25629D291;
	Tue, 16 Dec 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEYSa+GM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53424A058
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923985; cv=none; b=LunPsVipoGEdN0iokKqHlhpqaXS3rGCyxWag/8R0/HlgS/W3eVlXO6YTCPSayE0GfhmVe7kTRwGG6Vt+XsN02VvI2Mib9WHe+4UV6f/2Z+QfkPgnzA8QGBYGp7yU+07Sh6QhZp9ufOyaFmcsfah2vHueqakJ+q1FHkub2mdP5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923985; c=relaxed/simple;
	bh=mzrCRCKror/JQGyqLqRPbm2X5jgzEOlf5qQSFktaTKA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RZ9zqoxFeZXoCjCpI9bMrq3+d3hx72AZSHnvk8o7q1svhLND/7G5WuF4JUHnwJzQ/RePgZYY8e9Xhqsf35RzX/gtw9lqnm/YGuIBI7FRQInZIOa8eJoSCBKOYasD2pB0Osb8Kkm9nsGlZNMZqc3idD/oOmI7/6gXahEMlxMaGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEYSa+GM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AE0C4CEF1
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765923984;
	bh=mzrCRCKror/JQGyqLqRPbm2X5jgzEOlf5qQSFktaTKA=;
	h=Date:From:To:Subject:From;
	b=vEYSa+GMxAa9Ll2Eax47aD16+pXV1Z6SZuX7ZCXejQxIbqZS3Ta+cslLZ/TcHdGPB
	 o3tSlhlFA2+rMNYAP2LD9RyS7tIr+C8oHu5/rsLVYGbndlZolvznn44sqBnFjXiGdy
	 Rb+vHI3cDhhQjjtHbcj56f7ui8VQeGtk2OYlmzKRiwrhXEjshFzL9znksosmyNQVE6
	 EVROkMDO2a2Kz79OBynIdryh+gP5fYupENlrMxEragnuHIGi6HJr4lv1mi3fiEIxJT
	 FiU8T4qMP/kbux4vDV/HSb+UiKftu+hBh9a9ekh7l35NwXXtmQsiOpAfax89eLUF8O
	 0LtNQWzCs5I6w==
Date: Tue, 16 Dec 2025 17:26:23 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: xdr_stream interface oddities with pages vs stream
Message-ID: <aUHcjxer3GmVcBwG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've been working on enhancing the NFS client and server such that
nfs4_{set,set}acl utilities to set/get 4.0 ACLs will work when NFSD
v4.1 is reexporting NFS v4.2.  Its soul sucking, but that aside...

In my journey I'm finding that xdr_stream_decode_u32() followed by
xdr_stream_subsegment() doesn't continue from the point where
xdr_stream_decode_u32() advanced xdr_stream's ->p

xdr_stream_subsegment() doesn't appear in any way interlocked with the
pages offset (->p), it starts with xdr_stream_pos() but  ends with
advancing ->p.  So xdr_stream_subsegment() does what it should, I'm
concerned about interfaces like xdr_stream_decode_u32() not advancing
xdr->nwords

Shouldn't both the xdr->p and xdr->nwords be interlocked?  SO that
xdr_stream_subsegment() continues from the point where
xdr_stream_decode_u32() advanced the stream?

Could this possibly be a regression due to more recent scratch buffer
changes?

Anyway.. I'm stabbing/fishing here and hoping someone else knows how
things _should_ work.

Thanks,
Mike

ps. I can expound on what I'm seeing, I just don't want to bury people
right out of the gate ;)


