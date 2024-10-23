Return-Path: <linux-nfs+bounces-7374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F19ABBB3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 04:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75653B21C1B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0212F399;
	Wed, 23 Oct 2024 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PuTsPf8q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P90JoHdN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PuTsPf8q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P90JoHdN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102E12E1CD
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651367; cv=none; b=p9rB3Je8OLq96jWRRyGDc8ciACwAuO2rL8kvX+EWUBTIdUYkH+9Fwcr+X9gplTZ/EOVl20cjz5NEAr6TyrxekVWaNluN71jKGaFJMyKVfIAkYb+nrmtFfL0RUv2OQD13QL7DFiJNeI0kLcluj7ShoY9y47RMTDYGWg+GBYsBQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651367; c=relaxed/simple;
	bh=nvzG3uU3GPOIiO054wHoYH+ug0mAfEa1xx8dIQDCL/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKb8tAoXdvKMF7tnmwFr2GzBwZU56g+kKoiXxZA59WAWiYulkmUhtXok0uHhnFd0vCTlgnvuuSgGaG0st9UYKqfO9xLg+bVSpA/GHKQUF+ZeBOR0QwQzjOirwFcoFQTNuiiSMbQq8cTQZrkI0GoW28WfvIzTYn/bckNCSSHE8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PuTsPf8q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P90JoHdN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PuTsPf8q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P90JoHdN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0B1B21DB6;
	Wed, 23 Oct 2024 02:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=//cRCbyHneAdVzmfoFjxkBchaavRxHksIfG9vBMULCQ=;
	b=PuTsPf8qEgm7oIa+6t+HLNLhVhNUeBBWlVIV1/vED/T9ajhrDjhqKPysTqhjOI4G5ppvjp
	nmPVm+/Gel4atkVzqvPVFFMfC+vu3l3I/gfQLJqYF6ZRAjGDuKzmewLk7fIBHongOmS/OF
	PX/TJAZ48a/uxyjuF/69KNeH1DTumWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=//cRCbyHneAdVzmfoFjxkBchaavRxHksIfG9vBMULCQ=;
	b=P90JoHdNXRb+UUO4RNJp5ks9cdwXW+4oCSnzepnmby/Qz1o1AfXs3ThC9ujpVBIOhdHUei
	hAZtBO5aOsOnCeCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=//cRCbyHneAdVzmfoFjxkBchaavRxHksIfG9vBMULCQ=;
	b=PuTsPf8qEgm7oIa+6t+HLNLhVhNUeBBWlVIV1/vED/T9ajhrDjhqKPysTqhjOI4G5ppvjp
	nmPVm+/Gel4atkVzqvPVFFMfC+vu3l3I/gfQLJqYF6ZRAjGDuKzmewLk7fIBHongOmS/OF
	PX/TJAZ48a/uxyjuF/69KNeH1DTumWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=//cRCbyHneAdVzmfoFjxkBchaavRxHksIfG9vBMULCQ=;
	b=P90JoHdNXRb+UUO4RNJp5ks9cdwXW+4oCSnzepnmby/Qz1o1AfXs3ThC9ujpVBIOhdHUei
	hAZtBO5aOsOnCeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EFA413A63;
	Wed, 23 Oct 2024 02:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5XKZEKFiGGcVOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 02:42:41 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6] prepare for dynamic server thread management
Date: Wed, 23 Oct 2024 13:37:00 +1100
Message-ID: <20241023024222.691745-1-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

These patches prepare the way for demand-based adjustment of the number
of server threads.  They primarily remove some places there the
configured thread count is used to configure other things.

With these in place only two more patches are needed to have demand
based thread count.  The details of how to configure this need to be
discussed to ensure we have considered all perspectives, and I would
rather than happen in the context of two patches, not in the context of
8.  So I'm sending these first in the hope that will land with minimal
fuss.  Once they do land I'll send the remainder (which you have already
seen) and will look forward to a fruitful discussion.

Thanks,
NeilBrown

 [PATCH 1/6] SUNRPC: move nrthreads counting to start/stop threads.
 [PATCH 2/6] nfsd: return hard failure for OP_SETCLIENTID when there
 [PATCH 3/6] nfs: dynamically adjust per-client DRC slot limits.
 [PATCH 4/6] nfsd: don't use sv_nrthreads in connection limiting
 [PATCH 5/6] sunrpc: remove all connection limit configuration
 [PATCH 6/6] sunrpc: introduce possibility that requested number of

