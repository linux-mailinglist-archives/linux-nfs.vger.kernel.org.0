Return-Path: <linux-nfs+bounces-611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21AB813EE7
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE31F225E1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED920F5;
	Fri, 15 Dec 2023 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YC6Eugtg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jm0y0j6M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YC6Eugtg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jm0y0j6M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AD20F8
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DD0E2210C;
	Fri, 15 Dec 2023 01:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iHoblzqKoDEcs2ucYTO2xwtILePZouiP8Z0hT0FE9JI=;
	b=YC6EugtgKCQ/QpqTRKCDKEu4SR0mhzHiFieSqfolUwFRMyL3RcJO2EXrxPGQXzlX59nDev
	Z+sYFU59eWdNZeYhHRLABQWel0aWqDIBYbRDCalIxew+AcDObezSR0CoJJIAsaeLd+8wXD
	3u3YenrfH7P+WbUFT3fREbuMPFQXAhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iHoblzqKoDEcs2ucYTO2xwtILePZouiP8Z0hT0FE9JI=;
	b=Jm0y0j6Mq/FPygVn+rF06SmFZKVavmdP76BmqoZF32F/hCtMKJ74OxjICvHsb6ODBFCm5b
	5RDmA3Dz9l5EfCCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iHoblzqKoDEcs2ucYTO2xwtILePZouiP8Z0hT0FE9JI=;
	b=YC6EugtgKCQ/QpqTRKCDKEu4SR0mhzHiFieSqfolUwFRMyL3RcJO2EXrxPGQXzlX59nDev
	Z+sYFU59eWdNZeYhHRLABQWel0aWqDIBYbRDCalIxew+AcDObezSR0CoJJIAsaeLd+8wXD
	3u3YenrfH7P+WbUFT3fREbuMPFQXAhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iHoblzqKoDEcs2ucYTO2xwtILePZouiP8Z0hT0FE9JI=;
	b=Jm0y0j6Mq/FPygVn+rF06SmFZKVavmdP76BmqoZF32F/hCtMKJ74OxjICvHsb6ODBFCm5b
	5RDmA3Dz9l5EfCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E1E6137E8;
	Fri, 15 Dec 2023 01:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4aZcNT2le2WwTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:00:45 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Date: Fri, 15 Dec 2023 11:56:30 +1100
Message-ID: <20231215010030.7580-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YC6Eugtg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jm0y0j6M
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.82)[84.98%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.97)[-0.973];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.70
X-Rspamd-Queue-Id: 3DD0E2210C
X-Spam-Flag: NO

I sent an earlier version of this series, got some feed back, revised
it, but never sent it again.  Sorry.

The main feedback was around the interaction between sunrpc and nfsd for
handling poolstats.  I have changed that so that nfsd tells sunrpc where
the svc_serv pointer lives, and where to find a mutex to protect it.
sunrpc then taks the mutex and accesses the pointer - if not NULL.  I
think this is nicer than the version that pass around funciton pointers.

This series is against nfsd-next

Thanks,
NeilBrown


 [PATCH 1/5] nfsd: call nfsd_last_thread() before final nfsd_put()
 [PATCH 2/5] svc: don't hold reference for poolstats, only mutex.
 [PATCH 3/5] nfsd: hold nfsd_mutex across entire netlink operation
 [PATCH 4/5] SUNRPC: discard sv_refcnt, and svc_get/svc_put
 [PATCH 5/5] nfsd: rename nfsd_last_thread() to nfsd_destroy_serv()

