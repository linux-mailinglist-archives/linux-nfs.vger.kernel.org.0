Return-Path: <linux-nfs+bounces-1999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5F858A34
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 00:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C041C2241B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599001487EB;
	Fri, 16 Feb 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JttP4LrS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B41487C1
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126518; cv=none; b=DCZHJoovydt9tsgXOny+CcFRW7VpizZDBwbYvHtmiSVQBPTk+SCTKev+TVJlegVarv5NgX/NEQpGceY/VMY2h8ehuGR59YN3LxXfdoOj18JKlLxN/vn2dZ2FiDvzzdLX8EmR4ATOB+10WdxzdhGJvUBpSRq8yZtSjyBtrhQcK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126518; c=relaxed/simple;
	bh=Q80t2f6dO0gvZe7kuwhc5q7XogpcfQu0PLHcawxPOSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QuST6ue2OHz0u5oH+NCGZDFrwYXVXy9CMFc2KcT8iPQrN366kpgu54tFoWAL/cb6dFa1CwIIJO+41BcCPO75do/+n3PwlIEBS/2IdjwACrZoaMQYF+1ecSCtMga7V7VVBDQ8uX/MQlfrsE1+JRZvQvRrgb1iCbyENk63Vu5Zww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JttP4LrS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso32938951fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708126514; x=1708731314; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOKqGvfNDEUgHwRRt7cj847D86IPrEFE5b3kARdxa/8=;
        b=JttP4LrSCjDys7nPn4goW+SuJZtyZPAK7BwL9UPPnlWijX4Meig0QuW1bSrgqhzVD/
         1GyBy4eTArdHhWIPYp+HSHjLznj73n+aI2EmYpTVHGXR3l9vihCkjtEkak/ZrCMEywzJ
         ifZJiomszOIYrvyDTDCXbUGKcrL5tIiwV2nw/zCV7J3otH6mivzD0GUZOEb/XjVtltqo
         zvperM6X3XeOHlJYvlh4BsnGyuftFpHdUhGX/eQ/6NIGk4DZpL3CSk/9FTT1ZTAEpH/l
         CdfMpHnhRDz8JEcrM4JXtFrLdB2lY2P+6hh5mgoF2QJmcZPL1LaYUqvMgKDWLRxDh0Ch
         gjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126514; x=1708731314;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOKqGvfNDEUgHwRRt7cj847D86IPrEFE5b3kARdxa/8=;
        b=qYrjhzGdwFFTIMTnNRJK7Qtf09JhsTvZhxftDk5X/2fMgJx8flbar922KNcvBs4MzR
         hPwS6WjefHejfiHfmz9jJMXQS9cklKCP+4/iMrsnHPM/wZBDreD/7RV49osn94MF+GYa
         +XwOwHWY3NfPlWcjdIe7k5g9nmQJboVEtOHN8aK98tCCosTEEOwuRHBgh7FL5pJglzyZ
         58qif5N7cDbBajMN4ILG30SLro6epDNPhrxStwMj020EIEfm5lq0Reqi0Nr68/ZkF068
         Bl/YJUSUAlf0wqgRnGWWqLEX6mq/6EUhY8PCdB05AVqEiGnnrr3ZstdLtq6JcG8RTB9R
         3Bsg==
X-Gm-Message-State: AOJu0YzHCRgSmNeIQ9K9PjXJQHssHJD7gUFQU5QWgPs8FZpXzdhbT0uH
	fwbtoMpEAE8Wu0FI2xZfOQg/7lrdAyXF/2E93O3eMcZuamd707FKPiS8Pml+oCJvGwNT3/EBkGQ
	jTvS81Cp0wopozfkmV0k/QVD0mKiobh26lNw=
X-Google-Smtp-Source: AGHT+IE+KdlsxUV/7PmmKmsxfGI1fjkExl57dGpXwqHggakYUbwIMLhvC2QKXJ5uMntMgasr2l6uKMfI+RKi9sLXWAU=
X-Received: by 2002:a05:6512:513:b0:511:6952:70c0 with SMTP id
 o19-20020a056512051300b00511695270c0mr4134614lfb.5.1708126513940; Fri, 16 Feb
 2024 15:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sat, 17 Feb 2024 00:34:45 +0100
Message-ID: <CAAvCNcDDb4L2tcbBCcufFg=TLeFSrui4MHFuEeNUA+1VZyXLxQ@mail.gmail.com>
Subject: Re: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 23:11, Dai Ngo <dai.ngo@oracle.com> wrote:
>
> Currently GETATTR conflict with a write delegation is handled by
> recalling the delegation before replying to the GETATTR.
>
> This patch series add supports for CB_GETATTR callback to get the latest
> change_info and size information of the file from the client that holds
> the delegation to reply to the GETATTR from the second client.
>
> NOTE: this patch series is mostly the same as the previous patches which
> were backed out when un unrelated problem of NFSD server hang on reboot
> was reported.
>
> The only difference is the wait_on_bit() in nfsd4_deleg_getattr_conflict was
> replaced with wait_on_bit_timeout() with 30ms timeout to avoid a potential
> DOS attack by exhausting NFSD kernel threads with GETATTR conflicts.

I have a concern about this static and very tiny timeout.
What will happen if the ICMPv6 latency is well over 30ms, like 660ms
(average 250mbit/s satellite latency)?

Would that not ruin delegations?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

