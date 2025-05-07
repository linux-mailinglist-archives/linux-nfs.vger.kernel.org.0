Return-Path: <linux-nfs+bounces-11559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9088AADA46
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 10:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4363B9B0C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4C13C82E;
	Wed,  7 May 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cTNDxGTo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vor2kxzY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cTNDxGTo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vor2kxzY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B284B1E7F
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607000; cv=none; b=LtkQur52IJ/UOBnjXhXPQApzSeaSn7e3yBDXPeAWuSh0qbJuVIflWIwQrkA4Odg7cEVkpmr0hGT8IJmDbySsc6EiniifY85f2B0fMYbGSL5mg8hbxaHkHbpcP2nRniQDH1Gkr8BXV2mU+xdlc1IdzMOj0/MVBZ90WfM76eG5ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607000; c=relaxed/simple;
	bh=eDsH4l+EHdUf9Z8vsFtHBO7WoII5oNz9yfme2zEwKtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBzCuwjPlI3FVwX7sKhcieRO5W/wjFMrfFXRVgB0pjXrv8bmUUO87MNFbsT9aIwAAIxqxDQQu4/5gWQvbss13IKsrky3Vf3USOl2gzyzbdKmE2F/toP3fWAYcNxnQeNJDqK5KZ1FbZnUjF12Nv5plJvSk72+f1FsO5UcJ4OuMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cTNDxGTo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vor2kxzY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cTNDxGTo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vor2kxzY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8E1021182;
	Wed,  7 May 2025 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746606990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=cTNDxGToKZm2J6Ju2ztElnKIvYDZjy8NBfJoVgmxy3uPPLHxYSdExAoGKfxp43nahz5gu9
	4FtnoNOs9d31eLu5kWJJEe/WglZI5hC/FJPfRg02V8bhkRz9k6jG1hxjxyhYmIma/7uPDZ
	dyC3yfwY+7lJF29d272t3adXzbGLfoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746606990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=vor2kxzYaJ10duteLWGKdKoRF6eobr3wVLjH5961XZJlbrUSuPREbElN82rGAEmEOIbFjb
	vr0+kpe7Uh5CPGAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cTNDxGTo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vor2kxzY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746606990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=cTNDxGToKZm2J6Ju2ztElnKIvYDZjy8NBfJoVgmxy3uPPLHxYSdExAoGKfxp43nahz5gu9
	4FtnoNOs9d31eLu5kWJJEe/WglZI5hC/FJPfRg02V8bhkRz9k6jG1hxjxyhYmIma/7uPDZ
	dyC3yfwY+7lJF29d272t3adXzbGLfoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746606990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=vor2kxzYaJ10duteLWGKdKoRF6eobr3wVLjH5961XZJlbrUSuPREbElN82rGAEmEOIbFjb
	vr0+kpe7Uh5CPGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B54E9139D9;
	Wed,  7 May 2025 08:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xEarK44bG2j/agAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 08:36:30 +0000
Message-ID: <5ebf1f1a-48b8-454c-8c1f-eebbed04165c@suse.de>
Date: Wed, 7 May 2025 10:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
 <aBsSmc7W8Cx7n9md@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aBsSmc7W8Cx7n9md@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8E1021182
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 5/7/25 09:58, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 10:50:00AM +0300, Sagi Grimberg wrote:
>> Just so I understand, this is a separate issue from passing the keyring to
>> tlshd correct? Is the suggesting that nfs will create a special .nfs keyring
>> similar to what nvme does?
> 
> Yeah.
> 
>> Note that nvme also allows the user to pass its own keyring (never tried
>> it before - we probably need a blktest for it //hannes). So in this case,
>> the
>> possessor will need to set user READ perms on the key itself (assuming that
>> it updated tlshd.conf to know this keyring)?
> 
> I think so.  Or give user read permissions for the keys (which from
> my limited undertanding renders the patches a bit useless).
> 
> Let me send out my current patches and discuss it there.
> 
The canonical way here is to link the requested keyring into the
session keyring of the calling process. That way you have access
to the keys in that keyring.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

