Return-Path: <linux-nfs+bounces-20116-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA+tIslRs2l8UwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20116-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:52:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8B27B5AA
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CEE83102A8A
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479840825B;
	Thu, 12 Mar 2026 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NauSBUDG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62180377016
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359546; cv=none; b=ZtUlrPev3UTdLqfxydlAuJj1+TfHAMN9GfuShhNVxRekwP4UNk57vXlscjoXIiD3aLruZHYNg5sTw8sRXFBrhduoIhJel/5I6G1czdJMNkVEhNvonaMazuz8Se6V+Ql8mBFUPG10fqbjIOurDjtZOTf8IMrvQuL3GCkgZyAElwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359546; c=relaxed/simple;
	bh=wOUC16WI4/reo5GvoZO5ESmt8rfD7PE3++Xf9novjKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTbVVKY0vhLon0N043H/38zUoYdDCzb/xXN+AGjqI8tsyGrxqfx8YEogvmgIys8pcDkQJXr5wA2/dOxE9lShZUySgVTDpdvRwf9QjG74/4heHmG0mGRbcY3N7VJ2Oj7A3+6hXJEnIfoYctLRqo6my+ABPGwFflYSqThHatn41ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NauSBUDG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b96e579c0fcso272320766b.3
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773359544; x=1773964344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=NauSBUDG8C+IWSy/kg+CR2TNhzQBDUUkhuXphABdo1pUsZmbWphDV/vhFbL+R92I42
         UZuGmK88iuCECVHmGUjEGGRPrzfzz7kxbba4tZUDzG9n8jY1q0f0omJpomHkXTHg+bJz
         kxfmTstOUFUSa1jTo6c5jQWkMttvuuCmF9foM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359544; x=1773964344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=XCriMkcVhuPnT73YcAkBHVag51E6EG3i484VbfCahCG6QCs2QSyk2pa+JxqeLnykn7
         CECg08swMvYXPWuYFwUl2xMtTCRmiInizo0OIeDAYU6Jag++lV8VKaZYNvwBtBYSuq3V
         dSjgRZWND+2lHgEMZtkrtFQmmUXQhw/Hu1Pm3/M5BXSRt0XGHwy8IJixYbGasAVisW9e
         lLOQ+mzydfI0NTn26Zz0WzbDUK06s22SOda8F8MyH2qq4orTc55d7ZSPBYHFLHe7EZ8Y
         TkrNUsXIAlliNU9I9mMFyld6TEeSwM91JDQ+IQjPJ5IbqqttMfrsOOsOR6RFKtDjPlX5
         USTA==
X-Forwarded-Encrypted: i=1; AJvYcCXi9lx2wR0GbUxHO/EMZkNhwP85BwJhm89YxNshJzQthCFIYH3Iba4Hg0lcRKuiOxiZCZCPFRd+jTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xenVvO+OygRK9insSbkY3HALe0MOOEHZFZLBPt1l6pdBLXP2
	6Xx0kHCFwWGisUsk9PKTzh/naYYY3s5zwz0XHCCaXzPYADjzrcEP8ex4xajB4o63aqBPvAyCpjk
	48p+a4Ts=
X-Gm-Gg: ATEYQzzfAzUj/zmbOKnvbHzESVKnFHxCJkQP4OG7BY4lISoXYC1X3zQsuUsKs024XEr
	AxWobD4TQ1OIzE+TaU1EEFKqYg4GGUYmwK57MyDaGLC4vwbo65zqhxwBqs9h0lMJ3DrJf17J6OM
	avCzYPqIxRKRlgfKu3yCBgEO8CTjIf87OAaxOvZycGeqwWfUxuToJ03rI+T+dKtLcnssOjbFkHD
	6m7nyJ8N9/FCbnzVEfz0JzsAlLpbjr7nvtdj8l+iK42qu/JqKpD81/gYrQCbtOygyDxFFhVlIDn
	E8kKDyXAbDgPAYkd/yUTZ59EwIoNQJxFefCHMxWA/wH4MQBGMJD7CCzUgK2db9rwVFJi+A5r/Qc
	8/JLBEajeNkmBnjHjkZe9Y47Xo/qEUTTh+yAOHrXdNbY1cIOdCpog2gHoQgMVRJow++KCO5Uctk
	JQ5vnYjZXv8al+P55LPaLUAclDc8WqZVyJvLcQ+UpS6HFnFIStAOdDDr9INz1upTwivKM1k8xo
X-Received: by 2002:a17:906:fe43:b0:b90:4b42:a982 with SMTP id a640c23a62f3a-b97653ffae2mr70351166b.41.1773359543579;
        Thu, 12 Mar 2026 16:52:23 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976c86ce02sm4326566b.0.2026.03.12.16.52.23
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 16:52:23 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-662a1855af2so2634632a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 16:52:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOKfsjni8/xpicvRYPdo5/hmxQ/AXKWe5mwC0dJQHDcOtO40OMaXfVAl3FsgmxyIt6A3kpDtREUfc=@vger.kernel.org
X-Received: by 2002:a17:907:c5c9:b0:b96:d802:8b41 with SMTP id
 a640c23a62f3a-b9764fd8722mr66207066b.15.1773359215961; Thu, 12 Mar 2026
 16:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Mar 2026 16:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
X-Gm-Features: AaiRm503fTaccEgKNbxF9h_dDHM9fUsSr52XJuxzTwCI0G9L03uDq8g5di1zchk
Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org,vger.kernel.org,kvack.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20116-lists,linux-nfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 16D8B27B5AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
>
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.

I only got about half the patches, but the ones I did get didn't raise
my hackles.

HOWEVER.

This is very much a "absolutely requires ACKs from Al" series. Al?

Also, because I only got about half the patches, and there's 53 of
them total, I'd really like to see a git branch for something like
this. It makes it easier to review for me, and I suspect it makes it
easier for some of the test robots too.

But again - this needs Al to look at it. Iirc he had some fundamental
concern with the last version - hopefully now fixed, but ...

                 Linus

