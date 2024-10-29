Return-Path: <linux-nfs+bounces-7548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72A9B4824
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB7280E8A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E5204F6C;
	Tue, 29 Oct 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n9ljm9pW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7NGxbx5y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n9ljm9pW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7NGxbx5y";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS4p8cqu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608720403E
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200870; cv=none; b=mJIMKDdCJ0r365U1E5n2B2WBbPQZMEk7SPx6fULVUrySMVtz3StjBSE+H3f/rUQHxZPcLswdxkfF3h91z5QE2pwhPzPBbCoOCZX007NWqkWuNTE8T5pV0sx0rEPfq4ZO6RK+OVyL8gymtyrEAZxnqdZKno6Vjiq3v1tiBoDzaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200870; c=relaxed/simple;
	bh=p0a7eRP77jWUePNwwdmDWWIXbeJpCbEGNQtBasXLEOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGcyIycyQ2PPKllpa3dNGA3WXwK0nIa8saVp/nqwHclVyY3mOp3XtT4rB+fRjYYW7sqSZNDVQzpMRwxTkXt8b+dCFLIG5xvuT7LD7FwaygDPnIitVzkAAvZlgebfqqzPZbKLx5cV9TwfHfswXKqfFaDcTJ7OScHnktQ4mmtkmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n9ljm9pW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7NGxbx5y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n9ljm9pW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7NGxbx5y; dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS4p8cqu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5B221FE6A;
	Tue, 29 Oct 2024 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730200866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=TACU+JnMBJiUN1ZZRzU7X4pQgCe6ytfn9cyZGmSwupA=;
	b=n9ljm9pWugnSbyuzQbSjrLSdOeyD/O9iMVL3735bBEMuSuQuCoCAuZNvXE15Ulg5XAI3lK
	LqTVeCUNqECxAy2FhR6ALHH1Ce5awNZtFlYktC3Io5jMKqDDNyJNMxuGIclgbYTslXLX2E
	YtwCdVcdoUWBX0gfPTwE+5dZog4Z5Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730200866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=TACU+JnMBJiUN1ZZRzU7X4pQgCe6ytfn9cyZGmSwupA=;
	b=7NGxbx5y8tVfj4K8rBSUsepTTKq7GGD0dIfm21t3M1bXe4DfrIgK8XjJKcYItWMt0VjTEs
	O5nx99iQUGOTT+CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n9ljm9pW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7NGxbx5y;
	dkim=fail ("body hash did not verify") header.d=redhat.com header.s=mimecast20190719 header.b=jS4p8cqu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730200866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=TACU+JnMBJiUN1ZZRzU7X4pQgCe6ytfn9cyZGmSwupA=;
	b=n9ljm9pWugnSbyuzQbSjrLSdOeyD/O9iMVL3735bBEMuSuQuCoCAuZNvXE15Ulg5XAI3lK
	LqTVeCUNqECxAy2FhR6ALHH1Ce5awNZtFlYktC3Io5jMKqDDNyJNMxuGIclgbYTslXLX2E
	YtwCdVcdoUWBX0gfPTwE+5dZog4Z5Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730200866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=TACU+JnMBJiUN1ZZRzU7X4pQgCe6ytfn9cyZGmSwupA=;
	b=7NGxbx5y8tVfj4K8rBSUsepTTKq7GGD0dIfm21t3M1bXe4DfrIgK8XjJKcYItWMt0VjTEs
	O5nx99iQUGOTT+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 829CA136A5;
	Tue, 29 Oct 2024 11:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 53AAHyLFIGd+QwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 29 Oct 2024 11:21:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: steved@redhat.com,
	libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: linux-nfs@vger.kernel.org
