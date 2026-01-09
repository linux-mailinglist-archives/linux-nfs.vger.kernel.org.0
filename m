Return-Path: <linux-nfs+bounces-17685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CEBD0848E
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5CB304CAC7
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654813314AC;
	Fri,  9 Jan 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="Zeu+7bXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498C358D38
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951654; cv=none; b=Gjpbo4c6SRdcaGH09lqS1i33J0ycTgbl6aZw2vfvk/QkeSVw6dkwJRkqF536QhPCriZDx2WB5yWk1vf6joR1ddJtfvyK0sDSUeaFa/gmd0OE3wXcT5wX8iD1YfCqZVlUxUk5TaStcauQl/97+YQXdt9+14x1XmZOmtAJa9JIZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951654; c=relaxed/simple;
	bh=WlUfMFTSR5NXV8PTyJUGBCRu66E4qeCqhb+irbNnf6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdxdoHIv9PDOzzkwHbDl61L/zduaXIhkWdHG69p8CiS58gmRyHLmPlaExXHT0WCIIzCd67nLma8SxdWmurHJ95lb78h7qdeNuH13OGL4C0adIQfxl2d+pLQOQvNL2f0XXCVaBPa61WfPMI1Hjd4AGGMcpXEYOYeNFvGEAe6bL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=Zeu+7bXK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso5807008a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jan 2026 01:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1767951651; x=1768556451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QDGX/cEgwPsY1AJuZmrKEco8i+3wBOf5+Du9VGD5j7w=;
        b=Zeu+7bXK0DJSHm2/wf9KCSPkHhEUIYMwNqiL694mqt3axXbSw9zec8x3Obb+Fk7a3X
         c5ZaqCC1gcWqGc1qgdsNk5JR6UDWKbnZSyHwpdkIrwk+GB6HLGlm1+AXtrZ6bTIpWrou
         lZzCfqEKu4+1NCsOkevM48CaSabnNmWQW0VWZ7TsFX4s46UOKSPePzdI1mmK82mhzPb1
         k6Nxwzikep5mmF2BMFvcOcQ0jKU9kR6csH4ErVAke4Z7Ta9fVl7uOq7wlSlbvGLdZrZn
         sa2ljp1p6hb+i5U7e5nFvL6Uu+EMpHNq5rhGtH/6kKU0mWzEvj5zVDJ07pefOCQk05VH
         PkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767951651; x=1768556451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDGX/cEgwPsY1AJuZmrKEco8i+3wBOf5+Du9VGD5j7w=;
        b=qjed5SKlMGWiPRNCs+FIBxkVchI7PX88BoECR6dHcGfLbH6pkkfi3pyv5P35MgoY15
         rJh22jChNSmmd5a+MuZcHUAq3VLahqhdIouhGagqD9vIN3xOayjCOjGr2E1HlHMPryeo
         /dtUoplP/0Ir6Mw9LPFEiH0G9nVSzlr0Z2jdwSZ+BhuQYLmR992lcCqSDvKgtwzG8klO
         JKn+OALosbKAKDqZm6uEHi3P5xqGY+KbvdmEtfbUAafAS8H1KsxVPKBLtheowzO4I9HD
         XfnBviMou21h9WFRHopoE2cwin2XF/tn2/cSLrks6Vr2ADGDDVoGkuuSca85ALLm/CWm
         Q0Cw==
X-Gm-Message-State: AOJu0YxDhMkSW7EzOV0AEik/6t1rrBYhk3ed8BXrYXhhHUEHqVWzX3EA
	i/0zFdVE7FwMzx/ej7NVpFYWrO4xT2h/UBa+Wi4UsEYwouRkwN2hCeQouCLmrTVMvvQIagbIFvu
	0H3x8S+UTLobpSPWoGNkN7QIEHqI3NIbvQitTqVL6TSpZGnHZsHGOHT/cGg==
X-Gm-Gg: AY/fxX7fcwcZR8ooHt8w975C2CR3PElZIx245VMvU94+35jqUWZRVx3DUmSmQXZ5Rxh
	bJu1pR9gQvG4rL8iF8RHQOWUQ+G9p97azg50nVL18LtV3PpUFuC9Yf19jU0nDLbe2hWeqPlTBl2
	zlvLInyiL/Fgzl7d7jhipX01HgeI+4m+U12RbmlhavgDV58GhxUEm6d4y3TtUaTlUO5A6XBROnk
	vrroyOJtKigZxsdl8sOqxGcAP4TdUa8NiaZkqYfqFWVcWZfQtWKf1eVPZ+vnX74/T+u7Q==
