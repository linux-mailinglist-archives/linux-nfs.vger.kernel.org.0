Return-Path: <linux-nfs+bounces-6627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EB983D70
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33891C2284E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9424823D1;
	Tue, 24 Sep 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/K75H5q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D070481B3
	for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161117; cv=none; b=p5XtlWpgeG991KDZyGlXC19O9hvT7AKLKb+A+BcAM/W2eOv7yl5CqkTPGMKrRvI75vcz2kUKg9xiN4xcXQ6OhUzGOTwjnS22TYHbb2XvUVKicuQlHuFiUOGiPiTpiZ0h+y/jvzozh3vo5O5tDLl4HoCkrjC0ctQ2GglgC7c0jiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161117; c=relaxed/simple;
	bh=xiGQ7oka5Q8M4r9lWlRdL1rYMsiFdLVsR9ZTXJKIj4I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XY1++Lr9AVPnvIIofxmT27YrOpOsDv2sQh74yHp9qutVZLkuVxt1KEWSKzwZ/6qGcOz+6jIxo5MVbGUMRnJvA87j+JfJYQTMnxA9fbNQP6y1J2Bnmq2sU/Gr9w+VcnHzn9KFDmQrdRdgM+kmnb6EWOMtj6M4F/GBMwD29V5ej04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/K75H5q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-536562739baso4872303e87.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727161113; x=1727765913; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiGQ7oka5Q8M4r9lWlRdL1rYMsiFdLVsR9ZTXJKIj4I=;
        b=R/K75H5qwHIcBD9GClwpf1fxQdWdom3Lg8SNLBw7jDIqhuza5SIS8D64O0eIZHJqs0
         TdCtijdgtbvcaAoerLBltVqvEg8oNvhaGJ6npTOl0nGmZyS1HsZo3yZuDmq8CYcKhYos
         vbxLSedfL7RIckoE5bw+Wzkf8U1E4gS98ynIbt7MtvPDC1KZ4+8ofE0iwrrRCZ2qqmA6
         L7+uVO9iLJnhd/6EYd6/pcD/qyX1cDqoBzM/tKRcv5F+xn3uFgBsKiWJmTRD8UhTzTuC
         BkTGQ5hHvxaIJfksX1/eMfgjkRuhaIMDLfp8TDxU/ZwT+U5oo71eco5RRmwRNeI8Afdw
         OitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161113; x=1727765913;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiGQ7oka5Q8M4r9lWlRdL1rYMsiFdLVsR9ZTXJKIj4I=;
        b=sINT7bWQ4SRCx+CYS/40+pKtvyQr7pUDsZeIFxMsQNTFjSEmh/QAJpU0kg3xy4w0sd
         flVQvdNKL+iMwgm4XqxW2WK786Sv+JwjQ6j23UeTauSvFFo+4llO/omKeuhyw4iohSOG
         xjVaolViPzaEH5GN9H1Z3k1XGtxh6Y9U6eX0NhfLZGLG6GISlr/EWCJHpXSV8wKI5boF
         nAHl+lJggGA1a3WDJKu9NpZOnIqPjPPCCxHSGkmWCkVGoD7e2DV4P16kzbTSZAoEQq38
         wcfcVxci+K9bFjSpucOThJfXGJdMVWUqYOeD3Gh+J9mh30Be6wCt0Pd3h3DGYzPYjzPS
         e3Dg==
X-Gm-Message-State: AOJu0YyiOYaZQOr+GFv9drK9KyO8loY+a0RvWa7YR042u+oScGzgEP3H
	ANnUfYenW/4PD++qABd3eiIpPFTVicO1saOy2/U1chrmIVUMWC89ik9JUkg1HBfBsXeP+FMx0lL
	UflZ4M6JSOMwtf/FOjOeh9izqgPhgMruu
X-Google-Smtp-Source: AGHT+IEgR1mdlwXHQ+YzZhphikAk5EJyAl8HQoasnX/YFEl4brBT+2u3PmjxZrhqy7ESX/BmGMBuCRXSQsV9gMAemd4=
X-Received: by 2002:ac2:4e07:0:b0:535:6cf6:92fc with SMTP id
 2adb3069b0e04-536ac2d68e8mr6269423e87.8.1727161113344; Mon, 23 Sep 2024
 23:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 24 Sep 2024 09:58:22 +0300
Message-ID: <CAAiJnjpPs7J5VwjoCp_h67CBgVTxYh8uOHY0DmpGrM-=PM4F_Q@mail.gmail.com>
Subject: NFS session trunking / Multipathing
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Does NFS session trunking support link failover ?

NFS traffic uses two paths (from different subnets) simultaneously for
max bandwidth.

When one of the IP's goes down, IO operation (rsync in my case) will
just hang until it's back, even if there is another healthy IP.

Multiple IP's combined with nconnect provides great performance, but
it does look like the redundancy part has not been implemented.

If only the IO action was rescheduled on one of the other working
connections this would work beautifully.

Anton

