Return-Path: <linux-nfs+bounces-22301-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9bu3DNOKImq1ZwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22301-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 10:37:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64B646740
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 10:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nJz4tggM;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22301-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22301-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A963B306918C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E23CF68E;
	Fri,  5 Jun 2026 08:33:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A373CD8A3
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 08:33:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648417; cv=none; b=l+klu7QCz5SZcZ5HpV/CC7xw2jy2ZnxkHFXwaMOP3BsyaeTAyrLgk9hkV0hphYfemBEhvXy5nxXGDsNtIJDIZKBy5ZWyGik12Yhl8sjsoc7xCKClZgIHzRuWIr6M2ZMY/gbUwmL85eRvI8UGhPWi3mTXec/BS26b8Ec/RICMEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648417; c=relaxed/simple;
	bh=dw5ZX2TWY6dZxDUNc60ak9mge7y/ImiGMvgzZEHUi2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utsahC5U0hmV5Zl7UsE0RljSA9eBEtx0wU8DqSn3rLwzLz53m8VEdhkf8uvS9P+qJLVtKYQylxZRLheABQpEEB8tYjhhjTx+v3SZA5bIVrLHw/5LIsfCj+UN7fIxq00DYLllkyHnjjEdABoRA/0Bhag+E8vg5oND8FGEaxtt6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJz4tggM; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef372c58aso957227f8f.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2026 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780648415; x=1781253215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7EXbRC8R67rHvzXFjU33E64Dl9gsGtZbMHZP+ijZ/c=;
        b=nJz4tggMJJD7crGEEgG150BuCI8vKJ39zcU6sPIXnQqpOh7nrSB5H0g8Uk6bs7bU5e
         irOPuMEs+7bFgcZ1MKCW9XicfTmJn7qi30DdQswOHtDQY9Pnpmi8ccgZUCQhX+epmpR9
         +zKonV1LwtyIGTavv/CNMmYONEUKzAgFZd6xTR6k9OJ+Z3+BZ3byc3lbePTS3O8R+BSi
         +94kTl+PiY1gxjGIwvqH+uotLZuLb8/FDRtxg8KUwfgn1zT0X4AvJcmGdJtjk5JUt0fG
         L+5Xul89jRKKwtZJwBAIvpVC5zOqrMhNs4ueqEMxS2KyOoKOLWI2lcDD6F3eruBZ8tPG
         X0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780648415; x=1781253215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7EXbRC8R67rHvzXFjU33E64Dl9gsGtZbMHZP+ijZ/c=;
        b=MpAPYqXc/5AZ+mS/huXSzakI/SlCJLC6SwpeBsHdwcEJwY4+5Mg+KGX46J1a4oBOhZ
         2j3nt/xvmJ5RC+7D/VCWUD6t7wkf0IbgzEVfpgxdSUiukwnTXp9x+jVg79kG1lkLlAF0
         U9MQIRCCvCRxLPpjiFXKPeqjlrv4fwXSSmVqocvZlVQNNu1TjtqCBkYTB2Sw54a+CiuR
         4ZUTKMTgabWl7WPzcRWKcAJrfHhnnZ13EmIu7Dwj8MZiGvuafOrgB1ptjBygnjVtK7I5
         ybxHvvhVRZy9hH3WvzbfQZIuDfC6Qjd+AJyuy+IfzC2Gjnrv9nD3/5rUMXutlA0SFzwe
         fF9A==
X-Forwarded-Encrypted: i=1; AFNElJ8qmTqg3wV4Hj92SC6BSx+W2SPQaGHeARke5Jq/tStrckbeunC3wSxGnEv1nJW9rAE1ODYxeNm3v1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwFQzfvYGnaUTBpH20ZBrdkaXE3yzxNkLJMkdpwdXrK7pYRtN
	xcwGl9dZn88GgjKk3vFHbhb0CWmRZBRNYc3t4rR8PibQBdFN31D//AI0
X-Gm-Gg: Acq92OH6E1aSbFAzKy+if2Srl92rw2GrrxjGFyAZt00ZRMMz9vx+2dFIaRqAuKqOIKe
	3Va3Oy99J//96kFKEvhFNDhuV58fwCigFwMfSqUg3PIlqzfPtYTX+t4p4avmzQrC4c1+CJOc/Ud
	3iedqZkaNmP1eB1QKrRBL1i3+YQz1FJRjMGxImExAlhUq6i/BeagR+YpSqiY8EU7f6O2ku9cl3Y
	alHx0iBB7HnCKuGeES+mxiKuMxNVDu88TJevDP7YiJD8rAezKAeC6qkusbBKYtaRWK4m3G3qKUr
	rixXHaA53DUnlu3b4o+n3KP6Scyube45x2SdtC0+0ixxrWkNudwCo4nB7GX5cVgooA6TPS6bG0L
	AoWe1f3L5kfJp/RL0xEraSwdMW7Qk6BZAxKUEMy9G3BE47Dou/4yXXeakVa0OTSVG+Ta+ApsrNq
	Nwtfw1yr5i5r2IBIMEMi8sEyhwkoT3NOrIUZ3+uveGa9tqeRrv47CIOJDnaY62iHgHXHspIEs=
X-Received: by 2002:a05:6000:1288:b0:45e:ed7e:f8f8 with SMTP id ffacd0b85a97d-460304f07b8mr2783510f8f.8.1780648414528;
        Fri, 05 Jun 2026 01:33:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm24140153f8f.9.2026.06.05.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:33:34 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:33:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Mike Rapoport <rppt@kernel.org>, Jan Kara <jack@suse.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Dave Kleikamp <shaggy@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Kees Cook <kees@kernel.org>, "Tigran A. Aivazian"
 <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <20260605093332.7b067876@pumpkin>
In-Reply-To: <ximvn6jwgtam665a4droqkp73o55kwvd5uukyidwjesmysobth@oe7rigpsjfkz>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
	<20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
	<yfzx3jgzwesernofl7mzixa2mhjfii5v3o7yapghtmozixrpfu@6bsh7iixyiov>
	<aiEX4UTxEnBTjVKo@kernel.org>
	<ximvn6jwgtam665a4droqkp73o55kwvd5uukyidwjesmysobth@oe7rigpsjfkz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22301-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:rppt@kernel.org,m:jack@suse.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:konishi.ryusuke@gmail.com,m:slava@dubeyko.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shaggy@kernel.org,m:miklos@szeredi.hu,m:a.hindborg@kernel.org,m:leitao@debian.org,m:kees@kernel.org,m:aivazian.tigran@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:ocfs2-devel@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:konishiryusuke@gmail.com,m:aivaziantigran@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pumpkin:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF64B646740

On Thu, 4 Jun 2026 10:05:52 -0400
"Theodore Tso" <tytso@mit.edu> wrote:

...
> I suppose we could do it with kmalloc() with some flags which to
> prevent forced reclaim / compaction, and if that fails, then fall back
> to vmalloc().  Is there a better way?

There is already kvalloc().
I'm not sure how hard that tries to get kmalloc() to succeed.

-- David

> 
> Thanks,
> 
> 					- Ted
> 


