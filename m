Return-Path: <linux-nfs+bounces-18952-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDJHHDLrk2lX9wEAu9opvQ
	(envelope-from <linux-nfs+bounces-18952-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 05:14:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF3148AF0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 05:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CF03019916
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2925B305;
	Tue, 17 Feb 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frU9r1aQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE8258CD7
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771301674; cv=pass; b=sH8qAeY6gceQsshfgs+aikD28mFpeHYb+3ZakN3GI/Abegd49vZrIeGPIUSrfd5JDydlWWDkofDjBy0RwnTKcITgum+J6BIzPIsA4Bth1SjVntZwvq8d2h+2nTSzvMiBBeO/VvgUUzfYZfjZ1bvvnaK/bgl9Tya8SEl2HQnYhYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771301674; c=relaxed/simple;
	bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RloOgjXu5n9xMYsalaM0y4q8ap373OgXz69BD1T8y+2IFoQoV+XA9TMAjm0Cf/6/iVYpcfYjSLJ2GI8YRAPgDFyuQHDkbVieMn7ivgkQ2zSnYKk+AzIIHV4imXK9+Cnf5iFMa0KVX3eblYbzeOWMeLN1lA06/5pxC97hAoxaTtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frU9r1aQ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65bebcbffe8so3140944a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 20:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771301671; cv=none;
        d=google.com; s=arc-20240605;
        b=dDLJHcE5x5jYJIPiY8lBxqz8Eg5JKPVvqN599BlSzNcMcrKa8Hl3rx1wF+9YrC/ttp
         hhglROliftfG1sHa8KRtYTvxtushkEz2I55Vj76TgMTrXhfHKz32dk5yEjby4M4FJcED
         n+1uKaqKGFHNG7FSMK8wHeT6i0Csnoo8rTh0xLSXu16Fl6IY40fbI+0sKbYFeb3urwtQ
         wb9blkw8P7M/VS57tQPcHD4JkwgOSfunkd9VVJJazkV3vVY53ewIkjFwEpAWLMbb9EIT
         /fgQEss4DVAg+z4E0UGCqN5C3C6A5ko9BfnQ+wi7fk3EsW/FBVR7+4naadOZ1dq2UaPF
         g7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
        fh=C3YqIVhyYLkkgb0YUJ7wX0seLp9LULS4+1THJjKGSu0=;
        b=PdplxmKl4INlkD601KuxgWXlLvURbFeJD5jAqI5JOvzqwo5n/hPMZabJWXsxTfFJmC
         RZXdYThcI0GPuSmcVq3q1Y8T//oV1OXwS10Au1NUpPN7BICW3S2rRgPK/aqN7AaZM2d4
         C2SZ3/ldNRj7TVu+5zRsgRnA99Bt4DmPiRmiD8fjKNjWE5e1iQSoLTTTT/KbMDA0ODRA
         hRMQ8XK8LivPFnFAcgRW9M5A91KQ8362TN7dp70lnON6dzdSa1gLzG6W8InuhxsCdVkq
         g0X9gnBqEPEanXnKiT1K3Lu+uvkn2TMw6DCSf20QN2TJPEHtUa+Y7aukknCSlckZqBLb
         0ptQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771301671; x=1771906471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
        b=frU9r1aQzw4+qVjkdlz0wFF4WcsZnuG+7GoE6RmXGgXbKH5XyIT7YRYi9o9kywK680
         MpfuggRA0eNfMF06O8JKzkVMLPJOTPX6TOrjP7n2dos/DC3PfBCyWuuy+Wz+3nSf/KSC
         SXY17n5EqmA1q77NyOBul2ZYU3Sl3jz0wmtro3G+8KT0cXL/bWB1pdvfahwXdLmil/F8
         TsrENVvZnaQdWGghHJebwx1gx1uaRS/fNqOycVBM7LuMPAKcyj66FZHuHiebHgmLkojB
         6KO/FCE/O/yFVjILTpjMcHbEHNVPPgTJLXEtNn9k/KAy9y1mAOwQDjCkmTv7kx4vLLZt
         qBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771301671; x=1771906471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
        b=FF3eEjpBWPluaQPRdwZqVcScZzpmAUkjDrlYTrxSFMzqM1+1jim2OuHrUZQk8R2ZHA
         3jEUiZ7D2yltTlyLmHcVaXRhtXfEPmuuO5dTU9OYXiuaaPeARnR7I8RypP/Qxm9szPqk
         8IZ50GQnYhOEMYrLiss709L6/dzygzmEbS6d69h9GVXRbEnjeaxeB6ZfZ8NjeCuKSu4A
         j6JGJUeB6pN4QInLA/if5CbFK9aOxusELrYuxc+usykwgxbf+nqJi2C2datMfvYS0nLj
         Z/QfwP3341F2D0Jl0s2Yv1eHOil4xnAK7l1rl9O3AbkWD3XQ2SSMWdP9GKHyLo35OQf2
         ig5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4jFhFSl0O7DmO9UxETuNEPLS3xF4CR2JszKHu0iopFHQhlALzJ3epU2L6aLooCurnkfMMqrQCS8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaIwRqqW+DkPemrVQRzgq0hAlzX7i1w+CDEZV0uhCtHjJKwv5
	B+XTLPuqoOderGQW0tF4hS0jxQHi1lS6IFn8HzOTMOYYSFMaSqSePS/4R+CdCrarPU8vvC1X3jY
	Orm5wIvXe0U5a1LNVP+AH6o5omLHLLc4=
X-Gm-Gg: AZuq6aJ9QofNwNLRBkZN3G5Pjc5viImyGgFxnTFjyO3ToMGbMwM/ir+xHJDcMZZKxyH
	05SHksrnN+EtFkJW3gZJ6eBETyN/WcKFsEjKY+lRPtZt7swRtu19He2mJzLrYPiZdeW7DcPI1B+
	tAu26MKWtpoBhwXyenjx9Jc3+F3P0vL+GqLmej52N6WtqtRbS75ejphHbK05ebe5mslM02RcTg+
	rxSMoTJMu/MRgEaY45z5DPBNjPbPCUsakKvFzPdDhmyYspMLUuYzuQUqtJ/hF+ubXu6LzW+0uCB
	bgy6Yw==
X-Received: by 2002:a05:6402:278b:b0:65a:409c:6fe6 with SMTP id
 4fb4d7f45d1cf-65bb1161199mr6549992a12.15.1771301671063; Mon, 16 Feb 2026
 20:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com>
In-Reply-To: <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 17 Feb 2026 09:44:19 +0530
X-Gm-Features: AaiRm52qcDduH0WOoiy86XQ-uP4UAzjzDBGWAMpuxDVbnPDCNM8VzO-fhxMilbY
Message-ID: <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18952-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BBF3148AF0
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
> On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
> > Kernel filesystems sometimes need to upcall to userspace to get some
> > work done, which cannot be achieved in kernel code (or rather it is
> > better to be done in userspace). Some examples are DNS resolutions,
> > user authentication, ID mapping etc.
> >
> > Filesystems like SMB and NFS clients use the kernel keys subsystem for
> > some of these, which has an upcall facility that can exec a binary in
> > userspace. However, this upcall mechanism is not namespace aware and
> > upcalls to the host namespaces (namespaces of the init process).
>
> Hello Shyam, we've been introducing netlink control interfaces, which
> are namespace-aware. The kernel TLS handshake mechanism now uses
> this approach, as does the new NFSD netlink protocol.
>
>
> --
> Chuck Lever

Hi Chuck,

Interesting. Let me explore this a bit more.
I'm assuming that this is the file that I should be looking into:
fs/nfsd/nfsctl.c
And that there would be a corresponding handler in nfs-utils?

--=20
Regards,
Shyam

