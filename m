Return-Path: <linux-nfs+bounces-11958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66730AC7195
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 21:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431411BA8809
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012721FF53;
	Wed, 28 May 2025 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z1DTC82d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128821FF41
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461162; cv=none; b=ZtzB720/Lh1Wz7le4nre7fH8IKZ7G3SEMHjibRYp4fQdZBlqnhKMpfcMogR9CeRS6f1TYDHHO7D8z1c4isbZim0cSccjO+qJ7GdTz3aSWoNFDPGKianUv9tmd3UV44DwV6o/yOeRYREdgRCcu1WvcfttbaodrOwlgID1CohIS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461162; c=relaxed/simple;
	bh=6EB90aStD6oZtCtsMlLsrlS/zerOaqvnwH0RivSpcTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3ahwf5xPurMTsSyZTw1oiv2rEroaSOtQ9ptpS2aUwJ/WFkOXmBp1U9Hl/5LYQDf50SYQo7tdmqOxlaYSLESsKRZwUJiU1plI8fdhCGWBhuqxchYsNKsYsIyO4MDRzBRrPibniS2tZqyrJzQ+7cSGYz2osiHfuEEhlMR1VyE8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z1DTC82d; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6021b8b2c5fso335263a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748461156; x=1749065956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8e2i44Gr0oyZcRxefHfwT++nWQEkaT/mt94UZHEUYc=;
        b=Z1DTC82d/SGOJl7+oBejVF4dQncwQQRe9ZEaDheJNqcm8DSrCpHSAKx+3GJ+7pgs/r
         Hu1pP4j3JBaYh8DhrPHlJfl24+cS2lTg3KhgRlkvGznftAwJNpwXpHC9PxW1vpkrUXF8
         oQzp5Q8Y+e33a34CF/Zct3Rd4FtSbU2wB09MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461156; x=1749065956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8e2i44Gr0oyZcRxefHfwT++nWQEkaT/mt94UZHEUYc=;
        b=hmEBOfJJqf3VlCa2z/ezkeIlNhDoOucfEmEEf6TPqrjM7WaSfPA3jMmIgSSvh+FRzd
         suOhBk5XRUcNztenSNwUAVinQSDihjRqibrkpLVh9m9tHiURmUMIX94PVy2egpIMNoWj
         U5JwUqPCjTewwpKURSD4go5Xi9ZmHHi+9pnLYKrsTVpPZj1fRCS55mJBGdJ3uNNxIIhd
         2/4mP+NdqNbAftt4AhGYL2yTGXWBcf9etbsKmRxEzEUxIrPCjuV1d3TCuqIKeqipUIhB
         iPl0YN0NLP/skX7g8ooe2whOgff8WNMXr2Rc8BMY6g1X79XeoTPnsWPU7gA8BjUFWOFj
         3RVg==
X-Forwarded-Encrypted: i=1; AJvYcCUcGbkjOBW3ea+TB2548mi8+w57V2mMW53ZG8OHjzek2PsMVf8fMSM5DqLxiBGHdASwMUH73mQXBhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtY7E0Ev26yJ4ih5Q/wrOHRPlyagc4bF7DRG956pVBxe45h7D
	v+WVdt7CZY6qIdkMt/IJakH+nfhznE4vHSWaXzh+Aym9gz5+ST9/9d3AjzmOeTdkFgEhcIsd21X
	g5Lm0ETE=
X-Gm-Gg: ASbGnctp3/IA5xikmNtN9VuHd0RW7lQtB1usNypkrkz6XeNoxjJAoZ1AftI3U0401tI
	IMIA3T3JF/nwzbxUvwphtFEwTdmrZzVmm46mPZR82RvhRgblXuv7GgqisGyXs9HxxT9dTg9rLxj
	2fnLOPs/ZpvG3uK1fXfMddto+f/Px4g/jRTRnse3W5a+YFwVO0DTiJJnZ2MVwZ98r3gCFPq5kTn
	cZP31cQEKMv80a+PKNrZQTVsk1gRtVT9c7yBNBJIQEwlXvQ3B3RMK9Ypv2WOwcUn8Z1TOdx7m/e
	+qHvN444cOLEHbbdYpSWZFMSZCP6vYDv//Rdv7WuRfr3TzrC63EWC+n6sOpQ8P3ZnDAzPY1ymAP
	h1jILoW0UXplglzssV/EoOo69tw==
X-Google-Smtp-Source: AGHT+IFxrcCeNb9tpZNryo0zO4igq3BEjkE7I6ymQwMlkhMovCiUJAvYztFn+Wz1CJY1LxFwCB1Vlw==
X-Received: by 2002:a05:6402:278d:b0:5e6:17e6:9510 with SMTP id 4fb4d7f45d1cf-602d8f5ddc2mr15157995a12.6.1748461156075;
        Wed, 28 May 2025 12:39:16 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d60a4dasm1252870a12.45.2025.05.28.12.39.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 12:39:15 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac34257295dso18307266b.2
        for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 12:39:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrQ4nQLPLt6nMqmbBDMktKbdsL8oWusO2nVFLZCZ6q0a0V1n+7bzyO4iK7AbDHfIX5jVVtWtTSn9A=@vger.kernel.org
X-Received: by 2002:a17:907:971a:b0:ad8:9dba:fb35 with SMTP id
 a640c23a62f3a-ad89dbafba8mr449137366b.40.1748461154850; Wed, 28 May 2025
 12:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527141706.388993-1-cel@kernel.org>
In-Reply-To: <20250527141706.388993-1-cel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 May 2025 12:38:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggC6PP9ZNwKY7sEzdsC7h8qySA7pjqAchrYowniADUQg@mail.gmail.com>
X-Gm-Features: AX0GCFuQ-K3drbs-6E94wWPS_IuA71tVG9YGA_q9hwV9_Skek2OUDDsjT8zlJ6Q
Message-ID: <CAHk-=wggC6PP9ZNwKY7sEzdsC7h8qySA7pjqAchrYowniADUQg@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.16
To: Chuck Lever <cel@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 May 2025 at 07:17, <cel@kernel.org> wrote:
>
> NFSD 6.16 Release Notes

Pulled - but I have a silly request.

Can you fix your kernel.org email sending setup so that you have a
real name, not just your login name?

This is not your fault, btw. I think the kernel.org email sending
documentation is actively misleading and wrong, with

    https://korg.docs.kernel.org/mail.html

and the 'getsmtppass' output saying that you should do things like

    from  = "[username]@kernel.org"

in your git config (or mutt settings), like you were some kind of bot
that didn't have an actual name.

Konstantin, can we please get the kernel.org documentation and
getsmtpass output fixed? We had somebody else who also ended up being
nameless (Ingo, I think) due to following the documentation a bit too
slavishly.

We are human. We have actual names. Yes, the email address is
important for setting up email, but it should be

  Real Name Here <realname@kernel.org>

not *just* the kernel.org user name..

               Linus

