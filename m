Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D17E75B4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 01:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjKJALS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 19:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjKJALJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 19:11:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213975240
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 16:07:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507f1c29f25so1911896e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 16:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574839; x=1700179639; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fuDLWD5qbCAsJeJrobmOz6oSQqC7pTC3577ZLVdoLZg=;
        b=Hx5kfzUE6sAUOwjhMZOY5TnYhzVQc6HClvJukNkWhTAJXpzldNzqTqH4FhCwhDkgkZ
         jf7gZnBjuVjqFyRm0saSmaTv47efrI2KrxBNyHpq50wLYyDzEVQqzXfH1L6gL+2EjzYP
         5i7WNQzb8PS9IYxvhK5ijgpC3OOG+KI3MbCRCL0dRL0bZE5QBUyMkC8xrKYngHSSsAWG
         r6W45cmQNsmM6fHDCSpIRPRJaqx3nYwcSJif9Q4f/n0wRMyWiAWP1tQHTToI8fgmuK1v
         7KkSvB/JOM6dlQCSLBM6FZU044QsPzwdHdnW71tNUz7C3JkkkfhGZnzG/zmBJAB76qCr
         xTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574839; x=1700179639;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuDLWD5qbCAsJeJrobmOz6oSQqC7pTC3577ZLVdoLZg=;
        b=Q7yF8I807tG4j36mg+gXQqIONAXVcOXH149tesnHuI6Jum9rk7lwAne4SQ5KrwYiXE
         IolXRiiUG0V5Jas4SwJEz2B9NP/W/CcEb1nnTW0L2jP6LeiCyZpe74HFYqmfr4Zfsinq
         +eEoxhnlT1fY61KGMTifxHfLOzFfMjMiiRgY4ZuWKeKaRGkuy45gr1CuDTnWvHvIvnuA
         tgTmVwfD8vXLnQTC1CohBmOii8VrlwsIUwtPmredQY5G6m/S0qB92BOGUeih8g7gualw
         CJl+EOh4O7DJmEtIKzP9YXtjQd2bAdalvIV6Zq93fcrIFMI+MP1k0fQ6ZSas1q7fMMNe
         xCbg==
X-Gm-Message-State: AOJu0YzpazhYymmPoETJfwlTDt7G91IWq10Xi71P04Xe7SaGB7Qr6DqW
        TDRc6co6OjtEI7q+jsJH7p9Jhzfk1zLIcslpzws=
X-Google-Smtp-Source: AGHT+IEEVcWYjJ2E9vhNe1YTmf7wADe8un8odcTZAtEYy4/iLGXzLdnXGKbs3OI/Q5TRzysdEjmVDMMdx6LB+vndFGs=
X-Received: by 2002:a05:6512:3b97:b0:500:99a9:bc40 with SMTP id
 g23-20020a0565123b9700b0050099a9bc40mr3249496lfv.69.1699574839084; Thu, 09
 Nov 2023 16:07:19 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0Ucch734JB9piCUaTbCXwuuYSTmayvSin8RFYfcYcD+FmA@mail.gmail.com>
In-Reply-To: <CALXu0Ucch734JB9piCUaTbCXwuuYSTmayvSin8RFYfcYcD+FmA@mail.gmail.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Fri, 10 Nov 2023 01:06:42 +0100
Message-ID: <CALXu0UfzqBu-T9tZuchqnZBkvfuDUJaBmcDgTaWZfUC_yimGCA@mail.gmail.com>
Subject: Re: CITI ms-nfsv41 client: IOCTL_NFS41_WRITE failed with 31
 xid=5481722 opcode=NFS41_FILE_QUERY?
To:     Ms-nfs41-client-devel@lists.sourceforge.net,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 1 Sept 2023 at 05:53, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> The CITI ms-nfsv41 client for Windows sometimes prints the following warnings:
>
> 1eac: IOCTL_NFS41_WRITE failed with 31 xid=5481722 opcode=NFS41_FILE_QUERY
>
> Does anyone know what this means? Data loss?

Roland Mainz fixed the bug in
https://github.com/kofemann/ms-nfs41-client/commit/7824f2398170d07d2ad83bd23fac4dacd34cd47a

So no data loss, but a Win32 syscall randomly failed.


Ced
--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
