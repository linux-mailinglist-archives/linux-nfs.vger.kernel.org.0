Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62064693D73
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 05:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBMEaj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Feb 2023 23:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMEai (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Feb 2023 23:30:38 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD7E396
        for <linux-nfs@vger.kernel.org>; Sun, 12 Feb 2023 20:30:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bx22so10724204pjb.3
        for <linux-nfs@vger.kernel.org>; Sun, 12 Feb 2023 20:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGvrqA2TD+iaa6FQ0Wstv37JOnWL//deHlvXk3SdtF8=;
        b=pMnj+3aINRMcLNznn/J8N8uDS80heNcs7j85Xirb2WMsEuACrhRPXcGiUKQ/RkRi1e
         DVuTmF2a7Qzsa7vFXLaw9WvR45QUUshVRmQ2ZHB+erUmSXRgmb7fhXaoKuCJpzTxC2Vf
         vDO1bxGV4zxVKqpmENzCkM0kTwqDNR1nxNiOlzzjs6VrO+p5iBi4rezp1uAOKv+FRrjH
         m1rxstYfKEkT9YDkVJC74AaWb50AwLjL5bjr21sxrdgg2zCMdve9k4u3ivUB6PMRzBtg
         aLYnBF12dKL0MqK0C0cGTivvspsku4JFuSTkg+V2D/IvxG0feJ0CTukZH5C7p9p/7dwq
         Jr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGvrqA2TD+iaa6FQ0Wstv37JOnWL//deHlvXk3SdtF8=;
        b=Foeuu3ngc0YR8qRidtIhKCXSZKyVPcdWyK1gZy90gzEqSJR3HU61jiYv2jEPwncFXQ
         JfNU8oGSnAooomVeECM3/g2luNwxze/W3tIEsr/oK4/tAp23dhbu5dT/aVEognhzYx2B
         GTtzZ0EM+456NUpcFhF+WAJL9jdRV+BPnWG+fB6spp00eviKHBSmBJ58HClo8N6+ubLy
         hHo7tETdVnZHEm1cGwHd/azBSUZ1rJEuULENrREALlUMBwp6ZczqDPDcoOUi0hOgVn0N
         eG9M8L9h4UsJaFSPJFBaumY5fnXeNRKCjBeWIIVxGiMeUWzGZqwnvMWa+eE+iW+BL0mQ
         v9GQ==
X-Gm-Message-State: AO0yUKW/OKx2VwAAC30JgDv3A12hndr/SEgw22LpPHKVTA8Sr8tO3Q3a
        fVCRs1rmnxvVWmmJvyZuPEMRXIZJztZsg9H5aA==
X-Google-Smtp-Source: AK7set/uEpf+zBNlhzAJazSqfGpaobUUse3nfDLxcNSNfC5LGBZ3wj4SZCQVVKW2JEgPHpzMJnWv2IXCFwOkBaB6jHw=
X-Received: by 2002:a17:90a:9405:b0:233:f75c:b272 with SMTP id
 r5-20020a17090a940500b00233f75cb272mr435827pjo.4.1676262637430; Sun, 12 Feb
 2023 20:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20230212140148.4F0D.409509F4@e16-tech.com> <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
In-Reply-To: <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Sun, 12 Feb 2023 20:30:25 -0800
Message-ID: <CAM5tNy4hXW_YUExyncJAFU07yVhnvAG7dnNM+YFROsLOEM9qBQ@mail.gmail.com>
Subject: Re: question about the performance impact of sec=krb5
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Feb 12, 2023 at 9:47 AM Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca
>
>
>
>
> > On Feb 12, 2023, at 1:01 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi,
> >
> > question about the performance of sec=3Dkrb5.
> >
> > https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-=
impact-kerberos
> > Performance impact of krb5:
> >       Average IOPS decreased by 53%
> >       Average throughput decreased by 53%
> >       Average latency increased by 3.2 ms
>
> Looking at the numbers in this article... they don't
> seem quite right. Here are the others:
>
> > Performance impact of krb5i:
> >       =E2=80=A2 Average IOPS decreased by 55%
> >       =E2=80=A2 Average throughput decreased by 55%
> >       =E2=80=A2 Average latency increased by 0.6 ms
> > Performance impact of krb5p:
> >       =E2=80=A2 Average IOPS decreased by 77%
> >       =E2=80=A2 Average throughput decreased by 77%
> >       =E2=80=A2 Average latency increased by 1.6 ms
>
> I would expect krb5p to be the worst in terms of
> latency. And I would like to see round-trip numbers
> reported: what part of the increase in latency is
> due to server versus client processing?
>
> This is also remarkable:
>
> > When nconnect is used in Linux, the GSS security context is shared betw=
een all the nconnect connections to a particular server. TCP is a reliable =
transport that supports out-of-order packet delivery to deal with out-of-or=
der packets in a GSS stream, using a sliding window of sequence numbers.=E2=
=80=AFWhen packets not in the sequence window are received, the security co=
ntext is discarded, and=E2=80=AFa new security context is negotiated. All m=
essages sent with in the now-discarded context are no longer valid, thus re=
quiring the messages to be sent again. Larger number of packets in an nconn=
ect setup cause frequent out-of-window packets, triggering the described be=
havior. No specific degradation percentages can be stated with this behavio=
r.
>
>
> So, does this mean that nconnect makes the GSS sequence
> window problem worse, or that when a window underrun
> occurs it has broader impact because multiple connections
> are affected?
>
> Seems like maybe nconnect should set up a unique GSS
> context for each xprt. It would be helpful to file a bug.
>
Here's a snippet from RFC2203:
   In a successful response, the seq_window field is set to the sequence
   window length supported by the server for this context.  This window
   specifies the maximum number of client requests that may be
   outstanding for this context. The server will accept "seq_window"
   requests at a time, and these may be out of order.  The client may
   use this number to determine the number of threads that can
   simultaneously send requests on this context.

It would be interesting to know what size of window Netapp filers specify
in the reply when context initialization completes.
A simple fix might be to get Netapp to increase the window, since they
have observed the problem.
FreeBSD servers use 128.  I have no idea what other servers use.

rick

>
> > and then in 'man 5 nfs'
> > sec=3Dkrb5  provides cryptographic proof of a user's identity in each R=
PC request.
>
> Kerberos has performance impacts due to the crypto-
> graphic operations that are performed on even small
> fixed-sized sections of each RPC message, when using
> sec=3Dkrb5 (no 'i' or 'p').
>
>
> > Is there a option of better performance to check krb5 only when mount.n=
fs4,
> > not when file acess?
>
> If you mount with NFSv4 and sec=3Dsys from a Linux NFS
> client that has a keytab, the client will attempt to
> use krb5i for lease management operations (such as
> EXCHANGE_ID) but it will continue to use sec=3Dsys for
> user authentication. That's not terribly secure.
>
> A better answer would be to make Kerberos faster.
> I've done some recent work on improving the overhead
> of using message digest algorithms with GSS-API, but
> haven't done any specific measurement. I'm sure
> there's more room for optimization.
>
> Even better would be to use a transport layer security
> service. Amazon has EFS and Oracle Cloud has something
> similar, but we're working on a standard approach that
> uses TLSv1.3.
>
>
> --
> Chuck Lever
>
>
>
