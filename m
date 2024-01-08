Return-Path: <linux-nfs+bounces-976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580198277FE
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C4B284482
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD854FAB;
	Mon,  8 Jan 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1izmeLN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E854F96
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so2092540e87.0
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jan 2024 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704740185; x=1705344985; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iR81Y3268myWPqxEikIE/RlWlzupe84yUUC1OqoRrU=;
        b=h1izmeLNCneZlSdCySkju6RHuJszJXvY5O3NLEmEMnnrkfxWrn5o6/CZ2KVG1FsiZU
         wZ+15RDLbCmRyTMhlTZ3oZODS5+6Rr7YvOt528BV/+dz646y+F22owv4GtuiHAxCWvFS
         gc7JSqvLVBvx93gqDp7UTJ6SVdJit+wz6oX5Y01/vUN5tzjeBaB3IURuVyyGoQLTRAGX
         EXttDU9MsgppLWHYhUvCJp5NUPkGFQtSYzAz11uZv0udyjvl9lZs6joTSxQFUae861dE
         gdk9tDV9mAU2IAM1OUAB/7fA4tJzsL85geMvOXQArDVQiw7nIFIixKO5hFtiNG0BA0YP
         RDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740185; x=1705344985;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iR81Y3268myWPqxEikIE/RlWlzupe84yUUC1OqoRrU=;
        b=WYEnfEXcERFkpoHa0gPGevwYVEu5suJeLQUtH8CkGap5552vmylykDXYyvJuqvUR85
         9YEc6S8pkT8pFXX10kys5eU5yDeBI2L+W9oGs/tyhpagxMP0vfTRUqwIVhfQkNL4FKvL
         vMAvpqePkNQHRtKI6dHOuogXQanNv3Z097gPVXZgyZaIB5PmYEhTapJipq7m/s8LiWUW
         InDF0H2GFaaUZtbUiI4ASEDJN8gafEZrTAOn5QOmSvoe/SbHFqy0yNYxM2BWhVO6LqWK
         kSYsm08MeReALV5HFTVCmwHNhEuZ+ZigzesY/l5nqOUsJ+vRASpHfGv1nxK+lQ2+xHzK
         NDiA==
X-Gm-Message-State: AOJu0Yw17HonGxX9m1bGg3CY2AyX63qnEUx49etzrQtmFF9TCYnoGU8t
	8XqIC1QTKgx07wwv+jBYh8me/Lx+tFRZtgmIct90ZD1jdFU=
X-Google-Smtp-Source: AGHT+IG0nal/0jXpSRYrHojjwyKOyedhv9W9Pq2ul6+1CszZseOBTThr/z9pZAWbbmgiK+X/hzpWuuUsd9NEBuE5lxk=
X-Received: by 2002:a05:6512:308a:b0:50e:c8ea:fc8c with SMTP id
 z10-20020a056512308a00b0050ec8eafc8cmr111304lfd.237.1704740184692; Mon, 08
 Jan 2024 10:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcAAE0x4wJ0mVJ0b-7keSv3g=cFQf5o0yEd6-pMq35AzGg@mail.gmail.com>
 <466B1C7F-A994-4108-8154-4BA392B99647@redhat.com>
In-Reply-To: <466B1C7F-A994-4108-8154-4BA392B99647@redhat.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 8 Jan 2024 19:55:58 +0100
Message-ID: <CAAvCNcCqXr_U+WG2NK3uVvQMS7bYc4=n4emKs1ZLAtKy1XYEWQ@mail.gmail.com>
Subject: Re: What are nfs persistent sessions, and how to enable them in the server?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 16:56, Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 7 Jan 2024, at 10:24, Dan Shelton wrote:
>
> > Hello!
> >
> > The ms-nfs41-client brings up a message about "persistent session" -
> > what is that?
>
> Hi Dan,
>
> See: https://www.rfc-editor.org/rfc/rfc8881.html#section-2.10.6.5
>

Do the Linux or Solaris nfsd implement this? How can I turn this on or off?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

