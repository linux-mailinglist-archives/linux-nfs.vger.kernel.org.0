Return-Path: <linux-nfs+bounces-18404-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCqQLlnKc2mQygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18404-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 20:22:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1347A1BE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 20:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B790230028DB
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71403EBF29;
	Fri, 23 Jan 2026 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCD5Bs/e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712F208961
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196117; cv=none; b=thn3hQhzLjtQ3CzJeXcTml9rymdLMsh2L+obn+43ToHVVyg86FZbm2UXy3tesGd8QJHnRsQKXgSFllxr/JhGKiNgccqo5DEgDIUFuX/d2tUEEVQS/7sUpNPXDRO8vyFG7YHSvoIG7DNhD1+ZDGnxD+9KmJgTWJ8ChHjFRE/0dNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196117; c=relaxed/simple;
	bh=LkyS5Abo+zTQ1y7pT7W2H8yK66PfloSDPXKQGKvViZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXPHuBeE/0rladGPlLvkBzXb4Ji1u8C/xAUiU5/mdXLY5eJGMAVzL5vfKslXkEwKq1aSrjN7wi7PXYmXiEH54YZj5L3Svgun1ATtB4BPrWGMwZqLQlkW1MBHADUwTjQMLcZ9NZnnkvbzCFbGpHC7qRrStxnYMcodPFGpe0u1n2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCD5Bs/e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d28870ddso1397479f8f.3
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769196114; x=1769800914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkyS5Abo+zTQ1y7pT7W2H8yK66PfloSDPXKQGKvViZw=;
        b=HCD5Bs/esXXCQ98mdfQlPiSvI4ADsNW/D8wr/iQMdqBzt8s8jABkLt+XWZId3OuP0Z
         id47XFnjFxJ0+j7aD8xcmqavFRKZ97zmowkyF7w0fSflVIg70lT/PgeQmncCPInt1+yC
         UBHIDVN2Ik3LPH1T6wz3PZdxgYkLVM323ZSYfq9Gu0wPl0MqNSeIRK/A21c4EDGeyqua
         AjKMDTYUZosSNwecRDQ4DmTn0DSRvC0s2mDbzMKU9uqgbD/YDYlfzu8jCGI725b4tbjV
         uLtSv4p88cAL3NFoNrZUm/Fa2JiSOPc0GgXWYAyAhnnSeH2ni1hekZOXgrVwKXKhK842
         zbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196114; x=1769800914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkyS5Abo+zTQ1y7pT7W2H8yK66PfloSDPXKQGKvViZw=;
        b=ruPaRm7+2fdawskcmGwm/jLZ72NYvl2w0vIxJspJEANy1Aw4QUCvKIuwjJYKhnVql0
         CFnGw/+gr6MCXT6t3u64G37RPTBACTbwtvGk293Jn9xg3DQJZ28Xrsu7Cz1GbSQ8nsH5
         WWAmYEdlRqCVeOf/FNC5VB5We3m3VYKnwjqrhCimn1ypM9YdOWRHxvTdwIAZ2/iJhtzU
         YJPGIZTlyV6gjH0KP+rwWdLzD1EMYGD2+8z6+XbC98rxpWQ1iU/Qngh5Y5VYL8rI8iNu
         fG16szWzycdzpeS9p+zjTbV5NN/2+lnNnzgP1V3+MH/7IBfAFneLJEcACqKfwSfpuy9E
         RVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+BA64VLMeWZP7jvG+tVPGmTTfxiWLkobDuHF7Sr04lv5OlSbU3/9q38FX5kyF2LIfaFOpaOJ3Jvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+CaKiZYhTcw9Xt7QMt7UUubKhZv+0IB3ZjJ9+aLpLBkllhlj
	JorcVP4mZWaFJVldvhb/Be92N9MTTtDp6fKQ2dH3Gzpylz6VyzMC261O
X-Gm-Gg: AZuq6aLRySg2uXF2Dyzgkgg44bMnyhDv/2f4cVrkvJnTkgu1OAKc8yHIMbRPvXavlz4
	kx0IbWVO16tt8+CvCBVT9bOnZcw6rOHRpLhv1ipErL9AS6sJySBJ0LYYQuttpPkvalerDS1cVmu
	kWCFyhXMQB4PWatzAZ3pbOcQb2jqbSTut4f6JA8aXxYBDU2eBdGcbmk1ksQZ8GyAlxND7EkyaZu
	gYIAsYdah1mpo29gbToM8+ReyajSGDITGjyRE4ZxOnwAkf5/BXoAcJ+krwC/Tg/MOBMlABKCZzS
	VWjrVP5ztwO1d0CwTQEg/422ZlGHkM3krdtQ3K022AbD3cCs8NyIuuHhRPYQvEngu3OTw63ZeAE
	NuuNN5nr+IxM1bRfhRxfuGLot8zIjSi2GRF2zEeVF56YirW9WO1r6m6LYG0xehGBl9W5d3Y0/fL
	VuoR+/SLFpuJdcSLgX7dMQrYuyYhk8F0knRaJBYa25H05/1Qm3hzNjQoGcPNyz/enzFUiWxohGo
	Ow0ZVQvwQ==
X-Received: by 2002:a05:6000:186a:b0:435:9bf7:c6b9 with SMTP id ffacd0b85a97d-435b9307adbmr4078454f8f.24.1769196114322;
        Fri, 23 Jan 2026 11:21:54 -0800 (PST)
Received: from [192.168.0.125] (cdmjno2.plus.com. [31.125.38.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f744e2sm9980903f8f.31.2026.01.23.11.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:21:53 -0800 (PST)
Message-ID: <2b7b02aa-8759-43c4-9cd1-04a57b13cf8f@gmail.com>
Date: Fri, 23 Jan 2026 19:21:53 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2] nfsdctl: add support for min-threads
 parameter
To: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20260123-minthreads-v2-1-9bfbae745845@kernel.org>
Content-Language: en-GB
From: Mike Owen <mjnowen@gmail.com>
In-Reply-To: <20260123-minthreads-v2-1-9bfbae745845@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-18404-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjnowen@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,utoronto.ca:url]
X-Rspamd-Queue-Id: 0F1347A1BE
X-Rspamd-Action: no action

On 23/01/2026 18:48, Jeff Layton wrote:
> and the thread count will dynamically fluctuate between
> the min and max based on load.

Can "load" be described further in the manpage for users? I ask, because I'm interested to understand the heuristics it takes into account when nfsd makes a decision to increase or decrease the thread count. For example, is memory pressure + io pressure stall info + io requests all taken into account? A popular doc that is referenced in such discussions is here: [0].
[0]: https://utcc.utoronto.ca/~cks/space/blog/linux/NFSServerHowManyThreads


