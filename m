Return-Path: <linux-nfs+bounces-4110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A390F861
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C442837AC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 21:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D494878C6F;
	Wed, 19 Jun 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="luC5obNZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="haJmv114";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pI7bVXyj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t4eNIQ/4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EEC433B9
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831773; cv=none; b=HruCShKYpbo1irtPRQQUwjOesCxLsmhz8gCnFfpbe2/VmL29hjfI4j8KT+xjVPjCC+HwJstLbxu2Z73KbjIpLP58UxGNaJsqzFP6LHnkUBgt4rdfHpQ4olYwjBlOCQudY+3DoONIvcsftUGei6DpXvUNpbAtgN+WbfWRmIEsRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831773; c=relaxed/simple;
	bh=Mlvbcc33+T46jONaFX8cZL1xro1GRjQjexsTdbYmT0I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aKKmvWUnh0OMXyUBHMOY36PaNzb/zjdLUjysJCFVlygboj73iYdBkrnB9jS68sm72F1MADKe83QzX8ntNhTlWtdA98+T/x5wyITBd74eS/Fj4wOJ2wmU7gBjZjeq4j2CAhvTH966lr0Wvz4Kb1g90lHQVRrpteYgYC/tq7sfp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=luC5obNZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=haJmv114; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pI7bVXyj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t4eNIQ/4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0404A1F7E7;
	Wed, 19 Jun 2024 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718831770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxNQ+rgWZLPF/Lr4ibIRahea4U6H6eE1MhJrnkcL0ig=;
	b=luC5obNZQ5xFkz2tt4kyobTek0cs4W5CV3PENit/obg/RKPdykvjUeAZb7XQd3LKKyzjnK
	Z09T9b3BcZcqbsL94M4LvPI8mNxMpNg1vl0FyZoVHHicvffC1jvYBU1sviM8fmj8h4uryz
	Vu/wCkuZQx7sr4zobvGL+bVvskAghHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718831770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxNQ+rgWZLPF/Lr4ibIRahea4U6H6eE1MhJrnkcL0ig=;
	b=haJmv114/fCjomwoBf7ZV7oxX0R8aNGSp2NRrjxpFmst3/606hINpCB1r3PYEnx6Mxcjx5
	aHZuGUnONDfUWwBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718831769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxNQ+rgWZLPF/Lr4ibIRahea4U6H6eE1MhJrnkcL0ig=;
	b=pI7bVXyjgeCW3R7CZJaVRGdGpnojKajPogb9FvIxVge9jE4kBMgbrPLYYJnFYXISBtxrap
	6Mt7mhWllLU7BTxtFR8Y32VneCdPeVQpWrIUd5PZDcVvfB4mkN+3g0UO3SLZK/Lha5mlfc
	xrYFvXdh/eSOifsX9HKeWES43/y7AvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718831769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxNQ+rgWZLPF/Lr4ibIRahea4U6H6eE1MhJrnkcL0ig=;
	b=t4eNIQ/4hrIMhNn11LdRTwtywh6/y9KDqc31FmoqJ8b4evMb21qKNFST67usUMo8yBsNwz
	rHVJS/S/fTksh6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF33E13668;
	Wed, 19 Jun 2024 21:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cmHFKpVKc2bjCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 21:16:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
In-reply-to: <ZnJI7Em5clnyWDU6@dread.disaster.area>
References: <>, <ZnJI7Em5clnyWDU6@dread.disaster.area>
Date: Thu, 20 Jun 2024 07:16:02 +1000
Message-id: <171883176240.14261.9368616164114195539@noble.neil.brown.name>
X-Spam-Score: -4.19
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.19 / 50.00];
	BAYES_HAM(-2.89)[99.51%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, 19 Jun 2024, Dave Chinner wrote:
> 
> I'm not sure that the NFS server needs to reinvent the wheel here...
> 

Workqueues provide threads, but we still have to provide the 'struct
work_struct'.
For nfsd that is essentially 'struct svc_rqst' which is not small by
itself, and includes pre-allocated buffer space for the largest possible
request+reply - typically a little over 1MB.

If we allocate a new svc_rqst for each incoming request and hand it to
workqueue, then we are probably doing a lot more allocating and freeing
than at present.

If we keep a pool of svc_rqst and re-use them - and if we actually have
several pools, one for each NUMA node - then it seems very little extra
effort to permanently associate a thread with each svc_rqst.  It's not
clear that workqueue would buy us anything.

Certainly we could usefully learn from workqueue and make use of the
same primitives that it uses, but I don't see there would be a win from
using it directly.

Thanks,
NeilBrown

