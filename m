Return-Path: <linux-nfs+bounces-4591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE892632B
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6271C22A99
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0785A1854;
	Wed,  3 Jul 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wW3mNrVJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5C1DA31C;
	Wed,  3 Jul 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016132; cv=none; b=uqBlWEyMRbhdT7AB7dIyKjHhkW6csPwOOAXfoT3n+cas91BWKm2m21JnRXChjvEam1Gba7mf4y/98GPZ0kvVWLQwfgy62c9bQwOZ2SFVdL3KWhtnr52g5eCPsw+WzFujRtspD9EUz/qxdpQqrvdoot2tEZkrCPmJfszwrjCW0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016132; c=relaxed/simple;
	bh=soRTbom2IOqvM/6OPbQMNP+KtYHyJrE0TwApPCmTQPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLdfw/BGdA5Ymqzmm2FaYbqshFTeOYha+9eaQQ+m9k8qZVi8xC7+l1k5Vsl0pjgiAZ0ENMiLq6M4i+L+zP3NQRh2htd5+muVxASlWLJxyVwgHuAX8mKygeNNGmnwTnfyZmsQ0TnC4obWh7x+I6mUI2ipgEMHnH6O/oHbDKorzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wW3mNrVJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RffxOHUYeum2zBSAH5k7oIuRrPsD/arCb7IA0ItyE5s=; b=wW3mNrVJ2SVApYGvGZphNGzKMq
	ZezEDKyLDxutx0H7h3NFm0Z6glo7UGcvrfP4TqGnb0hfkm5MAVrTgd8+iSr4JT2TQaNFXwHpp7DsM
	oHqJ0uxN0Cm37yKvGcu9QqPj+e6BYnL2OJtgs91YbAaHidFl85AFnTBw+NRyee3BajKQGOKmhTGOP
	ffk/KAhpHYDZF3nU7/1i4u3u71jwZRQG4SlCA+ppLvhz/Te3iBL+AxjfgsUwM1IoTK+qHWMAnDxbM
	0hDooS6l/2Ewjhe+OQffFvP/KdOE7qTgZO9nNyMj2RLAfNItq2Ff+MjpVK9rCdEPVwK2Pk3LggrzZ
	K+omcvRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0lc-0000000ARFT-12hS;
	Wed, 03 Jul 2024 14:15:28 +0000
Date: Wed, 3 Jul 2024 07:15:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Mike Snitzer <snitzer@kernel.org>, linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoVdAPusEMugHBl8@infradead.org>
References: <>
 <ZoI0dKgc8oRoKKUn@infradead.org>
 <172000614061.16071.4185403871079452726@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172000614061.16071.4185403871079452726@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 09:29:00PM +1000, NeilBrown wrote:
> I know nothing of this stance.  Do you have a reference?

No particular one.

> I have put a modest amount of work into ensure NFS to a server on the
> same machine works and last I checked it did - though I'm more
> confident of NFSv3 than NFSv4 because of the state manager thread.

How do you propagate the NOFS flag (and NOIO for a loop device) to
the server an the workqueues run by the server and the file system
call by it?  How do you ensure WQ_MEM_RECLAIM gets propagate to
all workqueues that could be called by the file system on the
server (the problem kicking off this discussion)?


