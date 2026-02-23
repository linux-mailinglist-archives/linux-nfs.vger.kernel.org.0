Return-Path: <linux-nfs+bounces-19148-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PIhL+G3nGkqKAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19148-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:26:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A417CDA5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F252B3032CE1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109B36BCCC;
	Mon, 23 Feb 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leIJjH2i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43E361641
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878367; cv=pass; b=BKtvX2qxdqIpxsmHepRLzeZwsgVaFvE6cwfLUhmPjjdkjybbNrwNf5YgFHlTY30IjjO0WCbwUvR4xOSS9mcKVWpdzCW1asTuBZU5omz7TTAiKHcuFvA0Wz0finmPaKDonRsOklIibRTqFrIbEi+Xm6is7jcQrQgPOouyf33QkHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878367; c=relaxed/simple;
	bh=hBLy5onbOnJFwqz7bEebAhzAc4t2l1yEZ4NHzytzT+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=irnBgKnOwazuhPyD3yq3ejdvqSCxP+auES0RMbn2nywsjP+5I6vFlbQLqWVOs31MXaDIUtuxwpz2QSDUUyFUr7FLi2wLQ4bVHnYpTLpCUDlLrRkiZEJ9bBU/7HR8u3KFNJ4YaPtJgThzrmB1cwWIzo4XC1SfSlTtzUJWiztxh1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leIJjH2i; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e6253b16bso5330414e87.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 12:26:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771878364; cv=none;
        d=google.com; s=arc-20240605;
        b=jo5FzLu8qfWPO86boZK3cCAg2y8wYf5mf7zydHde+lD40TqmwVlOJaCy+5MrPq3P5a
         ShyI99WUVQGDua4zD4cGxksnjTq/Y3gzdkvapSnJW9zlVMlQnOKWCdXEE/MJfcwPxw3M
         feMnetllmmxKybGsTYNchKpi6P3QZq2ExKuMETvTU0VnklcbruRhV3vA7cL4Ys7TgofE
         oI43p+Yym62zgxTtWG4M027BDjw0MufGfVR8z8dGX7/yEdXq2luBc/PCJcMx7AbuwRZi
         IzMm5nfGINR9ddfsVfM/yVvn/Iz+yMW+sBQEUURO36Wb4DKE9Tx/2uu/M1n491U4gdo7
         Z6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBLy5onbOnJFwqz7bEebAhzAc4t2l1yEZ4NHzytzT+I=;
        fh=D9WwyoP5LHrUwBcOsT42Oby6fYiYcGzW/solReNrVdE=;
        b=PfNYdbG5HhelvGPfYGEc51oLNGXTHIE7gc8YNLi2Nv3uUUGm9fo9/tGG5QzNGGIEf3
         ekjFzJrZhRCgKcFabz3At13oiRlGPBbIWWT/DxcZ+oBG4ZoVjkgPc69TWPegv52GCiTI
         xEzDNec2+tyBIKCvY6QMLGXE0POLQPjQZVv+NvmFtBr8tf43mNBeOicSSTMxlij17CM+
         ezkUe06+55fwDkvetgKRqZsGByxeP537kdPgSBFOQUU76SiwyPXPqbQogjvOyRZwGaDo
         YIf3+wX3jSmSh6xxuwv+Xs3Mhi5gIXuuM/leepPsdk+76d1jkQ7n0fDsXmoC7ZJmXLHS
         ObqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771878364; x=1772483164; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBLy5onbOnJFwqz7bEebAhzAc4t2l1yEZ4NHzytzT+I=;
        b=leIJjH2idVotI/H+EEAgCW+7qmsVS/Yv+5Bf+wkjeFs53PUQCbtuSRQ1phJifOQ4WX
         0E231/v8fxax/jcAgxbNPOYabaDgt+RkzTZSxLEfEdrIPaq3RYB2cnMgzv2yc9ThPmXp
         w4Vd7zMKzrHU+S3jAVIk+pHq+yA0Vcq6RWtj1Wmm1/+D9uqd8Q/v7MUt2VDQt6L4zsAp
         T4MOfhEVM13OWyQsYRn14swOUbFjVIlUFUpTZAA2+2brLorcimGOuYxupl4rBui1UGkj
         qpeFNQR77VA9ZLJ/by3obSXZ8Ilj4HJhIeDKgJhQTgfeO+Rh0ouQElI/VdDpmamWbxyV
         wvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771878364; x=1772483164;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBLy5onbOnJFwqz7bEebAhzAc4t2l1yEZ4NHzytzT+I=;
        b=Pea6HZiyCXJN6H3t4hQFvQ5hrG46YyJJDVHJwSPriGgad0EJOZt0oDX6Po/Ehc24Vq
         X1sNZQ4UKD1UV+ELGuZ9f+DDH5p6etgCW0C369flOK+g+1qhIx1u+Q+JvR/nTQt1YfWU
         s7P2c5uiI4NV/92wyJVTSSVT3l+X9g3vxl/iVNEL5AiDrwXx/x0M6S2ENrbM8x2hV45v
         8yao+5j6u2DGP7dWnpvNuB7IimXXX43joLgW7HjFALS1dnoA+8tT+5YbbiWK+q2bXscz
         EVFSOs6TjGnFPQAJR9NKXhGWXSdZFV2Le2E1rSLyqrZNE8EpAq+f7zOTHTRhsbecwsIp
         kUpw==
