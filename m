Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068B5702FE3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbjEOOcA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbjEOObj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 10:31:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6B269D;
        Mon, 15 May 2023 07:31:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f427118644so84318805e9.0;
        Mon, 15 May 2023 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161069; x=1686753069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMPhyVWRqve92qYxQaDpJ5fmq5M8NJnbMmmflE/u0Cg=;
        b=QuIZVY/rNSsT2I8KjDr8bvjq4OrrOe62ixH+1L0Btc9YqVkFojhhs+F1lS8GiDhGbk
         QIprgLjJn0AnrYzqJ88jS67LGJqFlTuRk3GpmetbBvyrR6azel2H3Holhoj6y+l4l0oV
         36vWDWJc/TcIDi7gzugJD1FNMqIRaoZR1VyrTwU7p1Od3QSwOAs8OgV7P8r3uAZaGhTI
         qpU3/BSc3vbwLvN0jybs+AgrxAchE/QOM3GTvq7DDa4w1lYQK4G69K+Nz9ejb8AMnzX9
         WJDoSgQRxOyS95AQWSvGD3eX0qw18ZLT+PfahmYqkQCCQ7IrAqKP6Xf5OB3/7orhru29
         9N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161069; x=1686753069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMPhyVWRqve92qYxQaDpJ5fmq5M8NJnbMmmflE/u0Cg=;
        b=DnUNcHiFJgt1lyiijaeBtPkUb2VzZrwjbMKk6SYeZ/MmIZqKlHZDszGw2hEGa/z21W
         OiMcqxCqjxvaeVDDcekoG2za/iJQEohWU0uNhrk/HCuMNHMghW/gBDY+DgNPz5oMXgZc
         jQB+IdKILi9wrp6NG2Y62L8zTSwYfxWsfFx2OhPQq/7DQIea2PkrKJASk3UA6gJVrPqf
         btzHL6T1wCS5+CahuTG0Dlilv29WJglIbzxgMUxVZ0hn5M9Ivt9Vx5sNCEZ/TI+u4DJ+
         7hLjjxIBamLhmOlaVGwytjrFuKkSX3QnlnTEt0ZqtISc3FcB8iYimefvQdwsouAZqQe0
         ixFw==
X-Gm-Message-State: AC+VfDzjnYUo2oJQF11g2efxcbDcmxc0IOzJVzySk5J3ioBwF7WGvKiI
        Wi6wWcWjtuQeFDbt19YeIejRn1CUmL51cZT6sNM=
X-Google-Smtp-Source: ACHHUZ6aF70Xv94MHjpGGQxsWd0hdVMfuAjDOC9asCmf8hXrviuwNa0iqV48/659KNPtV2SO/8x1NNWOspWCTDEDMA8=
X-Received: by 2002:a1c:f202:0:b0:3f2:5be3:cd6a with SMTP id
 s2-20020a1cf202000000b003f25be3cd6amr27501307wmc.4.1684161068525; Mon, 15 May
 2023 07:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230515024044.2677124-1-azeemshaikh38@gmail.com> <338aa895e02c795329c980cee67463faef0fc57e.camel@kernel.org>
In-Reply-To: <338aa895e02c795329c980cee67463faef0fc57e.camel@kernel.org>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Mon, 15 May 2023 10:30:57 -0400
Message-ID: <CADmuW3V_J+5ikfArEmj8_a9HYpX57rON6BE9fV5bXsix+XtqxQ@mail.gmail.com>
Subject: Re: [PATCH v3] NFSD: Remove open coding of string copy
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 15, 2023 at 7:21=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2023-05-15 at 02:40 +0000, Azeem Shaikh wrote:
> > Instead of open coding a __dynamic_array(), use the __string() and
> > __assign_str() helper macros that exist for this kind of use case.
> >
> > Part of an effort to remove deprecated strlcpy() [1] completely from th=
e
> > kernel[2].
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---

v1 and v2 links for posterity.
v1: https://lore.kernel.org/all/20230510220952.3507366-1-azeemshaikh38@gmai=
l.com/
v2: https://lore.kernel.org/all/20230512145356.396567-1-azeemshaikh38@gmail=
.com/

> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!
