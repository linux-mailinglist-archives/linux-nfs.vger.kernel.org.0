Return-Path: <linux-nfs+bounces-21258-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKpQLKXk8GmoagEAu9opvQ
	(envelope-from <linux-nfs+bounces-21258-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 18:47:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBE489472
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924013165AA0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB36324B33;
	Tue, 28 Apr 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tdue3C8p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A06125AA
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393968; cv=none; b=Exe5aRwXJ85fd4HdtBPmG1+MehToF57jPftQmO41klIFkIoMJUwcVb2ptkGYklmgGP82XkbkH5I2E3iLk6Gu0F9XUXM5E/hb6pl69qXxO+rVSXaWiuijEhGl3lMSji/VkfPTOCLuFQgTwzs1op+GTRC6Fivk/SEDtz1a4EUxNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393968; c=relaxed/simple;
	bh=UXi3to+PEeM0vXAZmtoShs0caavlFjs/qq6Gqzz+kdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2WA4OA2Dj9a4h7tplHywCheN84jPbFFUk0AvxYiJAicukR6775Gpj62o5IGlzPRycLwCA6BdFiC0yO5w8OmwdxW32tNMXESLU90tUtXtQnStYB24Os5reRnhbWTPgo/OrobJaOOFYez6ZcIiZGuJW9mhQBHElC995MgTKHCAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Tdue3C8p; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so1970917166b.1
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777393965; x=1777998765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zdQshYQj3noQptsym9r2OjNoPP3O2vv/eFEz4ctitBQ=;
        b=Tdue3C8pAMawzA0oCTAUCr5LmXQRZivT/5MQfbe0FFx5GSM8eLH8otmPenWpWJXB3/
         pfdbtbJscxFXHD73pmS1z72DD0hx6/l7GKjfW0ZzJ7IlMEJdqT8zHrGEJQTIaMyuJ9Et
         Kbo/1sB51Se7r68lcLgaD80p2V2hsoEiv/AwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393965; x=1777998765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdQshYQj3noQptsym9r2OjNoPP3O2vv/eFEz4ctitBQ=;
        b=cYsKLxbb4je8iaHTIKlw6Duw9vkfNElNDq3pCOW11AwN21wwZugho3DP8sZxFWS+vk
         twNB785sKLzP9ezEdYobbP2aS8HXpIhHLc4Z5fraS9Jjw9pSrfBG8z1kmjdJfKuE9yOy
         LnXVSyuvcJNSgieJYrHB3rge3ncgSTZStYF23JLBkLtD/E3y2NkcVXOrKfPJbzommFYi
         7+AGfNBvCzEo62iWpAQndk2IBnTCI2I6PQ8Lc1IQu2yf8XNLDZI+Xguqxhzr5C3fpjNt
         6VH2JMJU6YOfzGpUrw/wx6g2WH/gxFcS7DJTz9obyku2waY18JTfSZA7a/zg6dKkPzSc
         zu4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8NyYW2vBC5OMwebxcaLKB3G5TkTXRrvpmsynnsS5DgkxD+AoHaGUzRHfwg8+vdcvQEZdQp8kLBFAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZf/UjN+jW3XV/HABIvfsTZWNtx1BRulv+Ca7w4C2qpAzbUfa
	rtd36VuEa90KTG8o2nd9PF9gdvd+oHVFbYnnKSApNaICtd0vx74KUe64BcxjGIb7FbkueWzt1lk
	xwzDHcLgzEQ==
X-Gm-Gg: AeBDievT2Yp4u8KElf4GypWv2OfXCNo0db+q+HL9v5APAGV9ObLup87VbXPyigdGjDB
	uIafJl1GGkNGjA3QfT6kAObSh0Xt+MGVU8XADT3+W65qN2wT+yiPczmk+VIp2bAJ8Z3F2vXXnIF
	tGJinuNdNn8tI69+zdMCQ5YqbU7/GbNMVws9Gx62+QfXrnuq9FYZkFr440VWD330EsdMeEzLTKt
	85tZu9bPwFVtg6xspuKxcq7HByeNUuCFnZThi/9fkoiOtbf3Jl5jd1irAHewkVVlQac0GLV3EQ/
	9HZSBT/P+bJh2rE2oOtfKC8uJImBzEA2H1NqgQsczFItoPiCxK7FFxciI9cjnpqyqe3ElCj/sDN
	tzG1D0Dtg048lBr0SAbXnHeTQexq2xypv46qmsZsBm/2bSfKdiXnns9+2QPjaLNHPPDFKfJYzSX
	3maQOiQTeXwdJ1J6aIOMnBg3m9inb/aWV8Qe6JP/NNyGxCwcmqSRJdQVzEgJPn2/W+p2pR0Ke/T
	6Wj3MYJ/e0=
X-Received: by 2002:a17:907:1b1e:b0:ba8:8c8c:1c67 with SMTP id a640c23a62f3a-bb8015eecabmr208120266b.4.1777393964957;
        Tue, 28 Apr 2026 09:32:44 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808632f35sm122483366b.11.2026.04.28.09.32.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:32:42 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67893fba9c3so11046702a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 09:32:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+TFvuGqrq09ccG2E0hwIx/LLkneLyozjGAHx3TozJQNy6MNOdc8oRc+F1qc0uJGvU34KAi58G+O2g=@vger.kernel.org
X-Received: by 2002:a05:6402:4498:b0:670:e9ce:203c with SMTP id
 4fb4d7f45d1cf-679bb05d621mr1866002a12.10.1777393961533; Tue, 28 Apr 2026
 09:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV>
In-Reply-To: <20260428033738.GV3518998@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Apr 2026 09:32:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXZz=-XnJdMGzM8BCwDkoqU0yDNKWyrpZSwXzchxsPUQ@mail.gmail.com>
X-Gm-Features: AVHnY4IIvtSv2v5AokZFbGGGL2ooIu4U0QBZlzJ1iurrKn3dZQo8WV0HU53s1sE
Message-ID: <CAHk-=whXZz=-XnJdMGzM8BCwDkoqU0yDNKWyrpZSwXzchxsPUQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E4FBE489472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21258-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:email]

On Mon, 27 Apr 2026 at 20:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I definitely like the calling conventions change, so much that I'd be glad
> to pick that one right now.

Honestly, while a 19-patch series isn't big as these things normally
go, when it comes to something as core and subtle as the dcache and
filesystem integration, I'd personally be very happy to see this
merged in small clear pieces, so I'll happily take any parts that are
good on their own early and separately.

So yes, please take any cleanups in this series asap, rather than
necessarily keeping this as a longer pending series.

               Linus

