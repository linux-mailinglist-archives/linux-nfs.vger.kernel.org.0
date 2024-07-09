Return-Path: <linux-nfs+bounces-4746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477892B07A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 08:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAED282D47
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB242067;
	Tue,  9 Jul 2024 06:45:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90F3C2F;
	Tue,  9 Jul 2024 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507555; cv=none; b=dNkLYIvGQSPO3T9L+ZrVt4vuwVDac5L/MpVxogluVk7u4vp9rpNsf/KNDVn+edMXnf6hxRsWrQNFEES816KAqh4/65Pw92hEo8P7krs75OOtc7rl86eLoZr5ocq305t231Zaamhe8rVV3DZbYi/pMPo31o77lLgYuFl5ZaeX1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507555; c=relaxed/simple;
	bh=1XMZCWaOwMOgvFv/A5wmGB+T7zimBDaGzI+FQllMaNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRpk59mT9pg2Mo9Mg4wLnMWJDAsGngb8EjFb4CaYWi39/Hz7QxEg3JN43UhMW82BHYKgVIApKDq7hOtVnmChWXvJ6mpOuhuOx5H+akm1dcwdYdH9dLjgAwWyVKuNWResvGiCe00jPKXB+Fg0df5pdi66cO9kbqH9CStuV0tlVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 049B21F79B;
	Tue,  9 Jul 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E06FB1369A;
	Tue,  9 Jul 2024 06:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJDzNZ/cjGZzCAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 09 Jul 2024 06:45:51 +0000
Date: Tue, 9 Jul 2024 08:48:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Greg KH <greg@kroah.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Sherry Yang <sherry.yang@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <ZozdQCwODOyO73U_@rei>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
 <2024070638-shale-avalanche-1b51@gregkh>
 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
 <2024070814-very-vitamins-7021@gregkh>
 <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 049B21F79B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi!
> There is a change in behavior in the upstream code, but Josef's
> patches fix an information leak and make the statistics more
> sensible in container environments. I'm not certain that
> should be considered a regression, but confess I don't know
> the regression rules to this fine a degree of detail.
> 
> If it is indeed a regression, how can we go about retaining
> both behaviors (selectable by Kconfig or perhaps administrative
> UI)?

That is IMHO the worst solution, every userspace tool would have to be
able to work with both formats for an undefinite amount of time and the
only added value of this approach would be a Kconfig option to enable
information leak...

-- 
Cyril Hrubis
chrubis@suse.cz

