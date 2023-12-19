Return-Path: <linux-nfs+bounces-704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB368180A0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Dec 2023 05:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09962284E76
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Dec 2023 04:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C428479;
	Tue, 19 Dec 2023 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2/wn127"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D68475
	for <linux-nfs@vger.kernel.org>; Tue, 19 Dec 2023 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kl27Zog8jaEvuys8g6UYmk943mgvE98EDx8AOjVKv+4=; b=n2/wn127TG3YpHhirchRtRiHYT
	4xwoPh67VMR2yTiFerHTLWsrTnffnl6lRoo9OsJD76/gnw4hR0CyW+SwNOucNUS79v76lT1P2dBU6
	9yg/EmJr0dtNEoqOOck95s0d1ul3ANJI5NaxaJwtXqzDujcMI/ln46vbWN22hODeHOGlYFVhOzcrC
	wVJunwUHb8PUCp/cfk2LoQSbhBuVLCD4HkK3n78VodZ9G3w7eIzUDFmaRF6ac+AWW/2QHN9Tq4dUP
	y+mdt54iQtl6cEwT1JIVbtN8oRmuQ/SeUmjQBJHkqjDWHErJE0kJ6SOEFHXay9A1cDufzCjqtGdQQ
	WOpRYBTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRsc-00Cons-1O;
	Tue, 19 Dec 2023 04:38:54 +0000
Date: Mon, 18 Dec 2023 20:38:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Realtime NFSv4?
Message-ID: <ZYEeXnnWu0wmZ7Rb@infradead.org>
References: <CALXu0UfJhNzETL_xFhrXYkxVSfkre836ed9nGyqyo5WxCvQ4aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0UfJhNzETL_xFhrXYkxVSfkre836ed9nGyqyo5WxCvQ4aQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 18, 2023 at 12:48:00PM +0100, Cedric Blancher wrote:
> Good morning!
> 
> How feasible would be a realtime NFSv4, which can guarantee NFSv4
> operations in a constant time manner suitable for realtime
> applications (similar to XFS realtime support)?

The XFS realtime subvoume is grossly misnamed, it does not guarantee
anything at all.  It just uses a separate, somewhat more predicatable
allocator.