Subject: ANNOUNCE: libtirpc-1.2.6 released.
Date: Tue, 29 Oct 2024 12:20:29 +0100
Message-ID: <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
References: <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326C1C2447 for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com; s=mimecast20190719; t=1729152904; h=from:from:reply-to:subject:subject:date:date:message-id:message-id: to:to:cc:cc:mime-version:mime-version:content-type:content-type: content-transfer-encoding:content-transfer-encoding; bh=WRw5eiYVYVuiU/gn9bnnVEXSieCmXb3bd2lkMP3kTGM=; b=jS4p8cquOWP8xd40M9G2pcGcru2qzEMxU9xEaiytXoizibrDwLI+XmxH/cgajbMorXjxXP K22dAodkQLN5z6FAPqSwqengsQzR1KJXkn2KdVz/9hpNKfqCw/AZT0UQxPef2O8+RHTLc1 Vb8auBv504L1PSA2MSZ13WDxMAU3cT0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-1xYggoP6MsmevKdvC7fzqw-1; Thu, 17 Oct 2024 04:15:02 -0400
X-MC-Unique: 1xYggoP6MsmevKdvC7fzqw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-690404fd230so13651047b3.3 for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 01:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1729152902; x=1729757702; h=content-transfer-encoding:content-language:cc:to:subject:from :user-agent:mime-version:date:message-id:x-gm-message-state:from:to :cc:subject:date:message-id:reply-to; bh=WRw5eiYVYVuiU/gn9bnnVEXSieCmXb3bd2lkMP3kTGM=; b=LV73pP87vRE7wx8ih8/0YPM1LjCewPe2MNx3MC9uwkTca0mptsJDReC88yI2CJF5a8 uAThvbgQzGmDb3ca2fT0zD8gdLdYLZVRQONEvl+IGeVltKt9UeWN+VV/rMg/s72WAvJT AZAEjtTYGutjs5V4K8hwaX0klb69t+X8S/5/k2eMu0tVJQAbc5QhljEbVGjPzm0rnLvu oWmYfjldej8zcuQRbsV3RJkh6SvKusWahGP9W1ec8oyZigpWN3CtuvlZXSwPa8l+1wBw 6m1dDZXSSDDBAl0vc+Dfd5UcIqh8NlX3qYUy10GCShy6dL5NAV8Xk5H3Nvjp65bVZUqm 1DLg==
X-Gm-Message-State: AOJu0YxlqABgOo2CMYwp2krzGQOzdgbPAxS7vGCkRZdV8kjSx55HQtmM 69wg7eS/c1gKE9wCKBTpWpSgLos2OfA3M0AXSFSxBsAxfli+DFFL1zUuTXvrqKp3jyyKw7fHF7y LfMKNVonpaJjwrWodU4T21eGEmAFGQylmzq/fBdWBEA3w9+gd9gE0rZ01NA==
X-Received: by 2002:a05:690c:dd1:b0:6e2:1467:17b4 with SMTP id 00721157ae682-6e3477c0195mr169229267b3.9.1729152902292; Thu, 17 Oct 2024 01:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFRIzpL9NWORnsXcpDTn85CPCK3flf6nxkWebVnb03wLauEXl9EcxjZNV5ouUELCEI936Gog==
X-Received: by 2002:a05:690c:dd1:b0:6e2:1467:17b4 with SMTP id 00721157ae682-6e3477c0195mr169229207b3.9.1729152902044; Thu, 17 Oct 2024 01:15:02 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202]) by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2f6121f4sm14362106d6.36.2024.10.17.01.15.01 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128); Thu, 17 Oct 2024 01:15:01 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5B221FE6A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.76 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	SUSE_ML_WHITELIST_VGER(-0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+,redhat.com:-];
	DKIM_MIXED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_REJECT(0.00)[redhat.com:s=mimecast20190719];
	PREVIOUSLY_DELIVERED(0.00)[linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.76
X-Spam-Flag: NO

From: Steve Dickson <steved@redhat.com>

Hi Steve,

> Hello,
> 
> The 1.2.6 version of libtirpc has just been release.

I suppose this should be 1.3.6.

> 
> Minor release... a couple rpcbind config changes and
> a few configuration changes for macOS.
> 
> The tarball:
>   
> http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.6/libtirpc-1.2.6.tar.bz2

https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.6/libtirpc-1.3.6.tar.bz2

> 
> Release notes:
>   
> http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.6/Release-1.2.6.txt

Could you please delete Release-1.2.6.txt
https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.6/Release-1.2.6.txt

and upload:
http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.6/Release-1.3.6.txt

Kind regards,
Petr

> 
> The git tree is at:
>     git://linux-nfs.org/~steved/libtirpc
> 
> 
> steved.
> 
> 

