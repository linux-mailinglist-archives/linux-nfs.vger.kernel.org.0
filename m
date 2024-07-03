Return-Path: <linux-nfs+bounces-4611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF549926A5E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 23:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7298E2864B4
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F571191F84;
	Wed,  3 Jul 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i+qVLGRn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RorCzl+z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i+qVLGRn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RorCzl+z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E399191F64
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042554; cv=none; b=qmrb1RdezJqfSY+Z/HRtGP+KjXlQmUxpSPpaJPMBHjIWyj5mjvO9/66V9Paah6DlUv6wPWGLo1+xeTC5iBWGO4PD/LlixiDHJnXh1+8nfupU3wMhvINQw1nd81F2EMq/+MpPXC4Ws/u2Yd+kHyHFfkxUjR8NhEqgUev1QRxUISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042554; c=relaxed/simple;
	bh=ZYKaLtoxW2znWPq7btMkjMU9f+A0efAblg4DNE6/oY8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AEXQGjHRnjGLkQxxU11k9k7KBnVVV3gqMkGM8cW7zl1+TxSiKC6tjLuShBfr+4u3ihuewvuX4KS/hGSeQQEShNL3N6lnemiGBhRyzFBL2W49ttCItBPwP0m3PPcrp2mAPmcTpUsynbdTOPFwLdsK0zzXpo4Fm9vMApC66zNWskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i+qVLGRn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RorCzl+z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i+qVLGRn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RorCzl+z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C51F21B98;
	Wed,  3 Jul 2024 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720042550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jq70JioqG/2slFdv+M5AgNyr3WdlAVFv2UjSzAvd8w=;
	b=i+qVLGRn1WfR9fQFArty4stoDRRhysXaS3guufoaFp7lheM0PJS1TG4FB4RPM/aTAAvgQu
	5CDo9QvDvI4Cfll3P5HMedAwLnTy8ZubHILpNL+kBMFKgofrU/DIJFMKpbm9SC77BeUygm
	R1J+7LCIWBq+JzXGIVXu5uBlF73BnyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720042550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jq70JioqG/2slFdv+M5AgNyr3WdlAVFv2UjSzAvd8w=;
	b=RorCzl+zMapF1iFmEoM3LvwkRVvyZxN0E0gDEqdTihA34EZbW8xfyB548mQiINsFSYnmd5
	jnYLm+yffYmdeSCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720042550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jq70JioqG/2slFdv+M5AgNyr3WdlAVFv2UjSzAvd8w=;
	b=i+qVLGRn1WfR9fQFArty4stoDRRhysXaS3guufoaFp7lheM0PJS1TG4FB4RPM/aTAAvgQu
	5CDo9QvDvI4Cfll3P5HMedAwLnTy8ZubHILpNL+kBMFKgofrU/DIJFMKpbm9SC77BeUygm
	R1J+7LCIWBq+JzXGIVXu5uBlF73BnyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720042550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jq70JioqG/2slFdv+M5AgNyr3WdlAVFv2UjSzAvd8w=;
	b=RorCzl+zMapF1iFmEoM3LvwkRVvyZxN0E0gDEqdTihA34EZbW8xfyB548mQiINsFSYnmd5
	jnYLm+yffYmdeSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D85C213974;
	Wed,  3 Jul 2024 21:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YvAtHzLEhWZ6MQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 03 Jul 2024 21:35:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
In-reply-to: <F5BE7C26-9E43-4514-9E5E-2B6F7B32569D@oracle.com>
References: <>, <F5BE7C26-9E43-4514-9E5E-2B6F7B32569D@oracle.com>
Date: Thu, 04 Jul 2024 07:35:42 +1000
Message-id: <172004254284.16071.16151296327028024779@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Thu, 04 Jul 2024, Chuck Lever III wrote:
> 
> 
> > On Jul 3, 2024, at 11:36 AM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > On Wed, Jul 03, 2024 at 03:24:18PM +0000, Chuck Lever III wrote:
> > 
> >> IMO the design document should, as part of the problem statement,
> >> explain why a pNFS-only solution is not workable.
> > 
> > Sure, I can add that.
> > 
> > I explained the NFSv3 requirement when we discussed at LSF.
> 
> You explained it to me in a private conversation, although
> there was a lot of "I don't know yet" in that discussion.
> 
> It needs to be (re)explained in a public forum because
> reviewers keep bringing this question up.
> 
> I hope to see more than just "NFSv3 is in the mix". There
> needs to be some explanation of why it is necessary to
> support NFSv3 without the use of pNFS flexfile.
> 

My perspective if "of course NFSv3".
This core idea is to accelerate loop-back NFS and unless we have decided
to deprecate NFSv3 (as I think we have decided to deprecate NFSv2), then
NFSv3 support should be on the table.

If v3 support turns out to be particularly burdensome, then it's not a
"must have" for me, but it isn't at all clear to me that a pNFS approach
would have fewer problems - only different problems.

Just my 2c worth.

NeilBrown

