Return-Path: <linux-nfs+bounces-6795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B658798E3FD
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2024 22:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C84C1F214D3
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2024 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74E2141BA;
	Wed,  2 Oct 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hcl-software.com header.i=@hcl-software.com header.b="Y3vY6PhW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62F1D0E28
	for <linux-nfs@vger.kernel.org>; Wed,  2 Oct 2024 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899971; cv=none; b=sA+XCxoWNn4fOMkgxltOgp3JYD3dR6LkTs2xNsemQsxswSbejNlgevq0oTOQJrbWSKOUxZZFcZLas4iDzWG7KNtDbzw2TJvWcgUc73Z17EkuxiaDBYfL2zGOghGLehwWhz/eSK8EA7jXLoBLoncuVJIFJq8VtsRDjVnjixEpd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899971; c=relaxed/simple;
	bh=LdNxp+6x3jArusgD/uScWjO7moP8G//lBZBJKQgF2FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=h2Wz6VxAsFJ98aq12rP8bgG8VHg0Y21lGulyjAGEC0u7t0FkJ1khnG+jZsdrnbwkDk/1Mt2dNqvek5hh5aB3+apAGlaNhqa46b2dMNCwIy33JcSGGqaVYiwmDKu0/TEfdxgfYm+FgL8SuZn0980OO1C/pNS1W2a2ud0Us0rzIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com; spf=pass smtp.mailfrom=hcl.software; dkim=pass (2048-bit key) header.d=hcl-software.com header.i=@hcl-software.com header.b=Y3vY6PhW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hcl.software
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398996acbeso170192e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 02 Oct 2024 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hcl-software.com; s=google; t=1727899967; x=1728504767; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdNxp+6x3jArusgD/uScWjO7moP8G//lBZBJKQgF2FU=;
        b=Y3vY6PhWgeZ8uoFU8rH4aUDPbZk7pw2Kx/HCdOvpmWJJPwKbwNEiaAYgGHXgAEmCpT
         zomKn5aeccHTDfwYTjfsYhTpz04cWjLiMqeYKxur5d3MH0HaIovH+ttSAnMLLOt1rq3E
         +hi7Xlqw35we/3xLFlnW1iVRYWPjRhl8eVEUD7uBjgvmT5P2AuhDcy2U+wHr+Row1Jrp
         HGVEUEmseMailY9LjtNgJue8o0Uh/71g/ckV6I1+Ga5GuxXuMU38IjGoTAjO2DppRg1C
         9P7CjpbvCtb+WbcLVQzPFOr2ze3tdYscrWa4B4wDj25bSiWyJkbAFo0YXh5SADQ9p20J
         ZsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899967; x=1728504767;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdNxp+6x3jArusgD/uScWjO7moP8G//lBZBJKQgF2FU=;
        b=seaqr5LfEcO6H08mqfsN6w0+GopAj7Qsf51RjjMb82yNdbcBlnVwku1gNCJ5uUM+ri
         aTCtRyrXv4VY8yO69gfgnfnRLagpbCi2rnd45/Dtuo3wCS59BmdptjCV3kW1zwF+9hB7
         du0kVVM2eRvdnMAFez7fnYTOZ0wwJucinWhzBZXgLc0LvO51jQY3Uj22uGLy1dtlm8bf
         XITsoD7KgtJaVRMBzkQb7Zbe7bHLA/KvfF6hLNfTujasRSrVIB27jr5juzOTXrFih2n+
         zmMTs7HaJpA8GMQgmRFI/uiBJHt/37c+uOYf2tieA5EHTAvRZDR2Rqw83ZqjGgwSHNdb
         bgOw==
X-Gm-Message-State: AOJu0Yw23RiOXtkIHcNbvTTzSUJSAuIyOo2jKQmuPwngvrRSSVLvGduZ
	JKZ+XQQLE7S1fPnVo/s7nx7SnprhiwGwEe0Dc21BUwLP2GyjznjUPjr1tsyvj3CIKT7zA+uAOBV
	R5fNi0o9XApCLAwrOo0Ae1H+NEwvgTpWpospmu+EDQo6B4XiiD/Ed5A==
X-Google-Smtp-Source: AGHT+IFUcaKne/zVr7ZGua7swABr+3V4OuSmqsELx14ARILhquH1uHpaorw0JqoFtoTJmIkiE21EezUDowTMQsF8uu8=
X-Received: by 2002:a05:6512:e91:b0:539:94b7:d6de with SMTP id
 2adb3069b0e04-539a067ae3fmr2523402e87.30.1727899967302; Wed, 02 Oct 2024
 13:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGOwBeVwrDSnhyDy8RkxA-fC2Zw2NYnTBOm8F2MLk7Q1waL3CQ@mail.gmail.com>
In-Reply-To: <CAGOwBeVwrDSnhyDy8RkxA-fC2Zw2NYnTBOm8F2MLk7Q1waL3CQ@mail.gmail.com>
From: Brian Cowan <brian.cowan@hcl-software.com>
Date: Wed, 2 Oct 2024 16:12:36 -0400
Message-ID: <CAGOwBeU7oZC0Q=KK5g5kkhhPKArLHHKondd+5jYWPt9jPNeDhw@mail.gmail.com>
Subject: Fwd: Does the NFS client send SIGSTOP to processes making requests?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks, Been a while since I asked a weird question, so here we go...

I have a client INSISTING that a process is getting spontaneous
SIGSTOPs from NFS if the mount is "hung" (and, of course, there is no
definition of the "hung" state...).

What is happening is that a server process that is trying to verify an
NFS path gets a SIGSTOP, and then, as it is a single-threaded process,
it stops responding to requests. Including any commands to terminate
short of SIGCONT ot SIGTERM.

We set up SIGSTOP tracing to see if we can find out what is actually
sending the SIGSTOPS, but naturally the issue doesn't happen now that
we're looking for it.

I don't THINK that the NFS client will send SIGSTOPs to processes
making requests through an undefinedly-stuck mount, but due diligence
means I need to ask since my Google-Fu is coming up blank.

Any thoughts?

Thanks,

Brian Cowan

