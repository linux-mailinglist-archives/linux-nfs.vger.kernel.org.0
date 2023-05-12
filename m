Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF895700FC9
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbjELUfP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 16:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbjELUfO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 16:35:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D9F1;
        Fri, 12 May 2023 13:35:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso75412005e9.0;
        Fri, 12 May 2023 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923705; x=1686515705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9q9IOHjC1OlavttONB/fPhSqhjx1Pw6wrvM4VT66EA=;
        b=mee6+fm9UuOx2D9z1/CST2E0V5GoFJv+K8lnL/C5HttDfQHVMKrSEzTqnmiHMpGdT3
         8MM6QKyuKcjo5OpPI9+DkZOXV1Mz6ZFnpKiod5pjTcOg/IoKpPte73wpQ+gJuN6k7r8v
         qXp2+BtD1pOPEn9AgqOQE9FnfR6mlDCK5JZ2GV7VqEJ9vsLX4BFAozufBNXYgmDLRBlL
         2mCwahBIo9gt3tFxW/9jb3WayG0wBFOY79/hm7aoxV60csL1hVaEAcDZYm4UN/aZpu7+
         4X0vwcfnFV2XlRqqv1ZcSo4L6D6kwvmJIr34iRQzA3SAdzLff//sIlb3gNur9s1AwB+3
         mrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923705; x=1686515705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9q9IOHjC1OlavttONB/fPhSqhjx1Pw6wrvM4VT66EA=;
        b=g8r/5rniBMc7b/2tEHuP8fVm/NHpi5DlzYhQtoIPDzSyBRIsYdBCv3hT/zYUOU5m50
         +VnamUNV5HO8hHa4VZr+8TiJTk48bSvQQy/8y7ZOcgQ9nk+XRJDcQp7lLSJ9Vz64C/fn
         R39VxP49SJuiPDqgMaq12hcxSsvLjLO/DITxkiXCWngfc/en72PitK/DQ+L0Ui8JAvBH
         6JUonj+17UHHTE2634mLk7sqWHNFVaNCy4ThHzlQdk9eHHTGUnXChvHxmHg+QUnX17ok
         GJrB7ieNXLoFszZZ1HqmFRlOc7jfYfDAK8emlvPtzJtuI5Atyr73gxH/KOqONBZzIgyJ
         g1rg==
X-Gm-Message-State: AC+VfDztF2RMsuBHosy+qHYu117ROJ01Yi1dqCAMCSPBx0tnNjBtpgk+
        ys9ZTF0j5aoEaukem+pcpE/cS9+CtaDKVHb1RlQ=
X-Google-Smtp-Source: ACHHUZ5Sf/6b7x4wWJ30YW/9I8P3WMl2ezn3idBZagON+lEhCcFEQqrfO0PLUy49/T0gVhwc7OHItE1f/Gg1us37eV8=
X-Received: by 2002:a1c:cc14:0:b0:3f4:20bd:ba46 with SMTP id
 h20-20020a1ccc14000000b003f420bdba46mr15619935wmb.5.1683923705179; Fri, 12
 May 2023 13:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
 <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com> <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
In-Reply-To: <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Fri, 12 May 2023 16:34:54 -0400
Message-ID: <CADmuW3UQ-wqobay34PY+myyk1Pr7s-cf7b-U7TUCnarEf+jsxg@mail.gmail.com>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Resending as plain text.

> >> strlcpy() reads the entire source buffer first.
> >> This read may exceed the destination size limit.
> >> This is both inefficient and can lead to linear read
> >> overflows if a source string is not NUL-terminated [1].
> >> In an effort to remove strlcpy() completely [2], replace
> >> strlcpy here.
> >
> > Let's update the patch description. This change is really
> > a clean up -- it doesn't address the memory issues you
> > originally described.
>
> Unless, of course, you intend to apply this patch /after/
> a patch that fixes __assign_str(). In that case, no change
> to the patch description is needed.

No, I plan to land this patch before attempting to fix __assign_str itself.
Let me know if the below description looks good to you and I'll send
over a v3 patch:

[PATCH v3] NFSD: Remove open coding of string copy

Instead of open coding a __dynamic_array(), use the __string() and
__assign_str()
helper macros that exist for this kind of use case.

Part of an effort to remove deprecated strlcpy() [1] completely from the
kernel[2].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
