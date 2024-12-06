Return-Path: <linux-nfs+bounces-8381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94799E6723
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 07:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D9A166576
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 06:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4A1D88C4;
	Fri,  6 Dec 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbzbep+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bmivs0TG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbzbep+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bmivs0TG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12513AD0
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465156; cv=none; b=joQBBzP8V3FnH2rN8nKe+0s8i5bUTFyQ3TzeEcMoM8tBcfCLAnQjLr2dyJu3gWlNH2x/zQBe1EOewVnhdlaJ7wwN8v7APtdMpWDf02s7HOKQHLqksQcQ52RQITfGZQ/ji3C0oW7e/soO5Kh3n6OXsg0Uibv1roVgXDLKgSrtoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465156; c=relaxed/simple;
	bh=tYeZjeXW6kyhIYbUVoDBhjs6Ws/gWyfzhEqZO/8Naxk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EvaLKfR39OJ/mvK3eDcKok7jUjptwMQpA5ffiw6OeDkfb0v7YL578g0Xe2qkaOIagEybbnPh2cpvI+qmipCCAg+1q846oUNxRNwxZv2/3eSiQxuKHd7BdTKx8B86BNVRwltIlbqPf84jERVYv18SAah1jlXH+7U00f04D9H+sU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbzbep+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bmivs0TG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbzbep+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bmivs0TG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A841321191;
	Fri,  6 Dec 2024 06:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733465152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPTioAVbgL+BEayBmSNBrj2qHQSiTzMSgmJ0tW5/pSc=;
	b=dbzbep+VhWdBxMFF/rKNcyTQ5C2rNdIhstHaL6nmqYQaa0HycVRSJWhQp5UZmpw9fTQQGU
	PJvhfxA+sm0IRg7eYFCbPUb71PJAzV9wSTXTXG/mFh4HCX2sOyd8oJFG9onLeqi9MD1V1l
	Aa4Xlsd3BG437gEzMPGZHh8tqe5+ejc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733465152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPTioAVbgL+BEayBmSNBrj2qHQSiTzMSgmJ0tW5/pSc=;
	b=Bmivs0TGnpEZf+g57VFsh+vpWhqWHGL3AEzDW1NIDsJVi9rOCz5AAnkbjaEOpvB/D4wbzO
	wp+8hABm/BjZvABQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dbzbep+V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bmivs0TG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733465152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPTioAVbgL+BEayBmSNBrj2qHQSiTzMSgmJ0tW5/pSc=;
	b=dbzbep+VhWdBxMFF/rKNcyTQ5C2rNdIhstHaL6nmqYQaa0HycVRSJWhQp5UZmpw9fTQQGU
	PJvhfxA+sm0IRg7eYFCbPUb71PJAzV9wSTXTXG/mFh4HCX2sOyd8oJFG9onLeqi9MD1V1l
	Aa4Xlsd3BG437gEzMPGZHh8tqe5+ejc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733465152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPTioAVbgL+BEayBmSNBrj2qHQSiTzMSgmJ0tW5/pSc=;
	b=Bmivs0TGnpEZf+g57VFsh+vpWhqWHGL3AEzDW1NIDsJVi9rOCz5AAnkbjaEOpvB/D4wbzO
	wp+8hABm/BjZvABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860FB138A7;
	Fri,  6 Dec 2024 06:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8dJ4Dj6UUmcKVgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 06:05:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
In-reply-to: <fc4542f333779947144c19024bbb924a82932bff.camel@kernel.org>
References: <>, <fc4542f333779947144c19024bbb924a82932bff.camel@kernel.org>
Date: Fri, 06 Dec 2024 17:05:38 +1100
Message-id: <173346513837.1734440.3876153166552002328@noble.neil.brown.name>
X-Rspamd-Queue-Id: A841321191
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Dec 2024, Jeff Layton wrote:
> On Fri, 2024-12-06 at 11:43 +1100, NeilBrown wrote:

> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 382cc1389396..c26ba86dbdfd 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -576,9 +576,7 @@ struct nfsd4_sequence {
> >  	u32			slotid;			/* request/response */
> >  	u32			maxslots;		/* request/response */
> >  	u32			cachethis;		/* request */
> > -#if 0
> >  	u32			target_maxslots;	/* response */
> > -#endif /* not yet */
> >  	u32			status_flags;		/* response */
> >  };
> >  
> 
> 
> I don't see where the above "#if 0" gets removed in patch 6. Shouldn't
> it be?

You are misreading.  It is being removed here in patch 5. 
It was added in 2.6.38 in 
Commit b85d4c01b76f ("nfsd41: sequence operation")


> 
> While it makes for a larger patch, I think we'd be better served by
> squashing 5 and 6 together. It doesn't make sense to add this core
> infrastructure without something to call it.

I find it easier to review if the distinct elements of functionality are
kept separate.  But if both you and Chuck want just one patch here, I
can do that.

Thanks,
NeilBrown


> -- 
> Jeff Layton <jlayton@kernel.org>
> 


