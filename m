Return-Path: <linux-nfs+bounces-20951-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ZTaOZf95GnDcwEAu9opvQ
	(envelope-from <linux-nfs+bounces-20951-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:06:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3AA42493E
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE858301CF84
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0B24EAB1;
	Sun, 19 Apr 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGZGceJL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865315746F
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614804; cv=pass; b=Jj1DZlxsmc98HGr8Gob6eOmNfDBi6jEoc0y/xm9SpAZoJUErqkcoAr8+La0u4Y32+sULV8grL0Nw2wwUVNPedO3jhZNHCZvAirOBJUor4S6U+ne15YFch+IWsw/w5l6AD6SStxbw3nXWAKDzq5JEwRrRdhEHxco8jsL7pBfJNyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614804; c=relaxed/simple;
	bh=F1YKUAQYFijXZrG0SRbjxLz8Lqy1xMRJfSD4ih+iTBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuV6GCSiFPMZchXlN3hNkYeT8zt4usDICJdero/O3eCQE+ArExyck6CP+jeGgRPgof41Gi/c0d/1BsrpwpUVa8pd55oqXd0lZoGUvjy20D+BEK9jE0sQXKQX4UrkLVvLLJmgXydLtSHhXrkLNmOVJIj0Nz5zeMb3ppdAi6oniNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGZGceJL; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-956948531a1so513850241.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 09:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776614802; cv=none;
        d=google.com; s=arc-20240605;
        b=SxfUpH2X/pp4CvVQEoOeptwsOcgjVzO9xd4F8tvD4C/2Ptwhlftc1KFf3XKonUNWZY
         t9tz588yhsfH70la84MYNIg9WWka1vYjQBmV0UkSxPakDtlAX027RMtwmguHB2J8JABL
         S7jMPzNpg0ezjqPcPRY5lOJUJIRuS5Y4KR/TrkW54mhs1loCluw9PSfrNz4Xqf4j36W1
         cw7nKw4S6jtjL8qpjA6iiN5384IV/9tpLZm4ikEVNYFMq5q3eYQLGfXj4h9gtPVkUq1F
         dTtLyxH2o5KJ0kC1jKn+6Sp6rOFAqF4/bDVlkx+cikPpAfG205LhuMkNJl5gb/TecLEY
         H0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=15dNuudv1CMvECZQVBZvQjDuz0Apk+Zw9+LFePNCFx0=;
        fh=56sw52SBxf/Q5r1DxERB2rMk5ZvBa79qg7YuMWLUtqE=;
        b=WjxvCWYf91nly68xDfIRcwngzjUBUvHHjkBH7fZqAl0a7DpjTnA91DDfW2gFUIn6Vz
         aAbflpO5JQv6TdOxkScMdLA6vI0J5pDqTS0hhk0/153T+9UZbZVzJ2e9pVy9LgNghSRi
         5AW/eCHTiRhKzBgrIghAi+C6PoSiMeESmim6wASmhcCbXUbjUJhi1kADlybYeMgW8ojL
         RqGznkI9prEDCMVKl+qWPakL9Fue+oMvl3rd00sWgk9rGcrzW6SMjIRzdS3ZyA62HC/L
         /Ml5O2A29VCIPRG1GM+HQS9Bp7yCvDMUMwGPRL/WJlw5VFHchsSP4J4tY1MODAtUf/0p
         evug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776614802; x=1777219602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15dNuudv1CMvECZQVBZvQjDuz0Apk+Zw9+LFePNCFx0=;
        b=QGZGceJLGycduBH5u4r3+5WWhTk0XBfubgX9uPEFa/UwyhOG+RpUQTnkNTirYxNOaq
         C35r2jL2pjog+vi92T+xqt4QJ/WXzADD3AMsMFyTAnnSZ3isY9eLxkHlhYylrFvyt5Re
         n08Y/bwDLJKDECPrP8y+vCDC2NkVitYdEqkwJy6KTw5Vba7UblAjdFAderPPzm/lwBFK
         wFry+a2Y35ejilDxwWpPTasaTAzguhrs6E+xEtsTGChhkasgIV82N2Vz7h5FhJPteojF
         DbDdbel69nAG42dNc/5p5enQnGOaAT0vGX9kJW9vtMar0nTIrFSl20SzP5Ajy4niagf5
         rNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776614802; x=1777219602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=15dNuudv1CMvECZQVBZvQjDuz0Apk+Zw9+LFePNCFx0=;
        b=WmhbOPLZ2LgKhGkmJ7TmUNwsJzDwcaByUl8fF41yLX6im+I57uy3ahuMfQCavlT9O4
         FkULZ+tBXuImZ20RxiLFD98FcLgqDFafnXmuh/PBs+i2jM9At/J86T/TLSiC01Hza7I2
         7tnYsGKU2Q//fWAE+dJjMLzxaGXy9U3iKkeBRJhp/pSQGBOlIwO1DUkyNiw4TVqcj+tf
         VB1oXIUj2XvmxWYVqY60WGmFEIYMQHSwtZE4DkWtgqXKUoaq4XQtZiGcz6UvoDMpEtFD
         R9Ddqq6fpeksqGd2bUXX2JxH0s+ckkHGRpocaGSqylIIYIPaFIVivYcqf/fKS8nEdusB
         yF0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ormWns2IInk1FJ2EOIRuIiOK/T91b86LTHE5G/jEJQstjVeAaEkfDm4SmoAMoL6xH9D24Apj1BLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaoL4gWT8C3qlq8s0GuRJIvnjx1q7kyzrav91e+BsoBzwryTx
	kSIDovqA+dbCbb5+Llj0MSnmnh2uKn7AEiyhxkhLHJpOS9ibaWtPln5OW1jmSLAaVTgnJxEk5yw
	HBgh141x7oeVO0x4xX8dogF/N7uUS5uo0OflH
X-Gm-Gg: AeBDietiLbmlUMEqYmX59y/JDL8ZzecXyO3vrKUjmtq3mtUsj18FRcrjgGeazkXhQG1
	9NZnW56R+qbHalUZv7C6rTXbN1q0Zym4tp2pGtN18Awl9FVEh9H4Swa25ufAt6/npjuUqYfru83
	HCIAFZCkNVcCuegiMu0h6C0AwmT1G0jWsy71qIBiqPvPRXrT6pZHtM+DgRqytG4Y+y2gB1suzac
	273+sFkDzmzoNhjAQjeSHfPoA4KIZG8gicEiULzZVSM8yvaQWe55SR5B6jDqXC3Pty9HOuj7KAE
	2/0bjmhVTkD1X/j1fQ==
X-Received: by 2002:a05:6102:2ad3:b0:605:b96a:a0d4 with SMTP id
 ada2fe7eead31-616f8fdbdbdmr4041968137.27.1776614802225; Sun, 19 Apr 2026
 09:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419100128.20546-1-seanwascoding@gmail.com>
 <20260419100128.20546-3-seanwascoding@gmail.com> <35E1BD18-1B61-4F71-B50A-D1C830760562@hammerspace.com>
In-Reply-To: <35E1BD18-1B61-4F71-B50A-D1C830760562@hammerspace.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Mon, 20 Apr 2026 00:06:30 +0800
X-Gm-Features: AQROBzCZz3QnXYZf62c-00-k_GhXWTQT9k2Ii-cepJ40pStn8QOM4bJHFZ7xikY
Message-ID: <CAAb=EJWsP_j-u+7Tqb3-7Fh3adRDhjOAGo-HF69xEB-kkCoqiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20951-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 4F3AA42493E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 9:52=E2=80=AFPM Benjamin Coddington
<ben.coddington@hammerspace.com> wrote:
>
>
> > +
> > +     if (!xprt1 || !xprt2 ||
> > +         !test_bit(XPRT_CONNECTED, &xprt1->state) ||
> > +         !test_bit(XPRT_CONNECTED, &xprt2->state))
> > +             goto out_unlock;
>
> ^^ I really don't think this check is necessary.  Aren't we only ever
> comparing with one freshly created, and the other looked up holding sb_lo=
ck?
>
> I'm doubtful this hunk is fixing a real problem.
>

Hi Ben,

Thanks for the clarification.

You're right. I've traced the call path and confirmed that
nfs_compare_super() is called by sget_fc() while holding
the global sb_lock. This ensures the existence and stability
of the existing superblocks and their associated transports
during the comparison.

Since the connection state doesn't affect the identity of the
server, I'll remove the redundant test_bit and pointer checks and send out =
v3.

Thanks,
Sean

