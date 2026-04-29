Return-Path: <linux-nfs+bounces-21293-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJuELENy8mmJrQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21293-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 23:04:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E949A555
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0713017511
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B53A0E99;
	Wed, 29 Apr 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RBR3I+Gu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37387388E46
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496639; cv=none; b=GWjo0InFBBBAM4c7GH5JU9xhyncEbXwJm7BJJtyNwp3RqOHet11Wtrlok/asJXSffl5b0DQpzkTaP2s1VdrMON5foFjQKL/elMWz8TtH6cYYB8kqXjmzyBAG222g+DK9ytNL+e5Yk4ODDC+ODPkx4KvXvTBNUCQZIXMfuDDy51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496639; c=relaxed/simple;
	bh=tKD1kZoqphx/1IqZo+FxuGf68uivswEb8Ml+8Wv6abw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev4T7hCDz3cmTWAkD1qJJVCeFnJpjBVg3NxvmXkGabaWjGGeinI2f7wiPdKrUCdJQfZuiFm2iEwfa634XGyWO4WJC9xa/U1lXUYFh4kdYwne1ifgZ8TUO35Zal3zsbCMM95agGXJ/thlonBnAOciNhpbcAEHvswCMJf0VWRbvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RBR3I+Gu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba5b107eaa2so26899166b.3
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777496636; x=1778101436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnqVnLYxhZQkXEJ+qyCw2Y174F/Hy99oiICnSXcEeRc=;
        b=RBR3I+GuArZP7KSs2BQDXI8594FAL+qYBC6Sm7zxM+aCIjT72MsGjpFV2wn0x6+To1
         4unXpsZjcFTX5Un141+0VNn4nzHLu7ZLLFJpinY7DM3SM6Ry8F3D2J7xOxOlwb1mpjTD
         cJeihOimJdLPGrHvSlng/vXtjL6AyfRZVueiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496636; x=1778101436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnqVnLYxhZQkXEJ+qyCw2Y174F/Hy99oiICnSXcEeRc=;
        b=IrGKXKfcJByLMVd7V83F5qsm5N79MNDWevhO2YgYMoe3TUKuZL5erlKzT9jWq5P+V8
         WQCR/Ydr7YQB2J7nH56POT0w/nKi7Tz9JjeJ5wy+6VzgOCloByjk+w+7YeHQvfMF0eMj
         NNzZtEN1PSXM3V6sNln0IBZwPDa0i9U3x+eD/F0oFmuU3mIuE643aKcWkNIlgj9vJD8K
         IbLN+sCfhJd/Wx3E5dIC09K2yqJF1unu3l+pcCSttTDQtBTRKYtxk6ZaB8eKL1WBEOlw
         L2mEHXWwQzIkzEnwl9m3/uOKi0vf5LkJnsjaClFs4vfXRTiHssw4d9z1+XRpLiEtDgTi
         fBBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RZ9mFnY9zL16adTBRG1nSiBtXUJzTrV0AlUblbqyNKx9HF4JzfEYu8wiNQ9756kqiGR3RMV4voIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCZAqi2zJTpC1T30TtEFEsx9V6h2VUoTb4P/FgFtRjeIRD6gW
	iULvIdQRRT7ZAuGjs4tl5VebhDAOrJTo0ph3P/V4j7gWAT7E3ody8gksFQPVgOWNvNcDz98k/LG
	DRcNpJpQ=
X-Gm-Gg: AeBDievDYWhODNF9Z9zFacr9S6oktiR7bPtDfTyHRnQy5iuD9VTT9cfIhiz5nKYRlKo
	rOQLFj9dYigMsjbUTVOBEWvLyP2hRZYiqOLfb1mlTh5YqCMH1bt83NHtTRtQCYdS4zNkCB4YLp1
	3b01T3IMO8/YDh1oSqDRQmhhiF7UH19RxOINuBXWYtkKjLVTwNCYh5MxjWiAghKBdzSFMzPFPOq
	GzFLr79ctKexo6nC90QLoOrT54ZBLug6VONNX2On1JfFZb5wYKa5kzrB9VzIW9Y62A9pp0g8+uy
	l/GYokUs0xj6WHQhbA0E6HZJvmcATmO7aofB9A+G+1qy8CvKkxHYDoWyLXOCwYWjDGT27oTtDnc
	q9hkePkblJTrx2nokdsKplhUSvUfma6ogFpyCiTqN2o8peq+IIdUMBJZXqky6kH7r/xYbRqi8kA
	7FwrsRgUV/h9Vv9o4aMRjrQOAM050GKskdL+mCwbjUWAYF7U0TpaWs9fuuUpksofmBCchpB7wwC
	N+hnANoeAI=
X-Received: by 2002:a17:907:1b09:b0:ba7:3578:f627 with SMTP id a640c23a62f3a-bbac6eb68e4mr18438666b.37.1777496636285;
        Wed, 29 Apr 2026 14:03:56 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb9864fd9e5sm139631466b.62.2026.04.29.14.03.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 14:03:55 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67893fba9c3so568529a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 14:03:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Tl4mEzEYrHf2sMAnSdGUNPJ2xrId/zFoNsiwUek1hdLaD6AWsHwhXvcDWK0XY8t5XBPbFUqRplls=@vger.kernel.org
X-Received: by 2002:a17:907:5cb:b0:bad:dfe1:6a56 with SMTP id
 a640c23a62f3a-bbac6ac310emr20951866b.30.1777496634502; Wed, 29 Apr 2026
 14:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV> <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
 <20260428142225.GX3518998@ZenIV> <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
 <20260429052626.GY3518998@ZenIV> <20260429170731.GZ3518998@ZenIV>
In-Reply-To: <20260429170731.GZ3518998@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Apr 2026 14:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs8yAfaQYmeKWab7KES0jU46TvdBfQ3Q9+6+=E=vrx=w@mail.gmail.com>
X-Gm-Features: AVHnY4JtG_9GDiz56QzrtD5BrZqKcsiFlr8t2n0kWXJmeuX800NGv4Qx6DLxhBo
Message-ID: <CAHk-=wgs8yAfaQYmeKWab7KES0jU46TvdBfQ3Q9+6+=E=vrx=w@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 286E949A555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,linux-foundation.org:server fail,linux.org.uk:server fail,mail.gmail.com:server fail];
	TAGGED_FROM(0.00)[bounces-21293-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.org.uk:email,linux-foundation.org:dkim]

On Wed, 29 Apr 2026 at 10:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Something like patch below (on top of -rc1, completely untested).

This looks like a clear improvement to me.

... but I obviously didn't test it either. But just looking at the
patch I went "Make it so".

             Linus

