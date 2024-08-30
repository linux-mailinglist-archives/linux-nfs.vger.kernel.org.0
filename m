Return-Path: <linux-nfs+bounces-6015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DD9653F1
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D32837EC
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 00:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D21D1310;
	Fri, 30 Aug 2024 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPLMUp/C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B56380
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977174; cv=none; b=QfYFwnYV5hp5Jxb30Rd5L1IoZam7b4t5ON7epWy4XTTpLIcaDvXitlk98Yi3V0tKjtpoal77ghrPaX69c5blMhUuy4xaoQ9aHhXfheg/qW9eZZ6paoJH9L07nWR4YC/E42ARsP/Ws+Bs6hYewnmgDo2xrNbSB+GLgpP2QJB0igM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977174; c=relaxed/simple;
	bh=f2Q6XDbaOzm2+44nx42xxpECcPALsdIxZkdR0cR4kQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eyg/rkHsi9IUJrtZj677thjfm+oAvuZgVnnDpA6duo0/PYzB1gr/i1OckRFjM3+JpC7T1oJpUpd78BrtZM4JCRcxaC4yLoNu+ZvwGsWT03gRyRGzQ4cE6ICan3J2NfFLfZ/sn0liXwAQCWOY+/Yh8f13vSIOcooQiXgPwaZYw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPLMUp/C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20230059241so11498295ad.3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 17:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724977172; x=1725581972; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wN1oYdA5coySZGOlqQ10F3+BI9FgrY6NogqoBEGr/vc=;
        b=dPLMUp/CO+9PMoPYbFoKuBckOID1suQdf3EQfWzv6jTHd2bDOQ1RqMuAR3kjyjSdT0
         GJV5L+ylB2mmvJTe8bO4WUTGpbEalFcIkad0BXIj3cnOYqQMAcJb1ij9qa5yB4iJ3Xmv
         Frh2pB3kSuPZI70SGa9QQ4CeIV4t905yrzEhAqpJXukv7DbUPnaZpZkzoLC1iorqG22f
         N1/+1yVvLEmj/W9/dhTFxtV/h43wqj6LLhjp0jHOrTCONxmZ5P6yOr7kIRjPn+o2INZW
         aYZ2EtZuOogD9cF3SurDFzxGDR2c3VeahMrKOS4RADfPrV0oVZHLPSiTSFqOdwbZ5Duo
         VN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724977172; x=1725581972;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN1oYdA5coySZGOlqQ10F3+BI9FgrY6NogqoBEGr/vc=;
        b=auWeRTlG4vyifKaQDA6w0KYotJZEBfNWOwIiZBH+B46ZgBS11NmNjMGkr0qLFAtnUS
         uqS+CviLk/0fVlyg1hUD00CHgdorzjd2q0FReoNNW3UnsqljeRkmJGiGNqU1Iy4b5dA/
         vw2hS8tBgjrN1bQxjlC2j6KD+N8z+OlNzSPWNSMAkz6M2FFM0LniD8u2/VRsmskti/r4
         RhuhxwDp61T05h9fnnL8izqoFraSD1JWM1KdPB1nAGyTSgNWd8amXpEnEOUSA1ZStIUQ
         zoCTBw1IQuoEplxDpWiNVe8YPj8PJLc+Ddf3H8TJ3SDDIUj9hxFCeC7Ut2p58f5a4etR
         Qnhg==
X-Gm-Message-State: AOJu0Yz+GmqF/SOnOVToaA0DuW2bUTTjPBpw43DO90lq0/Cm5Yvk6osD
	/qamrS0KaMh57jSSE374H8B4uuCvt4K2nCu9r8QfoxgxQ/VuZi0xlLDemiktyR0A/a2Fo99Mf1y
	h3rG0W/VQVsAmclvrbnoGZw0LtlyC
X-Google-Smtp-Source: AGHT+IEAPAGrbACvVWrWYeMhSUduMyYFb4zkUD7cWnT4k0DErDrUU52wW9ixvEVSl06XgGsv7/ISXv1UVoLAqKBJZrI=
X-Received: by 2002:a17:902:e845:b0:1fb:90e1:c8c5 with SMTP id
 d9443c01a7336-2050c429e62mr53930555ad.33.1724977172250; Thu, 29 Aug 2024
 17:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 29 Aug 2024 17:19:21 -0700
Message-ID: <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
Subject: Any idea how best to handle potentially large POSIX ACLs for getfacl?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a rather crude patch that does the POSIX draft ACL attributes
that my draft is suggesting for NFSv4.2 for the Linux client.
- It is working ok for small ACLs, but...

The hassle is that the on-the-wire ACEs have a "who" field that can
be up to 128bytes (IDMAP_NAMESZ).

I think I have figured out the SETATTR side, which isn't too bad because
it knows how many ACEs. (It does roughly what the NFSv3 NFSACL code
did, which is allocate some pages for the large ones.)

However, the getfacl side doesn't know how bug the ACL will be in
the reply. The NFSACL code allocates pages (7 of them) to handle the
largest possible ACL. Unfortunately, for these NFSv4 attributes, they
could be roughly 140Kbytes (140bytes assuming the largest "who" times
1024 ACEs).
--> Anyone have a better suggestion than just allocating 35pages each time
    (when 99.99% of them will fit in a fraction of a page)?

Thanks for any suggestions, rick

