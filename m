Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7F60BC44
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJXVdw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJXVde (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 17:33:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24677149DEB
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 12:40:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f23so9325371plr.6
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e7Yb3UjXI5lPD0c86NuvTsR4Ku9WQF1hEfKBHFtxwhg=;
        b=kHTik2UzVrvImPNTajXntc1cg0KU7mNqCTbjgAevJo4ydpuUxkzTVb64DiW1dI5v7R
         KmG3PHhVXqDwjNr85Qd2kbviXR0vJ7uue9LHnuTnl904KRvi3Jyd0OVvfPGlATPczEdm
         zSk8G0VvxK1J+1ARlv1i0YrtC0RLpmywOZF4PWlObXMprKyj077syaLn8rXHMIkjhxY/
         h14G7/uKXnqgLVgBr9hu0rZr42zhZDPAnijBSors+n3SkZEob17iloWzu3/XUuD4U87Y
         DiCxQHFNoKx7WRxfKrnipNqCdTOw1L9+PDXvqj1Q7kDQD7+Bv8eadbjhj3w0DrxJg7SN
         vb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7Yb3UjXI5lPD0c86NuvTsR4Ku9WQF1hEfKBHFtxwhg=;
        b=0CsMb4aeRf5p5p1w7jdvEEVAUlepYx4rxeDpvYUumd+fj0dspn1Kq0KCIQfo8UfPjP
         o1TJT8oJZh6qACl6a1m/NIldzhI9aN7FhyehT+EWEYfBX+5YamxWWPTl8V2Ih+zzj9al
         urMpLFC+fUb7ok5/jv65t2cZTkM2kBZq6EvtA1tMo+F8ynKzNkeJKe4JxTPYXegpX2B3
         eFcM5zoxRDmuKPdS23WrKFyTtVVEAuS+SYPTr/+1xAQ4MSzUV9e7PO1ji0GvznB8a9Zl
         IBgVm6Oo9jSFSZ3IkWGYc0NS24TQuztu4rcwx7spSRuSIahFn6IaaT0VG2pm2DrppyxL
         ZqBw==
X-Gm-Message-State: ACrzQf3WmXK5sZv22VPNd0T+8cZ1S9/tsDPz71IUbFINFFIkBarNiIPx
        tL1vL+TUrIaY22bc3Z1KklV+qDpt/HF05tiJtnrp/Ot2sPo=
X-Google-Smtp-Source: AMsMyM5USMlux4SkMDB+irGmbrmZAfUJyh39QWbpWoosnTxddfXbxDx2g6XRo3VEBgPWd0o0/lp+y2ac/NpkcSB/jLk=
X-Received: by 2002:a17:90b:1bd2:b0:213:2d7:3162 with SMTP id
 oa18-20020a17090b1bd200b0021302d73162mr9492894pjb.91.1666640363788; Mon, 24
 Oct 2022 12:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220919235954.14011-1-rosenp@gmail.com> <0d972685-d120-0b2c-c072-b8e9941e0baf@redhat.com>
 <CAKxU2N8azu-nfzocWZDCGVj3Yawqnc6HjzvzeFktAn-57PHzPA@mail.gmail.com>
In-Reply-To: <CAKxU2N8azu-nfzocWZDCGVj3Yawqnc6HjzvzeFktAn-57PHzPA@mail.gmail.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Mon, 24 Oct 2022 12:39:37 -0700
Message-ID: <CAKxU2N_oWP2joevtFdkbME3AEcKfQ-HMrnOEB+poZj-wPm5cRQ@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 1:31 PM Rosen Penev <rosenp@gmail.com> wrote:
>
> On Tue, Sep 20, 2022 at 12:28 PM Steve Dickson <steved@redhat.com> wrote:
> >
> >
> >
> > On 9/19/22 7:59 PM, Rosen Penev wrote:
> > > Fixes compilation warning.
> > What was the warning? Plus AUTH_DES is no longer supported.
> Implicit function declaration as it's not in a header file or anything.
>
> I found the issue from doing a meson conversion for libtirpc:
> https://github.com/mesonbuild/wrapdb/pull/644
>
> I have no idea about AUTH_DES or what it's used for.
ping.
> >
> > steved.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >   src/svc_auth.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/src/svc_auth.c b/src/svc_auth.c
> > > index ce8bbd8..789d6af 100644
> > > --- a/src/svc_auth.c
> > > +++ b/src/svc_auth.c
> > > @@ -66,6 +66,9 @@ static struct authsvc *Auths = NULL;
> > >
> > >   extern SVCAUTH svc_auth_none;
> > >
> > > +#ifdef AUTHDES_SUPPORT
> > > +extern enum auth_stat _svcauth_des(struct svc_req *rqst, struct rpc_msg *msg);
> > > +#endif
> > >   /*
> > >    * The call rpc message, msg has been obtained from the wire.  The msg contains
> > >    * the raw form of credentials and verifiers.  authenticate returns AUTH_OK
> >
