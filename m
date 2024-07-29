Return-Path: <linux-nfs+bounces-5182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0394004B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1941C21B5C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADE18E748;
	Mon, 29 Jul 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bt+L8f5R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1J0TflF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bt+L8f5R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1J0TflF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258018D4CF
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288159; cv=none; b=SYSuWsRN5h2kV3onuRRIorNEZ6TAjCgLUD0smJ74C1E5/026B6HEjOzgtLgl6mi7lHaXujnNvLfv/19XAlJtXpWucgB8bopcpy/x/0qNos3rwsW2HvfQkMbiPSFQk5uSbNG0N2GIy0QWdPVTMZ7cKcgOOVUPRE0y2kvAzPV8YLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288159; c=relaxed/simple;
	bh=qybajOlxWrOWl/sPCs6fKrUrSLlA+mBOZxGYLe1lphQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ec20sa7sfyhKv0G9+6aTcxskG3v+oQ3ZcFIcKwh+BNnBwCV69cQfSDspUB8PLgM7dtayf7MgNe83m2SMtprWRd00diVZjlN48XdC+wsbyDlGOcIetyC03XUTcglZ/udJzrjK/7zKTxafRDeBXePBVYpkipG1RtiGBRDaueYaAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bt+L8f5R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1J0TflF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bt+L8f5R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1J0TflF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 474521FBDD;
	Mon, 29 Jul 2024 21:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722288155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LXavgNsazTZq0OroSkQWO1roO411bBmwEjCxfuX6Taw=;
	b=Bt+L8f5RtLcCnD4l5t6MZvdgP6HTokOb9kfS7KxkLxUccKLtoSTZ929VxvqNYtJqWmvfI9
	t2a4A7kuYD6nMbDGtX7OHFfwBsRZhJh5fj3oMuJGTd/ata3Lc9HrKJ4A9RkybP3D2ZUm/C
	0VKsXlInBE4K07W4oi0SSH4TM9r+30g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722288155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LXavgNsazTZq0OroSkQWO1roO411bBmwEjCxfuX6Taw=;
	b=t1J0TflFvMKOTGLGOdF801CZEN65EDAxcoIz0XLJwU0vFEoc/5pv1GivlKrPQaQ+FGwx1q
	DRzL4oy+6EhlNtCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722288155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LXavgNsazTZq0OroSkQWO1roO411bBmwEjCxfuX6Taw=;
	b=Bt+L8f5RtLcCnD4l5t6MZvdgP6HTokOb9kfS7KxkLxUccKLtoSTZ929VxvqNYtJqWmvfI9
	t2a4A7kuYD6nMbDGtX7OHFfwBsRZhJh5fj3oMuJGTd/ata3Lc9HrKJ4A9RkybP3D2ZUm/C
	0VKsXlInBE4K07W4oi0SSH4TM9r+30g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722288155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LXavgNsazTZq0OroSkQWO1roO411bBmwEjCxfuX6Taw=;
	b=t1J0TflFvMKOTGLGOdF801CZEN65EDAxcoIz0XLJwU0vFEoc/5pv1GivlKrPQaQ+FGwx1q
	DRzL4oy+6EhlNtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C2DF138A7;
	Mon, 29 Jul 2024 21:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xu09NBgIqGbSVwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 21:22:32 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/2 v2] nfsd: fix handling of error from unshare_fs_struct()
Date: Tue, 30 Jul 2024 07:19:40 +1000
Message-ID: <20240729212217.30747-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

This v2 applies correctly to  git/cel/linux#master.

These two patches replace my previous patch:
 [PATCH 07/14] Change unshare_fs_struct() to never fail.

I had explored ways to change kthread_create() to avoid the need for
GFP_NOFAIL and concluded that we can do everything we need in the sunrpc
layer.  So the first patch here is a simple cleanup, and the second adds
simple infrastructure for an svc thread to confirm that it has started
up and to report if it was successful in that.

Thanks,
NeilBrown

 [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
 [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly

