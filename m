Return-Path: <linux-nfs+bounces-6410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE44976B18
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E071B1F221BF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD61A2C2B;
	Thu, 12 Sep 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KloGC5Od"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A714F6C
	for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148946; cv=none; b=j2DxV0QKNtgb/701dlykJAfwf+0QglZwE28QqOuSoG/Yj1GqLiEiNPpyKwPyr2q4ipDcQ/HxcpJ4ropzhJf5HMjG35ngQUJz1x1FaJ6vVEIuP8z4AClwtLMmy49J+52J2JoZ7J9yBnwM6MHZu2fBWojUyuS/ohJ2wMovFrWVBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148946; c=relaxed/simple;
	bh=3CA68YRDnGhsnsIp0UvkkHe8iLytqhs+8FHgfGh0mGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O70NwplSPPlwIUX4TwjnOTdDLQStXocT2pk8YtFPGWmOovel5qH0ZX8bgR0qWqjZDrJli3tB7kNIq1kN5Xw0UZkKgjDGrCGkMCqWtDO5OkycO6FcKPBrT/A4eKm04PpIXvoyYG8e9/QhU92CYejjpfostrBFcTRdX8TxkumMRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KloGC5Od; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=r6G8KXVb3X+Sv2qIQJt6BFsXFp23s4aQvuB2ckq/zXE=; b=KloGC5Od4EMiA+n4
	0XqpjPk54PrD7/N5RtUmWC7nrQO2lIINsH3/AAAPDda6NzEQu9qLhCEHz1Kx0YIFRXedGH8wWb0Td
	vVDxseJXFZYopRSn68Nw5cGoFdb0l8GlJnyEjVAgaCr/e+WyuRJC0HRZ3R5cXihWZqSj9h5eRi6YT
	axSvQjQyNTn8TTuCzESVpxVfS5+rIw8WASfzg8wbqWLSVIfbKi9QOaJldS5ewprUxucEJk6q4OvJ5
	2OdTAKSqnoKGi/UT7fbZZSwbYANzlb3KgzlbrnubkYLvc9hxOL2WwL8dDgyQxd9TiXY+CyWPo3sun
	EQY6J90tg3Y7wQoBLA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1soja7-005K4c-1N;
	Thu, 12 Sep 2024 13:09:55 +0000
Date: Thu, 12 Sep 2024 13:09:55 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: xprt_iter_get_xprt deadcode?
Message-ID: <ZuLoIy0xiqFKsns1@gallifrey>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:05:01 up 127 days, 19 min,  1 user,  load average: 0.14, 0.04,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Trond,
  A deadcode hunting script of mine noticed xprt_iter_get_xprt
is unused; from what I can tell, it's never been used since you added
it back in 2015.  Is it their just for symmetry or would it be right
to deadcode it out (in which case I'd be happy to send a patch).

Added in 80b14d5e61ca6d08e
  SUNRPC: Add a structure to track multiple transports
 include/linux/sunrpc/xprtmultipath.h
 net/sunrpc/xprtmultipath.c

Thanks in advance,

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

