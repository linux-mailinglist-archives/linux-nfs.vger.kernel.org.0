Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFDE3E2F7B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhHFSt6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhHFSt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 14:49:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DFC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 11:49:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c25so2706129ejb.3
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caUrqYILbllVz1ZX4/RjO+s5nVonpX9reu3vUgrD+5M=;
        b=at2tqi7mQBHUg6N3zotQtPUG3EVlhfutPI0TQ2Wswl2F7fbg93Eva1OyCYFpMOUqXs
         t+oPBeSs1nfh97+ywvmsrJb+h1TUjGm5VeHWb3qB/Xh9Sk0g5gjRIFG+sYJT9mCdwCYa
         U9RUtCHwLeoZwx4jHO3GxaKvFlgKaO1BIgk6hB8+PpLUEkk33o6+/fBJbOofhb0bZF1x
         xOlUXdF6bF1I7S3PPzkKdjzR/2H5NA5z/wTtYcx4KzN9obqHyTMHj5rRIyT1IUXq3B1h
         H1EBOde09IRWujaT7H+blcgIIoZ+Gn6NG7sHGOPT5uyr/EJAabNK7bDJF6Cjr7GRFp6I
         Ys7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caUrqYILbllVz1ZX4/RjO+s5nVonpX9reu3vUgrD+5M=;
        b=FBUUX+q40wqg3jDNCnN6CxnK7y6t0jtAIpdS/AyGm8iXmyhU8QyCj4+cBAG+FmqtVX
         1f8qD2kZ1aX3Z2u/FC5/7JyQP9AQZEXbgkznErCYvJ95lMPHTpwewalL/SZcv4yLf42w
         JuMXhzqN7yXf1S4Tlh9BWqr8HJgac/CaFAmO7EHnSMYUYxgXwbkfLEhfwCTFB1XlYMC6
         w095COI/Nrc0Umvi6cL6B9NZ3bFJ+evgSE5vaRkW/5+P8HBTLloml5z8gWihUS26UEu9
         YW9soBYC8SSnU/4cgfcon2/xHc7YXTx4VDRZ+W2RpS7TwCgdXwDrxzn41mEss9CB4nVm
         AiPw==
X-Gm-Message-State: AOAM5310Y4o4lVnfVCiSbDUqauWwLGNXsBbtEYAWD6lM0SexEmbGRWUY
        8HFehZJJ4AHtFKE50AeclFyooTo9UNF/hi458UA=
X-Google-Smtp-Source: ABdhPJzMSEjh3TjNjkrlabqJ+eCfwWgMGSQnyC+hDclP/h3g3l682QTBDkGLtKDvJ18VCwGhExeIJiiAqPF53HNSXPo=
X-Received: by 2002:a17:906:270f:: with SMTP id z15mr4438453ejc.348.1628275780106;
 Fri, 06 Aug 2021 11:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com> <3209bf6bdf0a167a19cd56be5c57abfcc761850b.camel@redhat.com>
In-Reply-To: <3209bf6bdf0a167a19cd56be5c57abfcc761850b.camel@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 6 Aug 2021 14:49:29 -0400
Message-ID: <CAN-5tyH0SRCvkB95wifjzzTGsVqHbEggNZueH98NKjrU2ftMVA@mail.gmail.com>
Subject: Re: [PATCH 3/4] nfs-utils: Fix mem leaks in krb5_util
To:     Alice Mitchell <ajmitchell@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Empty patch?

On Fri, Aug 6, 2021 at 12:25 PM Alice Mitchell <ajmitchell@redhat.com> wrote:
>
>
