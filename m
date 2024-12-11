Return-Path: <linux-nfs+bounces-8523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2569ED8FC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 22:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922E7161D1E
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB481D31B5;
	Wed, 11 Dec 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CI6ojm52";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bLL+ByFR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cXErH6cQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pPwSgqDr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47281D63CA
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953742; cv=none; b=KDltqHFvU377H1O1uwpE7OP5eB8TToIhw0R7X5I4lI1Wet6ZEoQy7nocweMHjBpElO5yjefnPT7py+daX5NmhVrtzcFYcMRTN1mLAOVbw3U6MFurgawDPFwxJBn/L5IknFSFP9B4wYZcm1E9NLJ5YsVEoOtJO55qDFNtAH0/Vrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953742; c=relaxed/simple;
	bh=N8HlekF+Ivlag8UfN0NLsxvrO7uNYiPMu3+tRx9JXjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odLqUoBQHeKJvGjTzDbfjOroT3JAJ9Bdy0AwouiW5XN/Z4ompQg58dWk6WvuBYe70M9pOExvLwraURb35qi+JADyVMS7DTwVnAPe7Rk2v7WihVAezVtAsQhvhI3NBI4kuUPEEpUbPvfzU1qNE+ZcQsMEGvzD/5QqvdiDxLZKrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CI6ojm52; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bLL+ByFR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cXErH6cQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pPwSgqDr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFCD51F397;
	Wed, 11 Dec 2024 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YMHiR8/ldv5hd/VrMC3DMea3ExtUyKDBJtWSTHQThJg=;
	b=CI6ojm52dXHNk9FOfQax74stCHeMlQUaysSbB7fw04BTPRCx6hxCxDS3HnlwLV7nZs7HTu
	oECg9rUcyIQjE9pw5be0x1wOy5Sc4ZjVo0OXajzZ91CZA70bvhac6NCLAvf44KcoGV8Kny
	Re1oG4Lhdp2UDLmdD0/7J+EFmeS3gj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YMHiR8/ldv5hd/VrMC3DMea3ExtUyKDBJtWSTHQThJg=;
	b=bLL+ByFRzQ8uh32rCL711Q3NqnS85j6bLZ1c6Z2HdBm+ijTDgY89GaO2nqkrzxuK+r850L
	oS9FsRFrlOEvQqCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YMHiR8/ldv5hd/VrMC3DMea3ExtUyKDBJtWSTHQThJg=;
	b=cXErH6cQJA8pN2G7QPHFhjWSx0AgPVbsSbSYOa4rabljI3OmZnreJDlx6yAtZWhIgEcckr
	3iUddPFxYHevFXNd6jmzmPvGm/2QoUzHyZYvfK3O19DiVzml5q5lN56xY7LcKlcUkbl92M
	SFMtkXRZg43dWFYGsmLiQoY0OrDTPqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YMHiR8/ldv5hd/VrMC3DMea3ExtUyKDBJtWSTHQThJg=;
	b=pPwSgqDrbhWMSiVSjx7F8myEBC5CHpIAFXCEKEU0cvfyw7UC0oR2jaklb7PeMdWisEQUTT
	d0vEVf40Ik82FeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D35AC1344A;
	Wed, 11 Dec 2024 21:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E5CLIccIWmexMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 21:48:55 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6 v5] nfsd: allocate/free session-based DRC slots on demand
Date: Thu, 12 Dec 2024 08:47:03 +1100
Message-ID: <20241211214842.2022679-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

Differences from v4:
 - added Jeff's Reviewed-by - thanks.
 - fixed problem in final patch.  There are two places where a session can be
   detached from lists and both need to detach from the new global list.

Thanks,
NeilBrown

 [PATCH 1/6] nfsd: use an xarray to store v4.1 session slots
 [PATCH 2/6] nfsd: remove artificial limits on the session-based DRC
 [PATCH 3/6] nfsd: add session slot count to
 [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
 [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
 [PATCH 6/6] nfsd: add shrinker to reduce number of slots allocated

