Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A271A365
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFAP4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjFAP4i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 11:56:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105CE6E
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 08:56:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f6bafd4782so7345901cf.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jun 2023 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685634986; x=1688226986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXdTYeXEHp2X2kaNh5l+DqQxKLPjaSKA/uHP20jjuCs=;
        b=nJHWICjWd6R8SOB2ufNKan2zq0SiBaDMlbRLjEZMvU/Xr418So8zqICOL6LWS/u9eR
         arN29cDYlX+rM8LWlxsgrsv2Wcj+Kkn8tGee7BwcVcF8aU63+6fSRHy/SNam7sGoF+lb
         4W+usmBKRrBEPIpmeacW1qK6Nmov6ZGm2XVht2BgChKdV5DBdUXOnMoyxXEZb1r96cD1
         5IYLvaoHRnF/skSGbl054yxerm3korG7UA/VJ4L6u3pqxhbs/ic01In88PXxLgBadmH9
         tzQPVUaQqlVt5Se8ZGXARklwAFibDDaZLc7Mr0x/uYSsfb1yYNUC10s+dFp6gPZhMm1J
         3Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634986; x=1688226986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXdTYeXEHp2X2kaNh5l+DqQxKLPjaSKA/uHP20jjuCs=;
        b=IIq8dKkxSdk6mPfHEYwJU1Jc2tt+KL/1QF+Iz+acxFMPoJWm3X/UfWC8iCK6QYp7SI
         8gQ12pxSQulUoatbeKzc8vJ9lwWu7jN8KngDQXefL9rwq+SWkRSos/RQSEMi4hLpmliP
         QZtbgLe+ZdTljBhuSQvycR//V+5KmUQ11jwZnZefqELdySazoCOVL3M0SdD0RMvFJSqO
         /mvvlwGEUKtS3CeBXXj39BaQUc7vctCBMbVjtk5LqKt+N+9hqkLEjBXCIs8VYlt/ecqU
         mRn4kspS2xUlNf235g290/Z2qmRaV0mvjEuSb8AwVDVjnBYFDV1GzpFCguEZ/iOhBgCj
         aK/Q==
X-Gm-Message-State: AC+VfDzAMwf4b5kwRnVpyuyRSY+QixiFXKQtNXeUJIqaaw/+Kj143XQf
        t9R0yaVETmaxMcOa29LQ5islpNNOjm1dkNOss00=
X-Google-Smtp-Source: ACHHUZ7BUdL2sl2e6bI+noHgtv/KGfIz+9qF4AcuFfeWZ7d02XX7SojFap0PdPsU/AuqoknDhY+S1rXUe7jg22AMOJc=
X-Received: by 2002:a05:622a:1713:b0:3f5:d890:8aa6 with SMTP id
 h19-20020a05622a171300b003f5d8908aa6mr11342066qtk.60.1685634986366; Thu, 01
 Jun 2023 08:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143332.255312-1-dmantipov@yandex.ru> <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
 <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
In-Reply-To: <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 1 Jun 2023 11:56:10 -0400
Message-ID: <CAFX2JfmGvpa2ucp=ZxWm_RszTXGr+50mbkatbscXu=BbVpAwgg@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 1, 2023 at 11:46=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Thu, Jun 01, 2023 at 02:38:58PM +0000, Chuck Lever III wrote:
> > > - if (len > SIZE_MAX / sizeof(*p))
> > > + if (unlikely(SIZE_MAX =3D=3D U32_MAX ? (len > U32_MAX / sizeof(*p))=
 : 0))
> >
>
> This is a bug in Clang.
>
> Generally the rule, is that if there is a bug in the static checker then
> you should fix the checker instead of the code.  Smatch used to have
> this same bug but I fixed it.  So it's not something which is
> unfixable.  This doesn't cause a problem for normal Clang builds, only
> for W=3D1, right?
>
> But, here is a nicer way to fix it.  You can send this, or I can send
> it tomorrow with your Reported-by?
>
> regards,
> dan carpenter
>
> Fix the following warning observed when building 64-bit (actually arm64)
> kernel with clang-17 (make LLVM=3D1 W=3D1):
>
> include/linux/sunrpc/xdr.h:779:10: warning: result of comparison of const=
ant
> 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') =
is
> always false [-Wtautological-constant-out-of-range-compare]
>  779 |         if (len > SIZE_MAX / sizeof(*p))
>
> That is, an overflow check makes sense for 32-bit kernel only.  Silence
> the Clang warning and make the code nicer by using the size_mul()
> function to prevent integer overflows.
>
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index f89ec4b5ea16..dbf7620a2853 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -775,9 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr=
,
>
>         if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
>                 return -EBADMSG;
> -       if (len > SIZE_MAX / sizeof(*p))
> -               return -EBADMSG;
> -       p =3D xdr_inline_decode(xdr, len * sizeof(*p));
> +       p =3D xdr_inline_decode(xdr, size_mul(len, sizeof(*p)));

I personally prefer this approach, and I agree that it makes the code
look nicer.

Anna


>         if (unlikely(!p))
>                 return -EBADMSG;
>         if (array =3D=3D NULL)
>