X-Google-Smtp-Source: AGHT+IEiG02FVemaIu6Qba6wB4zsTVcC0P49SbzwaR4xWcYHBjel+oixUpU2t3S3/EeBbSb/UTFL4EYpQ9A+FS115/8=
X-Received: by 2002:a05:6402:3586:b0:64c:9e19:9858 with SMTP id
 4fb4d7f45d1cf-65097e50ccemr8119510a12.22.1767951650846; Fri, 09 Jan 2026
 01:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
 <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com> <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
 <CAPt2mGO_gSfO4He7XeeENKuWD_+rbxa_z+hRJxNgQ8eC0XzZWw@mail.gmail.com>
 <89582fe2-2ee0-452a-9226-063f4b20ef5a@app.fastmail.com> <dcba5f89-7603-4abb-821f-f5322e964c40@app.fastmail.com>
 <CAPt2mGNXuktDMYeh4dhs9Em6Jjb8k5pcRGaYEjmFgSszUz9wjQ@mail.gmail.com>
In-Reply-To: <CAPt2mGNXuktDMYeh4dhs9Em6Jjb8k5pcRGaYEjmFgSszUz9wjQ@mail.gmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Fri, 9 Jan 2026 09:40:14 +0000
X-Gm-Features: AZwV_QgLaVoRpXWsldV7Ch9N8RlLzH3b8LN0nv2PCFYJXi0UZX1C8IXutOq-2-s
Message-ID: <CAPt2mGOecb1WR1Q42YE_RkbqqQo=AbvOOp84ZeJLJOc42CKyHQ@mail.gmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Well, my first crash with the latest debug params was quick, but the
ftrace buffer was empty...

[22183.614070] Dumping ftrace buffer:
[22183.615747]    (ftrace buffer empty)
[22183.617613] CR2: ffd6eb25124a0a08
[    0.000000] Linux version 6.18.2-1.dneg.x86_64 (daire@lonws12)

This is is how I interpreted your suggestions:

echo 200000 | sudo tee /sys/kernel/debug/tracing/buffer_size_kb
echo 0 | sudo tee
/sys/kernel/debug/tracing/events/nfsd/nfsd_slot_seqid_sequence/enable
echo 1 | sudo tee
/sys/kernel/debug/tracing/events/nfsd/nfsd_mark_client_expired/enable
echo 1 | sudo tee
/sys/kernel/debug/tracing/events/nfsd/nfsd_clid_destroyed/enable
echo orig_cpu | sudo tee /proc/sys/kernel/ftrace_dump_on_oops
echo 1200 | sudo tee  /proc/sys/kernel/panic
echo 'p:kprobes/refcount_warn refcount_warn_saturate' | sudo tee
/sys/kernel/debug/tracing/kprobe_events

Maybe I missed something.. I couldn't add the refcount_warn_saturate
kprobe though:

trace_kprobe: Could not probe notrace function refcount_warn_saturate

I definitely see the requested nfsd trace stuff in
/sys/kernel/debug/tracing/trace now, so not sure why it didn't dump on
the oops last time around.

I'll try it again and then try the suggested patch.

Daire

On Thu, 8 Jan 2026 at 22:16, Daire Byrne <daire@dneg.com> wrote:
>
> On Thu, 8 Jan 2026 at 21:33, Chuck Lever <cel@kernel.org> wrote:
> >
> >
> > This fix:
> >
> >   cbfd91d22776 ("nfsd: never defer requests during idmap lookup")
> >
> > has the possibility of being highly relevant. It's in the nfsd-testing
> > branch of:
>
> Yea, that looks interesting.
>
> I've applied (all) your recent ftrace debug suggestions so let's see
> if I can capture anything useful first and then I will try again with
> those patches to see if it makes any odds.
>
> Thanks again for your guidance.
>
> Daire
>
> >   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >
> >
> > --
> > Chuck Lever

