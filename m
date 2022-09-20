Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A067A5BEE93
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiITUb3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiITUb1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 16:31:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04207548F
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 13:31:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12000799pjq.3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZvpxC1JMIWSbTd3d8AxkKi3i5KepOdJosR/wfNdLeKU=;
        b=YlGJWARkkQGNfLJKOfLBIq/ctG09j3XfpFSRQhP5gTN5C82MNzQw8SVx12FbRsIaaz
         7GdSJK5glPCeEY+3zcETDa00TLDh71Y29zSw2+eAVMJh2UnzPVOQ4PadRZC9W7Xp6Yvf
         iRK5ue2xnw0e9rdIFziu3/NhVRNLPyz/Hgi9yUAGrcY2cNBnr2Nh/m55MMulpQ3E88J9
         tkaffad9K1MgYxwvycb47oPMUupquzu11ewr+fwyDNCEHcPP5ckhMVYKq9+Zl5eXqiLH
         ZCVEIUUvA6L8+JqAq94znBJY5mLB6UZAtrklabGmjJcypj3nSgdLMj/9+i5EM6CdjzW+
         hNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZvpxC1JMIWSbTd3d8AxkKi3i5KepOdJosR/wfNdLeKU=;
        b=S5CZHFUvq55Tp/sALptVu1OrnN4hg+mmaCQ4j2/bTKhjhEoUbpTv3waC6UEFgPok31
         iLdd1xHghy8jES/qvu+fuZu/NPfXAGe8Rv5ZwdDuvHIHNa4eGcgiWrXDDqWkVR8Ndo/s
         IEGSJcnUhYpCRQmaJCyxRvEuqeTfV4I78THYIFb1/TBkG5buSqpJslrNuYw+oKSQjCjW
         8nwocm9XcmTGZAGtm41YMNiJcOi0U33dXmqwyrbyllT4elZZ1nSOolfJK+JZCFKBtEpp
         SdDdBR5cYfWUz1oN3yPLxkTonaGmmCY2F4TnTudd2OejwlYVO4BEMj/JjK8CGI7CwGCC
         a48g==
X-Gm-Message-State: ACrzQf29DiQnWH6jYfgiQObH51FlZ1chUvHF4WNaFuRPYvVLYmAsznb/
        6pCzNGDlrFBBR6b3iyMFPFclkI85p20sDohjwWvqmu72zlyeVA==
X-Google-Smtp-Source: AMsMyM4w4qPGng2Ep0uwbdHVPhYGcfYdq55v7fCQONkmnkJKQwceHW2aQxpm9BB0GjFSMQKfUXvt8kk2FU7qx8IfXeQ=
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id
 s2-20020a17090a1c0200b001e00df731f2mr5612263pjs.222.1663705886252; Tue, 20
 Sep 2022 13:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220919235954.14011-1-rosenp@gmail.com> <0d972685-d120-0b2c-c072-b8e9941e0baf@redhat.com>
In-Reply-To: <0d972685-d120-0b2c-c072-b8e9941e0baf@redhat.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Tue, 20 Sep 2022 13:31:19 -0700
Message-ID: <CAKxU2N8azu-nfzocWZDCGVj3Yawqnc6HjzvzeFktAn-57PHzPA@mail.gmail.com>
Subject: Re: [PATCH] libtirpc: add missing extern
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 20, 2022 at 12:28 PM Steve Dickson <steved@redhat.com> wrote:
>
>
>
> On 9/19/22 7:59 PM, Rosen Penev wrote:
> > Fixes compilation warning.
> What was the warning? Plus AUTH_DES is no longer supported.
Implicit function declaration as it's not in a header file or anything.

I found the issue from doing a meson conversion for libtirpc:
https://github.com/mesonbuild/wrapdb/pull/644

I have no idea about AUTH_DES or what it's used for.
>
> steved.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   src/svc_auth.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/src/svc_auth.c b/src/svc_auth.c
> > index ce8bbd8..789d6af 100644
> > --- a/src/svc_auth.c
> > +++ b/src/svc_auth.c
> > @@ -66,6 +66,9 @@ static struct authsvc *Auths = NULL;
> >
> >   extern SVCAUTH svc_auth_none;
> >
> > +#ifdef AUTHDES_SUPPORT
> > +extern enum auth_stat _svcauth_des(struct svc_req *rqst, struct rpc_msg *msg);
> > +#endif
> >   /*
> >    * The call rpc message, msg has been obtained from the wire.  The msg contains
> >    * the raw form of credentials and verifiers.  authenticate returns AUTH_OK
>
