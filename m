Return-Path: <linux-nfs+bounces-8947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B6CA044F3
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E33A071E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3989619E806;
	Tue,  7 Jan 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8yp+Cgt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412F1537C3
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264534; cv=none; b=att0PmNN1vRjtl3CK//eYGO37I/9t/TZceb3aOqjxQoIvS4T/YBmZ0kyvlknubzFyVDjp4SOmZERv7JrRkrfig83FzCHnELZ57Rnes5bufA957enz7NdfhhprLmGfjAf/XUaMCYvZcxTkbALGCAnugMq1/+w4QdsOBKfePBxhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264534; c=relaxed/simple;
	bh=BlkOg4dvm9C4NnOQjvIamWerl0iODlh43Y3QIEUCy7M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UAAfPxleniWkqRtVlBQQy0y0RUha5hopAA7VvZAf+xOGrpUCDOvv9TfeLloUHDS1ivD7daob+0QIDTUk+yI0pUpppxxaSLpi+GQN3Qp54CWjYZ6jfe14hOi0+Ns91r22N+4DOMCs3/ug5/PdLSiXZ8X+JmaDRU4quo1O4FwnkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8yp+Cgt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so29616441a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jan 2025 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736264529; x=1736869329; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qAgkBGNlE4p5wgVdkywAx+fCyXwfSSMlvtL28piloLM=;
        b=m8yp+CgtATXUwJstB9AmlYz21HwCNX07TwydivqkP4fXl5g+qVbHbddzCUfXIlbaN7
         37ZTBCkz2Xhsfz9fAh8s/5+1AJRZwe6PF6v3rQijwXEKphM2TUTXnaJcqxLoXSRKCmfp
         yc1uXSxoVK1Dm9z7CYpYK8pHX+q9eGgV8e/Or3dVMgVdB02EHW6HiLhcb6UFGPdEjpp3
         uxnUhfLWbE9cvUWcnbyS25LyuYfxq8sWZsIF6p8zDvXgCQetovmg1tIXIc4a/mpMZvr4
         TKJg9nIK54Th0dyrHOBqp/+x6sVX2yfWVkns3ILjyP0j298oevcji+BMN5hsTeo6hK3C
         e9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264529; x=1736869329;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAgkBGNlE4p5wgVdkywAx+fCyXwfSSMlvtL28piloLM=;
        b=lLJ7h6PUcPIMKZpRlPRzC5A3eOQ3QxuUXUefTznVnse61cecVvAMsj8MkKNmrPIEnb
         NfssUOQBNBG4Td+32FUsqtF33YyxgMHK5I8P3aSHaBvhjJzFeURziLBRBKtn8HUutloH
         xu1VLpog/qizEmTp8bMp7DNoEixI1E0KPjDGNZ8eEMek/eE9ES/dlVa8IErSzCZ/57kg
         SUKQx+b4T+lRgWW2wNNzgs2UVvcOSf0Ygj6GJd0tHKCRiNo044uDaA9l78avOp69ISB/
         HPCHOuPDD1vx62t/fwxvmJlFmDAQr9DM+Zr3WeXZ5J/omdvdp9+raiwXqGvSlTzXO103
         xSWQ==
X-Gm-Message-State: AOJu0YxrnMlR1elvtEZwMI6Pkv7Ed3pUoGip0mOqB3AaYb98G1kg85Zi
	UahOeIfAqrU2fQz/NDbqI9dd/ZA0AT7mASJzEE4y2Tf3RGWSsxZLxty1nLrLecntiKTQxDCAz9c
	JjTYHMOVMsAnT5iiCp1l4nJ64sD3i1ozmy90=
X-Gm-Gg: ASbGncu/c4bdiC46Z8EwHSIHmbQEBw8iCupHPHdpqMfA6sm0y0YKWLwUXvEoTzoWaMt
	ekqhCwV26oJslXBvr/5JDZrX6RkEVChlBwbG4Gg==
X-Google-Smtp-Source: AGHT+IHcnXPv7rdSMopuGI/6IM9YrKpGRVYZBaQDEfIzYLbNsRWSnHE7nomPl+vfhK4sNLcKLQJdC1bGpw7s0Bq7rkI=
X-Received: by 2002:a17:907:1b85:b0:aab:c6d6:629e with SMTP id
 a640c23a62f3a-ab2918ba338mr267495966b.27.1736264528881; Tue, 07 Jan 2025
 07:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 7 Jan 2025 16:41:33 +0100
Message-ID: <CALWcw=F7tO_6S9xGUyyqZnc89FxhpKgtF7soZ+59vnSeYB2xMw@mail.gmail.com>
Subject: Why does Linux nfs not set EXCHGID4_FLAG_SUPP_FENCE_OPS in NFSv4.2 mode?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Why does Linux nfs not set EXCHGID4_FLAG_SUPP_FENCE_OPS in NFSv4.2 mode?

From https://datatracker.ietf.org/doc/html/rfc7862#section-14.1.4
   A client SHOULD request the EXCHGID4_FLAG_SUPP_FENCE_OPS capability
   when it sends an EXCHANGE_ID operation.  The server SHOULD set this
   capability in the EXCHANGE_ID reply whether the client requests it or
   not.  It is the server's return that determines whether this
   capability is in effect.  When it is in effect, the following will
   occur:

Why is Linux not doing this?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

