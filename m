Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2581C3B3471
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFXRL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFXRLz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 13:11:55 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2270C0613A2
        for <linux-nfs@vger.kernel.org>; Thu, 24 Jun 2021 10:09:32 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v5so7093625ilo.5
        for <linux-nfs@vger.kernel.org>; Thu, 24 Jun 2021 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=n9E1Q5L2VkLA/gQj6dszATepg94/TCGIwJHvXAI+xReiL4MIsZlap+6nGxCBXC8Lq4
         FJPyt+w04ZmKEIVk01mM36obZukcyE5xUoFNvRAXExybXnTCtHHywOi8fx5QP8th269c
         vkZKF5/fbaZ1atf3xt4Sa1xe3otihA1R0p2/nKHytt4IkEs64GUvfSh8HO4qQvao5aTV
         n+nMM6bgLlhLc4dEKRxeV85P9mHGs4X7449CJ30WSX9dohN6yUG1lI5E6itdWvI+AH9z
         AUAQBtQoDQdxG9wh5hX7uAtKSbsxYM6LZOMsDjLYTv1IUhPOx0TMLLxlN0JubOQuLUIa
         J3Ag==
X-Gm-Message-State: AOAM5319+4PK6mcfMRdqtGXZmnZoZfE6t9mau4hFhF86WoQOpxPP4xQM
        wINCNZPzf5aE8ba1mmGDGlN0z23U6cgXXj4oqXslKtIHs51+Ww==
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
