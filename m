Return-Path: <linux-nfs+bounces-18559-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFBuLGnweWnT1AEAu9opvQ
	(envelope-from <linux-nfs+bounces-18559-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:18:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E3AA02EC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A72C73038F34
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C82FE591;
	Wed, 28 Jan 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioWZMzb/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6628E571
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599010; cv=none; b=l/thGCGcZWN997K4FqCq0ZUom5SgBzEUpwNoaXF8or9uGU5R740T1Z5qHF3v3x6RQl9UC+HKyJyHyECiO1+f/NRci/UIoFb5GCl2Yl5Xp/mY/2fhm3R62RbOKJ2/TcC2V91TKWYmS9WB/8s2PwqVEisapTIPGepHJ3rrePL9BzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599010; c=relaxed/simple;
	bh=wGCY4bS5bxdyEjE28JW1gZnzqX+vO5Uux8mFkcXxF5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaU1hFyah0S5XBMAH7KrO14DhEqqLn4SMrCsU24nRq9wdft+7A8FfS9bvihBI4ZBJ6PuX5UA8/0TAf0J6+g9OX0DjyH/IyCD/gvTzNDA7PSqKz17vPnWtn1q34THps4HP2D3cgDIXbT799Z72IxwQGdCC6MW7NhHxgt7l8QP2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioWZMzb/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so8606046a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599007; x=1770203807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToKWdSItVHI53efzOxtWevg4AOceET8oQ5ajtU8G+Jk=;
        b=ioWZMzb/hs80v9XHgH7rJPJImmnrOM5Pb5MZHWhAxlhaU7HGif1qIvg8uy6jDrF3o2
         jz4RhdXYevT8wxdvGJdbAurRBn715qLe4q3mZHu5vhV3ZLmnaQbKOxEi/M2r7lrqHyrR
         4okx/Y7G1JiIfBQ+5M2bdApG0HVRbkH/DVYNJs/d7Uo32XBppuWhzNf5k3cofrvyewTy
         DrokeOeIycbwwswlfo3XI8k3j2xCC6gIRC68lW26V9W1bcf1edxR9e2+FI9WPQGL1tNZ
         A+cYhhL2W+LXkSpkVJBl+4CDMlGU9jHebqH1888MObU3cyQ5d+afcJ+GoQuxz83p759a
         V1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599007; x=1770203807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToKWdSItVHI53efzOxtWevg4AOceET8oQ5ajtU8G+Jk=;
        b=cbMquMLo4Xs9OXAjNu287GXt1PzEbK0jGtBKLqYCWnnLFA+PjsAPiehk7P9/huJKpd
         3PC06xRPTWTwX0bFFvhJ5eociubI0RrelvNmU7Q3ERBRap5W+7RzNF0MYJER9JOZlsCA
         YXdh6VGjXVizn1oVFeHP1e2MaBMNRA++8KxDOvCZJUJ8eD5RPg+C1lC9D5q6TpSNNJ5Y
         FKviveIq20KwJ0QgMfqx4DeIZdEg09MjwMwCvEvYnPr9hQ5yvNrHmioDV52op5HXQObR
         QLbLiXdGxXJpTfoBXDxeieXxzD8HZg/76FaOXxY3KC1Q6HfbvAQL4T8qJwiJJGSGvC1W
         6cgg==
X-Forwarded-Encrypted: i=1; AJvYcCWD6qCZzlIhI6Wy/2GId5awKlcNwJdyCrX1sGg5xiVQ/1KYVVHKkWCdHQVRSyIpjPKRtmWGP66fvrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznwjD3jJG6wwXvGddxVJwkgqKKAZ+Nq7SsjAbT/CRUoh5FPjOa
	rWKQ7UjCWGU1knpwDX/rv96AhRiBYGigrUnGLv6az3qgI4p9n6Vq14dQ
X-Gm-Gg: AZuq6aLWr+RXafm1IgWRJ69nAtr4a92BalygUS5FjFTisTOGdqae7ejSRaV/yXtn6di
	71t67PEmFwXafdEnp7rpm1X3ytTfzVY+pKttHtvJ2oMjbrPoEwnZWFf1X33Diw+wG+t2YflLVuD
	pDM/14L5Fl4aqcxbJTlU+p/2tWK/dZA8IH0Ts7F3VsMr+WMq76L4aa2SS8G22Fz4CTNU1WhtVkk
	HEhAlA9fsJLkKEu9I4drHE63GxCkOZY2dY2rUnL4YH9e0jLPcXoY8DZ0aGSo+AVb2JPP4Bt5Ftn
	Y9pkufu7vhHTUO6fMsfnDbu9GsxWT6Unyz9H8Sf/LHBzLMta/syyHQ9If9cS0baVxVf7vt72z0b
	3e3dFdgI/FAtiDubV5gN0M8G/+JyVMKHFC3dzsgvA6lwpNQHFSnnd4Z6ZOogscSQrew/eJ7UUnR
	WrwfDfeIgJz2NSkjfk/Eq1RckH6Qu5gjZ4BANOLo9ijyYD4qyOnqruw2y1HwBhttSP33XFB5IM/
	n1XNu/h3QKEimqz
X-Received: by 2002:a17:906:209a:b0:b8d:cbb5:c072 with SMTP id a640c23a62f3a-b8dcbb5c7c6mr64727966b.57.1769599007089;
        Wed, 28 Jan 2026 03:16:47 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-970d-2293-1f03-db81.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:970d:2293:1f03:db81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed500sm114462866b.63.2026.01.28.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:16:46 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] nfsd and special kernel filesystems
Date: Wed, 28 Jan 2026 12:16:43 +0100
Message-ID: <20260128111645.902932-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-18559-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35E3AA02EC
X-Rspamd-Action: no action

Christian,

I noticed that the kernel-doc refactoring queued on vfs-7.0.misc was
going to conflict with v2 [1], so I rebased over vfs-7.0.misc and split
it into doc update and nfsd fix patch that could be backported.

RVBs by Chuck and Jeff were removed due to the slight changes in wording.

I'd like to acknowledge that Christoph wrote on v2 that:
"As last time I'd be happy to help write documentation, but even
 after looking at the methods, their documentations and the commits
 adding them I do not understand them.  So getting an explanation
 from Christian would be really helpful to move forward here."

IMO, further clarifications of the new methods is very much welcome,
but should not be blocking the merge of this patch set, which at least
clarifies the WHAT (to use them for) if not the HOW (to use them).

Thanks,
Amir.

Changes since v2:
- Rebase over vfs-7.0.misc
- Split to doc/fix patches
- Remove RVBs

[1] https://lore.kernel.org/linux-fsdevel/20260122141942.660948-1-amir73il@gmail.com/

Amir Goldstein (2):
  exportfs: clarify the documentation of open()/permission() expotrfs
    ops
  nfsd: do not allow exporting of special kernel filesystems

 fs/nfsd/export.c         |  8 +++++---
 include/linux/exportfs.h | 25 ++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.52.0


