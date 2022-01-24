Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8ED497F9B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiAXMeJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 07:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiAXMeJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 07:34:09 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FACC06173B
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 04:34:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so20898116ejc.8
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 04:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCjjWkJcYMfxz5mbGVyQ53FOzP16gT530bbk1TahS0U=;
        b=g9LkreHwUxKlaIFgiHXTDOd/wTAlEkRLkmIvqTngaQqDIXIo0S0uudl3qgOLY3Iv2e
         LOa02lTUUG5sHvHvSLeF82Hv9Vmo1iBH6FFZ7kbq5EVOAOeQtFglb6u9fcgJ/BcK0zlO
         YHMT6RYCKhUCUzIIt7QMi4PkeQCy02IYlGu7DJLdeTaG1i2Xpm31YPTRMzOplQcSk7zP
         s14LciMPUmkPaaM+A1vW2zLOOXkZ+dJIVFSan6F/W8Pdc9ZUGnUHSL2RbqFGYdxP+dYw
         mc2VAE6yZcWfW40kCRuSc8NlhvaKPqOfnkiA/zzxesWcPpHtAxzcg1oIVN7jGDMHLglW
         bhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCjjWkJcYMfxz5mbGVyQ53FOzP16gT530bbk1TahS0U=;
        b=r3Lu6samZBGBCvWQLMzIvx6TgmZQcitLuXGLcrMXeEbtv6FRmF+ijkAHSiTHF02gfF
         0Ly1nVXgFHdQqBHsrul5ATuVIlLPcQw9qHfj0cY99ClwRlQCt9QLm8XLzAHT9VYHMg0a
         SJbNiklpckCqclVXBMSliT0ZcV3kQ0CIRM/saSHwJjT2681ni0w1S2BbV2ue7KsgiPEO
         5FuNqJ8Uk9sS8NP+5M3a8aLbcbGfmEeF/4Ff20x+STyYBTFXCQorPxQdlwUhieSBat1w
         t53isoxGMy93DHLVm9myUv87TRIKdoz1/Kix9vL7Ny3p/J9eJpQweFHI2Vf3OM6yQeJy
         7vIg==
X-Gm-Message-State: AOAM530fBEnM1UTXMolalGtXR7zTcmllqDQAvDZJrqSnAq6nqRuMqeSF
        JqnlioZBYoekbc2CssaoZMtBoG3/1HE0kB49HsCi2YeVbHSxZg==
X-Google-Smtp-Source: ABdhPJz4EOyik3AyRJ9puipSIjmMLWw+u+eWP/s0qhtjw1tHEAKZy5XgmT8vi38ypJTz46bhaKFJhnXUSIywIm2nNMA=
X-Received: by 2002:a17:906:5048:: with SMTP id e8mr12136157ejk.651.1643027647062;
 Mon, 24 Jan 2022 04:34:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org> <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
 <20220110145210.GA18213@fieldses.org> <20220110172106.GC18213@fieldses.org>
 <CAPt2mGPUa_VHHshXwLLCH=wvdrd6Hyb4gttMeEqKdgFV4GJY7g@mail.gmail.com> <20220123224238.GA9255@fieldses.org>
In-Reply-To: <20220123224238.GA9255@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 24 Jan 2022 12:33:31 +0000
Message-ID: <CAPt2mGMXHqBtWJhuEM76MY5tm0V=uAghKT21KRsHBQAfgkuJpg@mail.gmail.com>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 23 Jan 2022 at 22:42, J. Bruce Fields <bfields@fieldses.org> wrote:
> > I suspect it's just more recent kernels that has lost the ability to
> > use v4+noresvport
>
> Yes, thanks for checking that.  Let us know if you narrow down the
> kernel any more.

https://bugzilla.kernel.org/show_bug.cgi?id=215526

I think it stopped working somewhere between v5.11 and v5.12. I'll try
and bisect it this week.

Daire
