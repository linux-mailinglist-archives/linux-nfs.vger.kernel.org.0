Return-Path: <linux-nfs+bounces-7672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE139BD345
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 18:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CC01C212AC
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5611D90B4;
	Tue,  5 Nov 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjmU9yx6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E101C3050
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827331; cv=none; b=sMGNbs5kF8c/n70KQ22R1dmWUU/PSlbDe9ufiI6b97pzoec012hSnJW1dqVb4MEwisaKbnV8hGFzwXPJlijRuFnFVRKzM0wcDzt5SJSW8dMUMiWhWbu8XSm605k30H9BpfXI9uL1Av43XAgIqD0ZKcxBOxc81rz6TYG0t6GVRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827331; c=relaxed/simple;
	bh=ELZfvsPvjd7ovgEZuKVPIf/AgxWXbf+w1zgqbqTV8Xs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YdYHmaFPTapjKIbBFUom+AuNORobme3mGB9NMbutS0pCoU6L9FFDrkrKeopPJrgIhIRwQ8LZ4kUa4v069Tk/Xidi5RXeLJUN0fCuWQ4e5ab7jbu6vj6qjDnB4LLu5uPyhy4J657oi/+9V4bhGVI1ofzLUMu2tUooXYHJ4OqPutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjmU9yx6; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a9eb68e0bd1so121149866b.3
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2024 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730827328; x=1731432128; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uAX8owht9w5+1SWFnULX0+J+wz2ac0gF9QWs2xmpEuQ=;
        b=SjmU9yx6FdrlH7HAbim5a6r/eXcbYxSlUm19a0XjSB3GpZd03dchMkVTN8ZtUcxB+Q
         J19c9Gt617Wn0yjiQYsLn/izqbqU5BrFnYCCIJ1zmC2g5ydFOP2Jxt/zhwr4KxDq/dXj
         bQb8fgymNXyiTNQSZFjs87A9wkwUQpMOkHZ/iTkeitpS0G9t9XIs4B9DsFj1trjHIdo2
         5z5NUteIVUzW6sqAZ+PFrxOEl7KuHecJhkgxYQ/IbRrgKw5OoCejhZDXFbUUmCWhozCj
         PbHkl+4DAfXc9BC78ZvKSKijLv1adN4pLhjHaz6YDdSUis3IqDXoAE14+sQ2EvAPrfy7
         pJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827328; x=1731432128;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAX8owht9w5+1SWFnULX0+J+wz2ac0gF9QWs2xmpEuQ=;
        b=AqGbiHPiSatedmHNFa54nMPKF5BdaBZzGftiMTc0c2EGyKCdFxC4p5QO8iMsXvNtvM
         D8IbFiCIyJzrFw+UA5wfrah3L77ky3zsCeKW6bDIok8MdpbmLrf5Hlzu4pGc/Ke3btOe
         p08mrfXxqm/bSmdbFLRrUt4HZmN9LWKkc7N2oFfImtt/oOAHXJHpCCzj0y/L/9UblOvz
         vbuPIJBfKIXZcYNRyywcbZdYMLsPQVgZrHfA7b1jGJ6fINx6kXAFRfnvfMeYD712ZTN4
         UWLyYRXB/AM5b2/7Bhqhkorh+Efx3L9sCp8xjYhWIVXRamB00A7/GjjcO3GAIK0yMVAN
         j4Zg==
X-Gm-Message-State: AOJu0Yz39+jMRzSZIJ1Kp8MMgf3375hYtUWfeWT/6edXjx0XtLVaOQl3
	6PA7+X21yxggx7ba77Zj+P9GWVruRz4abRIsGTBIMAgP5OtF00Rw3UuAP5Gf/HB4RLOpx1eHUaM
	oQMw092dGeeteknb5+ncZfBNOhbKAZ+oE6xm73w==
X-Google-Smtp-Source: AGHT+IFfcxTHGIu+nT5hPdX2ZsRhRopfuHYq0W+ogrtHnkyYIyOYFRzW1gcyKd3s6Gf7tfXJ/El62W2DaKvqQrZMshg=
X-Received: by 2002:a17:906:c10c:b0:a99:379b:6b2c with SMTP id
 a640c23a62f3a-a9e655b957fmr1498259866b.42.1730827328034; Tue, 05 Nov 2024
 09:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 5 Nov 2024 18:21:56 +0100
Message-ID: <CAHnbEGJf0F1WaqDf-f8CKi0WGchG_3_sP4+6Xt1MCqcCF9fjaQ@mail.gmail.com>
Subject: Any NFSv4+TLS support outside Linux?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Does any other NFSv4 client or server implementation support TLS at the moment?

Sebi
-- 
Sebastian Feld - IT secruity expert

