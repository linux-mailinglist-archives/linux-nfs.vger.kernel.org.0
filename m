Return-Path: <linux-nfs+bounces-22539-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X3ZhKsBvLGpnQwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22539-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 22:44:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B681D67C60A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 22:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jVwsdnMh;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22539-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22539-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02D8E3005336
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172F357D05;
	Fri, 12 Jun 2026 20:44:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785E34D3B5
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 20:44:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297083; cv=pass; b=fLCNJxn9mvcMBK56ORUUT3hPR6OHsLDa/oP6jnsbInRi5vK+VkovgkJ8UTHO0CxRM4sz3teb2OmwuHlz0kBU9QirsPo9YexZZbHNZuBoVIpESM3Pmwy7UqnPfDp64tLlw4YneJ31igLXENJZkcVPWtJUp8NkPyRiL+mRcuQdeHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297083; c=relaxed/simple;
	bh=Tmc0PlLyPHGJZfw2BCk+8OiQMoy7EwvvDRcVIjjAsZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dHsqqHzMpsNBFBi7KaUdz4earQ+FjF9TptlaJgfHgvJDRRll+fjebmhkY8SW4qRu/mv6XZiJPv8vyO5Fq83MwbLoqzWXBG14pEdPSvcxo10hnYRUc7UxRbioBQAn+jFQ/sT2qKi2l2RGlkzxgUJFRUvA0fyvD2Z7ZYahT6dk2kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVwsdnMh; arc=pass smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so2327410a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 13:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781297080; cv=none;
        d=google.com; s=arc-20240605;
        b=JAtP+KZpOBQN+9JWogf255E04NhneUjUPpHpube1cH+wLxL4JjeCg+eFuG3tvRZSzK
         fTDuVoX0gop0/qRGMPbwPox/Nwa1zNwtsoqmG76hIvuHnJkS334wMQXlEbygZ+lnyJyU
         OeAZDhmqKaGNT1j+XXA78DJqjGecT/SnZ/o9kggz4pBkNpOyuqEL7qEZk+Pg50mQGyQ1
         tobZscAN99zPnvY9Krv417Ou87leF+imkZ9cVGr9OOwDGzcZRlEIm/AvpsBDmn45LpD4
         7mqRDOPzSBxzZg3hbKCyUjR1J2GQPzFX7QzEFT09E2ff4zJD2Z0iSPqfzZ0YgeA6JBlN
         6vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tmc0PlLyPHGJZfw2BCk+8OiQMoy7EwvvDRcVIjjAsZQ=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=FbF3vzs+KAEeY2ST6A9gjPnow0G2TNCDLjqXfZZXQsW7SKzZb61R7jkza0qrEy2ONQ
         BYVFrXBaRxHIsWl+TJXH4jpoKhuBdeEmMCfj2hbWG6kS0W0FfXR8HT45fTblORR9na+q
         dVVL1Ix5wL9xGy5BqoqbbNRWoIa7Vm361uLx30zSLjSzq9klYYdZK9ee5/1oXt+04qg0
         HOHimeostOmdaqTB3fEnxGoGLdinEBE8lpauvSlOQp3jYaCoNmApdUzYMks8sdELFFdr
         njPODUg+dJb8p7DjT0HwJEtjOW9RdpYBRDDrTQdSonWnGfYnjZXBqo2tMv7VsND37bHk
         NwjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781297080; x=1781901880; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmc0PlLyPHGJZfw2BCk+8OiQMoy7EwvvDRcVIjjAsZQ=;
        b=jVwsdnMha8VZi0eBS6YnnJiKl5yszZcUaUy2LTf/3/55GMmfjk847bcCh5Y2x4NXzi
         N+w9nJey6yfZuX2B517Loj4FB/d2kMI3NDARH57CH7TdGQowhmfJOtOxjykKOaezAuoq
         nHPSE+jz/VZGTenyiModuFh5mPUFLdTeNU7Z3MLzMoahUSHsyuUZPU1CkJNM+bPPNgnL
         x9YKdGZyKO3FsGmtWirIF/x8yC93H5hBmDKCjQ5D10mwNhFcOmmE0X7S9rEzfYexWLzZ
         tSelynuZG7R/kxRNAv/3yKNY8odS4ZyAxqeLyBjfm9qJ3Q0LsbjTaX2PLgM3MYC3K+B9
         5AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781297080; x=1781901880;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tmc0PlLyPHGJZfw2BCk+8OiQMoy7EwvvDRcVIjjAsZQ=;
        b=F/Xj+Csxvvf2Ms9CWGphYhRhA2eYUitqXqM4g3u+cCu9sV6aZ+EW5du8k1qzIZHIFu
         2mUJhfpqDLBIaiqW3n5Mtz3llKTydM/ny/kVgrxwZKiKqUlDr9jML/pMZcGVUm0nQxmd
         CAP+fLS1qIew0E63rOKSiM58r0TwwNmQJF9jMuv9fPyALrd2PaUmZXcBCrLugxtSzAgl
         ufZC7x6Ch+auyMkroU+Z1KR8LrdLR9R+yxDVbuwMRFh+DhjXwRBRtluf40kB0GcPL+Ra
         Wm/L65ukPBvKrKw8y5D/N5k2h35oD/2nktpXeEBdafyWolIVphpJgbnY5oOkyjMxt8Wn
         LXdw==
