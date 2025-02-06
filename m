Return-Path: <linux-nfs+bounces-9891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72075A29E41
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 02:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2173A11FB
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E41C68F;
	Thu,  6 Feb 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BFcK0FMO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GDXU5ftS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0vBvXXB8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mdu34yvH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283B10F2;
	Thu,  6 Feb 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804187; cv=none; b=b3Qdh+yj0nC0/EwiuXk79WCSc67Hy/uquXef/B4/L8CwT/rNHv3K0sJMted9VhdFlUB2MZFV9EmMhrPiPzetJjmeVHndssnLEmaQ3ufg6u6CXpfakbMkjdZ0o/NZNbjdnScJ6fPLwOsV/u22jfVszfppQ5zGk/owaV+AdZ3eHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804187; c=relaxed/simple;
	bh=2W7xGAvwEKREc2mmCCyJDKIVOQ00sNgjnc36dfk/5gc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=n1ScImbVdWCkllAdYGDF4DGWz1Fi6ReMwjAoR6bei8Yg3Cb8wxGRHg67WRod/BSC7JMdjhl0ZdPpu+Qxov3i5xF5g6vPmho+MplbMHm/GmfcKZ4DOF63iie/pJHDfqJOu7R7dfxuxB/KKIo0KyoGXz0y3ycX1rh83OrYDmY4ANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BFcK0FMO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GDXU5ftS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0vBvXXB8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mdu34yvH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB27C21114;
	Thu,  6 Feb 2025 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738804183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/K7GM68i/5RNp4Wq0Hmnk5pC72IEeShaFSY6FGnYRJE=;
	b=BFcK0FMOsbYhJG6H4W7Vea0FTOXYdhreyz11HQNYnY8RMlwuk6zSUKt0/kvSpD+kre6OiT
	IpPx6hl+waB/jehnjgtoVmX4XPpv9c5Y87jPRunDHpCMumISM00ZYSG0qCj82RLMLUyhu0
	kUGhHBsqtLaUrkdqPOIfjxlTInNkUTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738804183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/K7GM68i/5RNp4Wq0Hmnk5pC72IEeShaFSY6FGnYRJE=;
	b=GDXU5ftSX/hFDi5ovK4v774DaWqUo/Eem6iOGqFUsbRa65E638mZAWNJbs6rU+l5UAsBNW
	kiJ3X7zbtMkW81Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0vBvXXB8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mdu34yvH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738804182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/K7GM68i/5RNp4Wq0Hmnk5pC72IEeShaFSY6FGnYRJE=;
	b=0vBvXXB8l8ojhhPdg3vzTFJ+RqF9Twes2GvLF90YMDITiqpqzROjlv6B1GkpXyph4/cnJ2
	EKeD2X61Wqf/XzuJTvZ0C5t5HQ246RypdLh4WxxNXd21r+dzNNMMQIV2FUZwRuISWfTL1b
	MzC00Nk7+ZyeNGkP3e0nTQgRAiu1nMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738804182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/K7GM68i/5RNp4Wq0Hmnk5pC72IEeShaFSY6FGnYRJE=;
	b=Mdu34yvHtk8lDFOURScQjl4t5C9PUtPCpDi88STNmNpwkVWtoqs8wsJCx6glY74u0MQb5k
	qz4CZzk86PjYULAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48C7113694;
	Thu,  6 Feb 2025 01:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqqeOtELpGeJQgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 01:09:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Li Lingfeng" <lilingfeng3@huawei.com>, jlayton@kernel.org,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@hammerspace.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject:
 Re: [PATCH 1/2] nfsd: map the ELOOP to nfserr_symlink to avoid warning
In-reply-to: <8a05743a-5da9-46d1-bd89-c56cdc38fcdc@oracle.com>
References: <>, <8a05743a-5da9-46d1-bd89-c56cdc38fcdc@oracle.com>
Date: Thu, 06 Feb 2025 12:09:29 +1100
Message-id: <173880416944.22054.14559337357110702284@noble.neil.brown.name>
X-Rspamd-Queue-Id: EB27C21114
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, 06 Feb 2025, Chuck Lever wrote:
> 
> It's kind of interesting that there hasn't been a need to add an ELOOP
> mapping to nfserrno() until now. I'm a little hesitant to add a generic
> mapping without checking the thousand other places nfserrno() is called,
> but that might end up being a necessary part of this fix.


This ELOOP error is surprising on a local filesystem.  It means that the
lookup of the given name found an inode for a directory which already
existed in the dcache as an ancestor of the directory being listed - or
possibly as the directory itself.  For ext4, that means a corrupt
filesystem.

If the exported filesystem was NFS, then I think it is credible that a
complex race could result in this.

So we certainly need to handle ELOOP cleanly but we don't need to try
too hard to find a perfect solution.  Returning nfserr_io would be
defensible.  Nothing else really suits, certainly not NFS4ERR_SYMLINK
because there is no symlink involved here.

NeilBrown

