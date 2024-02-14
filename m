Return-Path: <linux-nfs+bounces-1920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428CE85465B
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D1E1C220CB
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F35134AD;
	Wed, 14 Feb 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHBHAK6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990512E5E
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904013; cv=none; b=hPIk6yyWffaOaVZObm2eWAoRsCFgkAw/eK7WuGQwHkBd/Gu/pAsgs9Cp1IizNqN+X3IKtSLMolH/a2kxt50ZjS9O7JThvxEh959s6pVTqKCwEG36MIFYWauUULhkgPKIO9Quz93lIG43888uUP7RtqtqutLdYNE3df0Ff3Djodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904013; c=relaxed/simple;
	bh=2Nwk9nKf7+672gst/QqbvZSD6DDUScVtppCgfAfeo+Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=crIcLLuF8R+d0VmooaEwN8xbvQIlVvpTuZKa3fSnRO90BC4ABJwVFcHiYtHO6n36mD3tL6nabah6h5BpvFA64vX9XjgVR/9ErqpQf2VbNfrwmSqEenStyK1LuIkm5zEBbSXd+QFpKqr5O1yXpduyUahLBw47e7bohwcuoS/gpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHBHAK6E; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-214ca209184so3452015fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707904011; x=1708508811; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Nwk9nKf7+672gst/QqbvZSD6DDUScVtppCgfAfeo+Q=;
        b=UHBHAK6EHVQLKid68T4IJKylJDmpzvFmwDc0TjDVnkaO7v+ZRv2PrzBrHb+RRixuSI
         XkQEm7qMJDk3uQ+ucNzd+P3Q7weHeKZaPQic6UImJ/JrS5u99lIQOV9OEGtA94VskGPa
         rOhR/7cFsOppdGNAK37/JjT6jcHZVsHJbJ87wf7/EbNhxoNJGPCo8gRUx4o5/F18I4Bw
         Mp+D44I3ElRrqBUNqGvhpiDBOtqNcu2JqXZ24H3DbuVUUlhmVofZt15oQRAzINe+GwOD
         pWL5orPi8y9BG0+G878GnlzI+mv79XlUSZBXKQf9j2CGzuckcEI/e8VTdKCTESQtjwW5
         b5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904011; x=1708508811;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Nwk9nKf7+672gst/QqbvZSD6DDUScVtppCgfAfeo+Q=;
        b=JJG90i138yc2o/vKPveLdO9j3QqkRw/jOfYDpAwNOf0hfgJyr8c4z0F4+OOjli4ynY
         eJLmFjygRlXzHu0UVHMAUOUywTZicWoeA8bR96GojcvX4mUabVVXbmcplF7lm3HU6+Mz
         B6MMOIoqJUwHDemq8Xje9vrEn+6ONQUc3HXIXKJq+w1IqlEDuOs6JjlsOma+LiSRCr2Q
         +2yNP1PiUe2+bu90Wj1Z80D1X4zVAFF4ZWzzwVIXXab1ln1uhMrJ/pVfN6HxtG4ScNsl
         odr7ZL4fdxeSUY69Bb/i1nNmwCyAS1P3EGPWleaSvMjZX9sweYcWIkmGz9NC/M1OSAOm
         aFAw==
X-Gm-Message-State: AOJu0YwHkGQTAeWTeU58a1c7fi628Vf/Zdudyv0MuzV1wuYECeYjjd2k
	dT2hHq6csezwSAPaW2lWAVPPLuupHEjWe+Bt08o2hazTlvs9a0KL8CD9BKIDCrDyPtCd3jMu/WS
	2QUBLn30ALzIFsJ0carNcse6OYbbiS598
X-Google-Smtp-Source: AGHT+IGjCgorUYfwzVKqNqXiC8AtRkEMHAbOtVYMWulNcUzvv5k3QkAf1lSCp/ySlWaRL7btBgeJ9GsQT3293BxmqBI=
X-Received: by 2002:a05:6870:6589:b0:21d:e30c:f586 with SMTP id
 fp9-20020a056870658900b0021de30cf586mr2447865oab.12.1707904010866; Wed, 14
 Feb 2024 01:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 14 Feb 2024 10:46:39 +0100
Message-ID: <CANH4o6P-jze6MB8yh3sWxhyHJWdj+JHK3vw58cYwQ0a7eVe_Vg@mail.gmail.com>
Subject: SELinux-Support in Linux NFSv4.1 impl?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Does the Linux implementation server&client for NFSv4.1 support SELinux?

Thanks,
Martin

