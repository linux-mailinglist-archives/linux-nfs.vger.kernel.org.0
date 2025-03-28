Return-Path: <linux-nfs+bounces-10933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF0A741A7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 01:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5044D3AA837
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792636B;
	Fri, 28 Mar 2025 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jwurCCos";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bWpUQ4dq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jwurCCos";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bWpUQ4dq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0F23AD
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743120484; cv=none; b=JRAOEJ2MenWzsEGApKWaW3c2GipPLNzkSktb7b6zhtctObcnIvUTZXREtZvUiDN30dw2h1fDRaQveYQWIApEMDngXb4ANEbfKmxTmjsKvIXAPkHDYPH4I8Ti7KOFjvcex6iwDL31KNNGUFRVyxR+nJixH5Ih5VslQlt6QL7xTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743120484; c=relaxed/simple;
	bh=3Bz+BViAAT9qL27+DxOqhquBs9fPKRjrbbw7gMa8+yw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GCeX01bESL4BWK+Q4YrxJ0/cbAy7rCkRq9kia4+fgqMf7qVPfkXlvHs5j3Bm4xmmeUYeVtD/vQv7kBy+OYSlnBVqB94CwIgfYvrAHBqypRl8abtnaXbDJe8bPNzOtvx1W3L+X97yKXOo24neDgHxr/fVV1D3aO8NDQQL0vxvcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jwurCCos; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bWpUQ4dq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jwurCCos; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bWpUQ4dq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 279A71F388;
	Fri, 28 Mar 2025 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743120480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjnM0VqrBMrgQ0Y0a0SVmkjIvJPyYUGYEEPe8LVunNE=;
	b=jwurCCosV7Jydr1xQg0BOdwcFdt1R93Inn17uTZsCmBvGWf/PQLoEywsCB/eKDRwwdP1H1
	8nMSGUaVvVity+c/h8y8DNVSjEozvxxk4D/i15dSzbimmu3CahXSqMD6/Ij0UffKRXwCwD
	BXNB1aMHcSeZOZaJfktNKoU6imgUxcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743120480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjnM0VqrBMrgQ0Y0a0SVmkjIvJPyYUGYEEPe8LVunNE=;
	b=bWpUQ4dqTo2KZNAyl3ULo4S0GX3NmrfV7uca2Ma/1Ulz3iXqDGrffN9N6TtTXTZKjP9fb/
	24xPhA4kGAoE9dCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jwurCCos;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bWpUQ4dq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743120480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjnM0VqrBMrgQ0Y0a0SVmkjIvJPyYUGYEEPe8LVunNE=;
	b=jwurCCosV7Jydr1xQg0BOdwcFdt1R93Inn17uTZsCmBvGWf/PQLoEywsCB/eKDRwwdP1H1
	8nMSGUaVvVity+c/h8y8DNVSjEozvxxk4D/i15dSzbimmu3CahXSqMD6/Ij0UffKRXwCwD
	BXNB1aMHcSeZOZaJfktNKoU6imgUxcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743120480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjnM0VqrBMrgQ0Y0a0SVmkjIvJPyYUGYEEPe8LVunNE=;
	b=bWpUQ4dqTo2KZNAyl3ULo4S0GX3NmrfV7uca2Ma/1Ulz3iXqDGrffN9N6TtTXTZKjP9fb/
	24xPhA4kGAoE9dCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14731139D4;
	Fri, 28 Mar 2025 00:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a6L9Ll3o5WfEAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 28 Mar 2025 00:07:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 Dai.Ngo@oracle.com, tom@talpey.com, "Olga Kornievskaia" <okorniev@redhat.com>
Subject: Re: [PATCH 0/3] access checking fixes for NLM under security policies
In-reply-to: <20250322001306.41666-1-okorniev@redhat.com>
References: <20250322001306.41666-1-okorniev@redhat.com>
Date: Fri, 28 Mar 2025 11:07:54 +1100
Message-id: <174312047480.9342.7103250290767163738@noble.neil.brown.name>
X-Rspamd-Queue-Id: 279A71F388
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> for export policies with "sec=krb5:..." or "xprtsec=tls:.." NLM
> locking calls on v3 mounts fail. And for "sec=krb5" NLM calls it
> also leads to out-of-bounds reference while in check_nfsd_access().
> 
> This patch series address 3 problems.
> 
> The first patch addresses a problem related to a TLS export
> policy. NLM call dont come over TLS and thus dont pass the
> TLS checks in check_nfsd_access() leading to access being
> denied. Instead rely on may_bypass_gss to indicate NLM and
> allow access checking to continue.
> 
> The other 2 patches are for problems related to sec=krb5.
> The 2nd patch is because previously for NLM check_nfsd_access()
> was never called and thus nfsd4_spo_must_allow() function wasn't
> called. After the patch, this lead to NLM call which has no
> compound state structure created trying to dereference it.
> This patch instead moves the call to after may_bypass_gss
> check which implies NLM and would return there and would
> never get to calling nfsd4_spo_must_allow().
> 
> The last patch is fixing what "access" content is being passed
> into the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
> explicitly set access to be read/ownership. And after is passes
> access that's set in nlm_fopen but it's lacking read access.
> 
> Olga Kornievskaia (3):
>   nfsd: fix access checking for NLM under XPRTSEC policies
I agree with this patch
  Reviewed-by: NeilBrown <neil@brown.name>

>   nfsd: adjust nfsd4_spo_must_allow checking order
I don't disagree with this patch but I don't think it is the best fix.
I've posted an alternate fix.  It would be OK for both to go in.

>   nfsd: reset access mask for NLM calls in nfsd_permission
I don't like this one.  I've explained why separately.

Thanks,
NeilBrown


> 
>  fs/nfsd/export.c | 20 ++++++++++----------
>  fs/nfsd/vfs.c    |  7 +++++++
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> -- 
> 2.47.1
> 
> 
> 


