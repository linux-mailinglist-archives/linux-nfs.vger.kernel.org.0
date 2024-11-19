Return-Path: <linux-nfs+bounces-8097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2F9D1CC6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449AF1F21C8C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DA22067;
	Tue, 19 Nov 2024 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UIoPmkve";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AejGQVa1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LYdqiXNj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QyeQT7oX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76D1F941
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977385; cv=none; b=L2aDlUg7c0tbc6sS8QMCSs3Y/mf2enJbGmTA7FV81Wyv9uy6Zn26X2uprws3KxEpRMQJuxnVDDWFiiyqrEZxoVADKI7V9Zw6Et67l83gBXIwee/dupJNcN/cjUv2m58NuNpgB6n3+1+VScWxvU4WiM2A2mfEcORKaY63C7hmkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977385; c=relaxed/simple;
	bh=9ztYrp/Z/F7bAM5xw3hXou1jXm20twfg3ZbTcPcuRrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ix8gqoSUd9ssuALo03ORfXVsXzTGXU+4vuqza9IYHItT1J/ZjAEzXkFbUOXoA69Em8xJIsXOoxH45v3+isYIiXznspkES5jSzmECjxd9m4d5tXUx3k+RQPZi+3jP0YCZboADa78eEiBKRfnu/ren6KMgDSSARV4JxAkDlw6CE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UIoPmkve; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AejGQVa1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LYdqiXNj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QyeQT7oX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E22AD1F365;
	Tue, 19 Nov 2024 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=K5yIs+Lu/OSYGa1fKi38zZvlq894PZc4Rmuz8jT4EU4=;
	b=UIoPmkveOxnn1VHX9E4vlwkeqfunIJXbpyzL/8C94ga9i180TrrKLtN26zRpFkx2pMkVRv
	0Kfvj3cIGmZsjOP+3ROEy4bBHMBnJ2a9Pawh9VyXMMwHA/jx6TMgMyXwo+6+BRO7sjBCLJ
	GTZYvEDirMKgTs08s9NDdLPvZ2Gw7WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=K5yIs+Lu/OSYGa1fKi38zZvlq894PZc4Rmuz8jT4EU4=;
	b=AejGQVa1/B67H5q5XWOQhwtKb7aVCcqfqJtjGMD4sZZVaFHD/7JnIv0PyJodEkK9OkX6w0
	pk8P5IWd3Yiz6gCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LYdqiXNj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QyeQT7oX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=K5yIs+Lu/OSYGa1fKi38zZvlq894PZc4Rmuz8jT4EU4=;
	b=LYdqiXNj+dFypyufcQuLZOa8VH6iHw3hp27tIGExvJ2vAsmCAvFrQ6n8fLODMDb5idzxRi
	SPHVcJU84Az2A7qQhmJ2Nw01Yejnp/kWUPqBMdzvuAu/0TFVonktpeIGxQEenIOp9bjoJD
	rC36tDXjvQU55Y9uSAVeWzDqXmhJ/O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=K5yIs+Lu/OSYGa1fKi38zZvlq894PZc4Rmuz8jT4EU4=;
	b=QyeQT7oXrYdaOaVcIuAxrUeUXLCOeTCV1M+vhjNx+KO3qiYOLX9pboKP0WLZ6SOo5mYTBx
	gJQIFrbJJOfS/hBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA7EB1376E;
	Tue, 19 Nov 2024 00:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2NXKI6PgO2eQJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 00:49:39 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6 RFC v2] nfsd: allocate/free session-based DRC slots on demand
Date: Tue, 19 Nov 2024 11:41:27 +1100
Message-ID: <20241119004928.3245873-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E22AD1F365
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Here is v2 of my series for on-demand allocation and freeing of session DRC slots.

- Now uses an xarray to store slots, and the limit is raised to 2048
- delays retiring a slot until the client has confirmed that it isn't
  using it as described in RFC:

      The replier SHOULD retain the slots it wants to retire until the
      requester sends a request with a highest_slotid less than or equal
      to the replier's new enforced highest_slotid.

- When a retired slot is used, allow the seqid to be the next in sequence
  as required by the RFC:

         Each time a slot is reused, the request MUST specify a sequence
         ID that is one greater than that of the previous request on the
         slot.

  or "1" as (arguably) allowed by the RFC:

         The first time a slot is used, the requester MUST specify a
         sequence ID of one

- current slot allocation is now reported in /proc/fs/nfsd/clients/*/info

This has been tested with highly aggressive shrinker settings:
	nfsd_slot_shrinker->seeks = 0;
	nfsd_slot_shrinker->batch = 2;

and with periodic "echo 3 > drop_caches".  The slot count drops as
expected and then increases again.

NeilBrown



