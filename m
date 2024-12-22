Return-Path: <linux-nfs+bounces-8709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1B9FA335
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 02:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82229167214
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3767A35;
	Sun, 22 Dec 2024 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyf5nwij"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE41373
	for <linux-nfs@vger.kernel.org>; Sun, 22 Dec 2024 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734829385; cv=none; b=THHCYT+ITKLhWwmKAtnjFUJ+bmxYhnQueqj1QGTfFRbhA+bhAQe3YBm3Vl0lFaLS2PPy8R+RKGPSJEbe2zVhB0r6/k4cOR0GRBt/wQDUf4cg6xp7OKNvVKPRR/2NqBmDpqe1umK9MtpOLYZeQp9zL4X3elKtDebROPrBm6YpWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734829385; c=relaxed/simple;
	bh=jxBzJ3PMhdtoBXzHLQQVhuyC8r86txc7E5XGJZ1MflI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Egs9Om7mutDRJDK6FKFSi4ivmnqBAM5//z9rWhGb9ST7g1ABp2To241I4B47WB0WiUGenAKjZbAk3Q56MHwSs4+ls8W3eiGyV821EwyAl+FH8n5INYSXDIpUCCkaHkQRLwyNrXwa4jBvvwDqHDiUZih2SSAH1q8KROslvs31V2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyf5nwij; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725dac69699so2817506b3a.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 17:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734829383; x=1735434183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxBzJ3PMhdtoBXzHLQQVhuyC8r86txc7E5XGJZ1MflI=;
        b=Nyf5nwijqptTCV7X8w7ETLMPb8SdhZ2/TpO9USMBuYryHM3xjsciXCJOEy6eNFrKN3
         flOrdBomUhb20zptna1U+9Hsy3TdG13hE3noVaOlGQk3Y0IcZoBx/ILzQU4zj3RRWNnx
         7qaPauIZ2+b0SrjHGB3shdNYV3wd6ObutHpwTBGw7TWPghjfS18iFnITfx4CL8XYzemr
         sEAMR45y60JkWn4Yu+F0Q91BMv5osQ+pgmZWr87e8Rjnk1Uan0EJJ/BPOEzuzpevuaUP
         4ndlm8Cpgzg4+9MJk62dRzFmuzp2+fZBCyq0fjZzIHploibU0j5ecyDzTAZEhV2noK96
         vViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734829383; x=1735434183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxBzJ3PMhdtoBXzHLQQVhuyC8r86txc7E5XGJZ1MflI=;
        b=EmFCDHqRAQv2vOuDsogoLjQnQhIhiLKCkVebVmcp9HH5LNTXE17k3yaCH5mcmE1X0r
         MCEtLff5oNrJ4nbE4fU9mGS9mCMRd/Z0PsMnGmaxRNyx4YiqCaAd4Y+Ck6uProJAO72a
         pkOK6W6U/avkRM+amjlYTBXCk7lZ0RZ0TIVHOWwhUzS9jRs4b8AqtV2kooDaAmkyZ2fq
         ck4IpbHyxZxnEK2AkyS6mgvz7i/xlErTfMFfbGnu8aZeCkgl4qdNyRu2yG4ltCopNETa
         3/HA7SlnETKObEqKNAOPYFaDsZRRzrQcLtIzTlDa3Z8HtuSaQ2kMJNKaIRNtNy8ONPgQ
         JFyg==
X-Forwarded-Encrypted: i=1; AJvYcCWx+5mXFwEvLHUaHUbKuxfb3J6OOlKK3378/KwWfIfVpjrMJ8PuT59p3qGMQqs3vgKYFEL9tJHE23M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbMsX9+PiAw5dK7DylNvzX+HkLOWKDJVHg3J0/XhGUpyBPu4o
	cMMtkd14DWakawZ+tzYA8s43Ngw68RNFm4aopU5+BCiizsrTE9Am6YjGG08oOkwiKBhm+pEbFaU
	/Pwu3uaxs5OMCaqMohqMUmdchAM8=
X-Gm-Gg: ASbGncs5ZHK79oPNNEvZ7u7rcxnOupt24w6DPbaVVVi4jCu5IyK1qg+P+SgYmB9mmaZ
	Fa5OjpaVTwQmO6p6MQTGUhaKVe+kecJpZPIh/
X-Google-Smtp-Source: AGHT+IFF/N2o1uVyt+mO2ahwXdk5OhHmDhVDZSRUb0hzvijiXRuHJ3XviXk0Cva1gwtLeu3uWjTD3CPc4Dp8brBndKU=
X-Received: by 2002:a17:90b:2b87:b0:2ee:f076:20fa with SMTP id
 98e67ed59e1d1-2f452eb11f0mr11453105a91.25.1734829383395; Sat, 21 Dec 2024
 17:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com> <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com> <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
 <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com> <CAM5tNy4yozhOhThFfSELN3Xc8KWbSaaqqfuvV4_6wZXozxNY8w@mail.gmail.com>
In-Reply-To: <CAM5tNy4yozhOhThFfSELN3Xc8KWbSaaqqfuvV4_6wZXozxNY8w@mail.gmail.com>
From: J David <j.david.lists@gmail.com>
Date: Sat, 21 Dec 2024 20:02:51 -0500
Message-ID: <CABXB=RSR1x9PmXrx1wdM67u8GFd8pWHHy8y+a2jx78oj=6s8VA@mail.gmail.com>
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 7:30=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
> On Sat, Dec 21, 2024 at 3:53=E2=80=AFPM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> > I have reproduced it.

Let me take a second to appreciate how great it feels anytime someone
else says that.

> Btw J. David, the patch I sent you that removes GETATTR from the RPC
> does seem to be a workaround.

Great! I have the source tree patched and ready to build, but haven't
wanted to mess up my ability to reproduce this in the test
environment. Now that it's out there, I'll give that a go.

Thanks!