X-Forwarded-Encrypted: i=1; AJvYcCVotMtVyEcPvQdzWIdoC7YvT/ssqVxX7N6xy4ABpwATnyihkkfcf9EdNWRisGZMYWUwnDFA0wq1vtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5S0kYb/WZcW2Z8IMg2zJkQSOUBmXbHOUGv8kw4cE6nuN6gY+
	IfE+1rzOy2ShMJBBzzymLhWS6mhlGKpDWurtPAfwntyttKsnh9iZlo+FFppgl/h7RAKDCao+woE
	mhPzquIK2TGGhU+PpAg3ChWvuHhxM1Dg=
X-Gm-Gg: ATEYQzx2kg2uUtdZqLi5NVAmNpGFvaH0FAZgXMSntRnjVH0IB5XnTJf+dSmGzmlypDK
	UgH8UUq/GJDbYpchsBiXayf+cUkw5BGplIjZuJ2ZA5c5SfWu5VS6OSoegx8eUDzu+73h+GR0SJT
	lJNM9dIqy2ZSHFXXvZSw8g7/vek9/Ry2kZJJQvsJXfii05Q7KPCAB1knFNqmju/DU4X95m4lTUv
	UmFXuCoJExi5JxQ+J2uLzp+FdPD2dRfZxDseJ9ovOrJ9CZhx0gufaClCiUsCRwXX+I56G7RTUQv
	DI7X04E=
X-Received: by 2002:a05:6512:63c4:10b0:5a0:ee11:8d92 with SMTP id
 2adb3069b0e04-5a0ee118debmr1942939e87.8.1771878364195; Mon, 23 Feb 2026
 12:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
In-Reply-To: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 23 Feb 2026 21:25:27 +0100
X-Gm-Features: AaiRm52cSS7rLoVEF2mgdeaGubSj3ljnHS1dMM9YSoIwZmUVSOxuhQZTSbJXzl0
Message-ID: <CAAvCNcDw+FgjEq-Vvx=yD2sD8Fwr5oVfahK03mCUgiyC7nKsGw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
To: Anna Schumaker <anna.schumaker@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19148-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danfshelton@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 474A417CDA5
X-Rspamd-Action: no action

On Tue, 14 Jan 2025 at 22:38, Anna Schumaker <anna.schumaker@oracle.com> wr=
ote:
>
> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] ope=
ration over the last few months [2][3] to accelerate writing patterns of da=
ta on the server, so it's been in the back of my mind for a future project.=
 I'll need to write some code somewhere so NFS & NFSD can handle this reque=
st. I could keep any implementation internal to NFS / NFSD, but I'd like to=
 find out if local filesystems would find this sort of feature useful and i=
f I should put it in the VFS instead.

Anna, what happened with this? Even a pure software implementation (no
SCSI acceleration) would be a win, as less space is used on the
network wire.
For a sample implementation you can use at nfs-ganesha.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

