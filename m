Return-Path: <linux-nfs+bounces-21642-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLXPOjKXB2r/9wIAu9opvQ
	(envelope-from <linux-nfs+bounces-21642-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 23:59:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43600558820
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6024B3013D46
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC843EEAED;
	Fri, 15 May 2026 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlxAZ0IA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84953EE1F7
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882348; cv=none; b=XDOdrKgvggdbZQMBvdDk+r54bDWSmptwJpxnq2bePrZZTDQVBvLyT6hdsuS2kEYIlynfTuTHRsz2U+Tq7DEluNkzJfo7kM9PbFtKkZPkGrRV+8FzFwLZn8pXq7/1eQywH72qbdR1dtO+LFfuvHIj7LcJy3PX0ln0KyMOYjcpAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882348; c=relaxed/simple;
	bh=Tefq8HvM4P5E2wSS3fwKg/uRUohzy18j3qB5eF3vc+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQjGvKUon5ThnQDfQFjwvtROO7h1CH8tGvylQ0+smNMuHtF4JpCB+99MqATDROOLe/l+6eqhLh0feI7fZDBR2q7Vc4ZGACmikf1s6ss+tKW2LIR0SJecO/Z3KwPRAZptixNt567uPp0oNoTz2Gcv2oXBJ3GpKSPZvoc0KiZive0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlxAZ0IA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A657C2BD04
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778882348;
	bh=Tefq8HvM4P5E2wSS3fwKg/uRUohzy18j3qB5eF3vc+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mlxAZ0IAIzSCHzLngeDmNQ4J6co9JfMfAyyTD56EEM12uxEwPF+d70rIFEgbXNu+t
	 nmFWRYoP8nH71/SzDNTwckMpq9wyB25aRToRPAIigrb7jE/X+huxz3wV5weJQEh3lf
	 ZsxLaxQxb/gZTw7PSxPLrOv75lNNcS2p2VvYZC9t6B4LYinmg6kLafUf0DfUj6eBpq
	 kZXCFWY/C9/weqMV5t5f0tzNqll4Mc26mgKMjPP/M9Z9q4x7BWVbGRpdIXWiR96TOE
	 0nKaYS+uAe3dGdJ5WvMJ67+DHS+m1Sv1+QgNDDJhKoqmJOrx70mm+Pc9QAldu7MgQe
	 B0cPfkZiG0HUw==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c305f381eso847949d50.3
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 14:59:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9xuXma4kEJiCeN3jXcdE6MN/v+y1gXl20wEVmkWjISd4i30R0bamOvP1Bv0YOXNEScPOYhkBIU+xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5sGiYfAyaZGz1HWiXZhSFS9bN9sowcMbjDaOo7mXuC5Eo4dX
	xEDKWXt/AxkuvCD/TaMbB7ep1qN59boZSSPQBnLslyiCfQLY11JekdW25md4Qqyg1Zj6gl9Bkl/
	A5+vz/Jkz5DQR5tvvnCQSxl1JRhnHdQfoV8ItZeD/zA==
X-Received: by 2002:a05:690e:4188:b0:65c:477a:2ad7 with SMTP id
 956f58d0204a3-65e22733998mr4980962d50.25.1778882347862; Fri, 15 May 2026
 14:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de> <20260512053625.2950900-12-hch@lst.de>
In-Reply-To: <20260512053625.2950900-12-hch@lst.de>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 May 2026 14:58:56 -0700
X-Gmail-Original-Message-ID: <CACePvbWMpfBo0zSFmMGLh7uxrpL2ugHCmD9xp=FC4aXiv9GYmQ@mail.gmail.com>
X-Gm-Features: AVHnY4JjyLNu3psg3JDksoA1h3sEopdVsiktUSZMp2g3bBnm0ZZ5mBGkhXfViRA
Message-ID: <CACePvbWMpfBo0zSFmMGLh7uxrpL2ugHCmD9xp=FC4aXiv9GYmQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] swap: move struct swap_extent to swapfile.c
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 43600558820
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21642-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,tencent.com,kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lst.de:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:38=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> struct swap_extent is only used inside of mm/swapfile.c, so move it
> there.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

