Return-Path: <linux-nfs+bounces-7522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF59B299A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 09:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A41F25EAD
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E918FDDA;
	Mon, 28 Oct 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/sUto+u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED118C900
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101575; cv=none; b=uOCF2TLR3QRXcIhRS1qI8pITzTCwHgua9nMGVqy7JzR/cHNOX21DDHhlQEnm9DRW51X+DwFbhcnPAiuIGxMag4t41KZ57odWZJaCecLurq2mSWB8L4fI4fiHVw2erR116papNzkwJsXzVVfOaRXqS7bj+AgtIX4SHXYgMTi1uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101575; c=relaxed/simple;
	bh=veLHZgnNnuv6jXGoHBbz+Ox0JifjkHtVniNdIdthaHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hqe7A85z4h0ko7mSnhsuTc+sIDxQ7pBuWuivwot8R5D4Y8I06/wcGgukU+v8EYuelVmv5ZxvuP8cMhbFfU84ZlkT+QhYvGywiy/0Srmj4KdEr/A5rnxoxKMUUlWWqFlM8CGYmsC+CheuOxPqLr9a8LyU9n7i8s09ppH/RV+wHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/sUto+u; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so5307730a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730101571; x=1730706371; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Z+oaI0ZSoPabHUTutgy2Aq4UtEITtPFc/X502oHbHQ=;
        b=l/sUto+uZ0i336BQwtmqB6gICOAc/BPxrlWmhfttURF3uHf0WPv0nwuyDw0xlf+n+d
         Yg62M5KRh7EmjHNC6S1F7SbzqO2s9+Zy0c9DCgVS/R7kXdbW9ozr8uQDnEXsU0cxGe7B
         NyRdZLosyuM6YQN6wxB4f9fanKnv5MwajkXxamwaiekqMCVvoDiyEp6yE+W4Q4Xbf/w4
         xYt67Ady1QE3yhyEe4AYsrR8xqt55wXL5lHgavTnxVCFF/Uz/pxaFCKd4foVspFZciG3
         7rqMdbQcYaIgOWAgp6T9kqVxaEd9sOs/t7fmgsitJ3KPZFj2PNUXxogWA3YX5GFNTlyR
         kYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101571; x=1730706371;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z+oaI0ZSoPabHUTutgy2Aq4UtEITtPFc/X502oHbHQ=;
        b=Wdi8AhHSbvigXlQ/BIYv8vd7hPEvOBXVzCp/YiOGhGwDo5q7t9wEkJWDloYr/lAnbD
         NiRn9Asi9CgEkeyMQvz4pEyuHNvk7VX4yrzMJnYP2Z9Y/ujGXTkXMnjCgS0XcKRqqELF
         cqjYsoSQLV60P2YuH1sp6sT8ohyXnl7/bC2oXeza1KcBkmCq2TmQUulP0i6Dyaxru9zh
         4vgECP76Wgf5mTGi3+bbzlg4vezFXT1+QnN/9GhdjE3a0iKQSubgqlbvOot668rwwyv1
         PlvlGM5wRfaZKIs6OfKQ1uU5n15q8Q3YKRvDRekRNdXzKHZL5rBbDEryLo8Hg1BGdUCm
         /neg==
X-Gm-Message-State: AOJu0YxvXwZg/khG0a2q3PJKudZ5IRJnAJO+3sqvdO39WiTDB/Rhwyh8
	7T2cfqljq5TaWbllVGNs0mMeiuNvjyS1TquY9EjNAwa9YuIQ1WcAXKZju8QydK+101NSarVbaN5
	ZJHxYqvhsGBrspnHTPlsaDeR0ii84X7Do
X-Google-Smtp-Source: AGHT+IE4III3onjGK9AN0dpdfh04Eszitlb1RCkMTe2M6VOJgarvqM9x2Z00XMrok9YxYMilysvXRfZqya5XrejJnRg=
X-Received: by 2002:a05:6402:194e:b0:5cb:7443:27d4 with SMTP id
 4fb4d7f45d1cf-5cbbf90eb86mr6364686a12.25.1730101570911; Mon, 28 Oct 2024
 00:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172972079577.81717.6397186554656127040@noble.neil.brown.name>
In-Reply-To: <172972079577.81717.6397186554656127040@noble.neil.brown.name>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 28 Oct 2024 08:45:00 +0100
Message-ID: <CALXu0UeGKrTpH2J1OemmrS2Ab3-mtKQwgHGG6GcSJXVnzjHDYA@mail.gmail.com>
Subject: Re: [PATCH - for -next] nfsd: dynamically adjust per-client DRC slot limits.
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 00:00, NeilBrown <neilb@suse.de> wrote:
>
>
> Currently per-client DRC slot limits (for v4.1+) are calculated when the
> client connects, and they are left unchanged.  So earlier clients can
> get a larger share when memory is tight.
>
> The heuristic for choosing a number includes the number of configured
> server threads.  This is problematic for 2 reasons.
> 1/ sv_nrthreads is different in different net namespaces, but the
>    memory allocation is global across all namespaces.  So different
>    namespaces get treated differently without good reason.
> 2/ a future patch will auto-configure number of threads based on
>    load so that there will be no need to preconfigure a number.  This will
>    make the current heuristic even more arbitrary.
>
> NFSv4.1 allows the number of slots to be varied dynamically - in the
> reply to each SEQUENCE op.  With this patch we provide a provisional
> upper limit in the EXCHANGE_ID reply which might end up being too big,
> and adjust it with each SEQUENCE reply.

I have some concerns here:
1. How should this be tested? You are adding a random element to the
test matrix, without an option to manually set a fixed value, or
disable it. At least there should be a hook in /proc to set the number
of DRC slots, so CI can simulate changes.
2. How do you provide backwards compatibility to clients which do not
implement the number of slots adjustments per SEQUENCE op, or
implement it wrong? Just  claim "its the NFSv4.1 standard, and legacy
clients should burn&die" is not an option, otherwise AWS&co will try a
Jeanne d'Arc-style punishment on those responsible
3. How do you handle changes in memory, e.g. memory hotplug, or
changes in mem assigned to the VM running the nfsd? Is swap space
counted too?

Finally:
4. Windows until Windows Server 2003 (leaked source code can be
googled) had this kind of memory autoscaling for SMB. Each Windows
release before Server 2003 had increasingly more complex code, with
increasingly unpleasant curses in the source comments about unexpected
and unwanted side effects. After Windows Server 2003 this whole
machinery was yanked out, because it was much more harmful to
customers than any savings in memory consumptions could ever bring.

Why do you want to try to bring the same nightmarish experiment to the
NFSv4 world, after Microsoft failed so horribly?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

