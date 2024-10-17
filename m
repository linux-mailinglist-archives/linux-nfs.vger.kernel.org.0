Return-Path: <linux-nfs+bounces-7262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B649A316D
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 01:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0315C283669
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 23:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DB20E304;
	Thu, 17 Oct 2024 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCwPSphJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FA20E302
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208030; cv=none; b=fwv6lNcAW7MZRFeA1i1No5SJbfJLSoMVXsx+aLqONY2c9vjOoU5baxQxN8eCUl5Cq4vTSNBkzjNkuMlVtdVaFxqV9mHJqMYVw8cv2OciQ8CRzMDcRSFPBLg6CBv0eVl3gBRKcutg2/tIfQCzid4SalTnLa78P0ukYEMUuCu4HHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208030; c=relaxed/simple;
	bh=kmeZznt1SMUv+KyCddoqIk+RyvGmLY+nS1W36YDBobo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CLucQjSaSYziFZGVos4O7APvlD6Guxp0qQ4ldti0ZYcTUW+cT8WdUz5VybGB5yishFpr3xojKNn/L9/WXJ64FusvHSxzJhQmqNd7TyR49d6Z27XdDz2O1R1RTkm/0if8wsnAcPN7NlarJV+kg3WzF4k8R0DFvDovv40oSWg6Mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCwPSphJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso2651970a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729208028; x=1729812828; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmeZznt1SMUv+KyCddoqIk+RyvGmLY+nS1W36YDBobo=;
        b=DCwPSphJYzlFj+snZEV3Un6dBIfcGjqExYRDUO+w13EvlbVv1ah2ug8WLzQwslBpFV
         TAjevHjuDXg6OtgzEXbIbjTt+Hv2/42SVK8u9685acVhYiMPFRo2JDzrHmfqGODSBEeV
         LheVM8J/CHIEhXnI9MAKFcTrCYl5rLq6I0885411GJQPmBrnxHHcDzihQSS17EjO81NW
         6tuvyK77aCFT95DHmxISwn+iOD+A5TQdbTTbudURd1xsrLbIojRSgjb6aUnNjfkqoC4d
         vzlnHqXslq5adYpmTO5jAZNldt4GmaNe+WASV8/869tgA7qWLB/DVI5xZSYxgzWQ6OaK
         ud/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729208028; x=1729812828;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmeZznt1SMUv+KyCddoqIk+RyvGmLY+nS1W36YDBobo=;
        b=syoeiUAJHDBUi5QFTVGGNAKE1ulr8z0TszWwBVGs7AKma05Z2n0GP3CTuJ3IrH8Xd/
         0+o2usUJb58BSadfcQg8BnQnotKYhMbfoAcpo2FNogeHn6xkQxeud8Hd4uiEJFhp5oHZ
         fR2QmSYUxlohmTYJaUZaHRnU3ul8WY6wTynSOg99daLjR85EL07D/ONTPyfNAQrrgIJe
         Ual4/TYGDqCmqjCqtc0Wz8tdT1SUOXMDr4/E+0DFPp+0KLiHc31ghxthYCjksZjkRnTD
         dAVfTh5ZgMRiZmONBt883xYDpVNLAwfrhB3G6ZZW9wLBW0pMaM1N4YNwsUFPRG5bRZDG
         iqQA==
X-Gm-Message-State: AOJu0YyYoBrqN7I/5hzpTLw/6sL1OCZPMqquGhjygBTtX/rjtAtSF27n
	aIgQ+iYIlDKd/5N3D6bfndWQ3eD3jCq5I7R2Sz6aSamEqOZ8UAp6Yc2e145F+rH514mMdLPsvDs
	1Bkvvq5MVEpq5814bk6cv/v+Gi14n
X-Google-Smtp-Source: AGHT+IH2WqZis+5shw5jwixBQN0emOMW/Ltk0VdwlnF0qhd7axfrEQikPOFuMpKOg3dKQMTpwS7W+4jgeosQdBt3Rw0=
X-Received: by 2002:a05:6402:4401:b0:5c9:7d47:4d27 with SMTP id
 4fb4d7f45d1cf-5ca0afaa35dmr256192a12.31.1729208027449; Thu, 17 Oct 2024
 16:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 17 Oct 2024 16:33:37 -0700
Message-ID: <CAM5tNy4erLZ5CDhRZzp5QKqeg5MiOhnbZsoU-Qx-JNyknsBegw@mail.gmail.com>
Subject: Posix ACL patch for testing
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I've updated my test patch for NFSv4 support of POSIX draft ACLs
to include basic (only Getattr of small ACLs) support in the knfsd.

Hopefully someone can give it a go next week?

You can find the patch here...
https://people.freebsd.org/~rmacklem/linux-next-posixacl.patch

If you have difficulty downloading it, just email me and I'll send you
a copy.

See you next week for testing, rick

