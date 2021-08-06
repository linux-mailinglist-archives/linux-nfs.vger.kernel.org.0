Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EFF3E2F7C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhHFSyk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhHFSyY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 14:54:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B0C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 11:54:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d6so14385328edt.7
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jdz6H71DZeYXrVrYxh8PKZ8SWYi1wxXy7SxX/rrcv0=;
        b=KNlzYbkrAIB1MFmH/UbYBfhqhm9VO7fMdapkrF/tIsDTH561s2Vki+BeGOry4wSlKi
         5OqsC1XQkEAROwI8DbIELZYHINvVQHvSgniNqFL7gdTxJpALv7dM9JbMvaaXgJ7nBpcS
         p5/l5KOAo3viEA6lP8NFPbEFk5fGy74tv9SDZU7YTy3vXwl+JBmoTA7HV3EguqXXQP71
         vKGqAOF90TKo3dxA/6fGJbXuFr3NaJCQ5AFjzwERYNcrmHD1/uhC/CDLIG89Qjkk/FvY
         nB2c7i8hkfhTY70Y3cJwyQUJoVL6S3QvuhBNQXMo9eCxciIlXqzXIJ+WNPs9yyP+XKGl
         wtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jdz6H71DZeYXrVrYxh8PKZ8SWYi1wxXy7SxX/rrcv0=;
        b=g9zLrRVgEup4abGsHm3QhXVXNfmNR9Ebr0aE30I1pEz62zB89nWxtDwVGye7aCddwA
         nZqyHURR+h4nTa5z+e9kw2+6AimR6UO5s5HwMPHwN/hF9ih0ECLdLSE7tYbJ/GOq+efJ
         xgs8Q7xkIDZfYP72t7W1JzMB2Peh+2A1WAgprLU1akWt8g5HH8m9BIMSAk9oJmoBLHeB
         7T03PmfwDFKUOhpLl04VZ8vxtdwoVLA7k+Y6qRqlV9Np8E/BwFHPETTxC04RPF3inZO4
         iQZbpJEYdh8kP0YahfnJ/e9rnf3im9WMZb/8BK4iNZJLBq+xEpbZKQEpNJSwy5weMowY
         +Fiw==
X-Gm-Message-State: AOAM533dDJxtS+Sw1zP8I72JQW54QwvgE5Dw95gU3iJ3v/SS8N09bDQn
        XSiWS/wt9flW26OFxPlpIV/dHxVaY5xg0Prfflw=
X-Google-Smtp-Source: ABdhPJwyOcJIIuYHF/GY5NP77JvrGbxpBpUZRvTTQrH+A5QnzLPnPsWlbzQYWCtYwKblxg8Jbxnq5MnZpC8CaJMVkdc=
X-Received: by 2002:a05:6402:28a4:: with SMTP id eg36mr15121177edb.84.1628276045393;
 Fri, 06 Aug 2021 11:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com> <d812b290c1cdee5320b811f0329e5c1d4b1c1931.camel@redhat.com>
In-Reply-To: <d812b290c1cdee5320b811f0329e5c1d4b1c1931.camel@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 6 Aug 2021 14:53:54 -0400
Message-ID: <CAN-5tyEOKkABBHH-Xb5U=S1FqeTLuq1tD_PP_ch6sPsimgdWtQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] nfs-utils: Fix mem leaks in krb5_util
To:     Alice Mitchell <ajmitchell@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Still empty for me... :-/

On Fri, Aug 6, 2021 at 2:50 PM Alice Mitchell <ajmitchell@redhat.com> wrote:
>
>
