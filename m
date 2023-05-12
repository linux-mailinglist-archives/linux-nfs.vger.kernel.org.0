Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDEB700AA4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbjELOsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjELOsC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 10:48:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC035BD;
        Fri, 12 May 2023 07:47:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30644c18072so6777535f8f.2;
        Fri, 12 May 2023 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683902878; x=1686494878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTWOwvaldOjhH0pQJ19fjebD/f7HM2yIpHGXSGoIMBQ=;
        b=s0Qk3g8qmpnn3ljcH+Uj+lqL2PcU4a7jlP3kpceUkoABcUYQIoWn5y9H/FfonpSObS
         A6oikBG4fsw/6msCWVsnmHfNh56khpsc9/wIgbt/AQFlq+gVUrb73L6FhbmYi63dOY5d
         NWNoAYVZu2U1LVzUTVrRvMuJV+lDwtMsR9T9a9BC5ZGpZ97rJoV8ozKoplnfJ/Oc/A70
         lsu11EkAo65SdICsX08n7TBR/vsI5JFe9V+xYZ3pDjSttvFc0oea9T1rzYB7oOicHqZ4
         RTnuJVHg9CpESQ24oMmvlUUNr6DQ0ISvNVBQiXx4Gm5sZS5W7W2v3SZo1XsnlvHAZpb4
         LH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683902878; x=1686494878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTWOwvaldOjhH0pQJ19fjebD/f7HM2yIpHGXSGoIMBQ=;
        b=Id4k0EIjA2xbhumw9lsORPAuqBYINl/ePf+oIfNnjvW9w2pmDLxxT44/qyrxqNIk+y
         tKDNUa+qiztRo2SQl1AHwGRfv5aKvY/VVJaBaNHrcUkGa4tMtcl7UF5WDhjEefFUgYGw
         zoVZeC468VaTKoOajg3/MFbhn83T6AMLlWpgVtCBmYRiGE4MIemy8qOjq+tQVfN3YcmP
         +/GmRfZFrwqkj6wEZ/xviJqcPQVAHzSYE1ubBjaFIJsynsXI5NIpGoHKZ4BRKo1xp+Gg
         /YsGJhksS+/fDWUZt3uob55SOwsarbpwvNhum8NusA1FIKX/eIPhYwh5iWj9QGDniA9y
         mXvg==
X-Gm-Message-State: AC+VfDzRRbPBJ1iv4Rmks7rY2wEZy69RkiOUndomkE/QxLi/LekPCggz
        FdlSaU0/+X6Emx6C9D3vk2CNCN4Q4xRWCcXDf9+mYnPiAdM=
X-Google-Smtp-Source: ACHHUZ4i8c9vgKonUU+4oTtcbm6xlE6mdGwFTl7WVckAgjVGOTRmy4tKnleal63lPFXY2l2HeyQq6ejgXPhQGX3dRZY=
X-Received: by 2002:a5d:6401:0:b0:306:2f8e:d259 with SMTP id
 z1-20020a5d6401000000b003062f8ed259mr15959551wru.57.1683902877799; Fri, 12
 May 2023 07:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
 <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com> <202305110927.12508719D2@keescook>
 <CADmuW3UbHBWN0JzXMYX667hkXyWJY8_88K1sJfRnKNg7_u38=A@mail.gmail.com> <076418CA-6400-4A92-8634-60F2934F985D@oracle.com>
In-Reply-To: <076418CA-6400-4A92-8634-60F2934F985D@oracle.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Fri, 12 May 2023 10:47:46 -0400
Message-ID: <CADmuW3W5=pyg5AF5UPbj-+8geyxn7zcjsTkOO+_r4FSpWJq8YQ@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, May 12, 2023 at 10:38=E2=80=AFAM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
>
>
>
> > On May 12, 2023, at 7:30 AM, Azeem Shaikh <azeemshaikh38@gmail.com> wro=
te:
> >
> > Thanks Chuck and Kees for the review.
> >
> >>> Actually netid should use the __string() and __assign_str()
> >>> macros rather than open-coding a string copy, I think.
> >
> > Do you mean something like this?
> >
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 4183819ea082..72a906a053dc 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
> >                __field(u32, cl_id)
> >                __field(unsigned long, authflavor)
> >                __sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> > -               __array(unsigned char, netid, 8)
> > +               __string(netid, netid)
> >        ),
> >        TP_fast_assign(
> >                __entry->cl_boot =3D clp->cl_clientid.cl_boot;
> >                __entry->cl_id =3D clp->cl_clientid.cl_id;
> > -               strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> > +               __assign_str(netid, netid);
> >                __entry->authflavor =3D authflavor;
> >                __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
> >                                  clp->cl_cb_conn.cb_addrlen)
> >        ),
> >        TP_printk("addr=3D%pISpc client %08x:%08x proto=3D%s flavor=3D%s=
",
> >                __get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
> > -               __entry->netid, show_nfsd_authflavor(__entry->authflavo=
r))
> > +               __get_str(netid), show_nfsd_authflavor(__entry->authfla=
vor))
> > );
>
> Yes. I don't remember why I chose to open-code the string
> handling in here.
>
> I agree with Kees, also: __assign_str() needs to handle
> the memory accesses properly, and I had assumed it did
> that already. My bad. That IMO should be handled as a
> separate patch.

Thanks I'll send out a patch with the __assign_str replacement for now.
I'll wait for Kees and Steve to respond on how to fix the memory
access in __assign_str.

> >>> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> >
> > Ack.
>
> I agree that it's not a high priority backport. However,
> I expect those who want to use trace points on KASAN-
> enabled stable kernels might prefer to have the
> __assign_str fix in place, along with this one.
>
> So, I'm good with including Fixes: or leaving it off. Up
> to you!
>

Will include it :)
