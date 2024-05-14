Return-Path: <linux-nfs+bounces-3251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328538C5C8C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 22:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640281C21179
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 20:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C5A339A0;
	Tue, 14 May 2024 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="LMeuTYTb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4311DFD1
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720219; cv=none; b=RiYwTBGH8Hr8aaizf2Zk9PZSFDzGZtTXAq28/Ua5Mihfycuy1ikNVU9NuSvg1fTaWD5kCf7m4ADkxzP3TyzBIbl0Hm3rCdynqB9w8HhRNEJWHN2aTSl0YZAhsbV2+VGVjRcPCUntIgCQfLiRizJXUMPf6Ota756H+wzDyA2lMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720219; c=relaxed/simple;
	bh=aSmFiXuISYxIQNmBMyYR/qqaI/cO1V9LmBLRRKM43f0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FpPumuddT1shfvqqWrO6u0xljsJPM9HWFArA29+n63M31PYBQRkI/U/sDIFI+nQbrJOuCAfZzJfuT9L4hI3ORZQIch6R2mdOWCSS5y+VOG/aCR+m1+wYcEkCJX1EqtjS8kfYI+Umjp7Ju/TLDkAJg2PjgTi1s/mxN5vKivOQgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=LMeuTYTb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5218714c267so583896e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1715720214; x=1716325014; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aSmFiXuISYxIQNmBMyYR/qqaI/cO1V9LmBLRRKM43f0=;
        b=LMeuTYTb+cdUOSRvw4CbWzaucmE5Vk75GW0UiBohpvsktjrRt4D60TACS9MH3W6Pzw
         BD8zhILBrxBsew1QSHZb2xEVRvqdfrkH9CcekQ8A0pv1423arpR9f8DwvMoZWrQOXbpg
         p0KJgYjn0S84lOXE9qKmfoBgPFVy9O9RaTEPFzPCxPGvYlA/6TzU2MM3i4plAdgvBqLQ
         c533eLatLIMjBCcJSvq56KGAkBjdhNPKaT9dXT+QivSp8JgUHSIJR221hx+wBlxdZZd+
         JIUOQviRni/dTOxxikX1kA6JVtBOeBFPi0dRudSLrqCXDDa0goQtTbhHeTZvEqVWyLMc
         FYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715720214; x=1716325014;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSmFiXuISYxIQNmBMyYR/qqaI/cO1V9LmBLRRKM43f0=;
        b=vbdCMfsQfQv9O58PIq5Z4WzlQaAlfTE2MWpIYnagcvC/KSHLCzyDJFLYSMb1qy9qI2
         5CWrgEjE76Qo5qpCUstT42QP85oHlP2VhiOUecPAVeh4XakAdTlH9uL0lhH00d6N8ya7
         VQTraGEw+mPQgvvbzP0iNq5Dxx6eRagf8qD/LBguVrdTRPFLavluwqPbCC+gCY4hVdCN
         MABEfdWeRJnpcgwALf90oJf3/dNGmRPpGhlqRHY86BW0ERvSup9/ppRZgwGUAjN6ghzS
         m38GOZgm1zXsdzpOKqmSe4CRZuRiFeuNSj8JuQkmShCMmGolpkouewVHSd3IMN+ToYwN
         7soA==
X-Gm-Message-State: AOJu0Yw/QYiDnCbkQe6+svDLS1fHKHLuYu1STEz1I1nNqYSySpTWfdV/
	e9bmJY50Ua80x5/IadTSaVBGkHd2/OvSjo8URjNrJAzzSYroOZH8h1Ve0xiYPeIQ74X5xXtL6yi
	CfjjVI/wa78uDsn4XIMCNndjxxQINTg==
X-Google-Smtp-Source: AGHT+IFc7/IcZVyoxRrHwZx19SuYwSdLDgwvoU3pMs1V1U5ikGMsqtZtaF8eP3dgdZYTGzIZ+ikDCCWzBRPX56HjNjk=
X-Received: by 2002:a2e:9e08:0:b0:2e3:3b4e:43ef with SMTP id
 38308e7fff4ca-2e5204ba461mr88503751fa.4.1715720213871; Tue, 14 May 2024
 13:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 14 May 2024 16:56:42 -0400
Message-ID: <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
Subject: sm notify (nlm) question
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Given that not everything for NFSv3 has a specification, I post a
question here (as it concerns linux v3 (client) implementation) but I
ask a generic question with respect to NOTIFY sent by an NFS server. A
NOTIFY message that is sent by an NFS server upon reboot has a monitor
name and a state. This "state" is an integer and is modified on each
server reboot. My question is: what about state value uniqueness? Is
there somewhere some notion that this value has to be unique (as in
say a random value).

Here's a problem. Say a client has 2 mounts to ip1 and ip2 (both
representing the same DNS name) and acquires a lock per mount. Now say
each of those servers reboot. Once up they each send a NOTIFY call and
each use a timestamp as basis for their "state" value -- which very
likely is to produce the same value for 2 servers rebooted at the same
time (or for the linux server that looks like a counter). On the
client side, once the client processes the 1st NOTIFY call, it updates
the "state" for the monitor name (ie a client monitors based on a DNS
name which is the same for ip1 and ip2) and then in the current code,
because the 2nd NOTIFY has the same "state" value this NOTIFY call
would be ignored. The linux client would never reclaim the 2nd lock
(but the application obviously would never know it's missing a lock)
--- data corruption.

Who is to blame: is the server not allowed to send "non-unique" state
value? Or is the client at fault here for some reason?

I'd appreciate the feedback.

