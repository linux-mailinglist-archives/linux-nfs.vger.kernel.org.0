Return-Path: <linux-nfs+bounces-23133-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zBRDJk7sTGp4sAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23133-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 14:08:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70571B37E
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 14:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=gMVztAxd;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23133-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23133-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B760F300BEAA
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926A3FC5AA;
	Tue,  7 Jul 2026 12:08:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541F3FA5F1
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 12:08:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426121; cv=none; b=fuy6JFPiRCb1FUQcRCIwb9W2dIPVSYAU19mi9xwqzB2w3DS4cHIgqWL8dIqdMVkk39OtZjkPJIaqJW8qxElXqZ2EQSYl91WETUM5QZKI2rXB8gIC7NmSw68yXmK90hv0IdHab5ZBL80c2eHOpnjXWiHHN7lt9wSm7Yyv9wQH/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426121; c=relaxed/simple;
	bh=tKdep5wfqWGXsqqgVoSBFgRw0T+jxm3tufE3mG6gaic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tihIwGV1PrXHPyxgt/qEjGHp2DupKRalajLM2LjO/As9SfjD5UdDFmYo3MhxpHmA8yJlZsfswJ0T4o2yd+GxKZMxJgN1gh+4rG6E0k5tA60c+yD6+CRa124HQeUQXwDVRIyxJk4t6BHx1fn3bigGuq4JGLxnWyD8okJ5KFwnxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMVztAxd; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cb59f6ba26so71315ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783426120; x=1784030920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4cV7wjZF91JZABaQ5nRkxwcAf75ivPZaWcSLuu/chBY=;
        b=gMVztAxd2Jfqy1RmjrW24cwvTf3F2LvNMJEX4HyIqR7zh/5nsqunTvWzWD23A5Nhme
         YmH0pDrXIJL8pDbAxWSiHT/HfNLdLPjrqQXjANDKiK3aqdeRs6qEy/SKa7yVC8jlZGda
         Ns5/cxuY62yGf1J3cIFqY/q+bjSJ3qDAq1t/wGK/CBsOdVYiukyKUElmG++oLBrY7Gda
         L0a/ISVVW9czicljMVhthdnz9ifHNziwHxUnLLbrrjV5aSgnsF1bGVSaRNowIEzllMvr
         mr7/sMYFfZOF41ckz/LnXbHZu3VnGv7BSIn/61RizU5BSpD7i2c5QcodR2AdTz9ClMy1
         Rkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783426120; x=1784030920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4cV7wjZF91JZABaQ5nRkxwcAf75ivPZaWcSLuu/chBY=;
        b=qmhDDg8wQyjzKv3zegB9JHBJK0llt9f5vqPHE9ng4Y0C8EhMbuCRF1ESbg4k44fgcq
         GGH0vdh6BMwIHIy05aw8qXQEHGbSBc+34PDNnl5VDkwXLsBCMPKVSi8HEGJKo5OpeDgg
         j0ZoDFMz39C/AiF3z8OgrJsKY9RW0hC5JoXB15eUcoZPbmwr7UeCYHYmmbPzWwdu2O+U
         Gaxt7bQBgMu/GixTT9EYHzxAq0RQKH6iJYKaf2MymNMftwgwVzV2WGXBijiFubrFvSoj
         2chSURUclOlnqP1A9bVcMXEh7gyeGdfefX/BjK67RjMyb+EBaTmmiCXVLKNKDk8d5yfz
         vUdQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqiQGH3SSTd9jXjx7rxU6YpQPUrBh98yg0xVIP4ZdAdVdv9+bijowb+1NoqMszHkwIkOV+cpefjwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9aFbxmNettQfLa3sSIrhL7xqHxRSqXpO7QyN3tFibnuRHZit
	QfoQnBGShd89twiVr0hOX1W5HMw0kCW6HQI8g/eXkA4amaHOBcegIpH8Fdnetr0Csg==
X-Gm-Gg: AfdE7cmym011RvdNtBRhHx4JxfE7NxkBt+tjjXit6+xIV/resJgfoKmb1feNvbAaVwx
	R6Lq240fNp4XDu2JCVfexVYLY6s9w+mXDsRGWkorJ9YEi/kiTj/4EsQj2QbH8yJyJl+2dRRIumm
	9gech7fmEr7+7QDEgTwS9AQv3jR/8SUnPWmGnSkg2E7psr0i5JiWgpBlzKtKBq/R2cq5d9WBHM2
	3ZVVYyCdEJP3RtjU6apq9w6+NdF99kBq8zVbGkfeBotQfyzVyO3w8/CNmY/g+x/u7R2ggNgwEH3
	vXXAlgswImTbDXjK/DilCNg5bgd9Hsy/aDCyyEOpZ2iKKfyle2TUj7oYYoxPUylJBT9oKAVjd6N
	6/8m0Xb2+t2noIeivpYI6BEIkjorXW75Mhm8HvXOX5TQdPZ5Ut4IuItoE8IzbZvfKKDsmhYXTM/
	Occ7A9qHa8dod1TfZt3DphhcsT3C+8MN8o6ossCs1Y0SLtUaU=
X-Received: by 2002:a17:902:e889:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2ccc9d7593bmr2658275ad.13.1783426119230;
        Tue, 07 Jul 2026 05:08:39 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d58f3sm853302a12.1.2026.07.07.05.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:08:38 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:08:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <akzsO_vmYX_7Umjd@google.com>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
 <akevQfFVteCOD6LM@google.com>
 <akfAgy52s_Gch2KG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akfAgy52s_Gch2KG@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-23133-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:willy@infradead.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F70571B37E

On Fri, Jul 03, 2026 at 07:00:35AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 03, 2026 at 12:46:58PM +0000, Pranjal Shrivastava wrote:
> > Do we have use-cases for a kernel user for direct I/O ? (Just curious to
> > know if there's something on the horizon).
> 
> Plenty.  Basically any storage on file driver, or storage / file system
> server:  loop, zloop, nvmet, scsi target and nfsd ar the ones I know off
> by head.
> 

Ack. I see! Thanks!

Regarding the page_folio impasse, how do you suggest we proceed? Should
I expose and use get_contig_folio_len() from bvec? Or should I move the
NFS helper into the iov_iter lib? (or both).

Also, do you suggest sending the Folio move as a standalone patch if it
is blocking the rest of the series or do we prefer keeping these in a
single series?

Thanks,
Praan

