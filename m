Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2D25A54
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2019 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfEUWeH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 18:34:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55235 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUWeH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 18:34:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so200806wml.4
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GWcKqoDzLDXpuafuimVQQMnRPipngjrMHYv31zMHFQ=;
        b=gZiSytRZ2/MBQ+JfyxlEs9mEw9A2TwotShpoyy+V3WexLSafViChsXEPLQXQLlnswK
         TvJlPfncV5KtBkOmkHJ00kYEvT0Ncxuq3B9uFrQj4RAEyzAWTZkAxCl+8UANz35jMurB
         y5SAfWQvb1OKtbM7JOa9ZPAZ5yA9FZFGuey7kq8RAihLQMDidtjk5MHhH5PiVtpt26QU
         3FDtPY2KJuw0buEjfRaZeIYN/vmiKOuWZ0gNVygsHuLNVI1vHyMkGig2DD8POlM5LO6b
         Ajmicgu0X/O4RTnmSOQNC4rixevRRbEdhjeed2HBL2l9XrCN7POVIn6m2/EiAW5VIZH4
         Y6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GWcKqoDzLDXpuafuimVQQMnRPipngjrMHYv31zMHFQ=;
        b=HlsM21zq/C/KK/58in7xD+Fc58EAC3YturhZPkR9ncY8639MHjW/Nd8OVIWesPg6Tv
         7DTL2zzv9dUOav9fiYyFyuFZyd/CR48VLiSDzPe1J/055w0ivQElqHqrluExLgTQ+EAb
         MdK1UZDyJ7avjghX6RgTHWgCC8MczFx/4AxqnX4dsiYFQnTsDp8C97/BAaj3Kn8W8CcS
         MhMufAvoUjLWf5wUtDKEAyVxxJ8yokIJYw65+M285A9WvBTU+dDkWX3p+i3EFaf5zcpa
         7to8d497QOShgixkRDsVzUN45+uf78J1xuZpaejhXClSk/A5CxsPL0tQKfLHpVDwKIzJ
         YeJw==
X-Gm-Message-State: APjAAAWzkAEar6SpmH4HcYiWn7oMnp1JhvisCF7bGm64PHKFBhTSlc1V
        m1jraDPdSViy79QXB0yk8Vzkb1qS171GH2cvBPLV+A==
X-Google-Smtp-Source: APXvYqwoK+hC4sSEvGKh3AcnlNsW+s/hNWKeMVcRYxg1LW6nPdfvN6FDfJsSqa5PHdu2cu5qQLSMBFe2RUCLuagdb8E=
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr4679655wmj.34.1558478044744;
 Tue, 21 May 2019 15:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <952928a350da64fd8de3e1a79deb8cc23552972f.1558362681.git.bcodding@redhat.com>
 <20190521155821.GD9499@fieldses.org> <A6640E39-5B5D-4CF3-8131-62F8106ED2E0@redhat.com>
In-Reply-To: <A6640E39-5B5D-4CF3-8131-62F8106ED2E0@redhat.com>
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Tue, 21 May 2019 15:33:53 -0700
Message-ID: <CAPtwhKp=qezMw4DfWkettC37wvYd+-6e0=isVdMx51_gFbi8bw@mail.gmail.com>
Subject: Re: [PATCH] Revert "lockd: Show pid of lockd for remote locks"
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 21, 2019 at 1:45 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 21 May 2019, at 11:58, J . Bruce Fields wrote:
>
> > On Mon, May 20, 2019 at 10:33:07AM -0400, Benjamin Coddington wrote:
> >> This reverts most of commit b8eee0e90f97 ("lockd: Show pid of lockd for
> >> remote locks"), which caused remote locks to not be differentiated between
> >> remote processes for NLM.

I just tested this today to be sure. And yes, this revert fixes the
problem we observed.

Reviewed-by: Xuewei Zhang <xueweiz@google.com>

Best regards,
Xuewei
