Return-Path: <linux-nfs+bounces-20990-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EHANCjf52kBCAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20990-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 22:33:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E343F7F7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 049E93003837
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 20:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048635C18C;
	Tue, 21 Apr 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZEQme8fv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EA32860B
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803614; cv=none; b=E3+FNSAgmGFF1wl8OD6UezEVJg1eVP3nDfz/L/ikDzpWgybNX+RbTNd3XutGL4rBcuBHi9knDWvMZGA+MS9shxl1UjFIt3ldLbDsK2kimLIPUJKZB9bHxi+2VbC8+KbPxpEguhLa3vjIu/gQs7oKWlCsLLb2g9zfVfA9HtuY09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803614; c=relaxed/simple;
	bh=fO09OjSaBqPbCVZGh+0ZVFDSeWqmiRQANPEDUCawNj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hh5uf6yqaIZgpaP2nNxwi0vaTQqVyA0rt3DiNArf0FuQOQrqNua1I9m+MG3MdZTngIurV5dys0GbEd+8vg/mefp3y9SQyzumgSUQ3ohIcjtGNfg6WfKE516S2Sg1VjlRDjopHeEjp1hUQPBW3x++uvSybRQy3L9P8K7cOWpsiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZEQme8fv; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479e7e88fb5so1085530b6e.3
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1776803611; x=1777408411; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/OEFvphu7eb6phPs6BsIVZCDAhuE0OLzi3je7vneVM=;
        b=ZEQme8fvVeM97VjR6zrPj1N4FI1QQYQ0xPWjss5hAn3XtBdvJWKdN/cGm4J9P4F6LF
         HcGT3PF1k4ZXJ8RmqmPUZxHjAB8BTWFO9gTEkIntbu+Qcy2cK+mE/7jm1J1J8wa1pDsR
         klrgO7+SpHQkDa1oNfWZXMnm4Is+dNbvVK5vRHni7RTkpAET7cr1SA7AkP3wAXLCvd6c
         C+VqSq9qMkAu7gN6/hwyjwhUBx8E91Up3YiMtM60GanXMQEkdjbRJDhxsMlPyCPFXPLk
         wtsXI58l1z3SdJAEOoijAwV7hd6z6pTfzao3hPpQuWnzKWHuVEgklTO+KPWgh8YDA8av
         2NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803611; x=1777408411;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/OEFvphu7eb6phPs6BsIVZCDAhuE0OLzi3je7vneVM=;
        b=WQNvg2pt7xASsl1B+QLq6Jeks68CtPiNP9kWPLapDIV+Ti3HR7om1tuWkj4o6qz7ji
         fWImBY91zJcL+XAaiWPcRrsdMOAgarfxEs7sDouei21nGuraDc1zT4NxHWMldVMe6o1X
         dB3hzBKqa96+/PnnLVX/XeXCE9SDPD+kGro+fcF0eO8xCRSY+wSzRtm/xNtBodQyu47d
         OTvWfBnXj7ByOsTZmmI0bVV7p201fGFYFIq5RBBfifW682A1xOhDIOcUB/HDsncpFZKf
         S2a8EaRKCl2FuneYmo3m+Oa5mA+Fnwyu1yR1VEG70g/2Tr/tx/WuqkR3FJtBcg80mvX6
         1+Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/DrOz0BOoLX4rMxBW3z9To9tDUFdGTbL2x+ow3WknlYl46Fs81kUJm2PVIotAsoTeZefRq50rnBuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbnMPAwoiIxEgGea+5TLfaLZZpfLkTFijwywjKEEs6Qme6iGI
	GZRHCS/nK0dcc3tsU431gAPqXKGLhzqSQHsjLqoCz6lDBMPF9o6nbskVfPr8IgyuUps=
X-Gm-Gg: AeBDiesAHPF0q9UnF4ZYM0PKElB1JldwsXkCOk1We+6/h46OSTLsoKX3oTjMRIAf0CC
	ZFI0d3AN35unZlOeyjuErr1O1I+ju81BN3SjEnDHcglDQctufC+NzC2nXkUJMYwW9Lb05NlmHff
	ipIa5ba8cGcy8T8lAQrAajHdliIizxFWpD9IwonWxbSRJSquW+kZLRsGcykUyk9epK6LuRUp2+Y
	lrTh4Hz3X125CRISFgYhPrL8l/5hoZLj1qeRLmaL8vJdBEmB/6ePHk+CPAcsvBg75uns7+wBCRl
	hLzM0rCuuKwd/QKZFGzKKQxiBtYYUM7v+HiJ9llcAJYKxYdTFSe+d+5xOfxCx0Dr/Wi9nZwsHpb
	vYjjcL7NnaNvDrhvsiq4J96P1vz3dx2rlTAlHihvVMQ23HjBSOVwVPV01UmJ5Ln4g8egP44RZf0
	1GincorXgn4vLqzcEnrSsepFHivzQmDdOSeF7bt0+IBIJoSpQTKOeEww==
X-Received: by 2002:a05:6808:1496:b0:467:4a4e:5a80 with SMTP id 5614622812f47-4799cb309fcmr13143374b6e.45.1776803611509;
        Tue, 21 Apr 2026 13:33:31 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc5b138basm5299616a34.3.2026.04.21.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:33:30 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>,
 syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Subject: Re: [PATCH] sunrpc: prevent out-of-bounds read in __cache_seq_start()
Date: Tue, 21 Apr 2026 16:33:29 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B3C1AAE8-7593-4E86-8C95-E95C57585DE9@hammerspace.com>
In-Reply-To: <20260421161126.129533-1-cel@kernel.org>
References: <20260421161126.129533-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-20990-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-nfs,60cfa08822470bbebe44];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 576E343F7F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21 Apr 2026, at 12:11, Chuck Lever wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> Commit 7b546bd89975 ("sunrpc/cache: improve RCU safety in
> cache_list walking.") changed the tail of __cache_seq_start()
> to unconditionally store
>
> 	*pos = ((long long)hash << 32) + 1
>
> before returning, dropping a prior "hash >= cd->hash_size"
> guard. When the while loop exits because every remaining
> bucket was empty, hash equals cd->hash_size, so the stored
> *pos is one position past the table's last valid bucket.
> seq_read_iter() caches that index in m->index. A subsequent
> pread(2) at the same file offset skips traverse() and hands
> the stored index back to __cache_seq_start(), which decodes
> hash = cd->hash_size and dereferences
> cd->hash_table[cd->hash_size] -- one hlist_head past the end
> of the kzalloc'd table.
>
> KASAN reports an eight-byte slab-out-of-bounds read at the
> tail of the 2048-byte hash_table allocation for the NFSD
> export cache (EXPORT_HASHMAX * sizeof(struct hlist_head) ==
> 256 * 8).
>
> Reject an input hash that is out of range before touching the
> hash table. cache_seq_next() already bounds-checks its own
> loop; the start routine needs to be symmetric.
>
> Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
> Fixes: 7b546bd89975 ("sunrpc/cache: improve RCU safety in cache_list walking.")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Thanks!!
We were hunting for this one.  You'll probably get a Tested-by shortly.

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

