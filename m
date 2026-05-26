Return-Path: <linux-nfs+bounces-21943-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OqFDK9qFWrxUwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21943-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:41:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF685D3827
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104BD3040F95
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E63D7A15;
	Tue, 26 May 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seiq+CXn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE43CD8AC
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788156; cv=none; b=G9CleVpeHZ9/I+BiL1vqdPU2H4KGNsJhaUM113L5f1OinDj3Jl0EGf/0aIurjeVtS4YBS1GXkquSkpmM6eItwUJ3X06Wz1xWaCaefJstEux8M4zFZR90+Bc63OCTZIcDrNXnzLEhpMGn2gH+A77hSqfzlELNBG77egM6r6rw65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788156; c=relaxed/simple;
	bh=sjU7RHyInlH9mxFug2LKz+GK48Ojh7vR1sjgQ2TiRGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtDAhr0et50KorfErspu91sdhMlhMo9R7jmjw0AzIGyNGVota2EtmDkfHZhaeB0l2rsanjdIyBMi9VpSXu0SJvHmA2nzq6QNJ1qxpuSDqrNAJ5SnCzrO/63WmTFHRKOXrRQKCUokbSGvw3YY7raLo/GByCvpVTH47GyxHtsv9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seiq+CXn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so7966626f8f.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779788154; x=1780392954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bHfAVXmh3q3FWdhM0EExqsSxnDVRJkOcr0NBrLZ8n4=;
        b=seiq+CXni9aIGbLGM0VXkKywgsa47MjhfAeycLy7TY/OhjQlRKHdvx00QtlkzFePb0
         94cFvPmHHU26vJWePAZj2+oA9GlBflkrO2GbNq1VpcTR9q7MzohCl2Dd1X6Ng7rQil8y
         HdVIbj3NgV4BzluSo9r4qPLEaCSRDsKBiEkYgwXEJJdERZJsBJDWjY3UA7NIhDpqnege
         QtFQRzkX7QvdA9XHnI+h01j8LEiDgfS4JPMni7ZC4le0GIdAHwnucmFIdvGFq9b/9vZV
         EsuUHym5brztgaVyeivqdcarrbd8S4BvVUFDB/IExFltz22m1SxB6Dwhzw0ror8XE253
         I70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788154; x=1780392954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bHfAVXmh3q3FWdhM0EExqsSxnDVRJkOcr0NBrLZ8n4=;
        b=BUM+3OHpuALFpRe5qny80a6JOIGOcsyla6PBQCZAyZ0O7rPoQwPxPmOYkjahhi6JvL
         lGu7O5kxDFlzd/W2tXBoNtPaxParownbAJyTwShynq04IhqOvzKckkpaqJ+TQkPbC65R
         cu1AxGDsDjge/zbcrmdEImwZ2rAaLzCTVzYOTFBpEsXOAg0vAnjYD5xMHlhchJnAk7zQ
         Sk+LX0pt7Smhn0phaChhON1Vz3o21jImrKrd+RrpOm+IjJ5yzpk107YE7dbvwyM2p7M8
         M879u+Y3Z2rjMVI1LwH2GFy3qCUANdBKQLqoLQZ/rqusmL7BXutuYCa+VE+Qcf0MUquM
         A2Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8+wfc0Eb2YFoGzh0tzN+lS/BGdVZNI1ngmtQ/X6ci59cLRKUC4Phn9GNE1IP42QKD1qOPeCn3HAkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/PxvdunkvcHXWxYPsJgR2P2aaBetBpyRIn0u05CQoZLTKXhS
	Hc3elUXA55aQwQHVvWM3Fo47yD+xxuKxiVRYmSZf9TuQnhzhzRxOVznL
X-Gm-Gg: Acq92OEhaF1/mN+8sX+F3J7mtl7lzKjEvHQizkLFfz8o0oxEuUXKr0sp+Yhpb2DhdTb
	5vroLDou9A5S34c+TWUAWvfhVlJAVMtKgrx6m4y/tlIKNaDJJlJ096HcnUCwGxmBJFWOPey5uV0
	prhULQBEkp/eFRH85MtGszX4atSwLQ4DInQ2twigKjwKuXnDqctWcWtKT0tAMw/ECoWab96d3Tm
	GDWdh9eWQkt5N4Dg3oWm70HEtwEte6kKvsoPWrt9ub3ov7KOMHox2AjbblMTFRsZWPehBx0eFXD
	ht0gvIk1v6HQRmzq3CWGXv5GD0ry2DvKrvVS3Bk4qEhA4LSTs6eRuEqlundBqaC6qN2rtEZNjBp
	1Fe4v7cWRTZbQF817TKetxJYDWn8ea5dvauz+6uRzdOwDSZwvhQJfVXj1GnIFlAjHdv9hW2puB4
	ZngQECUVe3uy0PbQqkSICofCahXwEnKJutEfVcP03b82tOoRf6jrJthIJv44dLx0KFst0S0Ndgz
	cQ=
X-Received: by 2002:a05:6000:4b07:b0:43c:cf25:f29a with SMTP id ffacd0b85a97d-45eb3689049mr28173297f8f.8.1779788153530;
        Tue, 26 May 2026 02:35:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d64eb1sm38023448f8f.32.2026.05.26.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:35:53 -0700 (PDT)
Date: Tue, 26 May 2026 10:35:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>, Andreas Hindborg
 <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Kees Cook
 <kees@kernel.org>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <20260526103551.0a05ec07@pumpkin>
In-Reply-To: <ahSNFmwAA17pMy6o@casper.infradead.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
	<20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
	<2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
	<20260525182134.04045610@pumpkin>
	<ahSNFmwAA17pMy6o@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21943-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,mit.edu,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7BF685D3827
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 18:55:34 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, May 25, 2026 at 06:21:34PM +0100, David Laight wrote:
> > Would kvalloc() be more appropriate here?  
> 
> no
> 
> > Does __get_free_pages() return physically contiguous memory?  
> 
> yes
> 

Thankyou

