Return-Path: <linux-nfs+bounces-10395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B543A4ABA4
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 15:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56331171B3D
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746035971;
	Sat,  1 Mar 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/5MjVEz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6E101C8;
	Sat,  1 Mar 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838649; cv=none; b=qjnGSnM/Bx3+IzGnkShyqU6MG1V15wzQdS9qsbz0IO0k+WqvqCrWrPX9N/sKS0slqOHh001rOGl1CGUXdvw1sTM+bjz1AjjiKdhHO9jXoNTM9D5V/Xvlg1qs5PJoGnyTlONnZteL9pGBztsHFlWD+gZ2YlvtvedFUEgGicSHXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838649; c=relaxed/simple;
	bh=/DF2JoumYBYqsnFTIdin6swrkcPaU5ofu3NC6lS6/zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPS4K1ZXxM/ZvzN+eRNnXnREiLL46AByyNzfQUVatfXjyU/P9MIE4eQMeCRspKq+ZbPSNn+1Z9J3yG3WGmFpmRnrBp5xvXsVnhG2hFnfPVpeLEXTd5SoEsH/73yryuf6Pw8SSWKVoUbBs5SHwtKbSDOIVt1or2B8kJUVpHkEnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/5MjVEz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438a39e659cso20880495e9.2;
        Sat, 01 Mar 2025 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740838645; x=1741443445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PahHoOir8qfv1LTrsi6925KzDdTFMUlnOTruGGEqzcE=;
        b=Z/5MjVEzkvK5JwSUOyWFvsu+7fnM6CZGPb990+YyzT4jcOaXljBml1k23UHZNhoCb8
         TqvBSif04b5GcqhM2a9try+lkp47zylZkZBnWPwvxKRRDx7CzKBwQJyH2qo7HP1tKVfW
         vYptfbRLsrNdatCp1QuVCfkpb3wKWaLcv3NVfOce35THi+geJjV7TvMG+VdPZEKLkWb6
         kALP6iRsY49plwfBLrH7BgRM3BHpxLg6A/SztdlFlKhi57ju+Fv5xu3G5Hgm1UIt3W1I
         LYVpeuv7BaHfSs0AeRRvSoGH1YX2UoQEMgIbgHVQW99W9hIJUL/k+BZ1qWYGSBS+AOmW
         XMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838645; x=1741443445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PahHoOir8qfv1LTrsi6925KzDdTFMUlnOTruGGEqzcE=;
        b=d7UEZoaDRO8LBhWmKuxAwRDUQGZblkzDrluM8H3mRONmS7qXb5nzfIBiuSBG3WareR
         v2UyGfQNMDggQog+UTjRpsqqykf/n2EihpY3hThMTb/wx5thPearXWQ02tXkc4sszudx
         gjbRUTwmTxR0XoNNebqtHMEK6G5/ngoQbOVuWcp2oRQC5UlffTFcjS7URWHw7xHrKa2Z
         m+lG9FY+ZuBMQECstvdZToBgcNqBWaEeZOQLWQbH3jAkEBmFtAghiSj2N6krqxGVbELz
         cfJxbTXJt6L5FH3HX1tqL0NriatClfgszAabPgqoaNV2h1Mjn++o21G7QzzqtnVuLVrn
         rqww==
X-Forwarded-Encrypted: i=1; AJvYcCU6GLZX9oTFphfGN1tpZt7qTFfMF+mspVKHPcGPA6o9ClyZWgM2Hdis6pWI0f17scxZ71fUbSxReYF5OZA=@vger.kernel.org, AJvYcCUBZrproCYQnq7+RYh13X9/qQZA+ryl0ctdjOHIX3pD+t8NAHDXwEvC2jswPfPB44vieBvh4im35+8m@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJjxnzBgwXmAvaqafK4ncSQCWebXuoeIJBqzakAMMkHcOBumH
	0DyrA1PL5jz1JJhlB/hLQgMrt08nMtcV7D1d/SYHudP7XYhUEdEb
X-Gm-Gg: ASbGncvA0S8w5ad/H+lP8XHJfbDV4Tah25/mTveMnKjM3sCX4jCkPB/4Mv8Xer9wl9h
	J3SBnGfQGOu03IuwgZgMJkqLwuXJx926HJJHdFuFu9TDbSm6VYt1qr7UsTNrilNK3fUrc/aMF9F
	g0Y9uUSR3Cqqr8od+E/lr1uHIUb+0ukH/UfGkHdczyefDUmRnHvC1PhW6osLfszq7sRaUevYwZV
	44N2MfG5Bwt3uMo4aq5u0pMD0DQuwkkV+KhQUc2LbtnMFjD1qhtMDbD3irFVYRw+xIpS+OGujJM
	r8+OHKa35lCNfyoS/2fO98iikelauVMUMuOF8IT0r9a+p6x2IQXzBAPtz22DvmTGmoB004pWYAY
	AVQ==
X-Google-Smtp-Source: AGHT+IHu+uW89Mv4jA7RdnRSpYtxvOY2+1IkdU5Ipoc2fSlHUuZeY5k321zzQexeQH1iEHNQ0xrsAg==
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr54184245e9.21.1740838645395;
        Sat, 01 Mar 2025 06:17:25 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53945bsm124253195e9.23.2025.03.01.06.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:17:24 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C2D63BE2DE0; Sat, 01 Mar 2025 15:17:23 +0100 (CET)
Date: Sat, 1 Mar 2025 15:17:23 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <Z8MW86zYK3VEPcHF@eldamar.lan>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com>
 <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
 <2025022051-rockband-hydroxide-7471@gregkh>
 <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>

Hi

(btw side question from a bystander looking a the bug)

On Thu, Feb 20, 2025 at 04:00:49PM +0100, Max Kellermann wrote:
> On Thu, Feb 20, 2025 at 3:17 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > It wasn't sent to me or to the stable list, so how could have I seen it?
> 
> Oh, of course, I forgot to add stable. How shall we proceed? Do you
> want me to resend to you with David's Signed-off-by?

Do I see it correctly that this will be 6.12.y and 6.13.y specific
backports since the code in mainline changed substantially with
e2d46f2ec332 ("netfs: Change the read result collector to only use one
work item") and so your change does not apply there anymore?

I'm asking since we got a bug report in Debian which seems to idicate
it might have the same root cause as you report, and it is at
https://bugs.debian.org/1098698 .

Regards,
Salvatore

