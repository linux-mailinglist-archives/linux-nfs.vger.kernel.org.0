Return-Path: <linux-nfs+bounces-20621-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H6GH0HnzmkRrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-20621-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 00:01:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6A38E960
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 00:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA63D3007ADF
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330D378833;
	Thu,  2 Apr 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBJzCsq7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8931B803;
	Thu,  2 Apr 2026 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167107; cv=none; b=k0KTnsXAl0U1zEWJXPFqqxg/0Ps3JXPapOn3I1EGDoeKTvF9US/PyIfdG+xpLI7tvChHd36X2Tl7BxvkXQId6eqjJ0CvRUFjBPnNvmh0R8aT2gMib5ftcekYMyYcmiA1YqUefTFMScCkjx1iMYXus6GRMr0nosElGxpPdOE0UK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167107; c=relaxed/simple;
	bh=QvUc9vANqYsb1luDp8UYk1f8BqkeVaTMVXLV75eutnQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DVJp2RZb27ELpuSXbKU4Hp/Y6oxtY4GVZi+hvh0cGpfFqwLi3iiECU8FkXW3LsP2E4BFa3lHd7gKiNOQi5H6gIaKO0hKHraIz2ZSgvjaY8pL8Nj3ueFJ33XzKXy8KKHzyLjplHoEp/PCfYJu8MKrJG/teYDsTZ/J1SYs3fWx0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBJzCsq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D96C116C6;
	Thu,  2 Apr 2026 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167106;
	bh=QvUc9vANqYsb1luDp8UYk1f8BqkeVaTMVXLV75eutnQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KBJzCsq7TNcgHpU+TWPAd3W8YuuJXdgpviR9Ow38UzYp/E+eDMYCQdUq5+04/Mnru
	 vF8yruBgH9Kqoxj3RdUA00tDQnEgnr1qE7AXbmqG7qka9IVu/f1eZKTg86JWT+ETrn
	 TjxI1jdECoYVYFvAydaPvhTr0DLyOkSNS0rHhfEWArmmkmeciwTpFwX+5aQHpstoUl
	 foXfbAlUvknuR2UINHvJ3kK1f5ozCCWUSVy6PFFL3eEN4gpoDz+keSHvFP6Ep2zvPe
	 Ej2doeiB7lotVTyVy6ov80wS5IsFWdnGSH4WR6z1XJ7lBV9TObDwXGWdYhpggyK3MT
	 1b1VbHt8uneOw==
Date: Thu, 2 Apr 2026 15:58:18 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Alexandra Winter <wintera@linux.ibm.com>, 
    Andreas Dilger <adilger.kernel@dilger.ca>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>, 
    Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
    Carlos Maiolino <cem@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Chao Yu <chao@kernel.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Christian Brauner <brauner@kernel.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    David Airlie <airlied@gmail.com>, 
    Dominique Martinet <asmadeus@codewreck.org>, 
    Dongsheng Yang <dongsheng.yang@linux.dev>, 
    Eric Dumazet <edumazet@google.com>, 
    Eric Van Hensbergen <ericvh@kernel.org>, 
    Heiko Carstens <hca@linux.ibm.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
    Jaegeuk Kim <jaegeuk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Jani Nikula <jani.nikula@linux.intel.com>, 
    Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>, 
    Jens Axboe <axboe@kernel.dk>, 
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
    Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
    Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>, 
    Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
    Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Sean Christopherson <seanjc@google.com>, Simona Vetter <simona@ffwll.ch>, 
    Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
    Trond Myklebust <trondmy@kernel.org>, 
    Tvrtko Ursulin <tursulin@ursulin.net>, Vasily Gorbik <gor@linux.ibm.com>, 
    Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
    Zheng Gu <cengku@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
    linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
    linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-block@vger.kernel.org, 
    intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    dm-devel@lists.linux.dev, netdev@vger.kernel.org, 
    linux-spi@vger.kernel.org, linux-ext4@vger.kernel.org, 
    linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
    linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
    linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev, 
    virtualization@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH 8/8] arch: use rest_of_page() macro where appropriate
In-Reply-To: <20260304012717.201797-9-ynorov@nvidia.com>
Message-ID: <ee15482d-22a8-9686-ba64-d216b25d8e68@kernel.org>
References: <20260304012717.201797-1-ynorov@nvidia.com> <20260304012717.201797-9-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	TAGGED_FROM(0.00)[bounces-20621-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FF6A38E960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 3 Mar 2026, Yury Norov wrote:

> Switch arch code to using the macro. No functional changes intended.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul

