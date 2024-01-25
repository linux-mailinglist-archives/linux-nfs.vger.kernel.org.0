Return-Path: <linux-nfs+bounces-1330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1D83B714
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 03:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1360DB24027
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD51877;
	Thu, 25 Jan 2024 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHSaUEsr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2517EF
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149310; cv=none; b=V5adeDj26cx/Gt6SE8nhpqc1zqzyxag3sevg3QPi9zhPMW9DubFlrlv4UaEC80LlARtIXhSQhGwIKhiZs7S36maH/gkNQv8RbP+i3JU7XEJ4eNXNqgMwKG30OkuFsAYfdUA3fnhUfH7veKiNETLQOwoKrojXOyHxvTxjQTEpek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149310; c=relaxed/simple;
	bh=ityfanWNPcO70rmr4H5LfrOhGL0HxO5PL2LsrZlSSY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MZfYmPe6mlTQO21vPe6HUmDFxmO9gUPcpIcS7FYyuBtF//ZQ1hvfoT7xMgDuQbhdVysjZLyV2gkHkJ3ysgfngt7rEBNMzCsOwoGJsL+gfHRtOLbRP3U/FTxLDazfBHNjqySP6grG7pmYoqYSNjKVusqXeK1Ame0G9TnYKtD7u7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHSaUEsr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso1900751e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 18:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706149306; x=1706754106; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hyOo6G+HTumzuejB+qI0HWbc7lU6RzV9sI/oYQZnhcE=;
        b=EHSaUEsrIqMlqcDy6zoSqlZ9Xc8C+tP1VvJ8yhgJ1nwXVB4p9h2/zpoeEMJpnFJN34
         uro4dtrSaMlwisy+CWMQMDJg2Z5BcRmznwS5cVoshYfEcVfyHoFbpN9tWgsx0+vQ8l40
         +2nqoDv90cECiSFKnJwOisKSvlG0FLMXb/00hAV4WvkzjDV9dd4VSbfvLeoLUrhS/B/+
         fiA4olR4KInTiqBvRSpDa4V9ngjMtjHXEcPj3iAS84RgrJk4IOGmsL2DGt26uq4ulL3D
         LneJtq5v5AZ5hnPygyrh/4y+2mpQGdH52RhWFkeqFpYIttWIRjoAvKmR2GhYoKrDoBA9
         N88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706149306; x=1706754106;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyOo6G+HTumzuejB+qI0HWbc7lU6RzV9sI/oYQZnhcE=;
        b=hh1rvoMefw6V56Zrydo5FeXIYny2+DNU8ybIDgRhwjhdbSv0ELyAlh/O1sh5Xp+yS7
         T1h9dutfois4FL4foA98Ta78ggggCLggfNTp1TKWU3wjYPSo/oTGc/UGvxn1dXVBqSn2
         cOQZFE61+XOCjmS+RYrgdpT264koinFCOKB8BQb2Zf7NiTOWgB90zQ1/bcKTCjYsLMqt
         IvPsYLaoi4mKSgdVi6xfHecaeRoWKATlBvDsLPpHZwdYI45XefbbZlI8V4VxrPQHRq10
         r+724BdxvVKPF0Ms5FPkSibKe5cUy8O1MwenatMHIZM1yJz4soAdjr/+p35grwB645nI
         /pxA==
X-Gm-Message-State: AOJu0YysAIBzIfnNZIHp374zjYn/WaVqKODEoEUAclLaH3TAnGEvsSc/
	NY/am3vf6hClTns0rslk8vtXjipj5NT8hGuAjAPFEFTOqHHgUGAno18jGddwVf88SJzRtCqm/ei
	JFzzXmgZkj4CyiVN9j9O+kDtm5ebUlKHspZc=
X-Google-Smtp-Source: AGHT+IFD0+BXDkRjQIs/yk/FYkirTFoVfYjlFv9R69EHa05Yso4BWa9FKYeAsl39DezC07UkgbHAhf30ZcrZHu6ki5w=
X-Received: by 2002:ac2:4a69:0:b0:510:141b:4f96 with SMTP id
 q9-20020ac24a69000000b00510141b4f96mr67386lfp.86.1706149305877; Wed, 24 Jan
 2024 18:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 25 Jan 2024 03:21:19 +0100
Message-ID: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
Subject: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Is it possible for a NFSv4 client to implement TLS support via
/usr/bin/openssl s_client?

/usr/bin/openssl s_client would do the connection, and a normal
libtirpc client would connect to the other side of s_client.

Does that work?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