X-Gm-Message-State: AOJu0Yzf1rSuD7OWiJ+3yMXl9rWbUD25UR+1cLUj1UQdbyS0FdycrpNm
	ObDf8pWKQ8NAY3ylU1+9KLqkVrx35gzi8h3W4BaGLAljxlErPWM2YYPk8uiEQjUtkcCAtwugXWH
	X2kJa2JjK1wRhU0Y4+hx4BO/0wPSYQqAVnA==
X-Gm-Gg: Acq92OFMk5xPQb7BWMrzsc4y4j8gezmnp1w6XJkB9nOhd4MJkxxVF3j9kL4MLsP4e4L
	aSetwlJlQR6QeM2ZggRRSZRV7T2yWT/LW7qW6ETnCJP8WYR+pGcVlsFmdBl1dtNGaln5GXeM8TN
	Bx7b2hppOoBC1/BuIZFYvIyrp6by7mh3iGXUks3A946I+Bwk9gdzEJlrTABBygAvUxDcZak9sHT
	GgdXnhQUxKc7PzfP7C155SgJoyGMyitYNcgqsm6Ohyh0EPSGIUGgNeSF7PSil9HrA+00YQwEgVC
	sXvuOADBBQ==
X-Received: by 2002:a05:6402:40d3:b0:693:a30e:6b22 with SMTP id
 4fb4d7f45d1cf-693c6baf582mr327249a12.22.1781297079884; Fri, 12 Jun 2026
 13:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDDFWyZezvE3yBB+5sWpYqDrYFk5k46ekS+ij-5Ajp44w@mail.gmail.com>
In-Reply-To: <CAAvCNcDDFWyZezvE3yBB+5sWpYqDrYFk5k46ekS+ij-5Ajp44w@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 12 Jun 2026 22:44:03 +0200
X-Gm-Features: AVVi8Cd3llbpis8LkIGdbZ1q8NXMYeHaehvsXoUicYMJ2YcKRY8024nhFLK5WeU
Message-ID: <CAAvCNcBf5qbkTx+7YXMhqZOAbQ829TfeixwZ4u0-tF_kV=MFbw@mail.gmail.com>
Subject: Re: I/O read and write *latency*, why is it so much higher on
 NFSv4.2, compared to P9 and iSCSI?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[danfshelton@gmail.com,linux-nfs@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danfshelton@gmail.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22539-lists,linux-nfs=lfdr.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B681D67C60A

On Fri, 5 Jun 2026 at 20:43, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> Except from the freebsd hackers mailing list:
>
> On Tue, 19 May 2026 at 00:39, Bakul Shah <bakul@iitbombay.org> wrote:
> >
> > On May 18, 2026, at 2:26=E2=80=AFPM, Dan Shelton <dan.f.shelton@gmail.c=
om> wrote:
> > >
> > > On Fri, 20 Feb 2026 at 01:21, Bakul Shah <bakul@iitbombay.org> wrote:
> > >>
> > >> On Feb 19, 2026, at 11:45=E2=80=AFAM, Dan Shelton <dan.f.shelton@gma=
il.com> wrote:
> > >>>
> > >>> On Wed, 18 Feb 2026 at 22:45, Dan Shelton <dan.f.shelton@gmail.com>=
 wrote:
> > >>>>
> > >>>> Hello,
> > >>>>
> > >>>> Has anyone tried a BHYVE with a disk as file on a NFSv4.2 mount?
> > >>
> > >> Yes. [I tried this on a 15.0-RELEASE-p3 host, nfsv4.2 mounting
> > >> a filesystem from a 15.0-STABLE machine]
> > >
> > > How about the performance? Is it better than iSCSI?
> >
> > I don't know about iSCSI but comparing with p9fs:
> >
> > Test1:
> > dd bs=3D1m count=3D4000 > /dev/null < large-file
> >
> > nfsV3:
> > 32.3
> > 46.3
> > 51.3
> >
> > nfsV4:
> > 129.1
> > 59.9
> > 48.8
> >
> > p9fs:
> > 17.7
> > 17.5
> > 17.6
> >
> > Test2:
> > find /usr/src/ > /dev/null
> >
> > nfsV3:
> > 60.0
> > 39.0
> > 30.9
> >
> > nfsV4:
> > 54.0
> > 17.9
> > 35.8
> >
> > p9fs:
> > 6.9
> > 6.5
> > 6.6
> >
> >
> > So slower in all cases. In addition the variability in nfs numbers is c=
oncerning!
> >
> > p9fs doesn't cache but nfs does, so anything cached is served much fast=
er.
>
> How is the situation on Linux? How is read/write *latency* NFSv4.2
> compared to iSCSI and P9FS?

Colleague of mine said Linux NFS is much worse, because of multiple
CPU context switch for each NFS write to disk, NFS read from disk. Is
that accurate?

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

